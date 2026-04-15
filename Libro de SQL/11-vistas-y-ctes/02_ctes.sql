-- =============================================================================
-- Capítulo 11 — CTEs (Common Table Expressions) con WITH
-- Archivo: 02_ctes.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
-- =============================================================================

.headers on
.mode column


-- =============================================================================
-- CTE BÁSICA: WITH ... AS (...)
-- =============================================================================

-- CTE simple: versículos de Juan capítulo 3
WITH juan_cap3 AS (
    SELECT v.verse, v.text
    FROM verses v
    JOIN books b ON b.book_number = v.book_number
    WHERE b.long_name = 'Juan' AND v.chapter = 3
)
SELECT verse AS versiculo, text AS texto
FROM juan_cap3
ORDER BY verse;

-- CTE para calcular estadísticas por libro
WITH stats AS (
    SELECT
        book_number,
        COUNT(*) AS total_versiculos,
        COUNT(DISTINCT chapter) AS total_capitulos
    FROM verses
    GROUP BY book_number
)
SELECT b.long_name, s.total_capitulos, s.total_versiculos
FROM stats s
JOIN books b ON b.book_number = s.book_number
ORDER BY s.total_versiculos DESC
LIMIT 10;


-- =============================================================================
-- CTEs MÚLTIPLES: varias CTEs en la misma consulta
-- =============================================================================

-- Comparar AT vs NT: libros, capítulos y versículos
WITH
  at_stats AS (
      SELECT
          COUNT(DISTINCT book_number)          AS libros,
          COUNT(DISTINCT book_number || chapter) AS capitulos,
          COUNT(*)                             AS versiculos
      FROM verses WHERE book_number < 400
  ),
  nt_stats AS (
      SELECT
          COUNT(DISTINCT book_number)          AS libros,
          COUNT(DISTINCT book_number || chapter) AS capitulos,
          COUNT(*)                             AS versiculos
      FROM verses WHERE book_number >= 400
  )
SELECT 'Antiguo Testamento' AS testamento, libros, capitulos, versiculos FROM at_stats
UNION ALL
SELECT 'Nuevo Testamento',                 libros, capitulos, versiculos FROM nt_stats;


-- =============================================================================
-- CTE + WINDOW FUNCTION: ranking
-- =============================================================================

-- Top 5 libros con más versículos por testamento
WITH conteo AS (
    SELECT
        b.long_name,
        b.book_number,
        COUNT(*) AS total,
        CASE WHEN b.book_number < 400 THEN 'AT' ELSE 'NT' END AS testamento
    FROM verses v
    JOIN books b ON b.book_number = v.book_number
    GROUP BY b.book_number
),
ranking AS (
    SELECT
        long_name,
        testamento,
        total,
        ROW_NUMBER() OVER (PARTITION BY testamento ORDER BY total DESC) AS rank
    FROM conteo
)
SELECT testamento, rank, long_name AS libro, total AS versiculos
FROM ranking
WHERE rank <= 5
ORDER BY testamento, rank;


-- =============================================================================
-- CTE PARA LIMPIAR CÓDIGO COMPLEJO
-- =============================================================================

-- Sin CTE: buscar libros por encima del promedio (difícil de leer)
SELECT b.long_name, COUNT(*) AS total
FROM verses v JOIN books b ON b.book_number = v.book_number
GROUP BY b.book_number
HAVING total > (
    SELECT AVG(cnt) FROM (SELECT COUNT(*) AS cnt FROM verses GROUP BY book_number)
);

-- Con CTE: mismo resultado, mucho más legible
WITH promedio AS (
    SELECT AVG(total) AS valor
    FROM (SELECT COUNT(*) AS total FROM verses GROUP BY book_number)
),
por_libro AS (
    SELECT b.long_name, COUNT(*) AS total
    FROM verses v JOIN books b ON b.book_number = v.book_number
    GROUP BY b.book_number
)
SELECT pl.long_name, pl.total
FROM por_libro pl, promedio p
WHERE pl.total > p.valor
ORDER BY pl.total DESC;
