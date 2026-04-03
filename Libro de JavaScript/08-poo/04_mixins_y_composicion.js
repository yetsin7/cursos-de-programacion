// ============================================================
// ARCHIVO: 04_mixins_y_composicion.js
// TEMA: Mixins, composición de objetos y Symbol en JavaScript
// CÓMO EJECUTAR: node 04_mixins_y_composicion.js
// ============================================================

'use strict';

// ─── 1. MIXINS CON Object.assign ────────────────────────────
// Un mixin es un objeto con métodos que se "mezclan" en una clase.
// Object.assign copia propiedades de un objeto fuente al prototipo destino.

/** Mixin que añade capacidad de serialización a cualquier clase */
const SerializableMixin = {
  /** Convierte la instancia a JSON string */
  toJSON() {
    return JSON.stringify(this);
  },
  /** Muestra un resumen legible del objeto */
  resumen() {
    return `[${this.constructor.name}] ${JSON.stringify(this)}`;
  },
};

/** Mixin que añade capacidad de búsqueda a colecciones */
const BuscableMixin = {
  /**
   * Busca elementos cuya propiedad coincida con el valor dado.
   * @param {string} propiedad - Nombre de la propiedad a comparar
   * @param {*} valor - Valor a buscar
   * @returns {Array} Elementos que coinciden
   */
  buscar(propiedad, valor) {
    if (!Array.isArray(this.items)) return [];
    return this.items.filter(
      (item) => String(item[propiedad]).toLowerCase().includes(String(valor).toLowerCase())
    );
  },
  /** Devuelve el total de elementos en la colección */
  contarItems() {
    return Array.isArray(this.items) ? this.items.length : 0;
  },
};

// ─── 2. PATRÓN FUNCIONAL DE MIXIN (Higher-Order) ─────────────
// En lugar de Object.assign, se usa una función que recibe una clase
// base y retorna una clase nueva con el comportamiento extra.

/**
 * Mixin funcional: hace que cualquier clase sea serializable.
 * @param {Function} Base - Clase base que será extendida
 * @returns {Function} Nueva clase con métodos de serialización
 */
const Serializable = (Base) =>
  class extends Base {
    /** Serializa la instancia a JSON */
    toJSON() {
      return JSON.stringify({ tipo: this.constructor.name, ...this });
    }
    /** Restaura una instancia desde un JSON string */
    static desdeJSON(json) {
      return Object.assign(new this(), JSON.parse(json));
    }
  };

/**
 * Mixin funcional: añade búsqueda y filtrado a colecciones.
 * @param {Function} Base - Clase base que será extendida
 * @returns {Function} Nueva clase con métodos de búsqueda
 */
const Buscable = (Base) =>
  class extends Base {
    /**
     * Filtra items por texto en cualquier propiedad string.
     * @param {string} texto - Texto a buscar
     * @returns {Array} Items que coinciden
     */
    buscarPorTexto(texto) {
      const termino = texto.toLowerCase();
      return this.items.filter((item) =>
        Object.values(item).some(
          (v) => typeof v === 'string' && v.toLowerCase().includes(termino)
        )
      );
    }
  };

// ─── 3. SYMBOL PARA PROPIEDADES ÚNICAS ───────────────────────
// Symbol garantiza que la clave de propiedad sea única globalmente.
// Evita colisiones de nombres entre mixins o bibliotecas externas.

/** Clave privada única para almacenar metadatos internos */
const _metadatos = Symbol('metadatos');
/** Clave privada única para el ID interno */
const _idInterno = Symbol('idInterno');

class Documento {
  constructor(titulo) {
    this.titulo = titulo;
    // Las propiedades con Symbol no aparecen en for...in ni JSON.stringify
    this[_metadatos] = { creadoEn: new Date().toISOString(), version: 1 };
    this[_idInterno] = Math.random().toString(36).slice(2);
  }

  /** Devuelve los metadatos internos (solo accesibles con el Symbol) */
  obtenerMetadatos() {
    return this[_metadatos];
  }

  /** Devuelve el ID interno único */
  get id() {
    return this[_idInterno];
  }
}

const doc = new Documento('Manual de JS');
console.log('=== Symbol como clave privada ===');
console.log('Título:', doc.titulo);
console.log('ID (Symbol):', doc.id);
console.log('Metadatos:', doc.obtenerMetadatos());
console.log('Las claves con Symbol NO aparecen en Object.keys:', Object.keys(doc));

