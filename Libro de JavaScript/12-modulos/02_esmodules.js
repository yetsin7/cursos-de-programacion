// =============================================================================
// ARCHIVO: 02_esmodules.js
// TEMA: ES Modules — el estándar moderno de módulos en JavaScript
// =============================================================================
// CÓMO EJECUTAR: node 02_esmodules.js
// NOTA: Para usar ESM en Node.js, agrega "type": "module" en package.json
//       o renombra el archivo a .mjs
//       Este archivo usa CommonJS para poder ejecutarse sin configuración,
//       pero documenta y demuestra la sintaxis y conceptos de ESM.
// =============================================================================

'use strict';

// -----------------------------------------------------------------------------
// NOTA IMPORTANTE SOBRE ESTE ARCHIVO
// Los ejemplos de ESM están mostrados como cadenas de texto porque ESM requiere
// configuración especial en Node.js. Los conceptos se demuestran con comentarios
// y equivalencias en CommonJS para que el archivo sea ejecutable directamente.
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// SECCIÓN 1: Sintaxis de export en ES Modules
// -----------------------------------------------------------------------------

console.log('=== ES Modules: sintaxis de export ===\n');

console.log(`
/* ---- ARCHIVO: matematicas.js ---- */

// Named exports (exportaciones con nombre)
export const PI = 3.14159;

export function sumar(a, b) {
  return a + b;
}

export function restar(a, b) {
  return a - b;
}

// También puedes exportar al final del archivo
const multiplicar = (a, b) => a * b;
const dividir = (a, b) => a / b;

export { multiplicar, dividir };

// Default export (solo uno por módulo)
export default class Calculadora {
  constructor() {
    this.historial = [];
  }
  calcular(op, a, b) {
    const resultado = op(a, b);
    this.historial.push({ a, b, resultado });
    return resultado;
  }
}
`);

// -----------------------------------------------------------------------------
// SECCIÓN 2: Sintaxis de import en ES Modules
// -----------------------------------------------------------------------------

console.log('=== ES Modules: sintaxis de import ===\n');

console.log(`
/* ---- ARCHIVO: main.js ---- */

// Import de named exports (con llaves)
import { sumar, restar, PI } from './matematicas.js';

// Import del default export (sin llaves, cualquier nombre)
import Calculadora from './matematicas.js';

// Import de todo el módulo como namespace
import * as Mate from './matematicas.js';
// Uso: Mate.sumar(2, 3), Mate.PI, new Mate.default()

// Import combinado: default + named en una sola línea
import Calculadora, { sumar, PI } from './matematicas.js';

// Renombrar al importar
import { sumar as add, restar as subtract } from './matematicas.js';

console.log(PI);           // 3.14159
console.log(sumar(2, 3));  // 5
const calc = new Calculadora();
`);

// -----------------------------------------------------------------------------
// SECCIÓN 3: Diferencia entre default y named exports
// -----------------------------------------------------------------------------

console.log('=== Default vs Named exports ===\n');

console.log(`
// Named export → se importa con el mismo nombre y llaves
export const nombre = 'Juan';
import { nombre } from './modulo.js';

// Default export → se importa SIN llaves, con cualquier nombre
export default function saludar() { ... }
import saludar from './modulo.js';      // ✅
import cualquierNombre from './modulo.js'; // ✅ también válido

// BUENAS PRÁCTICAS:
// - Usa named exports para utilidades, constantes, múltiples funciones
// - Usa default export para la "cosa principal" del módulo (clase, componente)
// - Evita mezclar demasiado, mantén los módulos enfocados
`);

// -----------------------------------------------------------------------------
// SECCIÓN 4: Importaciones dinámicas
// import() devuelve una Promise — útil para carga lazy
// -----------------------------------------------------------------------------

console.log('=== Importaciones dinámicas: import() ===\n');

