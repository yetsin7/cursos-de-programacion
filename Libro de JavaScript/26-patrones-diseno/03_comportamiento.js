// =============================================================
// MÓDULO 26 — Patrones de Comportamiento
// Archivo: 03_comportamiento.js
//
// Cómo los objetos se comunican, distribuyen responsabilidades
// y se coordinan entre sí.
// =============================================================

// =============================================================
// PATRÓN 1 — OBSERVER / EventEmitter
// Los objetos "observadores" se suscriben a un "sujeto" y reciben
// notificaciones cuando cambia su estado.
// Uso real: DOM events, Node.js EventEmitter, reactividad en frameworks.
// =============================================================

/**
 * EventEmitter simple — base del patrón Observer.
 * Permite suscribirse a eventos y emitirlos.
 *
 * Uso:
 *   const ee = new EventEmitter();
 *   ee.on("datos", (d) => console.log(d));
 *   ee.emit("datos", { valor: 42 });
 */
class EventEmitter {
  constructor() {
    /** @type {Map<string, Function[]>} Mapa de evento → listeners */
    this._listeners = new Map();
  }

  /**
   * Suscribe un listener a un evento.
   * @param {string} evento
   * @param {Function} listener
   * @returns {Function} Función para desuscribirse (cleanup)
   */
  on(evento, listener) {
    if (!this._listeners.has(evento)) {
      this._listeners.set(evento, []);
    }
    this._listeners.get(evento).push(listener);
    // Retorna función para desuscribir — importante para evitar memory leaks
    return () => this.off(evento, listener);
  }

  /**
   * Desuscribe un listener específico.
   * @param {string} evento
   * @param {Function} listener
   */
  off(evento, listener) {
    const lista = this._listeners.get(evento) ?? [];
    this._listeners.set(evento, lista.filter((l) => l !== listener));
  }

  /**
   * Emite un evento y notifica a todos los listeners.
   * @param {string} evento
   * @param {...any} args - Argumentos pasados a los listeners
   */
  emit(evento, ...args) {
    (this._listeners.get(evento) ?? []).forEach((l) => l(...args));
  }
}

// Demostración del Observer
const tienda = new EventEmitter();

const desuscribir = tienda.on("venta", ({ producto, monto }) => {
  console.log(`Observer — Venta registrada: ${producto} por $${monto}`);
});

tienda.on("venta", ({ monto }) => {
  console.log(`Observer — Monto acumulado: $${monto}`);
});

tienda.emit("venta", { producto: "Teclado", monto: 85 });
desuscribir(); // este listener ya no recibirá más eventos
tienda.emit("venta", { producto: "Mouse", monto: 35 });

// =============================================================
// PATRÓN 2 — STRATEGY
// Define una familia de algoritmos, los encapsula y los hace
// intercambiables sin modificar el código que los usa.
// Uso real: ordenamiento, métodos de pago, compresión, validación.
// =============================================================

/**
 * Estrategias de ordenamiento — algoritmos intercambiables.
 * Cada estrategia recibe el arreglo original y retorna uno ordenado.
 */
const estrategias = {
  /** Ordena por precio ascendente */
  precioAscendente: (items) =>
    [...items].sort((a, b) => a.precio - b.precio),

  /** Ordena por precio descendente */
  precioDescendente: (items) =>
    [...items].sort((a, b) => b.precio - a.precio),

  /** Ordena por nombre alfabéticamente */
  nombreAlfabetico: (items) =>
    [...items].sort((a, b) => a.nombre.localeCompare(b.nombre)),

  /** Ordena por calificación descendente */
  mejorCalificado: (items) =>
    [...items].sort((a, b) => b.calificacion - a.calificacion),
};

/**
 * Catálogo de productos que usa una estrategia de ordenamiento inyectada.
 * El algoritmo puede cambiarse en tiempo de ejecución.
 */
class CatalogProductos {
  constructor(items) {
    this._items = items;
    this._estrategia = estrategias.precioAscendente; // estrategia por defecto
  }

  /**
   * Cambia la estrategia de ordenamiento.
   * @param {Function} estrategia
   */
  setEstrategia(estrategia) {
    this._estrategia = estrategia;
  }

