-- =============================================================================
-- Capítulo 12 — Window Functions
-- Archivo: 02_window_functions.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
-- =============================================================================

.headers on
.mode column


-- =============================================================================
-- ROW_NUMBER: número de fila dentro de una partición
-- =============================================================================

-- Ranking global de libros por cantidad de versículos
SELECT
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS ranking,
    b.long_name AS libro,
    COUNT(*) AS versiculos
FROM verses v
JOIN books b ON b.book_number = v.book_number
GROUP BY b.book_number
ORDER BY ranking;

-- Ranking dentro de cada testamento (PARTITION BY)
WITH conteo AS (
    SELECT
        b.long_name AS libro,
        b.book_number,
        COUNT(*) AS versiculos,
        CASE WHEN b.book_number < 400 THEN 'AT' ELSE 'NT' END AS testamento
    FROM verses v
    JOIN books b ON b.book_number = v.book_number
    GROUP BY b.book_number
)
SELECT
    testamento,
    ROW_NUMBER() OVER (PARTITION BY testamento ORDER BY versiculos DESC) AS rank_testamento,
    libro,
    versiculos
FROM conteo
ORDER BY testamento, rank_testamento;


-- =============================================================================
-- RANK y DENSE_RANK: rankings con empates
-- =============================================================================

-- RANK: deja huecos en los números cuando hay empate
-- DENSE_RANK: no deja huecos
WITH conteo AS (
    SELECT book_number, COUNT(*) AS versiculos FROM verses GROUP BY book_number
)
SELECT
    b.long_name,
    c.versiculos,
    RANK()       OVER (ORDER BY c.versiculos DESC) AS rank_con_huecos,
    DENSE_RANK() OVER (ORDER BY c.versiculos DESC) AS rank_sin_huecos
FROM conteo c
JOIN books b ON b.book_number = c.book_number
ORDER BY c.versiculos DESC
LIMIT 15;


-- =============================================================================
-- SUM y AVG como window functions: acumulados
-- =============================================================================

-- Total acumulado de versículos por libro (en orden de libro)
WITH conteo AS (
    SELECT book_number, COUNT(*) AS versiculos
    FROM verses
    GROUP BY book_number
)
SELECT
    b.long_name AS libro,
    c.versiculos,
    SUM(c.versiculos) OVER (ORDER BY b.book_number) AS versiculos_acumulados
FROM conteo c
JOIN books b ON b.book_number = c.book_number
ORDER BY b.book_number;

-- Promedio móvil de versículos (ventana de 3 libros)
WITH conteo AS (
    SELECT book_number, COUNT(*) AS versiculos
    FROM verses GROUP BY book_number
)
SELECT
    b.long_name AS libro,
    c.versiculos,
    ROUND(AVG(c.versiculos) OVER (
        ORDER BY b.book_number
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ), 1) AS promedio_movil_3
FROM conteo c
JOIN books b ON b.book_number = c.book_number
ORDER BY b.book_number;
