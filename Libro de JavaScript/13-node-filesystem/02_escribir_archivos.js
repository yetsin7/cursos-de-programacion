// =============================================================================
// ARCHIVO: 02_escribir_archivos.js
// TEMA: Escribir archivos, crear directorios, copiar y verificar existencia
// =============================================================================
// CÓMO EJECUTAR: node 02_escribir_archivos.js
// =============================================================================

'use strict';

const fs   = require('fs');
const path = require('path');

// Directorio base para todos los archivos temporales de este script
const DIR_TEMP = path.join(__dirname, '_temp_escritura');

// =============================================================================
// SECCIÓN 1: Crear directorio con mkdir
// { recursive: true } evita error si ya existe y crea directorios anidados
// =============================================================================

async function crearDirectorios() {
  console.log('=== 1. Crear directorios con mkdir ===\n');

  // Crear directorio principal y subdirectorios de una sola vez
  const dirAnidado = path.join(DIR_TEMP, 'subdir', 'profundo');

  await fs.promises.mkdir(dirAnidado, { recursive: true });
  console.log('Directorio creado:', dirAnidado);

  // Verificar que existe
  const existe = fs.existsSync(dirAnidado);
  console.log('¿Existe?', existe);
}

// =============================================================================
// SECCIÓN 2: Escribir archivos con writeFile
// Sobreescribe el archivo si ya existe; lo crea si no existe
// =============================================================================

async function escribirArchivos() {
  console.log('\n=== 2. Escribir archivos con writeFile ===\n');

  const archivoTexto = path.join(DIR_TEMP, 'nota.txt');

  // Escritura síncrona — útil en scripts de inicialización
  fs.writeFileSync(archivoTexto, 'Primera línea (síncrono)\n', 'utf8');
  console.log('Escrito síncronamente:', archivoTexto);

  // Escritura con promesas (recomendada)
  await fs.promises.writeFile(
    archivoTexto,
    'Contenido reemplazado con fs.promises.writeFile\n',
    'utf8'
  );
  console.log('Sobreescrito con promesas:', archivoTexto);

  // Leer para verificar
  const leido = await fs.promises.readFile(archivoTexto, 'utf8');
  console.log('Contenido actual:', leido.trim());
}

// =============================================================================
// SECCIÓN 3: Agregar contenido al final con appendFile
// No sobreescribe, agrega al final del archivo
// =============================================================================

async function agregarAlFinal() {
  console.log('\n=== 3. Agregar al final con appendFile ===\n');

  const archivoLog = path.join(DIR_TEMP, 'registro.log');

  // Simular un sistema de logs básico
  const entradas = [
    'INFO  — Aplicación iniciada',
    'DEBUG — Conectando a la base de datos',
    'INFO  — Servidor escuchando en puerto 3000',
    'WARN  — Memoria alta: 85%',
  ];

  // Agregar cada entrada como nueva línea
  for (const entrada of entradas) {
    const linea = `[${new Date().toISOString()}] ${entrada}\n`;
    await fs.promises.appendFile(archivoLog, linea, 'utf8');
  }

  // Leer el log completo para verificar
  const log = await fs.promises.readFile(archivoLog, 'utf8');
  console.log('Archivo de log generado:');
  log.split('\n').filter(Boolean).forEach((l) => console.log(' ', l));

  // Versión síncrona (menos común)
  fs.appendFileSync(archivoLog, '[sync] Línea agregada síncronamente\n', 'utf8');
  console.log('\nLínea síncrona agregada');
}

// =============================================================================
// SECCIÓN 4: Escribir y leer JSON
// Patrón muy común para persistir configuraciones o datos locales
// =============================================================================

