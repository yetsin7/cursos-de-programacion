// ============================================================
// ARCHIVO: 04_otros_operadores.js
// TEMA: Spread, Rest, Destructuring, Ternario, in, instanceof, typeof, ?.
// CÓMO EJECUTAR: node 04_otros_operadores.js
// ============================================================

// ── Spread ... para copiar arrays y objetos ───────────────────
// Expande un iterable o un objeto en sus elementos individuales
console.log("=== Spread ===");

const frutas = ["manzana", "pera"];
const masFrutas = ["uva", ...frutas, "mango"];
console.log(masFrutas); // ['uva', 'manzana', 'pera', 'mango']

// Copiar un array (copia superficial)
const original = [1, 2, 3];
const copia = [...original];
copia.push(4);
console.log("original:", original); // [1, 2, 3] — no se modificó
console.log("copia:", copia);       // [1, 2, 3, 4]

// Spread en objetos
const persona = { nombre: "Luis", edad: 30 };
const personaConCiudad = { ...persona, ciudad: "Madrid" };
console.log(personaConCiudad); // { nombre: 'Luis', edad: 30, ciudad: 'Madrid' }

// Combinar objetos (la última propiedad gana si hay duplicados)
const base = { color: "rojo", tamaño: "M" };
const override = { color: "azul" };
const resultado = { ...base, ...override };
console.log(resultado); // { color: 'azul', tamaño: 'M' }

// ── Rest ... en parámetros ────────────────────────────────────
// Recoge todos los argumentos restantes en un array
// DEBE ser el último parámetro de la función
console.log("\n=== Rest en parámetros ===");

/**
 * Suma todos los números recibidos usando rest parameter.
 * @param {...number} nums - Números a sumar
 * @returns {number} Suma total
 */
function sumarTodo(...nums) {
  return nums.reduce((acc, n) => acc + n, 0);
}
console.log(sumarTodo(1, 2, 3, 4, 5)); // 15

// Rest captura solo los "restantes" después de parámetros definidos
function primeroYResto(primero, ...resto) {
  return { primero, resto };
}
console.log(primeroYResto("a", "b", "c", "d")); // { primero: 'a', resto: ['b','c','d'] }

// ── Destructuring en asignación ───────────────────────────────
console.log("\n=== Destructuring ===");

// Arrays: el orden importa
const [a, b, c] = [10, 20, 30];
console.log(a, b, c); // 10 20 30

// Saltar elementos con coma
const [primero, , tercero] = [1, 2, 3];
console.log(primero, tercero); // 1 3

// Valor por defecto si el elemento no existe
const [x = 0, y = 0, z = 99] = [5, 10];
console.log(x, y, z); // 5 10 99

// Objetos: el nombre de la variable debe coincidir con la clave
const { nombre, edad } = { nombre: "María", edad: 25, ciudad: "Bogotá" };
console.log(nombre, edad); // María 25

// Renombrar al desestructurar
const { nombre: nombrePersona, edad: añosVida } = { nombre: "Pedro", edad: 40 };
console.log(nombrePersona, añosVida); // Pedro 40

// ── Operador ternario ─────────────────────────────────────────
// condicion ? valorSiVerdadero : valorSiFalso
console.log("\n=== Ternario ===");

const puntos = 75;
const aprobado = puntos >= 60 ? "Aprobado" : "Reprobado";
console.log(aprobado); // Aprobado

// Ternario anidado (usar con moderación, reduce legibilidad)
const nivel = puntos >= 90 ? "A" : puntos >= 70 ? "B" : "C";
console.log(nivel); // B

// ── Operador in ───────────────────────────────────────────────
// Verifica si una propiedad existe en un objeto (incluye prototipo)
console.log("\n=== Operador in ===");

const coche = { marca: "Toyota", modelo: "Corolla" };
console.log("marca" in coche);   // true
console.log("color" in coche);   // false
console.log("toString" in coche); // true — viene del prototipo Object

// También funciona con arrays (verifica índices)
const arr = ["a", "b", "c"];
console.log(0 in arr);  // true  — índice 0 existe
console.log(5 in arr);  // false — índice 5 no existe

// ── Operador instanceof ───────────────────────────────────────
// Verifica si un objeto es instancia de una clase/constructor
console.log("\n=== instanceof ===");

console.log([] instanceof Array);   // true
console.log({} instanceof Object);  // true
console.log([] instanceof Object);  // true — Array hereda de Object

class Animal {}
class Perro extends Animal {}
const miPerro = new Perro();
console.log(miPerro instanceof Perro);  // true
console.log(miPerro instanceof Animal); // true — herencia

// ── typeof ───────────────────────────────────────────────────
// Devuelve el tipo del operando como string
console.log("\n=== typeof ===");

console.log(typeof 42);          // "number"
console.log(typeof "hola");      // "string"
console.log(typeof true);        // "boolean"
console.log(typeof undefined);   // "undefined"
console.log(typeof null);        // "object" — bug histórico de JS
console.log(typeof {});          // "object"
console.log(typeof []);          // "object" — los arrays son objetos
console.log(typeof function(){}); // "function"
console.log(typeof Symbol());    // "symbol"
console.log(typeof 42n);         // "bigint"

// Para detectar arrays, usa Array.isArray():
console.log(Array.isArray([]));  // true
console.log(Array.isArray({}));  // false

// ── Optional Chaining ?. ──────────────────────────────────────
// Accede a propiedades anidadas sin lanzar error si algún nodo es null/undefined
console.log("\n=== Optional Chaining ?. ===");

const usuario = {
  nombre: "Sara",
  direccion: {
    ciudad: "Lima"
  }
};

// Sin ?. lanzaría TypeError si 'perfil' no existe
console.log(usuario?.direccion?.ciudad);    // "Lima"
console.log(usuario?.perfil?.avatar);       // undefined — no lanza error

// ?. con métodos: verifica que el método exista antes de llamarlo
const obj = {
  saludar() { return "¡Hola!"; }
};
console.log(obj?.saludar?.());    // "¡Hola!"
console.log(obj?.despedir?.());   // undefined — método no existe, no error

// ?. con acceso dinámico a propiedades
const clave = "nombre";
console.log(usuario?.[clave]);    // "Sara"

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Usa spread para combinar dos arrays en uno nuevo sin modificar los originales
// 2. Desestructura un objeto con valores por defecto: const { tema = "claro" } = config
// 3. Prueba typeof null === "object" y reflexiona por qué es un bug histórico
// 4. Usa ?. para acceder a propiedades profundas de un objeto que puede ser null
