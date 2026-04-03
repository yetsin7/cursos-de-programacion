// ============================================================
// ARCHIVO: 02_optimizaciones_js.js
// TEMA: Optimizaciones de rendimiento en JavaScript
// CÓMO EJECUTAR: node 02_optimizaciones_js.js
// ============================================================

'use strict';

// ─── 1. CACHEAR LOOKUPS EN BUCLES ────────────────────────────
// Acceder a .length en cada iteración obliga al engine a calcularlo.
// Guardarlo en una variable es más claro y evita recalcular.

console.log('=== 1. Cachear length en bucles ===');

const arr = Array.from({ length: 1_000_000 }, (_, i) => i);

console.time('sin caché');
let suma1 = 0;
for (let i = 0; i < arr.length; i++) suma1 += arr[i]; // arr.length se evalúa en cada iteración
console.timeEnd('sin caché');

console.time('con caché');
let suma2 = 0;
const len = arr.length;
for (let i = 0; i < len; i++) suma2 += arr[i];
console.timeEnd('con caché');

console.log('Resultados iguales:', suma1 === suma2);

// ─── 2. Map PARA BÚSQUEDAS O(1) vs Array.find O(n) ──────────
// Array.find recorre el array completo en el peor caso — O(n).
// Map con clave directa es O(1) — ideal para búsquedas frecuentes.

console.log('\n=== 2. Map O(1) vs Array.find O(n) ===');

const usuarios = Array.from({ length: 50_000 }, (_, i) => ({
  id: i + 1,
  nombre: `Usuario ${i + 1}`,
  email: `u${i + 1}@test.com`,
}));

// Construir el índice Map UNA vez — O(n) pero se paga una sola vez
const mapaUsuarios = new Map(usuarios.map((u) => [u.id, u]));

const idsBuscar = [1, 12500, 49999, 50000];

console.time('Array.find (4 búsquedas)');
idsBuscar.forEach((id) => usuarios.find((u) => u.id === id));
console.timeEnd('Array.find (4 búsquedas)');

console.time('Map.get (4 búsquedas)');
idsBuscar.forEach((id) => mapaUsuarios.get(id));
console.timeEnd('Map.get (4 búsquedas)');

console.log('Usuario encontrado con Map:', mapaUsuarios.get(12500)?.nombre);

// ─── 3. Set PARA VERIFICAR EXISTENCIA O(1) ───────────────────
// Array.includes es O(n). Set.has es O(1).

console.log('\n=== 3. Set.has O(1) vs Array.includes O(n) ===');

const listaNumeros = Array.from({ length: 100_000 }, (_, i) => i);
const conjuntoNumeros = new Set(listaNumeros);

console.time('Array.includes (1000 búsquedas)');
for (let i = 0; i < 1000; i++) listaNumeros.includes(Math.floor(Math.random() * 100_000));
console.timeEnd('Array.includes (1000 búsquedas)');

console.time('Set.has (1000 búsquedas)');
for (let i = 0; i < 1000; i++) conjuntoNumeros.has(Math.floor(Math.random() * 100_000));
console.timeEnd('Set.has (1000 búsquedas)');

// Set también es ideal para deduplicar arrays
const conDuplicados = [1, 2, 2, 3, 3, 3, 4];
const sinDuplicados = [...new Set(conDuplicados)];
console.log('Deduplicar con Set:', sinDuplicados);

// ─── 4. DEBOUNCE ─────────────────────────────────────────────
// Retrasa la ejecución hasta que paren las llamadas.
// Caso de uso: búsqueda mientras el usuario escribe.

console.log('\n=== 4. Debounce ===');

/**
 * Crea una versión "debounced" de una función.
 * Solo se ejecuta después de que pasen `espera` ms sin nuevas llamadas.
 * @param {Function} fn - Función a debouncear
 * @param {number} espera - Tiempo de espera en milisegundos
 * @returns {Function} Función debounced
 */
function debounce(fn, espera) {
  let timer = null;
  return function (...args) {
    clearTimeout(timer);
    timer = setTimeout(() => fn.apply(this, args), espera);
  };
}

