// ============================================================
// ARCHIVO: 05_ejercicios.js
// TEMA: Ejercicios de async/await con soluciones
// CÓMO EJECUTAR: node 05_ejercicios.js
// ============================================================

// ── Función auxiliar reutilizable ────────────────────────────
/**
 * Simula una operación asíncrona con posible fallo.
 * @param {*} valor - Valor a resolver
 * @param {number} demora - Demora en ms
 * @param {boolean} [falla=false] - Si true, rechaza la promise
 * @returns {Promise<*>}
 */
function simular(valor, demora, falla = false) {
  return new Promise((resolve, reject) =>
    setTimeout(() => falla ? reject(new Error(`Error: ${valor}`)) : resolve(valor), demora)
  );
}

// ── EJERCICIO 1 ───────────────────────────────────────────────
// Crea una función timeout() que rechaza si una Promise tarda más de N ms.
// Úsala para proteger una llamada a API lenta.

console.log("=== Ejercicio 1: timeout() ===");

/**
 * Envuelve una Promise con un tiempo límite.
 * Si la Promise no resuelve en 'ms' milisegundos, rechaza con error de timeout.
 * @param {Promise<*>} promise - Promise a limitar en tiempo
 * @param {number} ms - Tiempo máximo en milisegundos
 * @returns {Promise<*>} La promise original o rechazo por timeout
 */
function conTimeout(promise, ms) {
  const reloj = new Promise((_, reject) =>
    setTimeout(() => reject(new Error(`Timeout: excedió ${ms}ms`)), ms)
  );
  // race: la primera en resolver/rechazar gana
  return Promise.race([promise, reloj]);
}

async function probarTimeout() {
  // Petición rápida — debería tener éxito
  try {
    const resultado = await conTimeout(simular("datos rápidos", 30), 100);
    console.log("Rápida:", resultado);
  } catch (e) {
    console.log("Error rápida:", e.message);
  }

  // Petición lenta — debería agotar el tiempo
  try {
    const resultado = await conTimeout(simular("datos lentos", 200), 100);
    console.log("Lenta:", resultado);
  } catch (e) {
    console.log("Timeout detectado:", e.message);
  }
}

probarTimeout();

// ── EJERCICIO 2 ───────────────────────────────────────────────
// Implementa reintentar() con versión async que incluye demora entre reintentos

console.log("\n=== Ejercicio 2: reintentar async ===");

/**
 * Reintenta una función asíncrona hasta N veces con demora entre intentos.
 * @param {Function} fn - Función async a reintentar
 * @param {number} maxIntentos - Número máximo de intentos
 * @param {number} [demora=100] - Milisegundos de espera entre reintentos
 * @returns {Promise<*>} Resultado de la primera ejecución exitosa
 * @throws {Error} Si todos los intentos fallan
 */
async function reintentarAsync(fn, maxIntentos, demora = 50) {
  let ultimoError;
  for (let intento = 1; intento <= maxIntentos; intento++) {
    try {
      return await fn(); // intenta ejecutar
    } catch (e) {
      ultimoError = e;
      console.log(`  Intento ${intento}/${maxIntentos} fallido: ${e.message}`);
      if (intento < maxIntentos) {
        // Esperar antes del próximo intento
        await new Promise(r => setTimeout(r, demora));
      }
    }
  }
  throw ultimoError;
}

async function probarReintentos() {
  let llamadas = 0;
  const operacionFlakey = async () => {
    llamadas++;
    if (llamadas < 3) throw new Error(`Fallo temporal ${llamadas}`);
    return `Éxito en llamada ${llamadas}`;
  };

  try {
    const resultado = await reintentarAsync(operacionFlakey, 5, 20);
    console.log("Reintentar resultado:", resultado);
  } catch (e) {
    console.log("Falló todos los intentos:", e.message);
  }
}

setTimeout(() => probarReintentos(), 300);

// ── EJERCICIO 3 ───────────────────────────────────────────────
// Crea una función cargarEnParalelo() que cargue N recursos en paralelo
// y reporte cuáles tuvieron éxito y cuáles fallaron

console.log("\n=== Ejercicio 3: carga paralela con reporte ===");

