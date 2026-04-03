// ============================================================
// ARCHIVO: 02_promises.js
// TEMA: Promises: creación, estados, then/catch/finally, métodos estáticos
// CÓMO EJECUTAR: node 02_promises.js
// ============================================================

// ── Qué es una Promise ────────────────────────────────────────
// Una Promise representa el resultado eventual de una operación asíncrona.
// Tiene tres estados:
// - pending:   operación en curso — aún no tiene resultado
// - fulfilled: operación completada con éxito — tiene un valor
// - rejected:  operación fallida — tiene una razón de error
console.log("=== Crear una Promise ===");

/**
 * Simula una operación asíncrona que puede tener éxito o fallar.
 * @param {boolean} exito - Si true, la promise se resuelve; si false, rechaza
 * @returns {Promise<string>} Promesa con el resultado
 */
function operacionAsync(exito) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      if (exito) {
        resolve("Operación exitosa"); // cambia estado a fulfilled
      } else {
        reject(new Error("Operación fallida")); // cambia estado a rejected
      }
    }, 50);
  });
}

operacionAsync(true)
  .then(resultado => console.log("then:", resultado))
  .catch(error => console.log("catch:", error.message));

operacionAsync(false)
  .then(resultado => console.log("then:", resultado))
  .catch(error => console.log("catch:", error.message));

// ── .then() .catch() .finally() ───────────────────────────────
// .then(onFulfilled):  se ejecuta cuando la promise se resuelve
// .catch(onRejected):  se ejecuta cuando la promise es rechazada
// .finally(onFinally): se ejecuta siempre, sin importar el resultado
console.log("\n=== then / catch / finally ===");

function simularAPI(url) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      if (url.startsWith("https")) {
        resolve({ data: `Respuesta de ${url}`, status: 200 });
      } else {
        reject(new Error(`URL insegura: ${url}`));
      }
    }, 30);
  });
}

simularAPI("https://api.ejemplo.com/datos")
  .then(respuesta => {
    console.log("Status:", respuesta.status);
    return respuesta.data; // el valor retornado pasa al siguiente .then()
  })
  .then(data => {
    console.log("Data:", data);
  })
  .catch(error => {
    console.log("Error de red:", error.message);
  })
  .finally(() => {
    console.log("Petición terminada (finally)");
  });

// ── Promise.resolve() y Promise.reject() ──────────────────────
// Crean promises ya resueltas o rechazadas inmediatamente
// Útiles para devolver valores síncronos como promises (APIs uniformes)
console.log("\n=== Promise.resolve / Promise.reject ===");

Promise.resolve(42)
  .then(v => console.log("Resolve inmediato:", v)); // 42

Promise.reject(new Error("error inmediato"))
  .catch(e => console.log("Reject inmediato:", e.message));

// ── Promise.all() ─────────────────────────────────────────────
// Ejecuta múltiples promises en PARALELO
// Espera a que TODAS se resuelvan — si UNA falla, todo falla
console.log("\n=== Promise.all (paralelo, falla si una falla) ===");

const p1 = new Promise(r => setTimeout(() => r("P1"), 30));
const p2 = new Promise(r => setTimeout(() => r("P2"), 10));
const p3 = new Promise(r => setTimeout(() => r("P3"), 20));

Promise.all([p1, p2, p3])
  .then(resultados => {
    // El orden del array coincide con el orden de las promises, no el de resolución
    console.log("Promise.all:", resultados); // ['P1', 'P2', 'P3']
  });

// Si una falla, todo el .all falla
const conFalla = [
  Promise.resolve("OK"),
  Promise.reject(new Error("Falló P2")),
  Promise.resolve("OK"),
];

Promise.all(conFalla)
  .then(r => console.log("No llega aquí"))
  .catch(e => console.log("Promise.all falla:", e.message));

// ── Promise.allSettled() ──────────────────────────────────────
// Espera TODAS las promises, hayan fallado o no
// Retorna array con estado de cada una: { status, value } o { status, reason }
console.log("\n=== Promise.allSettled (espera todas) ===");

const mixtas = [
  Promise.resolve("Éxito 1"),
  Promise.reject(new Error("Error 2")),
  Promise.resolve("Éxito 3"),
];

Promise.allSettled(mixtas)
  .then(resultados => {
    resultados.forEach((r, i) => {
      if (r.status === "fulfilled") {
        console.log(`P${i + 1} resuelta:`, r.value);
      } else {
        console.log(`P${i + 1} rechazada:`, r.reason.message);
      }
    });
  });

// ── Promise.race() ────────────────────────────────────────────
// La PRIMERA promise que resuelva (o rechace) gana — las demás se ignoran
// Útil para implementar timeouts
console.log("\n=== Promise.race (la primera gana) ===");

const lenta = new Promise(r => setTimeout(() => r("Respuesta lenta"), 200));
const rapida = new Promise(r => setTimeout(() => r("Respuesta rápida"), 30));
const timeout = new Promise((_, rej) => setTimeout(() => rej(new Error("Timeout!")), 100));

Promise.race([lenta, rapida, timeout])
  .then(r => console.log("race ganó:", r))        // "Respuesta rápida"
  .catch(e => console.log("race error:", e.message));

// ── Promise.any() ────────────────────────────────────────────
// La primera promise que resuelva EXITOSAMENTE gana
// Si TODAS fallan, lanza AggregateError
// Diferencia con race: ignora rechazos hasta que una tenga éxito
console.log("\n=== Promise.any (primera exitosa) ===");

const todasFallan = [
  Promise.reject(new Error("Error A")),
  Promise.reject(new Error("Error B")),
  Promise.resolve("Primera exitosa"),
];

Promise.any(todasFallan)
  .then(r => console.log("any exitosa:", r)) // "Primera exitosa"
  .catch(e => console.log("Todas fallaron:", e.message));

// ── EXPERIMENTA ───────────────────────────────────────────────
// EXPERIMENTA:
// 1. Crea una función timeout(ms) que retorna una Promise rechazada tras N ms
// 2. Implementa un sistema de reintentos usando Promises recursivamente
// 3. Usa Promise.allSettled para cargar múltiples recursos y reportar cuáles fallaron
// 4. Encadena 5 .then() y observa cómo fluye el valor transformado entre ellos
