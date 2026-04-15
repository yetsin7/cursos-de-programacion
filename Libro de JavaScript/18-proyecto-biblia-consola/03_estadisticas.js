// =============================================================================
// ARCHIVO: 03_estadisticas.js
// TEMA: Estadísticas de la Biblia RV60: versículos, comparativa AT/NT, palabras
// =============================================================================
// DEPENDENCIA: npm install better-sqlite3

const Database = require('better-sqlite3');
const readline = require('readline');
const path = require('path');

const DB_PATH = path.join(__dirname, '..', '..', 'datos', 'biblia_rv60.sqlite3');
const db = new Database(DB_PATH, { readonly: true });

/** Palabras vacías en español que no aportan significado estadístico */
const STOP_WORDS = new Set([
  'de', 'la', 'que', 'el', 'en', 'y', 'a', 'los', 'del', 'se', 'las',
  'un', 'por', 'con', 'no', 'una', 'su', 'al', 'lo', 'como', 'más',
  'pero', 'sus', 'le', 'ya', 'o', 'este', 'me', 'si', 'porque', 'esta',
  'entre', 'cuando', 'muy', 'sin', 'sobre', 'también', 'mi', 'te', 'tu',
]);

/**
 * Elimina marcas Strong del texto bíblico.
 * @param {string} texto - Texto crudo de la BD
 * @returns {string} Texto limpio
 */
const limpiarMarcas = texto =>
  texto.replace(/<S>\d+<\/S>/g, '').replace(/\s{2,}/g, ' ').trim();

/**
 * Muestra una tabla formateada con el conteo de versículos por libro.
 * Usa padStart para alinear columnas en consola.
 */
function versiculosPorLibro() {
  console.log('\n=== VERSÍCULOS POR LIBRO ===\n');
  const filas = db
    .prepare(
      `SELECT b.long_name, b.book_number, COUNT(*) AS total
       FROM verses v JOIN books b ON v.book_number = b.book_number
       GROUP BY v.book_number ORDER BY v.book_number`
    )
    .all();

  filas.forEach(f => {
    const barra = '█'.repeat(Math.round(f.total / 15));
    console.log(
      `  ${String(f.book_number).padStart(2)}. ${f.long_name.padEnd(20)} ` +
      `${String(f.total).padStart(4)} ${barra}`
    );
  });
}

/**
 * Muestra la comparativa de versículos entre el AT y el NT.
 */
function comparativaTestamentos() {
  console.log('\n=== AT vs NT ===\n');

  const at = db
    .prepare('SELECT COUNT(*) AS total FROM verses WHERE book_number <= 39')
    .get();
  const nt = db
    .prepare('SELECT COUNT(*) AS total FROM verses WHERE book_number >= 40')
    .get();
  const total = at.total + nt.total;

  const pctAT = ((at.total / total) * 100).toFixed(1);
  const pctNT = ((nt.total / total) * 100).toFixed(1);

  console.log(`  Antiguo Testamento: ${at.total} versículos (${pctAT}%)`);
  console.log(`  Nuevo Testamento:   ${nt.total} versículos (${pctNT}%)`);
  console.log(`  Total:              ${total} versículos`);
}

/**
 * Calcula y muestra el top 20 de palabras más frecuentes en toda la Biblia.
 * Excluye palabras vacías (stop words) para mostrar términos significativos.
 */
function top20Palabras() {
  console.log('\n=== TOP 20 PALABRAS MÁS FRECUENTES ===\n');

  // Traer todos los textos de una vez para procesar en JS
  const textos = db.prepare('SELECT text FROM verses').all();
  const frecuencia = {};

  textos.forEach(({ text }) => {
    const palabras = limpiarMarcas(text)
      .toLowerCase()
      .replace(/[^a-záéíóúüñ\s]/gi, ' ')
      .split(/\s+/);

    palabras.forEach(p => {
      if (p.length > 2 && !STOP_WORDS.has(p)) {
        frecuencia[p] = (frecuencia[p] || 0) + 1;
      }
    });
  });

  const top20 = Object.entries(frecuencia)
    .sort((a, b) => b[1] - a[1])
    .slice(0, 20);

  top20.forEach(([palabra, count], i) => {
    console.log(`  ${String(i + 1).padStart(2)}. ${palabra.padEnd(15)} ${count}`);
  });
}

/**
 * Busca una palabra en toda la Biblia y muestra cuántos versículos
 * la contienen en cada libro, ordenado de mayor a menor.
 * @param {string} palabra - Término a buscar
 */
function distribucionPorLibro(palabra) {
  console.log(`\n=== DISTRIBUCIÓN DE "${palabra}" POR LIBRO ===\n`);

  const filas = db
    .prepare(
      `SELECT b.long_name, COUNT(*) AS apariciones
       FROM verses v JOIN books b ON v.book_number = b.book_number
       WHERE v.text LIKE ?
       GROUP BY v.book_number
       ORDER BY apariciones DESC`
    )
    .all(`%${palabra}%`);

  if (filas.length === 0) {
    console.log(`  No se encontró "${palabra}" en ningún libro.`);
    return;
  }

  filas.forEach(f =>
    console.log(`  ${f.long_name.padEnd(22)} ${String(f.apariciones).padStart(4)} versículo(s)`)
  );

  const totalVers = filas.reduce((acc, f) => acc + f.apariciones, 0);
  console.log(`\n  Total: ${totalVers} versículo(s) en ${filas.length} libro(s)`);
}

// ─── Interfaz de usuario ─────────────────────────────────────────────────────

const rl = readline.createInterface({ input: process.stdin, output: process.stdout });
const preguntar = msg => new Promise(res => rl.question(msg, res));

async function menuEstadisticas() {
  console.log('\n╔══════════════════════════════════╗');
  console.log('║   BIBLIA RV60 — Estadísticas     ║');
  console.log('╚══════════════════════════════════╝');

  let continuar = true;
  while (continuar) {
    console.log('\n  1. Versículos por libro');
    console.log('  2. Comparativa AT vs NT');
    console.log('  3. Top 20 palabras más frecuentes');
    console.log('  4. Distribución de una palabra por libro');
    console.log('  0. Salir\n');

    const op = await preguntar('Elige una opción: ');
    switch (op.trim()) {
      case '1': versiculosPorLibro(); break;
      case '2': comparativaTestamentos(); break;
      case '3': top20Palabras(); break;
      case '4': {
        const palabra = await preguntar('Palabra a buscar: ');
        if (palabra.trim()) distribucionPorLibro(palabra.trim());
        break;
      }
      case '0': continuar = false; break;
      default: console.log('\n  Opción no válida.');
    }
  }

  rl.close();
  db.close();
  console.log('\nHasta luego.\n');
}

menuEstadisticas().catch(err => {
  console.error('Error:', err.message);
  db.close();
  process.exit(1);
});
