# Herramientas del Ecosistema JavaScript Moderno

Estas son las herramientas más usadas en proyectos profesionales de JavaScript y Node.js.

---

## Calidad de Código

| Herramienta | Categoría | Para qué sirve | Instalación |
|---|---|---|---|
| **ESLint** | Linter | Detecta errores, malas prácticas y código inconsistente antes de ejecutar | `npm install -D eslint` |
| **Prettier** | Formateador | Formatea el código automáticamente con un estilo consistente en todo el equipo | `npm install -D prettier` |
| **Husky** | Git hooks | Ejecuta scripts automáticamente antes de commits (ej: lint + tests) | `npm install -D husky` |

### ESLint — ejemplo de configuración (`.eslintrc.json`)
```json
{
  "env": { "node": true, "es2022": true },
  "extends": ["eslint:recommended"],
  "rules": {
    "no-unused-vars": "warn",
    "no-console": "off"
  }
}
```

### Prettier — ejemplo de configuración (`.prettierrc`)
```json
{
  "semi": true,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "es5",
  "printWidth": 100
}
```

---

## Testing

| Herramienta | Categoría | Para qué sirve | Instalación |
|---|---|---|---|
| **Vitest** | Test runner | Tests unitarios ultrarrápidos, compatible con Vite y ESM | `npm install -D vitest` |
| **Jest** | Test runner | El más popular históricamente, especialmente en React | `npm install -D jest` |
| **Testing Library** | Testing UI | Pruebas de componentes React centradas en el comportamiento del usuario | `npm install -D @testing-library/react` |

### Vitest — ejemplo de test
```js
import { describe, it, expect } from 'vitest';
import { sumar } from './math.js';

describe('sumar', () => {
  it('suma dos números positivos', () => {
    expect(sumar(2, 3)).toBe(5);
  });
});
```

---

## Build y Bundling

| Herramienta | Categoría | Para qué sirve | Instalación |
|---|---|---|---|
| **Vite** | Bundler | Build ultrarrápido para apps frontend (React, Vue, Vanilla) | `npm create vite@latest` |
| **esbuild** | Bundler | El más rápido, usado internamente por Vite | `npm install -D esbuild` |
| **Webpack** | Bundler | El más configurables, muy establecido pero más lento | `npm install -D webpack` |

---

## Ejecución de Código

| Herramienta | Categoría | Para qué sirve | Instalación |
|---|---|---|---|
| **nodemon** | Dev server | Reinicia Node.js automáticamente al guardar un archivo | `npm install -D nodemon` |
| **tsx** | Runtime | Ejecuta TypeScript en Node.js directamente sin compilar | `npm install -D tsx` |
| **ts-node** | Runtime | Alternativa a tsx para ejecutar TypeScript | `npm install -D ts-node` |

### nodemon — ejemplo en package.json
```json
"scripts": {
  "dev": "nodemon index.js",
  "dev:ts": "nodemon --exec tsx index.ts"
}
```

---

## TypeScript

| Herramienta | Para qué sirve | Instalación |
|---|---|---|
| **typescript** | Compilador TypeScript | `npm install -D typescript` |
| **@types/node** | Tipos de Node.js para TypeScript | `npm install -D @types/node` |
| **@types/express** | Tipos de Express para TypeScript | `npm install -D @types/express` |

---

## Utilidades de Desarrollo

| Herramienta | Para qué sirve | Instalación |
|---|---|---|
| **dotenv** | Cargar variables de entorno desde `.env` | `npm install dotenv` |
| **cross-env** | Establecer variables de entorno cross-platform | `npm install -D cross-env` |
| **rimraf** | Eliminar directorios cross-platform (rm -rf) | `npm install -D rimraf` |
| **concurrently** | Ejecutar múltiples scripts npm en paralelo | `npm install -D concurrently` |

---

## Stack recomendado para un proyecto Node.js nuevo

```bash
# Inicializar proyecto
npm init -y

# Dependencias de producción
npm install express cors dotenv better-sqlite3

# Dependencias de desarrollo
npm install -D nodemon eslint prettier

# Scripts en package.json
# "start": "node index.js"
# "dev":   "nodemon index.js"
# "lint":  "eslint ."
```

## Stack recomendado para un proyecto React nuevo

```bash
# Crear proyecto con Vite
npm create vite@latest mi-app -- --template react

cd mi-app
npm install

# Añadir testing
npm install -D vitest @testing-library/react

# Añadir calidad de código
npm install -D eslint prettier
```
