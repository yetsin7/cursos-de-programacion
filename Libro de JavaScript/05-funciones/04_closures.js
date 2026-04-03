// ============================================================
// ARCHIVO: 04_closures.js
// TEMA: Closures: qué son, variables privadas, módulo pattern, factory functions
// CÓMO EJECUTAR: node 04_closures.js
// ============================================================

// ── Qué es un closure ────────────────────────────────────────
// Un closure es una función que "recuerda" las variables del ámbito
// en que fue CREADA, incluso después de que ese ámbito haya terminado.
// Toda función en JavaScript forma un closure con su entorno léxico.
console.log("=== Qué es un closure ===");

function crearSaludo(idioma) {
  // 'idioma' vive en el ámbito de crearSaludo
  // La función interna "captura" y recuerda esa variable
  return function(nombre) {
    const saludos = { es: "Hola", en: "Hello", fr: "Bonjour" };
    return `${saludos[idioma] ?? "Hola"}, ${nombre}!`;
  };
}

// crearSaludo terminó de ejecutarse, pero 'idioma' sigue vivo
// gracias al closure de la función retornada
const saludarEnEspañol = crearSaludo("es");
const saludarEnIngles  = crearSaludo("en");

console.log(saludarEnEspañol("María")); // "Hola, María!"
console.log(saludarEnIngles("John"));   // "Hello, John!"

// ── Factory function con estado privado ──────────────────────
// Una factory es una función que crea y retorna objetos o funciones
// El estado interno solo es accesible a través de la interfaz pública
console.log("\n=== Factory function (closure con estado) ===");

/**
 * Crea un contador personalizable con paso configurable.
 * El valor actual es privado: no se puede acceder directamente desde fuera.
 * @param {number} [paso=1] - Cuánto incrementar/decrementar en cada operación
 * @param {number} [valorInicial=0] - Valor inicial del contador
 * @returns {{ incrementar: Function, decrementar: Function, obtener: Function, reiniciar: Function }}
 */
function contadorConPaso(paso = 1, valorInicial = 0) {
  // 'valor' es privado — solo accesible mediante las funciones que retornamos
  let valor = valorInicial;

  return {
    incrementar() { valor += paso; },
    decrementar() { valor -= paso; },
    obtener()     { return valor; },
    reiniciar()   { valor = valorInicial; },
  };
}

const contadorA = contadorConPaso(1, 0);   // paso 1, inicio en 0
const contadorB = contadorConPaso(5, 100); // paso 5, inicio en 100

contadorA.incrementar();
contadorA.incrementar();
contadorA.incrementar();
console.log("A:", contadorA.obtener()); // 3

contadorB.incrementar();
contadorB.decrementar();
console.log("B:", contadorB.obtener()); // 100 (subió 5, bajó 5)

// Los dos contadores son independientes — cada uno tiene su propio 'valor'
console.log("A no afecta B:", contadorA.obtener(), contadorB.obtener());

// ── Variables "privadas" con closures ────────────────────────
// JavaScript no tiene modificadores de acceso tradicionales (private)
// Los closures permiten encapsular estado que no es accesible desde fuera
console.log("\n=== Variables privadas ===");

function crearCuentaBancaria(titular, saldoInicial) {
  let saldo = saldoInicial; // PRIVADO — inaccesible desde fuera
  const historial = [];     // PRIVADO — inaccesible desde fuera

  function registrar(operacion, monto) {
    historial.push({ operacion, monto, saldoResultante: saldo });
  }

  // Solo se expone la interfaz pública
  return {
    depositar(monto) {
      if (monto <= 0) throw new Error("El monto debe ser positivo");
      saldo += monto;
      registrar("depósito", monto);
    },
    retirar(monto) {
      if (monto > saldo) throw new Error("Saldo insuficiente");
      saldo -= monto;
      registrar("retiro", monto);
    },
    obtenerSaldo()   { return saldo; },
    obtenerHistorial() { return [...historial]; }, // copia para no exponer el original
    toString()       { return `Cuenta de ${titular}`; },
  };
}

const cuenta = crearCuentaBancaria("Ana", 1000);
cuenta.depositar(500);
cuenta.retirar(200);
console.log("Saldo:", cuenta.obtenerSaldo()); // 1300
console.log("Historial:", cuenta.obtenerHistorial());
// console.log(cuenta.saldo); // undefined — saldo es privado

// ── Módulo pattern con IIFE ───────────────────────────────────
// IIFE (Immediately Invoked Function Expression): se ejecuta de inmediato
// Permite crear un módulo con API pública y estado privado en una sola expresión
console.log("\n=== Módulo pattern con IIFE ===");

const moduloContador = (() => {
  // Estado privado — inaccesible desde fuera del IIFE
  let conteo = 0;
  const MAX = 10;

  // API pública: solo lo que retorna el IIFE es accesible
  return {
    incrementar() {
      if (conteo < MAX) conteo++;
    },
    reiniciar() { conteo = 0; },
    valor()     { return conteo; },
    estaLleno() { return conteo >= MAX; },
  };
})(); // se ejecuta inmediatamente

moduloContador.incrementar();
moduloContador.incrementar();
console.log("Conteo:", moduloContador.valor()); // 2
// console.log(moduloContador.conteo); // undefined — privado

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Crea una factory function que genere funciones multiplicadoras:
//    const doble = multiplicador(2); doble(5) → 10
// 2. Agrega un límite máximo al contadorConPaso para que no supere un tope
// 3. Crea un closure que genere IDs únicos secuenciales (generadorId())
// 4. Implementa un sistema de caché (memoización) usando closure para almacenar resultados
