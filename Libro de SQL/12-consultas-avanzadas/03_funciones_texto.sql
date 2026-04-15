-- =============================================================================
-- Capítulo 12 — Funciones de texto
-- Archivo: 03_funciones_texto.sql
-- Base de datos: ../../datos/biblia_rv60.sqlite3
-- =============================================================================

.headers on
.mode column


-- =============================================================================
-- FUNCIONES BÁSICAS DE TEXTO
-- =============================================================================

-- LENGTH: longitud de cadena
SELECT long_name, LENGTH(long_name) AS caracteres
FROM books
ORDER BY caracteres DESC
LIMIT 5;

-- UPPER y LOWER: cambiar capitalización
SELECT UPPER(long_name) AS mayusculas, LOWER(long_name) AS minusculas
FROM books
LIMIT 5;

-- SUBSTR: extraer parte de un texto
SELECT long_name, SUBSTR(long_name, 1, 3) AS primeras_3_letras
FROM books
LIMIT 10;

-- TRIM: eliminar espacios
SELECT TRIM('   Juan   ') AS limpio;

-- INSTR: encontrar posición de una subcadena
SELECT long_name, INSTR(long_name, 'a') AS posicion_de_a
FROM books
WHERE INSTR(long_name, 'a') > 0
LIMIT 5;

-- Concatenar con ||
SELECT long_name || ' (' || short_name || ')' AS libro_completo
FROM books
LIMIT 5;


-- =============================================================================
-- REPLACE: reemplazar texto
-- Útil para limpiar las marcas Strong <S>NNNN</S> del texto bíblico
-- =============================================================================

-- Ver un versículo que tiene marcas Strong (si las hay)
SELECT text
FROM verses
WHERE text LIKE '%<S>%'
LIMIT 3;

-- REPLACE puede eliminar patrones simples pero no regex
-- Para limpiar <S>1234</S>, en SQLite puro necesitamos múltiples REPLACE
-- (ver nota al pie — Python/JS lo hacen mejor con regex)

-- Contar versículos con marcas Strong
SELECT COUNT(*) AS versiculos_con_strong
FROM verses
WHERE text LIKE '%<S>%';

-- Ver el porcentaje que tiene marcas Strong
SELECT
    ROUND(100.0 * COUNT(CASE WHEN text LIKE '%<S>%' THEN 1 END) / COUNT(*), 1)
    AS porcentaje_con_strong
FROM verses;


-- =============================================================================
-- CONSULTAS CREATIVAS CON TEXTO
-- =============================================================================

-- Primer y último versículo de cada libro (concatenado)
SELECT
    b.long_name AS libro,
    (SELECT SUBSTR(text, 1, 60) FROM verses
     WHERE book_number = b.book_number AND chapter = 1 AND verse = 1) AS primer_versiculo
FROM books b
ORDER BY b.book_number
LIMIT 10;

-- Libros cuyo nombre contiene una vocal doble
SELECT long_name
FROM books
WHERE long_name LIKE '%aa%'
   OR long_name LIKE '%ee%'
   OR long_name LIKE '%ii%'
   OR long_name LIKE '%oo%'
   OR long_name LIKE '%uu%';

-- Los 10 versículos más cortos (excluyendo vacíos)
SELECT b.long_name AS libro, v.chapter, v.verse, v.text, LENGTH(v.text) AS chars
FROM verses v
JOIN books b ON b.book_number = v.book_number
WHERE LENGTH(v.text) > 0
ORDER BY chars ASC
LIMIT 10;

-- Nota sobre marcas Strong:
-- Para limpiar correctamente el texto en consultas SQL, considera usar
-- las funciones del lenguaje cliente (Python re.sub, JS replace con regex).
-- Ejemplo en Python:
--   import re
--   limpio = re.sub(r'<S>\d+</S>', '', texto).strip()
