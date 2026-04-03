// ============================================================
// ARCHIVO: 02_rutas_y_params.js
// TEMA: Parámetros de ruta, query strings, body y Router
// CÓMO EJECUTAR: node 02_rutas_y_params.js
// DEPENDENCIA: npm install express
// ============================================================

const express = require('express');
const app = express();

// Middleware para parsear JSON en el body de las peticiones
app.use(express.json());

// ─── BASE DE DATOS SIMULADA ───────────────────────────────────
// Array en memoria para simular usuarios sin necesitar una BD real.
const usuarios = [
  { id: 1, nombre: 'Ana García', email: 'ana@ejemplo.com', rol: 'admin' },
  { id: 2, nombre: 'Carlos López', email: 'carlos@ejemplo.com', rol: 'editor' },
  { id: 3, nombre: 'María Rodríguez', email: 'maria@ejemplo.com', rol: 'usuario' },
];

// ─── 1. PARÁMETROS DE RUTA (:param) ──────────────────────────
// Los dos puntos indican un parámetro dinámico en la URL.
// /usuarios/1 → req.params.id = '1' (siempre string)

/**
 * GET /usuarios/:id — Obtiene un usuario por su ID.
 * Ejemplo: GET /usuarios/2
 */
app.get('/usuarios/:id', (req, res) => {
  // req.params contiene los segmentos dinámicos de la URL
  const id = parseInt(req.params.id);

  if (isNaN(id)) {
    return res.status(400).json({ error: 'El ID debe ser un número' });
  }

  const usuario = usuarios.find((u) => u.id === id);

  if (!usuario) {
    return res.status(404).json({ error: `Usuario con id ${id} no encontrado` });
  }

  res.json(usuario);
});

/**
 * GET /usuarios/:id/perfil — Múltiples parámetros en la misma ruta.
 * Ejemplo: GET /usuarios/1/perfil
 */
app.get('/usuarios/:id/perfil', (req, res) => {
  const usuario = usuarios.find((u) => u.id === parseInt(req.params.id));
  if (!usuario) return res.status(404).json({ error: 'Usuario no encontrado' });

  // Respuesta con datos adicionales del perfil
  res.json({
    ...usuario,
    perfil: {
      ultimoAcceso: new Date().toISOString(),
      sesionesActivas: 1,
    },
  });
});

// ─── 2. QUERY STRINGS (?clave=valor) ─────────────────────────
// Los parámetros de consulta van después del '?' en la URL.
// /buscar?q=ana&rol=admin → req.query = { q: 'ana', rol: 'admin' }

/**
 * GET /usuarios — Lista usuarios con filtros opcionales por query params.
 * Ejemplos:
 *   GET /usuarios
 *   GET /usuarios?rol=admin
 *   GET /usuarios?q=car&rol=editor
 *   GET /usuarios?pagina=1&limite=2
 */
app.get('/usuarios', (req, res) => {
  // Desestructurar los query params con valores por defecto
  const { q = '', rol = '', pagina = 1, limite = 10 } = req.query;

  let resultado = [...usuarios];

  // Filtrar por búsqueda de texto (nombre o email)
  if (q) {
    const termino = q.toLowerCase();
    resultado = resultado.filter(
      (u) =>
        u.nombre.toLowerCase().includes(termino) ||
        u.email.toLowerCase().includes(termino)
    );
  }

  // Filtrar por rol
  if (rol) {
    resultado = resultado.filter((u) => u.rol === rol);
  }

  // Paginación básica
  const inicio = (parseInt(pagina) - 1) * parseInt(limite);
  const paginado = resultado.slice(inicio, inicio + parseInt(limite));

  res.json({
    total: resultado.length,
    pagina: parseInt(pagina),
    limite: parseInt(limite),
    datos: paginado,
  });
});

// ─── 3. BODY DE LA PETICIÓN (req.body) ───────────────────────
// req.body contiene el cuerpo de peticiones POST/PUT/PATCH.
// Requiere el middleware express.json() (registrado al inicio).

