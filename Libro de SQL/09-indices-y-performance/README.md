# Capítulo 09 — Índices y Performance

## ¿Qué es un índice?

Un índice es una estructura de datos que acelera las búsquedas.
Es como el índice de un libro: en lugar de leer todas las páginas para encontrar
"Juan 3:16", buscas en el índice y vas directo a la página correcta.

**Sin índice:** SQLite lee todas las filas de la tabla (full table scan).
**Con índice:** SQLite salta directamente a las filas relevantes.

---

## CREATE INDEX

```sql
-- Índice simple en una columna
CREATE INDEX idx_verses_book ON verses (book_number);

-- Índice compuesto (múltiples columnas)
CREATE INDEX idx_verses_location ON verses (book_number, chapter, verse);

-- Índice único (previene duplicados)
CREATE UNIQUE INDEX idx_books_short ON books (short_name);
```

---

## ¿Cuándo usar índices?

**Crear índice cuando:**
- La columna aparece frecuentemente en `WHERE`
- La columna se usa para `JOIN` entre tablas
- La columna se usa en `ORDER BY` con muchos datos

**No crear índice cuando:**
- La tabla tiene muy pocas filas
- La columna se actualiza muy frecuentemente (los índices ralentizan INSERT/UPDATE)
- La columna tiene muy pocos valores únicos (por ejemplo, una columna boolean)

---

## EXPLAIN QUERY PLAN

SQLite te dice cómo va a ejecutar una consulta:

```sql
EXPLAIN QUERY PLAN
SELECT * FROM verses WHERE book_number = 430;
```

- `SCAN verses` → lee toda la tabla (lento con millones de filas)
- `SEARCH verses USING INDEX` → usa un índice (rápido)

---

## Archivos del capítulo

| Archivo | Contenido |
|---------|-----------|
| `01_indices.sql` | Crear índices y medir impacto con EXPLAIN QUERY PLAN |
