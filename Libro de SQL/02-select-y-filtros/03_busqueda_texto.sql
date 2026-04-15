-- =============================================================================
-- Capítulo 02 — Búsqueda de texto con LIKE
-- Archivo: 03_busqueda_texto.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
-- =============================================================================

.headers on
.mode column


-- -----------------------------------------------------------------------------
-- LIKE: búsqueda de texto con comodines
-- % = cero o más caracteres
-- _ = exactamente un carácter
-- -----------------------------------------------------------------------------

-- Libros que empiezan con "S"
SELECT long_name FROM books WHERE long_name LIKE 'S%';

-- Libros que terminan con "s"
SELECT long_name FROM books WHERE long_name LIKE '%s';

-- Libros que contienen la letra "a" en cualquier parte
SELECT long_name FROM books WHERE long_name LIKE '%a%';

-- Libros cuyo nombre tiene exactamente 4 caracteres
SELECT long_name FROM books WHERE long_name LIKE '____';

-- Libros que empiezan con "1" o "2" (epístolas numeradas)
SELECT long_name FROM books WHERE long_name LIKE '1%' OR long_name LIKE '2%';


-- -----------------------------------------------------------------------------
-- LIKE en versículos: buscar palabras en el texto
-- Nota: el texto puede incluir marcas <S>NNNN</S> de números Strong
-- -----------------------------------------------------------------------------

-- Versículos que contienen la palabra "amor"
SELECT b.long_name, v.chapter, v.verse, v.text
FROM verses v
JOIN books b ON b.book_number = v.book_number
WHERE v.text LIKE '%amor%'
LIMIT 10;

-- Versículos que contienen "luz" (solo texto, con JOIN)
SELECT b.long_name, v.chapter, v.verse, v.text
FROM verses v
JOIN books b ON b.book_number = v.book_number
WHERE v.text LIKE '%luz%'
LIMIT 10;

-- Contar cuántos versículos contienen "amor"
SELECT COUNT(*) AS versiculos_con_amor
FROM verses
WHERE text LIKE '%amor%';

-- Contar cuántos versículos contienen "fe"
SELECT COUNT(*) AS versiculos_con_fe
FROM verses
WHERE text LIKE '%fe%';

-- Comparar presencia de varias palabras clave
SELECT
    'amor'  AS palabra, COUNT(*) AS total FROM verses WHERE text LIKE '%amor%'
UNION ALL
SELECT 'fe',    COUNT(*) FROM verses WHERE text LIKE '%fe%'
UNION ALL
SELECT 'gracia', COUNT(*) FROM verses WHERE text LIKE '%gracia%'
UNION ALL
SELECT 'paz',   COUNT(*) FROM verses WHERE text LIKE '%paz%'
UNION ALL
SELECT 'vida',  COUNT(*) FROM verses WHERE text LIKE '%vida%';
