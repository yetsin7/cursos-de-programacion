// ============================================================
// ARCHIVO: 03_ejercicios.js
// TEMA: Ejercicios de manejo de errores con soluciones
// CÓMO EJECUTAR: node 03_ejercicios.js
// ============================================================

// ── EJERCICIO 1 ───────────────────────────────────────────────
// Implementa una función fetchJSON segura que:
// 1. Intente parsear un string JSON
// 2. Valide que el resultado sea un objeto (no null, array u otro tipo)
// 3. Retorne el Result pattern: { data, error }

console.log("=== Ejercicio 1: fetchJSON seguro ===");

/**
 * Parsea un string JSON de forma segura con validación de tipo.
 * Retorna un Result pattern en lugar de lanzar excepciones.
 * @param {string} texto - String JSON a parsear
 * @returns {{ data: object, error: null } | { data: null, error: Error }}
 */
function fetchJSON(texto) {
  try {
    // Intentar parsear — puede lanzar SyntaxError
    const parsed = JSON.parse(texto);

    // Validar que sea un objeto simple (no null ni array)
    if (parsed === null || typeof parsed !== "object" || Array.isArray(parsed)) {
      return {
        data: null,
        error: new TypeError("Se esperaba un objeto JSON, no un valor primitivo ni array"),
      };
    }

    return { data: parsed, error: null };
  } catch (e) {
    // JSON inválido
    return { data: null, error: e };
  }
}

// Casos de prueba
const casos = [
  '{"nombre":"Ana","edad":25}',    // válido
  "[ 1, 2, 3 ]",                   // array — no permitido
  "null",                          // null — no permitido
  '"solo un string"',              // primitivo — no permitido
  "{ esto no es JSON }",           // JSON inválido
];

casos.forEach(caso => {
  const { data, error } = fetchJSON(caso);
  if (error) {
    console.log(`Error [${error.name}]: ${error.message}`);
  } else {
    console.log("Parseado:", data);
  }
});

// ── EJERCICIO 2 ───────────────────────────────────────────────
// Implementa una función reintentar() que ejecute una operación
// que puede fallar hasta N veces antes de rendirse.
// Si la operación tiene éxito, retorna el resultado.
// Si falla todas las veces, lanza el último error.

console.log("\n=== Ejercicio 2: Función reintentar ===");

/**
 * Ejecuta una función hasta N veces hasta que tenga éxito.
 * @param {Function} operacion - Función a ejecutar (puede lanzar errores)
 * @param {number} maxIntentos - Número máximo de intentos
 * @returns {*} Resultado de la operación si tiene éxito
 * @throws {Error} El último error si todos los intentos fallan
 */
function reintentar(operacion, maxIntentos) {
  let ultimoError;
  for (let intento = 1; intento <= maxIntentos; intento++) {
    try {
      const resultado = operacion();
      console.log(`Éxito en el intento ${intento}`);
      return resultado;
    } catch (e) {
      ultimoError = e;
      console.log(`Intento ${intento} fallido: ${e.message}`);
    }
  }
  throw ultimoError; // todos los intentos fallaron
}

// Simular operación que falla las primeras veces y luego tiene éxito
let contador = 0;
function operacionInestable() {
  contador++;
  if (contador < 3) throw new Error(`Fallo temporal (intento ${contador})`);
  return `Resultado exitoso en intento ${contador}`;
}

try {
  const resultado = reintentar(operacionInestable, 5);
  console.log("Resultado final:", resultado);
} catch (e) {
  console.log("Todos los intentos fallaron:", e.message);
}

// Simular operación que siempre falla (agota los intentos)
function siempreFalla() {
  throw new Error("Error permanente");
}

try {
  reintentar(siempreFalla, 3);
} catch (e) {
  console.log("Agotados los intentos — último error:", e.message);
}

// ── EJERCICIO 3 ───────────────────────────────────────────────
// Crea una clase FormValidator que valide campos usando
// errores personalizados. Debe acumular TODOS los errores
// antes de lanzarlos juntos (en lugar de parar en el primero).

console.log("\n=== Ejercicio 3: FormValidator con errores acumulados ===");

/**
 * Error de validación de formulario con múltiples campos.
 * Contiene todos los errores encontrados en una sola validación.
 */
class FormValidationError extends Error {
  /**
   * @param {Array<{campo: string, mensaje: string}>} errores - Lista de errores
   */
  constructor(errores) {
    super(`Validación fallida: ${errores.length} error(es)`);
    this.name = "FormValidationError";
    this.errores = errores;
    Object.setPrototypeOf(this, new.target.prototype);
  }
}

/**
 * Valida los campos de un formulario de registro.
 * Acumula todos los errores antes de lanzarlos.
 * @param {{ nombre: string, email: string, contrasena: string }} campos
 * @throws {FormValidationError} Si algún campo es inválido
 */
function validarFormulario({ nombre, email, contrasena }) {
  const errores = [];

  // Validar nombre
  if (!nombre || nombre.trim().length < 2) {
    errores.push({ campo: "nombre", mensaje: "El nombre debe tener al menos 2 caracteres" });
  }

  // Validar email
  if (!email || !email.includes("@") || !email.includes(".")) {
    errores.push({ campo: "email", mensaje: "El email no tiene un formato válido" });
  }

  // Validar contraseña
  if (!contrasena || contrasena.length < 8) {
    errores.push({ campo: "contrasena", mensaje: "La contraseña debe tener al menos 8 caracteres" });
  }
  if (!/\d/.test(contrasena ?? "")) {
    errores.push({ campo: "contrasena", mensaje: "La contraseña debe contener al menos un número" });
  }

  // Lanzar todos los errores juntos si hay alguno
  if (errores.length > 0) throw new FormValidationError(errores);
}

// Formulario con múltiples errores
try {
  validarFormulario({ nombre: "A", email: "correo-sin-arroba", contrasena: "abc" });
} catch (e) {
  if (e instanceof FormValidationError) {
    console.log(e.message);
    e.errores.forEach(({ campo, mensaje }) => {
      console.log(`  [${campo}]: ${mensaje}`);
    });
  }
}

// Formulario válido
try {
  validarFormulario({ nombre: "Ana López", email: "ana@ejemplo.com", contrasena: "MiPass123" });
  console.log("Formulario válido — sin errores");
} catch (e) {
  console.log("Error inesperado:", e.message);
}

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Agrega a reintentar() un delay entre intentos usando async/await
// 2. Extiende FormValidationError para incluir sugerencias de corrección
// 3. Agrega a fetchJSON una validación de campos obligatorios usando Result pattern
// 4. Crea un wrapper que convierta funciones que lanzan errores en funciones Result
