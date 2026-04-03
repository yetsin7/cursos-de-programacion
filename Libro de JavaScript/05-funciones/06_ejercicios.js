// ============================================================
// ARCHIVO: 06_ejercicios.js
// TEMA: Ejercicios sobre funciones con soluciones comentadas
// CÓMO EJECUTAR: node 06_ejercicios.js
// ============================================================

// ── EJERCICIO 1 ───────────────────────────────────────────────
// Implementa una función de memoización genérica y úsala para
// optimizar el cálculo de Fibonacci

console.log("=== Ejercicio 1: Memoización ===");

/**
 * Envuelve cualquier función pura en una capa de caché.
 * La primera llamada calcula el resultado; las siguientes lo devuelven desde el cache.
 * @param {Function} fn - Función pura a memoizar
 * @returns {Function} Función con caché incorporado
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

// Sin memoización, fib(40) recalcula millones de subproblemas
// Con memoización, cada subproblema se calcula una sola vez
const fib = memoizar(function fibonacci(n) {
  if (n <= 1) return n;
  return fib(n - 1) + fib(n - 2); // llama la versión memoizada
});

console.log(fib(10)); // 55
console.log(fib(40)); // 102334155 — rápido gracias al cache

// ── EJERCICIO 2 ───────────────────────────────────────────────
// Crea un generador de funciones validadoras usando currying y closures.
// validar(minLen, maxLen) retorna una función que valida strings.

console.log("\n=== Ejercicio 2: Validador currificado ===");

/**
 * Crea un validador de longitud de strings con currying.
 * @param {number} minLen - Longitud mínima permitida
 * @param {number} maxLen - Longitud máxima permitida
 * @returns {Function} Función validadora que recibe un string y retorna boolean
 */
const validarLongitud = (minLen, maxLen) => texto =>
  typeof texto === "string" && texto.length >= minLen && texto.length <= maxLen;

const validarNombre     = validarLongitud(2, 50);
const validarContrasena = validarLongitud(8, 128);
const validarPin        = validarLongitud(4, 4);

console.log(validarNombre("Ana"));          // true
console.log(validarNombre("A"));            // false — muy corto
console.log(validarContrasena("miPass123")); // true
console.log(validarContrasena("abc"));      // false — muy corto
console.log(validarPin("1234"));            // true
console.log(validarPin("12345"));           // false — demasiado largo

// ── EJERCICIO 3 ───────────────────────────────────────────────
// Implementa una función pipe() que encadene N funciones
// pipe(f, g, h)(x) = h(g(f(x))) — de izquierda a derecha

console.log("\n=== Ejercicio 3: pipe() ===");

/**
 * Compone N funciones de izquierda a derecha (pipeline).
 * Cada función recibe el resultado de la anterior.
 * @param {...Function} fns - Funciones a encadenar
 * @returns {Function} Función compuesta
 */
const pipe = (...fns) => x => fns.reduce((v, fn) => fn(v), x);

// Funciones de transformación simples
const recortar    = s => s.trim();
const capitalizar = s => s.charAt(0).toUpperCase() + s.slice(1).toLowerCase();
const agregarPunto = s => s.endsWith(".") ? s : `${s}.`;
const exclamar    = s => `¡${s}`;

// Pipeline: recortar → capitalizar → agregarPunto → exclamar
const formatearOracion = pipe(recortar, capitalizar, agregarPunto, exclamar);

console.log(formatearOracion("  hola mundo  ")); // "¡Hola mundo."
console.log(formatearOracion("  bienvenido a javascript  ")); // "¡Bienvenido a javascript."

// ── EJERCICIO 4 ───────────────────────────────────────────────
// Usando closures, crea un sistema de eventos simple (event emitter)
// con métodos: on(evento, callback), emit(evento, datos), off(evento, callback)

console.log("\n=== Ejercicio 4: Event Emitter simple ===");

/**
 * Crea un emisor de eventos simple.
 * Permite suscribirse a eventos, emitirlos y cancelar suscripciones.
 * @returns {{ on: Function, off: Function, emit: Function }}
 */
function crearEventEmitter() {
  // Mapa privado: nombre del evento → lista de listeners
  const listeners = new Map();

  return {
    /**
     * Suscribe un callback a un evento.
     * @param {string} evento - Nombre del evento
     * @param {Function} callback - Función a ejecutar cuando ocurra el evento
     */
    on(evento, callback) {
      if (!listeners.has(evento)) listeners.set(evento, []);
      listeners.get(evento).push(callback);
    },

    /**
     * Cancela la suscripción de un callback a un evento.
     * @param {string} evento - Nombre del evento
     * @param {Function} callback - Función a eliminar
     */
    off(evento, callback) {
      const cbs = listeners.get(evento) ?? [];
      listeners.set(evento, cbs.filter(cb => cb !== callback));
    },

    /**
     * Emite un evento notificando a todos los listeners suscritos.
     * @param {string} evento - Nombre del evento a emitir
     * @param {*} [datos] - Datos opcionales a pasar a los listeners
     */
    emit(evento, datos) {
      const cbs = listeners.get(evento) ?? [];
      cbs.forEach(cb => cb(datos));
    },
  };
}

const emitter = crearEventEmitter();

const onLogin = (usuario) => console.log(`Usuario conectado: ${usuario}`);
const onLogin2 = (usuario) => console.log(`Bienvenido, ${usuario}!`);

emitter.on("login", onLogin);
emitter.on("login", onLogin2);
emitter.emit("login", "Ana"); // ambos callbacks se ejecutan

emitter.off("login", onLogin); // cancelar primer listener
emitter.emit("login", "Pedro"); // solo onLogin2 se ejecuta

// ── EJERCICIO 5 ───────────────────────────────────────────────
// Implementa una función groupBy() que agrupe los elementos de un array
// según el resultado de una función clasificadora

console.log("\n=== Ejercicio 5: groupBy() ===");

/**
 * Agrupa los elementos de un array según el resultado de una función clave.
 * @template T
 * @param {T[]} array - Array a agrupar
 * @param {Function} obtenerClave - Función que determina el grupo de cada elemento
 * @returns {Object} Objeto con grupos como claves y arrays de elementos como valores
 */
function groupBy(array, obtenerClave) {
  return array.reduce((grupos, elemento) => {
    const clave = obtenerClave(elemento);
    // Si el grupo no existe, lo inicializa; luego agrega el elemento
    grupos[clave] = [...(grupos[clave] ?? []), elemento];
    return grupos;
  }, {});
}

const personas = [
  { nombre: "Ana",    edad: 25, ciudad: "Madrid" },
  { nombre: "Pedro",  edad: 30, ciudad: "Lima" },
  { nombre: "Lucía",  edad: 25, ciudad: "Madrid" },
  { nombre: "Carlos", edad: 30, ciudad: "Bogotá" },
  { nombre: "Sofía",  edad: 22, ciudad: "Lima" },
];

console.log("Agrupado por edad:", groupBy(personas, p => p.edad));
console.log("Agrupado por ciudad:", groupBy(personas, p => p.ciudad));

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Extiende el EventEmitter para soportar eventos que solo se ejecutan una vez (once)
// 2. Crea una versión async de pipe() que soporte funciones que retornan Promises
// 3. Agrega tiempo de expiración al memoizador: los resultados expiran después de N ms
// 4. Usa groupBy() con una función clave que clasifique números como "par" o "impar"
