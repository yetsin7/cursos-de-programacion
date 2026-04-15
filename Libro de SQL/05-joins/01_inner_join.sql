-- =============================================================================
-- Capítulo 05 — INNER JOIN
-- Archivo: 01_inner_join.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
-- =============================================================================

.headers on
.mode column


-- -----------------------------------------------------------------------------
-- INNER JOIN básico: unir books con verses
-- -----------------------------------------------------------------------------

-- Mostrar nombre del libro junto a sus versículos (primer capítulo de Génesis)
SELECT b.long_name AS libro, v.chapter, v.verse, v.text
FROM verses v
INNER JOIN books b ON b.book_number = v.book_number
WHERE b.long_name = 'Génesis' AND v.chapter = 1
ORDER BY v.verse;

-- Juan 3:16 con nombre del libro
SELECT b.long_name, v.chapter, v.verse, v.text
FROM verses v
INNER JOIN books b ON b.book_number = v.book_number
WHERE b.long_name = 'Juan' AND v.chapter = 3 AND v.verse = 16;

-- Salmo 23 completo con nombre del libro
SELECT b.long_name, v.chapter, v.verse, v.text
FROM verses v
INNER JOIN books b ON b.book_number = v.book_number
WHERE b.long_name = 'Salmos' AND v.chapter = 23
ORDER BY v.verse;


-- -----------------------------------------------------------------------------
-- INNER JOIN con GROUP BY: estadísticas por libro
-- -----------------------------------------------------------------------------

-- Versículos por libro (con nombre)
SELECT b.long_name AS libro, COUNT(*) AS total_versiculos
FROM verses v
INNER JOIN books b ON b.book_number = v.book_number
GROUP BY b.book_number
ORDER BY total_versiculos DESC;

-- Capítulos por libro (con nombre)
SELECT b.long_name AS libro, COUNT(DISTINCT v.chapter) AS total_capitulos
FROM verses v
INNER JOIN books b ON b.book_number = v.book_number
GROUP BY b.book_number
ORDER BY b.book_number;


-- -----------------------------------------------------------------------------
-- INNER JOIN con búsqueda de texto
-- -----------------------------------------------------------------------------

-- Versículos que contienen "amor" con nombre del libro
SELECT b.long_name AS libro, v.chapter, v.verse, v.text
FROM verses v
INNER JOIN books b ON b.book_number = v.book_number
WHERE v.text LIKE '%amor%'
ORDER BY b.book_number, v.chapter, v.verse
LIMIT 15;

-- ¿En qué libro aparece más veces la palabra "amor"?
SELECT b.long_name AS libro, COUNT(*) AS apariciones
FROM verses v
INNER JOIN books b ON b.book_number = v.book_number
WHERE v.text LIKE '%amor%'
GROUP BY b.book_number
ORDER BY apariciones DESC
LIMIT 5;
