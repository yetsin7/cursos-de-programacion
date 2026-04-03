# Módulo 29 — App Biblia Web (Biblia RV60)

Proyecto final del Libro de JavaScript. Aplicación web profesional para leer la Biblia Reina-Valera 1960.
Construida con **Express** en el backend y **React + Vite** en el frontend.

## Descripción

- Lista de 66 libros organizados en Antiguo y Nuevo Testamento
- Navegación por capítulos y versículos con scroll
- Búsqueda global de texto en toda la Biblia
- Versículo del día (aleatorio)
- Favoritos persistidos en localStorage
- Modo oscuro persistido en localStorage

## Arquitectura

```
Backend  →  Express + better-sqlite3  →  Puerto 3001
Frontend →  React + Vite (SPA)        →  Puerto 5173
Base de datos → biblia_rv60.sqlite3   →  ../../datos/biblia_rv60.sqlite3
```

La comunicación es REST: el frontend hace fetch al backend en `/api/*`.
Vite está configurado con un proxy para `/api` → `http://localhost:3001`.

## Estructura del proyecto

```
29-app-biblia-web/
├── README.md
├── backend/
│   ├── package.json
│   ├── server.js
│   └── routes/
│       └── bible.js
└── frontend/
    ├── package.json
    ├── vite.config.js
    ├── index.html
    └── src/
        ├── main.jsx
        ├── App.jsx
        ├── api/bibleApi.js
        ├── hooks/useBible.js
        ├── hooks/useFavorites.js
        ├── components/
        └── pages/
```

## Cómo ejecutar

### 1. Instalar dependencias

```bash
# Backend
cd backend
npm install

# Frontend
cd ../frontend
npm install
```

### 2. Iniciar el backend

```bash
cd backend
npm run dev   # con nodemon (recarga automática)
# o
npm start     # producción
```

El servidor queda disponible en `http://localhost:3001`.

### 3. Iniciar el frontend

```bash
cd frontend
npm run dev
```

La app queda disponible en `http://localhost:5173`.

## Endpoints de la API

| Método | Ruta | Descripción |
|--------|------|-------------|
| GET | /api/books | Lista los 66 libros |
| GET | /api/books/:bookNumber/chapters | Capítulos de un libro |
| GET | /api/books/:bookNumber/chapters/:chapter/verses | Versículos de un capítulo |
| GET | /api/search?q=texto | Búsqueda global (máx 50 resultados) |
| GET | /api/verse/random | Versículo aleatorio |

## Base de datos

La BD SQLite debe estar en:
```
C:\Users\Yetsin\Documents\Programacion\datos\biblia_rv60.sqlite3
```

Se accede desde el backend con la ruta relativa `../../../datos/biblia_rv60.sqlite3`.

## Dependencias

### Backend
- express ^4.18.0
- better-sqlite3 ^9.0.0
- cors ^2.8.5
- nodemon ^3.0.0 (dev)

### Frontend
- react ^18.2.0
- react-dom ^18.2.0
- react-router-dom ^6.20.0
- @vitejs/plugin-react ^4.2.0
- vite ^5.0.0
