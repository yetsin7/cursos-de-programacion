// =============================================================================
// ARCHIVO: 02_buscador.js
// TEMA: Buscador de versículos con paginación y filtro por testamento
// =============================================================================
// DEPENDENCIA: npm install better-sqlite3

const Database = require('better-sqlite3');
const readline = require('readline');
const path = require('path');

const DB_PATH = path.join(__dirname, '..', '..', 'datos', 'biblia_rv60.sqlite3');
const db = new Database(DB_PATH, { readonly: true });

// Constantes para los rangos de testamento
const AT_MAX = 39; // Libros 1-39: Antiguo Testamento
const NT_MIN = 40; // Libros 40-66: Nuevo Testamento

/** Tamaño de página para la paginación de resultados */
const TAMANIO_PAGINA = 10;

/**
 * Elimina marcas Strong del texto bíblico.
 * @param {string} texto - Texto con posibles marcas <S>NNNN</S>
 * @returns {string} Texto limpio
 */
const limpiarMarcas = texto =>
  texto.replace(/<S>\d+<\/S>/g, '').replace(/\s{2,}/g, ' ').trim();

/**
 * Busca versículos que contengan la palabra clave dada.
 * Opcionalmente filtra por testamento (AT, NT, o ambos).
 * @param {string} palabra - Término de búsqueda (SQL LIKE)
 * @param {'AT'|'NT'|'TODO'} testamento - Filtro de testamento
 * @returns {Array} Lista de resultados con referencia y texto limpio
 */
function buscar(palabra, testamento = 'TODO') {
  let condicionTestamento = '';
  if (testamento === 'AT') condicionTestamento = `AND v.book_number <= ${AT_MAX}`;
  if (testamento === 'NT') condicionTestamento = `AND v.book_number >= ${NT_MIN}`;

  const filas = db
    .prepare(
      `SELECT v.book_number, v.chapter, v.verse, v.text, b.long_name, b.short_name
       FROM verses v
       JOIN books b ON v.book_number = b.book_number
       WHERE v.text LIKE ? ${condicionTestamento}
       ORDER BY v.book_number, v.chapter, v.verse`
    )
    .all(`%${palabra}%`);

  return filas.map(f => ({
    referencia: `${f.long_name} ${f.chapter}:${f.verse}`,
    texto: limpiarMarcas(f.text),
    libro: f.long_name,
    bookNum: f.book_number,
  }));
}

/**
 * Calcula estadísticas sobre un conjunto de resultados de búsqueda.
 * Devuelve el total de versículos y el número de libros distintos involucrados.
 * @param {Array} resultados - Lista de resultados de buscar()
 * @returns {object} { total, librosUnicos }
 */
function calcularEstadisticas(resultados) {
  const libros = new Set(resultados.map(r => r.libro));
  return {
    total: resultados.length,
    librosUnicos: libros.size,
  };
}

/**
 * Imprime una página de resultados en consola, con número de página.
 * @param {Array} resultados - Todos los resultados de la búsqueda
 * @param {number} pagina - Número de página actual (empezando en 0)
 */
function imprimirPagina(resultados, pagina) {
  const inicio = pagina * TAMANIO_PAGINA;
  const fin = Math.min(inicio + TAMANIO_PAGINA, resultados.length);
  const pagina_actual = resultados.slice(inicio, fin);

  console.log(`\n  — Resultados ${inicio + 1}-${fin} de ${resultados.length} —\n`);
  pagina_actual.forEach((r, i) => {
    console.log(`  ${String(inicio + i + 1).padStart(4)}. ${r.referencia}`);
    console.log(`        ${r.texto.substring(0, 100)}${r.texto.length > 100 ? '...' : ''}`);
  });
}

// ─── Interfaz de usuario ─────────────────────────────────────────────────────

const rl = readline.createInterface({ input: process.stdin, output: process.stdout });
const preguntar = msg => new Promise(res => rl.question(msg, res));

/**
 * Flujo principal del buscador: solicita término, testamento,
 * muestra estadísticas y permite paginar resultados.
 */
async function iniciarBuscador() {
  console.log('\n╔══════════════════════════════════╗');
  console.log('║   BIBLIA RV60 — Buscador         ║');
  console.log('╚══════════════════════════════════╝\n');

  let continuar = true;
  while (continuar) {
    const palabra = await preguntar('Buscar palabra (o "salir"): ');
    if (palabra.toLowerCase() === 'salir') break;
    if (!palabra.trim()) continue;

    console.log('  Testamento: 1=Todo  2=Solo AT  3=Solo NT');
    const opT = await preguntar('  Opción (1-3): ');
    const mapa = { '1': 'TODO', '2': 'AT', '3': 'NT' };
    const testamento = mapa[opT.trim()] || 'TODO';

    console.log('\n  Buscando...');
    const resultados = buscar(palabra.trim(), testamento);

    if (resultados.length === 0) {
      console.log(`\n  ✗ No se encontraron resultados para "${palabra}".`);
      continue;
    }

    const stats = calcularEstadisticas(resultados);
    console.log(`\n  ✓ ${stats.total} versículos en ${stats.librosUnicos} libro(s)`);

    let pagina = 0;
    const totalPaginas = Math.ceil(resultados.length / TAMANIO_PAGINA);

    imprimirPagina(resultados, pagina);

    while (pagina < totalPaginas - 1) {
      const mas = await preguntar('\n  [ENTER] ver más  |  [s] nueva búsqueda: ');
      if (mas.toLowerCase() === 's') break;
      pagina++;
      imprimirPagina(resultados, pagina);
    }

    if (pagina >= totalPaginas - 1) {
      console.log('\n  — Fin de los resultados —');
    }
  }

  rl.close();
  db.close();
  console.log('\nHasta luego.\n');
}

iniciarBuscador().catch(err => {
  console.error('Error:', err.message);
  db.close();
  process.exit(1);
});
