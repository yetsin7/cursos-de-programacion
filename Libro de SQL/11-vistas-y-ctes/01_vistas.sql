-- =============================================================================
-- Capítulo 11 — Vistas (VIEW)
-- Archivo: 01_vistas.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
-- =============================================================================

.headers on
.mode column


-- =============================================================================
-- CREAR VISTAS
-- =============================================================================

-- Vista: versículos con nombre del libro incluido
CREATE VIEW IF NOT EXISTS vista_versiculos AS
SELECT
    b.long_name  AS libro,
    b.short_name AS abrev,
    v.chapter    AS capitulo,
    v.verse      AS versiculo,
    v.text       AS texto
FROM verses v
JOIN books b ON b.book_number = v.book_number;

-- Vista: estadísticas por libro
CREATE VIEW IF NOT EXISTS vista_estadisticas_libro AS
SELECT
    b.long_name                     AS libro,
    b.short_name                    AS abrev,
    b.book_number,
    COUNT(DISTINCT v.chapter)       AS capitulos,
    COUNT(v.verse)                  AS versiculos,
    ROUND(AVG(LENGTH(v.text)), 1)   AS longitud_promedio
FROM books b
LEFT JOIN verses v ON v.book_number = b.book_number
GROUP BY b.book_number;

-- Ver las vistas creadas
SELECT name FROM sqlite_master WHERE type = 'view';


-- =============================================================================
-- USAR LAS VISTAS
-- =============================================================================

-- Usar vista_versiculos como si fuera una tabla normal
SELECT * FROM vista_versiculos WHERE libro = 'Juan' AND capitulo = 3 LIMIT 5;

-- Buscar texto sin necesidad de hacer JOIN manualmente
SELECT libro, capitulo, versiculo, texto
FROM vista_versiculos
WHERE texto LIKE '%amor%'
LIMIT 10;

-- Contar por libro usando la vista
SELECT libro, COUNT(*) AS apariciones
FROM vista_versiculos
WHERE texto LIKE '%amor%'
GROUP BY libro
ORDER BY apariciones DESC
LIMIT 5;

-- Usar vista de estadísticas
SELECT libro, capitulos, versiculos, longitud_promedio
FROM vista_estadisticas_libro
ORDER BY versiculos DESC
LIMIT 10;

-- Ver libros con más de 50 capítulos
SELECT libro, capitulos, versiculos
FROM vista_estadisticas_libro
WHERE capitulos > 50
ORDER BY capitulos DESC;


-- =============================================================================
-- ELIMINAR VISTAS (limpieza)
-- =============================================================================

DROP VIEW IF EXISTS vista_versiculos;
DROP VIEW IF EXISTS vista_estadisticas_libro;

-- Verificar que se eliminaron
SELECT name FROM sqlite_master WHERE type = 'view';
