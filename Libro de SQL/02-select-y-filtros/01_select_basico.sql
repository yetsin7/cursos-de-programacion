-- =============================================================================
-- Capítulo 02 — SELECT y Filtros con WHERE
-- Archivo: 01_select_basico.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
-- =============================================================================

.headers on
.mode column


-- -----------------------------------------------------------------------------
-- SELECT: elegir qué columnas mostrar
-- -----------------------------------------------------------------------------

-- Todas las columnas con *
SELECT * FROM books;

-- Solo las columnas que necesitamos
SELECT long_name, short_name FROM books;

-- Con alias: renombrar columnas en el resultado
SELECT long_name AS nombre, short_name AS abreviatura FROM books;

-- Columna calculada: texto literal concatenado
SELECT long_name || ' (' || short_name || ')' AS libro_completo FROM books;


-- -----------------------------------------------------------------------------
-- DISTINCT: eliminar duplicados
-- -----------------------------------------------------------------------------

-- ¿Qué valores únicos de chapter existen para el libro de Juan (430)?
SELECT DISTINCT chapter FROM verses WHERE book_number = 430 ORDER BY chapter;

-- ¿Cuántos capítulos tiene Juan?
SELECT COUNT(DISTINCT chapter) AS total_capitulos
FROM verses
WHERE book_number = 430;


-- -----------------------------------------------------------------------------
-- WHERE: filtrar resultados
-- -----------------------------------------------------------------------------

-- Buscar el libro de Juan por nombre
SELECT * FROM books WHERE long_name = 'Juan';

-- Todos los libros del Nuevo Testamento (book_number >= 400)
SELECT long_name, short_name FROM books WHERE book_number >= 400;

-- El versículo más famoso: Juan 3:16
SELECT text
FROM verses
WHERE book_number = 430 AND chapter = 3 AND verse = 16;

-- Todos los versículos del primer capítulo de Génesis
SELECT verse, text
FROM verses
WHERE book_number = 10 AND chapter = 1
ORDER BY verse;
