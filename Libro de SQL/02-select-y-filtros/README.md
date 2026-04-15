# Capítulo 02 — SELECT y Filtros con WHERE

## El comando SELECT

`SELECT` es el comando más usado en SQL. Permite recuperar datos de una o más tablas.

```sql
-- Sintaxis completa (el orden importa)
SELECT columnas
FROM tabla
WHERE condicion;
```

---

## La cláusula WHERE

`WHERE` filtra los resultados. Solo devuelve las filas que cumplen la condición.

```sql
-- Sin filtro: devuelve todos los libros (66)
SELECT long_name FROM books;

-- Con filtro: devuelve solo libros cuyo book_number es mayor a 400
SELECT long_name FROM books WHERE book_number > 400;
```

---

## Operadores de comparación

| Operador | Significado | Ejemplo |
|----------|-------------|---------|
| `=`  | Igual | `WHERE book_number = 430` |
| `!=` o `<>` | Distinto | `WHERE short_name != 'Gn'` |
| `>`  | Mayor que | `WHERE book_number > 400` |
| `<`  | Menor que | `WHERE book_number < 400` |
| `>=` | Mayor o igual | `WHERE book_number >= 400` |
| `<=` | Menor o igual | `WHERE book_number <= 390` |

---

## Operadores lógicos: AND, OR, NOT

```sql
-- AND: ambas condiciones deben ser verdaderas
SELECT long_name
FROM books
WHERE book_number >= 400 AND book_number <= 500;

-- OR: al menos una condición debe ser verdadera
SELECT long_name
FROM books
WHERE long_name = 'Juan' OR long_name = 'Marcos';

-- NOT: invierte la condición
SELECT long_name
FROM books
WHERE NOT book_number = 10;
```

---

## BETWEEN — Rango de valores

```sql
-- Entre dos valores (inclusive en ambos extremos)
SELECT long_name
FROM books
WHERE book_number BETWEEN 400 AND 500;

-- Equivale a:
WHERE book_number >= 400 AND book_number <= 500
```

---

## IN — Lista de valores

```sql
-- book_number está en la lista
SELECT long_name
FROM books
WHERE book_number IN (10, 430, 660);

-- Equivale a:
WHERE book_number = 10 OR book_number = 430 OR book_number = 660
```

---

## LIKE — Búsqueda de texto

```sql
-- % es un comodín que representa cero o más caracteres
SELECT long_name FROM books WHERE long_name LIKE 'S%';      -- empieza con S
SELECT long_name FROM books WHERE long_name LIKE '%s';      -- termina con s
SELECT long_name FROM books WHERE long_name LIKE '%an%';    -- contiene "an"

-- _ es un comodín que representa exactamente un carácter
SELECT long_name FROM books WHERE long_name LIKE '_éxodo';  -- un carácter antes de "éxodo"
```

---

## IS NULL / IS NOT NULL

```sql
-- Filas donde book_color tiene valor
SELECT long_name FROM books WHERE book_color IS NOT NULL;

-- Filas donde book_color no tiene valor
SELECT long_name FROM books WHERE book_color IS NULL;
```

> **Importante:** No uses `= NULL`. En SQL, NULL no es igual a nada, ni a sí mismo.
> Siempre usa `IS NULL` o `IS NOT NULL`.

---

## Archivos del capítulo

| Archivo | Contenido |
|---------|-----------|
| `01_select_basico.sql` | SELECT con distintas columnas, aliases, DISTINCT |
| `02_where_operadores.sql` | WHERE con todos los operadores de comparación |
| `03_busqueda_texto.sql` | LIKE, BETWEEN, IN sobre los versículos de la Biblia |
