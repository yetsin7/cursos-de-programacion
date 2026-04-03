// ============================================================
// ARCHIVO: 05_higher_order.js
// TEMA: Higher-order functions, callbacks, map/filter/reduce, composición, currying
// CÓMO EJECUTAR: node 05_higher_order.js
// ============================================================

// ── Funciones de orden superior (Higher-Order Functions) ─────
// Una función es de orden superior si:
// 1. Recibe una o más funciones como argumento (callback), O
// 2. Retorna una función como resultado
// En JS, esto es posible porque las funciones son ciudadanos de primera clase
console.log("=== Higher-Order Functions ===");

// Ejemplo básico: función que aplica otra función a un valor
/**
 * Aplica una función transformadora a un valor.
 * @param {Function} fn - Función a aplicar
 * @param {*} valor - Valor de entrada
 * @returns {*} Resultado de fn(valor)
 */
function aplicar(fn, valor) {
  return fn(valor);
}

const doblar = x => x * 2;
const mayusculas = s => s.toUpperCase();

console.log(aplicar(doblar, 5));           // 10
console.log(aplicar(mayusculas, "hola")); // "HOLA"

// ── Callbacks ────────────────────────────────────────────────
// Un callback es una función que se pasa como argumento para ser llamada
// en un momento determinado (después de una operación, al ocurrir un evento, etc.)
console.log("\n=== Callbacks ===");

/**
 * Procesa un array usando una función callback para transformar cada elemento.
 * @param {Array} lista - Array de elementos
 * @param {Function} callback - Función a aplicar a cada elemento
 * @returns {Array} Nuevo array con los elementos transformados
 */
function transformarLista(lista, callback) {
  const resultado = [];
  for (const item of lista) {
    resultado.push(callback(item));
  }
  return resultado;
}

const numeros = [1, 2, 3, 4, 5];
console.log(transformarLista(numeros, x => x ** 2)); // [1, 4, 9, 16, 25]
console.log(transformarLista(["a", "b", "c"], s => s.toUpperCase())); // ['A','B','C']

// ── map, filter, reduce — los HOF más importantes de arrays ──
console.log("\n=== map / filter / reduce ===");

const productos = [
  { nombre: "Manzana", precio: 1.5, categoria: "fruta" },
  { nombre: "Leche",   precio: 2.0, categoria: "lácteo" },
  { nombre: "Pera",    precio: 1.8, categoria: "fruta" },
  { nombre: "Yogur",   precio: 1.2, categoria: "lácteo" },
];

// map: transforma cada elemento → retorna nuevo array del mismo tamaño
const nombres = productos.map(p => p.nombre);
console.log("map nombres:", nombres);

// filter: conserva elementos que cumplen la condición → retorna subconjunto
const frutas = productos.filter(p => p.categoria === "fruta");
console.log("filter frutas:", frutas.map(p => p.nombre));

// reduce: acumula todos los valores en uno solo
const totalPrecios = productos.reduce((acum, p) => acum + p.precio, 0);
console.log("reduce total:", totalPrecios.toFixed(2)); // 6.50

// Encadenamiento: obtener el precio total de las frutas
const totalFrutas = productos
  .filter(p => p.categoria === "fruta")  // 1. filtrar frutas
  .reduce((sum, p) => sum + p.precio, 0); // 2. sumar precios
console.log("Total frutas:", totalFrutas.toFixed(2)); // 3.30

// ── Crear nuestros propios HOF ────────────────────────────────
console.log("\n=== Crear HOF propios ===");

/**
 * Crea una función que repite la ejecución de otra función N veces.
 * @param {Function} fn - Función a repetir
 * @param {number} veces - Número de repeticiones
 * @returns {Function} Función que ejecuta fn N veces al ser llamada
 */
function repetir(fn, veces) {
  return function(...args) {
    for (let i = 0; i < veces; i++) fn(...args);
  };
}

const saludarTresVeces = repetir(nombre => console.log(`Hola, ${nombre}!`), 3);
saludarTresVeces("Mundo"); // Imprime "Hola, Mundo!" tres veces

/**
 * Memoiza una función: almacena resultados para evitar recálculos costosos.
 * @param {Function} fn - Función pura a memoizar
 * @returns {Function} Versión cacheada de la función
 */
function memoizar(fn) {
  const cache = new Map();
  return function(...args) {
    const clave = JSON.stringify(args);
    if (cache.has(clave)) return cache.get(clave);
    const resultado = fn(...args);
    cache.set(clave, resultado);
    return resultado;
  };
}

const fibMemo = memoizar(function fib(n) {
  if (n <= 1) return n;
  return fibMemo(n - 1) + fibMemo(n - 2); // usa la versión memoizada
});
console.log(fibMemo(40)); // rápido — sin memoización sería extremadamente lento

// ── Composición de funciones ──────────────────────────────────
// Combinar funciones pequeñas para crear comportamientos más complejos
// compose(f, g)(x) = f(g(x)) — primero g, luego f
console.log("\n=== Composición ===");

/**
 * Compone dos funciones: aplica g primero y luego f al resultado.
 * @param {Function} f - Segunda función a aplicar
 * @param {Function} g - Primera función a aplicar
 * @returns {Function} Función compuesta f(g(x))
 */
const compose = (f, g) => x => f(g(x));

const recortar = s => s.trim();
const capitalizar = s => s.charAt(0).toUpperCase() + s.slice(1);
const exclamar = s => `${s}!`;

// Pipeline: recortar → capitalizar → exclamar
const formatearMensaje = compose(exclamar, compose(capitalizar, recortar));
console.log(formatearMensaje("  hola mundo  ")); // "Hola mundo!"

// ── Currying básico ───────────────────────────────────────────
// Transformar una función de N argumentos en N funciones de 1 argumento
// Permite crear funciones especializadas a partir de funciones generales
console.log("\n=== Currying ===");

// Función normal con dos parámetros
const sumarNormal = (a, b) => a + b;

// Versión curried: retorna una función que espera el segundo argumento
const sumar = a => b => a + b;

console.log(sumar(3)(4)); // 7 — llamada completa

// Crear funciones especializadas parcialmente aplicadas
const sumar10 = sumar(10);  // función que suma 10 a cualquier número
const sumar100 = sumar(100);

console.log(sumar10(5));  // 15
console.log(sumar100(5)); // 105
console.log([1, 2, 3].map(sumar10)); // [11, 12, 13]

// Currying con más parámetros
const multiplicar = a => b => c => a * b * c;
console.log(multiplicar(2)(3)(4)); // 24

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Crea una función pipe() que componga N funciones de izquierda a derecha
// 2. Implementa tu propio map() y filter() usando reduce() como base
// 3. Crea una versión curried de una función de validación de email
// 4. Combina memoizar() con una función de cálculo costoso y mide el tiempo
