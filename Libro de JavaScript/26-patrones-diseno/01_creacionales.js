// =============================================================
// MÓDULO 26 — Patrones Creacionales
// Archivo: 01_creacionales.js
//
// Cómo crear objetos de forma flexible, controlada y reutilizable.
// =============================================================

// =============================================================
// PATRÓN 1 — SINGLETON
// Garantiza que una clase tenga UNA SOLA instancia en toda la app.
// Uso real: conexión a base de datos, configuración global, logger.
// =============================================================

/**
 * Gestor de configuración de la aplicación.
 * Solo puede existir una instancia — evita configuraciones inconsistentes.
 *
 * Uso:
 *   const config = ConfigManager.getInstance();
 *   config.set("tema", "oscuro");
 *   ConfigManager.getInstance().get("tema"); // "oscuro"
 */
class ConfigManager {
  /** @type {ConfigManager|null} Instancia única almacenada */
  static #instancia = null;

  /** @type {Map<string, any>} Almacén de configuraciones */
  #datos = new Map();

  // Constructor privado — no se puede usar `new ConfigManager()`
  constructor() {
    if (ConfigManager.#instancia) {
      throw new Error("Usa ConfigManager.getInstance()");
    }
  }

  /**
   * Retorna la instancia única, creándola si no existe.
   * @returns {ConfigManager}
   */
  static getInstance() {
    if (!ConfigManager.#instancia) {
      ConfigManager.#instancia = new ConfigManager();
    }
    return ConfigManager.#instancia;
  }

  /**
   * Almacena un valor de configuración.
   * @param {string} clave
   * @param {any} valor
   */
  set(clave, valor) {
    this.#datos.set(clave, valor);
  }

  /**
   * Obtiene un valor de configuración.
   * @param {string} clave
   * @returns {any}
   */
  get(clave) {
    return this.#datos.get(clave);
  }
}

// Demostración del Singleton
const config1 = ConfigManager.getInstance();
const config2 = ConfigManager.getInstance();

config1.set("idioma", "es");
console.log("Singleton — misma instancia:", config1 === config2); // true
console.log("Idioma desde config2:", config2.get("idioma")); // "es"

// =============================================================
// PATRÓN 2 — FACTORY
// Crea objetos sin exponer la clase concreta.
// El cliente pide "un animal de tipo X" sin saber cómo se construye.
// Uso real: crear instancias de servicios, conectores, parsers.
// =============================================================

/**
 * Clases de notificación concretas — el cliente no las usa directamente.
 */
class NotificacionEmail {
  constructor(destinatario) {
    this.tipo = "email";
    this.destinatario = destinatario;
  }
  /** Envía la notificación por email */
  enviar(mensaje) {
    return `[EMAIL → ${this.destinatario}] ${mensaje}`;
  }
}

class NotificacionSMS {
  constructor(telefono) {
    this.tipo = "sms";
    this.telefono = telefono;
  }
  /** Envía la notificación por SMS */
  enviar(mensaje) {
    return `[SMS → ${this.telefono}] ${mensaje}`;
  }
}

class NotificacionPush {
  constructor(token) {
    this.tipo = "push";
    this.token = token;
  }
  /** Envía notificación push al dispositivo */
  enviar(mensaje) {
    return `[PUSH → ${this.token}] ${mensaje}`;
  }
}

/**
 * Factory de notificaciones.
 * El cliente solo necesita saber el tipo y el destino.
 *
 * @param {"email"|"sms"|"push"} tipo
 * @param {string} destino - email, teléfono o token según el tipo
 * @returns {NotificacionEmail|NotificacionSMS|NotificacionPush}
 */
function crearNotificacion(tipo, destino) {
  const tipos = {
    email: NotificacionEmail,
    sms: NotificacionSMS,
    push: NotificacionPush,
  };
  const Clase = tipos[tipo];
  if (!Clase) throw new Error(`Tipo de notificación desconocido: ${tipo}`);
  return new Clase(destino);
}

// Demostración del Factory
const notif1 = crearNotificacion("email", "usuario@ejemplo.com");
const notif2 = crearNotificacion("sms", "+1234567890");

console.log("\nFactory:");
console.log(notif1.enviar("Tu pedido fue enviado"));
console.log(notif2.enviar("Código de verificación: 4829"));

// =============================================================
// PATRÓN 3 — BUILDER
// Construye objetos complejos paso a paso con una API fluida.
// Evita constructores con 10 parámetros opcionales.
// Uso real: construir queries SQL, peticiones HTTP, objetos de configuración.
// =============================================================

/**
 * Representa una petición HTTP configurada.
 * Se construye con PeticionHTTPBuilder.
 */
class PeticionHTTP {
  constructor(config) {
    this.url = config.url;
    this.metodo = config.metodo;
    this.headers = config.headers;
    this.cuerpo = config.cuerpo;
    this.timeout = config.timeout;
  }

  /** Muestra la configuración de la petición */
  toString() {
    return JSON.stringify(this, null, 2);
  }
}

/**
 * Builder para construir peticiones HTTP con una API fluida (chainable).
 * Cada método retorna `this` para permitir encadenamiento.
 *
 * Uso:
 *   const peticion = new PeticionHTTPBuilder()
 *     .url("https://api.ejemplo.com/datos")
 *     .metodo("POST")
 *     .header("Authorization", "Bearer token123")
 *     .body({ nombre: "Ana" })
 *     .construir();
 */
class PeticionHTTPBuilder {
  constructor() {
    // Valores por defecto
    this._url = "";
    this._metodo = "GET";
    this._headers = {};
    this._cuerpo = null;
    this._timeout = 5000;
  }

  /** @param {string} url */
  url(url) {
    this._url = url;
    return this; // retorna this para encadenamiento
  }

  /** @param {"GET"|"POST"|"PUT"|"DELETE"|"PATCH"} metodo */
  metodo(metodo) {
    this._metodo = metodo.toUpperCase();
    return this;
  }

  /**
   * Agrega un header a la petición.
   * @param {string} nombre
   * @param {string} valor
   */
  header(nombre, valor) {
    this._headers[nombre] = valor;
    return this;
  }

  /** @param {Object} datos - Cuerpo de la petición */
  body(datos) {
    this._cuerpo = datos;
    this._headers["Content-Type"] = "application/json";
    return this;
  }

  /** @param {number} ms - Timeout en milisegundos */
  timeout(ms) {
    this._timeout = ms;
    return this;
  }

  /**
   * Valida y construye el objeto PeticionHTTP final.
   * @returns {PeticionHTTP}
   */
  construir() {
    if (!this._url) throw new Error("La URL es obligatoria");
    return new PeticionHTTP({
      url: this._url,
      metodo: this._metodo,
      headers: this._headers,
      cuerpo: this._cuerpo,
      timeout: this._timeout,
    });
  }
}

// Demostración del Builder
const peticion = new PeticionHTTPBuilder()
  .url("https://api.ejemplo.com/usuarios")
  .metodo("POST")
  .header("Authorization", "Bearer abc123")
  .body({ nombre: "Carlos", email: "carlos@ejemplo.com" })
  .timeout(10000)
  .construir();

console.log("\nBuilder — PeticionHTTP:");
console.log(peticion.toString());
