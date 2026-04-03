// =============================================================================
// ARCHIVO: 03_json_y_modelos.js
// TEMA: JSON — parse, stringify, validación, modelos, fechas ISO 8601
// =============================================================================
// CÓMO EJECUTAR: node 03_json_y_modelos.js
// =============================================================================

// =============================================================================
// SECCIÓN 1: JSON.parse y JSON.stringify — fundamentos
// =============================================================================

console.log('=== 1. JSON.parse y JSON.stringify ===\n');

const objetoOriginal = {
  nombre:    'Ana García',
  edad:      28,
  activa:    true,
  puntuacion: 9.5,
  etiquetas: ['javascript', 'node', 'react'],
  direccion: {
    ciudad: 'Madrid',
    pais:   'España',
  },
  // Estos tipos se pierden o transforman en JSON:
  fecha:     new Date(),   // se convierte a string ISO
  indefinido: undefined,   // se omite en el JSON
  funcion:   () => 'hola', // se omite en el JSON
  simbolo:   Symbol('id'), // se omite en el JSON
};

// Serializar a string JSON
const jsonString = JSON.stringify(objetoOriginal);
console.log('JSON.stringify (compacto):');
console.log(jsonString.slice(0, 100) + '...\n');

// JSON "pretty print" — indentación de 2 espacios para legibilidad
const jsonPretty = JSON.stringify(objetoOriginal, null, 2);
console.log('JSON.stringify (pretty, primeras líneas):');
jsonPretty.split('\n').slice(0, 10).forEach((l) => console.log(l));
console.log('...\n');

// Deserializar de string a objeto
const parseado = JSON.parse(jsonString);
console.log('JSON.parse — tipo resultado:', typeof parseado);
console.log('nombre:', parseado.nombre);
console.log('fecha (era Date, ahora string):', typeof parseado.fecha, parseado.fecha);
console.log('undefined se omitió:', parseado.indefinido === undefined);

// =============================================================================
// SECCIÓN 2: JSON.stringify con replacer — controlar qué se incluye
// =============================================================================

console.log('\n=== 2. JSON.stringify con replacer ===\n');

const usuario = {
  id:         1,
  nombre:     'Carlos López',
  email:      'carlos@ejemplo.com',
  password:   's3cr3t0_muy_privado', // ← NO debe ir en la API de respuesta
  tarjeta:    '4111-1111-1111-1111', // ← tampoco
  puntos:     150,
  ultimaConexion: new Date().toISOString(),
};

// Replacer como array: solo incluir los campos de esta lista
const camposPublicos = ['id', 'nombre', 'email', 'puntos', 'ultimaConexion'];
const jsonPublico = JSON.stringify(usuario, camposPublicos, 2);
console.log('Solo campos públicos (replacer array):');
console.log(jsonPublico);

// Replacer como función: transformar valores durante la serialización
const jsonFiltrado = JSON.stringify(usuario, (clave, valor) => {
  // Omitir campos sensibles
  if (['password', 'tarjeta'].includes(clave)) return undefined;
  // Enmascarar emails
  if (clave === 'email') return valor.replace(/(.{2}).+(@.+)/, '$1***$2');
  return valor;
}, 2);
console.log('\nCon función replacer (email enmascarado):');
console.log(jsonFiltrado);

// =============================================================================
// SECCIÓN 3: Crear clases/factories desde JSON (mapeo de modelos)
// =============================================================================

console.log('\n=== 3. Clases y factories desde JSON ===\n');

/**
 * Clase que representa un producto mapeado desde la respuesta de la API.
 * Encapsula la lógica de negocio y normaliza los datos recibidos.
 */
class Producto {
  /**
   * Crea una instancia de Producto desde datos crudos de la API.
   * @param {object} datos - Datos del producto tal como llegan del servidor
   */
  constructor({ id, title, price, rating, category, description }) {
    this.id          = id;
    this.titulo      = title;
    this.precio      = price ?? 0;
    this.puntuacion  = rating?.rate ?? 0;
    this.totalVotos  = rating?.count ?? 0;
    this.categoria   = category ?? 'sin categoría';
    this.descripcion = description ?? '';
  }

  /** Retorna el precio formateado con símbolo de moneda */
  precioFormateado() {
    return `$${this.precio.toFixed(2)}`;
  }

  /** Retorna true si el producto tiene buena puntuación (>= 4.0) */
  esBienValorado() {
    return this.puntuacion >= 4.0;
  }

