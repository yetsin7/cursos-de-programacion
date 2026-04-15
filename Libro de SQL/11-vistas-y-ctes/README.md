# Capítulo 11 — Vistas (VIEW) y CTEs (WITH)

## CREATE VIEW — Vistas

Una vista es una **consulta guardada** que funciona como una tabla virtual.
No almacena datos — cada vez que se consulta, ejecuta la consulta subyacente.

```sql
-- Crear una vista: versículos con nombre del libro incluido
CREATE VIEW vista_versiculos AS
SELECT
    b.long_name  AS libro,
    b.short_name AS abrev,
    v.chapter    AS capitulo,
    v.verse      AS versiculo,
    v.text       AS texto
FROM verses v
JOIN books b ON b.book_number = v.book_number;

-- Usar la vista como si fuera una tabla
SELECT * FROM vista_versiculos WHERE libro = 'Juan' LIMIT 5;
SELECT COUNT(*) FROM vista_versiculos WHERE texto LIKE '%amor%';
```

**Ventajas de las vistas:**
- Simplifican consultas complejas (el JOIN queda oculto)
- Reutilización: múltiples consultas usan la misma vista
- Seguridad: puedes dar acceso a una vista sin exponer las tablas base

---

## CTEs — Common Table Expressions (WITH)

Un CTE es como una vista temporal que solo existe durante la consulta.
Mejora la legibilidad de consultas complejas.

```sql
-- CTE básica
WITH versiculos_juan AS (
    SELECT v.chapter, v.verse, v.text
    FROM verses v
    JOIN books b ON b.book_number = v.book_number
    WHERE b.long_name = 'Juan'
)
SELECT * FROM versiculos_juan WHERE chapter = 3;
```

**CTEs múltiples:**
```sql
WITH
  libros_nt AS (
      SELECT * FROM books WHERE book_number >= 400
  ),
  versiculos_nt AS (
      SELECT v.* FROM verses v
      JOIN libros_nt l ON l.book_number = v.book_number
  )
SELECT l.long_name, COUNT(*) AS total
FROM versiculos_nt v
JOIN libros_nt l ON l.book_number = v.book_number
GROUP BY l.book_number
ORDER BY total DESC;
```

---

## Archivos del capítulo

| Archivo | Contenido |
|---------|-----------|
| `01_vistas.sql` | CREATE VIEW, usar y eliminar vistas |
| `02_ctes.sql` | CTEs simples y múltiples con la Biblia |
