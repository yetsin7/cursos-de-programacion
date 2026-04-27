# Carpeta `datos/` — Recursos del Libro de JavaScript

> **La base de datos `biblia_rv60.sqlite3` se movió a la carpeta compartida.**

## Nueva ubicación

```
cursos-de-programacion/
└── datos/
    └── biblia_rv60.sqlite3   ← aquí está ahora
```

Ruta relativa desde cualquier capítulo de este libro:

```javascript
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const DB_PATH = path.join(__dirname, '..', '..', 'datos', 'biblia_rv60.sqlite3');
```

O con CommonJS:

```javascript
const path = require('path');
const DB_PATH = path.join(__dirname, '..', '..', 'datos', 'biblia_rv60.sqlite3');
```

## ¿Por qué se movió?

Para evitar tener copias duplicadas del mismo archivo en cada libro.
Todos los libros (Python, JavaScript, SQL, Flutter) apuntan ahora
a un único archivo centralizado en `cursos-de-programación/datos/`.

→ Consulta `../../datos/README.md` para la documentación completa de la base de datos.