  /** Representación legible del producto */
  toString() {
    return `[${this.id}] ${this.titulo} — ${this.precioFormateado()} ⭐${this.puntuacion}`;
  }
}

// Simular datos que podrían venir de una API (patrón real)
const datosAPICrudos = [
  { id: 1, title: 'Camiseta básica',    price: 15.99, rating: { rate: 4.2, count: 120 }, category: 'ropa' },
  { id: 2, title: 'Auriculares pro',    price: 89.00, rating: { rate: 3.8, count: 45  }, category: 'electrónica' },
  { id: 3, title: 'Libro de JS',        price: 29.99, rating: { rate: 4.9, count: 312 }, category: 'libros' },
];

// Mapear datos crudos a instancias de la clase
const productos = datosAPICrudos.map((dato) => new Producto(dato));

console.log('Productos mapeados:');
productos.forEach((p) => {
  console.log(' ', p.toString());
  console.log('   Bien valorado:', p.esBienValorado());
});

// =============================================================================
// SECCIÓN 4: Validar estructura del JSON recibido
// =============================================================================

console.log('\n=== 4. Validar estructura de JSON ===\n');

/**
 * Valida que un objeto tenga los campos requeridos con los tipos esperados.
 * Retorna un objeto con el resultado de la validación y los errores encontrados.
 * @param {object} datos - Objeto a validar
 * @param {object} esquema - Esquema de validación { campo: tipo }
 * @returns {{ valido: boolean, errores: string[] }}
 */
function validarEsquema(datos, esquema) {
  const errores = [];

  for (const [campo, tipo] of Object.entries(esquema)) {
    if (datos[campo] === undefined || datos[campo] === null) {
      errores.push(`Campo requerido faltante: "${campo}"`);
    } else if (typeof datos[campo] !== tipo) {
      errores.push(`Campo "${campo}" debe ser ${tipo}, recibido: ${typeof datos[campo]}`);
    }
  }

  return { valido: errores.length === 0, errores };
}

const esquemaUsuario = {
  id:     'number',
  nombre: 'string',
  email:  'string',
};

const usuarioValido   = { id: 1, nombre: 'Ana', email: 'ana@test.com' };
const usuarioInvalido = { id: '1', nombre: 'Ana' }; // id es string, falta email

console.log('Usuario válido:  ', validarEsquema(usuarioValido, esquemaUsuario));
console.log('Usuario inválido:', validarEsquema(usuarioInvalido, esquemaUsuario));

// =============================================================================
// SECCIÓN 5: Manejo de fechas en JSON (ISO 8601)
// =============================================================================

console.log('\n=== 5. Fechas en JSON (ISO 8601) ===\n');

// Las fechas no tienen representación nativa en JSON
// La convención estándar es usar strings ISO 8601
const evento = {
  titulo:    'Conferencia JavaScript',
  inicio:    new Date('2025-06-15T10:00:00Z'),
  fin:       new Date('2025-06-15T18:00:00Z'),
  creado:    new Date(),
};

// Al serializar, Date se convierte automáticamente a ISO 8601
const eventoJSON = JSON.stringify(evento, null, 2);
console.log('Evento serializado:');
console.log(eventoJSON);

// Al deserializar, los strings de fecha NO se reconvierten a Date automáticamente
const eventoDeserializado = JSON.parse(eventoJSON);
console.log('\nTipo de fecha después de parse:', typeof eventoDeserializado.inicio);

// Hay que convertirlas manualmente
const fechaInicio = new Date(eventoDeserializado.inicio);
console.log('Fecha convertida:', fechaInicio.toLocaleDateString('es-ES', {
  year: 'numeric', month: 'long', day: 'numeric', hour: '2-digit', minute: '2-digit'
}));

// Patrón: reviver en JSON.parse para auto-convertir fechas
const ISO_DATE_REGEX = /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}/;

function reviverFechas(clave, valor) {
  if (typeof valor === 'string' && ISO_DATE_REGEX.test(valor)) {
    return new Date(valor);
  }
  return valor;
}

const eventoConFechas = JSON.parse(eventoJSON, reviverFechas);
console.log('\nCon reviver — tipo de fecha:', eventoConFechas.inicio instanceof Date);
console.log('Fecha inicio:', eventoConFechas.inicio.toLocaleDateString('es-ES'));

console.log('\n✅ Módulo 14 — JSON y modelos completado');
