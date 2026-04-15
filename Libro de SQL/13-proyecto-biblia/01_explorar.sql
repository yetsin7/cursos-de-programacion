-- =============================================================================
-- Proyecto Final — 01: Explorar la base de datos
-- Archivo: 01_explorar.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
-- =============================================================================

.headers on
.mode column


-- =============================================================================
-- PASO 1: ¿Qué hay en esta base de datos?
-- =============================================================================

-- Ver todas las tablas
SELECT name AS tabla FROM sqlite_master WHERE type = 'table' ORDER BY name;

-- Ver los índices existentes
SELECT name AS indice, tbl_name AS tabla FROM sqlite_master WHERE type = 'index';

-- Ver la estructura de cada tabla
PRAGMA table_info(books);
PRAGMA table_info(verses);
PRAGMA table_info(info);


-- =============================================================================
-- PASO 2: ¿Cuántos datos hay?
-- =============================================================================

SELECT
    (SELECT COUNT(*) FROM books)  AS total_libros,
    (SELECT COUNT(*) FROM verses) AS total_versiculos,
    (SELECT COUNT(DISTINCT book_number || '-' || chapter) FROM verses) AS total_capitulos;


-- =============================================================================
-- PASO 3: Ver los metadatos de la versión
-- =============================================================================

SELECT * FROM info;


-- =============================================================================
-- PASO 4: Explorar la tabla books
-- =============================================================================

-- Todos los libros
SELECT book_number, short_name, long_name, book_color FROM books ORDER BY book_number;

-- ¿Cuántos libros tienen color definido?
SELECT
    COUNT(*) AS total_libros,
    COUNT(book_color) AS con_color,
    COUNT(*) - COUNT(book_color) AS sin_color
FROM books;


-- =============================================================================
-- PASO 5: Explorar la tabla verses
-- =============================================================================

-- Primeros 5 versículos
SELECT book_number, chapter, verse, text FROM verses LIMIT 5;

-- Últimos 5 versículos
SELECT book_number, chapter, verse, text FROM verses ORDER BY rowid DESC LIMIT 5;

-- ¿Cuántos versículos tiene cada libro?
SELECT b.long_name AS libro, COUNT(*) AS versiculos
FROM verses v JOIN books b ON b.book_number = v.book_number
GROUP BY b.book_number
ORDER BY b.book_number;

-- ¿Cuántos versículos tienen marcas Strong?
SELECT
    COUNT(CASE WHEN text LIKE '%<S>%' THEN 1 END) AS con_strong,
    COUNT(CASE WHEN text NOT LIKE '%<S>%' THEN 1 END) AS sin_strong,
    COUNT(*) AS total
FROM verses;
