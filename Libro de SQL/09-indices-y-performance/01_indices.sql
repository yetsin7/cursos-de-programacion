-- =============================================================================
-- Capítulo 09 — Índices y Performance
-- Archivo: 01_indices.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
-- =============================================================================

.headers on
.mode column


-- =============================================================================
-- VER EL PLAN DE EJECUCIÓN SIN ÍNDICE
-- =============================================================================

-- Consulta sin índice: SQLite hace SCAN (lee toda la tabla)
EXPLAIN QUERY PLAN
SELECT * FROM verses WHERE book_number = 430;

-- Consulta con condición compuesta
EXPLAIN QUERY PLAN
SELECT * FROM verses WHERE book_number = 430 AND chapter = 3 AND verse = 16;

-- Ver índices existentes en la base de datos
SELECT name, tbl_name, sql
FROM sqlite_master
WHERE type = 'index';


-- =============================================================================
-- CREAR ÍNDICES
-- =============================================================================

-- Índice simple: acelera búsquedas por book_number
CREATE INDEX IF NOT EXISTS idx_verses_book
ON verses (book_number);

-- Ver el plan de ejecución ahora (debería mostrar USING INDEX)
EXPLAIN QUERY PLAN
SELECT * FROM verses WHERE book_number = 430;

-- Índice compuesto: acelera búsquedas por libro + capítulo + versículo
CREATE INDEX IF NOT EXISTS idx_verses_location
ON verses (book_number, chapter, verse);

-- Ahora las búsquedas exactas son mucho más rápidas
EXPLAIN QUERY PLAN
SELECT * FROM verses WHERE book_number = 430 AND chapter = 3 AND verse = 16;

-- Índice para búsquedas frecuentes por nombre de libro
CREATE INDEX IF NOT EXISTS idx_books_long_name
ON books (long_name);

-- Ver todos los índices creados
SELECT name, tbl_name FROM sqlite_master WHERE type = 'index';


-- =============================================================================
-- DEMOSTRACIÓN DE IMPACTO
-- =============================================================================

-- Contar versículos por libro — con índice en book_number es más eficiente
SELECT book_number, COUNT(*) AS total
FROM verses
GROUP BY book_number
ORDER BY total DESC
LIMIT 5;

-- Búsqueda de texto con LIKE: los índices NO ayudan con LIKE '%palabra%'
-- porque el comodín al inicio previene el uso del índice
EXPLAIN QUERY PLAN
SELECT * FROM verses WHERE text LIKE '%amor%';
-- Verás SCAN aquí — es normal. Para búsqueda full-text, se usa FTS5.


-- =============================================================================
-- ELIMINAR ÍNDICES (limpieza)
-- =============================================================================

DROP INDEX IF EXISTS idx_verses_book;
DROP INDEX IF EXISTS idx_verses_location;
DROP INDEX IF EXISTS idx_books_long_name;

-- Verificar que se eliminaron
SELECT name FROM sqlite_master WHERE type = 'index' AND name LIKE 'idx_%';
