-- =============================================================================
-- Proyecto Final — 04: Estadísticas completas de la Biblia
-- Archivo: 04_estadisticas.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
-- =============================================================================

.headers on
.mode column


-- =============================================================================
-- RESUMEN GENERAL
-- =============================================================================

SELECT '=== RESUMEN DE LA BIBLIA RV60 ===' AS titulo;

SELECT
    (SELECT COUNT(*)                FROM books)  AS libros,
    (SELECT COUNT(DISTINCT book_number || '-' || chapter) FROM verses) AS capitulos,
    (SELECT COUNT(*)                FROM verses) AS versiculos,
    (SELECT SUM(LENGTH(text))       FROM verses) AS caracteres_totales,
    (SELECT ROUND(AVG(LENGTH(text)),1) FROM verses) AS longitud_promedio_versiculo;


-- =============================================================================
-- DISTRIBUCIÓN: AT vs NT
-- =============================================================================

SELECT '=== ANTIGUO vs NUEVO TESTAMENTO ===' AS titulo;

SELECT
    CASE WHEN book_number < 400 THEN 'Antiguo Testamento' ELSE 'Nuevo Testamento' END AS testamento,
    COUNT(DISTINCT book_number) AS libros,
    COUNT(DISTINCT book_number || '-' || chapter) AS capitulos,
    COUNT(*) AS versiculos,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM verses), 1) AS porcentaje
FROM verses
GROUP BY testamento;


-- =============================================================================
-- TOP 10: LIBROS MÁS LARGOS Y MÁS CORTOS
-- =============================================================================

SELECT '=== TOP 5 LIBROS MÁS LARGOS ===' AS titulo;

SELECT b.long_name AS libro,
       COUNT(DISTINCT v.chapter) AS capitulos,
       COUNT(*) AS versiculos
FROM verses v JOIN books b ON b.book_number = v.book_number
GROUP BY b.book_number ORDER BY versiculos DESC LIMIT 5;

SELECT '=== TOP 5 LIBROS MÁS CORTOS ===' AS titulo;

SELECT b.long_name AS libro,
       COUNT(DISTINCT v.chapter) AS capitulos,
       COUNT(*) AS versiculos
FROM verses v JOIN books b ON b.book_number = v.book_number
GROUP BY b.book_number ORDER BY versiculos ASC LIMIT 5;


-- =============================================================================
-- RÉCORDS: CAPÍTULOS Y VERSÍCULOS
-- =============================================================================

SELECT '=== CAPÍTULO CON MÁS VERSÍCULOS ===' AS titulo;

SELECT b.long_name AS libro, v.chapter AS capitulo, COUNT(*) AS versiculos
FROM verses v JOIN books b ON b.book_number = v.book_number
GROUP BY b.book_number, v.chapter
ORDER BY versiculos DESC LIMIT 1;

SELECT '=== CAPÍTULO CON MENOS VERSÍCULOS ===' AS titulo;

SELECT b.long_name AS libro, v.chapter AS capitulo, COUNT(*) AS versiculos
FROM verses v JOIN books b ON b.book_number = v.book_number
GROUP BY b.book_number, v.chapter
ORDER BY versiculos ASC LIMIT 1;

SELECT '=== VERSÍCULO MÁS LARGO ===' AS titulo;

SELECT b.long_name AS libro, v.chapter, v.verse, LENGTH(v.text) AS chars,
       SUBSTR(v.text, 1, 100) AS inicio
FROM verses v JOIN books b ON b.book_number = v.book_number
ORDER BY LENGTH(v.text) DESC LIMIT 1;

SELECT '=== VERSÍCULO MÁS CORTO ===' AS titulo;

SELECT b.long_name AS libro, v.chapter, v.verse, LENGTH(v.text) AS chars, v.text
FROM verses v JOIN books b ON b.book_number = v.book_number
WHERE LENGTH(v.text) > 0
ORDER BY LENGTH(v.text) ASC LIMIT 1;


-- =============================================================================
-- ANÁLISIS DE PALABRAS CLAVE
-- =============================================================================

SELECT '=== PALABRAS CLAVE: APARICIONES EN LA BIBLIA ===' AS titulo;

SELECT palabra, apariciones
FROM (
    SELECT 'amor'     AS palabra, COUNT(*) AS apariciones FROM verses WHERE text LIKE '%amor%'    UNION ALL
    SELECT 'fe',                  COUNT(*) FROM verses WHERE text LIKE '%fe%'                      UNION ALL
    SELECT 'gracia',              COUNT(*) FROM verses WHERE text LIKE '%gracia%'                  UNION ALL
    SELECT 'paz',                 COUNT(*) FROM verses WHERE text LIKE '%paz%'                     UNION ALL
    SELECT 'vida',                COUNT(*) FROM verses WHERE text LIKE '%vida%'                    UNION ALL
    SELECT 'muerte',              COUNT(*) FROM verses WHERE text LIKE '%muerte%'                  UNION ALL
    SELECT 'Dios',                COUNT(*) FROM verses WHERE text LIKE '%Dios%'                    UNION ALL
    SELECT 'Jehová',              COUNT(*) FROM verses WHERE text LIKE '%Jehová%'                  UNION ALL
    SELECT 'salvación',           COUNT(*) FROM verses WHERE text LIKE '%salvación%'               UNION ALL
    SELECT 'pecado',              COUNT(*) FROM verses WHERE text LIKE '%pecado%'
)
ORDER BY apariciones DESC;


-- =============================================================================
-- DISTRIBUCIÓN POR SECCIÓN BÍBLICA
-- =============================================================================

SELECT '=== VERSÍCULOS POR SECCIÓN BÍBLICA ===' AS titulo;

SELECT
    CASE
        WHEN book_number BETWEEN 10  AND 50  THEN '1. Pentateuco'
        WHEN book_number BETWEEN 60  AND 170 THEN '2. Historia'
        WHEN book_number BETWEEN 180 AND 220 THEN '3. Poéticos'
        WHEN book_number BETWEEN 230 AND 390 THEN '4. Profetas'
        WHEN book_number BETWEEN 400 AND 450 THEN '5. Evangelios y Hechos'
        WHEN book_number BETWEEN 460 AND 640 THEN '6. Epístolas'
        ELSE '7. Apocalipsis'
    END AS seccion,
    COUNT(DISTINCT book_number) AS libros,
    COUNT(*) AS versiculos
FROM verses
GROUP BY seccion
ORDER BY seccion;