async function manejarJSON() {
  console.log('\n=== 4. Escribir y leer JSON ===\n');

  const archivoJSON = path.join(DIR_TEMP, 'config.json');

  // Objeto a persistir
  const configuracion = {
    version:        '2.0.0',
    idioma:         'es',
    temaOscuro:     true,
    maxIntentos:    3,
    servidores:     ['api1.ejemplo.com', 'api2.ejemplo.com'],
    ultimaActualizacion: new Date().toISOString(),
  };

  // JSON.stringify con indentación de 2 espacios para legibilidad
  await fs.promises.writeFile(
    archivoJSON,
    JSON.stringify(configuracion, null, 2),
    'utf8'
  );
  console.log('JSON escrito:', archivoJSON);

  // Leer y parsear de vuelta
  const raw    = await fs.promises.readFile(archivoJSON, 'utf8');
  const leido  = JSON.parse(raw);
  console.log('JSON leído — versión:', leido.version);
  console.log('Servidores:', leido.servidores.join(', '));

  // Actualizar solo una propiedad (patrón read-modify-write)
  leido.idioma = 'en';
  await fs.promises.writeFile(archivoJSON, JSON.stringify(leido, null, 2), 'utf8');
  console.log('JSON actualizado — idioma cambiado a:', leido.idioma);
}

// =============================================================================
// SECCIÓN 5: Verificar existencia y copiar archivos
// =============================================================================

async function verificarYCopiar() {
  console.log('\n=== 5. Verificar existencia y copiar archivos ===\n');

  const origen  = path.join(DIR_TEMP, 'config.json');
  const destino = path.join(DIR_TEMP, 'subdir', 'config.backup.json');

  // fs.existsSync — verificación síncrona simple
  if (fs.existsSync(origen)) {
    console.log('Archivo origen existe:', origen);

    // Copiar archivo (sobreescribe destino si existe)
    await fs.promises.copyFile(origen, destino);
    console.log('Copia creada en:', destino);

    // Alternativa síncrona
    // fs.copyFileSync(origen, destino);
  } else {
    console.log('Archivo origen no encontrado — omitiendo copia');
  }

  // Verificar si algo es archivo o directorio con stat
  try {
    const stat = await fs.promises.stat(DIR_TEMP);
    console.log('\nInfo del directorio temp:');
    console.log('  Es directorio:', stat.isDirectory());
    console.log('  Es archivo:   ', stat.isFile());
    console.log('  Última modificación:', stat.mtime.toLocaleString());
  } catch (err) {
    console.error('Error stat:', err.message);
  }
}

// =============================================================================
// SECCIÓN 6: Renombrar y mover archivos
// fs.rename también mueve archivos entre rutas del mismo volumen
// =============================================================================

async function renombrarArchivo() {
  console.log('\n=== 6. Renombrar y mover archivos ===\n');

  const nombreOriginal = path.join(DIR_TEMP, 'nota.txt');
  const nombreNuevo    = path.join(DIR_TEMP, 'nota_renombrada.txt');

  if (fs.existsSync(nombreOriginal)) {
    await fs.promises.rename(nombreOriginal, nombreNuevo);
    console.log('Renombrado de:', path.basename(nombreOriginal));
    console.log('          a: ', path.basename(nombreNuevo));
  }
}

// =============================================================================
// SECCIÓN 7: Limpieza — eliminar directorio temporal recursivamente
// =============================================================================

async function limpiarTemporal() {
  console.log('\n=== 7. Limpieza de archivos temporales ===\n');

  if (fs.existsSync(DIR_TEMP)) {
    // rm con recursive elimina directorio y todo su contenido (Node 14.14+)
    await fs.promises.rm(DIR_TEMP, { recursive: true, force: true });
    console.log('Directorio temporal eliminado:', DIR_TEMP);
  }
}

// Ejecutar todas las secciones en orden
(async () => {
  try {
    await crearDirectorios();
    await escribirArchivos();
    await agregarAlFinal();
    await manejarJSON();
    await verificarYCopiar();
    await renombrarArchivo();
    await limpiarTemporal();
    console.log('\n✅ Módulo 13 — Escribir archivos completado');
  } catch (err) {
    console.error('Error inesperado:', err.message);
  }
})();
