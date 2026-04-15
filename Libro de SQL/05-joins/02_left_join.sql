-- =============================================================================
-- Capítulo 05 — LEFT JOIN
-- Archivo: 02_left_join.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
-- =============================================================================

.headers on
.mode column


-- -----------------------------------------------------------------------------
-- LEFT JOIN: todos los registros de la tabla izquierda
-- -----------------------------------------------------------------------------

-- Todos los libros con conteo de versículos
-- (si un libro no tuviera versículos, aparecería con 0)
SELECT b.long_name AS libro, COUNT(v.verse) AS total_versiculos
FROM books b
LEFT JOIN verses v ON v.book_number = b.book_number
GROUP BY b.book_number
ORDER BY b.book_number;

-- Diferencia entre INNER JOIN y LEFT JOIN:
-- Con INNER JOIN: solo libros que tienen versículos
SELECT COUNT(*) AS libros_con_inner_join
FROM books b
INNER JOIN verses v ON v.book_number = b.book_number
GROUP BY b.book_number;

-- Con LEFT JOIN: todos los libros aunque no tengan versículos
SELECT b.long_name, COUNT(v.verse) AS versiculos
FROM books b
LEFT JOIN verses v ON v.book_number = b.book_number
GROUP BY b.book_number
HAVING versiculos = 0;
-- Si el resultado está vacío, todos los libros tienen versículos


-- -----------------------------------------------------------------------------
-- DETECTAR registros sin coincidencia (IS NULL)
-- -----------------------------------------------------------------------------

-- Libros que NO tienen ningún versículo registrado
SELECT b.long_name
FROM books b
LEFT JOIN verses v ON v.book_number = b.book_number
WHERE v.book_number IS NULL;
-- Si está vacío, todos los libros tienen versículos — ¡buena señal!


-- -----------------------------------------------------------------------------
-- RESUMEN COMPARATIVO
-- -----------------------------------------------------------------------------

-- Comparar INNER vs LEFT (conteo total de filas devueltas)
SELECT 'INNER JOIN' AS tipo, COUNT(*) AS filas
FROM verses v INNER JOIN books b ON b.book_number = v.book_number
UNION ALL
SELECT 'LEFT JOIN', COUNT(*)
FROM books b LEFT JOIN verses v ON v.book_number = b.book_number;
