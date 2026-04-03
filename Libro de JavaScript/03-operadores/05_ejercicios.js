// ============================================================
// ARCHIVO: 05_ejercicios.js
// TEMA: Ejercicios sobre operadores de comparación, lógicos y especiales
// CÓMO EJECUTAR: node 05_ejercicios.js
// ============================================================

// ── EJERCICIO 1 ───────────────────────────────────────────────
// Escribe una función que reciba dos valores y devuelva true si son
// estrictamente iguales, incluyendo el caso especial de NaN.
// Pista: usa Object.is()

console.log("=== Ejercicio 1: Igualdad con NaN ===");

/**
 * Compara dos valores con soporte para NaN y -0.
 * @param {*} a - Primer valor
 * @param {*} b - Segundo valor
 * @returns {boolean} true si son iguales (incluyendo NaN === NaN)
 */
function sonIguales(a, b) {
  // Object.is maneja NaN y -0 correctamente
  return Object.is(a, b);
}

console.log(sonIguales(1, 1));         // true
console.log(sonIguales(NaN, NaN));     // true  — caso especial
console.log(sonIguales(-0, 0));        // false — son distintos con Object.is
console.log(sonIguales("hola", "hola")); // true
console.log(sonIguales(null, undefined)); // false

// ── EJERCICIO 2 ───────────────────────────────────────────────
// Dado un objeto de configuración parcial, rellena los valores
// faltantes usando ?? (nullish coalescing) para respetar 0 y ""

console.log("\n=== Ejercicio 2: Configuración con ?? ===");

/**
 * Combina una configuración parcial con valores por defecto.
 * Respeta 0 y "" como valores válidos (usa ??, no ||).
 * @param {object} config - Configuración parcial del usuario
 * @returns {object} Configuración completa
 */
function configurar(config) {
  return {
    // ?? permite que 0 y "" sean valores válidos
    volumen: config.volumen ?? 50,
    tema: config.tema ?? "claro",
    idioma: config.idioma ?? "es",
    intentos: config.intentos ?? 3,
  };
}

console.log(configurar({ volumen: 0, tema: "" }));
// { volumen: 0, tema: "", idioma: "es", intentos: 3 }
// Nota: 0 y "" se respetan porque ?? solo falla con null/undefined

// ── EJERCICIO 3 ───────────────────────────────────────────────
// Ordena un array de ciudades con acentos y caracteres especiales
// correctamente usando localeCompare

console.log("\n=== Ejercicio 3: Ordenar ciudades con localeCompare ===");

/**
 * Ordena un array de strings respetando el idioma español.
 * @param {string[]} ciudades - Array de nombres de ciudades
 * @returns {string[]} Array ordenado correctamente
 */
function ordenarCiudades(ciudades) {
  // localeCompare con "es" garantiza orden correcto para español
  return [...ciudades].sort((a, b) => a.localeCompare(b, "es"));
}

const ciudades = ["Úbeda", "Ávila", "Córdoba", "Álava", "Barcelona", "Zaragoza"];
console.log("Sin localeCompare:", [...ciudades].sort());
console.log("Con localeCompare:", ordenarCiudades(ciudades));

// ── EJERCICIO 4 ───────────────────────────────────────────────
// Crea una función que acceda de forma segura a una propiedad
// profundamente anidada usando optional chaining y devuelva
// un valor por defecto si no existe

console.log("\n=== Ejercicio 4: Acceso seguro con ?. y ?? ===");

/**
 * Obtiene el avatar del usuario de forma segura.
 * @param {object|null|undefined} usuario - Objeto usuario (puede ser null)
 * @returns {string} URL del avatar o imagen por defecto
 */
function obtenerAvatar(usuario) {
  // ?. evita errores si usuario, perfil o imagen es null/undefined
  // ?? proporciona el valor por defecto
  return usuario?.perfil?.imagen?.url ?? "https://ejemplo.com/avatar-default.png";
}

const usuarioCompleto = {
  nombre: "Ana",
  perfil: { imagen: { url: "https://ejemplo.com/ana.jpg" } }
};
const usuarioParcial = { nombre: "Pedro", perfil: null };
const sinUsuario = null;

console.log(obtenerAvatar(usuarioCompleto)); // URL de Ana
console.log(obtenerAvatar(usuarioParcial));  // URL por defecto
console.log(obtenerAvatar(sinUsuario));      // URL por defecto

// ── EJERCICIO 5 ───────────────────────────────────────────────
// Crea una función que valide si un valor es de un tipo esperado
// usando typeof e instanceof

console.log("\n=== Ejercicio 5: Validación de tipos ===");

/**
 * Valida si un valor coincide con el tipo esperado.
 * Soporta tipos primitivos (typeof) y clases (instanceof).
 * @param {*} valor - Valor a validar
 * @param {string|Function} tipo - Tipo esperado como string o clase
 * @returns {boolean} true si el valor es del tipo esperado
 */
function esDelTipo(valor, tipo) {
  if (typeof tipo === "string") {
    // Caso especial: typeof null es "object", pero conceptualmente null no es objeto
    if (tipo === "null") return valor === null;
    if (tipo === "array") return Array.isArray(valor);
    return typeof valor === tipo;
  }
  // Si tipo es una clase/constructor, usamos instanceof
  return valor instanceof tipo;
}

console.log(esDelTipo(42, "number"));      // true
console.log(esDelTipo("hola", "string"));  // true
console.log(esDelTipo(null, "null"));      // true
console.log(esDelTipo([], "array"));       // true
console.log(esDelTipo([], "object"));      // false — es array, no "object" genérico
console.log(esDelTipo(new Date(), Date));  // true — instanceof

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Modifica ejercicio 2 para usar ||= en lugar de ?? y observa la diferencia
// 2. En ejercicio 3, agrega "ñoño" y "nube" al array y verifica el orden
// 3. En ejercicio 4, encadena tres niveles más de profundidad con ?.
// 4. Extiende ejercicio 5 para detectar NaN como tipo "nan"
