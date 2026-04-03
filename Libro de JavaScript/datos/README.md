# Carpeta `datos/` — Base de datos Biblia RV60

Esta carpeta está reservada para almacenar la base de datos SQLite utilizada
en los ejercicios avanzados del repositorio.

---

## Archivo: `biblia_rv60.sqlite3`

Base de datos SQLite con la Biblia Reina-Valera 1960 completa, incluyendo
marcas Strong para estudio bíblico profundo.

### Estadísticas

| Dato | Valor |
|------|-------|
| Total de versículos | 31,103 |
| Libros | 66 |
| Idioma | Español (RV60) |
| Marcas Strong incluidas | Sí |
| Formato | SQLite 3 |

---

## Estructura de tablas

### Tabla `books` — Libros de la Biblia

| Columna | Tipo | Descripción |
|---------|------|-------------|
| `id` | INTEGER | ID único del libro (1–66) |
| `name` | TEXT | Nombre completo del libro |
| `abbrev` | TEXT | Abreviatura estándar |
| `testament` | TEXT | `'OT'` (Antiguo) o `'NT'` (Nuevo) |
| `chapters` | INTEGER | Total de capítulos en el libro |

### Tabla `verses` — Versículos

| Columna | Tipo | Descripción |
|---------|------|-------------|
| `id` | INTEGER | ID único del versículo |
| `book_id` | INTEGER | FK → books.id |
| `chapter` | INTEGER | Número de capítulo |
| `verse` | INTEGER | Número de versículo |
| `text` | TEXT | Texto del versículo en español RV60 |
| `strong_numbers` | TEXT | Marcas Strong separadas por espacios (puede ser NULL) |

### Tabla `info` — Metadatos de la base de datos

| Columna | Tipo | Descripción |
|---------|------|-------------|
| `key` | TEXT | Clave del metadato |
| `value` | TEXT | Valor del metadato |

Claves comunes: `version`, `language`, `encoding`, `source`.

---

## Consultas de ejemplo (SQLite)

```sql
-- Obtener Génesis 1:1
SELECT v.text
FROM verses v
JOIN books b ON b.id = v.book_id
WHERE b.name = 'Génesis' AND v.chapter = 1 AND v.verse = 1;

-- Contar versículos por libro
SELECT b.name, COUNT(v.id) AS total
FROM books b
JOIN verses v ON v.book_id = b.id
GROUP BY b.id
ORDER BY b.id;

-- Buscar versículos que contengan una palabra
SELECT b.name, v.chapter, v.verse, v.text
FROM verses v
JOIN books b ON b.id = v.book_id
WHERE v.text LIKE '%amor%'
LIMIT 10;
```

---

## Uso con Node.js

Para usar esta base de datos en Node.js instala el paquete `better-sqlite3`:

```bash
npm install better-sqlite3
```

Ejemplo básico:

```js
import Database from 'better-sqlite3';

const db = new Database('./datos/biblia_rv60.sqlite3');

const versiculo = db
  .prepare('SELECT text FROM verses WHERE book_id = 1 AND chapter = 1 AND verse = 1')
  .get();

console.log(versiculo.text);
```

---

## Nota

Si el archivo `biblia_rv60.sqlite3` no está presente en esta carpeta,
puedes descargarlo de fuentes públicas de bases de datos bíblicas en SQLite
o generarlo a partir de archivos OSIS/Sword con herramientas de conversión.
