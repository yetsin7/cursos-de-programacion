# Módulo 14 — HTTP y Fetch

## ¿Qué aprenderás?

Cómo consumir APIs REST desde JavaScript usando `fetch` — disponible nativamente en navegadores y en Node.js 18+.

## La API Fetch

`fetch()` es la forma moderna de hacer peticiones HTTP en JavaScript. Devuelve una `Promise` que resuelve con un objeto `Response`.

```js
const response = await fetch('https://api.ejemplo.com/datos');
const datos = await response.json();
```

## Errores comunes con fetch

**Importante**: `fetch` solo rechaza la Promise en errores de red (sin conexión, DNS fallido). Para errores HTTP (404, 500), la Promise **resuelve** pero `response.ok` es `false`.

```js
const res = await fetch(url);
if (!res.ok) throw new Error(`HTTP ${res.status}`); // ← necesario verificar
```

## Archivos del módulo

- `01_fetch_basico.js` — GET con fetch, response.json, manejo de errores
- `02_fetch_avanzado.js` — POST/PUT/DELETE, headers, AbortController, retry
- `03_json_y_modelos.js` — JSON.parse/stringify, validación, fechas ISO
- `04_ejercicios.js` — Ejercicios prácticos

## Requisito

Node.js 18 o superior para usar `fetch` nativo. Para versiones anteriores:
```
npm install node-fetch
```
