// =============================================================
// MÓDULO 26 — Patrones Estructurales
// Archivo: 02_estructurales.js
//
// Cómo componer clases y objetos para formar estructuras más grandes.
// =============================================================

// =============================================================
// PATRÓN 1 — MODULE PATTERN
// Encapsula código en un scope privado usando closures.
// Era la solución antes de que existieran ESModules y clases.
// Todavía útil en scripts que no usan un bundler.
// =============================================================

/**
 * Módulo de carrito de compras usando el Module Pattern.
 * Los datos internos son privados — solo se expone lo necesario.
 *
 * @returns {Object} API pública del carrito
 */
const carrito = (() => {
  // Variable privada — no accesible desde fuera
  const _items = [];
  let _descuento = 0;

  /**
   * Calcula el total sin descuento (función privada).
   * @returns {number}
   */
  function _calcularSubtotal() {
    return _items.reduce((acc, item) => acc + item.precio * item.cantidad, 0);
  }

  // API pública — solo esto es visible desde fuera
  return {
    /**
     * Agrega un producto al carrito.
     * @param {string} nombre
     * @param {number} precio
     * @param {number} [cantidad=1]
     */
    agregar(nombre, precio, cantidad = 1) {
      _items.push({ nombre, precio, cantidad });
    },

    /**
     * Aplica un descuento porcentual al total.
     * @param {number} porcentaje - número entre 0 y 100
     */
    aplicarDescuento(porcentaje) {
      _descuento = Math.min(100, Math.max(0, porcentaje));
    },

    /**
     * Calcula el total con descuento aplicado.
     * @returns {number}
     */
    total() {
      const subtotal = _calcularSubtotal();
      return subtotal * (1 - _descuento / 100);
    },

    /** @returns {number} Cantidad de ítems en el carrito */
    get cantidad() {
      return _items.length;
    },
  };
})();

// Demostración del Module Pattern
carrito.agregar("Laptop", 1200, 1);
carrito.agregar("Mouse", 35, 2);
carrito.aplicarDescuento(10);
console.log("Module Pattern — Carrito:");
console.log(`Total: $${carrito.total()}`); // $1143

// =============================================================
// PATRÓN 2 — DECORATOR
// Agrega comportamiento a un objeto SIN modificar su clase original.
// Alternativa a la herencia cuando quieres composición.
// Uso real: logging, validación, caché sobre funciones/clases existentes.
// =============================================================

/**
 * Servicio base de almacenamiento en memoria.
 * Solo hace su trabajo principal sin adornos.
 */
class AlmacenamientoBase {
  constructor() {
    this._datos = new Map();
  }

  /** Guarda un valor */
  guardar(clave, valor) {
    this._datos.set(clave, valor);
    return valor;
  }

  /** Obtiene un valor */
  obtener(clave) {
    return this._datos.get(clave) ?? null;
  }
}

/**
 * Decorador que agrega logging al almacenamiento.
 * Envuelve el servicio original sin modificarlo.
 *
 * @param {AlmacenamientoBase} almacenamiento - servicio a decorar
 * @returns {Object} Servicio con logging
 */
function conLogging(almacenamiento) {
  return {
    guardar(clave, valor) {
      console.log(`[LOG] Guardando: ${clave} =`, valor);
      return almacenamiento.guardar(clave, valor);
    },
    obtener(clave) {
      const valor = almacenamiento.obtener(clave);
      console.log(`[LOG] Obteniendo: ${clave} =`, valor);
      return valor;
    },
  };
}

/**
 * Decorador que agrega caché al almacenamiento.
 * Si el valor ya está en caché, no consulta el almacenamiento real.
 *
 * @param {Object} almacenamiento
 * @returns {Object}
 */
function conCache(almacenamiento) {
  const cache = new Map();
  return {
    guardar(clave, valor) {
      cache.set(clave, valor);
      return almacenamiento.guardar(clave, valor);
    },
    obtener(clave) {
      if (cache.has(clave)) return cache.get(clave); // desde caché
      return almacenamiento.obtener(clave);
    },
  };
}

