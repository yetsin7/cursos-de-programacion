# 24 — Bases de Datos desde Node.js

Node.js puede conectarse a bases de datos SQL y NoSQL. Este módulo cubre SQLite (ideal para proyectos pequeños y de escritorio) y una introducción a Prisma ORM.

## Contenido

| Archivo | Tema |
|---|---|
| `01_sqlite_node.js` | better-sqlite3 — API síncrona, simple y rápida |
| `02_crud_completo.js` | CRUD completo con clase NotasDB |
| `03_prisma_intro.js` | Introducción conceptual a Prisma ORM |

## ¿Por qué SQLite?

- Un solo archivo `.db` — fácil de distribuir y hacer backup
- No requiere servidor — se ejecuta en el mismo proceso de Node.js
- Perfecto para apps de escritorio, prototipos y proyectos pequeños
- better-sqlite3 tiene la API más simple y es síncrona (más fácil de razonar)

## Instalación

```bash
npm install better-sqlite3
```

## Para proyectos más grandes

Usa **Prisma** con PostgreSQL o MySQL cuando necesites:
- Múltiples usuarios concurrentes
- Escalar el backend horizontalmente
- Tipado automático con TypeScript
