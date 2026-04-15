-- =============================================================================
-- Capítulo 06 — Subconsultas
-- Archivo: 01_subconsultas.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
-- =============================================================================

.headers on
.mode column


-- -----------------------------------------------------------------------------
-- SUBCONSULTA ESCALAR: devuelve un solo valor
-- -----------------------------------------------------------------------------

-- ¿Cuál es el libro con más versículos?
SELECT b.long_name, COUNT(*) AS total
FROM verses v
JOIN books b ON b.book_number = v.book_number
GROUP BY b.book_number
ORDER BY total DESC
LIMIT 1;

-- Lo mismo con subconsulta anidada
SELECT long_name AS libro_con_mas_versiculos
FROM books
WHERE book_number = (
    SELECT book_number
    FROM verses
    GROUP BY book_number
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- ¿Cuál es el versículo más largo? (obtenemos su texto)
SELECT text
FROM verses
WHERE LENGTH(text) = (SELECT MAX(LENGTH(text)) FROM verses);


-- -----------------------------------------------------------------------------
-- SUBCONSULTA CON IN: filtrar con una lista dinámica
-- -----------------------------------------------------------------------------

-- Libros que tienen más de 100 capítulos (en realidad versículos)
-- Primero: libros con más de 1000 versículos
SELECT long_name
FROM books
WHERE book_number IN (
    SELECT book_number
    FROM verses
    GROUP BY book_number
    HAVING COUNT(*) > 1000
);

-- Libros cuyo nombre corto tiene solo 2 caracteres
SELECT long_name
FROM books
WHERE short_name IN (
    SELECT short_name FROM books WHERE LENGTH(short_name) = 2
);


-- -----------------------------------------------------------------------------
-- SUBCONSULTA EN FROM: como tabla temporal
-- -----------------------------------------------------------------------------

-- Promedio de versículos por libro
SELECT ROUND(AVG(total), 1) AS promedio_versiculos_por_libro
FROM (
    SELECT COUNT(*) AS total
    FROM verses
    GROUP BY book_number
) AS conteos;

-- Libros con más versículos que el promedio
SELECT b.long_name, COUNT(*) AS total
FROM verses v
JOIN books b ON b.book_number = v.book_number
GROUP BY b.book_number
HAVING total > (
    SELECT AVG(cnt) FROM (
        SELECT COUNT(*) AS cnt FROM verses GROUP BY book_number
    )
)
ORDER BY total DESC;


-- -----------------------------------------------------------------------------
-- SUBCONSULTA CORRELACIONADA
-- -----------------------------------------------------------------------------

-- Para cada libro: su nombre y su total de versículos
SELECT
    b.long_name AS libro,
    (SELECT COUNT(*) FROM verses v WHERE v.book_number = b.book_number) AS versiculos
FROM books b
ORDER BY versiculos DESC;
