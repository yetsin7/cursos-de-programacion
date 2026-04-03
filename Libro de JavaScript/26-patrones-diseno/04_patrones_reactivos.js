// =============================================================
// MÓDULO 26 — Patrones Reactivos
// Archivo: 04_patrones_reactivos.js
//
// Patrones para gestión de estado y flujo de datos en aplicaciones
// modernas. Base conceptual de Redux, XState, MobX y similares.
// =============================================================

// =============================================================
// PATRÓN 1 — PUB/SUB (Publicar/Suscribir)
// Diferencia con Observer: el publisher y el subscriber NO se conocen.
// Se comunican a través de un canal centralizado (el "bus de eventos").
// Uso real: comunicación entre módulos desacoplados, React context,
// arquitecturas de microservicios en el frontend.
// =============================================================

/**
 * Bus de eventos global — canal de comunicación desacoplado.
 * Los publicadores no saben quién está suscrito.
 * Los suscriptores no saben quién publica.
 *
 * @returns {Object} API del bus: publicar, suscribir, desuscribir
 */
function crearBusEventos() {
  const suscriptores = new Map();

  return {
    /**
     * Suscribe una función a un canal.
     * @param {string} canal
     * @param {Function} handler
     * @returns {Function} Función para cancelar la suscripción
     */
    suscribir(canal, handler) {
      if (!suscriptores.has(canal)) suscriptores.set(canal, new Set());
      suscriptores.get(canal).add(handler);
      return () => suscriptores.get(canal)?.delete(handler);
    },

    /**
     * Publica un mensaje en un canal.
     * @param {string} canal
     * @param {any} datos
     */
    publicar(canal, datos) {
      suscriptores.get(canal)?.forEach((h) => h(datos));
    },
  };
}

// Demostración del Pub/Sub
const bus = crearBusEventos();

// Módulo A: suscrito al canal "pedido:nuevo"
const cancelarA = bus.suscribir("pedido:nuevo", (pedido) => {
  console.log(`[Inventario] Reservando stock para pedido #${pedido.id}`);
});

// Módulo B: también suscrito al mismo canal
bus.suscribir("pedido:nuevo", (pedido) => {
  console.log(`[Email] Enviando confirmación a ${pedido.email}`);
});

// Módulo C: publica — no sabe quién escucha
console.log("Pub/Sub:");
bus.publicar("pedido:nuevo", {
  id: 1042,
  email: "cliente@ejemplo.com",
  total: 149.99,
});
cancelarA(); // módulo A deja de escuchar

// =============================================================
// PATRÓN 2 — STATE MACHINE (Máquina de Estado)
// Modela un sistema que solo puede estar en un estado a la vez.
// Las transiciones son explícitas y predecibles.
// Uso real: formularios de checkout, reproductor de video, autenticación.
// =============================================================

/**
 * Máquina de estado simple y genérica.
 * @param {string} estadoInicial
 * @param {Object} transiciones - { ESTADO: { EVENTO: nuevoEstado } }
 */
function crearMaquinaEstado(estadoInicial, transiciones) {
  let estadoActual = estadoInicial;
  const listeners = [];

  return {
    /** @returns {string} Estado actual */
    get estado() {
      return estadoActual;
    },

    /**
     * Intenta hacer una transición con el evento dado.
     * @param {string} evento
     * @returns {boolean} true si la transición fue válida
     */
    enviar(evento) {
      const posibles = transiciones[estadoActual];
      if (!posibles || !(evento in posibles)) {
        console.warn(
          `[FSM] Evento "${evento}" no válido en estado "${estadoActual}"`
        );
        return false;
      }
      const anterior = estadoActual;
      estadoActual = posibles[evento];
      listeners.forEach((l) => l(estadoActual, anterior, evento));
      return true;
    },

    /**
     * Suscribe un listener a los cambios de estado.
     * @param {Function} listener - (nuevoEstado, estadoAnterior, evento)
     */
    onChange(listener) {
      listeners.push(listener);
    },
  };
}

