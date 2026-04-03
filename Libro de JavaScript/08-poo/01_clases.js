// =============================================================================
// ARCHIVO: 01_clases.js
// TEMA: Clases en JavaScript — sintaxis moderna de POO
// =============================================================================
// CÓMO EJECUTAR: node 01_clases.js
// =============================================================================

'use strict';

// -----------------------------------------------------------------------------
// 1. CLASE BÁSICA CON CONSTRUCTOR
// -----------------------------------------------------------------------------

/**
 * Representa un libro con sus datos básicos y estado de lectura.
 * Ejemplo básico de clase con propiedades, métodos y toString.
 */
class Libro {
  // Las propiedades se declaran y asignan en el constructor
  constructor(titulo, autor, paginas) {
    this.titulo  = titulo;
    this.autor   = autor;
    this.paginas = paginas;
    this.leido   = false;       // propiedad con valor por defecto
    this.progreso = 0;          // páginas leídas
  }

  // Método de instancia: actúa sobre el objeto actual (this)
  marcarLeido() {
    this.leido    = true;
    this.progreso = this.paginas;
    return this; // retornar this permite encadenar métodos
  }

  // Método con parámetros
  actualizarProgreso(paginasLeidas) {
    if (paginasLeidas < 0 || paginasLeidas > this.paginas) {
      throw new RangeError(`Páginas deben estar entre 0 y ${this.paginas}`);
    }
    this.progreso = paginasLeidas;
    this.leido    = paginasLeidas === this.paginas;
    return this;
  }

  // Calcula el porcentaje de lectura
  porcentajeLeido() {
    return +((this.progreso / this.paginas) * 100).toFixed(1);
  }

  // toString: se llama automáticamente cuando el objeto se convierte a string
  toString() {
    const estado = this.leido ? '✓ Leído' : `${this.porcentajeLeido()}%`;
    return `"${this.titulo}" — ${this.autor} (${this.paginas} págs.) [${estado}]`;
  }
}

console.log('=== CLASE LIBRO ===');

// Instanciar con `new`
const libro1 = new Libro('Clean Code', 'Robert Martin', 431);
const libro2 = new Libro('El Quijote', 'Cervantes', 863);

console.log(String(libro1)); // invoca toString
console.log(String(libro2));

// Encadenar métodos (retornan this)
libro1.actualizarProgreso(200);
console.log(`Progreso: ${libro1.porcentajeLeido()}%`);
libro1.marcarLeido();
console.log(String(libro1)); // ahora muestra ✓ Leído

// typeof y instanceof
console.log('\ntypeof libro1:          ', typeof libro1);         // 'object'
console.log('libro1 instanceof Libro:', libro1 instanceof Libro); // true

// -----------------------------------------------------------------------------
// 2. DIFERENCIA CON PROTOTYPE (LA REALIDAD BAJO EL CAPÓ)
// -----------------------------------------------------------------------------

console.log('\n=== CLASS vs PROTOTYPE ===');

// La sintaxis class es azúcar sintáctico — JavaScript usa prototipos internamente
// Estos dos son equivalentes:

// Con class (moderno — preferido)
class Punto {
  constructor(x, y) {
    this.x = x;
    this.y = y;
  }
  distanciaAlOrigen() {
    return Math.sqrt(this.x ** 2 + this.y ** 2).toFixed(2);
  }
  toString() { return `(${this.x}, ${this.y})`; }
}

// Con prototype (la forma antigua)
function PuntoViejo(x, y) {
  this.x = x;
  this.y = y;
}
PuntoViejo.prototype.distanciaAlOrigen = function () {
  return Math.sqrt(this.x ** 2 + this.y ** 2).toFixed(2);
};

const p1 = new Punto(3, 4);
const p2 = new PuntoViejo(3, 4);
console.log('class:     ', p1.distanciaAlOrigen()); // '5.00'
console.log('prototype: ', p2.distanciaAlOrigen()); // '5.00' — idéntico resultado

// Los métodos de class viven en el prototipo, no en cada instancia
console.log('Método en prototipo:', Punto.prototype.distanciaAlOrigen === p1.distanciaAlOrigen);

// -----------------------------------------------------------------------------
// 3. CLASE CON MÚLTIPLES RESPONSABILIDADES
// -----------------------------------------------------------------------------

console.log('\n=== CLASE CARRITO ===');

/**
 * Representa un carrito de compras con gestión de items.
 * Demuestra this, métodos encadenables y toString.
 */
class Carrito {
  constructor(usuario) {
    this.usuario = usuario;
    this.items   = [];
    this.creado  = new Date().toISOString().slice(0, 10);
  }

  // Agrega un producto o incrementa su cantidad si ya existe
  agregar(nombre, precio, cantidad = 1) {
    const existente = this.items.find(i => i.nombre === nombre);
    if (existente) {
      existente.cantidad += cantidad;
    } else {
      this.items.push({ nombre, precio, cantidad });
    }
    return this;
  }

  // Elimina un item por nombre
  eliminar(nombre) {
    this.items = this.items.filter(i => i.nombre !== nombre);
    return this;
  }

  // Calcula el total del carrito
  calcularTotal() {
    return this.items.reduce((sum, i) => sum + i.precio * i.cantidad, 0);
  }

  // Retorna cuántos items (unidades) hay en el carrito
  get cantidadItems() {
    return this.items.reduce((sum, i) => sum + i.cantidad, 0);
  }

  toString() {
    if (this.items.length === 0) return `Carrito de ${this.usuario}: vacío`;
    const lista = this.items.map(i =>
      `  - ${i.nombre.padEnd(15)} x${i.cantidad}  $${(i.precio * i.cantidad).toFixed(2)}`
    ).join('\n');
    return `Carrito de ${this.usuario}:\n${lista}\n  TOTAL: $${this.calcularTotal().toFixed(2)}`;
  }
}

const carrito = new Carrito('María');
carrito
  .agregar('Laptop', 1299, 1)
  .agregar('Mouse',  35,   2)
  .agregar('Teclado', 80,  1)
  .agregar('Mouse',  35,   1); // agrega 1 más al Mouse existente

console.log(String(carrito));
console.log(`\nTotal items: ${carrito.cantidadItems}`);

// =============================================================================
// EXPERIMENTA:
// - Agrega un método vaciar() que vacíe el carrito y retorne this
// - Crea un método aplicarDescuento(porcentaje) en Carrito
// - Añade a Libro un método resumenCorto() con máximo 60 caracteres
// - Instancia 5 libros y muéstralos con toString() usando forEach
// =============================================================================
