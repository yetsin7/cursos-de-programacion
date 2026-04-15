// =============================================================================
// ARCHIVO: 01_lector_basico.js
// TEMA: Lector interactivo de versículos bíblicos con menú en consola
// =============================================================================
// DEPENDENCIA: npm install better-sqlite3

const Database = require('better-sqlite3');
const readline = require('readline');
const path = require('path');

const DB_PATH = path.join(__dirname, '..', '..', 'datos', 'biblia_rv60.sqlite3');

// Abrir BD una sola vez al iniciar el script
const db = new Database(DB_PATH, { readonly: true });

/**
 * Elimina las marcas Strong <S>NNNN</S> del texto bíblico.
 * Ejemplo: "En el <S>7225</S>principio" → "En el principio"
 * @param {string} texto - Texto con posibles marcas Strong
 * @returns {string} Texto limpio sin marcas
 */
function limpiarMarcas(texto) {
  return texto.replace(/<S>\d+<\/S>/g, '').replace(/\s{2,}/g, ' ').trim();
}

/**
 * Obtiene un versículo específico por su referencia.
 * @param {number} libro - Número del libro (1-66)
 * @param {number} capitulo - Número del capítulo
 * @param {number} versiculo - Número del versículo
 * @returns {object|null} Objeto con text y referencia, o null si no existe
 */
function obtenerVersiculo(libro, capitulo, versiculo) {
  const fila = db
    .prepare(
      `SELECT v.text, b.long_name
       FROM verses v
       JOIN books b ON v.book_number = b.book_number
       WHERE v.book_number = ? AND v.chapter = ? AND v.verse = ?`
    )
    .get(libro, capitulo, versiculo);

  if (!fila) return null;

  return {
    referencia: `${fila.long_name} ${capitulo}:${versiculo}`,
    texto: limpiarMarcas(fila.text),
  };
}

/**
 * Obtiene todos los versículos de un capítulo completo.
 * @param {number} libro - Número del libro
 * @param {number} capitulo - Número del capítulo
 * @returns {Array} Lista de versículos con su número y texto limpio
 */
function obtenerCapitulo(libro, capitulo) {
  const filas = db
    .prepare(
      `SELECT v.verse, v.text, b.long_name
       FROM verses v
       JOIN books b ON v.book_number = b.book_number
       WHERE v.book_number = ? AND v.chapter = ?
       ORDER BY v.verse`
    )
    .all(libro, capitulo);

  return filas.map(f => ({
    numero: f.verse,
    texto: limpiarMarcas(f.text),
    libro: f.long_name,
  }));
}

/**
 * Obtiene un versículo completamente aleatorio de toda la Biblia.
 * Usa Math.random() para seleccionar un índice al azar.
 * @returns {object} Objeto con referencia y texto del versículo aleatorio
 */
function versiculoAleatorio() {
  const total = db.prepare('SELECT COUNT(*) AS total FROM verses').get().total;
  // ROWID en SQLite empieza en 1, no en 0
  const rowid = Math.floor(Math.random() * total) + 1;

  const fila = db
    .prepare(
      `SELECT v.book_number, v.chapter, v.verse, v.text, b.long_name
       FROM verses v
       JOIN books b ON v.book_number = b.book_number
       WHERE v.rowid = ?`
    )
    .get(rowid);

  return {
    referencia: `${fila.long_name} ${fila.chapter}:${fila.verse}`,
    texto: limpiarMarcas(fila.text),
  };
}

// ─── Interfaz readline para menú interactivo ─────────────────────────────────

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

/** Pregunta al usuario y devuelve su respuesta como promesa. */
const preguntar = msg => new Promise(res => rl.question(msg, res));

/**
 * Muestra el menú principal y gestiona la navegación.
 * El menú se repite hasta que el usuario elige salir.
 */
async function menuPrincipal() {
  console.log('\n╔══════════════════════════════════╗');
  console.log('║   BIBLIA RV60 — Lector Básico    ║');
  console.log('╚══════════════════════════════════╝');

  let continuar = true;
  while (continuar) {
    console.log('\n  1. Ir a un versículo');
    console.log('  2. Leer un capítulo completo');
    console.log('  3. Versículo aleatorio');
    console.log('  0. Salir\n');

    const opcion = await preguntar('Elige una opción: ');

    switch (opcion.trim()) {
      case '1': {
        const libro = parseInt(await preguntar('Número de libro (1-66): '), 10);
        const cap = parseInt(await preguntar('Capítulo: '), 10);
        const ver = parseInt(await preguntar('Versículo: '), 10);
        const resultado = obtenerVersiculo(libro, cap, ver);
        if (resultado) {
          console.log(`\n  ${resultado.referencia}`);
          console.log(`  "${resultado.texto}"\n`);
        } else {
          console.log('\n  ✗ Versículo no encontrado.\n');
        }
        break;
      }
      case '2': {
        const libro = parseInt(await preguntar('Número de libro (1-66): '), 10);
        const cap = parseInt(await preguntar('Capítulo: '), 10);
        const versiculos = obtenerCapitulo(libro, cap);
        if (versiculos.length === 0) {
          console.log('\n  ✗ Capítulo no encontrado.\n');
        } else {
          console.log(`\n  ${versiculos[0].libro} — Capítulo ${cap}\n`);
          versiculos.forEach(v =>
            console.log(`  ${String(v.numero).padStart(3)}. ${v.texto}`)
          );
        }
        break;
      }
      case '3': {
        const aleatorio = versiculoAleatorio();
        console.log(`\n  ${aleatorio.referencia}`);
        console.log(`  "${aleatorio.texto}"\n`);
        break;
      }
      case '0':
        continuar = false;
        break;
      default:
        console.log('\n  Opción no válida.\n');
    }
  }

  rl.close();
  db.close();
  console.log('\nHasta luego.\n');
}

menuPrincipal().catch(err => {
  console.error('Error:', err.message);
  db.close();
  process.exit(1);
});
