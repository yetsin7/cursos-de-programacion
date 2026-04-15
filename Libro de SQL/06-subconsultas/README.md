# Capítulo 06 — Subconsultas

## ¿Qué es una subconsulta?

Una subconsulta es una consulta SQL dentro de otra consulta.
Se encierra entre paréntesis y puede aparecer en el `SELECT`, `WHERE` o `FROM`.

```sql
-- Subconsulta en WHERE: libros con más versículos que el promedio
SELECT b.long_name, COUNT(*) AS total
FROM verses v
JOIN books b ON b.book_number = v.book_number
GROUP BY b.book_number
HAVING total > (
    SELECT AVG(versiculos_por_libro)
    FROM (
        SELECT COUNT(*) AS versiculos_por_libro
        FROM verses
        GROUP BY book_number
    )
);
```

---

## Tipos de subconsultas

### Subconsulta escalar (devuelve un solo valor)
```sql
-- Máximo de versículos en un libro
SELECT long_name
FROM books
WHERE book_number = (
    SELECT book_number
    FROM verses
    GROUP BY book_number
    ORDER BY COUNT(*) DESC
    LIMIT 1
);
```

### Subconsulta con IN (devuelve una lista)
```sql
-- Libros que aparecen en el NT
SELECT long_name FROM books
WHERE book_number IN (
    SELECT DISTINCT book_number FROM verses WHERE book_number >= 400
);
```

### Subconsulta correlacionada (referencia la consulta externa)
```sql
-- Para cada libro, mostrar si tiene más de 1000 versículos
SELECT b.long_name,
    (SELECT COUNT(*) FROM verses v WHERE v.book_number = b.book_number) AS total
FROM books b;
```

---

## Archivos del capítulo

| Archivo | Contenido |
|---------|-----------|
| `01_subconsultas.sql` | Subconsultas escalares, con IN, correlacionadas |
