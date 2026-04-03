// ============================================================
// ARCHIVO: 03_middleware.js
// TEMA: Middleware en Express — logging, errores y CORS
// CÓMO EJECUTAR: node 03_middleware.js
// DEPENDENCIA: npm install express cors
// ============================================================

const express = require('express');

// cors permite que un frontend en otro dominio/puerto acceda a esta API
// Instalar con: npm install cors
let cors;
try {
  cors = require('cors');
} catch {
  // Si cors no está instalado, usamos un middleware manual básico
  cors = () => (req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE,OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization');
    if (req.method === 'OPTIONS') return res.sendStatus(204);
    next();
  };
  console.log('⚠️  cors no instalado — usando fallback manual. Ejecuta: npm install cors');
}

const app = express();

// ─── QUÉ ES UN MIDDLEWARE ────────────────────────────────────
// Un middleware es una función con la firma: (req, res, next) => {}
// - Puede leer y modificar req y res
// - Debe llamar next() para pasar al siguiente middleware/ruta
// - Si no llama next(), la petición queda colgada
// El ORDEN de registro importa: se ejecuta de arriba hacia abajo.

// ─── 1. MIDDLEWARE GLOBAL — CORS ─────────────────────────────
// app.use(fn) sin ruta lo aplica a TODAS las peticiones.
// cors() permite que el frontend (en otro origen) llame a esta API.
app.use(cors());

// ─── 2. MIDDLEWARE DE LOGGING PROPIO ─────────────────────────
// Registra método, ruta, código de estado y tiempo de respuesta.

/**
 * Middleware de logging: registra cada petición con tiempo de respuesta.
 * Se ejecuta antes de que Express procese la ruta.
 * @param {express.Request} req
 * @param {express.Response} res
 * @param {express.NextFunction} next
 */
function logger(req, res, next) {
  const inicio = Date.now();
  const timestamp = new Date().toISOString();

  // Escuchar el evento 'finish' de la respuesta para conocer el código final
  res.on('finish', () => {
    const duracion = Date.now() - inicio;
    const estado = res.statusCode;
    // Colorear según código de estado para mejor lectura
    const color = estado >= 500 ? '\x1b[31m' : estado >= 400 ? '\x1b[33m' : '\x1b[32m';
    const reset = '\x1b[0m';
    console.log(`${color}[${timestamp}] ${req.method} ${req.path} → ${estado} (${duracion}ms)${reset}`);
  });

  next(); // Pasar al siguiente middleware o ruta
}

// Registrar el logger antes de cualquier ruta
app.use(logger);

// ─── 3. MIDDLEWARE DE PARSEO DE CUERPO ───────────────────────
app.use(express.json());
app.use(express.urlencoded({ extended: true })); // Para formularios HTML

// ─── 4. MIDDLEWARE DE AUTENTICACIÓN (selectivo) ──────────────
// Se puede aplicar solo a rutas específicas en lugar de globalmente.

/** Simula verificación de token — en producción usaría JWT */
function requiereAuth(req, res, next) {
  const token = req.headers['authorization'];

  if (!token) {
    return res.status(401).json({ error: 'Se requiere token de autenticación' });
  }

  if (token !== 'Bearer mi-token-secreto') {
    return res.status(403).json({ error: 'Token inválido o expirado' });
  }

  // Adjuntar datos del usuario al request para que las rutas lo usen
  req.usuario = { id: 1, nombre: 'Admin', rol: 'admin' };
  next();
}

// ─── RUTAS ────────────────────────────────────────────────────

/** Ruta pública — no requiere autenticación */
app.get('/', (req, res) => {
  res.json({ mensaje: 'API con middleware', version: '1.0' });
});

/**
 * Ruta protegida — requiere token válido.
 * Probar con: curl -H "Authorization: Bearer mi-token-secreto" http://localhost:3000/privado
 */
app.get('/privado', requiereAuth, (req, res) => {
  res.json({
    mensaje: 'Acceso autorizado',
    usuario: req.usuario,
  });
});

/** Ruta de ejemplo para ver el middleware de logging en acción */
app.get('/api/datos', (req, res) => {
  res.json({ datos: [1, 2, 3, 4, 5], total: 5 });
});

/** Ruta que simula un error para probar el manejador global */
app.get('/api/crash', (req, res, next) => {
  // Pasar el error a next() para que lo maneje el middleware de errores
  next(new Error('¡Error simulado en el servidor!'));
});

/** Ruta que lanza un error asíncrono */
app.get('/api/async-crash', async (req, res, next) => {
  try {
    await Promise.reject(new Error('Error asíncrono simulado'));
  } catch (err) {
    next(err); // Siempre pasar errores async a next()
  }
});

// ─── 5. MIDDLEWARE DE MANEJO GLOBAL DE ERRORES ───────────────
// DEBE tener exactamente 4 parámetros: (err, req, res, next)
// Express lo reconoce como handler de errores por esa firma.
// SIEMPRE va al FINAL, después de todas las rutas.

/**
 * Manejador global de errores.
 * Captura cualquier error pasado con next(err) en las rutas.
 * @param {Error} err - El error capturado
 * @param {express.Request} req
 * @param {express.Response} res
 * @param {express.NextFunction} next - Requerido por Express aunque no se use
 */
// eslint-disable-next-line no-unused-vars
function manejadorDeErrores(err, req, res, next) {
  console.error('ERROR:', err.message);
  console.error('Stack:', err.stack);

  // En producción nunca exponer el stack trace al cliente
  const esProduccion = process.env.NODE_ENV === 'production';

  res.status(err.statusCode || 500).json({
    error: err.message || 'Error interno del servidor',
    ...(esProduccion ? {} : { stack: err.stack }),
  });
}

// Registrar el manejador de errores AL FINAL
app.use(manejadorDeErrores);

// ─── INICIAR SERVIDOR ─────────────────────────────────────────
const PUERTO = process.env.PORT || 3000;
app.listen(PUERTO, () => {
  console.log(`\n✅ Servidor con middleware en http://localhost:${PUERTO}`);
  console.log('\nPruebas:');
  console.log(`  curl http://localhost:${PUERTO}/api/datos`);
  console.log(`  curl http://localhost:${PUERTO}/privado   ← sin token: 401`);
  console.log(`  curl -H "Authorization: Bearer mi-token-secreto" http://localhost:${PUERTO}/privado`);
  console.log(`  curl http://localhost:${PUERTO}/api/crash  ← error manejado`);
});
