// =============================================================================
// ARCHIVO: 03_static_y_privado.js
// TEMA: static, propiedades privadas #, getters y setters
// =============================================================================
// CÓMO EJECUTAR: node 03_static_y_privado.js
// =============================================================================

'use strict';

// -----------------------------------------------------------------------------
// 1. MÉTODOS Y PROPIEDADES ESTÁTICAS
// -----------------------------------------------------------------------------

/**
 * Clase Temperatura con métodos estáticos de conversión.
 * Los métodos static pertenecen a la CLASE, no a las instancias.
 */
class Temperatura {
  // Propiedad estática: pertenece a la clase, no a las instancias
  static UNIDADES = Object.freeze(['celsius', 'fahrenheit', 'kelvin']);

  constructor(valor, unidad = 'celsius') {
    this.valor = valor;
    this.unidad = unidad;
  }

  // Método de instancia: actúa sobre THIS
  aCelsius() {
    if (this.unidad === 'celsius')    return this.valor;
    if (this.unidad === 'fahrenheit') return Temperatura.fahrenheitACelsius(this.valor);
    if (this.unidad === 'kelvin')     return this.valor - 273.15;
    throw new Error('Unidad no reconocida');
  }

  // Métodos estáticos: se llaman como Temperatura.metodo(), no como instancia.metodo()
  static celsiusAFahrenheit(c) { return (c * 9 / 5) + 32; }
  static fahrenheitACelsius(f) { return (f - 32) * 5 / 9; }
  static celsiusAKelvin(c)     { return c + 273.15; }

  // Factory method estático: crea una instancia a partir de otro formato
  static deFahrenheit(f)       { return new Temperatura(f, 'fahrenheit'); }
  static deKelvin(k)           { return new Temperatura(k, 'kelvin'); }

  toString() {
    return `${this.valor}° ${this.unidad}`;
  }
}

console.log('=== MÉTODOS ESTÁTICOS ===');

// Usar métodos estáticos sin crear instancia
console.log('100°C en °F:', Temperatura.celsiusAFahrenheit(100)); // 212
console.log('32°F en °C: ', Temperatura.fahrenheitACelsius(32).toFixed(1)); // 0.0
console.log('Unidades:   ', Temperatura.UNIDADES);

// Usar instancia con factory method estático
const t = Temperatura.deFahrenheit(98.6);
console.log('98.6°F son:', t.aCelsius().toFixed(1), '°C');

// Error: los métodos static no existen en las instancias
try {
  t.celsiusAFahrenheit(0); // TypeError
} catch (e) {
  console.log('Error esperado:', e.message);
}

// -----------------------------------------------------------------------------
// 2. PROPIEDADES PRIVADAS CON # (ES2022)
// -----------------------------------------------------------------------------

console.log('\n=== PROPIEDADES PRIVADAS # ===');

/**
 * Cuenta bancaria con balance privado y validaciones.
 * El # hace que la propiedad sea genuinamente inaccesible desde fuera de la clase.
 */
class CuentaBancaria {
  // Declaración de campos privados — obligatorio declararlos aquí
  #balance;
  #historial;
  #pin;

  constructor(titular, balanceInicial, pin) {
    this.titular  = titular; // propiedad pública
    this.#balance  = balanceInicial;
    this.#historial = [];
    this.#pin      = pin;
  }

  // Método privado — solo accesible dentro de la clase
  #registrarMovimiento(tipo, monto) {
    this.#historial.push({
      tipo,
      monto,
      fecha: new Date().toISOString().slice(0, 10),
      balance: this.#balance,
    });
  }

  // Getter público que expone el balance (solo lectura)
  get balance() {
    return this.#balance;
  }

  // Método público que usa el privado internamente
  depositar(monto) {
    if (monto <= 0) throw new RangeError('El monto debe ser positivo');
    this.#balance += monto;
    this.#registrarMovimiento('depósito', monto);
    return this;
  }

  // Verificación de PIN antes de retirar
  retirar(monto, pin) {
    if (pin !== this.#pin)    throw new Error('PIN incorrecto');
    if (monto > this.#balance) throw new RangeError('Saldo insuficiente');
    this.#balance -= monto;
    this.#registrarMovimiento('retiro', monto);
    return this;
  }

  verHistorial(pin) {
    if (pin !== this.#pin) throw new Error('PIN incorrecto');
    return [...this.#historial]; // retorna copia para no exponer la referencia
  }

  toString() {
    return `Cuenta de ${this.titular} — Balance: $${this.#balance.toFixed(2)}`;
  }
}

const cuenta = new CuentaBancaria('Roberto', 1000, '1234');
cuenta.depositar(500).depositar(250);
cuenta.retirar(200, '1234');

console.log(String(cuenta));
console.log('Historial:', cuenta.verHistorial('1234'));

// Los campos privados son INACCESIBLES desde fuera de la clase
try {
  console.log(cuenta.#balance); // SyntaxError: campo privado
} catch (e) {
  console.log('Acceso a #balance bloqueado:', e.constructor.name);
}

// La propiedad tampoco aparece en Object.keys
console.log('Keys visibles:', Object.keys(cuenta)); // solo 'titular'

// -----------------------------------------------------------------------------
// 3. GETTERS Y SETTERS
// -----------------------------------------------------------------------------

console.log('\n=== GETTERS Y SETTERS ===');

/**
 * Temperatura con getters y setters para conversión transparente.
 * Los getters/setters permiten validar y transformar valores automáticamente.
 */
class Circulo {
  #radio;

  constructor(radio) {
    this.radio = radio; // usa el setter automáticamente
  }

  // Setter: se ejecuta cuando se hace `instancia.radio = valor`
  set radio(valor) {
    if (typeof valor !== 'number' || valor < 0) {
      throw new RangeError('El radio debe ser un número positivo');
    }
    this.#radio = valor;
  }

  // Getter: se ejecuta cuando se lee `instancia.radio`
  get radio() { return this.#radio; }

  // Getters computados (solo lectura, sin setter)
  get diametro()     { return this.#radio * 2; }
  get circunferencia() { return +(2 * Math.PI * this.#radio).toFixed(4); }
  get area()         { return +(Math.PI * this.#radio ** 2).toFixed(4); }

  toString() {
    return `Círculo(r=${this.#radio}) — área=${this.area}`;
  }
}

const c = new Circulo(5);
console.log('Radio:          ', c.radio);
console.log('Diámetro:       ', c.diametro);
console.log('Circunferencia: ', c.circunferencia);
console.log('Área:           ', c.area);

c.radio = 10; // usa el setter con validación
console.log('Nuevo radio:    ', c.radio);
console.log('Nueva área:     ', c.area);

try {
  c.radio = -5; // activa la validación del setter
} catch (e) {
  console.log('Setter bloqueó radio negativo:', e.message);
}

// =============================================================================
// EXPERIMENTA:
// - Agrega un método estático Circulo.comparar(c1, c2) que indique cuál es mayor
// - Añade un campo privado #creado con la fecha de creación de CuentaBancaria
// - Crea un getter 'enNumeros' en CuentaBancaria que formatee el balance como string
// - Implementa un setter con transformación: set nombre(v) { this.#nombre = v.trim() }
// =============================================================================
