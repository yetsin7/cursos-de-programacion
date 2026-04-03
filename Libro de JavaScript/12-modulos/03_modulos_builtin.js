// =============================================================================
// ARCHIVO: 03_modulos_builtin.js
// TEMA: Módulos built-in de Node.js — path, os, process, util, url
// =============================================================================
// CÓMO EJECUTAR: node 03_modulos_builtin.js
// =============================================================================

'use strict';

// -----------------------------------------------------------------------------
// Los módulos built-in vienen incluidos con Node.js — no requieren instalación.
// Son la base para trabajar con archivos, redes, procesos y utilidades del SO.
// -----------------------------------------------------------------------------

const path  = require('path');
const os    = require('os');
const util  = require('util');
const { URL } = require('url');

// =============================================================================
// MÓDULO: path — manipulación de rutas de archivos
// =============================================================================

console.log('╔══════════════════════════════════════╗');
console.log('║         MÓDULO: path                 ║');
console.log('╚══════════════════════════════════════╝\n');

// join: une segmentos con el separador del sistema operativo
const ruta1 = path.join('/usuarios', 'juan', 'documentos', 'nota.txt');
console.log('path.join:        ', ruta1);

// resolve: ruta absoluta desde el directorio de trabajo actual
const ruta2 = path.resolve('src', 'utils', 'helpers.js');
console.log('path.resolve:     ', ruta2);

// dirname: directorio padre de una ruta completa
const directorioPadre = path.dirname('/app/src/componentes/Boton.js');
console.log('path.dirname:     ', directorioPadre);

// basename: último segmento (nombre del archivo)
const nombreArchivo = path.basename('/app/src/componentes/Boton.js');
console.log('path.basename:    ', nombreArchivo);

// basename sin extensión
const nombreSinExt = path.basename('/app/src/componentes/Boton.js', '.js');
console.log('basename sin ext: ', nombreSinExt);

// extname: extensión del archivo (incluye el punto)
const extension = path.extname('imagen.principal.png');
console.log('path.extname:     ', extension); // .png

// parse: descompone una ruta en sus partes
const partes = path.parse('/usuarios/juan/docs/nota.md');
console.log('path.parse:       ', partes);
// { root: '/', dir: '/usuarios/juan/docs', base: 'nota.md', ext: '.md', name: 'nota' }

// format: reconstruye una ruta desde sus partes (inverso de parse)
const rutaReconstruida = path.format({
  dir:  '/usuarios/juan/docs',
  name: 'nota',
  ext:  '.md',
});
console.log('path.format:      ', rutaReconstruida);

// normalize: limpia rutas con ../ y // redundantes
const rutaSucia = path.normalize('/app//src/../componentes/./Boton.js');
console.log('path.normalize:   ', rutaSucia);

// isAbsolute: verifica si una ruta es absoluta
console.log('isAbsolute (/app):', path.isAbsolute('/app'));     // true
console.log('isAbsolute (src): ', path.isAbsolute('src/app'));  // false

// posix y win32: forzar separadores de un SO específico
console.log('path.sep (actual):', JSON.stringify(path.sep));

// =============================================================================
// MÓDULO: os — información del sistema operativo
// =============================================================================

console.log('\n╔══════════════════════════════════════╗');
console.log('║         MÓDULO: os                   ║');
console.log('╚══════════════════════════════════════╝\n');

// Plataforma y arquitectura
console.log('os.platform():  ', os.platform());   // 'win32', 'linux', 'darwin'
console.log('os.arch():      ', os.arch());        // 'x64', 'arm64'
console.log('os.type():      ', os.type());        // 'Windows_NT', 'Linux', 'Darwin'
console.log('os.release():   ', os.release());     // versión del kernel/SO

// Directorio home del usuario
console.log('os.homedir():   ', os.homedir());

// Directorio temporal del sistema
console.log('os.tmpdir():    ', os.tmpdir());

// Nombre del host
console.log('os.hostname():  ', os.hostname());

// Memoria en bytes → convertir a GB para legibilidad
const totalGB = (os.totalmem() / 1024 ** 3).toFixed(2);
const libreGB  = (os.freemem()  / 1024 ** 3).toFixed(2);
console.log(`Memoria total:   ${totalGB} GB`);
console.log(`Memoria libre:   ${libreGB} GB`);

// Información de CPUs
const cpus = os.cpus();
console.log(`CPUs:            ${cpus.length} núcleos — ${cpus[0]?.model}`);

// Tiempo de actividad en segundos
const uptimeHoras = (os.uptime() / 3600).toFixed(1);
console.log(`Uptime:          ${uptimeHoras} horas`);

