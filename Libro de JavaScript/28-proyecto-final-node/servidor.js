// ============================================================
// ARCHIVO: servidor.js
// TEMA: API REST completa — Express + SQLite
// CÓMO EJECUTAR: node servidor.js
// DEPENDENCIAS: npm install express better-sqlite3 cors
//
// ENDPOINTS DISPONIBLES:
//   GET    /api/notas          → Listar todas (con ?q=texto para buscar)
//   GET    /api/notas/:id      → Obtener una nota por ID
//   POST   /api/notas          → Crear nota {titulo, contenido?, etiqueta?}
//   PUT    /api/notas/:id      → Actualizar nota
//   DELETE /api/notas/:id      → Eliminar nota
// ============================================================

'use strict';

const express = require('express');
const Database = require('better-sqlite3');
const cors = require('cors');
const path = require('path');

// ─── CONFIGURACIÓN ────────────────────────────────────────────
const PUERTO = process.env.PORT || 3000;
const RUTA_DB = path.join(__dirname, 'notas.db');

// ─── BASE DE DATOS ────────────────────────────────────────────

/**
 * Inicializa la base de datos y crea la tabla si no existe.
 * @returns {Database} Instancia de la BD lista para usar
 */
function inicializarBD() {
  const db = new Database(RUTA_DB);
  db.pragma('journal_mode = WAL');
  db.pragma('foreign_keys = ON');

  // Crear tabla solo si no existe — idempotente
  db.exec(`
    CREATE TABLE IF NOT EXISTS notas (
      id           INTEGER PRIMARY KEY AUTOINCREMENT,
      titulo       TEXT    NOT NULL,
      contenido    TEXT    NOT NULL DEFAULT '',
      etiqueta     TEXT    NOT NULL DEFAULT 'general',
      creado_en    TEXT    NOT NULL DEFAULT (datetime('now', 'localtime')),
      actualizado  TEXT    NOT NULL DEFAULT (datetime('now', 'localtime'))
    )
  `);

  // Prepared statements — compilados una vez, reutilizados múltiples veces
  db.stmts = {
    obtenerTodas: db.prepare('SELECT * FROM notas ORDER BY creado_en DESC'),
    buscar: db.prepare(`SELECT * FROM notas
      WHERE titulo LIKE @termino OR contenido LIKE @termino OR etiqueta LIKE @termino
      ORDER BY creado_en DESC`),
    obtenerUna: db.prepare('SELECT * FROM notas WHERE id = @id'),
    insertar: db.prepare(`INSERT INTO notas (titulo, contenido, etiqueta)
      VALUES (@titulo, @contenido, @etiqueta)`),
    actualizar: db.prepare(`UPDATE notas
      SET titulo = @titulo, contenido = @contenido, etiqueta = @etiqueta,
          actualizado = datetime('now', 'localtime')
      WHERE id = @id`),
    eliminar: db.prepare('DELETE FROM notas WHERE id = @id'),
    contar: db.prepare('SELECT COUNT(*) as total FROM notas').pluck(),
  };

  return db;
}

const db = inicializarBD();

// ─── APP EXPRESS ──────────────────────────────────────────────
const app = express();

// ─── MIDDLEWARE GLOBALES ──────────────────────────────────────

// CORS: permite peticiones desde cualquier origen (frontend en otro puerto)
app.use(cors());

// Parsear body JSON en peticiones POST/PUT
app.use(express.json());

/**
 * Middleware de logging: registra método, ruta, código y tiempo de respuesta.
 */
app.use((req, res, next) => {
  const inicio = Date.now();
  const ts = new Date().toLocaleTimeString('es');

  res.on('finish', () => {
    const ms = Date.now() - inicio;
    const estado = res.statusCode;
    const color = estado >= 500 ? '\x1b[31m' : estado >= 400 ? '\x1b[33m' : '\x1b[32m';
    console.log(`${color}[${ts}] ${req.method} ${req.path} → ${estado} (${ms}ms)\x1b[0m`);
  });

  next();
});

// ─── HELPERS ─────────────────────────────────────────────────

/**
 * Valida los campos requeridos de una nota.
 * @param {{ titulo?: string }} body
 * @returns {{ valido: boolean, error?: string }}
 */
const validarNota = (body) => {
  if (!body || typeof body.titulo !== 'string' || !body.titulo.trim()) {
    return { valido: false, error: 'El campo "titulo" es obligatorio y no puede estar vacío' };
  }
  if (body.titulo.trim().length < 2) {
    return { valido: false, error: 'El título debe tener al menos 2 caracteres' };
  }
  return { valido: true };
};

// ─── RUTAS ────────────────────────────────────────────────────

