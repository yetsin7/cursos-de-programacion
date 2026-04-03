// =============================================================
// MÓDULO 27 — Medición de Performance
// Archivo: 01_medicion.js
//
// Antes de optimizar, MIDE. El código que crees que es lento
// puede no ser el cuello de botella real.
//
// Ejecutar: node 01_medicion.js
// =============================================================

// =============================================================
// SECCIÓN 1 — console.time / console.timeEnd
// La forma más simple de medir tiempo de ejecución.
// Precisión: milisegundos. Útil para mediciones aproximadas.
// =============================================================

/**
 * Genera un arreglo de n números aleatorios.
 * @param {number} n
 * @returns {number[]}
 */
function generarArreglo(n) {
  return Array.from({ length: n }, () => Math.random() * 1000);
}

const arregloGrande = generarArreglo(100_000);

console.log("=== console.time ===");

// El string es la etiqueta — debe coincidir en time y timeEnd
console.time("ordenar-100k");
const ordenado = [...arregloGrande].sort((a, b) => a - b);
console.timeEnd("ordenar-100k"); // imprime: "ordenar-100k: X.XXXms"

// timeLog permite ver el tiempo parcial sin detener el cronómetro
console.time("proceso-completo");
const suma = arregloGrande.reduce((acc, n) => acc + n, 0);
console.timeLog("proceso-completo", "después de suma");
const media = suma / arregloGrande.length;
console.timeEnd("proceso-completo");

// =============================================================
// SECCIÓN 2 — performance.now()
// Alta resolución (sub-milisegundo). Ideal para benchmarks precisos.
// Retorna tiempo en milisegundos con decimales de microsegundos.
// =============================================================

/**
 * Mide el tiempo de ejecución de una función.
 * @param {string} etiqueta - Nombre para identificar la medición
 * @param {Function} fn - Función a medir
 * @param {...any} args - Argumentos para la función
 * @returns {any} El resultado de la función
 */
function medir(etiqueta, fn, ...args) {
  const inicio = performance.now();
  const resultado = fn(...args);
  const fin = performance.now();
  console.log(`[${etiqueta}] ${(fin - inicio).toFixed(4)}ms`);
  return resultado;
}

console.log("\n=== performance.now() ===");

// Comparar dos implementaciones de la misma operación
/**
 * Suma los elementos de un arreglo con un bucle for clásico.
 * @param {number[]} arr
 * @returns {number}
 */
function sumaConFor(arr) {
  let total = 0;
  for (let i = 0; i < arr.length; i++) {
    total += arr[i];
  }
  return total;
}

/**
 * Suma los elementos de un arreglo con reduce.
 * @param {number[]} arr
 * @returns {number}
 */
function sumaConReduce(arr) {
  return arr.reduce((acc, n) => acc + n, 0);
}

medir("suma-for", sumaConFor, arregloGrande);
medir("suma-reduce", sumaConReduce, arregloGrande);

// =============================================================
// SECCIÓN 3 — performance.mark() y performance.measure()
// Permite marcar puntos nombrados en el tiempo y medir entre ellos.
// Más organizado que guardar variables de tiempo manualmente.
// =============================================================

const { performance: perf, PerformanceObserver } = require("perf_hooks");

console.log("\n=== performance.mark() y measure() ===");

/**
 * Simula una operación de procesamiento de datos en varias fases.
 */
function procesarDatos(datos) {
  // Fase 1: Filtrar
  perf.mark("filtrar-inicio");
  const filtrados = datos.filter((n) => n > 500);
  perf.mark("filtrar-fin");

  // Fase 2: Transformar
  perf.mark("transformar-inicio");
  const transformados = filtrados.map((n) => Math.sqrt(n));
  perf.mark("transformar-fin");

  // Fase 3: Reducir
  perf.mark("reducir-inicio");
  const resultado = transformados.reduce((acc, n) => acc + n, 0);
  perf.mark("reducir-fin");

  // Medir cada fase
  perf.measure("Fase 1 - Filtrar", "filtrar-inicio", "filtrar-fin");
  perf.measure("Transformar", "transformar-inicio", "transformar-fin");
  perf.measure("Reducir", "reducir-inicio", "reducir-fin");

  return resultado;
}

procesarDatos(arregloGrande);

// Leer las mediciones acumuladas
const mediciones = perf.getEntriesByType("measure");
mediciones.forEach((m) => {
  console.log(`${m.name}: ${m.duration.toFixed(4)}ms`);
});

// Limpiar marcas para no contaminar futuras mediciones
perf.clearMarks();
perf.clearMeasures();

// =============================================================
// SECCIÓN 4 — Benchmark simple: comparar implementaciones
// Ejecuta múltiples iteraciones para obtener tiempos estables.
// =============================================================

/**
 * Ejecuta una función N veces y retorna el tiempo promedio.
 * Útil para comparar implementaciones con tiempos muy cortos.
 *
 * @param {string} nombre
 * @param {Function} fn
 * @param {number} [iteraciones=1000]
 * @returns {number} Tiempo promedio en ms
 */
function benchmark(nombre, fn, iteraciones = 1000) {
  const inicio = perf.now();
  for (let i = 0; i < iteraciones; i++) {
    fn();
  }
  const total = perf.now() - inicio;
  const promedio = total / iteraciones;
  console.log(`[${nombre}] ${iteraciones} iter: ${total.toFixed(2)}ms | avg: ${promedio.toFixed(4)}ms`);
  return promedio;
}

console.log("\n=== Benchmark comparativo ===");

const datos = generarArreglo(1000);

// Comparar: acceso a .length en cada iteración vs cacheado
const t1 = benchmark("for sin cachear length", () => {
  let s = 0;
  for (let i = 0; i < datos.length; i++) s += datos[i];
}, 500);

const t2 = benchmark("for cacheando length", () => {
  let s = 0;
  const len = datos.length; // cacheado fuera del bucle
  for (let i = 0; i < len; i++) s += datos[i];
}, 500);

console.log(`\nDiferencia: ${((t1 - t2) / t1 * 100).toFixed(1)}% más rápido con caché`);
console.log("(La diferencia es mínima en motores modernos — V8 optimiza esto)");
console.log("\nMoral: mide primero, luego decide si optimizar.");
