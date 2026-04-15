# Capítulo 13 — Proyecto Final: Análisis Completo de la Biblia

## Descripción del proyecto

En este proyecto final aplicamos **todo lo aprendido** en el libro para hacer un
análisis exhaustivo de la base de datos de la Biblia Reina-Valera 1960.

Pasamos de consultas simples a análisis estadísticos completos, usando JOINs,
subconsultas, CTEs, window functions, vistas y más.

---

## Dataset

```
../../datos/biblia_rv60.sqlite3
```

| Tabla    | Filas  | Descripción |
|----------|--------|-------------|
| `books`  | 66     | Los 66 libros de la Biblia |
| `verses` | 31,103 | Todos los versículos en español |
| `info`   | 8      | Metadatos de la versión |

---

## Archivos del proyecto

| Archivo | Contenido |
|---------|-----------|
| `01_explorar.sql` | Exploración inicial: estructura, conteos, primeros datos |
| `02_consultas_basicas.sql` | SELECT, WHERE, JOIN — leer versículos como un usuario real |
| `03_consultas_avanzadas.sql` | GROUP BY, subconsultas, CTEs — estadísticas profundas |
| `04_estadisticas.sql` | Análisis completo: distribuciones, rankings, patrones |

---

## Lo que aprenderás en este proyecto

1. Cómo explorar una base de datos desconocida con `sqlite_master` y `PRAGMA`
2. Leer datos reales: capítulos, libros, versículos específicos
3. Generar reportes: libros más largos, versículos más cortos, palabras más frecuentes
4. Usar CTEs para estructurar consultas complejas y legibles
5. Aplicar window functions para crear rankings dinámicos
6. Crear vistas que simplifican el acceso para múltiples consultas
7. Analizar patrones estadísticos en un dataset de 31,000+ filas

---

## Cómo ejecutar

```bash
# Opción 1: ejecutar directamente en la terminal
sqlite3 ../../datos/biblia_rv60.sqlite3 < 01_explorar.sql

# Opción 2: entrar al CLI interactivo
sqlite3 ../../datos/biblia_rv60.sqlite3
.read 01_explorar.sql

# Opción 3: DB Browser for SQLite
# Abrir el archivo de BD y copiar las consultas en la pestaña "Ejecutar SQL"
```
