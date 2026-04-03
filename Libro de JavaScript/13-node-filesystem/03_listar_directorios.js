// =============================================================================
// ARCHIVO: 03_listar_directorios.js
// TEMA: Listar, recorrer y filtrar contenido de directorios con Node.js
// =============================================================================
// CÓMO EJECUTAR: node 03_listar_directorios.js
// =============================================================================

'use strict';

const fs   = require('fs');
const path = require('path');

// Directorio base: usamos el módulo padre del proyecto actual como ejemplo
const DIR_BASE = path.join(__dirname, '..');

// =============================================================================
// SECCIÓN 1: Listar archivos de un directorio — readdir básico
// =============================================================================

console.log('=== 1. Listar directorio con readdir ===\n');

async function listarDirectorioBasico(directorio) {
  // Versión síncrona
  const archivosSync = fs.readdirSync(directorio);
  console.log(`[Sync] Contenido de ${path.basename(directorio)}:`);
  archivosSync.forEach((nombre) => console.log('  -', nombre));

  // Versión con promesas (recomendada)
  const archivos = await fs.promises.readdir(directorio);
  console.log(`\n[Async] Total de entradas: ${archivos.length}`);
  return archivos;
}

// =============================================================================
// SECCIÓN 2: Obtener información detallada con stat
// stat retorna tamaño, fechas, tipo (archivo/directorio)
// =============================================================================

async function listarConDetalles(directorio) {
  console.log('\n=== 2. Listar con detalles — stat ===\n');

  const entradas = await fs.promises.readdir(directorio);

  const detalles = await Promise.all(
    entradas.map(async (nombre) => {
      const ruta = path.join(directorio, nombre);
      try {
        const stat = await fs.promises.stat(ruta);
        return {
          nombre,
          tipo:      stat.isDirectory() ? 'DIR' : 'FILE',
          tamano:    stat.isFile() ? `${(stat.size / 1024).toFixed(1)} KB` : '-',
          modificado: stat.mtime.toLocaleDateString('es-ES'),
        };
      } catch {
        return { nombre, tipo: '???', tamano: '-', modificado: '-' };
      }
    })
  );

  // Mostrar como tabla
  console.log('Tipo   Tamaño      Modificado   Nombre');
  console.log('------ ----------- ------------ ------');
  detalles.forEach(({ tipo, tamano, modificado, nombre }) => {
    console.log(
      `${tipo.padEnd(6)} ${tamano.padEnd(11)} ${modificado.padEnd(12)} ${nombre}`
    );
  });

  return detalles;
}

// =============================================================================
// SECCIÓN 3: readdir con withFileTypes — más eficiente que stat por separado
// Retorna Dirent objects con isFile() y isDirectory() sin leer el disco extra
// =============================================================================

async function listarConDirent(directorio) {
  console.log('\n=== 3. readdir con withFileTypes (Dirent) ===\n');

  const entradas = await fs.promises.readdir(directorio, { withFileTypes: true });

  const archivos     = entradas.filter((e) => e.isFile());
  const subdirectorios = entradas.filter((e) => e.isDirectory());

  console.log(`Archivos (${archivos.length}):`);
  archivos.forEach((f) => console.log('  📄', f.name));

  console.log(`\nSubdirectorios (${subdirectorios.length}):`);
  subdirectorios.forEach((d) => console.log('  📁', d.name));

  return { archivos, subdirectorios };
}

// =============================================================================
// SECCIÓN 4: Filtrar archivos por extensión
// =============================================================================

async function filtrarPorExtension(directorio, extension) {
  console.log(`\n=== 4. Filtrar archivos .${extension} ===\n`);

  const entradas = await fs.promises.readdir(directorio, { withFileTypes: true });

  const filtrados = entradas
    .filter((e) => e.isFile() && e.name.endsWith(`.${extension}`))
    .map((e) => e.name);

  console.log(`Archivos .${extension} en ${path.basename(directorio)}:`);
  if (filtrados.length === 0) {
    console.log('  (ninguno)');
  } else {
    filtrados.forEach((f) => console.log('  -', f));
  }

  return filtrados;
}

// =============================================================================
// SECCIÓN 5: Recorrido recursivo de directorios
// Función recursiva para obtener TODOS los archivos incluyendo subdirectorios
// =============================================================================

