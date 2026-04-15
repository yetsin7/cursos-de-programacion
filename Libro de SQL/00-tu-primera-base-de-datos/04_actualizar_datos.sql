-- =============================================================================
-- Capítulo 00 — UPDATE: modificar contactos existentes
-- Archivo: 04_actualizar_datos.sql
-- Base de datos: mi_base_de_datos.db
-- =============================================================================

.headers on
.mode column

PRAGMA foreign_keys = ON;


-- =============================================================================
-- Ver estado actual antes de actualizar
-- =============================================================================

SELECT id, nombre, email, telefono, ciudad FROM personas;


-- =============================================================================
-- UPDATE básico: cambiar un valor
-- =============================================================================

-- Cambiar el teléfono de Luis (id = 2)
UPDATE personas SET telefono = '8888-9999' WHERE id = 2;

-- Verificar el cambio
SELECT id, nombre, telefono FROM personas WHERE id = 2;


-- =============================================================================
-- UPDATE con múltiples columnas
-- =============================================================================

-- Actualizar email y ciudad de María (id = 3)
UPDATE personas
SET email = 'maria@correo.com', ciudad = 'Managua'
WHERE id = 3;

-- Verificar
SELECT id, nombre, email, ciudad FROM personas WHERE id = 3;


-- =============================================================================
-- UPDATE con condición por valor (no por id)
-- =============================================================================

-- Cambiar "Sin especificar" por "Nicaragua" en todos los que lo tienen
UPDATE personas
SET ciudad = 'Nicaragua'
WHERE ciudad = 'Sin especificar';

-- Verificar cuántos se actualizaron
SELECT nombre, ciudad FROM personas WHERE ciudad = 'Nicaragua';


-- =============================================================================
-- UPDATE en notas
-- =============================================================================

-- Actualizar el contenido de una nota
UPDATE notas
SET contenido = 'Reunión agendada para el lunes. Muy interesado.'
WHERE id = 5;

-- Ver el resultado
SELECT p.nombre, n.contenido
FROM notas n JOIN personas p ON p.id = n.persona_id
WHERE n.id = 5;


-- =============================================================================
-- VERIFICAR estado final
-- =============================================================================

SELECT id, nombre, email, telefono, ciudad FROM personas ORDER BY id;
