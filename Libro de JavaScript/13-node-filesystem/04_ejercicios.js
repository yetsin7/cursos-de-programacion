// =============================================================================
// ARCHIVO: 04_ejercicios.js
// TEMA: Ejercicios — Sistema de archivos con Node.js
// =============================================================================
// CÓMO EJECUTAR: node 04_ejercicios.js
// =============================================================================

'use strict';

const fs   = require('fs');
const path = require('path');

const DIR_TRABAJO = path.join(__dirname, '_ejercicios_temp');

// =============================================================================
// EJERCICIO 1: Crear una estructura de proyecto
// Genera la estructura de carpetas de un proyecto web estándar
// =============================================================================

async function ejercicio1_estructuraProyecto() {
  console.log('=== EJERCICIO 1: Crear estructura de proyecto ===\n');

  const estructura = [
    'src/components',
    'src/pages',
    'src/utils',
    'src/styles',
    'public/images',
    'tests',
    'docs',
  ];

  for (const dir of estructura) {
    const ruta = path.join(DIR_TRABAJO, dir);
    await fs.promises.mkdir(ruta, { recursive: true });
  }

  // Crear archivos placeholder en cada directorio
  const archivosIniciales = [
    ['src/utils/helpers.js',   '// Funciones de utilidad\n'],
    ['src/styles/main.css',    '/* Estilos principales */\n'],
    ['public/index.html',      '<!DOCTYPE html>\n<html>\n</html>\n'],
    ['README.md',              '# Mi Proyecto\n\nDescripción aquí.\n'],
    ['.gitignore',             'node_modules/\ndist/\n.env\n'],
  ];

  for (const [rutaRel, contenido] of archivosIniciales) {
    const rutaCompleta = path.join(DIR_TRABAJO, rutaRel);
    await fs.promises.mkdir(path.dirname(rutaCompleta), { recursive: true });
    await fs.promises.writeFile(rutaCompleta, contenido, 'utf8');
  }

  console.log('Estructura de proyecto creada en:', DIR_TRABAJO);
  console.log('Directorios creados:', estructura.length);
  console.log('Archivos creados:', archivosIniciales.length);
}

// =============================================================================
// EJERCICIO 2: Buscador de archivos por extensión
// Recorre un directorio y devuelve todos los archivos de cierto tipo
// =============================================================================

async function ejercicio2_buscadorArchivos(dirRaiz, extensiones) {
  console.log('\n=== EJERCICIO 2: Buscador de archivos por extensión ===\n');

  /**
   * Busca archivos con las extensiones dadas de forma recursiva.
   * @param {string} dir - Directorio donde buscar
   * @param {string[]} exts - Extensiones a buscar (sin punto)
   * @returns {Promise<Map<string, string[]>>} Mapa extensión → rutas de archivos
   */
  async function buscar(dir, exts) {
    const resultado = new Map(exts.map((e) => [e, []]));

    async function explorar(d) {
      let entradas;
      try {
        entradas = await fs.promises.readdir(d, { withFileTypes: true });
      } catch {
        return;
      }

      for (const entrada of entradas) {
        if (entrada.name.startsWith('.') || entrada.name === 'node_modules') continue;
        const ruta = path.join(d, entrada.name);

        if (entrada.isDirectory()) {
          await explorar(ruta);
        } else {
          const ext = path.extname(entrada.name).slice(1); // sin el punto
          if (resultado.has(ext)) {
            resultado.get(ext).push(path.relative(dirRaiz, ruta));
          }
        }
      }
    }

    await explorar(dir);
    return resultado;
  }

  const encontrados = await buscar(dirRaiz, extensiones);

  console.log(`Buscando en: ${path.basename(dirRaiz)}`);
  for (const [ext, archivos] of encontrados) {
    console.log(`\n.${ext} — ${archivos.length} archivos:`);
    archivos.forEach((f) => console.log('  -', f));
  }
}

// =============================================================================
// EJERCICIO 3: Sistema de respaldos (backup)
// Copia archivos .json de un directorio a una carpeta de backup con timestamp
// =============================================================================

