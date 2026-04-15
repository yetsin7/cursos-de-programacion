-- =============================================================================
-- Capítulo 02 — WHERE: Operadores de comparación y lógicos
-- Archivo: 02_where_operadores.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
-- =============================================================================

.headers on
.mode column


-- -----------------------------------------------------------------------------
-- OPERADORES DE COMPARACIÓN: =, !=, >, <, >=, <=
-- -----------------------------------------------------------------------------

-- Igual: solo el libro con book_number 10
SELECT long_name FROM books WHERE book_number = 10;

-- Distinto: todos menos el Génesis
SELECT long_name FROM books WHERE book_number != 10;

-- Mayor que: libros del NT (book_number de 400 en adelante)
SELECT long_name FROM books WHERE book_number >= 400;

-- Menor que: solo los primeros 5 libros del AT
SELECT long_name FROM books WHERE book_number <= 50;


-- -----------------------------------------------------------------------------
-- OPERADORES LÓGICOS: AND, OR, NOT
-- -----------------------------------------------------------------------------

-- AND: versículo específico (Génesis 1:1)
SELECT text
FROM verses
WHERE book_number = 10 AND chapter = 1 AND verse = 1;

-- OR: cualquiera de los libros evangelios sinópticos
SELECT long_name
FROM books
WHERE long_name = 'Mateo' OR long_name = 'Marcos' OR long_name = 'Lucas';

-- Más limpio con IN
SELECT long_name
FROM books
WHERE long_name IN ('Mateo', 'Marcos', 'Lucas');

-- NOT: todos los libros excepto el Salmo (190) y Proverbios (200)
SELECT long_name
FROM books
WHERE NOT book_number IN (190, 200);


-- -----------------------------------------------------------------------------
-- BETWEEN: rango de valores
-- -----------------------------------------------------------------------------

-- Libros del Nuevo Testamento (400 a 660)
SELECT long_name FROM books WHERE book_number BETWEEN 400 AND 660;

-- Versículos del capítulo 1 al 3 de Juan
SELECT chapter, verse, text
FROM verses
WHERE book_number = 430 AND chapter BETWEEN 1 AND 3
ORDER BY chapter, verse;


-- -----------------------------------------------------------------------------
-- IN: lista de valores exactos
-- -----------------------------------------------------------------------------

-- Libros específicos por número
SELECT long_name, short_name
FROM books
WHERE book_number IN (10, 190, 430, 660);

-- Primeros versículos de tres libros
SELECT book_number, chapter, verse, text
FROM verses
WHERE book_number IN (10, 430, 660) AND chapter = 1 AND verse = 1;
