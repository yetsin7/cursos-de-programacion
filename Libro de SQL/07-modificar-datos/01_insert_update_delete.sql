-- =============================================================================
-- Capítulo 07 — INSERT, UPDATE, DELETE
-- Archivo: 01_insert_update_delete.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
--
-- NOTA: Estos ejercicios modifican los datos. Se usan números de libro
-- fuera del rango real (700+) para no afectar los datos originales.
-- Al final se limpian los datos de prueba.
-- =============================================================================

.headers on
.mode column


-- =============================================================================
-- INSERT: insertar filas nuevas
-- =============================================================================

-- Insertar un libro de prueba
INSERT INTO books (book_number, short_name, long_name, book_color)
VALUES (700, 'Tp', 'Libro de Prueba', '#FF6B6B');

-- Verificar que se insertó
SELECT * FROM books WHERE book_number = 700;

-- Insertar múltiples filas a la vez
INSERT INTO books (book_number, short_name, long_name, book_color) VALUES
    (701, 'T1', 'Prueba Uno',  '#4ECDC4'),
    (702, 'T2', 'Prueba Dos',  '#45B7D1'),
    (703, 'T3', 'Prueba Tres', '#96CEB4');

-- Ver todos los libros de prueba
SELECT * FROM books WHERE book_number >= 700;

-- Insertar versículos de prueba para el libro 700
INSERT INTO verses (book_number, chapter, verse, text) VALUES
    (700, 1, 1, 'Este es el primer versículo de prueba.'),
    (700, 1, 2, 'Este es el segundo versículo de prueba.'),
    (700, 2, 1, 'Este es el primer versículo del capítulo 2.');

-- Ver los versículos insertados
SELECT * FROM verses WHERE book_number = 700;


-- =============================================================================
-- UPDATE: modificar filas existentes
-- =============================================================================

-- Cambiar el color del libro de prueba
UPDATE books SET book_color = '#FFFFFF' WHERE book_number = 700;

-- Verificar el cambio
SELECT * FROM books WHERE book_number = 700;

-- Actualizar múltiples columnas a la vez
UPDATE books
SET long_name = 'Libro de Prueba Actualizado', book_color = '#000000'
WHERE book_number = 700;

-- Verificar
SELECT long_name, book_color FROM books WHERE book_number = 700;

-- Actualizar texto de un versículo
UPDATE verses
SET text = 'Versículo actualizado correctamente.'
WHERE book_number = 700 AND chapter = 1 AND verse = 1;

-- Verificar
SELECT text FROM verses WHERE book_number = 700 AND chapter = 1 AND verse = 1;


-- =============================================================================
-- INSERT OR REPLACE (UPSERT): insertar o reemplazar si existe
-- =============================================================================

-- Intentar insertar un book_number que ya existe → lo reemplaza
INSERT OR REPLACE INTO books (book_number, short_name, long_name, book_color)
VALUES (700, 'Tp', 'Libro Reemplazado', '#FF0000');

SELECT * FROM books WHERE book_number = 700;

-- INSERT OR IGNORE: no hace nada si ya existe
INSERT OR IGNORE INTO books (book_number, short_name, long_name)
VALUES (700, 'Tp', 'Este texto no se guardará porque ya existe');

SELECT long_name FROM books WHERE book_number = 700;  -- sigue siendo el anterior


-- =============================================================================
-- DELETE: eliminar filas
-- =============================================================================

-- Eliminar un versículo específico
DELETE FROM verses WHERE book_number = 700 AND chapter = 2 AND verse = 1;

-- Verificar
SELECT COUNT(*) AS versiculos_restantes FROM verses WHERE book_number = 700;

-- Eliminar todos los versículos del libro de prueba
DELETE FROM verses WHERE book_number = 700;

-- Eliminar los libros de prueba
DELETE FROM books WHERE book_number >= 700;

-- Verificar que se eliminaron todos
SELECT COUNT(*) AS libros_prueba FROM books WHERE book_number >= 700;
SELECT COUNT(*) AS versiculos_prueba FROM verses WHERE book_number >= 700;
