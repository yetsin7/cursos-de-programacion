-- =============================================================================
-- Proyecto Final — 02: Consultas básicas (leer la Biblia con SQL)
-- Archivo: 02_consultas_basicas.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
-- =============================================================================

.headers on
.mode column


-- =============================================================================
-- LEER VERSÍCULOS ESPECÍFICOS
-- =============================================================================

-- Génesis 1:1
SELECT b.long_name, v.chapter, v.verse, v.text
FROM verses v JOIN books b ON b.book_number = v.book_number
WHERE b.long_name = 'Génesis' AND v.chapter = 1 AND v.verse = 1;

-- Juan 3:16 (el versículo más conocido)
SELECT b.long_name, v.chapter, v.verse, v.text
FROM verses v JOIN books b ON b.book_number = v.book_number
WHERE b.long_name = 'Juan' AND v.chapter = 3 AND v.verse = 16;

-- Salmo 23 completo
SELECT v.verse AS versiculo, v.text AS texto
FROM verses v JOIN books b ON b.book_number = v.book_number
WHERE b.long_name = 'Salmos' AND v.chapter = 23
ORDER BY v.verse;

-- Primer y último versículo de la Biblia
SELECT 'Primer versículo' AS posicion, b.long_name, v.chapter, v.verse, v.text
FROM verses v JOIN books b ON b.book_number = v.book_number
WHERE v.book_number = (SELECT MIN(book_number) FROM books)
  AND v.chapter = 1 AND v.verse = 1
UNION ALL
SELECT 'Último versículo', b.long_name, v.chapter, v.verse, v.text
FROM verses v JOIN books b ON b.book_number = v.book_number
WHERE v.book_number = (SELECT MAX(book_number) FROM books)
  AND v.chapter = (SELECT MAX(chapter) FROM verses WHERE book_number = 660)
  AND v.verse   = (SELECT MAX(verse)   FROM verses WHERE book_number = 660
                   AND chapter = (SELECT MAX(chapter) FROM verses WHERE book_number = 660));


-- =============================================================================
-- LEER CAPÍTULOS COMPLETOS
-- =============================================================================

-- Génesis capítulo 1
SELECT v.verse AS v, v.text AS texto
FROM verses v
WHERE v.book_number = 10 AND v.chapter = 1
ORDER BY v.verse;

-- Juan capítulo 1 (los primeros 14 versículos — el prólogo)
SELECT v.verse AS v, v.text AS texto
FROM verses v
WHERE v.book_number = 430 AND v.chapter = 1
ORDER BY v.verse
LIMIT 14;


-- =============================================================================
-- BUSCAR VERSÍCULOS POR TEXTO
-- =============================================================================

-- Buscar "amor" con nombre del libro
SELECT b.long_name AS libro, v.chapter AS cap, v.verse AS ver, v.text AS texto
FROM verses v JOIN books b ON b.book_number = v.book_number
WHERE v.text LIKE '%amor%'
ORDER BY b.book_number, v.chapter, v.verse
LIMIT 20;

-- Buscar "Jehová es mi pastor"
SELECT b.long_name, v.chapter, v.verse, v.text
FROM verses v JOIN books b ON b.book_number = v.book_number
WHERE v.text LIKE '%Jehová es mi pastor%';

-- Buscar referencias a "luz del mundo"
SELECT b.long_name, v.chapter, v.verse, v.text
FROM verses v JOIN books b ON b.book_number = v.book_number
WHERE v.text LIKE '%luz del mundo%';


-- =============================================================================
-- NAVEGAR POR LIBROS
-- =============================================================================

-- ¿Cuántos capítulos tiene cada libro del Nuevo Testamento?
SELECT b.long_name AS libro, COUNT(DISTINCT v.chapter) AS capitulos
FROM verses v JOIN books b ON b.book_number = v.book_number
WHERE b.book_number >= 400
GROUP BY b.book_number
ORDER BY b.book_number;

-- Versículos del primer capítulo de cada libro (solo el primero)
SELECT b.long_name AS libro, v.text AS primer_versiculo
FROM verses v JOIN books b ON b.book_number = v.book_number
WHERE v.chapter = 1 AND v.verse = 1
ORDER BY b.book_number;