async function ejercicio3_sistemaBackup(dirOrigen) {
  console.log('\n=== EJERCICIO 3: Sistema de respaldos ===\n');

  // Crear algunos JSON de ejemplo para respaldar
  const datosEjemplo = [
    { archivo: 'usuarios.json',  datos: [{ id: 1, nombre: 'Ana' }] },
    { archivo: 'productos.json', datos: [{ id: 1, producto: 'Laptop' }] },
    { archivo: 'config.json',    datos: { version: '1.0', idioma: 'es' } },
  ];

  for (const { archivo, datos } of datosEjemplo) {
    await fs.promises.writeFile(
      path.join(dirOrigen, archivo),
      JSON.stringify(datos, null, 2),
      'utf8'
    );
  }

  // Crear directorio de backup con timestamp
  const timestamp   = new Date().toISOString().replace(/[:.]/g, '-').slice(0, 19);
  const dirBackup   = path.join(dirOrigen, 'backups', timestamp);
  await fs.promises.mkdir(dirBackup, { recursive: true });

  // Copiar todos los .json al backup
  const entradas    = await fs.promises.readdir(dirOrigen, { withFileTypes: true });
  const archivosJSON = entradas.filter(
    (e) => e.isFile() && e.name.endsWith('.json')
  );

  for (const archivo of archivosJSON) {
    const origen  = path.join(dirOrigen, archivo.name);
    const destino = path.join(dirBackup, archivo.name);
    await fs.promises.copyFile(origen, destino);
  }

  console.log(`Backup creado: ${path.relative(DIR_TRABAJO, dirBackup)}`);
  console.log(`Archivos respaldados: ${archivosJSON.length}`);
}

// =============================================================================
// EJERCICIO 4: Contador de líneas de código
// Cuenta líneas de todos los .js en un directorio
// =============================================================================

async function ejercicio4_contadorLineas(directorio) {
  console.log('\n=== EJERCICIO 4: Contador de líneas de código ===\n');

  /**
   * Cuenta las líneas de todos los archivos .js en un directorio.
   * Retorna un resumen con total de archivos y líneas encontradas.
   * @param {string} dir - Directorio a analizar
   * @returns {Promise<object>} Estadísticas de líneas de código
   */
  async function contarLineas(dir) {
    const entradas = await fs.promises.readdir(dir, { withFileTypes: true });
    const resultados = [];

    for (const entrada of entradas) {
      if (!entrada.isFile() || !entrada.name.endsWith('.js')) continue;

      const ruta     = path.join(dir, entrada.name);
      const contenido = await fs.promises.readFile(ruta, 'utf8');
      const lineas   = contenido.split('\n');
      const noVacias = lineas.filter((l) => l.trim().length > 0).length;
      const comentarios = lineas.filter((l) => l.trim().startsWith('//')).length;

      resultados.push({
        archivo:     entrada.name,
        totalLineas: lineas.length,
        noVacias,
        comentarios,
        codigo:      noVacias - comentarios,
      });
    }

    return resultados;
  }

  const stats = await contarLineas(directorio);

  if (stats.length === 0) {
    console.log('No se encontraron archivos .js en:', path.basename(directorio));
  } else {
    console.log('Archivo                       Total  Código  Comentarios');
    console.log('------------------------------------------------------------');
    stats.forEach(({ archivo, totalLineas, codigo, comentarios }) => {
      console.log(
        `${archivo.padEnd(30)} ${String(totalLineas).padStart(5)}  ` +
        `${String(codigo).padStart(6)}  ${String(comentarios).padStart(11)}`
      );
    });

    const totales = stats.reduce(
      (acc, s) => ({
        lineas:      acc.lineas + s.totalLineas,
        codigo:      acc.codigo + s.codigo,
        comentarios: acc.comentarios + s.comentarios,
      }),
      { lineas: 0, codigo: 0, comentarios: 0 }
    );

    console.log('------------------------------------------------------------');
    console.log(`${'TOTAL'.padEnd(30)} ${String(totales.lineas).padStart(5)}  ${String(totales.codigo).padStart(6)}  ${String(totales.comentarios).padStart(11)}`);
  }
}

// =============================================================================
// LIMPIEZA: eliminar archivos temporales creados por los ejercicios
// =============================================================================

async function limpiar() {
  if (fs.existsSync(DIR_TRABAJO)) {
    await fs.promises.rm(DIR_TRABAJO, { recursive: true, force: true });
    console.log('\nDirectorio de ejercicios eliminado:', DIR_TRABAJO);
  }
}

// Ejecutar todos los ejercicios
(async () => {
  try {
    await fs.promises.mkdir(DIR_TRABAJO, { recursive: true });

    await ejercicio1_estructuraProyecto();
    await ejercicio2_buscadorArchivos(path.join(__dirname, '..'), ['js', 'md']);
    await ejercicio3_sistemaBackup(DIR_TRABAJO);
    await ejercicio4_contadorLineas(__dirname);
    await limpiar();

    console.log('\n✅ Ejercicios del Módulo 13 completados');
  } catch (err) {
    console.error('Error:', err.message);
    console.error(err.stack);
  }
})();
