-- =============================================================================
-- Capítulo 01 — Introducción a SQL
-- Archivo: 01_primeras_consultas.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
--
-- Cómo ejecutar:
--   sqlite3 ../../datos/biblia_rv60.sqlite3 < 01_primeras_consultas.sql
--   O abre el archivo en DB Browser for SQLite
-- =============================================================================

-- Activar encabezados de columnas y formato de tabla
.headers on
.mode column


-- -----------------------------------------------------------------------------
-- EXPLORAR LA ESTRUCTURA DE LA BASE DE DATOS
-- -----------------------------------------------------------------------------

-- Ver todas las tablas disponibles
SELECT name FROM sqlite_master WHERE type = 'table';

-- Ver la definición de la tabla books (su estructura)
SELECT sql FROM sqlite_master WHERE name = 'books';

-- Ver la definición de la tabla verses
SELECT sql FROM sqlite_master WHERE name = 'verses';

-- Ver los metadatos de la base de datos
SELECT * FROM info;


-- -----------------------------------------------------------------------------
-- PRIMERAS CONSULTAS CON SELECT
-- -----------------------------------------------------------------------------

-- Seleccionar todas las columnas de todos los libros
SELECT * FROM books;

-- Seleccionar solo las columnas que nos interesan
SELECT long_name, short_name FROM books;

-- Seleccionar solo el nombre largo con un alias más legible
SELECT long_name AS libro FROM books;


-- -----------------------------------------------------------------------------
-- LIMITAR RESULTADOS CON LIMIT
-- -----------------------------------------------------------------------------

-- Ver solo los primeros 5 libros
SELECT long_name FROM books LIMIT 5;

-- Ver los primeros 3 versículos de toda la tabla
SELECT book_number, chapter, verse, text FROM verses LIMIT 3;


-- -----------------------------------------------------------------------------
-- CONTAR REGISTROS
-- -----------------------------------------------------------------------------

-- ¿Cuántos libros hay?
SELECT COUNT(*) AS total_libros FROM books;

-- ¿Cuántos versículos hay en total?
SELECT COUNT(*) AS total_versiculos FROM verses;


-- -----------------------------------------------------------------------------
-- EXPLORAR DATOS ÚNICOS CON DISTINCT
-- -----------------------------------------------------------------------------

-- ¿Cuántos capítulos tiene el Génesis? (book_number = 10)
SELECT DISTINCT chapter FROM verses WHERE book_number = 10;

-- Contar los capítulos únicos del Génesis
SELECT COUNT(DISTINCT chapter) AS capitulos_genesis
FROM verses
WHERE book_number = 10;
