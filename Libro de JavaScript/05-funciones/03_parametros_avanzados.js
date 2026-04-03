// ============================================================
// ARCHIVO: 03_parametros_avanzados.js
// TEMA: Rest parameters, spread al llamar, destructuring en params, arguments
// CÓMO EJECUTAR: node 03_parametros_avanzados.js
// ============================================================

// ── Rest parameters ───────────────────────────────────────────
// Recoge todos los argumentos "restantes" en un array
// Debe ser el ÚLTIMO parámetro — solo puede haber uno
// Diferencia con 'arguments': rest es un Array real, arguments no
console.log("=== Rest parameters ===");

/**
 * Suma cualquier cantidad de números usando rest parameter.
 * @param {...number} nums - Números a sumar (cantidad ilimitada)
 * @returns {number} La suma de todos los argumentos
 */
function sumar(...nums) {
  // nums es un Array real — podemos usar todos los métodos de array
  return nums.reduce((total, n) => total + n, 0);
}

console.log(sumar(1, 2, 3));       // 6
console.log(sumar(10, 20, 30, 40)); // 100
console.log(sumar());              // 0 — array vacío

// Rest con parámetros previos definidos
/**
 * Registra un evento con su tipo y datos adicionales.
 * @param {string} tipo - Tipo de evento
 * @param {...*} datos - Información adicional del evento
 */
function registrarEvento(tipo, ...datos) {
  console.log(`Evento [${tipo}]:`, datos);
}

registrarEvento("clic", "botón", "header", { x: 10, y: 20 });
// Evento [clic]: ['botón', 'header', { x: 10, y: 20 }]

registrarEvento("error"); // datos = [] (array vacío)

// ── Spread al llamar funciones ────────────────────────────────
// Expande un array en argumentos individuales al llamar una función
console.log("\n=== Spread al llamar ===");

const valores = [3, 1, 4, 1, 5, 9, 2, 6];

// Math.max/min no aceptan un array directamente — necesita spread
console.log(Math.max(...valores)); // 9
console.log(Math.min(...valores)); // 1

// Sin spread necesitarías: Math.max.apply(null, valores) — forma antigua

// Spread para pasar array como argumentos individuales
function crearFecha(año, mes, dia) {
  return new Date(año, mes - 1, dia);
}
const partesFecha = [2024, 12, 25];
const navidad = crearFecha(...partesFecha);
console.log(navidad.toLocaleDateString("es")); // 25/12/2024

// Combinar con argumentos normales
function presentar(saludo, ...nombres) {
  return `${saludo}, ${nombres.join(" y ")}!`;
}
const participantes = ["Ana", "Carlos"];
console.log(presentar("Hola", ...participantes)); // "Hola, Ana y Carlos!"

// ── Destructuring en parámetros ───────────────────────────────
// Extrae valores directamente en la firma de la función
// Hace el código más expresivo y evita acceder a obj.propiedad dentro
console.log("\n=== Destructuring en parámetros ===");

// Destructuring de objeto en parámetro
/**
 * Formatea el nombre completo de una persona.
 * @param {{ nombre: string, apellido: string, edad?: number }} persona
 * @returns {string} Nombre formateado con edad opcional
 */
function formatearPersona({ nombre, apellido, edad = 18 }) {
  return `${nombre} ${apellido} (${edad} años)`;
}

console.log(formatearPersona({ nombre: "María", apellido: "García", edad: 28 }));
console.log(formatearPersona({ nombre: "Pedro", apellido: "López" })); // edad = 18 default

// Destructuring de array en parámetro
/**
 * Calcula la distancia entre dos puntos 2D.
 * @param {[number, number]} puntoA - Coordenadas [x, y] del punto A
 * @param {[number, number]} puntoB - Coordenadas [x, y] del punto B
 * @returns {number} Distancia euclidiana entre los puntos
 */
function distancia([x1, y1], [x2, y2]) {
  return Math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2);
}

console.log(distancia([0, 0], [3, 4])); // 5 (triángulo 3-4-5)

// Destructuring anidado
/**
 * Extrae el nombre de la ciudad de una configuración de usuario.
 * @param {{ usuario: { nombre: string, ubicacion: { ciudad: string } } }} config
 */
function mostrarCiudad({ usuario: { nombre, ubicacion: { ciudad } } }) {
  console.log(`${nombre} vive en ${ciudad}`);
}

mostrarCiudad({
  usuario: { nombre: "Sofía", ubicacion: { ciudad: "Buenos Aires" } }
});

// ── El objeto 'arguments' (solo en funciones normales) ────────
// 'arguments' es un objeto similar a un array disponible en funciones normales
// EVITAR en código moderno — usar rest parameters en su lugar
console.log("\n=== arguments (evitar — usar rest) ===");

function sumarAntiguo() {
  // arguments NO es un Array real — no tiene map, filter, etc.
  let total = 0;
  for (let i = 0; i < arguments.length; i++) {
    total += arguments[i];
  }
  return total;
}

console.log(sumarAntiguo(1, 2, 3)); // 6 — funciona pero es código legado

// Las arrow functions NO tienen 'arguments'
const arrowSinArguments = () => {
  // console.log(arguments); // ❌ ReferenceError en módulos / undefined en otros contextos
  return "las arrows no tienen arguments";
};
console.log(arrowSinArguments());

// Razón para evitar 'arguments': usa rest parameters que son claros y modernos
function sumarModerno(...nums) {
  return nums.reduce((t, n) => t + n, 0); // nums es Array real
}
console.log(sumarModerno(1, 2, 3)); // 6 — equivalente, mejor código

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Crea una función con rest que calcule la media aritmética de N números
// 2. Usa spread para combinar tres arrays en una llamada a función
// 3. Desestructura un objeto con valor por defecto en un parámetro
// 4. Compara 'arguments' y rest: convierte arguments a array con Array.from()