/** GET / — documentación básica de la API */
app.get('/', (req, res) => {
  res.json({
    nombre: 'API de Notas — Proyecto Final Node.js',
    version: '1.0.0',
    totalNotas: db.stmts.contar.get(),
    endpoints: {
      'GET  /api/notas':        'Listar todas | filtrar: ?q=texto',
      'GET  /api/notas/:id':    'Obtener una nota',
      'POST /api/notas':        'Crear { titulo, contenido?, etiqueta? }',
      'PUT  /api/notas/:id':    'Actualizar { titulo?, contenido?, etiqueta? }',
      'DELETE /api/notas/:id':  'Eliminar',
    },
  });
});

/**
 * GET /api/notas — Devuelve todas las notas.
 * Si se pasa ?q=texto, filtra por título, contenido y etiqueta.
 */
app.get('/api/notas', (req, res) => {
  const { q } = req.query;
  const notas = q
    ? db.stmts.buscar.all({ termino: `%${q}%` })
    : db.stmts.obtenerTodas.all();

  res.json({ total: notas.length, notas });
});

/**
 * GET /api/notas/:id — Devuelve una nota por ID.
 * Responde 404 si no existe.
 */
app.get('/api/notas/:id', (req, res) => {
  const id = parseInt(req.params.id);
  if (isNaN(id)) return res.status(400).json({ error: 'El ID debe ser un número entero' });

  const nota = db.stmts.obtenerUna.get({ id });
  if (!nota) return res.status(404).json({ error: `Nota con id ${id} no encontrada` });

  res.json(nota);
});

/**
 * POST /api/notas — Crea una nota nueva.
 * Body: { titulo: string, contenido?: string, etiqueta?: string }
 */
app.post('/api/notas', (req, res) => {
  const { valido, error } = validarNota(req.body);
  if (!valido) return res.status(400).json({ error });

  const payload = {
    titulo: req.body.titulo.trim(),
    contenido: (req.body.contenido || '').trim(),
    etiqueta: (req.body.etiqueta || 'general').trim(),
  };

  const { lastInsertRowid } = db.stmts.insertar.run(payload);
  const nuevaNota = db.stmts.obtenerUna.get({ id: lastInsertRowid });

  res.status(201).json(nuevaNota);
});

/**
 * PUT /api/notas/:id — Actualiza una nota existente.
 * Solo actualiza los campos presentes en el body.
 */
app.put('/api/notas/:id', (req, res) => {
  const id = parseInt(req.params.id);
  if (isNaN(id)) return res.status(400).json({ error: 'El ID debe ser un número entero' });

  const nota = db.stmts.obtenerUna.get({ id });
  if (!nota) return res.status(404).json({ error: `Nota con id ${id} no encontrada` });

  // Merge: usar los valores del body si existen, o los actuales de la nota
  const payload = {
    id,
    titulo: (req.body.titulo ?? nota.titulo).trim(),
    contenido: (req.body.contenido ?? nota.contenido).trim(),
    etiqueta: (req.body.etiqueta ?? nota.etiqueta).trim(),
  };

  const { valido, error } = validarNota(payload);
  if (!valido) return res.status(400).json({ error });

  db.stmts.actualizar.run(payload);
  res.json(db.stmts.obtenerUna.get({ id }));
});

/**
 * DELETE /api/notas/:id — Elimina una nota.
 * Responde 404 si no existe.
 */
app.delete('/api/notas/:id', (req, res) => {
  const id = parseInt(req.params.id);
  if (isNaN(id)) return res.status(400).json({ error: 'El ID debe ser un número entero' });

  const nota = db.stmts.obtenerUna.get({ id });
  if (!nota) return res.status(404).json({ error: `Nota con id ${id} no encontrada` });

  db.stmts.eliminar.run({ id });
  res.json({ mensaje: 'Nota eliminada exitosamente', nota });
});

/** 404 global para rutas no definidas */
app.use((req, res) => {
  res.status(404).json({ error: 'Ruta no encontrada', ver: 'GET /' });
});

/**
 * Manejador global de errores — captura errores de next(err).
 * Siempre al final, con 4 parámetros.
 */
// eslint-disable-next-line no-unused-vars
app.use((err, req, res, next) => {
  console.error('\x1b[31mError no manejado:\x1b[0m', err.message);
  res.status(500).json({ error: 'Error interno del servidor' });
});

// ─── INICIAR SERVIDOR ─────────────────────────────────────────
const servidor = app.listen(PUERTO, () => {
  console.log('\n\x1b[32m✅ API de Notas corriendo\x1b[0m');
  console.log(`   URL:  http://localhost:${PUERTO}`);
  console.log(`   BD:   ${RUTA_DB}`);
  console.log(`   Notas en BD: ${db.stmts.contar.get()}`);
  console.log('\nPara probar: node cliente_test.js');
  console.log('Para detener: Ctrl+C\n');
});

// Cierre limpio del servidor y la BD al terminar el proceso
process.on('SIGINT', () => {
  console.log('\nCerrando servidor...');
  servidor.close(() => {
    db.close();
    console.log('Servidor y BD cerrados. ¡Hasta luego!');
    process.exit(0);
  });
});