// Máquina de estado para un pedido en e-commerce
const pedidoFSM = crearMaquinaEstado("pendiente", {
  pendiente: { CONFIRMAR: "confirmado", CANCELAR: "cancelado" },
  confirmado: { ENVIAR: "enviado", CANCELAR: "cancelado" },
  enviado: { ENTREGAR: "entregado" },
  entregado: {},
  cancelado: {},
});

pedidoFSM.onChange((nuevo, anterior, evento) => {
  console.log(`[FSM] ${anterior} --[${evento}]--> ${nuevo}`);
});

console.log("\nState Machine:");
pedidoFSM.enviar("CONFIRMAR");
pedidoFSM.enviar("ENVIAR");
pedidoFSM.enviar("CANCELAR"); // no válido en estado "enviado"
pedidoFSM.enviar("ENTREGAR");
console.log("Estado final:", pedidoFSM.estado);

// =============================================================
// PATRÓN 3 — FLUX/REDUX
// Estado centralizado + acciones + reducers = cambios predecibles.
// Base de Redux, Zustand, Pinia, NgRx y similares.
//
// Principios:
//   1. Una sola fuente de verdad (el store)
//   2. El estado es de solo lectura
//   3. Los cambios se hacen mediante funciones puras (reducers)
// =============================================================

/**
 * Crea un store Redux-like minimalista (~40 líneas funcionales).
 *
 * @param {Function} reducer - (estado, accion) => nuevoEstado
 * @param {any} estadoInicial
 * @returns {{ getState, dispatch, subscribe }}
 */
function crearStore(reducer, estadoInicial) {
  let estado = estadoInicial;
  const listeners = new Set();

  return {
    /**
     * Devuelve el estado actual (snapshot inmutable).
     * @returns {any}
     */
    getState() {
      return estado;
    },

    /**
     * Despacha una acción para cambiar el estado.
     * @param {{ type: string, payload?: any }} accion
     */
    dispatch(accion) {
      estado = reducer(estado, accion);
      listeners.forEach((l) => l());
    },

    /**
     * Suscribe una función que se llama en cada cambio de estado.
     * @param {Function} listener
     * @returns {Function} Función para desuscribirse
     */
    subscribe(listener) {
      listeners.add(listener);
      return () => listeners.delete(listener);
    },
  };
}

// --- Reducer: función pura que define las transiciones de estado ---
/**
 * Reducer del carrito de compras.
 * @param {Object} estado
 * @param {{ type: string, payload?: any }} accion
 * @returns {Object}
 */
function carritoReducer(estado, accion) {
  switch (accion.type) {
    case "AGREGAR_ITEM":
      return {
        ...estado,
        items: [...estado.items, accion.payload],
      };
    case "ELIMINAR_ITEM":
      return {
        ...estado,
        items: estado.items.filter((i) => i.id !== accion.payload),
      };
    case "VACIAR_CARRITO":
      return { ...estado, items: [] };
    default:
      return estado; // siempre retornar el estado por defecto
  }
}

// --- Store y acciones ---
const storeCarrito = crearStore(carritoReducer, { items: [] });

// Suscribirse a cambios
const cancelarSub = storeCarrito.subscribe(() => {
  const { items } = storeCarrito.getState();
  console.log(`[Redux] Items en carrito: ${items.length}`);
});

console.log("\nFlux/Redux:");
storeCarrito.dispatch({
  type: "AGREGAR_ITEM",
  payload: { id: 1, nombre: "Audífonos", precio: 120 },
});
storeCarrito.dispatch({
  type: "AGREGAR_ITEM",
  payload: { id: 2, nombre: "Cable USB", precio: 12 },
});
storeCarrito.dispatch({ type: "ELIMINAR_ITEM", payload: 1 });
storeCarrito.dispatch({ type: "VACIAR_CARRITO" });

cancelarSub();
console.log("Estado final:", storeCarrito.getState());
