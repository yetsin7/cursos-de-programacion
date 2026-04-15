-- =============================================================================
-- Capítulo 00 — Tu primera base de datos
-- Archivo: 01_crear_bd.sql
-- Base de datos: mi_base_de_datos.db  (se crea en esta misma carpeta)
--
-- Cómo usar:
--   sqlite3 mi_base_de_datos.db < 01_crear_bd.sql
-- O desde sqlite3 interactivo:
--   .read 01_crear_bd.sql
-- =============================================================================

.headers on
.mode column


-- =============================================================================
-- PASO 1: Limpiar si ya existe (para poder re-ejecutar sin errores)
-- =============================================================================

DROP TABLE IF EXISTS notas;
DROP TABLE IF EXISTS personas;


-- =============================================================================
-- PASO 2: Crear las tablas
-- =============================================================================

-- Tabla principal: datos de contacto
CREATE TABLE personas (
    id        INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID automático
    nombre    TEXT    NOT NULL,                   -- nombre completo obligatorio
    email     TEXT    UNIQUE,                     -- email único (puede ser NULL)
    telefono  TEXT,                               -- teléfono opcional
    ciudad    TEXT    DEFAULT 'Sin especificar',  -- ciudad con valor por defecto
    creado_en TEXT    DEFAULT (datetime('now'))   -- fecha de creación automática
);

-- Tabla secundaria: notas sobre cada persona
CREATE TABLE notas (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    persona_id INTEGER NOT NULL,               -- FK → personas.id
    contenido  TEXT    NOT NULL,               -- texto de la nota
    creado_en  TEXT    DEFAULT (datetime('now')),
    FOREIGN KEY (persona_id) REFERENCES personas(id) ON DELETE CASCADE
);

-- Activar claves foráneas (necesario en SQLite)
PRAGMA foreign_keys = ON;


-- =============================================================================
-- PASO 3: Verificar que se crearon correctamente
-- =============================================================================

-- Ver las tablas creadas
SELECT name AS tabla FROM sqlite_master WHERE type = 'table' ORDER BY name;

-- Ver la estructura de cada tabla
PRAGMA table_info(personas);
PRAGMA table_info(notas);

SELECT '¡Base de datos creada correctamente!' AS resultado;