const buscarAPI = debounce((termino) => {
  console.log('  Petición enviada al servidor:', termino);
}, 300);

// Simular usuario escribiendo rápido — solo la última llamada llega al servidor
console.log('Simulando escritura rápida...');
buscarAPI('j');
buscarAPI('ja');
buscarAPI('jav');
buscarAPI('java');
buscarAPI('javas');
buscarAPI('javascript'); // Solo esta ejecuta la petición (después de 300ms)

// ─── 5. THROTTLE ─────────────────────────────────────────────
// Limita la ejecución a máximo una vez por período de tiempo.
// Caso de uso: evento scroll, resize, mousemove.

console.log('\n=== 5. Throttle ===');

/**
 * Crea una versión "throttled" de una función.
 * Garantiza que no se ejecute más de una vez por `limite` ms.
 * @param {Function} fn - Función a throttlear
 * @param {number} limite - Tiempo mínimo entre ejecuciones (ms)
 * @returns {Function} Función throttled
 */
function throttle(fn, limite) {
  let ultimaEjecucion = 0;
  return function (...args) {
    const ahora = Date.now();
    if (ahora - ultimaEjecucion >= limite) {
      ultimaEjecucion = ahora;
      return fn.apply(this, args);
    }
  };
}

const manejarScroll = throttle((posicion) => {
  console.log('  Scroll procesado en posición:', posicion);
}, 200);

// Simular 10 eventos de scroll rápidos — solo algunos se procesan
console.log('Simulando eventos de scroll...');
[0, 20, 50, 100, 150, 200, 250, 300, 350, 400].forEach((pos) => manejarScroll(pos));

// ─── 6. MEMOIZACIÓN CON Map ───────────────────────────────────
// Guardar el resultado de llamadas anteriores para no recalcular.

console.log('\n=== 6. Memoización ===');

/**
 * Genera una versión memoizada de una función.
 * Guarda resultados en un Map usando los argumentos como clave.
 * @param {Function} fn - Función pura a memoizar
 * @returns {Function & { cache: Map }} Función memoizada con caché accesible
 */
function memoizar(fn) {
  const cache = new Map();
  const memoizada = function (...args) {
    const clave = JSON.stringify(args);
    if (cache.has(clave)) {
      return cache.get(clave); // Cache hit — retorno inmediato
    }
    const resultado = fn.apply(this, args);
    cache.set(clave, resultado);
    return resultado;
  };
  memoizada.cache = cache;
  return memoizada;
}

// Fibonacci sin memoización — exponencialmente lento
function fibLento(n) {
  if (n <= 1) return n;
  return fibLento(n - 1) + fibLento(n - 2);
}

// Fibonacci con memoización — lineal
const fibRapido = memoizar(function fib(n) {
  if (n <= 1) return n;
  return fibRapido(n - 1) + fibRapido(n - 2);
});

console.time('fib(35) sin memo');
console.log('fib(35):', fibLento(35));
console.timeEnd('fib(35) sin memo');

console.time('fib(35) con memo');
console.log('fib(35):', fibRapido(35));
console.timeEnd('fib(35) con memo');

// Llamada repetida — resultado instantáneo desde caché
console.time('fib(35) segunda vez (caché)');
fibRapido(35);
console.timeEnd('fib(35) segunda vez (caché)');

// ─── 7. IMPORTACIONES DINÁMICAS ──────────────────────────────
// Cargar módulos solo cuando se necesitan — reduce el tiempo de inicio.

console.log('\n=== 7. Importaciones dinámicas ===');
console.log(`
// En lugar de cargar todo al inicio:
// const { parse } = require('csv-parse'); // Siempre cargado, aunque no se use

// Cargar solo cuando se necesite:
async function procesarCSV(archivo) {
  // El módulo se descarga y carga la primera vez que se llama a procesarCSV
  const { parse } = await import('csv-parse');
  // ...usar parse...
}

// En React / navegador — code splitting automático con Vite:
// const GraficosPesados = React.lazy(() => import('./GraficosPesados'));
`);

console.log('✅ Demo de optimizaciones completada.');
