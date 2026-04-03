# Módulo 07 — Objetos en JavaScript

Objetos en JS: la base de todo en JavaScript. Todo es un objeto (o se comporta
como uno). Domina la creación, manipulación, desestructuración y clonación.

## Archivos

| Archivo | Tema |
|---|---|
| `01_objetos_basico.js` | Creación, acceso, métodos, shorthand, computed keys, optional chaining |
| `02_destructuring_objetos.js` | Destructuring, renombrar, defaults, rest, anidado |
| `03_spread_y_merge.js` | Spread, merge, shallow vs deep copy, structuredClone |
| `04_metodos_objeto.js` | Object.keys/values/entries, freeze, hasOwn, iteración |
| `05_ejercicios.js` | Ejercicios prácticos combinando todo lo visto |

## Cómo ejecutar

```bash
node 01_objetos_basico.js
node 02_destructuring_objetos.js
node 03_spread_y_merge.js
node 04_metodos_objeto.js
node 05_ejercicios.js
```

## Conceptos clave

- Los objetos son colecciones de **pares clave-valor**
- Las claves pueden ser strings o Symbols
- Los objetos son **referenciados** — cuidado con las copias shallow
- `structuredClone()` (ES2022) para copia profunda nativa
- Optional chaining `?.` para acceder a propiedades sin riesgo de error
