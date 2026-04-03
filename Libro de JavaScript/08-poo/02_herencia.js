// =============================================================================
// ARCHIVO: 02_herencia.js
// TEMA: Herencia en JavaScript — extends, super, override, instanceof
// =============================================================================
// CÓMO EJECUTAR: node 02_herencia.js
// =============================================================================

'use strict';

// -----------------------------------------------------------------------------
// 1. CLASE BASE (PADRE)
// -----------------------------------------------------------------------------

/**
 * Clase base que representa un vehículo genérico.
 * Define la interfaz común para todos los tipos de vehículos.
 */
class Vehiculo {
  constructor(marca, modelo, año) {
    this.marca  = marca;
    this.modelo = modelo;
    this.año    = año;
    this.encendido = false;
    this.kilometros = 0;
  }

  // Método que las clases hijas pueden heredar directamente
  encender() {
    this.encendido = true;
    return `${this.marca} ${this.modelo} encendido`;
  }

  // Método que las clases hijas probablemente sobreescriban
  describir() {
    return `${this.año} ${this.marca} ${this.modelo}`;
  }

  // Método que usa el estado interno
  conducir(km) {
    if (!this.encendido) throw new Error('El vehículo está apagado');
    this.kilometros += km;
    return `Conducido ${km}km. Total: ${this.kilometros}km`;
  }

  toString() {
    return `[Vehículo: ${this.describir()}]`;
  }
}

// -----------------------------------------------------------------------------
// 2. CLASES HIJAS CON EXTENDS
// -----------------------------------------------------------------------------

/**
 * Automóvil: hereda de Vehículo y agrega propiedades propias.
 * Demuestra super() en el constructor y override de métodos.
 */
class Automovil extends Vehiculo {
  constructor(marca, modelo, año, numeroPuertas = 4) {
    // super() DEBE llamarse antes de usar `this`
    super(marca, modelo, año);
    this.numeroPuertas = numeroPuertas;
    this.combustible   = 100; // porcentaje
  }

  // Override del método del padre — agrega comportamiento específico
  describir() {
    return `${super.describir()} (${this.numeroPuertas} puertas)`;
  }

  // Método propio, no existe en Vehículo
  repostar(litros) {
    this.combustible = Math.min(100, this.combustible + litros);
    return `Combustible al ${this.combustible}%`;
  }
}

/**
 * Motocicleta: hereda de Vehículo con sus propias características.
 */
class Motocicleta extends Vehiculo {
  constructor(marca, modelo, año, cilindrada) {
    super(marca, modelo, año);
    this.cilindrada = cilindrada; // en cc
    this.caballeta  = false;
  }

  describir() {
    return `${super.describir()} (${this.cilindrada}cc)`;
  }

  // Método exclusivo de Motocicleta
  activarCaballeta() {
    this.caballeta = !this.caballeta;
    return `Caballeta ${this.caballeta ? 'activada' : 'desactivada'}`;
  }
}

/**
 * Camion: demuestra herencia con múltiples propiedades extra.
 */
class Camion extends Vehiculo {
  constructor(marca, modelo, año, capacidadTon) {
    super(marca, modelo, año);
    this.capacidadTon = capacidadTon;
    this.cargaActual  = 0;
  }

  describir() {
    return `${super.describir()} (${this.capacidadTon}T capacidad)`;
  }

  cargar(toneladas) {
    if (this.cargaActual + toneladas > this.capacidadTon) {
      throw new RangeError(`Excede capacidad máxima de ${this.capacidadTon}T`);
    }
    this.cargaActual += toneladas;
    return `Carga: ${this.cargaActual}/${this.capacidadTon}T`;
  }
}

// -----------------------------------------------------------------------------
// 3. USANDO LAS CLASES
// -----------------------------------------------------------------------------

console.log('=== HERENCIA EN ACCIÓN ===');

const auto   = new Automovil('Toyota', 'Corolla', 2023, 4);
const moto   = new Motocicleta('Honda', 'CBR', 2022, 600);
const camion = new Camion('Volvo', 'FH16', 2021, 25);

// Métodos heredados del padre
console.log(auto.encender());
console.log(auto.conducir(50));

// Métodos override (con super)
console.log('\nDescripciones:');
console.log('Auto:   ', auto.describir());   // incluye puertas
console.log('Moto:   ', moto.describir());   // incluye cc
console.log('Camión: ', camion.describir()); // incluye capacidad

// Métodos propios de cada clase
console.log('\nMétodos específicos:');
console.log(auto.repostar(20));
console.log(moto.activarCaballeta());
console.log(camion.cargar(15));

// -----------------------------------------------------------------------------
// 4. INSTANCEOF Y CADENA DE PROTOTIPOS
// -----------------------------------------------------------------------------

console.log('\n=== INSTANCEOF ===');

// instanceof verifica si el objeto es instancia de la clase o sus padres
console.log('auto instanceof Automovil:', auto instanceof Automovil); // true
console.log('auto instanceof Vehiculo: ', auto instanceof Vehiculo);  // true (hereda)
console.log('auto instanceof Motocicleta:', auto instanceof Motocicleta); // false
console.log('moto instanceof Vehiculo: ', moto instanceof Vehiculo);  // true

// Polimorfismo: tratar todos como Vehículo
const flota = [auto, moto, camion];
console.log('\nFlota (polimorfismo):');
flota.forEach(v => {
  const tipo = v.constructor.name; // nombre de la clase
  console.log(`  [${tipo.padEnd(12)}] ${v.describir()}`);
});

// Solo los automóviles tienen repostar
flota.forEach(v => {
  if (v instanceof Automovil) {
    console.log('Repostando auto:', v.repostar(10));
  }
});

// -----------------------------------------------------------------------------
// 5. LA CADENA DE PROTOTIPOS
// -----------------------------------------------------------------------------

console.log('\n=== CADENA DE PROTOTIPOS ===');

// JavaScript implementa herencia a través de la cadena de prototipos
// Class es solo azúcar sintáctico sobre este mecanismo
console.log('Prototipo de auto:         ', Object.getPrototypeOf(auto).constructor.name);
console.log('Prototipo del prototipo:   ', Object.getPrototypeOf(Object.getPrototypeOf(auto)).constructor.name);
console.log('Prototipo del prototipo²:  ', Object.getPrototypeOf(Object.getPrototypeOf(Object.getPrototypeOf(auto))).constructor.name);

// La cadena: auto → Automovil.prototype → Vehiculo.prototype → Object.prototype → null
console.log('\nMétodos heredados de Object:');
console.log('auto.hasOwnProperty:', typeof auto.hasOwnProperty); // función heredada de Object

// =============================================================================
// EXPERIMENTA:
// - Crea una clase ElectricAuto que herede de Automovil y tenga bateria en vez de combustible
// - Sobreescribe conducir() en ElectricAuto para consumir batería
// - Crea un array mixto de Automovil y ElectricAuto y usa instanceof para diferenciarlos
// - Experimenta qué pasa si no llamas super() antes de usar this
// =============================================================================
