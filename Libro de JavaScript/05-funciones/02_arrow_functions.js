// ============================================================
// ARCHIVO: 02_arrow_functions.js
// TEMA: Arrow functions: sintaxis, retorno implícito, this léxico
// CÓMO EJECUTAR: node 02_arrow_functions.js
// ============================================================

// ── Sintaxis básica ───────────────────────────────────────────
console.log("=== Sintaxis de arrow functions ===");

// Función normal
function doblarNormal(x) { return x * 2; }

// Arrow equivalente — forma completa con cuerpo {}
const doblarArrow = (x) => { return x * 2; };

// Arrow con un solo parámetro — se pueden omitir los paréntesis
const triplicar = x => x * 3;

// Arrow sin parámetros — paréntesis vacíos obligatorios
const saludar = () => "¡Hola!";

// Arrow con múltiples parámetros
const sumar = (a, b) => a + b;

console.log(doblarNormal(5));  // 10
console.log(doblarArrow(5));   // 10
console.log(triplicar(5));     // 15
console.log(saludar());        // "¡Hola!"
console.log(sumar(3, 4));      // 7

// ── Retorno implícito (sin llaves) ───────────────────────────
// Cuando el cuerpo es una sola expresión y se omiten las llaves,
// esa expresión se retorna automáticamente
console.log("\n=== Retorno implícito ===");

const cuadrado = x => x * x;
const esMayorDeEdad = edad => edad >= 18;
const formatearNombre = (nombre, apellido) => `${nombre} ${apellido}`;

console.log(cuadrado(6));                    // 36
console.log(esMayorDeEdad(20));              // true
console.log(formatearNombre("Ana", "López")); // "Ana López"

// Muy común con métodos de array
const numeros = [1, 2, 3, 4, 5];
const dobles = numeros.map(n => n * 2);
const pares  = numeros.filter(n => n % 2 === 0);
console.log(dobles); // [2, 4, 6, 8, 10]
console.log(pares);  // [2, 4]

// ── Arrow con cuerpo {} requiere return explícito ─────────────
console.log("\n=== Cuerpo con llaves → return explícito ===");

// Cuando necesitas múltiples líneas, usas llaves y return obligatorio
const procesarEdad = (edad) => {
  if (edad < 0) return null; // validación
  const categoria = edad < 18 ? "menor" : "adulto";
  return { edad, categoria };
};

console.log(procesarEdad(25));  // { edad: 25, categoria: 'adulto' }
console.log(procesarEdad(-1));  // null
console.log(procesarEdad(15));  // { edad: 15, categoria: 'menor' }

// ── Retornar un objeto literal ─────────────────────────────────
// Problema: las llaves {} se confunden con el inicio del cuerpo de la función
// Solución: envolver el objeto en paréntesis ()
console.log("\n=== Retornar objeto literal ===");

// ❌ Esto lanza SyntaxError: las llaves se interpretan como cuerpo de función
// const crearPersona = (nombre, edad) => { nombre, edad };

// ✅ Correcto: paréntesis alrededor del objeto
const crearPersona = (nombre, edad) => ({ nombre, edad });

console.log(crearPersona("María", 30)); // { nombre: 'María', edad: 30 }

// También funciona en map
const personas = [["Pedro", 25], ["Lucía", 28]];
const objetos = personas.map(([nombre, edad]) => ({ nombre, edad }));
console.log(objetos);

// ── this en arrow functions: contexto léxico ─────────────────
// Las arrow functions NO tienen su propio 'this'
// Heredan el 'this' del contexto en que fueron DEFINIDAS (léxico)
// Las funciones normales tienen su propio 'this' (dinámico)
console.log("\n=== this en arrow vs function normal ===");

const temporizador = {
  segundos: 0,
  iniciarConFunction() {
    // setInterval con function normal: 'this' es undefined o global (no el objeto)
    // Por eso en el pasado se usaba: const self = this;
    const self = this;
    const id = setInterval(function() {
      self.segundos++; // necesita 'self' porque 'this' cambia
      if (self.segundos >= 3) clearInterval(id);
    }, 1);
    // Esperamos un momento para que el intervalo corra
  },
  iniciarConArrow() {
    // Arrow function hereda 'this' del método → es el objeto temporizador
    const id = setInterval(() => {
      this.segundos++; // 'this' aquí es el objeto temporizador
      if (this.segundos >= 3) clearInterval(id);
    }, 1);
  }
};

// Demostración simplificada de 'this' léxico sin timers reales
class Contador {
  constructor() {
    this.valor = 0;
  }

  // Método con function normal: 'this' funciona bien aquí
  incrementar() {
    this.valor++;
  }

  // Arrow dentro de método: hereda 'this' del método
  incrementarConArrow() {
    const paso = () => {
      this.valor += 10; // 'this' es la instancia del Contador
    };
    paso();
  }
}

const contador = new Contador();
contador.incrementar();
contador.incrementarConArrow();
console.log("Valor:", contador.valor); // 11

// ── Cuándo NO usar arrow functions ───────────────────────────
console.log("\n=== Cuándo NO usar arrows ===");

// 1. Métodos de objetos que usan 'this' — el 'this' no será el objeto
const mascota = {
  nombre: "Fido",
  saludarMal: () => {
    // 'this' aquí NO es mascota — es el contexto exterior (undefined en strict mode)
    return `Hola, soy ${this?.nombre ?? "desconocido"}`;
  },
  saludarBien() {
    // function normal en método de objeto — 'this' sí es mascota
    return `Hola, soy ${this.nombre}`;
  }
};

console.log(mascota.saludarMal());  // "Hola, soy desconocido" — 'this' incorrecto
console.log(mascota.saludarBien()); // "Hola, soy Fido" — correcto

// 2. Constructores — no se pueden usar con 'new'
// const MiClase = () => {}; // ❌ TypeError si haces: new MiClase()

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Convierte una función normal con múltiples líneas a arrow con cuerpo {}
// 2. Crea un método de objeto que use una arrow interna y observa 'this'
// 3. Prueba qué pasa si intentas usar 'new' con una arrow function
// 4. Usa arrow functions en cadenas de map().filter().reduce()
