# Módulo 02 — Tipos de Datos en Detalle

En este módulo exploramos en profundidad los tipos de datos más usados en
JavaScript: strings, numbers, booleans y los valores especiales null y undefined.

---

## ¿Por qué es importante este módulo?

JavaScript es un lenguaje de tipado dinámico y débil. Eso significa:

- **Dinámico**: las variables pueden cambiar de tipo durante la ejecución
- **Débil**: JS convierte tipos automáticamente cuando los mezclas (coerción implícita)

Entender cómo funciona cada tipo te evitará bugs confusos como:

```js
'5' + 3   // '53' (concatenación, no suma)
'5' - 3   // 2   (conversión implícita a number)
true + 1  // 2   (true se convierte a 1)
null + 1  // 1   (null se convierte a 0)
```

---

## Archivos de este módulo

| Archivo | Tema |
|---------|------|
| `01_strings.js` | Métodos de texto: slice, replace, split, padStart... |
| `02_numbers.js` | Enteros, decimales, Infinity, NaN, Math, precisión |
| `03_booleans.js` | Truthy/falsy, &&, ||, !!, ??, short-circuit |
| `04_null_undefined.js` | Optional chaining ?., nullish coalescing ??, ??= |
| `05_ejercicios.js` | Práctica combinando todos los tipos |

---

## Conceptos clave del módulo

### Coerción implícita — El lado oscuro de JS

```js
// El operador + tiene doble personalidad:
// - Con strings: concatena
// - Con numbers: suma
1 + 2       // 3
'1' + 2     // '12' (convierte el número a string)
1 + '2'     // '12'

// Los demás operadores aritméticos siempre intentan convertir a number:
'5' - 2     // 3
'5' * 2     // 10
'hola' - 1  // NaN
```

### Regla de oro

Siempre convierte **explícitamente** cuando necesites cambiar de tipo:

```js
Number('42')   // Convierte string a number
String(42)     // Convierte number a string
Boolean(0)     // Convierte a boolean
```

---

## Ejecutar los archivos

```bash
node 02-tipos-de-datos/01_strings.js
```
