// ============================================================
// ARCHIVO: 01_funciones_declaradas.js
// TEMA: Function declarations, expressions, hoisting, parámetros, return
// CÓMO EJECUTAR: node 01_funciones_declaradas.js
// ============================================================

// ── Function Declaration ──────────────────────────────────────
// Forma clásica. El nombre es obligatorio.
// Se puede llamar ANTES de su definición gracias al hoisting

console.log("=== Function Declaration ===");

/**
 * Calcula el cuadrado de un número.
 * @param {number} n - Número a elevar al cuadrado
 * @returns {number} El cuadrado del número
 */
function cuadrado(n) {
  return n * n;
}

console.log(cuadrado(5)); // 25

// ── Hoisting de declarations ──────────────────────────────────
// Las function declarations se "suben" al inicio del scope
// Esto permite llamarlas antes de declararlas (funcionamiento especial del motor JS)

console.log("\n=== Hoisting ===");
console.log(sumar(3, 4)); // 7 — funciona aunque la función está abajo

function sumar(a, b) {
  return a + b;
}

// ── Function Expression ───────────────────────────────────────
// La función se asigna a una variable
// NO se eleva (hoisting): solo la variable sube, no su valor

console.log("\n=== Function Expression ===");

// Esto lanzaría TypeError si se llamara antes de esta línea:
// console.log(restar(10, 3)); // ❌ TypeError: restar is not a function

const restar = function(a, b) {
  return a - b;
};

console.log(restar(10, 3)); // 7 — funciona porque se declaró antes

// Expression con nombre (útil para recursión y stack traces)
const factorial = function calcularFactorial(n) {
  if (n <= 1) return 1;
  return n * calcularFactorial(n - 1); // usa el nombre interno
};
console.log(factorial(5)); // 120

// ── Parámetros con valor por defecto ─────────────────────────
// Si el argumento no se pasa (o es undefined), se usa el valor por defecto
console.log("\n=== Parámetros con valor por defecto ===");

/**
 * Saluda a una persona con un idioma opcional.
 * @param {string} nombre - Nombre de la persona
 * @param {string} [idioma="es"] - Idioma del saludo (por defecto español)
 * @returns {string} Saludo formateado
 */
function saludar(nombre, idioma = "es") {
  const saludos = { es: "Hola", en: "Hello", fr: "Bonjour" };
  const saludo = saludos[idioma] ?? "Hola";
  return `${saludo}, ${nombre}!`;
}

console.log(saludar("Ana"));          // "Hola, Ana!"   — usa el default
console.log(saludar("Bob", "en"));    // "Hello, Bob!"
console.log(saludar("Marie", "fr"));  // "Bonjour, Marie!"

// Los valores por defecto pueden ser expresiones
function crearId(prefijo = "usr", timestamp = Date.now()) {
  return `${prefijo}_${timestamp}`;
}
console.log(crearId());          // algo como: "usr_1710000000000"
console.log(crearId("admin"));   // "admin_1710000000000"

// ── return ────────────────────────────────────────────────────
// Una función sin return (o con return vacío) devuelve undefined
console.log("\n=== return ===");

function sinReturn() {
  const x = 5; // hace algo pero no retorna
}
console.log(sinReturn()); // undefined

// return puede devolver cualquier tipo de valor
function obtenerConfig() {
  return { tema: "oscuro", idioma: "es", version: 2 }; // retorna un objeto
}
const config = obtenerConfig();
console.log(config.tema); // "oscuro"

// return termina la función inmediatamente (early return)
function dividir(a, b) {
  if (b === 0) return null; // salida temprana para evitar división por cero
  return a / b;
}
console.log(dividir(10, 2)); // 5
console.log(dividir(10, 0)); // null

// ── Funciones dentro de funciones ────────────────────────────
// Una función puede definir otras funciones internas (locales)
// Las funciones internas solo existen dentro de la función que las define
console.log("\n=== Funciones internas ===");

/**
 * Procesa una lista de números: filtra pares y devuelve sus cuadrados.
 * Usa funciones internas para organizar la lógica.
 * @param {number[]} nums - Array de números
 * @returns {number[]} Cuadrados de los números pares
 */
function procesarNumeros(nums) {
  // Función interna: solo accesible dentro de procesarNumeros
  function esPar(n) {
    return n % 2 === 0;
  }

  // Usa la función interna para filtrar
  return nums.filter(esPar).map(cuadrado); // cuadrado definida arriba
}

console.log(procesarNumeros([1, 2, 3, 4, 5, 6])); // [4, 16, 36]

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Intenta llamar una function expression antes de declararla y lee el error
// 2. Crea una función con un parámetro por defecto que dependa de otro parámetro
// 3. Escribe una función que retorne múltiples valores empaquetados en un objeto
// 4. Crea una función recursiva usando una function expression con nombre
