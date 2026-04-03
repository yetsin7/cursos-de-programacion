// =============================================================================
// ARCHIVO: 05_ejercicios.js
// TEMA: Ejercicios del Módulo 02 — Tipos de datos
// =============================================================================
//
// Practica strings, numbers, booleans y null/undefined. Cada ejercicio
// incluye una solución comentada. Intenta resolverlo antes de mirar.
//
// CÓMO EJECUTAR:
//   node 05_ejercicios.js
//
// =============================================================================

console.log('╔════════════════════════════════════════╗');
console.log('║  EJERCICIOS — MÓDULO 02 TIPOS DE DATOS ║');
console.log('╚════════════════════════════════════════╝\n');

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 1: Procesar un nombre completo
// ─────────────────────────────────────────────────────────────────────────────
//
// Dada la cadena: '   juan carlos pérez   '
// 1. Elimina los espacios del inicio y final
// 2. Convierte a Title Case (primera letra de cada palabra en mayúscula)
// 3. Imprime el resultado y su longitud

console.log('─── EJERCICIO 1: Procesar nombre ───');

/**
 * Convierte un string a Title Case (Primera Letra De Cada Palabra En Mayúscula).
 * @param {string} str - El string a convertir.
 * @returns {string} El string en Title Case.
 */
const toTitleCase = (str) =>
  str
    .trim()
    .toLowerCase()
    .split(' ')
    .map((palabra) => palabra.charAt(0).toUpperCase() + palabra.slice(1))
    .join(' ');

const nombreRaw = '   juan carlos pérez   ';
const nombreLimpio = toTitleCase(nombreRaw);

console.log(`Original:  "${nombreRaw}"`);
console.log(`Procesado: "${nombreLimpio}"`);
console.log(`Longitud:  ${nombreLimpio.length} caracteres`);

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 2: Formatear precios
// ─────────────────────────────────────────────────────────────────────────────
//
// Tienes un array de precios como numbers.
// Formatea cada precio como string con:
// - 2 decimales
// - Separador de miles (punto en español: 1.500,00)
// - Símbolo de moneda al inicio

console.log('\n─── EJERCICIO 2: Formatear precios ───');

const precios = [1500, 42.5, 1000000, 0.99, 250.75];

// Formateador de moneda en pesos colombianos
const formatearPrecio = (precio) =>
  new Intl.NumberFormat('es-CO', {
    style: 'currency',
    currency: 'COP',
    minimumFractionDigits: 2,
  }).format(precio);

precios.forEach((p) => {
  console.log(`  ${p.toString().padStart(12)} → ${formatearPrecio(p)}`);
});

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 3: Clasificador de valores
// ─────────────────────────────────────────────────────────────────────────────
//
// Crea una función clasificarValor(val) que retorne:
// - 'nulo' si es null
// - 'indefinido' si es undefined
// - 'vacío' si es string vacío, 0, false
// - 'truthy' para todo lo demás

console.log('\n─── EJERCICIO 3: Clasificador de valores ───');

/**
 * Clasifica un valor según su naturaleza en JavaScript.
 * @param {*} val - El valor a clasificar.
 * @returns {string} La clasificación del valor.
 */
const clasificarValor = (val) => {
  if (val === null) return 'nulo';
  if (val === undefined) return 'indefinido';
  if (val === '' || val === 0 || val === false) return 'vacío/falsy explícito';
  return 'truthy';
};

const casosDePrueba = [null, undefined, '', 0, false, 'hola', 1, true, [], {}];

casosDePrueba.forEach((val) => {
  const repr = JSON.stringify(val) ?? String(val);
  console.log(`  ${repr?.padEnd(12) ?? String(val).padEnd(12)} → ${clasificarValor(val)}`);
});

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 4: Validador de email básico
// ─────────────────────────────────────────────────────────────────────────────
//
// Crea una función que valide si un string parece ser un email válido.
// Reglas básicas: contiene @, tiene algo antes y después del @,
// el dominio tiene al menos un punto.

console.log('\n─── EJERCICIO 4: Validador de email ───');

/**
 * Valida si un string tiene el formato básico de un email.
 * @param {string} email - El string a validar.
 * @returns {boolean} true si parece un email válido.
 */
const esEmailValido = (email) => {
  if (typeof email !== 'string' || email.trim().length === 0) return false;

  const indiceArroba = email.indexOf('@');

  // Debe tener exactamente un @
  if (indiceArroba <= 0) return false;
  if (email.lastIndexOf('@') !== indiceArroba) return false;

  const dominio = email.slice(indiceArroba + 1);

  // El dominio debe tener al menos un punto y algo después
  const indicePunto = dominio.lastIndexOf('.');
  if (indicePunto <= 0) return false;
  if (indicePunto === dominio.length - 1) return false;

  return true;
};

const emails = [
  'usuario@ejemplo.com',
  'invalido',
  '@sinusuario.com',
  'sin-dominio@',
  'dos@@arrobas.com',
  'usuario@dominio.co',
  '',
];

emails.forEach((e) => {
  const valido = esEmailValido(e);
  const icono = valido ? '✅' : '❌';
  console.log(`  ${icono} "${e}"`);
});

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 5: Acceso seguro a datos de API
// ─────────────────────────────────────────────────────────────────────────────
//
// Simula una respuesta de API que puede tener datos faltantes.
// Usa optional chaining y nullish coalescing para extraer datos
// con valores por defecto cuando falten.

console.log('\n─── EJERCICIO 5: Acceso seguro a API ───');

/**
 * Extrae y normaliza los datos de un usuario desde una respuesta de API.
 * @param {Object|null} respuesta - La respuesta cruda de la API.
 * @returns {Object} Datos del usuario con valores por defecto.
 */
const extraerDatosUsuario = (respuesta) => ({
  nombre: respuesta?.datos?.usuario?.nombre ?? 'Desconocido',
  email: respuesta?.datos?.usuario?.contacto?.email ?? 'sin-email',
  ciudad: respuesta?.datos?.usuario?.ubicacion?.ciudad ?? 'Sin ciudad',
  plan: respuesta?.datos?.suscripcion?.plan ?? 'gratuito',
  activo: respuesta?.datos?.usuario?.activo ?? false,
});

const respuestas = [
  {
    datos: {
      usuario: {
        nombre: 'Luis Torres',
        contacto: { email: 'luis@test.com' },
        ubicacion: { ciudad: 'Caracas' },
        activo: true,
      },
      suscripcion: { plan: 'premium' },
    },
  },
  {
    datos: {
      usuario: {
        nombre: 'Elena',
        // Sin contacto, sin ubicación
        activo: false,
      },
    },
  },
  null, // API retornó null (error o sin datos)
];

respuestas.forEach((resp, i) => {
  console.log(`\n  Respuesta ${i + 1}:`);
  const datos = extraerDatosUsuario(resp);
  Object.entries(datos).forEach(([clave, valor]) => {
    console.log(`    ${clave}: ${valor}`);
  });
});

// =============================================================================
// EXPERIMENTA:
// 1. Mejora el validador de email con más reglas (sin espacios, TLD válido)
// 2. Crea una función que genere un slug URL desde un título:
//    'Mi Blog Post #1' → 'mi-blog-post-1'
// 3. Usa el ejercicio 5 con tus propias estructuras de datos anidadas
// 4. Crea una función que detecte si un número es primo
// 5. Combina string methods para limpiar y normalizar datos de un formulario
// =============================================================================
