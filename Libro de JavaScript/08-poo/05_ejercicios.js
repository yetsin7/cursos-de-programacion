// ============================================================
// ARCHIVO: 05_ejercicios.js
// TEMA: Ejercicios de Programación Orientada a Objetos
// CÓMO EJECUTAR: node 05_ejercicios.js
// ============================================================

'use strict';

// ─── EJERCICIO 1: Sistema de cuentas bancarias ───────────────
// Modelar una cuenta bancaria con saldo privado y operaciones.

console.log('=== Ejercicio 1: Cuenta Bancaria ===');

/** Representa una cuenta bancaria con saldo encapsulado */
class CuentaBancaria {
  /** @type {number} Saldo actual de la cuenta */
  #saldo = 0;
  /** @type {Array<string>} Historial de movimientos */
  #historial = [];

  /**
   * Crea una cuenta con un saldo inicial.
   * @param {string} titular - Nombre del dueño
   * @param {number} saldoInicial - Monto de apertura
   */
  constructor(titular, saldoInicial = 0) {
    this.titular = titular;
    if (saldoInicial > 0) {
      this.#saldo = saldoInicial;
      this.#historial.push(`Apertura: +${saldoInicial}`);
    }
  }

  /**
   * Deposita dinero en la cuenta.
   * @param {number} monto - Debe ser positivo
   */
  depositar(monto) {
    if (monto <= 0) throw new Error('El monto debe ser positivo');
    this.#saldo += monto;
    this.#historial.push(`Depósito: +${monto} | Saldo: ${this.#saldo}`);
  }

