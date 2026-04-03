// =============================================================================
// ARCHIVO: 01_commonjs.js
// TEMA: CommonJS — el sistema de módulos original de Node.js
// =============================================================================
// CÓMO EJECUTAR: node 01_commonjs.js
// =============================================================================

'use strict';

// -----------------------------------------------------------------------------
// ¿QUÉ ES COMMONJS?
// CommonJS (CJS) fue el primer sistema de módulos estándar en Node.js.
// Usa require() para importar y module.exports para exportar.
// Sigue siendo muy común porque la mayoría del ecosistema npm lo usa.
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// SECCIÓN 1: __dirname y __filename
// Variables especiales disponibles SOLO en CommonJS (no en ESM)
// __dirname  → ruta absoluta del directorio del archivo actual
// __filename → ruta absoluta del archivo actual
// -----------------------------------------------------------------------------

console.log('=== __dirname y __filename ===');
console.log('Directorio actual:', __dirname);
console.log('Archivo actual:   ', __filename);

// -----------------------------------------------------------------------------
// SECCIÓN 2: Módulo PATH — trabajar con rutas de archivos
// path resuelve diferencias entre sistemas operativos (/ vs \)
// -----------------------------------------------------------------------------

const path = require('path');

console.log('\n=== Módulo PATH ===');

// join: une segmentos de ruta con el separador del SO
const rutaUnida = path.join(__dirname, 'carpeta', 'archivo.txt');
console.log('path.join:    ', rutaUnida);

// resolve: convierte a ruta absoluta desde el directorio de trabajo
const rutaAbsoluta = path.resolve('carpeta', 'archivo.txt');
console.log('path.resolve: ', rutaAbsoluta);

// dirname: directorio padre de una ruta
console.log('path.dirname: ', path.dirname('/usuarios/juan/docs/nota.txt'));

// basename: nombre del archivo (último segmento)
console.log('path.basename:', path.basename('/usuarios/juan/docs/nota.txt'));

// extname: extensión del archivo
console.log('path.extname: ', path.extname('imagen.png'));

// sep: separador de ruta del sistema operativo
console.log('path.sep:     ', JSON.stringify(path.sep)); // '\' en Windows, '/' en Unix

// -----------------------------------------------------------------------------
// SECCIÓN 3: Módulo OS — información del sistema operativo
// -----------------------------------------------------------------------------

const os = require('os');

console.log('\n=== Módulo OS ===');
console.log('Plataforma:   ', os.platform());   // 'win32', 'linux', 'darwin'
console.log('Arquitectura: ', os.arch());        // 'x64', 'arm64'
console.log('Directorio home:', os.homedir());
console.log('CPUs disponibles:', os.cpus().length);

// Memoria total en GB (totalmem devuelve bytes)
const memGB = (os.totalmem() / 1024 ** 3).toFixed(2);
console.log(`Memoria total: ${memGB} GB`);

// Memoria libre
const memLibreGB = (os.freemem() / 1024 ** 3).toFixed(2);
console.log(`Memoria libre: ${memLibreGB} GB`);

// -----------------------------------------------------------------------------
// SECCIÓN 4: Módulo FS (File System) — introducción rápida
// (se profundiza en el Módulo 13)
// -----------------------------------------------------------------------------

const fs = require('fs');

console.log('\n=== Módulo FS (introducción) ===');

// existsSync: verificar si un archivo o carpeta existe
const existeDirectorio = fs.existsSync(__dirname);
console.log('¿Existe este directorio?', existeDirectorio);

// readdirSync: lista archivos en un directorio
const archivos = fs.readdirSync(__dirname);
console.log('Archivos en este directorio:', archivos);

// -----------------------------------------------------------------------------
// SECCIÓN 5: module.exports y exports
// Para exportar valores desde un módulo CommonJS
// -----------------------------------------------------------------------------

console.log('\n=== module.exports y exports ===');

// Forma 1: asignar directamente a module.exports (recomendada)
// Esto reemplaza todo el objeto de exportación
// module.exports = { suma, resta }; // se usaría en otro archivo

// Forma 2: agregar propiedades a exports (shortcut de module.exports)
// exports.nombre = 'valor'; // equivale a module.exports.nombre = 'valor'

// IMPORTANTE: nunca reasignar exports directamente
// exports = { algo }; // ❌ esto NO funciona — rompe la referencia
// module.exports = { algo }; // ✅ esto sí funciona

// Demostración con un módulo simulado
const moduloSimulado = (function () {
  // Variables privadas (no exportadas)
  const VERSION = '1.0.0';

  // Función privada — no accesible desde fuera
  function _calcularInterno(a, b) {
    return a + b;
  }

  // Lo que se exporta: la "API pública" del módulo
  return {
    version: VERSION,
    sumar: (a, b) => _calcularInterno(a, b),
    saludar: (nombre) => `Hola, ${nombre}!`,
  };
})();

console.log('Versión del módulo:', moduloSimulado.version);
console.log('sumar(3, 4):', moduloSimulado.sumar(3, 4));
console.log('saludar:', moduloSimulado.saludar('JavaScript'));

// -----------------------------------------------------------------------------
// SECCIÓN 6: require() — cómo Node resuelve los módulos
// -----------------------------------------------------------------------------

console.log('\n=== Cómo funciona require() ===');

/*
  Cuando escribes require('algo'), Node.js busca en este orden:

  1. Módulos del core (path, fs, os, etc.)      → sin instalación necesaria
  2. Módulos locales con ruta relativa           → require('./miarchivo')
  3. node_modules en el directorio actual        → require('express')
  4. node_modules en directorios padres (sube)   → hasta la raíz
  5. Variables de entorno NODE_PATH

  require() es SÍNCRONO — el archivo se carga completo antes de continuar.
  Esto es diferente a ESM que puede cargar de forma asíncrona.
*/

// Ejemplo de require con módulo del core
const { EventEmitter } = require('events');
const emisor = new EventEmitter();

emisor.on('mensaje', (texto) => {
  console.log('Evento recibido:', texto);
});

emisor.emit('mensaje', '¡CommonJS sigue siendo poderoso!');

// -----------------------------------------------------------------------------
// SECCIÓN 7: require() con caché
// Node.js cachea los módulos — la segunda llamada devuelve el mismo objeto
// -----------------------------------------------------------------------------

console.log('\n=== Caché de módulos ===');

const path1 = require('path');
const path2 = require('path');

// Son exactamente el mismo objeto en memoria gracias al caché
console.log('¿path1 === path2?', path1 === path2); // true

/*
  Resumen de CommonJS:
  ✅ require() para importar
  ✅ module.exports para exportar
  ✅ __dirname y __filename disponibles
  ✅ Síncrono y simple
  ✅ Compatible con todo el ecosistema npm legacy
  ⚠️ No soporta tree-shaking eficiente
  ⚠️ No es el estándar web (solo Node.js)
*/

console.log('\n✅ Módulo 12 — CommonJS completado');