/**
 * POST /usuarios — Crea un nuevo usuario.
 * Body esperado: { nombre, email, rol }
 */
app.post('/usuarios', (req, res) => {
  const { nombre, email, rol = 'usuario' } = req.body;

  // Validación básica
  if (!nombre || !email) {
    return res.status(400).json({
      error: 'Los campos nombre y email son obligatorios',
    });
  }

  // Verificar que el email no esté duplicado
  const existe = usuarios.some((u) => u.email === email);
  if (existe) {
    return res.status(409).json({ error: 'Ya existe un usuario con ese email' });
  }

  // Crear el nuevo usuario
  const nuevoId = Math.max(...usuarios.map((u) => u.id)) + 1;
  const nuevoUsuario = { id: nuevoId, nombre, email, rol };
  usuarios.push(nuevoUsuario);

  // 201 Created — código correcto para recursos creados
  res.status(201).json(nuevoUsuario);
});

// ─── 4. express.Router() ─────────────────────────────────────
// Router permite organizar rutas en módulos separados.
// En un proyecto real, cada router estaría en su propio archivo.

/** Router dedicado para rutas de productos */
const productosRouter = express.Router();

// Base de datos simulada de productos
const productos = [
  { id: 1, nombre: 'Teclado mecánico', precio: 89.99, categoria: 'periféricos' },
  { id: 2, nombre: 'Monitor 27"', precio: 349.99, categoria: 'monitores' },
  { id: 3, nombre: 'Mouse inalámbrico', precio: 45.50, categoria: 'periféricos' },
];

// Las rutas del router son relativas al prefijo donde se monta
productosRouter.get('/', (req, res) => {
  const { categoria } = req.query;
  const resultado = categoria
    ? productos.filter((p) => p.categoria === categoria)
    : productos;
  res.json(resultado);
});

productosRouter.get('/:id', (req, res) => {
  const producto = productos.find((p) => p.id === parseInt(req.params.id));
  if (!producto) return res.status(404).json({ error: 'Producto no encontrado' });
  res.json(producto);
});

// Montar el router bajo el prefijo /productos
// Todas las rutas del router quedan como /productos/*
app.use('/productos', productosRouter);

// ─── RUTA RAÍZ CON DOCUMENTACIÓN ─────────────────────────────
app.get('/', (req, res) => {
  res.json({
    titulo: 'API de Rutas y Parámetros',
    endpoints: {
      'GET /usuarios': 'Lista con filtros: ?q=texto&rol=admin&pagina=1&limite=5',
      'GET /usuarios/:id': 'Usuario por ID',
      'GET /usuarios/:id/perfil': 'Perfil extendido del usuario',
      'POST /usuarios': 'Crear usuario (body: {nombre, email, rol})',
      'GET /productos': 'Lista productos, filtrar: ?categoria=periféricos',
      'GET /productos/:id': 'Producto por ID',
    },
  });
});

// ─── 404 global ───────────────────────────────────────────────
app.use((req, res) => {
  res.status(404).json({ error: 'Ruta no encontrada', ruta: req.path });
});

// ─── INICIAR SERVIDOR ─────────────────────────────────────────
const PUERTO = process.env.PORT || 3000;
app.listen(PUERTO, () => {
  console.log(`\n✅ Servidor en http://localhost:${PUERTO}`);
  console.log('\nEjemplos de prueba:');
  console.log(`  curl "http://localhost:${PUERTO}/usuarios"`);
  console.log(`  curl "http://localhost:${PUERTO}/usuarios/1"`);
  console.log(`  curl "http://localhost:${PUERTO}/usuarios?rol=admin"`);
  console.log(`  curl "http://localhost:${PUERTO}/productos?categoria=periféricos"`);
  console.log(`  curl -X POST http://localhost:${PUERTO}/usuarios -H "Content-Type: application/json" -d '{"nombre":"Luis","email":"luis@test.com"}'`);
});
