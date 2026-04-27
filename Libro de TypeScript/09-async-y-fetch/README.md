# Capítulo 09 — Async y Fetch

En aplicaciones reales casi nunca trabajas solo con datos locales. Tarde o
temprano debes leer archivos, llamar APIs, esperar respuestas o manejar errores
de red. Aqui entra la programación asincrona.

## Que aprenderas

- como funcionan `Promise` y `async/await`;
- por que "esperar" no significa bloquear toda la app;
- como tipar respuestas externas;
- por que datos externos deben validarse aunque tengas TypeScript.

## Que esta pasando dentro del software

Cuando haces una operación asincrona, el programa inicia una tarea y continua con
otras partes mientras espera el resultado. Cuando la respuesta llega, se resuelve
la promesa y el flujo retoma el siguiente paso.

TypeScript puede ayudarte a modelar la forma esperada del dato, pero no puede
garantizar que internet o una API respeten esa forma. Por eso debes validar.

## Archivo de este capítulo

| Archivo | Descripción |
|---|---|
| `01_async_and_fetch.ts` | Promesas, async/await y lectura de datos externos simulados |
