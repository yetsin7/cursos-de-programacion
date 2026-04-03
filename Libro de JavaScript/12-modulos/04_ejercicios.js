// =============================================================================
// ARCHIVO: 04_ejercicios.js
// TEMA: Ejercicios — Módulos en JavaScript
// =============================================================================
// CÓMO EJECUTAR: node 04_ejercicios.js
// =============================================================================

'use strict';

const path = require('path');
const os   = require('os');
const fs   = require('fs');
const util = require('util');
const { URL } = require('url');

// =============================================================================
// EJERCICIO 1: Explorador de rutas
// Dado un array de rutas, extrae información de cada una
// =============================================================================

console.log('=== EJERCICIO 1: Explorador de rutas ===\n');

/**
 * Analiza un array de rutas y retorna información detallada de cada una.
 * Usa el módulo path para extraer directorio, nombre y extensión.
 * @param {string[]} rutas - Array de rutas a analizar
 * @returns {object[]} Array de objetos con la info de cada ruta
 */
function analizarRutas(rutas) {
  return rutas.map((ruta) => ({
    original:   ruta,
    directorio: path.dirname(ruta),
    archivo:    path.basename(ruta),
    nombre:     path.basename(ruta, path.extname(ruta)),
    extension:  path.extname(ruta),
    esAbsoluta: path.isAbsolute(ruta),
  }));
}

const rutasDePrueba = [
  '/usuarios/juan/documentos/informe.pdf',
  'src/componentes/Boton.jsx',
  'C:\\Windows\\System32\\cmd.exe',
  './config/settings.json',
];

const resultados = analizarRutas(rutasDePrueba);
resultados.forEach((r) => {
  console.log(`Ruta: ${r.original}`);
  console.log(`  Directorio: ${r.directorio}`);
  console.log(`  Archivo:    ${r.archivo}`);
  console.log(`  Nombre:     ${r.nombre}`);
  console.log(`  Extensión:  ${r.extension}`);
  console.log(`  Absoluta:   ${r.esAbsoluta}\n`);
});

// =============================================================================
// EJERCICIO 2: Reporte del sistema
// Genera un reporte con información del sistema usando el módulo os
// =============================================================================

console.log('=== EJERCICIO 2: Reporte del sistema ===\n');

/**
 * Genera un reporte con información del sistema operativo y hardware.
 * Formatea los valores en unidades legibles (GB, horas).
 * @returns {object} Objeto con datos del sistema formateados
 */
function generarReporteSistema() {
  const bytesAGB = (bytes) => (bytes / 1024 ** 3).toFixed(2);

  return {
    plataforma:    os.platform(),
    arquitectura:  os.arch(),
    hostname:      os.hostname(),
    home:          os.homedir(),
    cpus:          os.cpus().length,
    modelCPU:      os.cpus()[0]?.model.trim() ?? 'desconocido',
    memoriaTotal:  `${bytesAGB(os.totalmem())} GB`,
    memoriaUsada:  `${bytesAGB(os.totalmem() - os.freemem())} GB`,
    memoriaLibre:  `${bytesAGB(os.freemem())} GB`,
    uptimeHoras:   `${(os.uptime() / 3600).toFixed(1)} horas`,
  };
}

const reporte = generarReporteSistema();
console.log('Reporte del sistema:');
Object.entries(reporte).forEach(([clave, valor]) => {
  console.log(`  ${clave.padEnd(16)}: ${valor}`);
});

// =============================================================================
// EJERCICIO 3: Analizador de argumentos CLI
// Parsea los argumentos pasados por línea de comandos
// =============================================================================

console.log('\n=== EJERCICIO 3: Analizador de argumentos CLI ===\n');
console.log('Tip: ejecuta con argumentos, ej: node 04_ejercicios.js --nombre=Juan --edad=30\n');

/**
 * Parsea los argumentos de process.argv en formato --clave=valor.
 * Ignora los primeros 2 elementos (node y el nombre del script).
 * @returns {object} Objeto con los argumentos parseados
 */
function parsearArgumentos() {
  const args = process.argv.slice(2);
  const resultado = {};

  args.forEach((arg) => {
    if (arg.startsWith('--')) {
      const sinPrefijo = arg.slice(2);
      const [clave, valor] = sinPrefijo.split('=');
      resultado[clave] = valor ?? true; // si no tiene valor, es un flag booleano
    }
  });

  return resultado;
}

const argumentos = parsearArgumentos();
console.log('Argumentos recibidos:', argumentos);

if (Object.keys(argumentos).length === 0) {
  console.log('(No se pasaron argumentos — ejecuta con --nombre=TuNombre para probar)');
}

// =============================================================================
// EJERCICIO 4: Manipulador de URLs
// Construye y modifica URLs de una API usando el módulo url
// =============================================================================

console.log('\n=== EJERCICIO 4: Manipulador de URLs ===\n');

/**
 * Construye una URL de API con los parámetros especificados.
 * Retorna la URL completa como string y sus componentes principales.
 * @param {string} base - URL base de la API
 * @param {string} endpoint - Ruta del endpoint
 * @param {object} params - Parámetros de query string
 * @returns {object} URL completa y sus componentes
 */
function construirURLApi(base, endpoint, params = {}) {
  const url = new URL(endpoint, base);

  Object.entries(params).forEach(([clave, valor]) => {
    url.searchParams.set(clave, String(valor));
  });

  return {
    completa:  url.toString(),
    host:      url.host,
    ruta:      url.pathname,
    parametros: Object.fromEntries(url.searchParams),
  };
}

const apiURL = construirURLApi(
  'https://api.tienda.com',
  '/productos',
  { categoria: 'libros', pagina: 1, limite: 20, orden: 'precio' }
);

console.log('URL construida:');
console.log('  Completa:   ', apiURL.completa);
console.log('  Host:       ', apiURL.host);
console.log('  Ruta:       ', apiURL.ruta);
console.log('  Parámetros: ', apiURL.parametros);

// =============================================================================
// EJERCICIO 5: util.promisify con fs
// Demuestra cómo convertir la API de callbacks de fs a Promises
// =============================================================================

console.log('\n=== EJERCICIO 5: util.promisify con fs ===\n');

/**
 * Lee las primeras N líneas de un archivo usando la API promisificada de fs.
 * Demuestra el uso de util.promisify para trabajar con async/await.
 * @param {string} rutaArchivo - Ruta del archivo a leer
 * @param {number} numLineas - Cantidad de líneas a retornar
 * @returns {Promise<string[]>} Array con las primeras N líneas
 */
async function leerPrimerasLineas(rutaArchivo, numLineas = 5) {
  const readFile = util.promisify(fs.readFile);
  const contenido = await readFile(rutaArchivo, 'utf8');
  return contenido.split('\n').slice(0, numLineas);
}

(async () => {
  try {
    const lineas = await leerPrimerasLineas(__filename, 5);
    console.log('Primeras 5 líneas de este archivo:');
    lineas.forEach((linea, i) => {
      console.log(`  ${String(i + 1).padStart(2)}: ${linea}`);
    });
  } catch (err) {
    console.error('Error:', err.message);
  }

  console.log('\n✅ Ejercicios del Módulo 12 completados');
})();
