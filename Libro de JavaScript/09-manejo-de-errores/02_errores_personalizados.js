// ============================================================
// ARCHIVO: 02_errores_personalizados.js
// TEMA: Extender Error, jerarquía de errores, Result pattern
// CÓMO EJECUTAR: node 02_errores_personalizados.js
// ============================================================

// ── Extender Error para errores personalizados ───────────────
// Crear clases de error propias permite:
// 1. Agregar propiedades adicionales (código, contexto, etc.)
// 2. Identificar el tipo con instanceof
// 3. Separar errores de negocio de errores técnicos
console.log("=== Error personalizado básico ===");

/**
 * Error base de la aplicación.
 * Todas las clases de error del sistema deben extender esta.
 */
class AppError extends Error {
  /**
   * @param {string} mensaje - Descripción del error
   * @param {string} codigo - Código identificador del error (ej: "AUTH_FAILED")
   */
  constructor(mensaje, codigo) {
    super(mensaje);          // llama al constructor de Error con el mensaje
    this.name = "AppError"; // sobreescribe el nombre por defecto ("Error")
    this.codigo = codigo;
    // Necesario para que instanceof funcione correctamente al extender Error
    Object.setPrototypeOf(this, new.target.prototype);
  }
}

const error = new AppError("Operación no permitida", "FORBIDDEN");
console.log(error.name);    // "AppError"
console.log(error.message); // "Operación no permitida"
console.log(error.codigo);  // "FORBIDDEN"
console.log(error instanceof AppError); // true
console.log(error instanceof Error);    // true — hereda de Error

// ── Jerarquía de errores ──────────────────────────────────────
// Crear subclases específicas para diferentes categorías de errores
// Permite manejar cada tipo de forma distinta en el catch

/**
 * Error de red o comunicación con servicios externos.
 */
class NetworkError extends AppError {
  /**
   * @param {string} mensaje - Descripción del error
   * @param {number} statusCode - Código HTTP de la respuesta
   */
  constructor(mensaje, statusCode) {
    super(mensaje, "NETWORK_ERROR");
    this.name = "NetworkError";
    this.statusCode = statusCode;
    Object.setPrototypeOf(this, new.target.prototype);
  }
}

/**
 * Error de validación de datos de entrada.
 */
class ValidationError extends AppError {
  /**
   * @param {string} mensaje - Descripción del error
   * @param {string} campo - Campo que no pasó la validación
   */
  constructor(mensaje, campo) {
    super(mensaje, "VALIDATION_ERROR");
    this.name = "ValidationError";
    this.campo = campo;
    Object.setPrototypeOf(this, new.target.prototype);
  }
}

/**
 * Error cuando un recurso no se encuentra.
 */
class NotFoundError extends AppError {
  /**
   * @param {string} recurso - Nombre del recurso no encontrado
   * @param {string|number} id - Identificador buscado
   */
  constructor(recurso, id) {
    super(`${recurso} con id "${id}" no encontrado`, "NOT_FOUND");
    this.name = "NotFoundError";
    this.recurso = recurso;
    this.id = id;
    Object.setPrototypeOf(this, new.target.prototype);
  }
}

// ── Uso con instanceof para manejar errores específicamente ──
console.log("\n=== Manejo con instanceof ===");

/**
 * Simula la obtención de un usuario por ID.
 * @param {number} id - ID del usuario
 * @returns {object} Datos del usuario
 * @throws {ValidationError} Si el ID no es válido
 * @throws {NotFoundError} Si el usuario no existe
 */
function obtenerUsuario(id) {
  if (typeof id !== "number" || id <= 0) {
    throw new ValidationError("El ID debe ser un número positivo", "id");
  }
  if (id > 100) {
    throw new NotFoundError("Usuario", id);
  }
  return { id, nombre: `Usuario_${id}`, activo: true };
}

function manejarPeticion(id) {
  try {
    const usuario = obtenerUsuario(id);
    console.log("Usuario encontrado:", usuario.nombre);
  } catch (e) {
    if (e instanceof ValidationError) {
      // Error de validación → informar al usuario qué campo falló
      console.log(`Validación fallida en campo '${e.campo}': ${e.message}`);
    } else if (e instanceof NotFoundError) {
      // Recurso no encontrado → respuesta 404
      console.log(`No encontrado: ${e.message}`);
    } else if (e instanceof NetworkError) {
      // Error de red → reintentar o mostrar error de conexión
      console.log(`Error de red (${e.statusCode}): ${e.message}`);
    } else {
      // Error inesperado → registrar y notificar
      console.log("Error inesperado:", e.message);
      throw e; // re-lanzar errores que no sabemos manejar
    }
  }
}

manejarPeticion(5);    // usuario encontrado
manejarPeticion(-1);   // error de validación
manejarPeticion(999);  // not found

// ── Result pattern: alternativa sin excepciones ───────────────
// En lugar de lanzar excepciones, las funciones retornan un objeto
// con dos formas: { data: valor, error: null } o { data: null, error: Error }
// Ventaja: el flujo es explícito — el llamador DEBE manejar ambos casos
console.log("\n=== Result pattern ===");

/**
 * Parsea JSON de forma segura sin lanzar excepciones.
 * @param {string} texto - String JSON a parsear
 * @returns {{ data: any, error: null } | { data: null, error: Error }}
 */
function parsearJSON(texto) {
  try {
    const data = JSON.parse(texto);
    return { data, error: null };
  } catch (e) {
    return { data: null, error: e };
  }
}

const { data: config, error: errorConfig } = parsearJSON('{"tema":"oscuro"}');
if (errorConfig) {
  console.log("Error al parsear:", errorConfig.message);
} else {
  console.log("Config parseada:", config);
}

const { data: invalido, error: errorInvalido } = parsearJSON("{ no es json }");
if (errorInvalido) {
  console.log("Error esperado:", errorInvalido.message);
}

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Crea un AuthError que extienda AppError con campos 'usuario' y 'intentos'
// 2. Implementa una función que capture cualquier AppError pero re-lance los demás
// 3. Convierte obtenerUsuario() para usar el Result pattern en lugar de throw
// 4. Crea una jerarquía de 3 niveles: AppError → DatabaseError → ConnectionError
