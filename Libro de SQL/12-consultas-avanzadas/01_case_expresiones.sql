-- =============================================================================
-- Capítulo 12 — CASE, COALESCE, NULLIF
-- Archivo: 01_case_expresiones.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
-- =============================================================================

.headers on
.mode column


-- =============================================================================
-- CASE WHEN: lógica condicional
-- =============================================================================

-- Categorizar libros por sección bíblica
SELECT long_name AS libro,
    CASE
        WHEN book_number BETWEEN 10  AND 50  THEN 'Pentateuco'
        WHEN book_number BETWEEN 60  AND 170 THEN 'Historia'
        WHEN book_number BETWEEN 180 AND 220 THEN 'Poéticos'
        WHEN book_number BETWEEN 230 AND 390 THEN 'Profetas'
        WHEN book_number BETWEEN 400 AND 450 THEN 'Evangelios y Hechos'
        WHEN book_number BETWEEN 460 AND 640 THEN 'Epístolas'
        ELSE                                      'Apocalipsis'
    END AS seccion
FROM books
ORDER BY book_number;

-- Contar libros por sección
SELECT
    CASE
        WHEN book_number BETWEEN 10  AND 50  THEN 'Pentateuco'
        WHEN book_number BETWEEN 60  AND 170 THEN 'Historia'
        WHEN book_number BETWEEN 180 AND 220 THEN 'Poéticos'
        WHEN book_number BETWEEN 230 AND 390 THEN 'Profetas'
        WHEN book_number BETWEEN 400 AND 450 THEN 'Evangelios y Hechos'
        WHEN book_number BETWEEN 460 AND 640 THEN 'Epístolas'
        ELSE                                      'Apocalipsis'
    END AS seccion,
    COUNT(*) AS libros
FROM books
GROUP BY seccion
ORDER BY MIN(book_number);

-- Clasificar versículos por longitud
SELECT
    CASE
        WHEN LENGTH(text) < 50  THEN 'Corto (< 50 chars)'
        WHEN LENGTH(text) < 100 THEN 'Medio (50-100 chars)'
        WHEN LENGTH(text) < 200 THEN 'Largo (100-200 chars)'
        ELSE                         'Muy largo (> 200 chars)'
    END AS categoria,
    COUNT(*) AS total
FROM verses
GROUP BY categoria
ORDER BY MIN(LENGTH(text));


-- =============================================================================
-- COALESCE: devuelve el primer valor no NULL
-- =============================================================================

-- Mostrar el color del libro o 'Sin color' si es NULL
SELECT long_name, COALESCE(book_color, 'Sin color') AS color
FROM books
ORDER BY book_number
LIMIT 10;

-- COALESCE con múltiples opciones
SELECT long_name,
    COALESCE(book_color, short_name, 'Desconocido') AS valor_alternativo
FROM books
LIMIT 5;


-- =============================================================================
-- NULLIF: convierte un valor a NULL si cumple una condición
-- =============================================================================

-- Evitar división por cero
SELECT book_number,
    100.0 / NULLIF(chapter, 0) AS resultado_seguro
FROM verses
LIMIT 5;

-- Convertir cadena vacía a NULL
SELECT long_name,
    NULLIF(book_color, '') AS color_o_null
FROM books
LIMIT 5;
