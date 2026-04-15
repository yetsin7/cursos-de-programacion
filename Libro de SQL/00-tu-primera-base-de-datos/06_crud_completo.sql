-- =============================================================================
-- Capítulo 00 — CRUD completo: flujo real de una aplicación
-- Archivo: 06_crud_completo.sql
-- Base de datos: mi_base_de_datos.db
--
-- Este archivo simula cómo una app real usaría la BD:
-- crear, leer, actualizar y eliminar en un flujo coherente.
-- =============================================================================

.headers on
.mode column

PRAGMA foreign_keys = ON;


-- =============================================================================
-- ESCENARIO: Gestionar una agenda de contactos
-- =============================================================================

-- PASO 1: Limpiar y empezar desde cero
DROP TABLE IF EXISTS notas;
DROP TABLE IF EXISTS personas;

CREATE TABLE personas (
    id        INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre    TEXT NOT NULL,
    email     TEXT UNIQUE,
    telefono  TEXT,
    ciudad    TEXT DEFAULT 'Sin especificar',
    creado_en TEXT DEFAULT (datetime('now'))
);

CREATE TABLE notas (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    persona_id INTEGER NOT NULL,
    contenido  TEXT NOT NULL,
    creado_en  TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (persona_id) REFERENCES personas(id) ON DELETE CASCADE
);

SELECT '=== BD creada ===' AS paso;


-- =============================================================================
-- CREATE: agregar nuevos contactos
-- =============================================================================

INSERT INTO personas (nombre, email, telefono, ciudad) VALUES
    ('Juan Herrera',  'juan@email.com',  '8000-0001', 'Managua'),
    ('Laura Castillo','laura@email.com', '8000-0002', 'León'),
    ('Pedro Vásquez', NULL,              '8000-0003', 'Granada');

INSERT INTO notas (persona_id, contenido) VALUES
    (1, 'Cliente nuevo. Interesado en el plan básico.'),
    (1, 'Llamar el martes para hacer seguimiento.'),
    (2, 'Referida por Juan. Muy buena comunicación.');

SELECT '=== Contactos creados ===' AS paso;
SELECT id, nombre, email, ciudad FROM personas;


-- =============================================================================
-- READ: buscar y consultar
-- =============================================================================

SELECT '=== Buscar contactos de Managua ===' AS paso;
SELECT nombre, email FROM personas WHERE ciudad = 'Managua';

SELECT '=== Notas de Juan ===' AS paso;
SELECT n.contenido FROM notas n
JOIN personas p ON p.id = n.persona_id
WHERE p.nombre = 'Juan Herrera';


-- =============================================================================
-- UPDATE: actualizar datos de un contacto
-- =============================================================================

-- Juan actualizó su teléfono
UPDATE personas SET telefono = '8000-9999' WHERE nombre = 'Juan Herrera';

-- Pedro finalmente dio su email
UPDATE personas SET email = 'pedro@email.com' WHERE nombre = 'Pedro Vásquez';

SELECT '=== Después de actualizar ===' AS paso;
SELECT id, nombre, email, telefono FROM personas;


-- =============================================================================
-- UPDATE a notas: marcar seguimiento como completado
-- =============================================================================

UPDATE notas
SET contenido = '[COMPLETADO] Llamada realizada el martes. Acepta reunión.'
WHERE persona_id = 1 AND contenido LIKE '%Llamar%';

SELECT '=== Nota actualizada ===' AS paso;
SELECT n.contenido FROM notas n WHERE n.persona_id = 1;


-- =============================================================================
-- DELETE: eliminar un contacto inactivo
-- =============================================================================

-- Pedro canceló. Eliminarlo junto con sus datos (no tiene notas, pero CASCADE las borraría)
DELETE FROM personas WHERE nombre = 'Pedro Vásquez';

SELECT '=== Después de eliminar a Pedro ===' AS paso;
SELECT id, nombre, ciudad FROM personas;


-- =============================================================================
-- RESUMEN FINAL
-- =============================================================================

SELECT '=== RESUMEN FINAL ===' AS resultado;

SELECT
    p.nombre,
    p.email,
    p.ciudad,
    COUNT(n.id) AS notas
FROM personas p
LEFT JOIN notas n ON n.persona_id = p.id
GROUP BY p.id
ORDER BY p.nombre;
