-- =============================================================================
-- Capítulo 08 — Diseño de tablas: CREATE TABLE, constraints
-- Archivo: 01_create_tables.sql
-- Este archivo crea tablas de ejemplo y las elimina al final.
-- =============================================================================

.headers on
.mode column


-- =============================================================================
-- CREAR TABLAS CON CONSTRAINTS
-- =============================================================================

-- Tabla simple con tipos básicos
CREATE TABLE IF NOT EXISTS usuarios (
    id      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre  TEXT    NOT NULL,
    email   TEXT    UNIQUE NOT NULL,
    edad    INTEGER CHECK (edad >= 0 AND edad <= 150),
    activo  INTEGER DEFAULT 1
);

-- Tabla con FOREIGN KEY (referencia a usuarios)
CREATE TABLE IF NOT EXISTS notas_biblia (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    usuario_id  INTEGER NOT NULL,
    libro_num   INTEGER NOT NULL,
    capitulo    INTEGER NOT NULL,
    versiculo   INTEGER NOT NULL,
    nota        TEXT    NOT NULL,
    creado_en   TEXT    DEFAULT (datetime('now')),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (libro_num)  REFERENCES books(book_number)
);

-- Verificar que se crearon
SELECT name FROM sqlite_master WHERE type = 'table' AND name IN ('usuarios', 'notas_biblia');


-- =============================================================================
-- INSERTAR DATOS DE PRUEBA
-- =============================================================================

INSERT INTO usuarios (nombre, email, edad) VALUES
    ('Ana García',  'ana@ejemplo.com',   28),
    ('Luis Pérez',  'luis@ejemplo.com',  35),
    ('María López', 'maria@ejemplo.com', 22);

INSERT INTO notas_biblia (usuario_id, libro_num, capitulo, versiculo, nota) VALUES
    (1, 430, 3, 16, 'El versículo más importante del NT'),
    (1, 190, 23, 1, 'El Salmo del pastor — favorito personal'),
    (2, 10,  1,  1, 'El inicio de todo');

-- Ver los datos insertados con JOIN
SELECT
    u.nombre    AS usuario,
    b.long_name AS libro,
    n.capitulo,
    n.versiculo,
    n.nota
FROM notas_biblia n
JOIN usuarios u ON u.id = n.usuario_id
JOIN books    b ON b.book_number = n.libro_num
ORDER BY u.nombre;


-- =============================================================================
-- EXPLORAR LA ESTRUCTURA DE LAS TABLAS CREADAS
-- =============================================================================

-- Ver la definición completa de cada tabla
SELECT sql FROM sqlite_master WHERE name = 'usuarios';
SELECT sql FROM sqlite_master WHERE name = 'notas_biblia';

-- PRAGMA: ver columnas de una tabla
PRAGMA table_info(usuarios);
PRAGMA table_info(notas_biblia);


-- =============================================================================
-- LIMPIEZA: eliminar tablas de prueba
-- =============================================================================

DROP TABLE IF EXISTS notas_biblia;
DROP TABLE IF EXISTS usuarios;

-- Verificar que se eliminaron
SELECT name FROM sqlite_master WHERE type = 'table' AND name IN ('usuarios', 'notas_biblia');
