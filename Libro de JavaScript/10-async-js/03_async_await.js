// ============================================================
// ARCHIVO: 03_async_await.js
// TEMA: async/await, manejo de errores, paralelismo, top-level await
// CÓMO EJECUTAR: node 03_async_await.js
// ============================================================

// ── async function siempre retorna una Promise ────────────────
// async convierte una función en asíncrona y envuelve su retorno en una Promise
// Incluso si retorna un valor normal, se convierte en Promise.resolve(valor)
console.log("=== async siempre retorna Promise ===");

async function obtenerNombre() {
  return "Ana"; // equivale a: return Promise.resolve("Ana")
}

const resultado = obtenerNombre();
console.log(resultado instanceof Promise); // true
resultado.then(n => console.log("Nombre:", n)); // "Ana"

// ── await: esperar el resultado de una Promise ────────────────
// await pausa la ejecución de la función async hasta que la Promise se resuelva
// Solo puede usarse DENTRO de una función async (o con top-level await en módulos)
console.log("\n=== await ===");

// Función auxiliar: simula operación asíncrona
function esperar(ms, valor) {
  return new Promise(resolve => setTimeout(() => resolve(valor), ms));
}

async function demostrarAwait() {
  console.log("Inicio de función async");

  const paso1 = await esperar(30, "Paso 1 completado");
  console.log(paso1); // espera 30ms, luego continúa

  const paso2 = await esperar(20, "Paso 2 completado");
  console.log(paso2); // espera 20ms más

  console.log("Función async terminada");
  return "todo listo";
}

demostrarAwait().then(r => console.log("Retorno:", r));

// ── try/catch con async/await ────────────────────────────────
// El manejo de errores se hace con try/catch normal
// mucho más legible que encadenar .catch() en promises
console.log("\n=== try/catch con async/await ===");

function apiConPosibleError(debeiFallar) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      if (debeiFallar) reject(new Error("La API falló"));
      else resolve({ datos: "respuesta exitosa" });
    }, 20);
  });
}

async function cargarDatos(fallar) {
  try {
    const respuesta = await apiConPosibleError(fallar);
    console.log("Datos cargados:", respuesta.datos);
    return respuesta;
  } catch (error) {
    console.log("Error capturado:", error.message);
    return null; // retorna null en caso de error para que el llamador pueda decidir
  } finally {
    console.log("Carga terminada (finally en async)");
  }
}

cargarDatos(false); // exitoso
setTimeout(() => cargarDatos(true), 100); // fallido — espera para ver el output ordenado

// ── Paralelismo: await Promise.all() ─────────────────────────
// ANTI-PATRÓN: await secuencial innecesario (operaciones independientes en serie)
// CORRECTO: await Promise.all([...]) para operaciones independientes en paralelo
console.log("\n=== Paralelismo vs secuencial ===");

function fetchUsuario(id) {
  return esperar(50, { id, nombre: `Usuario_${id}` });
}

// ❌ Secuencial innecesario: 50ms + 50ms + 50ms = ~150ms total
async function cargarSecuencial() {
  const inicio = Date.now();
  const u1 = await fetchUsuario(1);
  const u2 = await fetchUsuario(2);
  const u3 = await fetchUsuario(3);
  console.log(`Secuencial: ${Date.now() - inicio}ms — ${[u1, u2, u3].map(u => u.nombre)}`);
}

// ✅ Paralelo: todas las requests al mismo tiempo → ~50ms total
async function cargarParalelo() {
  const inicio = Date.now();
  const [u1, u2, u3] = await Promise.all([fetchUsuario(1), fetchUsuario(2), fetchUsuario(3)]);
  console.log(`Paralelo: ${Date.now() - inicio}ms — ${[u1, u2, u3].map(u => u.nombre)}`);
}

// Ejecutar ambos para comparar tiempos
setTimeout(async () => {
  await cargarSecuencial();
  await cargarParalelo();
}, 200);

// ── Top-level await (ES2022 — en módulos ES) ──────────────────
// En archivos .mjs o con "type":"module" en package.json,
// puedes usar await directamente en el nivel superior del módulo
// sin necesidad de envolver en una función async
//
// Ejemplo (requiere módulo ES):
//
//   // archivo: datos.mjs
//   const datos = await fetch("https://api.ejemplo.com/info").then(r => r.json());
//   export { datos };
//
// En Node.js con CommonJS (require), debes usar el patrón IIFE async:
console.log("\n=== Top-level await (patrón para CommonJS) ===");

// Patrón IIFE async: permite código asíncrono al nivel "top" en CommonJS
(async () => {
  const valor = await esperar(10, "resultado top-level simulado");
  console.log("IIFE async:", valor);
})();

// ── Async/await con bucles ────────────────────────────────────
// forEach NO soporta await — usar for...of
console.log("\n=== async en bucles ===");

const ids = [1, 2, 3];

// ❌ forEach no espera las promesas internas
// ids.forEach(async id => { await fetchUsuario(id); }); // no funciona como se espera

// ✅ for...of sí respeta await — procesamiento secuencial
async function procesarSecuencial() {
  console.log("Procesando de forma secuencial:");
  for (const id of ids) {
    const usuario = await fetchUsuario(id);
    console.log("  Procesado:", usuario.nombre);
  }
}

setTimeout(() => procesarSecuencial(), 500);

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Mide el tiempo de cargarSecuencial vs cargarParalelo con 10 usuarios
// 2. Convierte los callbacks del archivo 01 en funciones async/await
// 3. Crea un archivo .mjs y usa top-level await sin IIFE
// 4. Usa Promise.allSettled con async/await para manejar errores parciales
