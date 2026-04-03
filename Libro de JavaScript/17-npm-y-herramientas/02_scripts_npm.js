// ============================================================
// ARCHIVO: 02_scripts_npm.js
// TEMA: Scripts de npm, variables de entorno y dotenv
// CÓMO EJECUTAR: node 02_scripts_npm.js
// DEPENDENCIA: npm install dotenv
// ============================================================

'use strict';

// ─────────────────────────────────────────────────────────────
// SCRIPTS EN package.json
// ─────────────────────────────────────────────────────────────
//
// Los scripts permiten automatizar tareas comunes del proyecto.
// Se definen en el campo "scripts" de package.json.
//
// Ejemplo de configuración completa:
//
// "scripts": {
//   "start":      "node index.js",
//   "dev":        "nodemon index.js",
//   "build":      "tsc",
//   "test":       "vitest",
//   "lint":       "eslint .",
//   "lint:fix":   "eslint . --fix",
//   "format":     "prettier --write .",
//   "db:migrate": "node scripts/migrate.js"
// }
//
// Cómo ejecutarlos:
//   npm start          → no necesita "run" (es especial)
//   npm test           → no necesita "run" (es especial)
//   npm run dev        → los demás necesitan "run"
//   npm run lint
//   npm run build
//
// Scripts especiales que NO necesitan "run":
//   npm start, npm test, npm stop, npm restart
//
// Pasar argumentos al script:
//   npm run dev -- --port 4000
//   (El -- separa los args de npm de los args del script)

// ─────────────────────────────────────────────────────────────
// process.env — Variables de entorno
// ─────────────────────────────────────────────────────────────
//
// process.env es el objeto global donde Node.js expone
// todas las variables de entorno del sistema y del proceso.
//
// Usos más comunes:
//   process.env.NODE_ENV   → 'development', 'production', 'test'
//   process.env.PORT       → puerto donde escucha el servidor
//   process.env.API_KEY    → clave de una API externa
//   process.env.DB_URL     → URL de conexión a la base de datos
//
// Establecer en la terminal (Unix):
//   NODE_ENV=production node app.js
//   PORT=8080 NODE_ENV=production node app.js
//
// Establecer en package.json scripts (cross-platform con cross-env):
//   "dev": "cross-env NODE_ENV=development nodemon index.js"

console.log('=== Variables de entorno ===');
console.log('NODE_ENV:', process.env.NODE_ENV || 'no definido (default: development)');
console.log('PORT:', process.env.PORT || 'no definido (usaría 3000)');
console.log('PATH (primeros 80 chars):', (process.env.PATH || '').slice(0, 80) + '...');

// ─────────────────────────────────────────────────────────────
// dotenv — cargar variables desde un archivo .env
// ─────────────────────────────────────────────────────────────
//
// Problema: no puedes commitear API_KEY al repositorio de git.
// Solución: guardar las variables sensibles en un archivo .env
//           que está en .gitignore (nunca se sube al repo).
//
// Archivo .env (ejemplo):
//   PORT=3000
//   NODE_ENV=development
//   API_KEY=abc123secreto
//   DB_URL=postgresql://user:pass@localhost:5432/midb
//   JWT_SECRET=mi-clave-super-secreta
//
// IMPORTANTE: .env SIEMPRE debe estar en .gitignore
// Crear .env.example con las variables pero sin valores reales
// para que otros desarrolladores sepan qué variables configurar.

// Cargar dotenv al inicio de la aplicación (antes de todo lo demás)
try {
  require('dotenv').config();
  console.log('\n✅ dotenv cargado — variables de .env disponibles en process.env');
} catch {
  console.log('\n⚠️  dotenv no instalado. Ejecuta: npm install dotenv');
  console.log('    Sin dotenv, las variables .env no se cargan automáticamente');
}

// ─────────────────────────────────────────────────────────────
// Patrón de configuración centralizada
// ─────────────────────────────────────────────────────────────
// En lugar de leer process.env directamente en cada archivo,
// es mejor crear un módulo de configuración central.
// Esto facilita validación, valores por defecto y testing.

/**
 * Configuración centralizada de la aplicación.
 * Lee las variables de entorno con valores por defecto seguros.
 */
const config = {
  // Puerto del servidor — en producción lo provee la plataforma (Railway, Render, etc.)
  port: parseInt(process.env.PORT) || 3000,

  // Entorno de ejecución
  nodeEnv: process.env.NODE_ENV || 'development',

  // Indica si estamos en producción
  esProduccion: process.env.NODE_ENV === 'production',

  // Clave secreta para JWT — en producción debe ser larga y aleatoria
  jwtSecret: process.env.JWT_SECRET || 'secreto-desarrollo-no-usar-en-produccion',

  // URL de la base de datos
  dbUrl: process.env.DB_URL || './local.db',

  // API key de terceros
  apiKey: process.env.API_KEY,
};

console.log('\n=== Configuración del proyecto ===');
console.log('Puerto:', config.port);
console.log('Entorno:', config.nodeEnv);
console.log('¿Es producción?', config.esProduccion);
console.log('DB URL:', config.dbUrl);
console.log('API Key:', config.apiKey ? '✅ configurada' : '❌ no configurada');

// ─────────────────────────────────────────────────────────────
// Validar que las variables obligatorias estén presentes
// ─────────────────────────────────────────────────────────────

/**
 * Verifica que las variables de entorno requeridas estén presentes.
 * Lanza un error descriptivo si alguna falta.
 * @param {string[]} vars - Nombres de las variables requeridas
 */
function validarEnv(vars) {
  const faltantes = vars.filter((v) => !process.env[v]);
  if (faltantes.length > 0) {
    throw new Error(
      `Variables de entorno requeridas no configuradas: ${faltantes.join(', ')}\n` +
      'Crea un archivo .env con estas variables. Ver .env.example como referencia.'
    );
  }
}

// En producción, validar que las variables críticas estén configuradas
if (config.esProduccion) {
  try {
    validarEnv(['JWT_SECRET', 'DB_URL']);
    console.log('\n✅ Variables de producción validadas');
  } catch (e) {
    console.error('\n❌ Error de configuración:', e.message);
    process.exit(1); // Terminar el proceso si falta config crítica
  }
} else {
  console.log('\n⚠️  Modo desarrollo — usando valores por defecto para variables no configuradas');
}

// ─────────────────────────────────────────────────────────────
// process.argv — argumentos de la línea de comandos
// ─────────────────────────────────────────────────────────────
//
// Permite recibir argumentos al ejecutar el script:
//   node 02_scripts_npm.js --modo=debug --puerto=8080

console.log('\n=== Argumentos de línea de comandos ===');
console.log('process.argv:', process.argv.slice(2)); // [0]=node [1]=archivo, [2+]=args del usuario

// Parsear argumentos simples de tipo --clave=valor
const args = Object.fromEntries(
  process.argv
    .slice(2)
    .filter((a) => a.startsWith('--'))
    .map((a) => {
      const [clave, valor] = a.slice(2).split('=');
      return [clave, valor ?? true];
    })
);

if (Object.keys(args).length > 0) {
  console.log('Args parseados:', args);
} else {
  console.log('Sin argumentos extra. Prueba: node 02_scripts_npm.js --modo=debug');
}
