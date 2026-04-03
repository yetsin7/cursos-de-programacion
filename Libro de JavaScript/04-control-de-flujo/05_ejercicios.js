// ============================================================
// ARCHIVO: 05_ejercicios.js
// TEMA: Ejercicios de control de flujo con soluciones
// CÓMO EJECUTAR: node 05_ejercicios.js
// ============================================================

// ── EJERCICIO 1 ───────────────────────────────────────────────
// Clasifica una lista de temperaturas como "fría", "templada" o "caliente"
// Frío: < 10 | Templado: 10–25 | Caliente: > 25

console.log("=== Ejercicio 1: Clasificar temperaturas ===");

/**
 * Clasifica una temperatura en frío, templado o caliente.
 * @param {number} temp - Temperatura en grados Celsius
 * @returns {string} Clasificación de la temperatura
 */
function clasificarTemperatura(temp) {
  if (temp < 10) return "fría";
  if (temp <= 25) return "templada";
  return "caliente";
}

const temperaturas = [-5, 8, 15, 22, 25, 30, 38];
temperaturas.forEach(t => {
  console.log(`${t}°C → ${clasificarTemperatura(t)}`);
});

// ── EJERCICIO 2 ───────────────────────────────────────────────
// Encuentra todos los números primos entre 2 y 50

console.log("\n=== Ejercicio 2: Números primos entre 2 y 50 ===");

/**
 * Verifica si un número es primo.
 * Un número primo solo es divisible por 1 y por sí mismo.
 * @param {number} n - Número a verificar
 * @returns {boolean} true si es primo
 */
function esPrimo(n) {
  if (n < 2) return false;
  // Solo necesitamos verificar hasta la raíz cuadrada
  for (let i = 2; i <= Math.sqrt(n); i++) {
    if (n % i === 0) return false; // divisible → no es primo
  }
  return true;
}

const primos = [];
for (let num = 2; num <= 50; num++) {
  if (esPrimo(num)) primos.push(num);
}
console.log("Primos:", primos.join(", "));

// ── EJERCICIO 3 ───────────────────────────────────────────────
// Dado un array de palabras, construye un objeto que cuente
// cuántas veces aparece cada palabra (frecuencia de palabras)

console.log("\n=== Ejercicio 3: Frecuencia de palabras ===");

/**
 * Cuenta la frecuencia de cada palabra en un array.
 * @param {string[]} palabras - Array de palabras
 * @returns {Object} Objeto con cada palabra y su frecuencia
 */
function contarFrecuencia(palabras) {
  const frecuencia = {};
  for (const palabra of palabras) {
    // Si la palabra ya existe, suma 1; si no, inicializa en 1
    frecuencia[palabra] = (frecuencia[palabra] ?? 0) + 1;
  }
  return frecuencia;
}

const texto = ["hola", "mundo", "hola", "JavaScript", "mundo", "hola"];
console.log(contarFrecuencia(texto));
// { hola: 3, mundo: 2, JavaScript: 1 }

// ── EJERCICIO 4 ───────────────────────────────────────────────
// Aplana (flatten) un array de arrays con un solo nivel de profundidad
// Entrada: [[1,2],[3,4],[5]] → Salida: [1,2,3,4,5]
// No usar Array.flat() — implementarlo manualmente con bucles

console.log("\n=== Ejercicio 4: Aplanar array de arrays ===");

/**
 * Aplana un array de arrays (un nivel de profundidad).
 * @param {Array[]} matriz - Array que contiene otros arrays
 * @returns {Array} Array aplanado con todos los elementos
 */
function aplanar(matriz) {
  const resultado = [];
  for (const subArray of matriz) {
    for (const elemento of subArray) {
      resultado.push(elemento);
    }
  }
  return resultado;
}

console.log(aplanar([[1, 2], [3, 4], [5]]));      // [1, 2, 3, 4, 5]
console.log(aplanar([["a", "b"], ["c"], ["d", "e"]])); // ['a','b','c','d','e']

// ── EJERCICIO 5 ───────────────────────────────────────────────
// Implementa FizzBuzz: para números del 1 al 30
// Múltiplo de 3 → "Fizz"
// Múltiplo de 5 → "Buzz"
// Múltiplo de ambos → "FizzBuzz"
// Resto → el número mismo

console.log("\n=== Ejercicio 5: FizzBuzz ===");

/**
 * Genera la secuencia FizzBuzz del 1 al límite dado.
 * @param {number} limite - Número hasta el que generar la secuencia
 * @returns {Array} Array con la secuencia FizzBuzz
 */
function fizzBuzz(limite) {
  const resultado = [];
  for (let n = 1; n <= limite; n++) {
    // Importante: verificar ambos primero antes de verificar individualmente
    if (n % 15 === 0) {
      resultado.push("FizzBuzz");
    } else if (n % 3 === 0) {
      resultado.push("Fizz");
    } else if (n % 5 === 0) {
      resultado.push("Buzz");
    } else {
      resultado.push(n);
    }
  }
  return resultado;
}

console.log(fizzBuzz(30).join(", "));

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Modifica esPrimo() para usar while en lugar de for
// 2. Reescribe contarFrecuencia() usando reduce() de arrays
// 3. Extiende FizzBuzz para incluir "Jazz" en múltiplos de 7
// 4. Implementa aplanar() de forma recursiva para múltiples niveles de profundidad