  /**
   * Retira dinero de la cuenta.
   * @param {number} monto - No puede superar el saldo disponible
   */
  retirar(monto) {
    if (monto <= 0) throw new Error('El monto debe ser positivo');
    if (monto > this.#saldo) throw new Error('Saldo insuficiente');
    this.#saldo -= monto;
    this.#historial.push(`Retiro: -${monto} | Saldo: ${this.#saldo}`);
  }

  /** @returns {number} Saldo actual (solo lectura) */
  get saldo() {
    return this.#saldo;
  }

  /** Imprime el estado de la cuenta */
  imprimirEstado() {
    console.log(`Titular: ${this.titular} | Saldo: $${this.#saldo}`);
    console.log('Historial:', this.#historial.join(', '));
  }
}

const cuenta = new CuentaBancaria('Ana García', 1000);
cuenta.depositar(500);
cuenta.retirar(200);
cuenta.imprimirEstado();

try {
  cuenta.retirar(9999);
} catch (e) {
  console.log('Error esperado:', e.message);
}

// ─── EJERCICIO 2: Jerarquía de figuras geométricas ───────────
// Polimorfismo: cada figura implementa area() y perimetro().

console.log('\n=== Ejercicio 2: Figuras Geométricas ===');

/** Clase base abstracta para todas las figuras */
class Figura {
  /**
   * @param {string} color
   */
  constructor(color = 'blanco') {
    if (new.target === Figura) {
      throw new Error('Figura es una clase abstracta');
    }
    this.color = color;
  }

  /** @returns {number} Área de la figura — debe implementarse */
  area() {
    throw new Error('area() debe implementarse en la subclase');
  }

  /** @returns {number} Perímetro de la figura — debe implementarse */
  perimetro() {
    throw new Error('perimetro() debe implementarse en la subclase');
  }

  /** Descripción general de la figura */
  describir() {
    return `${this.constructor.name} (${this.color}) — Área: ${this.area().toFixed(2)}, Perímetro: ${this.perimetro().toFixed(2)}`;
  }
}

/** Círculo con radio dado */
class Circulo extends Figura {
  /** @param {number} radio */
  constructor(radio, color) {
    super(color);
    this.radio = radio;
  }
  area() { return Math.PI * this.radio ** 2; }
  perimetro() { return 2 * Math.PI * this.radio; }
}

/** Rectángulo con base y altura */
class Rectangulo extends Figura {
  constructor(base, altura, color) {
    super(color);
    this.base = base;
    this.altura = altura;
  }
  area() { return this.base * this.altura; }
  perimetro() { return 2 * (this.base + this.altura); }
}

/** Triángulo equilátero con lado dado */
class TrianguloEquilatero extends Figura {
  /** @param {number} lado */
  constructor(lado, color) {
    super(color);
    this.lado = lado;
  }
  area() { return (Math.sqrt(3) / 4) * this.lado ** 2; }
  perimetro() { return this.lado * 3; }
}

const figuras = [
  new Circulo(5, 'rojo'),
  new Rectangulo(4, 7, 'azul'),
  new TrianguloEquilatero(6, 'verde'),
];

figuras.forEach((f) => console.log(f.describir()));

// Polimorfismo: calcular el área total de cualquier lista de figuras
const areaTotal = figuras.reduce((acc, f) => acc + f.area(), 0);
console.log('Área total:', areaTotal.toFixed(2));

// ─── EJERCICIO 3: Sistema de roles con mixins ─────────────────
// Combinar comportamientos usando el patrón de mixin funcional.

console.log('\n=== Ejercicio 3: Sistema de Roles con Mixins ===');

/** Mixin: capacidad de autenticarse */
const Autenticable = (Base) =>
  class extends Base {
    /** Simula verificación de contraseña */
    autenticar(contrasena) {
      const valida = contrasena === this._contrasena;
      console.log(`${this.nombre}: autenticación ${valida ? 'exitosa' : 'fallida'}`);
      return valida;
    }
  };

/** Mixin: capacidad de publicar contenido */
const Publicador = (Base) =>
  class extends Base {
    /** @type {Array<string>} */
    #publicaciones = [];

    /** Publica un artículo */
    publicar(titulo) {
      this.#publicaciones.push(titulo);
      console.log(`${this.nombre} publicó: "${titulo}"`);
    }

    /** @returns {number} Número de publicaciones */
    get totalPublicaciones() {
      return this.#publicaciones.length;
    }
  };

/** Usuario base del sistema */
class Usuario {
  constructor(nombre, contrasena) {
    this.nombre = nombre;
    this._contrasena = contrasena; // En producción usaría hashing
  }
}

/** Editor: puede autenticarse y publicar */
class Editor extends Publicador(Autenticable(Usuario)) {}

const editor = new Editor('Carlos', 'secreta123');
editor.autenticar('incorrecta');
editor.autenticar('secreta123');
editor.publicar('Introducción a los Mixins');
editor.publicar('Composición vs Herencia');
console.log('Total publicaciones:', editor.totalPublicaciones);

// ─── EJERCICIO 4: Patrón Iterator personalizado ───────────────
// Crear una clase ListaCircular que sea iterable con for...of.

console.log('\n=== Ejercicio 4: Lista Circular Iterable ===');

/**
 * Lista circular: al llegar al último elemento vuelve al primero.
 * Limita la iteración a un número de pasos para evitar bucle infinito.
 */
class ListaCircular {
  /**
   * @param {Array} elementos - Elementos de la lista
   */
  constructor(elementos) {
    this.elementos = [...elementos];
  }

  /**
   * Hace la lista iterable. Recorre los elementos n veces en círculo.
   * @param {number} pasos - Cuántos elementos devolver en total
   */
  iterar(pasos) {
    const elementos = this.elementos;
    let indice = 0;
    let conteo = 0;
    return {
      [Symbol.iterator]() {
        return {
          next() {
            if (conteo >= pasos) return { done: true };
            const value = elementos[indice % elementos.length];
            indice++;
            conteo++;
            return { value, done: false };
          },
        };
      },
    };
  }
}

const lista = new ListaCircular(['lunes', 'martes', 'miércoles']);
console.log('Iteración circular (8 pasos):');
for (const dia of lista.iterar(8)) {
  process.stdout.write(dia + ' → ');
}
console.log('fin');
