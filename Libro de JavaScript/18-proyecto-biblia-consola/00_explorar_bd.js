// =============================================================================
// ARCHIVO: 00_explorar_bd.js
// TEMA: Exploración de la base de datos SQLite de la Biblia RV60
// =============================================================================
// DEPENDENCIA: npm install better-sqlite3

// Importar el módulo de base de datos SQLite (sincrónico)
const Database = require('better-sqlite3');
const path = require('path');

// Ruta a la base de datos relativa a este archivo
const DB_PATH = path.join(__dirname, '..', '..', 'datos', 'biblia_rv60.sqlite3');

/**
 * Abre la conexión a la base de datos SQLite.
 * Lanza un error si el archivo no existe o no es accesible.
 * @returns {Database} Instancia de la base de datos
 */
function abrirBD() {
  return new Database(DB_PATH, { readonly: true });
}

/**
 * Muestra todas las tablas disponibles en la base de datos.
 * @param {Database} db - Instancia de la base de datos
 */
function mostrarTablas(db) {
  console.log('\n=== TABLAS EN LA BASE DE DATOS ===');
  const tablas = db
    .prepare("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name")
    .all();

  tablas.forEach(t => console.log(`  • ${t.name}`));
}

/**
 * Muestra los conteos totales de libros y versículos.
 * @param {Database} db - Instancia de la base de datos
 */
function mostrarConteos(db) {
  console.log('\n=== CONTEOS GENERALES ===');

  const totalLibros = db.prepare('SELECT COUNT(*) AS total FROM books').get();
  const totalVersiculos = db.prepare('SELECT COUNT(*) AS total FROM verses').get();

  console.log(`  Libros:     ${totalLibros.total}`);
  console.log(`  Versículos: ${totalVersiculos.total}`);
}

/**
 * Muestra los primeros 5 libros del Antiguo Testamento (book_number 1-39).
 * @param {Database} db - Instancia de la base de datos
 */
function mostrarPrimerosDel_AT(db) {
  console.log('\n=== PRIMEROS 5 LIBROS DEL AT ===');
  const libros = db
    .prepare(
      'SELECT book_number, short_name, long_name FROM books WHERE book_number <= 39 ORDER BY book_number LIMIT 5'
    )
    .all();

  libros.forEach(l =>
    console.log(`  [${String(l.book_number).padStart(2, '0')}] ${l.short_name.padEnd(5)} → ${l.long_name}`)
  );
}

/**
 * Muestra los últimos 5 libros del Nuevo Testamento (book_number 40-66).
 * @param {Database} db - Instancia de la base de datos
 */
function mostrarUltimosDelNT(db) {
  console.log('\n=== ÚLTIMOS 5 LIBROS DEL NT ===');
  const libros = db
    .prepare(
      'SELECT book_number, short_name, long_name FROM books WHERE book_number >= 40 ORDER BY book_number DESC LIMIT 5'
    )
    .all();

  // Invertir para mostrar en orden ascendente
  libros.reverse().forEach(l =>
    console.log(`  [${String(l.book_number).padStart(2, '0')}] ${l.short_name.padEnd(5)} → ${l.long_name}`)
  );
}

/**
 * Muestra la estructura de columnas de cada tabla.
 * @param {Database} db - Instancia de la base de datos
 */
function mostrarEstructura(db) {
  console.log('\n=== ESTRUCTURA DE TABLAS ===');
  const tablas = ['books', 'verses'];

  tablas.forEach(tabla => {
    console.log(`\n  Tabla: ${tabla}`);
    const columnas = db.prepare(`PRAGMA table_info(${tabla})`).all();
    columnas.forEach(c =>
      console.log(`    - ${c.name.padEnd(15)} ${c.type}`)
    );
  });
}

// ─── Punto de entrada principal ──────────────────────────────────────────────
let db;
try {
  db = abrirBD();
  console.log(`✓ Base de datos abierta: ${DB_PATH}`);

  mostrarTablas(db);
  mostrarConteos(db);
  mostrarPrimerosDel_AT(db);
  mostrarUltimosDelNT(db);
  mostrarEstructura(db);

  console.log('\n✓ Exploración completada.\n');
} catch (err) {
  console.error('\n✗ Error al abrir la base de datos:', err.message);
  console.error('  Verifica que el archivo exista en:', DB_PATH);
  process.exit(1);
} finally {
  // Cerrar siempre la conexión, sin importar si hubo error
  if (db) db.close();
}
