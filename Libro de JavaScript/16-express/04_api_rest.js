// ============================================================
// ARCHIVO: 04_api_rest.js
// TEMA: API REST completa con CRUD en memoria
// CÓMO EJECUTAR: node 04_api_rest.js
// DEPENDENCIA: npm install express
// ============================================================

const express = require('express');
const app = express();

app.use(express.json());

// ─── BASE DE DATOS EN MEMORIA ─────────────────────────────────
// En producción esto sería SQLite, PostgreSQL u otra BD.
// Usamos un array para enfocarnos en la estructura de la API.

/** Contador para generar IDs únicos y crecientes */
let proximoId = 4;

/** @type {Array<{id:number, titulo:string, contenido:string, creadoEn:string}>} */
const notas = [
  { id: 1, titulo: 'Primera nota', contenido: 'Contenido de ejemplo', creadoEn: '2024-01-01T10:00:00Z' },
  { id: 2, titulo: 'Apuntes de Express', contenido: 'Express es un framework minimalista', creadoEn: '2024-01-02T11:00:00Z' },
  { id: 3, titulo: 'Ideas de proyecto', contenido: 'API REST con SQLite y autenticación', creadoEn: '2024-01-03T12:00:00Z' },
];

// ─── HELPERS ──────────────────────────────────────────────────

/**
 * Busca una nota por su ID numérico.
 * @param {number} id
 * @returns {object|undefined}
 */
const encontrarNota = (id) => notas.find((n) => n.id === id);

/**
 * Valida que los datos de una nota sean correctos.
 * @param {object} datos
 * @returns {{ valido: boolean, error?: string }}
 */
const validarNota = (datos) => {
  if (!datos.titulo || typeof datos.titulo !== 'string') {
    return { valido: false, error: 'El campo titulo es obligatorio y debe ser string' };
  }
  if (datos.titulo.trim().length < 3) {
    return { valido: false, error: 'El titulo debe tener al menos 3 caracteres' };
  }
  return { valido: true };
};

// ─── RUTAS ─────────────────────────────────────────────────────

/**
 * GET /api/notas — Devuelve todas las notas.
 * Soporta búsqueda: GET /api/notas?q=texto
 */
app.get('/api/notas', (req, res) => {
  const { q } = req.query;

  if (q) {
    const termino = q.toLowerCase();
    const encontradas = notas.filter(
      (n) =>
        n.titulo.toLowerCase().includes(termino) ||
        n.contenido.toLowerCase().includes(termino)
    );
    return res.json({ total: encontradas.length, notas: encontradas });
  }

  res.json({ total: notas.length, notas });
});

/**
 * GET /api/notas/:id — Devuelve una nota por ID.
 * Retorna 404 si no existe.
 */
app.get('/api/notas/:id', (req, res) => {
  const id = parseInt(req.params.id);

  if (isNaN(id)) {
    return res.status(400).json({ error: 'El ID debe ser un número entero' });
  }

  const nota = encontrarNota(id);

  if (!nota) {
    return res.status(404).json({ error: `Nota con id ${id} no encontrada` });
  }

  res.json(nota);
});

/**
 * POST /api/notas — Crea una nueva nota.
 * Body: { titulo: string, contenido?: string }
 * Retorna 201 con la nota creada.
 * Retorna 400 si los datos son inválidos.
 */
app.post('/api/notas', (req, res) => {
  const { valido, error } = validarNota(req.body);

  if (!valido) {
    return res.status(400).json({ error });
  }

  const nuevaNota = {
    id: proximoId++,
    titulo: req.body.titulo.trim(),
    contenido: (req.body.contenido || '').trim(),
    creadoEn: new Date().toISOString(),
  };

  notas.push(nuevaNota);

  // 201 Created es el código correcto para recursos creados exitosamente
  res.status(201).json(nuevaNota);
});

/**
 * PUT /api/notas/:id — Actualiza una nota completa.
 * Reemplaza todos los campos editables con los valores del body.
 * Retorna 404 si no existe, 400 si los datos son inválidos.
 */
app.put('/api/notas/:id', (req, res) => {
  const id = parseInt(req.params.id);

  if (isNaN(id)) {
    return res.status(400).json({ error: 'El ID debe ser un número entero' });
  }

  const indice = notas.findIndex((n) => n.id === id);

  if (indice === -1) {
    return res.status(404).json({ error: `Nota con id ${id} no encontrada` });
  }

  const { valido, error } = validarNota(req.body);
  if (!valido) {
    return res.status(400).json({ error });
  }

  // Actualizar manteniendo el id y creadoEn originales
  notas[indice] = {
    ...notas[indice],
    titulo: req.body.titulo.trim(),
    contenido: (req.body.contenido || '').trim(),
    actualizadoEn: new Date().toISOString(),
  };

  res.json(notas[indice]);
});

/**
 * DELETE /api/notas/:id — Elimina una nota.
 * Retorna 404 si no existe.
 * Retorna 200 con mensaje de confirmación.
 */
app.delete('/api/notas/:id', (req, res) => {
  const id = parseInt(req.params.id);

  if (isNaN(id)) {
    return res.status(400).json({ error: 'El ID debe ser un número entero' });
  }

  const indice = notas.findIndex((n) => n.id === id);

  if (indice === -1) {
    return res.status(404).json({ error: `Nota con id ${id} no encontrada` });
  }

  const eliminada = notas.splice(indice, 1)[0];

  res.json({ mensaje: 'Nota eliminada exitosamente', nota: eliminada });
});

/** Ruta raíz con documentación de la API */
app.get('/', (req, res) => {
  res.json({
    nombre: 'API de Notas',
    version: '1.0.0',
    endpoints: {
      'GET    /api/notas': 'Listar todas. Filtrar: ?q=texto',
      'GET    /api/notas/:id': 'Obtener una por ID',
      'POST   /api/notas': 'Crear (body: {titulo, contenido?})',
      'PUT    /api/notas/:id': 'Actualizar (body: {titulo, contenido?})',
      'DELETE /api/notas/:id': 'Eliminar',
    },
  });
});

/** 404 global para rutas no definidas */
app.use((req, res) => {
  res.status(404).json({ error: 'Ruta no encontrada', sugerencia: 'Ver GET /' });
});

/** Manejador global de errores */
// eslint-disable-next-line no-unused-vars
app.use((err, req, res, next) => {
  console.error('Error no manejado:', err.message);
  res.status(500).json({ error: 'Error interno del servidor' });
});

// ─── INICIAR SERVIDOR ─────────────────────────────────────────
const PUERTO = process.env.PORT || 3000;
app.listen(PUERTO, () => {
  console.log(`\n✅ API REST de Notas en http://localhost:${PUERTO}`);
  console.log('\nComandos de prueba (curl):');
  console.log(`  curl http://localhost:${PUERTO}/api/notas`);
  console.log(`  curl http://localhost:${PUERTO}/api/notas/1`);
  console.log(`  curl "http://localhost:${PUERTO}/api/notas?q=express"`);
  console.log(`  curl -X POST http://localhost:${PUERTO}/api/notas -H "Content-Type: application/json" -d '{"titulo":"Mi nota","contenido":"Hola"}'`);
  console.log(`  curl -X PUT http://localhost:${PUERTO}/api/notas/1 -H "Content-Type: application/json" -d '{"titulo":"Actualizada"}'`);
  console.log(`  curl -X DELETE http://localhost:${PUERTO}/api/notas/1`);
});