// Se pueden encadenar decoradores (composición)
const almacen = conLogging(conCache(new AlmacenamientoBase()));
almacen.guardar("usuario", { nombre: "Ana" });
almacen.obtener("usuario");

// =============================================================
// PATRÓN 3 — PROXY
// Intercepta operaciones sobre un objeto para agregar lógica.
// JavaScript tiene soporte nativo con la clase Proxy.
// Usado en: Vue 3 (reactividad), MobX, validación de datos.
// =============================================================

/**
 * Crea un proxy de validación para un objeto de configuración.
 * Rechaza valores de tipo incorrecto antes de asignarlos.
 *
 * @param {Object} objetivo - objeto original a proteger
 * @returns {Proxy}
 */
function crearConfigSegura(objetivo) {
  return new Proxy(objetivo, {
    /**
     * Intercepta las asignaciones de propiedades.
     * @param {Object} obj
     * @param {string} prop
     * @param {any} valor
     */
    set(obj, prop, valor) {
      if (prop === "puerto" && typeof valor !== "number") {
        throw new TypeError(`"puerto" debe ser un número, recibido: ${typeof valor}`);
      }
      if (prop === "host" && typeof valor !== "string") {
        throw new TypeError(`"host" debe ser un string`);
      }
      obj[prop] = valor;
      return true; // obligatorio en traps set
    },

    /**
     * Intercepta los accesos de lectura para logging.
     * @param {Object} obj
     * @param {string} prop
     */
    get(obj, prop) {
      if (!(prop in obj)) {
        console.warn(`[Proxy] Propiedad "${prop}" no existe en la configuración`);
        return undefined;
      }
      return obj[prop];
    },
  });
}

const dbConfig = crearConfigSegura({ host: "localhost", puerto: 5432 });
console.log("\nProxy — configuración segura:");
console.log(dbConfig.host); // "localhost"
dbConfig.puerto = 3306;     // válido
try {
  dbConfig.puerto = "3306"; // lanza TypeError
} catch (e) {
  console.log("Error esperado:", e.message);
}

// =============================================================
// PATRÓN 4 — ADAPTER
// Convierte la interfaz de una clase en otra que el cliente espera.
// Uso real: integrar librerías de terceros con tu arquitectura.
// =============================================================

/**
 * API de pagos antigua (legado) con una interfaz diferente.
 * No podemos modificarla — viene de una librería externa.
 */
class PasarelaLegacy {
  /** @param {number} amount - en centavos */
  processPayment(amount, cardNumber) {
    return { success: true, transactionId: "TXN-" + Date.now(), amount };
  }
}

/**
 * Adapter que convierte la API legada a la interfaz moderna.
 * Tu código solo usa la interfaz moderna — el adapter hace la traducción.
 *
 * Interfaz moderna esperada por el resto de la app:
 *   cobrar({ monto, tarjeta }) → { ok, id, monto }
 */
class AdaptadorPago {
  /**
   * @param {PasarelaLegacy} pasarela - servicio legado a adaptar
   */
  constructor(pasarela) {
    this._pasarela = pasarela;
  }

  /**
   * Procesa un pago usando la interfaz moderna.
   * Internamente traduce al formato del sistema legado.
   *
   * @param {Object} opciones
   * @param {number} opciones.monto - en pesos/dólares (no centavos)
   * @param {string} opciones.tarjeta
   * @returns {{ ok: boolean, id: string, monto: number }}
   */
  cobrar({ monto, tarjeta }) {
    const montoEnCentavos = Math.round(monto * 100);
    const resultado = this._pasarela.processPayment(montoEnCentavos, tarjeta);
    return {
      ok: resultado.success,
      id: resultado.transactionId,
      monto,
    };
  }
}

// El resto de la app solo conoce al adapter — no sabe que hay un sistema legado
const pago = new AdaptadorPago(new PasarelaLegacy());
const resultado = pago.cobrar({ monto: 49.99, tarjeta: "4111111111111111" });
console.log("\nAdapter — resultado del pago:");
console.log(resultado);
