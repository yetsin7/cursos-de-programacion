// ============================================================
// ARCHIVO: 01_servidor_basico.js
// TEMA: Servidor HTTP básico con Express
// CÓMO EJECUTAR: node 01_servidor_basico.js
// DEPENDENCIA: npm install express
// ============================================================

// Importar Express usando CommonJS (compatible con Node sin configuración extra)
const express = require('express');

// ─── CREAR LA APLICACIÓN ──────────────────────────────────────
// express() devuelve una instancia de la aplicación Express.
// Toda la configuración y rutas se registran sobre este objeto.
const app = express();

// ─── MIDDLEWARE GLOBAL ────────────────────────────────────────
// Permite que Express lea el body en formato JSON automáticamente.
// Sin esto, req.body sería undefined en peticiones POST/PUT.
app.use(express.json());

// ─── RUTAS ────────────────────────────────────────────────────

/**
 * GET / — Ruta raíz.
 * req: objeto con información de la petición (headers, params, body, etc.)
 * res: objeto para enviar la respuesta al cliente.
 */
app.get('/', (req, res) => {
  // res.send() envía texto plano (o HTML) y cierra la conexión
  res.send('¡Hola desde Express! 🚀');
});

/**
 * GET /saludo — Responde con HTML.
 * Express infiere el Content-Type automáticamente.
 */
app.get('/saludo', (req, res) => {
  res.send('<h1>Bienvenido a mi servidor Express</h1><p>Módulo 16</p>');
});

/**
 * GET /api/info — Responde con JSON.
 * res.json() serializa el objeto y establece Content-Type: application/json.
 */
app.get('/api/info', (req, res) => {
  res.json({
    nombre: 'API de Ejemplo',
    version: '1.0.0',
    descripcion: 'Servidor básico con Express',
    endpoints: ['/', '/saludo', '/api/info', '/api/eco'],
  });
});

/**
 * GET /api/eco — Devuelve los headers y query params de la petición.
 * Útil para inspeccionar qué recibe el servidor.
 */
app.get('/api/eco', (req, res) => {
  res.json({
    metodo: req.method,
    ruta: req.path,
    queryParams: req.query,
    headers: {
      'user-agent': req.headers['user-agent'],
      accept: req.headers['accept'],
    },
  });
});

/**
 * POST /api/eco — Devuelve el body recibido tal cual.
 * Probar con: curl -X POST http://localhost:3000/api/eco \
 *             -H "Content-Type: application/json" \
 *             -d '{"mensaje":"hola"}'
 */
app.post('/api/eco', (req, res) => {
  res.json({
    recibido: req.body,
    mensaje: 'Body recibido correctamente',
  });
});

/**
 * GET /api/error — Ejemplo de respuesta con código de estado específico.
 * res.status(código).json(datos) — encadenamiento de métodos.
 */
app.get('/api/error', (req, res) => {
  res.status(503).json({
    error: 'Servicio temporalmente no disponible',
    codigo: 503,
  });
});

/**
 * Ruta 404 — Captura cualquier ruta no definida.
 * SIEMPRE debe ir al FINAL, después de todas las rutas.
 */
app.use((req, res) => {
  res.status(404).json({
    error: 'Ruta no encontrada',
    ruta: req.path,
    sugerencia: 'Las rutas disponibles están en GET /api/info',
  });
});

// ─── INICIAR EL SERVIDOR ──────────────────────────────────────
// process.env.PORT: variable de entorno para entornos de producción (Heroku, Railway, etc.)
const PUERTO = process.env.PORT || 3000;

app.listen(PUERTO, () => {
  console.log(`\n✅ Servidor corriendo en http://localhost:${PUERTO}`);
  console.log('\nRutas disponibles:');
  console.log(`  GET  http://localhost:${PUERTO}/`);
  console.log(`  GET  http://localhost:${PUERTO}/saludo`);
  console.log(`  GET  http://localhost:${PUERTO}/api/info`);
  console.log(`  GET  http://localhost:${PUERTO}/api/eco`);
  console.log(`  POST http://localhost:${PUERTO}/api/eco`);
  console.log(`  GET  http://localhost:${PUERTO}/api/error`);
  console.log('\nPrueba con el navegador o con:');
  console.log(`  curl http://localhost:${PUERTO}/api/info`);
  console.log('\nPresiona Ctrl+C para detener el servidor.');
});
