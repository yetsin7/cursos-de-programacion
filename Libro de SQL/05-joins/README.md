# Capítulo 05 — JOINs: Unir tablas

## ¿Qué es un JOIN?

Un `JOIN` combina filas de dos o más tablas basándose en una columna relacionada.
Sin JOINs, estarías limitado a consultar una sola tabla a la vez.

En nuestra base de datos:
- `books` tiene el nombre de cada libro
- `verses` tiene los versículos pero solo el `book_number`, no el nombre
- Con JOIN podemos combinar ambas tablas para obtener nombre + versículo

---

## Tipos de JOIN

```
Tabla A (books)    Tabla B (verses)
┌───────┐          ┌───────┐
│  10   │──────────│  10   │  ← INNER JOIN: solo los que coinciden
│  20   │──────────│  20   │
│  30   │    ╳     │       │  ← solo en A (LEFT JOIN devuelve estos)
└───────┘          └───────┘
```

| Tipo | Descripción |
|------|-------------|
| `INNER JOIN` | Solo filas que tienen coincidencia en ambas tablas |
| `LEFT JOIN` | Todas las filas de la izquierda + coincidencias de la derecha |
| `RIGHT JOIN` | Todas las filas de la derecha + coincidencias de la izquierda |
| `FULL OUTER JOIN` | Todas las filas de ambas tablas |

> SQLite solo soporta `INNER JOIN` y `LEFT JOIN` de forma nativa.

---

## INNER JOIN — Solo coincidencias

```sql
-- Combinar nombre del libro con sus versículos
SELECT b.long_name, v.chapter, v.verse, v.text
FROM verses v
INNER JOIN books b ON b.book_number = v.book_number
WHERE b.long_name = 'Juan'
LIMIT 5;
```

La cláusula `ON` define la condición de unión: qué columna de cada tabla son iguales.

---

## LEFT JOIN — Todo lo de la izquierda

```sql
-- Todos los libros, tengan o no versículos registrados
SELECT b.long_name, COUNT(v.verse) AS versiculos
FROM books b
LEFT JOIN verses v ON v.book_number = b.book_number
GROUP BY b.book_number;
```

Útil para encontrar registros "huérfanos" (sin datos en la otra tabla).

---

## Alias de tablas

Es buena práctica usar alias cortos para las tablas en JOINs:

```sql
-- Sin alias (verbose)
FROM verses INNER JOIN books ON books.book_number = verses.book_number

-- Con alias (limpio)
FROM verses v INNER JOIN books b ON b.book_number = v.book_number
```

---

## Archivos del capítulo

| Archivo | Contenido |
|---------|-----------|
| `01_inner_join.sql` | INNER JOIN entre books y verses |
| `02_left_join.sql` | LEFT JOIN y detección de registros sin coincidencia |
