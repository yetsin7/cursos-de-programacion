# Capítulo 03 — ORDER BY, LIMIT y OFFSET

## ORDER BY — Ordenar resultados

Por defecto, SQL no garantiza el orden de los resultados. Usa `ORDER BY` para
ordenar de forma explícita.

```sql
-- Orden ascendente (por defecto, de A a Z / de menor a mayor)
SELECT long_name FROM books ORDER BY long_name ASC;

-- Orden descendente (de Z a A / de mayor a menor)
SELECT long_name FROM books ORDER BY long_name DESC;

-- Ordenar por múltiples columnas
SELECT chapter, verse FROM verses
WHERE book_number = 430
ORDER BY chapter ASC, verse ASC;
```

---

## LIMIT — Limitar el número de resultados

```sql
-- Solo los primeros 10 resultados
SELECT long_name FROM books LIMIT 10;

-- Los 5 versículos más recientes (libro de mayor número)
SELECT book_number, chapter, verse
FROM verses
ORDER BY book_number DESC, chapter DESC, verse DESC
LIMIT 5;
```

---

## OFFSET — Paginar resultados

`OFFSET` salta un número de filas antes de devolver resultados.
Junto con `LIMIT`, permite implementar paginación.

```sql
-- Página 1: primeros 10 libros
SELECT long_name FROM books LIMIT 10 OFFSET 0;

-- Página 2: siguientes 10 libros
SELECT long_name FROM books LIMIT 10 OFFSET 10;

-- Página 3: siguientes 10 libros
SELECT long_name FROM books LIMIT 10 OFFSET 20;
```

**Fórmula para paginación:**
```
OFFSET = (número_de_página - 1) × registros_por_página
```

---

## Archivos del capítulo

| Archivo | Contenido |
|---------|-----------|
| `01_order_limit_offset.sql` | ORDER BY, LIMIT, OFFSET con la Biblia |
