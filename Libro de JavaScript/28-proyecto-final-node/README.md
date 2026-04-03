# 28 — Proyecto Final Node.js: API REST completa

API REST con Express + SQLite lista para conectar con un frontend React.

## Stack

- **Express** — servidor HTTP y routing
- **better-sqlite3** — base de datos SQLite local
- **cors** — permitir peticiones desde el frontend

## Instalación

```bash
npm init -y
npm install express better-sqlite3 cors
```

## Cómo ejecutar

```bash
# Terminal 1: iniciar la API
node servidor.js

# Terminal 2: probar la API
node cliente_test.js
```

## Endpoints

| Método | Ruta | Descripción |
|---|---|---|
| GET | `/api/notas` | Listar todas. Filtrar con `?q=texto` |
| GET | `/api/notas/:id` | Obtener una nota |
| POST | `/api/notas` | Crear nota (body: `{titulo, contenido?, etiqueta?}`) |
| PUT | `/api/notas/:id` | Actualizar nota |
| DELETE | `/api/notas/:id` | Eliminar nota |

## Estructura del proyecto

```
28-proyecto-final-node/
├── servidor.js      ← API Express + SQLite
├── cliente_test.js  ← Script de prueba con fetch nativo
└── README.md
```

La base de datos `notas.db` se crea automáticamente al iniciar el servidor por primera vez.
