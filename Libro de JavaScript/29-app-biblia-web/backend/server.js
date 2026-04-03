/**
 * server.js
 * Punto de entrada del servidor Express para la API de la Biblia RV60.
 * Configura middlewares, rutas y manejo de errores global.
 */

import express from 'express';
import cors from 'cors';
import bibleRoutes from './routes/bible.js';

const app = express();
const PORT = process.env.PORT || 3001;

// ─── Middlewares globales ────────────────────────────────────────────────────

// Permite peticiones desde el frontend en localhost:5173
app.use(cors());

// Parsea cuerpos JSON en las peticiones entrantes
app.use(express.json());

// ─── Rutas ───────────────────────────────────────────────────────────────────

// Todas las rutas de la Biblia quedan bajo /api
app.use('/api', bibleRoutes);

// Ruta raíz: confirmación de que el servidor está activo
app.get('/', (_req, res) => {
  res.json({ message: 'API Biblia RV60 activa', version: '1.0.0' });
});

// ─── Manejo de errores global ────────────────────────────────────────────────

/**
 * Middleware de manejo de errores.
 * Captura cualquier error lanzado en las rutas y retorna un JSON con el mensaje.
 *
 * @param {Error} err - Error capturado
 * @param {import('express').Request} _req - Objeto de solicitud (no usado)
 * @param {import('express').Response} res - Objeto de respuesta
 * @param {import('express').NextFunction} _next - Siguiente middleware (requerido por Express)
 */
app.use((err, _req, res, _next) => {
  console.error('[Error global]', err.message);
  res.status(500).json({ error: 'Error interno del servidor', details: err.message });
});

// ─── Inicio del servidor ─────────────────────────────────────────────────────

app.listen(PORT, () => {
  console.log(`Servidor Biblia RV60 corriendo en http://localhost:${PORT}`);
});
