# Capítulo 12 — Consultas Avanzadas

## CASE — Expresiones condicionales

`CASE` permite lógica condicional dentro de una consulta SQL:

```sql
SELECT long_name,
    CASE
        WHEN book_number < 200  THEN 'Pentateuco e Historia'
        WHEN book_number < 300  THEN 'Poéticos'
        WHEN book_number < 400  THEN 'Profetas'
        WHEN book_number < 500  THEN 'Evangelios y Hechos'
        ELSE                         'Epístolas y Apocalipsis'
    END AS categoria
FROM books;
```

---

## Window Functions — Funciones de ventana

Las window functions calculan valores sobre un conjunto de filas relacionadas
sin colapsar el resultado como `GROUP BY`.

```sql
-- ROW_NUMBER: número de fila dentro de cada grupo
SELECT
    b.long_name,
    COUNT(*) AS versiculos,
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS ranking
FROM verses v
JOIN books b ON b.book_number = v.book_number
GROUP BY b.book_number;
```

---

## Funciones de texto en SQLite

| Función | Descripción | Ejemplo |
|---------|-------------|---------|
| `LENGTH(s)` | Longitud de la cadena | `LENGTH('Juan')` → 4 |
| `UPPER(s)` | Convertir a mayúsculas | `UPPER('juan')` → `JUAN` |
| `LOWER(s)` | Convertir a minúsculas | `LOWER('JUAN')` → `juan` |
| `SUBSTR(s, i, n)` | Subcadena desde posición i, n caracteres | `SUBSTR('Juan',1,2)` → `Ju` |
| `REPLACE(s, a, b)` | Reemplazar texto | `REPLACE(text,'<S>','')` |
| `TRIM(s)` | Eliminar espacios al inicio y fin | `TRIM(' juan ')` → `juan` |
| `INSTR(s, sub)` | Posición de subcadena | `INSTR('Juan','an')` → 3 |

---

## Archivos del capítulo

| Archivo | Contenido |
|---------|-----------|
| `01_case_expresiones.sql` | CASE, COALESCE, NULLIF |
| `02_window_functions.sql` | ROW_NUMBER, RANK, OVER, PARTITION BY |
| `03_funciones_texto.sql` | LENGTH, SUBSTR, REPLACE, limpiar marcas Strong |
