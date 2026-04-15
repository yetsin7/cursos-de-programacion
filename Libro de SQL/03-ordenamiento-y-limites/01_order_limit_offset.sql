-- =============================================================================
-- Capítulo 03 — ORDER BY, LIMIT y OFFSET
-- Archivo: 01_order_limit_offset.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
-- =============================================================================

.headers on
.mode column


-- -----------------------------------------------------------------------------
-- ORDER BY: ordenar resultados
-- -----------------------------------------------------------------------------

-- Libros en orden alfabético (ASC es el predeterminado)
SELECT long_name FROM books ORDER BY long_name ASC;

-- Libros en orden alfabético inverso
SELECT long_name FROM books ORDER BY long_name DESC;

-- Libros ordenados por número de libro
SELECT book_number, long_name FROM books ORDER BY book_number;

-- Versículos de Génesis ordenados por capítulo y versículo
SELECT chapter, verse, text
FROM verses
WHERE book_number = 10
ORDER BY chapter ASC, verse ASC
LIMIT 10;

-- Los 5 libros con nombre más largo (por número de caracteres)
SELECT long_name, LENGTH(long_name) AS largo
FROM books
ORDER BY largo DESC
LIMIT 5;


-- -----------------------------------------------------------------------------
-- LIMIT: restringir el número de resultados
-- -----------------------------------------------------------------------------

-- Solo los primeros 5 libros
SELECT long_name FROM books LIMIT 5;

-- Los últimos 5 libros (ordenando al revés)
SELECT long_name FROM books ORDER BY book_number DESC LIMIT 5;

-- El primer versículo de la Biblia
SELECT chapter, verse, text
FROM verses
WHERE book_number = 10
ORDER BY chapter, verse
LIMIT 1;

-- El último versículo de la Biblia (Apocalipsis = 660)
SELECT chapter, verse, text
FROM verses
WHERE book_number = 660
ORDER BY chapter DESC, verse DESC
LIMIT 1;


-- -----------------------------------------------------------------------------
-- OFFSET: paginación
-- -----------------------------------------------------------------------------

-- Página 1 de libros (libros 1-10)
SELECT long_name FROM books ORDER BY book_number LIMIT 10 OFFSET 0;

-- Página 2 de libros (libros 11-20)
SELECT long_name FROM books ORDER BY book_number LIMIT 10 OFFSET 10;

-- Página 3 de libros (libros 21-30)
SELECT long_name FROM books ORDER BY book_number LIMIT 10 OFFSET 20;

-- Paginación de versículos de Génesis: página 2 (versículos 11-20)
SELECT chapter, verse, text
FROM verses
WHERE book_number = 10 AND chapter = 1
ORDER BY verse
LIMIT 10 OFFSET 10;
