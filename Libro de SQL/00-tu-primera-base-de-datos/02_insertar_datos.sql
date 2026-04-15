-- =============================================================================
-- Capítulo 00 — INSERT: agregar contactos
-- Archivo: 02_insertar_datos.sql
-- Base de datos: mi_base_de_datos.db
--
-- NOTA: Ejecuta primero 01_crear_bd.sql si aún no lo has hecho.
-- =============================================================================

.headers on
.mode column

PRAGMA foreign_keys = ON;


-- =============================================================================
-- INSERT básico: una persona a la vez
-- =============================================================================

-- Forma completa: especificar todas las columnas
INSERT INTO personas (nombre, email, telefono, ciudad)
VALUES ('Ana García', 'ana@correo.com', '8888-1111', 'Managua');

-- Forma corta: omitir columnas opcionales (tomarán su valor por defecto)
INSERT INTO personas (nombre, email)
VALUES ('Luis Pérez', 'luis@correo.com');

-- Sin email (puede ser NULL porque no pusimos NOT NULL en email)
INSERT INTO personas (nombre, telefono, ciudad)
VALUES ('María López', '8888-2222', 'León');

-- Con ciudad explícita
INSERT INTO personas (nombre, email, ciudad)
VALUES ('Carlos Ruiz', 'carlos@correo.com', 'Granada');


-- =============================================================================
-- INSERT múltiple: varias personas en una sola instrucción
-- =============================================================================

INSERT INTO personas (nombre, email, telefono, ciudad) VALUES
    ('Sofía Martínez', 'sofia@correo.com',  '8888-3333', 'Managua'),
    ('Diego Torres',   'diego@correo.com',  '8888-4444', 'Masaya'),
    ('Elena Jiménez',  NULL,                '8888-5555', 'Estelí'),
    ('Roberto Díaz',   'roberto@correo.com', NULL,       'Managua');


-- =============================================================================
-- INSERT en la tabla notas
-- =============================================================================

INSERT INTO notas (persona_id, contenido) VALUES
    (1, 'Conocida en el trabajo. Muy puntual.'),
    (1, 'Prefiere comunicación por email.'),
    (2, 'Amigo de la universidad.'),
    (3, 'Familiar de un colega.'),
    (5, 'Cliente potencial. Reunión pendiente.');


-- =============================================================================
-- VERIFICAR los datos insertados
-- =============================================================================

-- Ver todas las personas
SELECT id, nombre, email, ciudad, creado_en FROM personas;

-- Contar cuántas personas se insertaron
SELECT COUNT(*) AS total_contactos FROM personas;

-- Ver las notas con el nombre de la persona
SELECT p.nombre, n.contenido, n.creado_en
FROM notas n
JOIN personas p ON p.id = n.persona_id
ORDER BY p.nombre;
