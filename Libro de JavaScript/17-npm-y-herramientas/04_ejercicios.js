// ============================================================
// ARCHIVO: 04_ejercicios.js
// TEMA: Ejercicios de configuración de proyectos npm
// CÓMO EJECUTAR: node 04_ejercicios.js
// ============================================================

'use strict';

// ─────────────────────────────────────────────────────────────
// EJERCICIO 1: Inicializar un proyecto Express desde cero
// ─────────────────────────────────────────────────────────────
//
// Tarea: Crear un proyecto de API REST con Node.js + Express
// configurado correctamente para desarrollo y producción.
//
// Pasos a seguir:
//
// 1. Crear y entrar al directorio del proyecto:
//    mkdir mi-api && cd mi-api
//
// 2. Inicializar npm:
//    npm init -y
//
// 3. Instalar dependencias de producción:
//    npm install express cors dotenv
//
// 4. Instalar dependencias de desarrollo:
//    npm install -D nodemon eslint
//
// 5. Editar package.json para agregar estos scripts:
//    "scripts": {
//      "start": "node index.js",
//      "dev":   "nodemon index.js",
//      "lint":  "eslint ."
//    }
//
// 6. Crear el archivo .gitignore con el contenido:
//    node_modules/
//    .env
//    *.log
//
// 7. Crear .env con las variables del proyecto:
//    PORT=3000
//    NODE_ENV=development
//
// 8. Crear .env.example (SÍ se commitea):
//    PORT=3000
//    NODE_ENV=development
//    API_KEY=tu-api-key-aqui
//
// 9. Crear index.js mínimo y probar:
//    npm run dev
//
// Verificación: la app debe reiniciarse al editar index.js.

// ─────────────────────────────────────────────────────────────
// EJERCICIO 2: Proyecto React con Vite configurado
// ─────────────────────────────────────────────────────────────
//
// Tarea: Crear una app React moderna con Vite, testing y linting.
//
// Pasos:
//
// 1. Crear el proyecto:
//    npm create vite@latest mi-app -- --template react
//    cd mi-app
//    npm install
//
// 2. Agregar Vitest para testing:
//    npm install -D vitest @testing-library/react @testing-library/jest-dom jsdom
//
// 3. Configurar Vitest en vite.config.js:
//    export default defineConfig({
//      plugins: [react()],
//      test: {
//        environment: 'jsdom',
//        globals: true,
//        setupFiles: './src/setupTests.js',
//      },
//    })
//
// 4. Agregar el script de test en package.json:
//    "test": "vitest",
//    "test:ui": "vitest --ui"
//
// 5. Crear un componente simple y su test:
//    // src/components/Saludo.jsx
//    export const Saludo = ({ nombre }) => <h1>Hola, {nombre}</h1>;
//
//    // src/components/Saludo.test.jsx
//    import { render, screen } from '@testing-library/react';
//    import { Saludo } from './Saludo';
//    test('muestra el nombre', () => {
//      render(<Saludo nombre="Ana" />);
//      expect(screen.getByText('Hola, Ana')).toBeInTheDocument();
//    });
//
// 6. Ejecutar los tests:
//    npm test
//
// Verificación: el test debe pasar en verde.

// ─────────────────────────────────────────────────────────────
// EJERCICIO 3: Configurar ESLint + Prettier juntos
// ─────────────────────────────────────────────────────────────
//
// Tarea: Configurar las dos herramientas para que no entren en
// conflicto (Prettier maneja el formato, ESLint maneja la lógica).
//
// Pasos:
//
// 1. Instalar dependencias:
//    npm install -D eslint prettier
//    npm install -D eslint-config-prettier  ← desactiva reglas de ESLint que chocan con Prettier
//
// 2. Crear .eslintrc.json:
//    {
//      "env": { "node": true, "es2022": true, "browser": true },
//      "extends": ["eslint:recommended", "prettier"],
//      "rules": {
//        "no-unused-vars": "warn",
//        "no-console": "off",
//        "prefer-const": "error"
//      }
//    }
//
// 3. Crear .prettierrc:
//    {
//      "semi": true,
//      "singleQuote": true,
//      "tabWidth": 2,
//      "trailingComma": "es5",
//      "printWidth": 100
//    }
//
// 4. Agregar scripts en package.json:
//    "lint":      "eslint .",
//    "lint:fix":  "eslint . --fix",
//    "format":    "prettier --write .",
//    "check":     "prettier --check ."
//
// 5. Instalar y configurar Husky para validar antes de cada commit:
//    npm install -D husky lint-staged
//    npx husky init
//    echo "npx lint-staged" > .husky/pre-commit
//
// 6. Agregar configuración de lint-staged en package.json:
//    "lint-staged": {
//      "*.js": ["eslint --fix", "prettier --write"],
//      "*.{json,md}": "prettier --write"
//    }
//
// Verificación: al hacer git commit, el código se formatea
// automáticamente y ESLint reporta errores si los hay.

// ─────────────────────────────────────────────────────────────
// DEMO: mostrar la estructura recomendada de un proyecto
// ─────────────────────────────────────────────────────────────

console.log('=== Estructura recomendada de un proyecto Node.js ===\n');
console.log(`
mi-proyecto/
├── src/
│   ├── index.js          ← punto de entrada
│   ├── routes/           ← rutas Express separadas por dominio
│   │   ├── usuarios.js
│   │   └── productos.js
│   ├── controllers/      ← lógica de cada ruta
│   ├── services/         ← lógica de negocio
│   └── db/               ← acceso a base de datos
├── tests/                ← archivos de test
├── .env                  ← variables reales (en .gitignore)
├── .env.example          ← plantilla de variables (sí commitear)
├── .gitignore
├── .eslintrc.json
├── .prettierrc
├── package.json
├── package-lock.json     ← sí commitear
└── README.md
`);

console.log('Comandos más usados:');
console.log('  npm init -y             → crear package.json');
console.log('  npm install paquete     → instalar dependencia');
console.log('  npm install -D paquete  → instalar devDependency');
console.log('  npm run dev             → correr en desarrollo');
console.log('  npm test                → correr tests');
console.log('  npm run lint            → verificar código');
console.log('  npm run format          → formatear código');
