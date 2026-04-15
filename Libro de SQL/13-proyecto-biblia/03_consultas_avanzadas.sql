-- =============================================================================
-- Proyecto Final — 03: Consultas avanzadas con CTEs y subconsultas
-- Archivo: 03_consultas_avanzadas.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
-- =============================================================================

.headers on
.mode column


-- =============================================================================
-- CTEs PARA ANÁLISIS PROFUNDO
-- =============================================================================

-- Ranking de libros por versículos, separado por testamento
WITH stats AS (
    SELECT
        b.long_name AS libro,
        b.book_number,
        COUNT(*) AS versiculos,
        CASE WHEN b.book_number < 400 THEN 'Antiguo' ELSE 'Nuevo' END AS testamento
    FROM verses v JOIN books b ON b.book_number = v.book_number
    GROUP BY b.book_number
),
ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY testamento ORDER BY versiculos DESC) AS rank
    FROM stats
)
SELECT testamento, rank, libro, versiculos
FROM ranked
WHERE rank <= 5
ORDER BY testamento DESC, rank;


-- Los 10 capítulos más largos de toda la Biblia
WITH caps AS (
    SELECT
        b.long_name AS libro,
        v.chapter   AS capitulo,
        COUNT(*)    AS versiculos,
        SUM(LENGTH(v.text)) AS total_chars
    FROM verses v JOIN books b ON b.book_number = v.book_number
    GROUP BY b.book_number, v.chapter
)
SELECT libro, capitulo, versiculos, total_chars
FROM caps
ORDER BY versiculos DESC
LIMIT 10;


-- Libros cuya primera palabra del primer versículo comienza con "E"
WITH primeros AS (
    SELECT b.long_name AS libro,
           SUBSTR(v.text, 1, 50) AS inicio
    FROM verses v JOIN books b ON b.book_number = v.book_number
    WHERE v.chapter = 1 AND v.verse = 1
)
SELECT libro, inicio
FROM primeros
WHERE inicio LIKE 'E%' OR inicio LIKE 'En %';


-- =============================================================================
-- SUBCONSULTAS AVANZADAS
-- =============================================================================

-- Libros con más versículos que Salmos (el libro más largo)
SELECT b.long_name AS libro, COUNT(*) AS versiculos
FROM verses v JOIN books b ON b.book_number = v.book_number
GROUP BY b.book_number
HAVING versiculos >= (
    SELECT COUNT(*) FROM verses
    WHERE book_number = (
        SELECT book_number FROM books WHERE long_name = 'Salmos'
    )
);

-- Capítulos donde todos los versículos son cortos (< 80 chars promedio)
SELECT b.long_name AS libro, v.chapter, COUNT(*) AS versiculos,
       ROUND(AVG(LENGTH(v.text)), 1) AS long_promedio
FROM verses v JOIN books b ON b.book_number = v.book_number
GROUP BY v.book_number, v.chapter
HAVING long_promedio < 80
ORDER BY long_promedio ASC
LIMIT 10;


-- =============================================================================
-- CREAR VISTAS ÚTILES PARA EL PROYECTO
-- =============================================================================

CREATE VIEW IF NOT EXISTS biblia_completa AS
SELECT
    b.long_name  AS libro,
    b.short_name AS abrev,
    b.book_number,
    v.chapter    AS capitulo,
    v.verse      AS versiculo,
    v.text       AS texto,
    CASE WHEN b.book_number < 400 THEN 'AT' ELSE 'NT' END AS testamento
FROM verses v
JOIN books b ON b.book_number = v.book_number;

-- Usar la vista para consultas simples
SELECT * FROM biblia_completa
WHERE libro = 'Juan' AND capitulo = 1
ORDER BY versiculo
LIMIT 5;

-- Contar por testamento usando la vista
SELECT testamento, COUNT(*) AS versiculos
FROM biblia_completa
GROUP BY testamento;

-- Limpiar la vista al finalizar
DROP VIEW IF EXISTS biblia_completa;
