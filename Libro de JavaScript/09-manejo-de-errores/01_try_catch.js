// ============================================================
// ARCHIVO: 01_try_catch.js
// TEMA: try/catch/finally, tipos de error built-in, throw
// CÓMO EJECUTAR: node 01_try_catch.js
// ============================================================

// ── try / catch / finally ────────────────────────────────────
// try: bloque donde puede ocurrir un error
// catch: se ejecuta solo si ocurre un error en try — recibe el objeto Error
// finally: se ejecuta SIEMPRE, haya error o no (útil para limpiar recursos)
console.log("=== try / catch / finally ===");

try {
  const texto = null;
  console.log(texto.longitud); // TypeError: Cannot read properties of null
} catch (e) {
  console.log("Error capturado:", e.message);
} finally {
  console.log("finally siempre se ejecuta");
}

// ── Propiedades del objeto Error ─────────────────────────────
// e.name    → nombre del tipo de error ("TypeError", "RangeError", etc.)
// e.message → descripción legible del error
// e.stack   → traza completa de la pila de llamadas (útil para debug)
console.log("\n=== Propiedades del Error ===");

try {
  undefined.propiedad; // forzar un TypeError
} catch (e) {
  console.log("name:", e.name);          // "TypeError"
  console.log("message:", e.message);    // descripción del error
  // e.stack puede ser muy largo, mostramos solo la primera línea
  console.log("stack (primera línea):", e.stack.split("\n")[0]);
}

// ── Tipos de errores built-in ─────────────────────────────────
console.log("\n=== Tipos de errores ===");

// TypeError: operación en un valor del tipo incorrecto
try {
  null.toString();
} catch (e) {
  console.log(`[${e.name}] ${e.message}`);
}

// RangeError: valor numérico fuera de rango permitido
try {
  new Array(-1); // tamaño negativo no permitido
} catch (e) {
  console.log(`[${e.name}] ${e.message}`);
}

// ReferenceError: acceder a una variable que no existe
try {
  // eslint-disable-next-line no-undef
  console.log(variableQueNoExiste);
} catch (e) {
  console.log(`[${e.name}] ${e.message}`);
}

// SyntaxError: sintaxis inválida en JSON.parse o eval
try {
  JSON.parse("{ esto no es JSON válido }");
} catch (e) {
  console.log(`[${e.name}] ${e.message}`);
}

// URIError: URI malformada
try {
  decodeURIComponent("%"); // secuencia de escape incompleta
} catch (e) {
  console.log(`[${e.name}] ${e.message}`);
}

// ── throw: lanzar errores manualmente ────────────────────────
// Puedes lanzar cualquier valor, pero la práctica correcta es lanzar Error
console.log("\n=== throw ===");

/**
 * Divide dos números con validación.
 * @param {number} a - Dividendo
 * @param {number} b - Divisor
 * @returns {number} Resultado de la división
 * @throws {Error} Si el divisor es cero
 * @throws {TypeError} Si los argumentos no son números
 */
function dividir(a, b) {
  if (typeof a !== "number" || typeof b !== "number") {
    throw new TypeError("Ambos argumentos deben ser números");
  }
  if (b === 0) {
    throw new Error("No se puede dividir entre cero");
  }
  return a / b;
}

try {
  console.log(dividir(10, 2)); // 5
  console.log(dividir(10, 0)); // lanza Error
} catch (e) {
  console.log("Error en división:", e.message);
}

try {
  dividir("10", 2); // lanza TypeError
} catch (e) {
  console.log("TypeError:", e.message);
}

// throw con cualquier tipo de valor (no recomendado — dificulta el manejo)
try {
  throw "esto es un string como error"; // posible pero evitar
} catch (e) {
  // e es el string directamente, no tiene .message ni .stack
  console.log("Error como string:", e);
}

// ── finally: cuándo y cómo usarlo ────────────────────────────
// finally se ejecuta sin importar si hubo error o no
// Ideal para: cerrar archivos, liberar conexiones, limpiar estado temporal
console.log("\n=== finally ===");

function operacionConRecurso() {
  let recursoAbierto = false;
  try {
    recursoAbierto = true;
    console.log("Recurso abierto");
    // Simulamos un error en medio de la operación
    throw new Error("Fallo en operación");
  } catch (e) {
    console.log("Error manejado:", e.message);
  } finally {
    // Se ejecuta aunque catch re-lance el error o haya return en try/catch
    recursoAbierto = false;
    console.log("Recurso cerrado (finally)");
  }
}

operacionConRecurso();

// finally con return: el return en finally override cualquier otro return
function conReturnEnFinally() {
  try {
    return "desde try";
  } finally {
    return "desde finally"; // este return gana siempre
  }
}
console.log("Return en finally:", conReturnEnFinally()); // "desde finally"
// Nota: return en finally es válido pero confuso — evitar en producción

// ── Cuándo usar try/catch ─────────────────────────────────────
// NO en toda la app — solo en los límites del sistema:
// - Al parsear datos externos (JSON.parse, APIs)
// - Al acceder a recursos externos (archivos, red, base de datos)
// - En funciones que interactúan con el usuario
// Dentro de la lógica de negocio, preferir validación preventiva

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Coloca un return dentro del bloque try y observa que finally igual se ejecuta
// 2. Lanza un número como error (throw 42) y observa qué propiedades tiene
// 3. Crea una función parseJSON segura que retorne null en caso de error
// 4. Usa instanceof para manejar diferentes tipos de error de forma distinta
