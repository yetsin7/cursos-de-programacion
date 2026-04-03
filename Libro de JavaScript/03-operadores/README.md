# Módulo 03 — Operadores

Los operadores son los símbolos con los que realizas operaciones sobre valores.
JavaScript tiene muchos operadores y algunos tienen comportamientos sorpresivos
que conviene conocer bien antes de programar en producción.

---

## Archivos de este módulo

| Archivo | Tema |
|---------|------|
| `01_aritmeticos.js` | +, -, *, /, %, **, ++, -- |
| `02_comparacion.js` | == vs ===, <, >, localeCompare, Object.is |
| `03_logicos.js` | &&, \|\|, !, ??, &&=, \|\|=, ??= |
| `04_otros_operadores.js` | Spread, rest, destructuring, ternario, in, instanceof |
| `05_ejercicios.js` | Práctica de todos los operadores |

---

## La regla más importante

**Siempre usa `===` (triple igual), nunca `==` (doble igual).**

```js
0 == ''      // true  — coerción extraña
0 === ''     // false — correcto y predecible
null == undefined  // true  con ==
null === undefined // false con ===
```

---

## Ejecutar los archivos

```bash
node 03-operadores/01_aritmeticos.js
```