// Separador de línea del SO (\n en Unix, \r\n en Windows)
console.log('os.EOL:         ', JSON.stringify(os.EOL));

// =============================================================================
// MÓDULO: process — información y control del proceso Node.js actual
// =============================================================================

console.log('\n╔══════════════════════════════════════╗');
console.log('║         MÓDULO: process              ║');
console.log('╚══════════════════════════════════════╝\n');

// Argumentos de línea de comandos
// process.argv[0] = ruta de node
// process.argv[1] = ruta del script
// process.argv[2+] = argumentos del usuario
console.log('process.argv:   ', process.argv);

// Variables de entorno (un subconjunto para no llenar la consola)
console.log('NODE_ENV:        ', process.env.NODE_ENV ?? 'no definido');
console.log('HOME/USERPROFILE:', process.env.HOME ?? process.env.USERPROFILE);

// Directorio de trabajo actual
console.log('process.cwd():  ', process.cwd());

// Versión de Node.js
console.log('process.version:', process.version);

// Plataforma (igual que os.platform())
console.log('process.platform:', process.platform);

// ID del proceso actual
console.log('process.pid:    ', process.pid);

// Tiempo de ejecución del proceso (en segundos, decimales de alta precisión)
const [segundos, nanosegundos] = process.hrtime();
console.log(`process.hrtime:  ${segundos}s ${nanosegundos}ns`);

// process.exit() — termina el proceso (0 = éxito, cualquier otro = error)
// process.exit(0); // no llamar aquí para que el script continúe

// =============================================================================
// MÓDULO: util — utilidades varias de Node.js
// =============================================================================

console.log('\n╔══════════════════════════════════════╗');
console.log('║         MÓDULO: util                 ║');
console.log('╚══════════════════════════════════════╝\n');

// util.format: formateo de strings con tokens como printf
const mensaje = util.format('Hola %s, tienes %d mensajes', 'Juan', 5);
console.log('util.format:    ', mensaje);

// util.inspect: representación de objetos para depuración
const objeto = { nombre: 'Juan', edad: 30, hobbies: ['leer', 'correr'] };
console.log('util.inspect:   ', util.inspect(objeto, { colors: false, depth: 2 }));

// util.promisify: convierte una función con callback al estilo Promise
// Muy útil para trabajar con APIs antiguas de Node.js con async/await
const fs = require('fs');
const readFilePromise = util.promisify(fs.readFile);

// Ahora readFilePromise retorna una Promise
(async () => {
  try {
    const contenido = await readFilePromise(__filename, 'utf8');
    const lineas = contenido.split('\n').length;
    console.log(`util.promisify:   archivo leído — ${lineas} líneas`);
  } catch (err) {
    console.error('Error leyendo archivo:', err.message);
  }
})();

// util.isDeepStrictEqual: comparación profunda de objetos
const a = { x: 1, y: { z: 2 } };
const b = { x: 1, y: { z: 2 } };
console.log('isDeepStrictEqual:', util.isDeepStrictEqual(a, b)); // true

// =============================================================================
// MÓDULO: url — manipulación de URLs
// =============================================================================

console.log('\n╔══════════════════════════════════════╗');
console.log('║         MÓDULO: url                  ║');
console.log('╚══════════════════════════════════════╝\n');

// La clase URL (estándar WHATWG — mismo que en el navegador)
const miURL = new URL('https://api.ejemplo.com:8080/usuarios?pagina=2&limite=10#resultados');

console.log('href:      ', miURL.href);
console.log('protocol:  ', miURL.protocol);  // 'https:'
console.log('host:      ', miURL.host);       // 'api.ejemplo.com:8080'
console.log('hostname:  ', miURL.hostname);   // 'api.ejemplo.com'
console.log('port:      ', miURL.port);       // '8080'
console.log('pathname:  ', miURL.pathname);   // '/usuarios'
console.log('search:    ', miURL.search);     // '?pagina=2&limite=10'
console.log('hash:      ', miURL.hash);       // '#resultados'

// searchParams: interfaz para trabajar con query strings
const params = miURL.searchParams;
console.log('\nsearchParams:');
console.log('  pagina:', params.get('pagina'));    // '2'
console.log('  limite:', params.get('limite'));    // '10'

// Modificar parámetros
params.set('pagina', '3');
params.append('orden', 'nombre');
console.log('  URL modificada:', miURL.toString());

// Iterar todos los parámetros
console.log('  Todos los parámetros:');
for (const [clave, valor] of params) {
  console.log(`    ${clave} = ${valor}`);
}

console.log('\n✅ Módulo 12 — Módulos built-in completado');
