// ============================================================
// ARCHIVO: 01_callbacks.js
// TEMA: Callbacks, setTimeout, setInterval, error-first, callback hell
// CÓMO EJECUTAR: node 01_callbacks.js
// ============================================================

// ── Qué es un callback y por qué surgieron ───────────────────
// Un callback es una función pasada como argumento para ser ejecutada
// después de que una operación asíncrona termine.
// Surgieron porque JS necesitaba ejecutar código después de operaciones
// que toman tiempo, sin bloquear el hilo principal.
console.log("=== Callbacks básicos ===");

// Callback sincrónico (no asíncrono, pero es un callback)
function procesarNombre(nombre, callback) {
  const resultado = nombre.toUpperCase();
  callback(resultado); // llama a la función pasada como argumento
}

procesarNombre("ana", (nombreMayus) => {
  console.log("Procesado:", nombreMayus); // "ANA"
});

// ── setTimeout y setInterval ──────────────────────────────────
// setTimeout: ejecuta una función una vez después de N milisegundos
// setInterval: ejecuta una función repetidamente cada N milisegundos
console.log("\n=== setTimeout / setInterval ===");

console.log("1. Antes del setTimeout");

// El callback se ejecuta después de 0ms pero de forma asíncrona
// (se coloca en la macrotask queue — el código síncrono termina primero)
setTimeout(() => {
  console.log("3. Dentro del setTimeout (asíncrono)");
}, 0);

console.log("2. Después del setTimeout (síncróno, se ejecuta primero)");

// setInterval: ejecuta repetidamente
let veces = 0;
const intervalo = setInterval(() => {
  veces++;
  process.stdout.write(`tick${veces} `);
  if (veces >= 3) {
    clearInterval(intervalo); // detener el intervalo
    console.log("\nIntervalo detenido");
  }
}, 10); // cada 10ms

// ── Error-first callback pattern de Node.js ──────────────────
// Convención estándar de Node.js:
// El PRIMER argumento del callback es siempre el error (null si no hay error)
// El SEGUNDO argumento es el resultado (si la operación fue exitosa)
console.log("\n=== Error-first callback (Node.js pattern) ===");

/**
 * Simula leer un archivo de forma asíncrona con error-first callback.
 * @param {string} nombreArchivo - Nombre del archivo a leer
 * @param {Function} callback - Función (error, contenido) al terminar
 */
function leerArchivo(nombreArchivo, callback) {
  setTimeout(() => {
    if (nombreArchivo === "inexistente.txt") {
      // Primer argumento: el error
      callback(new Error(`Archivo no encontrado: ${nombreArchivo}`), null);
    } else {
      // Primer argumento: null (sin error) — segundo: el resultado
      callback(null, `Contenido de ${nombreArchivo}`);
    }
  }, 50);
}

leerArchivo("datos.txt", (error, contenido) => {
  // Siempre verificar el error primero
  if (error) {
    console.log("Error:", error.message);
    return; // salir para no procesar contenido inválido
  }
  console.log("Archivo leído:", contenido);
});

leerArchivo("inexistente.txt", (error, contenido) => {
  if (error) {
    console.log("Error esperado:", error.message);
    return;
  }
  console.log(contenido);
});

// ── Callback hell: el problema del anidamiento profundo ──────
// Cuando necesitas operaciones secuenciales, los callbacks se anidan
// Esto crea una "pirámide de la perdición" — difícil de leer y mantener
console.log("\n=== Callback hell (el problema) ===");

/**
 * Simula operaciones asíncronas para demostrar el callback hell.
 * En código real, esto sería: leer DB → procesar → guardar → notificar
 */
function obtenerUsuario(id, callback) {
  setTimeout(() => callback(null, { id, nombre: "Ana" }), 10);
}

function obtenerPedidos(usuario, callback) {
  setTimeout(() => callback(null, [{ id: 1, producto: "Libro" }]), 10);
}

function calcularTotal(pedidos, callback) {
  setTimeout(() => callback(null, pedidos.length * 25), 10);
}

// Anidamiento de callbacks — difícil de leer y depurar
obtenerUsuario(1, (err1, usuario) => {
  if (err1) return console.error("Error usuario:", err1.message);
  obtenerPedidos(usuario, (err2, pedidos) => {
    if (err2) return console.error("Error pedidos:", err2.message);
    calcularTotal(pedidos, (err3, total) => {
      if (err3) return console.error("Error total:", err3.message);
      // Imagina 3 niveles más de anidamiento...
      console.log(`Total de ${usuario.nombre}: $${total}`);
      // Solución: Promises y async/await (ver archivos siguientes)
    });
  });
});

// ── Cuándo siguen siendo útiles los callbacks ────────────────
// 1. Event listeners del DOM/Node.js: btn.addEventListener("click", callback)
// 2. APIs de Node.js que usan el patrón error-first
// 3. setTimeout/setInterval
// 4. Callbacks simples de array: map, filter, forEach, sort

// Ejemplo: sort con callback comparador
const nombres = ["Carlos", "Ana", "Beatriz", "David"];
nombres.sort((a, b) => a.localeCompare(b, "es"));
console.log("\nOrdenado:", nombres);

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Crea un setInterval que cuente regresivamente de 5 a 0 y luego se detenga
// 2. Agrega un cuarto nivel de anidamiento al callback hell para sentir el problema
// 3. Reescribe leerArchivo usando Promises (adelanto del siguiente archivo)
// 4. Observa el orden de ejecución: sincrónico, setTimeout(0), setTimeout(100)
