// ============================================================
// ARCHIVO: 03_async_performance.js
// TEMA: Rendimiento en código asíncrono — paralelo vs serie
// CÓMO EJECUTAR: node 03_async_performance.js
// ============================================================

'use strict';

// ─── UTILIDAD: simular delay de red ──────────────────────────
/**
 * Simula una operación asíncrona con latencia (ej: llamada a API).
 * @param {string} nombre - Nombre de la operación para logging
 * @param {number} ms - Tiempo de espera simulado en milisegundos
 * @returns {Promise<string>} Resultado de la operación
 */
const operacionAsync = (nombre, ms) =>
  new Promise((resolve) =>
    setTimeout(() => resolve(`✅ ${nombre} (${ms}ms)`), ms)
  );

// ─── 1. ANTI-PATRÓN: await EN SERIE ──────────────────────────
// Cada await espera a que termine el anterior antes de empezar.
// El tiempo total es la SUMA de todos los tiempos.
// Solo tiene sentido si cada operación depende del resultado de la anterior.

console.log('=== 1. await en serie (anti-patrón) ===');

async function cargarEnSerie() {
  console.time('serie');
  const usuario = await operacionAsync('obtener usuario', 200);
  const permisos = await operacionAsync('obtener permisos', 150);
  const config = await operacionAsync('obtener configuración', 100);
  console.timeEnd('serie'); // ≈ 450ms (200 + 150 + 100)
  return [usuario, permisos, config];
}

// ─── 2. MEJOR: Promise.all PARA PARALELO ─────────────────────
// Todas las promesas se inician al mismo tiempo.
// El tiempo total es el de LA MÁS LENTA, no la suma.
// Si alguna falla, Promise.all falla inmediatamente (fail-fast).

console.log('\n=== 2. Promise.all — paralelo ===');

async function cargarEnParalelo() {
  console.time('paralelo');
  // Las tres operaciones se inician SIMULTÁNEAMENTE
  const [usuario, permisos, config] = await Promise.all([
    operacionAsync('obtener usuario', 200),
    operacionAsync('obtener permisos', 150),
    operacionAsync('obtener configuración', 100),
  ]);
  console.timeEnd('paralelo'); // ≈ 200ms (solo la más lenta)
  return [usuario, permisos, config];
}

// ─── 3. Promise.allSettled CUANDO NECESITAS TODOS ────────────
// A diferencia de Promise.all, NO falla si alguna promesa falla.
// Devuelve SIEMPRE todos los resultados, con status fulfilled/rejected.
// Ideal cuando quieres continuar aunque algunas operaciones fallen.

console.log('\n=== 3. Promise.allSettled — todos los resultados ===');

async function cargarConFallos() {
  const promesas = [
    operacionAsync('API principal', 100),
    Promise.reject(new Error('API secundaria sin conexión')), // Esta falla
    operacionAsync('API de caché', 80),
  ];

  console.time('allSettled');
  const resultados = await Promise.allSettled(promesas);
  console.timeEnd('allSettled');

  // Inspeccionar cada resultado individualmente
  resultados.forEach((resultado, i) => {
    if (resultado.status === 'fulfilled') {
      console.log(`  Promesa ${i + 1}: OK →`, resultado.value);
    } else {
      console.log(`  Promesa ${i + 1}: FALLÓ →`, resultado.reason.message);
    }
  });

  // Separar éxitos de fallos
  const exitosos = resultados.filter((r) => r.status === 'fulfilled').map((r) => r.value);
  console.log('  Solo exitosos:', exitosos);
}

// ─── 4. STREAMS PARA ARCHIVOS GRANDES ────────────────────────
// Leer un archivo completo con fs.readFile carga TODO en memoria.
// Con streams se procesa en chunks — memoria constante sin importar el tamaño.

console.log('\n=== 4. Streams vs readFile ===');

const fs = require('fs');
const path = require('path');
const os = require('os');

