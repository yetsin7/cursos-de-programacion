# Módulo 12 — Módulos en JavaScript

## ¿Qué son los módulos?

Los módulos permiten dividir el código en archivos pequeños, reutilizables y organizados. En lugar de tener miles de líneas en un solo archivo, cada módulo encapsula una responsabilidad concreta.

## CommonJS vs ES Modules

| Característica | CommonJS (CJS) | ES Modules (ESM) |
|---|---|---|
| Sintaxis import | `require()` | `import` |
| Sintaxis export | `module.exports` | `export` / `export default` |
| Evaluación | Síncrona | Asíncrona |
| Estándar | Node.js legacy | Estándar ECMAScript moderno |
| Extensión | `.js` (default Node) | `.mjs` o `"type": "module"` |
| `__dirname` | ✅ Disponible | ❌ No disponible (usar `import.meta.url`) |

## ¿Por qué los módulos son clave?

- **Organización**: cada archivo tiene una sola responsabilidad
- **Reutilización**: exportar y consumir código en múltiples lugares
- **Encapsulación**: lo que no se exporta es privado al módulo
- **Mantenibilidad**: proyectos grandes son manejables con módulos
- **Tree-shaking**: los bundlers como Vite/Webpack eliminan código no usado (solo ESM)

## ¿Cuál usar hoy?

**ES Modules es el estándar moderno.** Para proyectos nuevos, usar siempre ESM. CommonJS sigue siendo relevante porque la mayoría del ecosistema npm aún lo usa internamente.

## Archivos del módulo

- `01_commonjs.js` — CommonJS: require, module.exports, módulos del core
- `02_esmodules.js` — ES Modules: import, export, importaciones dinámicas
- `03_modulos_builtin.js` — Módulos built-in de Node.js: path, os, process, util, url
- `04_ejercicios.js` — Ejercicios prácticos
