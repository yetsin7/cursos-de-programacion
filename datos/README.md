# Carpeta `datos/` — Recursos compartidos de todos los cursos

Esta carpeta contiene los datasets reutilizables que se usan en **todos los libros**
de este repositorio. Centralizar los datos aquí evita duplicación y asegura que
todos los cursos trabajen con la misma versión del archivo.

---

## Archivos disponibles

### `biblia_rv60.sqlite3`
**La Santa Biblia — Reina Valera 1960 con números Strong**

Base de datos SQLite3 con el texto completo de la Biblia en español (dominio público).
Es el dataset principal para ejercicios de bases de datos, scripts, análisis y proyectos
prácticos en todos los libros.

| Tabla    | Descripción                                      | Filas  |
|----------|--------------------------------------------------|--------|
| `books`  | 66 libros con nombre corto, nombre largo y color | 66     |
| `verses` | Todos los versículos con texto y números Strong  | 31,103 |
| `info`   | Metadatos de la versión (nombre, idioma, etc.)   | 8      |

---

### Estructura de la tabla `books`

```sql
CREATE TABLE books (
    book_number  INTEGER PRIMARY KEY,  -- 10=Génesis, 20=Éxodo, ..., 660=Apocalipsis
    short_name   TEXT NOT NULL,        -- Gn, Ex, Lv, ...
    long_name    TEXT NOT NULL,        -- Génesis, Éxodo, Levítico, ...
    book_color   TEXT                  -- color HEX para UI (ej: #FF6B6B)
);
```

Ejemplos de filas:

| book_number | short_name | long_name    | book_color |
|-------------|------------|--------------|------------|
| 10          | Gn         | Génesis      | #FF6B6B    |
| 190         | Sal        | Salmos       | #4ECDC4    |
| 430         | Jn         | Juan         | #45B7D1    |
| 660         | Ap         | Apocalipsis  | #96CEB4    |

> **Nota:** Los números de libro son múltiplos de 10 (10, 20, 30..., 660).

---

### Estructura de la tabla `verses`

```sql
CREATE TABLE verses (
    book_number  INTEGER NOT NULL,  -- FK → books.book_number
    chapter      INTEGER NOT NULL,  -- número de capítulo
    verse        INTEGER NOT NULL,  -- número de versículo
    text         TEXT    NOT NULL   -- texto con posibles marcas <S>NNNN</S>
);
```

Ejemplos de filas:

| book_number | chapter | verse | text |
|-------------|---------|-------|------|
| 10          | 1       | 1     | En el principio creó Dios los cielos... |
| 430         | 3       | 16    | Porque de tal manera amó Dios al mundo... |
| 190         | 23      | 1     | Jehová es mi pastor; nada me faltará. |

---

### Estructura de la tabla `info`

```sql
CREATE TABLE info (
    name   TEXT PRIMARY KEY,
    value  TEXT
);
```

Contiene metadatos: nombre de la versión, idioma, año, autor, etc.

---

## Marcas Strong

Algunos versículos contienen referencias al **Diccionario Strong** con este formato:

```
En el principio <S>7225</S> creó <S>1254</S> Dios <S>430</S>...
```

Para mostrar texto limpio en la UI, elimínalas con una expresión regular:

**Python:**
```python
import re
def limpiar_texto(texto):
    return re.sub(r'<S>\d+</S>', '', texto).strip()
```

**JavaScript:**
```javascript
const limpiarTexto = (texto) => texto.replace(/<S>\d+<\/S>/g, '').trim();
```

**Dart:**
```dart
String limpiarTexto(String texto) {
  return texto.replaceAll(RegExp(r'<S>\d+</S>'), '').trim();
}
```

**SQL:**
```sql
-- SQLite no tiene regex nativa; usa la función REPLACE para casos simples
-- o maneja la limpieza en el lenguaje del cliente
```

---

## Cómo referenciar este archivo desde cada libro

Desde cualquier archivo dentro de un capítulo del libro, la ruta relativa es:

```
../../datos/biblia_rv60.sqlite3
```

| Libro               | Ejemplo de ruta                                             |
|---------------------|-------------------------------------------------------------|
| Libro de Python     | `os.path.join(__file__, '..', '..', 'datos', 'biblia_rv60.sqlite3')` |
| Libro de JavaScript | `path.join(__dirname, '..', '..', 'datos', 'biblia_rv60.sqlite3')`   |
| Libro de SQL        | `../../datos/biblia_rv60.sqlite3` (referencia directa)               |
| Libro de Flutter    | `path.join(scriptDir, '..', '..', 'datos', 'biblia_rv60.sqlite3')`   |

---

## Consultas SQL de ejemplo

```sql
-- Génesis 1:1
SELECT v.text
FROM verses v
WHERE v.book_number = 10 AND v.chapter = 1 AND v.verse = 1;

-- Contar versículos por libro (con nombre)
SELECT b.long_name, COUNT(*) AS total_versiculos
FROM verses v
JOIN books b ON b.book_number = v.book_number
GROUP BY b.book_number
ORDER BY b.book_number;

-- Buscar versículos que contienen una palabra
SELECT b.long_name, v.chapter, v.verse, v.text
FROM verses v
JOIN books b ON b.book_number = v.book_number
WHERE v.text LIKE '%amor%'
LIMIT 10;

-- Libros del Nuevo Testamento (book_number >= 400)
SELECT long_name, short_name
FROM books
WHERE book_number >= 400
ORDER BY book_number;

-- Libro con más versículos
SELECT b.long_name, COUNT(*) AS total
FROM verses v
JOIN books b ON b.book_number = v.book_number
GROUP BY b.book_number
ORDER BY total DESC
LIMIT 1;
```

---

*Base de datos incluida únicamente con fines educativos. Texto: Biblia Reina-Valera 1960 — dominio público.*
