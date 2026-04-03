// =============================================================================
// ARCHIVO: 01_leer_archivos.js
// TEMA: Leer archivos con Node.js — síncrono, callbacks y async/await
// =============================================================================
// CÓMO EJECUTAR: node 01_leer_archivos.js
// =============================================================================

'use strict';

const fs   = require('fs');
const path = require('path');

// Ruta de este mismo archivo para usar como ejemplo de lectura
const ESTE_ARCHIVO = __filename;

// =============================================================================
// SECCIÓN 1: Lectura síncrona con fs.readFileSync()
// Bloquea el hilo de Node hasta que termina — útil en inicialización
// =============================================================================

console.log('=== 1. Lectura síncrona — fs.readFileSync() ===\n');

try {
  // Sin encoding → retorna Buffer (datos binarios)
  const buffer = fs.readFileSync(ESTE_ARCHIVO);
  console.log('Tipo sin encoding:', buffer.constructor.name); // Buffer
  console.log('Tamaño en bytes:  ', buffer.length);

  // Con encoding → retorna string directamente
  const contenido = fs.readFileSync(ESTE_ARCHIVO, 'utf8');
  const lineas = contenido.split('\n');
  console.log('Total de líneas:  ', lineas.length);
  console.log('Primera línea:    ', lineas[0]);
} catch (err) {
  // ENOENT = archivo no encontrado, EACCES = sin permiso
  console.error('Error leyendo archivo:', err.code, err.message);
}

// =============================================================================
// SECCIÓN 2: Lectura asíncrona con callback — fs.readFile()
// No bloquea, pero el código se anida (callback hell en casos complejos)
// =============================================================================

console.log('\n=== 2. Lectura con callback — fs.readFile() ===\n');

fs.readFile(ESTE_ARCHIVO, 'utf8', (err, contenido) => {
  if (err) {
    console.error('Error:', err.message);
    return;
  }
  const lineas = contenido.split('\n').length;
  console.log(`[Callback] Archivo leído: ${lineas} líneas`);
});

// =============================================================================
// SECCIÓN 3: Lectura con Promesas — fs.promises.readFile() (RECOMENDADO)
// Permite usar async/await, manejo de errores con try/catch
// =============================================================================

console.log('=== 3. Lectura con Promesas — fs.promises.readFile() ===\n');

async function leerArchivoConPromesas() {
  try {
    // Leer texto plano
    const contenido = await fs.promises.readFile(ESTE_ARCHIVO, 'utf8');
    const lineas = contenido.split('\n');
    console.log(`[Promesa] Archivo leído: ${lineas.length} líneas`);
    console.log('Últimas 3 líneas:');
    lineas.slice(-3).forEach((l) => console.log(' ', l));
  } catch (err) {
    console.error('Error:', err.code, '-', err.message);
  }
}

// =============================================================================
// SECCIÓN 4: Leer JSON desde archivo
// readFileSync + JSON.parse es el patrón más común para configuraciones
// =============================================================================

console.log('=== 4. Leer archivos JSON ===\n');

async function leerJSON() {
  // Crear un JSON temporal de ejemplo
  const archivoPrueba = path.join(__dirname, '_temp_datos.json');
  const datosEjemplo  = {
    nombre:   'Mi Aplicación',
    version:  '1.0.0',
    activo:   true,
    usuarios: [
      { id: 1, nombre: 'Ana',   rol: 'admin' },
      { id: 2, nombre: 'Carlos', rol: 'usuario' },
    ],
  };

  // Escribir el JSON temporal
  await fs.promises.writeFile(
    archivoPrueba,
    JSON.stringify(datosEjemplo, null, 2),
    'utf8'
  );

  // Leer y parsear el JSON
  const contenidoRaw = await fs.promises.readFile(archivoPrueba, 'utf8');
  const datos = JSON.parse(contenidoRaw);

  console.log('JSON leído:', datos.nombre, 'v' + datos.version);
  console.log('Usuarios:');
  datos.usuarios.forEach((u) => {
    console.log(`  - ${u.nombre} (${u.rol})`);
  });

  // Limpiar archivo temporal
  await fs.promises.unlink(archivoPrueba);
  console.log('Archivo temporal eliminado');
}

// =============================================================================
// SECCIÓN 5: Leer archivo que no existe — manejo de errores
// =============================================================================

async function manejarArchivoNoExistente() {
  console.log('\n=== 5. Manejo de errores al leer ===\n');

  const rutaInexistente = path.join(__dirname, 'archivo_que_no_existe.txt');

  try {
    await fs.promises.readFile(rutaInexistente, 'utf8');
  } catch (err) {
    // Tipos de errores comunes del sistema de archivos:
    // ENOENT  = No such file or directory
    // EACCES  = Permission denied
    // EISDIR  = Is a directory (intentaste leer un directorio como archivo)
    // EMFILE  = Too many open files
    console.log(`Error capturado correctamente:`);
    console.log(`  Código: ${err.code}`);
    console.log(`  Ruta:   ${err.path}`);
    console.log(`  Acción: mostrar mensaje amigable al usuario`);
  }
}

// =============================================================================
// SECCIÓN 6: Leer archivo grande en streaming (para archivos > 100MB)
// fs.createReadStream evita cargar todo en memoria
// =============================================================================

function mostrarEjemploStream() {
  console.log('\n=== 6. Lectura en streaming (para archivos grandes) ===\n');

  console.log(`
// Para archivos grandes, usa streams en lugar de readFile
const stream = fs.createReadStream('archivo-grande.csv', {
  encoding: 'utf8',
  highWaterMark: 64 * 1024, // leer de 64KB en 64KB
});

let totalBytes = 0;

stream.on('data', (chunk) => {
  totalBytes += chunk.length;
  // Procesar cada fragmento sin cargar todo en memoria
});

stream.on('end', () => {
  console.log('Lectura completa:', totalBytes, 'bytes');
});

stream.on('error', (err) => {
  console.error('Error en stream:', err.message);
});
  `);
}

// Ejecutar todos los ejemplos en orden
(async () => {
  await leerArchivoConPromesas();
  await leerJSON();
  await manejarArchivoNoExistente();
  mostrarEjemploStream();
  console.log('\n✅ Módulo 13 — Leer archivos completado');
})();
