-- =============================================================================
-- Capítulo 00 — SELECT: consultar y buscar contactos
-- Archivo: 03_consultar_datos.sql
-- Base de datos: mi_base_de_datos.db
-- =============================================================================

.headers on
.mode column

PRAGMA foreign_keys = ON;


-- =============================================================================
-- SELECT básico: ver todos los datos
-- =============================================================================

-- Todos los contactos
SELECT * FROM personas;

-- Solo nombre y ciudad
SELECT nombre, ciudad FROM personas;

-- Con alias de columnas
SELECT nombre AS contacto, ciudad AS ubicacion FROM personas;


-- =============================================================================
-- WHERE: filtrar resultados
-- =============================================================================

-- Personas de Managua
SELECT nombre, telefono FROM personas WHERE ciudad = 'Managua';

-- Personas sin email registrado
SELECT nombre, ciudad FROM personas WHERE email IS NULL;

-- Personas con email registrado
SELECT nombre, email FROM personas WHERE email IS NOT NULL;

-- Buscar por nombre (LIKE)
SELECT * FROM personas WHERE nombre LIKE 'A%';    -- nombres que empiezan con A
SELECT * FROM personas WHERE nombre LIKE '%ez';   -- nombres que terminan en ez
SELECT * FROM personas WHERE nombre LIKE '%ar%';  -- nombres que contienen "ar"


-- =============================================================================
-- ORDER BY: ordenar resultados
-- =============================================================================

-- Alfabéticamente por nombre
SELECT nombre, ciudad FROM personas ORDER BY nombre ASC;

-- Por ciudad y luego por nombre
SELECT nombre, ciudad FROM personas ORDER BY ciudad, nombre;

-- Los más recientes primero
SELECT nombre, creado_en FROM personas ORDER BY creado_en DESC;


-- =============================================================================
-- LIMIT y OFFSET: paginación
-- =============================================================================

-- Solo los primeros 3 contactos
SELECT nombre FROM personas ORDER BY nombre LIMIT 3;

-- Del 4 al 6 (página 2)
SELECT nombre FROM personas ORDER BY nombre LIMIT 3 OFFSET 3;


-- =============================================================================
-- JOIN: combinar personas con sus notas
-- =============================================================================

-- Todos los contactos con sus notas
SELECT p.nombre, n.contenido
FROM personas p
LEFT JOIN notas n ON n.persona_id = p.id
ORDER BY p.nombre;

-- Solo contactos que TIENEN notas
SELECT p.nombre, n.contenido
FROM personas p
INNER JOIN notas n ON n.persona_id = p.id
ORDER BY p.nombre;

-- Contactos SIN ninguna nota
SELECT p.nombre
FROM personas p
LEFT JOIN notas n ON n.persona_id = p.id
WHERE n.id IS NULL;


-- =============================================================================
-- AGGREGATE: estadísticas
-- =============================================================================

-- Cuántos contactos hay por ciudad
SELECT ciudad, COUNT(*) AS contactos
FROM personas
GROUP BY ciudad
ORDER BY contactos DESC;

-- Cuántas notas tiene cada persona
SELECT p.nombre, COUNT(n.id) AS total_notas
FROM personas p
LEFT JOIN notas n ON n.persona_id = p.id
GROUP BY p.id
ORDER BY total_notas DESC;