console.log(`
// import() es una función que retorna una Promise
// Útil para cargar módulos bajo demanda (lazy loading)

async function cargarModulo() {
  // Solo se carga cuando se llama a esta función
  const modulo = await import('./matematicas.js');

  // Named exports: modulo.sumar, modulo.PI
  console.log(modulo.sumar(10, 5)); // 15

  // Default export: modulo.default
  const calc = new modulo.default();
}

// Caso de uso real: cargar solo si el usuario realiza cierta acción
document.getElementById('btn-calcular').addEventListener('click', async () => {
  const { Calculadora } = await import('./calculadora.js');
  const calc = new Calculadora();
  // ...
});

// import() también funciona en Node.js con ESM habilitado
`);

// -----------------------------------------------------------------------------
// SECCIÓN 5: Top-level await (ES2022)
// En ESM puedes usar await fuera de funciones async
// -----------------------------------------------------------------------------

console.log('=== Top-level await (ES2022) ===\n');

console.log(`
// Solo disponible en ES Modules (no en CommonJS)
// Archivo: config.js (con "type": "module" en package.json)

const config = await fetch('https://api.ejemplo.com/config').then(r => r.json());

export const API_URL = config.apiUrl;
export const TIMEOUT = config.timeout;

// Esto BLOQUEA la inicialización del módulo hasta que fetch resuelva
// Los módulos que importan config.js esperan automáticamente
`);

// -----------------------------------------------------------------------------
// SECCIÓN 6: ESM en Node.js — configuración necesaria
// -----------------------------------------------------------------------------

console.log('=== Configurar ESM en Node.js ===\n');

console.log(`
OPCIÓN 1: Agregar "type": "module" en package.json
{
  "name": "mi-proyecto",
  "version": "1.0.0",
  "type": "module"   // <-- esto activa ESM para todos los .js
}

OPCIÓN 2: Usar extensión .mjs para archivos individuales
  archivo.mjs  → siempre tratado como ESM
  archivo.cjs  → siempre tratado como CommonJS

OPCIÓN 3: tsconfig.json con "module": "ESNext" (TypeScript)

IMPORTANTE en ESM con Node.js:
  ✅ import { algo } from './modulo.js'  (extensión .js OBLIGATORIA)
  ❌ import { algo } from './modulo'     (sin extensión → error en Node)
  ✅ __dirname no existe, usar:
     import { fileURLToPath } from 'url';
     import { dirname } from 'path';
     const __filename = fileURLToPath(import.meta.url);
     const __dirname = dirname(__filename);
`);

// -----------------------------------------------------------------------------
// SECCIÓN 7: import.meta — información del módulo actual
// -----------------------------------------------------------------------------

console.log('=== import.meta ===\n');

console.log(`
// import.meta está disponible en ESM (equivale a algunos globals de CJS)

// URL del archivo actual
console.log(import.meta.url);
// file:///Users/juan/proyecto/main.js

// Obtener __dirname en ESM
import { fileURLToPath } from 'url';
import { dirname } from 'path';
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// En Node.js 20.11+ también existe:
console.log(import.meta.dirname);   // equivale a __dirname
console.log(import.meta.filename);  // equivale a __filename
`);

// -----------------------------------------------------------------------------
// SECCIÓN 8: Comparativa rápida CJS vs ESM
// -----------------------------------------------------------------------------

console.log('=== Tabla comparativa CJS vs ESM ===\n');

const comparativa = [
  ['Característica',    'CommonJS',              'ES Modules'],
  ['Importar',          "require('./mod')",       "import x from './mod.js'"],
  ['Exportar',          'module.exports = {}',   'export / export default'],
  ['Evaluación',        'Síncrona',              'Asíncrona'],
  ['Top-level await',   '❌ No',                 '✅ Sí'],
  ['Tree-shaking',      '❌ Difícil',            '✅ Eficiente'],
  ['__dirname',         '✅ Disponible',         '❌ Usar import.meta'],
  ['Uso recomendado',   'Código legacy/npm',     'Proyectos modernos'],
];

comparativa.forEach(([feature, cjs, esm]) => {
  console.log(`${feature.padEnd(20)} | ${cjs.padEnd(30)} | ${esm}`);
});

console.log('\n✅ Módulo 12 — ES Modules completado');
