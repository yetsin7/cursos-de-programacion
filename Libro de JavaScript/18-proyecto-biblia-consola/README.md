# Módulo 18 — Proyecto Biblia en Consola

## ¿Por qué la Biblia es ideal para aprender?

La Biblia Reina-Valera 1960 es un corpus de texto **perfecto para practicar programación** porque:

- **31,103 versículos** → ideal para consultas SQL, búsquedas y estadísticas
- **66 libros** → estructura jerárquica (libro → capítulo → versículo)
- **Texto limpio y conocido** → fácil de validar resultados
- **Dominio sin ambigüedad** → no necesitas conocer el negocio, solo el texto

Este proyecto es la versión JavaScript/Node.js del capítulo 29 del Libro de Python. Integra los conceptos más importantes aprendidos hasta ahora: funciones, objetos, módulos, manejo de errores, y ahora agrega acceso a bases de datos SQLite.

## Conceptos que integra

- Conexión y consulta a SQLite con `better-sqlite3`
- Limpieza de datos con expresiones regulares
- Menús interactivos con `readline` de Node.js
- Paginación de resultados
- Estadísticas con SQL y JavaScript
- Manejo de errores robusto con try/catch

## Estructura de la base de datos

**Archivo:** `../datos/biblia_rv60.sqlite3`

```
books (66 filas)
  - book_number   INTEGER  (1-66)
  - short_name    TEXT     ('Gn', 'Ex', ...)
  - long_name     TEXT     ('Génesis', 'Éxodo', ...)
  - book_color    TEXT     (color hex para UI)

verses (31,103 filas)
  - book_number   INTEGER
  - chapter       INTEGER
  - verse         INTEGER
  - text          TEXT     (contiene marcas <S>7225</S> que hay que limpiar)
```

## Cómo ejecutar

```bash
# Instalar dependencia
npm install better-sqlite3

# Explorar la base de datos
node 00_explorar_bd.js

# Lector interactivo
node 01_lector_basico.js

# Buscador de versículos
node 02_buscador.js

# Estadísticas
node 03_estadisticas.js
```

## Dependencia

```bash
npm install better-sqlite3
```

> `better-sqlite3` es una librería sincrónica para SQLite en Node.js.
> Es más simple de usar que las alternativas asíncronas para scripts de consola.
