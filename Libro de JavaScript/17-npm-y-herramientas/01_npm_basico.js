// ============================================================
// ARCHIVO: 01_npm_basico.js
// TEMA: npm — gestor de paquetes y package.json
// CÓMO EJECUTAR: node 01_npm_basico.js
// NOTA: Este archivo son comentarios explicativos + código de demostración
// ============================================================

'use strict';

// ─────────────────────────────────────────────────────────────
// npm init
// ─────────────────────────────────────────────────────────────
//
// Inicializa un proyecto Node.js creando package.json.
//
//   npm init          → modo interactivo (hace preguntas)
//   npm init -y       → acepta todos los defaults automáticamente
//
// El archivo generado tiene esta estructura mínima:
//
// {
//   "name": "mi-proyecto",
//   "version": "1.0.0",
//   "description": "",
//   "main": "index.js",
//   "scripts": { "test": "echo \"Error: no test specified\" && exit 1" },
//   "keywords": [],
//   "author": "",
//   "license": "ISC"
// }

// ─────────────────────────────────────────────────────────────
// npm install — instalar paquetes
// ─────────────────────────────────────────────────────────────
//
// Dependencias de PRODUCCIÓN (se incluyen al desplegar):
//   npm install express
//   npm install express better-sqlite3 cors
//
// Dependencias de DESARROLLO (solo para trabajar localmente):
//   npm install -D nodemon
//   npm install --save-dev eslint prettier
//
// Instalar versión específica:
//   npm install express@4.18.2
//
// Instalar globalmente (comando disponible en toda la terminal):
//   npm install -g nodemon
//   npm install -g typescript

// ─────────────────────────────────────────────────────────────
// dependencies vs devDependencies
// ─────────────────────────────────────────────────────────────
//
// "dependencies" — necesarias para que la app funcione en producción
//   Ej: express, better-sqlite3, cors, dotenv, bcrypt
//
// "devDependencies" — solo necesarias durante el desarrollo
//   Ej: nodemon, eslint, prettier, jest, vitest, typescript
//
// Ejemplo en package.json:
// {
//   "dependencies": {
//     "express": "^4.18.2",
//     "cors": "^2.8.5"
//   },
//   "devDependencies": {
//     "nodemon": "^3.0.1",
//     "eslint": "^8.50.0"
//   }
// }
//
// El símbolo ^ significa "compatible con esta versión mayor":
//   "^4.18.2" → acepta 4.18.2, 4.19.0, 4.20.0, pero NO 5.0.0
// El símbolo ~ significa "solo parches":
//   "~4.18.2" → acepta 4.18.2, 4.18.3, pero NO 4.19.0

// ─────────────────────────────────────────────────────────────
// node_modules/ — NUNCA commitear al repositorio
// ─────────────────────────────────────────────────────────────
//
// node_modules/ puede pesar cientos de MB y siempre se regenera con:
//   npm install
//
// Siempre agregar al archivo .gitignore:
//   node_modules/
//   .env
//   *.log
//
// Para recrear node_modules en un proyecto clonado:
//   git clone https://github.com/usuario/repo
//   cd repo
//   npm install   ← lee package.json y descarga todo

// ─────────────────────────────────────────────────────────────
// package-lock.json — SÍ commitear al repositorio
// ─────────────────────────────────────────────────────────────
//
// El lockfile registra las versiones EXACTAS instaladas, incluyendo
// las dependencias de tus dependencias (árbol completo).
//
// Beneficio: todos los desarrolladores del equipo y el servidor de
// producción instalan exactamente las mismas versiones.
//
// npm install    → respeta package-lock.json si existe
// npm ci         → instalación limpia respetando el lock (recomendado en CI/CD)
// npm update     → actualiza paquetes dentro del rango permitido por ^
// npm outdated   → muestra qué paquetes tienen versiones más nuevas disponibles

// ─────────────────────────────────────────────────────────────
// Comandos útiles del día a día
// ─────────────────────────────────────────────────────────────
//
// npm uninstall express          → eliminar un paquete
// npm list                       → árbol de dependencias instaladas
// npm list --depth=0             → solo las dependencias directas
// npm run nombreScript           → ejecutar un script de package.json
// npm audit                      → revisar vulnerabilidades de seguridad
// npm audit fix                  → corregir vulnerabilidades automáticamente
// npx nombre-paquete             → ejecutar paquete sin instalarlo globalmente
//   Ejemplo: npx create-react-app mi-app

// ─────────────────────────────────────────────────────────────
// DEMO: leer el package.json del proyecto actual
// ─────────────────────────────────────────────────────────────

const path = require('path');
const fs = require('fs');

/**
 * Busca y muestra información del package.json más cercano.
 * Sube directorios hasta encontrarlo o llegar a la raíz.
 */
function mostrarPackageJson() {
  let directorio = __dirname;

  for (let i = 0; i < 5; i++) {
    const ruta = path.join(directorio, 'package.json');
    if (fs.existsSync(ruta)) {
      const pkg = JSON.parse(fs.readFileSync(ruta, 'utf-8'));
      console.log('=== package.json encontrado ===');
      console.log('Nombre:', pkg.name || '(sin nombre)');
      console.log('Versión:', pkg.version || '(sin versión)');
      console.log('Scripts:', Object.keys(pkg.scripts || {}).join(', ') || 'ninguno');
      console.log('Dependencies:', Object.keys(pkg.dependencies || {}).join(', ') || 'ninguna');
      console.log('DevDependencies:', Object.keys(pkg.devDependencies || {}).join(', ') || 'ninguna');
      return;
    }
    directorio = path.dirname(directorio);
  }

  console.log('No se encontró package.json en los directorios cercanos.');
  console.log('Ejecuta: npm init -y   para crear uno.');
}

mostrarPackageJson();

// ─────────────────────────────────────────────────────────────
// process — objeto global de Node.js con info del entorno
// ─────────────────────────────────────────────────────────────

console.log('\n=== Información del entorno (process) ===');
console.log('Node.js versión:', process.version);
console.log('Plataforma:', process.platform);
console.log('Directorio de trabajo:', process.cwd());
console.log('Directorio del archivo:', __dirname);
console.log('Nombre del archivo:', __filename);
