-- =============================================================================
-- Capítulo 04 — GROUP BY y HAVING
-- Archivo: 02_group_by_having.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
-- =============================================================================

.headers on
.mode column


-- -----------------------------------------------------------------------------
-- GROUP BY: agrupar y contar
-- -----------------------------------------------------------------------------

-- Versículos por libro (sin nombre, solo number)
SELECT book_number, COUNT(*) AS total_versiculos
FROM verses
GROUP BY book_number
ORDER BY total_versiculos DESC;

-- Versículos por capítulo del libro de Salmos (book_number = 190)
SELECT chapter, COUNT(*) AS total_versiculos
FROM verses
WHERE book_number = 190
GROUP BY chapter
ORDER BY chapter;

-- Número de capítulos por libro
SELECT book_number, COUNT(DISTINCT chapter) AS total_capitulos
FROM verses
GROUP BY book_number
ORDER BY book_number;


-- -----------------------------------------------------------------------------
-- GROUP BY con JOIN: combinar nombre del libro
-- -----------------------------------------------------------------------------

-- Versículos por libro con nombre real
SELECT b.long_name, COUNT(*) AS total_versiculos
FROM verses v
JOIN books b ON b.book_number = v.book_number
GROUP BY b.book_number
ORDER BY total_versiculos DESC;

-- Los 10 libros con más versículos
SELECT b.long_name, COUNT(*) AS total
FROM verses v
JOIN books b ON b.book_number = v.book_number
GROUP BY b.book_number
ORDER BY total DESC
LIMIT 10;

-- Los 10 libros con menos versículos
SELECT b.long_name, COUNT(*) AS total
FROM verses v
JOIN books b ON b.book_number = v.book_number
GROUP BY b.book_number
ORDER BY total ASC
LIMIT 10;


-- -----------------------------------------------------------------------------
-- HAVING: filtrar grupos después de agrupar
-- -----------------------------------------------------------------------------

-- Libros con más de 1000 versículos
SELECT b.long_name, COUNT(*) AS total
FROM verses v
JOIN books b ON b.book_number = v.book_number
GROUP BY b.book_number
HAVING total > 1000
ORDER BY total DESC;

-- Libros con menos de 30 versículos en total
SELECT b.long_name, COUNT(*) AS total
FROM verses v
JOIN books b ON b.book_number = v.book_number
GROUP BY b.book_number
HAVING total < 30
ORDER BY total ASC;

-- Capítulos de Génesis con más de 30 versículos
SELECT chapter, COUNT(*) AS versiculos
FROM verses
WHERE book_number = 10
GROUP BY chapter
HAVING versiculos > 30
ORDER BY versiculos DESC;


-- -----------------------------------------------------------------------------
-- ESTADÍSTICAS GENERALES DE LA BIBLIA
-- -----------------------------------------------------------------------------

-- Resumen del Antiguo Testamento vs Nuevo Testamento
SELECT
    CASE WHEN book_number < 400 THEN 'Antiguo Testamento'
         ELSE 'Nuevo Testamento'
    END AS testamento,
    COUNT(DISTINCT book_number) AS libros,
    COUNT(DISTINCT book_number || '-' || chapter) AS capitulos,
    COUNT(*) AS versiculos
FROM verses
GROUP BY testamento;
