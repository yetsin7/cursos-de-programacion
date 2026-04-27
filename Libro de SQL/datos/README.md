# Carpeta `datos/` — Recursos del Libro de SQL

> **La base de datos está en la carpeta compartida del repositorio.**

## Ubicación del archivo

```
cursos-de-programacion/
└── datos/
    └── biblia_rv60.sqlite3   ← aquí está
```

Ruta relativa desde cualquier capítulo de este libro:

```
../../datos/biblia_rv60.sqlite3
```

## Abrir con SQLite CLI

```bash
# Desde la carpeta de cualquier capítulo:
sqlite3 ../../datos/biblia_rv60.sqlite3
```

## ¿Por qué está allá y no aquí?

Para evitar duplicación: Python, JavaScript, Flutter y SQL comparten el mismo archivo.
Solo hay una copia, en `cursos-de-programación/datos/`.

→ Consulta `../../datos/README.md` para la documentación completa de las tablas.