/**
 * Recorre un directorio recursivamente y retorna todas las rutas de archivos.
 * Puede opcionalmente filtrar por extensión.
 * @param {string} directorio - Directorio raíz donde iniciar la búsqueda
 * @param {string|null} extension - Extensión a filtrar (sin punto), o null para todas
 * @param {number} profundidadMax - Límite de profundidad para evitar loops
 * @returns {Promise<string[]>} Array de rutas absolutas de archivos encontrados
 */
async function recorrerRecursivo(directorio, extension = null, profundidadMax = 5) {
  const archivosEncontrados = [];

  async function explorar(dir, profundidad) {
    // Detener si se alcanzó la profundidad máxima
    if (profundidad > profundidadMax) return;

    let entradas;
    try {
      entradas = await fs.promises.readdir(dir, { withFileTypes: true });
    } catch {
      return; // Sin permiso o directorio inaccesible
    }

    for (const entrada of entradas) {
      // Omitir node_modules y directorios ocultos
      if (entrada.name.startsWith('.') || entrada.name === 'node_modules') {
        continue;
      }

      const rutaCompleta = path.join(dir, entrada.name);

      if (entrada.isDirectory()) {
        // Llamada recursiva para el subdirectorio
        await explorar(rutaCompleta, profundidad + 1);
      } else if (entrada.isFile()) {
        // Agregar si coincide con el filtro de extensión (o si no hay filtro)
        const coincide = !extension || entrada.name.endsWith(`.${extension}`);
        if (coincide) {
          archivosEncontrados.push(rutaCompleta);
        }
      }
    }
  }

  await explorar(directorio, 0);
  return archivosEncontrados;
}

// =============================================================================
// SECCIÓN 6: Calcular tamaño total de un directorio
// =============================================================================

/**
 * Calcula el tamaño total en bytes de todos los archivos en un directorio.
 * Recorre recursivamente todos los subdirectorios.
 * @param {string} directorio - Ruta del directorio a analizar
 * @returns {Promise<number>} Tamaño total en bytes
 */
async function calcularTamatoDirectorio(directorio) {
  console.log('\n=== 6. Calcular tamaño total de un directorio ===\n');

  let totalBytes = 0;
  let totalArchivos = 0;

  async function sumarTamanos(dir) {
    let entradas;
    try {
      entradas = await fs.promises.readdir(dir, { withFileTypes: true });
    } catch {
      return;
    }

    for (const entrada of entradas) {
      if (entrada.name.startsWith('.') || entrada.name === 'node_modules') continue;

      const ruta = path.join(dir, entrada.name);

      if (entrada.isDirectory()) {
        await sumarTamanos(ruta);
      } else if (entrada.isFile()) {
        try {
          const stat = await fs.promises.stat(ruta);
          totalBytes += stat.size;
          totalArchivos++;
        } catch {
          // Omitir archivos inaccesibles
        }
      }
    }
  }

  await sumarTamanos(directorio);

  const tamanoKB = (totalBytes / 1024).toFixed(2);
  const tamanoMB = (totalBytes / 1024 ** 2).toFixed(3);

  console.log(`Directorio: ${path.basename(directorio)}`);
  console.log(`Archivos:   ${totalArchivos}`);
  console.log(`Tamaño:     ${tamanoKB} KB (${tamanoMB} MB)`);

  return { totalBytes, totalArchivos };
}

// Ejecutar todos los ejemplos
(async () => {
  try {
    await listarDirectorioBasico(DIR_BASE);
    await listarConDetalles(DIR_BASE);
    await listarConDirent(DIR_BASE);
    await filtrarPorExtension(DIR_BASE, 'md');

    console.log('\n=== 5. Recorrido recursivo ===\n');
    const archivosJS = await recorrerRecursivo(DIR_BASE, 'js', 3);
    console.log(`Archivos .js encontrados (max profundidad 3): ${archivosJS.length}`);
    archivosJS.slice(0, 8).forEach((f) => console.log(' ', path.relative(DIR_BASE, f)));
    if (archivosJS.length > 8) console.log(`  ... y ${archivosJS.length - 8} más`);

    await calcularTamatoDirectorio(DIR_BASE);

    console.log('\n✅ Módulo 13 — Listar directorios completado');
  } catch (err) {
    console.error('Error:', err.message);
  }
})();
