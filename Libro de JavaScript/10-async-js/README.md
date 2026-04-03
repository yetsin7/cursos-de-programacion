# 10 - JavaScript Asíncrono

JavaScript es **single-threaded**: solo puede ejecutar una cosa a la vez. Sin embargo, las aplicaciones necesitan hacer operaciones que toman tiempo (llamadas a APIs, leer archivos, temporizadores) sin bloquear el resto del programa.

## El problema del código bloqueante

```js
// Si esto bloqueara, la página se congelaría por 3 segundos
const datos = leerArchivo("datos.txt"); // bloqueante — NO así en JS
console.log(datos);
```

JavaScript resuelve esto con **asincronía**: delega la operación a las Web APIs / Node APIs y continúa ejecutando código. Cuando la operación termina, el resultado se procesa en el event loop.

## La evolución histórica

```
Callbacks (1995)  →  Promises (ES6/2015)  →  async/await (ES2017)
```

Cada etapa resolvió los problemas de la anterior:
- **Callbacks**: funcionales pero causan "callback hell"
- **Promises**: encadenamiento limpio, manejo de errores unificado
- **async/await**: código asíncrono con apariencia síncrona

## El Event Loop

```
Call Stack → Web APIs → Callback Queue (macrotasks)
                     → Microtask Queue (Promises) ← prioridad mayor
```

El event loop constantemente revisa si el call stack está vacío, procesa primero todas las microtasks (Promises), luego toma la siguiente macrotask (setTimeout, I/O).

## Estructura del módulo

| Archivo | Contenido |
|---|---|
| `01_callbacks.js` | Callbacks, setTimeout, error-first, callback hell |
| `02_promises.js` | new Promise, then/catch/finally, Promise.all/race |
| `03_async_await.js` | async/await, try/catch, paralelismo, top-level await |
| `04_event_loop.js` | Call stack, microtasks, macrotasks, orden de ejecución |
| `05_ejercicios.js` | 4 ejercicios prácticos con soluciones |

## Cómo ejecutar

```bash
node 01_callbacks.js
node 02_promises.js
# etc.
```
