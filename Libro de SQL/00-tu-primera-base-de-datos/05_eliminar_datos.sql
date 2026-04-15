-- =============================================================================
-- Capítulo 00 — DELETE: eliminar contactos y notas
-- Archivo: 05_eliminar_datos.sql
-- Base de datos: mi_base_de_datos.db
-- =============================================================================

.headers on
.mode column

PRAGMA foreign_keys = ON;


-- =============================================================================
-- Ver estado actual
-- =============================================================================

SELECT id, nombre, ciudad FROM personas;
SELECT '--- Notas ---' AS sep;
SELECT id, persona_id, contenido FROM notas;


-- =============================================================================
-- DELETE básico: eliminar un registro por id
-- =============================================================================

-- Eliminar la persona con id = 8 (Roberto Díaz)
DELETE FROM personas WHERE id = 8;

-- Verificar que se eliminó
SELECT id, nombre FROM personas;


-- =============================================================================
-- DELETE en cascada: al eliminar una persona, sus notas también se borran
-- (Esto funciona porque pusimos ON DELETE CASCADE en la FK de notas)
-- =============================================================================

-- Ver notas de Ana (id = 1) antes de borrarla
SELECT * FROM notas WHERE persona_id = 1;

-- Eliminar a Ana
DELETE FROM personas WHERE id = 1;

-- Verificar que sus notas también desaparecieron automáticamente
SELECT * FROM notas WHERE persona_id = 1;
SELECT 'Las notas de Ana se borraron automáticamente (CASCADE).' AS resultado;


-- =============================================================================
-- DELETE de notas específicas (sin borrar la persona)
-- =============================================================================

-- Eliminar solo una nota específica
DELETE FROM notas WHERE id = 3;

-- Verificar
SELECT id, persona_id, contenido FROM notas;


-- =============================================================================
-- DELETE con condición: borrar varios registros a la vez
-- =============================================================================

-- Eliminar todos los contactos de León
DELETE FROM personas WHERE ciudad = 'León';

-- Verificar
SELECT nombre, ciudad FROM personas ORDER BY ciudad;


-- =============================================================================
-- CUIDADO: DELETE sin WHERE borra TODO
-- =============================================================================

-- Esto borraría TODAS las notas:
-- DELETE FROM notas;

-- Esto borraría TODAS las personas (y sus notas por CASCADE):
-- DELETE FROM personas;

-- Si necesitas vaciar una tabla completamente, usa TRUNCATE en otros motores
-- o DELETE sin WHERE + VACUUM en SQLite.


-- =============================================================================
-- Estado final
-- =============================================================================

SELECT id, nombre, ciudad FROM personas ORDER BY nombre;
SELECT '--- Notas restantes ---' AS sep;
SELECT n.id, p.nombre, n.contenido FROM notas n JOIN personas p ON p.id = n.persona_id;
