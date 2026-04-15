# Capítulo 04 — Funciones Agregadas y GROUP BY

## ¿Qué son las funciones agregadas?

Las funciones agregadas calculan un solo valor a partir de un grupo de filas.
En lugar de devolver una fila por registro, devuelven **un resumen** del conjunto.

| Función | Descripción | Ejemplo |
|---------|-------------|---------|
| `COUNT(*)` | Cuenta filas | Total de versículos |
| `COUNT(col)` | Cuenta filas no NULL | Total con color definido |
| `SUM(col)` | Suma valores | Suma de book_numbers |
| `AVG(col)` | Promedio | Promedio de versículos por capítulo |
| `MIN(col)` | Valor mínimo | Primer capítulo |
| `MAX(col)` | Valor máximo | Último capítulo |

---

## COUNT — Contar filas

```sql
-- Contar todos los versículos
SELECT COUNT(*) AS total FROM verses;

-- Contar solo filas donde book_color no es NULL
SELECT COUNT(book_color) AS libros_con_color FROM books;
```

---

## GROUP BY — Agrupar resultados

`GROUP BY` divide las filas en grupos y aplica la función agregada a cada grupo.

```sql
-- ¿Cuántos versículos tiene cada libro?
SELECT book_number, COUNT(*) AS total_versiculos
FROM verses
GROUP BY book_number
ORDER BY total_versiculos DESC;
```

**Regla:** Cuando usas `GROUP BY`, las columnas en el `SELECT` deben ser:
- La columna por la que agrupas, O
- Una función agregada

---

## HAVING — Filtrar grupos

`HAVING` es como `WHERE` pero para grupos (se aplica después de `GROUP BY`).

```sql
-- Libros con más de 1000 versículos
SELECT book_number, COUNT(*) AS total
FROM verses
GROUP BY book_number
HAVING total > 1000;
```

**Diferencia clave:**
- `WHERE` filtra filas **antes** de agrupar
- `HAVING` filtra grupos **después** de agrupar

---

## Orden de cláusulas SQL

El orden en que SQL procesa las cláusulas (no es el mismo en que se escriben):

```
1. FROM        → de qué tabla
2. WHERE       → filtrar filas
3. GROUP BY    → agrupar
4. HAVING      → filtrar grupos
5. SELECT      → qué mostrar
6. ORDER BY    → ordenar
7. LIMIT       → cuántos mostrar
```

---

## Archivos del capítulo

| Archivo | Contenido |
|---------|-----------|
| `01_count_sum_avg.sql` | COUNT, SUM, AVG, MIN, MAX con la Biblia |
| `02_group_by_having.sql` | GROUP BY, HAVING — estadísticas por libro |