  /** @returns {Object[]} Items ordenados según la estrategia actual */
  obtenerOrdenados() {
    return this._estrategia(this._items);
  }
}

const productos = [
  { nombre: "Teclado", precio: 85, calificacion: 4.2 },
  { nombre: "Monitor", precio: 350, calificacion: 4.8 },
  { nombre: "Mouse", precio: 35, calificacion: 4.5 },
];

const catalogo = new CatalogProductos(productos);
console.log("\nStrategy — por precio ascendente:");
catalogo.obtenerOrdenados().forEach((p) => console.log(`  ${p.nombre}: $${p.precio}`));

catalogo.setEstrategia(estrategias.mejorCalificado);
console.log("Strategy — mejor calificado:");
catalogo.obtenerOrdenados().forEach((p) =>
  console.log(`  ${p.nombre}: ${p.calificacion}★`)
);

// =============================================================
// PATRÓN 3 — COMMAND
// Encapsula una acción como un objeto, permitiendo deshacer/rehacer,
// colas de operaciones, y logging de comandos.
// Uso real: editores de texto (undo/redo), transacciones, colas de jobs.
// =============================================================

/**
 * Editor de texto con soporte para deshacer/rehacer.
 * Cada acción es un Command con métodos execute() y undo().
 */
class EditorTexto {
  constructor() {
    this.contenido = "";
    /** @type {Object[]} Historial de comandos ejecutados */
    this._historial = [];
  }

  /**
   * Ejecuta un comando y lo guarda en el historial.
   * @param {{ execute: Function, undo: Function }} comando
   */
  ejecutar(comando) {
    comando.execute();
    this._historial.push(comando);
  }

  /**
   * Deshace el último comando ejecutado.
   */
  deshacer() {
    const ultimo = this._historial.pop();
    if (ultimo) ultimo.undo();
    else console.log("Nada que deshacer");
  }
}

// Fábrica de comandos para el editor
const editor = new EditorTexto();

/**
 * Crea un comando para insertar texto.
 * @param {EditorTexto} ed
 * @param {string} texto
 */
function cmdInsertar(ed, texto) {
  return {
    execute() { ed.contenido += texto; },
    undo() { ed.contenido = ed.contenido.slice(0, -texto.length); },
  };
}

editor.ejecutar(cmdInsertar(editor, "Hola"));
editor.ejecutar(cmdInsertar(editor, " mundo"));
console.log("\nCommand — contenido:", editor.contenido); // "Hola mundo"
editor.deshacer();
console.log("Command — después de deshacer:", editor.contenido); // "Hola"

// =============================================================
// PATRÓN 4 — ITERATOR (personalizado con Symbol.iterator)
// Define cómo recorrer una colección sin exponer su estructura interna.
// JavaScript ya tiene iteradores nativos — aquí vemos cómo crear uno.
// =============================================================

/**
 * Rango de números con un iterador personalizado.
 * Permite usar el objeto en bucles for...of.
 *
 * Uso:
 *   for (const n of new Rango(1, 5)) console.log(n); // 1 2 3 4 5
 */
class Rango {
  /**
   * @param {number} inicio
   * @param {number} fin - inclusivo
   * @param {number} [paso=1]
   */
  constructor(inicio, fin, paso = 1) {
    this.inicio = inicio;
    this.fin = fin;
    this.paso = paso;
  }

  /**
   * Implementa el protocolo de iteración de JavaScript.
   * Cualquier objeto con este método puede usarse en for...of, spread, etc.
   * @returns {Iterator}
   */
  [Symbol.iterator]() {
    let actual = this.inicio;
    const fin = this.fin;
    const paso = this.paso;
    return {
      next() {
        if (actual <= fin) {
          const value = actual;
          actual += paso;
          return { value, done: false };
        }
        return { value: undefined, done: true };
      },
    };
  }
}

console.log("\nIterator — Rango(1, 5):");
for (const n of new Rango(1, 5)) {
  process.stdout.write(n + " ");
}
console.log();

// También funciona con spread y destructuring
const pares = [...new Rango(2, 10, 2)];
console.log("Iterator — pares del 2 al 10:", pares);
