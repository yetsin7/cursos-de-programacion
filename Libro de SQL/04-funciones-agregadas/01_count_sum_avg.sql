-- =============================================================================
-- Capítulo 04 — Funciones Agregadas: COUNT, AVG, MIN, MAX
-- Archivo: 01_count_sum_avg.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
-- =============================================================================

.headers on
.mode column


-- -----------------------------------------------------------------------------
-- COUNT: contar filas
-- -----------------------------------------------------------------------------

-- Total de libros
SELECT COUNT(*) AS total_libros FROM books;

-- Total de versículos
SELECT COUNT(*) AS total_versiculos FROM verses;

-- Libros que tienen color definido (no NULL)
SELECT COUNT(book_color) AS libros_con_color FROM books;

-- Libros sin color definido
SELECT COUNT(*) - COUNT(book_color) AS libros_sin_color FROM books;


-- -----------------------------------------------------------------------------
-- MIN y MAX: valor mínimo y máximo
-- -----------------------------------------------------------------------------

-- Primer y último número de libro
SELECT MIN(book_number) AS primer_libro, MAX(book_number) AS ultimo_libro
FROM books;

-- Capítulo mínimo y máximo en toda la Biblia
SELECT MIN(chapter) AS min_capitulo, MAX(chapter) AS max_capitulo
FROM verses;

-- Libro con el versículo de número más alto
SELECT MAX(verse) AS maximo_versiculo FROM verses;

-- En qué libro y capítulo está ese versículo máximo
SELECT book_number, chapter, verse
FROM verses
WHERE verse = (SELECT MAX(verse) FROM verses);


-- -----------------------------------------------------------------------------
-- AVG: promedio
-- -----------------------------------------------------------------------------

-- Promedio de versículos por capítulo en toda la Biblia
SELECT ROUND(AVG(versiculos_por_capitulo), 1) AS promedio
FROM (
    SELECT COUNT(*) AS versiculos_por_capitulo
    FROM verses
    GROUP BY book_number, chapter
);

-- Promedio de versículos por libro
SELECT ROUND(AVG(versiculos_por_libro), 1) AS promedio_por_libro
FROM (
    SELECT COUNT(*) AS versiculos_por_libro
    FROM verses
    GROUP BY book_number
);


-- -----------------------------------------------------------------------------
-- LENGTH: longitud de texto
-- -----------------------------------------------------------------------------

-- Versículo más largo de toda la Biblia
SELECT book_number, chapter, verse, text, LENGTH(text) AS longitud
FROM verses
ORDER BY longitud DESC
LIMIT 1;

-- Versículo más corto de la Biblia
SELECT book_number, chapter, verse, text, LENGTH(text) AS longitud
FROM verses
ORDER BY longitud ASC
LIMIT 1;

-- Promedio de longitud de versículos
SELECT ROUND(AVG(LENGTH(text)), 1) AS longitud_promedio FROM verses;