async function demoStreams() {
  // Crear un archivo temporal de prueba
  const archivoTemp = path.join(os.tmpdir(), 'test_stream.txt');
  const contenido = 'Línea de texto de prueba\n'.repeat(10_000);
  fs.writeFileSync(archivoTemp, contenido, 'utf8');

  const tamano = (fs.statSync(archivoTemp).size / 1024).toFixed(1);
  console.log(`  Archivo de prueba: ${tamano} KB`);

  // Enfoque 1: readFile — carga TODO en memoria de una vez
  console.time('  readFile completo');
  const todoElContenido = fs.readFileSync(archivoTemp, 'utf8');
  const lineas1 = todoElContenido.split('\n').length;
  console.timeEnd('  readFile completo');
  console.log(`  readFile: ${lineas1} líneas, memoria usada: ${(process.memoryUsage().heapUsed / 1024 / 1024).toFixed(1)} MB`);

  // Enfoque 2: stream — procesa chunk a chunk, memoria constante
  await new Promise((resolve, reject) => {
    let lineasContadas = 0;
    console.time('  stream por chunks');

    // readline procesa línea a línea sin cargar el archivo completo
    const readline = require('readline');
    const rl = readline.createInterface({
      input: fs.createReadStream(archivoTemp, { encoding: 'utf8' }),
      crlfDelay: Infinity,
    });

    rl.on('line', () => lineasContadas++);
    rl.on('close', () => {
      console.timeEnd('  stream por chunks');
      console.log(`  Stream: ${lineasContadas} líneas procesadas`);
      resolve();
    });
    rl.on('error', reject);
  });

  // Limpiar archivo temporal
  fs.unlinkSync(archivoTemp);
}

// ─── 5. setImmediate PARA NO BLOQUEAR EL EVENT LOOP ──────────
// Si tienes trabajo pesado en CPU, dividirlo con setImmediate
// permite que el event loop procese otras tareas entre chunks.

console.log('\n=== 5. setImmediate — trabajo sin bloquear ===');

/**
 * Procesa un array grande en chunks sin bloquear el event loop.
 * Usa setImmediate para ceder el control entre cada chunk.
 * @param {Array} datos - Array de datos a procesar
 * @param {Function} procesarChunk - Función a aplicar a cada chunk
 * @param {number} tamanoChunk - Tamaño de cada porción
 * @returns {Promise<void>}
 */
function procesarSinBloquear(datos, procesarChunk, tamanoChunk = 1000) {
  return new Promise((resolve) => {
    let indice = 0;

    function paso() {
      const fin = Math.min(indice + tamanoChunk, datos.length);
      procesarChunk(datos.slice(indice, fin));
      indice = fin;

      if (indice < datos.length) {
        // setImmediate cede el control al event loop antes del siguiente chunk
        // Permite que I/O, timers y otras callbacks se ejecuten entre chunks
        setImmediate(paso);
      } else {
        resolve();
      }
    }

    paso();
  });
}

// ─── EJECUTAR TODAS LAS DEMOS ─────────────────────────────────

async function main() {
  // Serie vs paralelo
  const resultadosSerie = await cargarEnSerie();
  console.log('Resultados serie:', resultadosSerie.length, 'items');

  const resultadosParalelo = await cargarEnParalelo();
  console.log('Resultados paralelo:', resultadosParalelo.length, 'items');

  // allSettled con fallos
  await cargarConFallos();

  // Streams
  await demoStreams();

  // setImmediate — procesar 50,000 items sin bloquear
  console.time('  procesarSinBloquear (50k items)');
  let totalProcesado = 0;
  await procesarSinBloquear(
    Array.from({ length: 50_000 }, (_, i) => i),
    (chunk) => { totalProcesado += chunk.length; },
    5_000
  );
  console.timeEnd('  procesarSinBloquear (50k items)');
  console.log('  Items procesados sin bloquear:', totalProcesado);

  console.log('\n✅ Demos de rendimiento asíncrono completadas.');
}

main().catch((err) => {
  console.error('Error:', err.message);
  process.exit(1);
});
