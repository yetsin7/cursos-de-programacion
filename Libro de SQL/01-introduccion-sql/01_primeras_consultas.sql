-- =============================================================================
-- Capitulo 01 — Introduccion a SQL
-- Archivo: 01_primeras_consultas.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
--
-- Como ejecutar:
--   sqlite3 ../../datos/biblia_rv60.sqlite3 < 01_primeras_consultas.sql
--   O abre el archivo en DB Browser for SQLite
--
-- IDEA CLAVE:
-- SQL no "recorre texto a mano". SQL le pide al motor de base de datos que
-- busque, filtre y organice informacion almacenada en disco y memoria.
-- =============================================================================

-- Activar encabezados y formato legible en la consola de SQLite
.headers on
.mode column


-- -----------------------------------------------------------------------------
-- EXPLORAR LA ESTRUCTURA DE LA BASE DE DATOS
-- -----------------------------------------------------------------------------

-- Ver todas las tablas disponibles.
-- sqlite_master es una tabla interna que describe la estructura de la base.
SELECT name FROM sqlite_master WHERE type = 'table';

-- Ver la estructura de la tabla books.
SELECT sql FROM sqlite_master WHERE name = 'books';

-- Ver la estructura de la tabla verses.
SELECT sql FROM sqlite_master WHERE name = 'verses';

-- Ver metadatos generales de esta base de datos.
SELECT * FROM info;


-- -----------------------------------------------------------------------------
-- PRIMERAS CONSULTAS CON SELECT
-- -----------------------------------------------------------------------------

-- SELECT pide columnas concretas de una tabla.
-- El asterisco (*) significa "todas las columnas".
SELECT * FROM books;

-- Pedir solo las columnas necesarias hace la consulta mas clara.
SELECT long_name, short_name FROM books;

-- AS crea un alias temporal para que el resultado se lea mejor.
SELECT long_name AS libro FROM books;


-- -----------------------------------------------------------------------------
-- LIMITAR RESULTADOS CON LIMIT
-- -----------------------------------------------------------------------------

-- LIMIT recorta la cantidad de filas devueltas.
SELECT long_name FROM books LIMIT 5;

-- Esto ayuda a explorar una tabla grande sin cargar demasiados resultados.
SELECT book_number, chapter, verse, text FROM verses LIMIT 3;


-- -----------------------------------------------------------------------------
-- CONTAR REGISTROS
-- -----------------------------------------------------------------------------

-- COUNT(*) cuenta cuantas filas devolvio la consulta.
SELECT COUNT(*) AS total_libros FROM books;

-- Aqui contamos todos los registros de la tabla verses.
SELECT COUNT(*) AS total_versiculos FROM verses;


-- -----------------------------------------------------------------------------
-- EXPLORAR DATOS ÚNICOS CON DISTINCT
-- -----------------------------------------------------------------------------

-- DISTINCT elimina repetidos del resultado.
-- Aqui sirve para listar capitulos sin repetir numeros.
SELECT DISTINCT chapter FROM verses WHERE book_number = 10;

-- Podemos combinar COUNT con DISTINCT para contar valores unicos.
SELECT COUNT(DISTINCT chapter) AS capitulos_genesis
FROM verses
WHERE book_number = 10;

-- =============================================================================
-- QUE DEBERIAS ENTENDER AL TERMINAR
-- - Una base de datos no es magia: es informacion organizada.
-- - SELECT pide datos al motor.
-- - LIMIT ayuda a explorar sin saturarte.
-- - COUNT resume cantidades.
-- - DISTINCT evita duplicados.
--
-- PRACTICA GUIADA
-- 1. Cambia LIMIT 5 por LIMIT 10.
-- 2. Pide solo short_name desde books.
-- 3. Cuenta cuantos registros hay en info.
-- 4. Explica con tus palabras por que sqlite_master es util.
-- =============================================================================
