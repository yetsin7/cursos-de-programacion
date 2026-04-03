// ============================================================
// ARCHIVO: 01_sqlite_node.js
// TEMA: better-sqlite3 — SQLite desde Node.js con API síncrona
// CÓMO EJECUTAR: node 01_sqlite_node.js
// DEPENDENCIA: npm install better-sqlite3
// ============================================================

'use strict';

// better-sqlite3 es la librería más popular para SQLite en Node.js.
// A diferencia de sqlite3 (async), esta es SÍNCRONA — más simple de usar.
const Database = require('better-sqlite3');

// ─── ABRIR / CREAR LA BASE DE DATOS ──────────────────────────
// Si el archivo no existe, se crea automáticamente.
// En producción usar una ruta absoluta o configurable.
const db = new Database('./demo.db', {
  // verbose: console.log, // Descomentar para ver todas las queries SQL ejecutadas
});

console.log('Base de datos abierta: demo.db');

// ─── PRAGMA — configuración de SQLite ────────────────────────
// WAL (Write-Ahead Logging) mejora el rendimiento en lecturas concurrentes
db.pragma('journal_mode = WAL');
// foreign_keys: habilitar integridad referencial (desactivado por defecto en SQLite)
db.pragma('foreign_keys = ON');

// ─── CREAR TABLA ──────────────────────────────────────────────
// IF NOT EXISTS evita error si la tabla ya fue creada antes
db.exec(`
  CREATE TABLE IF NOT EXISTS productos (
    id       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre   TEXT    NOT NULL,
    precio   REAL    NOT NULL CHECK(precio >= 0),
    stock    INTEGER NOT NULL DEFAULT 0,
    creado   TEXT    NOT NULL DEFAULT (datetime('now'))
  )
`);

console.log('Tabla "productos" verificada.');

// ─── INSERTAR — stmt.run() ────────────────────────────────────
// prepare() compila la query una vez — más eficiente para queries repetidas
// Los ? son placeholders posicionales (previenen SQL injection)
const insertarProducto = db.prepare(
  'INSERT INTO productos (nombre, precio, stock) VALUES (?, ?, ?)'
);

// run() ejecuta la query y retorna { changes, lastInsertRowid }
const resultado1 = insertarProducto.run('Teclado mecánico', 89.99, 15);
const resultado2 = insertarProducto.run('Mouse gaming', 45.50, 30);
const resultado3 = insertarProducto.run('Monitor 27"', 349.99, 8);

console.log('\nProductos insertados:');
console.log('  ID del primero:', resultado1.lastInsertRowid);
console.log('  ID del tercero:', resultado3.lastInsertRowid);
console.log('  Filas afectadas:', resultado1.changes);

// ─── PARÁMETROS NOMBRADOS ─────────────────────────────────────
// En lugar de ? se usa @nombre — más legible para queries complejas
const insertarConNombres = db.prepare(
  'INSERT INTO productos (nombre, precio, stock) VALUES (@nombre, @precio, @stock)'
);

insertarConNombres.run({ nombre: 'Auriculares USB', precio: 65.00, stock: 20 });
console.log('Producto con parámetros nombrados insertado.');

// ─── CONSULTAR — .all(), .get(), .pluck() ────────────────────

// .all() retorna un array con TODOS los registros que coinciden
const todosLosProductos = db.prepare('SELECT * FROM productos').all();
console.log('\nTodos los productos:');
todosLosProductos.forEach((p) => {
  console.log(`  [${p.id}] ${p.nombre} — $${p.precio} (stock: ${p.stock})`);
});

// .get() retorna UNO solo (el primero que coincida) o undefined si no existe
const unProducto = db.prepare('SELECT * FROM productos WHERE id = ?').get(2);
console.log('\nProducto con id=2:', unProducto);

// Buscar por texto con LIKE
const busqueda = db.prepare("SELECT * FROM productos WHERE nombre LIKE ?").all('%Mouse%');
console.log('\nBúsqueda "Mouse":', busqueda.map((p) => p.nombre));

// .pluck() retorna solo la primera columna como valor escalar
const totalStock = db.prepare('SELECT SUM(stock) FROM productos').pluck().get();
console.log('\nStock total:', totalStock);

// ─── ACTUALIZAR ───────────────────────────────────────────────
const actualizar = db.prepare('UPDATE productos SET precio = ?, stock = ? WHERE id = ?');
const cambios = actualizar.run(99.99, 12, 1); // Actualizar teclado
console.log('\nProducto actualizado. Filas modificadas:', cambios.changes);

// ─── ELIMINAR ─────────────────────────────────────────────────
const eliminar = db.prepare('DELETE FROM productos WHERE id = ?');
eliminar.run(4); // Eliminar auriculares
console.log('Producto id=4 eliminado.');

// ─── TRANSACCIONES ────────────────────────────────────────────
// Una transacción garantiza que todas las operaciones se completan,
// o ninguna lo hace (atomicidad). Ideal para operaciones relacionadas.

/**
 * Transacción: transferir stock de un producto a otro.
 * Si cualquier operación falla, todo se revierte automáticamente.
 */
const transferirStock = db.transaction((desdeId, haciaId, cantidad) => {
  const restar = db.prepare('UPDATE productos SET stock = stock - ? WHERE id = ? AND stock >= ?');
  const sumar = db.prepare('UPDATE productos SET stock = stock + ? WHERE id = ?');

  const resultado = restar.run(cantidad, desdeId, cantidad);
  if (resultado.changes === 0) {
    throw new Error(`Stock insuficiente en producto id=${desdeId}`);
  }
  sumar.run(cantidad, haciaId);
  return { transferido: cantidad };
});

try {
  const res = transferirStock(1, 2, 5);
  console.log('\nTransacción exitosa:', res);
} catch (e) {
  console.error('\nTransacción fallida:', e.message);
}

// ─── VERIFICAR ESTADO FINAL ───────────────────────────────────
console.log('\nEstado final de la base de datos:');
db.prepare('SELECT id, nombre, precio, stock FROM productos').all().forEach((p) => {
  console.log(`  [${p.id}] ${p.nombre} — $${p.precio} | stock: ${p.stock}`);
});

// ─── CERRAR LA CONEXIÓN ───────────────────────────────────────
// Siempre cerrar la BD al finalizar para liberar el archivo
db.close();
console.log('\nConexión cerrada.');

// Limpiar el archivo de demo para que el script sea idempotente
const fs = require('fs');
if (fs.existsSync('./demo.db')) fs.unlinkSync('./demo.db');
if (fs.existsSync('./demo.db-wal')) fs.unlinkSync('./demo.db-wal');
if (fs.existsSync('./demo.db-shm')) fs.unlinkSync('./demo.db-shm');
console.log('Archivo demo.db eliminado (script de demostración).');
