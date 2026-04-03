// ============================================================
// ARCHIVO: 04_event_loop.js
// TEMA: Call stack, Web APIs, microtasks, macrotasks, event loop
// CÓMO EJECUTAR: node 04_event_loop.js
// ============================================================

// ── El Event Loop explicado ───────────────────────────────────
//
// JavaScript tiene UN SOLO hilo de ejecución (single-threaded).
// El Event Loop coordina todo el código asíncrono.
//
// Las piezas del sistema:
//
// 1. CALL STACK
//    - Pila donde se ejecutan las funciones síncronas
//    - Cada función que se llama se apila (push), al terminar se quita (pop)
//    - Solo puede ejecutar UNA función a la vez
//
// 2. WEB APIs / NODE APIs
//    - Manejan operaciones que toman tiempo: setTimeout, fetch, fs.readFile, etc.
//    - Son externas al motor JS — corren en paralelo en otros hilos del sistema
//    - Cuando terminan, colocan el callback en una QUEUE
//
// 3. MICROTASK QUEUE (alta prioridad)
//    - Contiene: callbacks de Promise.then/catch, queueMicrotask()
//    - Se vacía COMPLETAMENTE antes de procesar cualquier macrotask
//
// 4. MACROTASK QUEUE / CALLBACK QUEUE (baja prioridad)
//    - Contiene: setTimeout, setInterval, I/O callbacks, setImmediate
//    - Se procesa de a UNA tarea por vuelta del event loop
//
// 5. EL EVENT LOOP
//    - Ciclo continuo: verifica si el call stack está vacío
//    - Si está vacío: procesa TODAS las microtasks
//    - Luego procesa UNA macrotask
//    - Repite indefinidamente

// ── Demostración del orden de ejecución ──────────────────────
console.log("=== Orden de ejecución — demo 1 ===");

console.log("1 - Síncrono: inicio");

setTimeout(() => {
  console.log("4 - Macrotask: setTimeout(0)");
}, 0);

Promise.resolve().then(() => {
  console.log("3 - Microtask: Promise.then");
});

console.log("2 - Síncrono: fin");

// Orden esperado: 1 → 2 → 3 → 4
// Explicación:
// - "1" y "2" son síncronos → van al call stack directamente
// - setTimeout(0) se delega a Node APIs → callback va a macrotask queue
// - Promise.resolve().then → callback va a microtask queue
// - Al vaciar el call stack, se procesan PRIMERO las microtasks ("3")
// - LUEGO la macrotask ("4")

// ── Microtasks tienen prioridad sobre macrotasks ──────────────
console.log("\n=== Microtasks vs Macrotasks — demo 2 ===");

setTimeout(() => console.log("Macrotask A"), 0);
setTimeout(() => console.log("Macrotask B"), 0);

Promise.resolve()
  .then(() => console.log("Microtask 1"))
  .then(() => console.log("Microtask 2")) // encadenada — también es microtask
  .then(() => console.log("Microtask 3"));

queueMicrotask(() => console.log("Microtask via queueMicrotask"));

// Orden: Microtask 1 → queueMicrotask → Microtask 2 → Microtask 3 → Macrotask A → Macrotask B
// Las 4 microtasks se procesan antes de cualquier macrotask

// ── Ejemplo con async/await para ver el orden ────────────────
console.log("\n=== async/await y el event loop ===");

async function funcionAsync() {
  console.log("A - Inicio de funcionAsync (síncrono)");
  await Promise.resolve(); // pausa aquí — el resto es una microtask
  console.log("C - Después del await (microtask)");
}

console.log("X - Antes de llamar funcionAsync");
funcionAsync();
console.log("B - Después de llamar funcionAsync (síncrono)");

// Orden: X → A → B → C
// "A" se ejecuta síncronamente (antes del await)
// "B" se ejecuta porque funcionAsync() se pausó en await
// "C" se ejecuta como microtask cuando el stack se vacía

// ── setTimeout anidado: macrotasks sucesivas ─────────────────
console.log("\n=== Macrotasks anidadas ===");

setTimeout(() => {
  console.log("Macrotask 1");
  // Esta macrotask genera otra macrotask — no se ejecuta en la misma vuelta
  setTimeout(() => console.log("Macrotask 1 anidada"), 0);
  Promise.resolve().then(() => console.log("Microtask dentro de Macrotask 1"));
}, 0);

setTimeout(() => {
  console.log("Macrotask 2");
}, 0);

// Orden: Macrotask 1 → Microtask dentro de Macrotask 1 → Macrotask 2 → Macrotask 1 anidada
// Después de cada macrotask, se procesan todas las microtasks pendientes

// ── Resumen visual del Event Loop ────────────────────────────
//
// Cada "vuelta" del event loop:
//
//   ┌─ ¿Call stack vacío? ─────────────────────────────────────┐
//   │                                                          │
//   │  1. Procesar TODAS las microtasks (una por una)          │
//   │     hasta que la microtask queue esté vacía              │
//   │     (Promises, queueMicrotask)                           │
//   │                                                          │
//   │  2. Tomar UNA macrotask de la macrotask queue            │
//   │     (setTimeout, setInterval, I/O)                       │
//   │     → ejecutarla → puede generar nuevas microtasks       │
//   │                                                          │
//   │  3. Volver al paso 1                                     │
//   └──────────────────────────────────────────────────────────┘

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Agrega un console.log dentro de una Promise que se crea (no en .then) y observa cuándo se ejecuta
// 2. Crea una microtask infinita con queueMicrotask recursivo — observa qué pasa con las macrotasks
// 3. Compara setImmediate (solo Node.js) vs setTimeout(0) en cuanto a orden
// 4. Usa performance.now() para medir cuándo se ejecuta cada tipo de tarea