// ─── 4. Symbol.iterator — OBJETO ITERABLE ────────────────────
// Al definir [Symbol.iterator] en un objeto, se puede usar con for...of.

/**
 * Rango numérico iterable usando Symbol.iterator.
 * Permite hacer: for (const n of new Rango(1, 5)) { ... }
 */
class Rango {
  /**
   * @param {number} inicio - Número inicial (inclusive)
   * @param {number} fin - Número final (inclusive)
   */
  constructor(inicio, fin) {
    this.inicio = inicio;
    this.fin = fin;
  }

  /** Hace que la instancia sea iterable con for...of */
  [Symbol.iterator]() {
    let actual = this.inicio;
    const fin = this.fin;
    return {
      next() {
        return actual <= fin
          ? { value: actual++, done: false }
          : { value: undefined, done: true };
      },
    };
  }
}

console.log('\n=== Symbol.iterator — objeto iterable ===');
const rango = new Rango(1, 5);
for (const num of rango) {
  process.stdout.write(num + ' ');
}
console.log();
// También funciona con spread y destructuring
console.log('Spread:', [...new Rango(10, 14)]);

// ─── 5. CLASE BIBLIOTECA CON MIXINS ──────────────────────────
// Combina los mixins funcionales Serializable y Buscable.

/** Clase base con la colección de libros */
class BibliotecaBase {
  constructor(nombre) {
    this.nombre = nombre;
    /** @type {Array<{titulo: string, autor: string, anio: number}>} */
    this.items = [];
  }

  /**
   * Agrega un libro a la biblioteca.
   * @param {string} titulo
   * @param {string} autor
   * @param {number} anio
   */
  agregarLibro(titulo, autor, anio) {
    this.items.push({ titulo, autor, anio });
  }
}

/**
 * Biblioteca que combina Serializable y Buscable vía mixins funcionales.
 * Demuestra composición en lugar de herencia múltiple.
 */
class Biblioteca extends Buscable(Serializable(BibliotecaBase)) {}

// También se puede aplicar Object.assign al prototipo para mixins simples
Object.assign(Biblioteca.prototype, SerializableMixin);

console.log('\n=== Biblioteca con Mixins ===');
const biblio = new Biblioteca('Biblioteca Central');
biblio.agregarLibro('Eloquent JavaScript', 'Marijn Haverbeke', 2018);
biblio.agregarLibro('You Don\'t Know JS', 'Kyle Simpson', 2015);
biblio.agregarLibro('JavaScript: The Good Parts', 'Douglas Crockford', 2008);

console.log('Total de libros:', biblio.contarItems());
console.log('Buscar "javascript":', biblio.buscarPorTexto('javascript'));
console.log('Buscar por mixin simple:', biblio.buscar('autor', 'simpson'));
console.log('Resumen (SerializableMixin):', biblio.resumen());

// ─── 6. COMPOSICIÓN VS HERENCIA ──────────────────────────────
// En lugar de heredar de una clase "Animal" con todo dentro,
// componemos comportamientos pequeños y reutilizables.

/** Comportamiento: puede nadar */
const puedeNadar = (estado) => ({
  nadar: () => console.log(`${estado.nombre} está nadando`),
});

/** Comportamiento: puede volar */
const puedeVolar = (estado) => ({
  volar: () => console.log(`${estado.nombre} está volando`),
});

/** Comportamiento: puede ladrar */
const puedeLadrar = (estado) => ({
  ladrar: () => console.log(`${estado.nombre} dice: ¡Guau!`),
});

/**
 * Crea un pato combinando comportamientos por composición.
 * @param {string} nombre
 * @returns {Object} Objeto con todos los comportamientos
 */
const crearPato = (nombre) => {
  const estado = { nombre };
  return Object.assign({}, estado, puedeNadar(estado), puedeVolar(estado));
};

/**
 * Crea un perro combinando comportamientos por composición.
 * @param {string} nombre
 * @returns {Object}
 */
const crearPerro = (nombre) => {
  const estado = { nombre };
  return Object.assign({}, estado, puedeNadar(estado), puedeLadrar(estado));
};

console.log('\n=== Composición de comportamientos ===');
const pato = crearPato('Donald');
pato.nadar();
pato.volar();

const perro = crearPerro('Rex');
perro.nadar();
perro.ladrar();
