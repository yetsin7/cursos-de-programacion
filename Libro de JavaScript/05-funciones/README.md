# 05 - Funciones

Las funciones son **ciudadanos de primera clase** en JavaScript. Esto significa que las funciones son tratadas como cualquier otro valor: pueden asignarse a variables, pasarse como argumentos a otras funciones, retornarse como resultado de otras funciones, y almacenarse en arrays u objetos.

## ¿Qué significa "ciudadano de primera clase"?

```js
// 1. Asignar una función a una variable
const saludar = function(nombre) { return `Hola, ${nombre}`; };

// 2. Pasar una función como argumento
[1, 2, 3].map(n => n * 2);

// 3. Retornar una función desde otra función
function multiplicador(factor) {
  return n => n * factor; // retorna una función
}

// 4. Guardar funciones en un objeto
const acciones = { correr: () => {}, saltar: () => {} };
```

Este poder es la base de patrones fundamentales: **callbacks**, **closures**, **higher-order functions**, **currying** y **composición**.

## Estructura del módulo

| Archivo | Contenido |
|---|---|
| `01_funciones_declaradas.js` | Declaration vs expression, hoisting, default params |
| `02_arrow_functions.js` | Sintaxis, retorno implícito, `this` léxico |
| `03_parametros_avanzados.js` | Rest, spread, destructuring en params, `arguments` |
| `04_closures.js` | Qué es un closure, variables privadas, módulo pattern |
| `05_higher_order.js` | Callbacks, map/filter/reduce, composición, currying |
| `06_ejercicios.js` | 5 ejercicios prácticos con soluciones |

## Concepto clave

> Una función no es solo una forma de reutilizar código — es una **unidad de comportamiento** que puede combinarse, transformarse y pasarse entre partes de tu programa. Dominar las funciones es dominar JavaScript.

## Cómo ejecutar

```bash
node 01_funciones_declaradas.js
node 02_arrow_functions.js
# etc.
```