/**
 * Carga múltiples recursos en paralelo y reporta éxitos y fallos.
 * @param {Array<{id: string, url: string}>} recursos - Lista de recursos a cargar
 * @returns {Promise<{exitosos: Array, fallidos: Array}>}
 */
async function cargarEnParalelo(recursos) {
  // Simula fetch para cada recurso
  const promesas = recursos.map(recurso =>
    simular(`Contenido de ${recurso.id}`, Math.random() * 50 + 10, recurso.url.includes("falla"))
      .then(data => ({ ...recurso, data, estado: "exitoso" }))
      .catch(error => ({ ...recurso, error: error.message, estado: "fallido" }))
  );

  // allSettled garantiza que esperamos todos aunque algunos fallen
  const resultados = await Promise.all(promesas);

  return {
    exitosos: resultados.filter(r => r.estado === "exitoso"),
    fallidos:  resultados.filter(r => r.estado === "fallido"),
  };
}

async function probarCargaParalela() {
  const recursos = [
    { id: "usuarios",  url: "https://api.com/usuarios" },
    { id: "productos", url: "https://api.com/falla/productos" }, // fallará
    { id: "ordenes",   url: "https://api.com/ordenes" },
    { id: "config",    url: "https://api.com/falla/config" },   // fallará
  ];

  const { exitosos, fallidos } = await cargarEnParalelo(recursos);
  console.log(`Exitosos (${exitosos.length}):`, exitosos.map(r => r.id));
  console.log(`Fallidos (${fallidos.length}):`, fallidos.map(r => r.id));
}

setTimeout(() => probarCargaParalela(), 600);

// ── EJERCICIO 4 ───────────────────────────────────────────────
// Implementa una cola de tareas async (AsyncQueue) que:
// - Agrega tareas con enqueue()
// - Procesa tareas de a UNA por vez (no en paralelo)
// - Notifica cuando todas las tareas terminaron

console.log("\n=== Ejercicio 4: AsyncQueue (cola de tareas) ===");

/**
 * Cola de tareas asíncronas que procesa una tarea a la vez.
 * Las tareas se encolan y se ejecutan secuencialmente.
 */
class AsyncQueue {
  constructor() {
    this._cola = [];       // tareas pendientes
    this._corriendo = false; // si hay una tarea en ejecución
  }

  /**
   * Agrega una tarea a la cola.
   * @param {Function} tarea - Función async a ejecutar
   * @returns {Promise<*>} Promise que resuelve cuando la tarea se ejecuta
   */
  enqueue(tarea) {
    return new Promise((resolve, reject) => {
      this._cola.push({ tarea, resolve, reject });
      this._procesarSiguiente();
    });
  }

  /**
   * Procesa la siguiente tarea en la cola si no hay ninguna corriendo.
   * @private
   */
  async _procesarSiguiente() {
    if (this._corriendo || this._cola.length === 0) return;
    this._corriendo = true;

    const { tarea, resolve, reject } = this._cola.shift();
    try {
      const resultado = await tarea();
      resolve(resultado);
    } catch (e) {
      reject(e);
    } finally {
      this._corriendo = false;
      this._procesarSiguiente(); // procesar la siguiente tarea
    }
  }
}

async function probarAsyncQueue() {
  const cola = new AsyncQueue();

  // Encolar 3 tareas que deben ejecutarse secuencialmente
  const t1 = cola.enqueue(() => simular("Tarea 1", 40));
  const t2 = cola.enqueue(() => simular("Tarea 2", 20));
  const t3 = cola.enqueue(() => simular("Tarea 3", 10));

  // Aunque t3 termina más rápido, debe ejecutarse después de t1 y t2
  const [r1, r2, r3] = await Promise.all([t1, t2, t3]);
  console.log("Cola procesó en orden:", r1, "→", r2, "→", r3);
}

setTimeout(() => probarAsyncQueue(), 900);

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Agrega concurrencia configurable a AsyncQueue (procesar N tareas en paralelo)
// 2. Agrega eventos onSuccess y onError a cargarEnParalelo
// 3. Implementa conTimeout como decorador: const fn = timeoutDecorator(apiFn, 500)
// 4. Combina reintentarAsync con conTimeout para operaciones resilientes
