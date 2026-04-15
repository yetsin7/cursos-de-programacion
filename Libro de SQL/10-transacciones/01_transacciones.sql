-- =============================================================================
-- Capítulo 10 — Transacciones: BEGIN, COMMIT, ROLLBACK
-- Archivo: 01_transacciones.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
-- =============================================================================

.headers on
.mode column


-- =============================================================================
-- SIN TRANSACCIÓN: cada operación es atómica por sí misma
-- =============================================================================

-- Ver estado inicial
SELECT COUNT(*) AS libros_antes FROM books WHERE book_number >= 800;


-- =============================================================================
-- TRANSACCIÓN EXITOSA: BEGIN + COMMIT
-- =============================================================================

BEGIN;

-- Insertar un libro de prueba
INSERT INTO books (book_number, short_name, long_name, book_color)
VALUES (800, 'Tx', 'Libro Transacción', '#FF6B6B');

-- Insertar versículos para ese libro
INSERT INTO verses (book_number, chapter, verse, text) VALUES
    (800, 1, 1, 'Primer versículo de la transacción.'),
    (800, 1, 2, 'Segundo versículo de la transacción.'),
    (800, 2, 1, 'Versículo del capítulo 2.');

-- Confirmar todos los cambios
COMMIT;

-- Verificar que se guardaron
SELECT * FROM books WHERE book_number = 800;
SELECT * FROM verses WHERE book_number = 800;


-- =============================================================================
-- TRANSACCIÓN REVERTIDA: BEGIN + ROLLBACK
-- =============================================================================

BEGIN;

-- Esta operación se hará...
INSERT INTO books (book_number, short_name, long_name)
VALUES (801, 'Ry', 'Libro que será Revertido');

-- Verificar que está temporalmente en la BD (dentro de la transacción)
SELECT long_name FROM books WHERE book_number = 801;

-- Revertir — todo vuelve al estado anterior
ROLLBACK;

-- Verificar que desapareció
SELECT COUNT(*) AS debe_ser_cero FROM books WHERE book_number = 801;


-- =============================================================================
-- CASO PRÁCTICO: insertar o revertir si hay error
-- La BD de SQLite no tiene TRY/CATCH nativo, pero podemos ver el patrón
-- que usarían los lenguajes al envolver esto en código Python/JS
-- =============================================================================

-- Simulación: insertar múltiples versículos como una unidad
BEGIN;

INSERT INTO verses (book_number, chapter, verse, text) VALUES (800, 3, 1, 'Cap 3, v1.');
INSERT INTO verses (book_number, chapter, verse, text) VALUES (800, 3, 2, 'Cap 3, v2.');
INSERT INTO verses (book_number, chapter, verse, text) VALUES (800, 3, 3, 'Cap 3, v3.');

COMMIT;

-- Ver todos los versículos del libro 800
SELECT chapter, verse, text FROM verses WHERE book_number = 800 ORDER BY chapter, verse;


-- =============================================================================
-- LIMPIEZA
-- =============================================================================

BEGIN;
DELETE FROM verses WHERE book_number >= 800;
DELETE FROM books  WHERE book_number >= 800;
COMMIT;

-- Verificar limpieza
SELECT COUNT(*) AS libros_prueba    FROM books  WHERE book_number >= 800;
SELECT COUNT(*) AS versiculos_prueba FROM verses WHERE book_number >= 800;
