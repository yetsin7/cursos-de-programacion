# Módulo 27 — Performance en JavaScript

## Regla número uno

> "La optimización prematura es la raíz de todos los males." — Donald Knuth

Primero haz que el código funcione correctamente. Luego, **mide**. Optimiza solo lo que los datos demuestran que es lento.

---

## Flujo correcto de optimización

```
1. Código funciona ✓
2. Mide con herramientas reales (no intuición)
3. Identifica el cuello de botella
4. Aplica la optimización específica
5. Mide de nuevo para confirmar la mejora
6. Repite solo si es necesario
```

---

## Herramientas de medición

| Herramienta               | Uso                                              | Entorno        |
|---------------------------|--------------------------------------------------|----------------|
| `console.time/timeEnd`    | Medir tiempo de un bloque de código              | Node + Browser |
| `performance.now()`       | Medición de alta resolución (microsegundos)      | Node + Browser |
| `performance.mark/measure`| Benchmarks nombrados con la API Performance      | Node + Browser |
| Chrome DevTools Profiler  | Ver flame graph, CPU, memoria                    | Browser        |
| `node --prof`             | Profiling de CPU en Node.js                      | Node.js        |
| `clinic.js`               | Suite completa de diagnóstico para Node.js       | Node.js        |

---

## Áreas de optimización comúnes

| Área                    | Técnica                                      |
|-------------------------|----------------------------------------------|
| Bucles costosos         | Cachear `.length`, evitar recálculos         |
| Búsquedas frecuentes    | Usar `Map` o `Set` en lugar de arrays        |
| funciones costosas      | Memoization con `Map` como caché             |
| Llamadas frecuentes     | Debounce (esperar pausa) / Throttle (limitar) |
| Llamadas paralelas      | `Promise.all()` en lugar de await secuencial |
| Trabajo pesado de CPU   | Worker Threads en Node.js                   |
| Animaciones             | `requestAnimationFrame` en el navegador      |
| Imports grandes         | Lazy loading con `import()` dinámico         |

---

## Archivos del módulo

| Archivo                  | Contenido                                            |
|--------------------------|------------------------------------------------------|
| `01_medicion.js`         | console.time, performance.now, benchmarks            |
| `02_optimizaciones_js.js`| Maps, Sets, debounce, throttle, memoization, lazy    |
| `03_async_performance.js`| Promise.all, Worker Threads, rAF, queueMicrotask     |
| `04_buenas_practicas.md` | Checklist de performance y memory leaks              |
