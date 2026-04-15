-- =============================================================================
-- Capítulo 00 — Diseña TU propia base de datos
-- Archivo: 07_personaliza_tu_bd.sql
-- Base de datos: mi_base_de_datos.db
--
-- Este archivo es una PLANTILLA. Edítala con tus propias ideas.
-- Aquí encontrarás varios ejemplos comentados para inspirarte.
-- Elige uno, descoméntalo, y empieza a practicar.
-- =============================================================================

.headers on
.mode column

PRAGMA foreign_keys = ON;

-- Limpiar tablas anteriores
DROP TABLE IF EXISTS notas;
DROP TABLE IF EXISTS personas;


-- =============================================================================
-- OPCIÓN A: Base de datos de PELÍCULAS favoritas
-- Descomenta este bloque para usarlo
-- =============================================================================

/*
CREATE TABLE peliculas (
    id        INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo    TEXT    NOT NULL,
    director  TEXT,
    año       INTEGER,
    genero    TEXT,
    vista     INTEGER DEFAULT 0,   -- 0 = no vista, 1 = vista
    puntuacion INTEGER CHECK (puntuacion BETWEEN 1 AND 10)
);

CREATE TABLE reseñas (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    pelicula_id INTEGER NOT NULL,
    comentario  TEXT NOT NULL,
    fecha       TEXT DEFAULT (date('now')),
    FOREIGN KEY (pelicula_id) REFERENCES peliculas(id) ON DELETE CASCADE
);

-- Insertar algunas películas de ejemplo
INSERT INTO peliculas (titulo, director, año, genero, vista, puntuacion) VALUES
    ('El Padrino',     'Francis Ford Coppola', 1972, 'Drama',    1, 10),
    ('Interstellar',   'Christopher Nolan',    2014, 'Sci-Fi',   1, 9),
    ('El Señor de los Anillos', 'Peter Jackson', 2001, 'Fantasía', 1, 10),
    ('Dune',           'Denis Villeneuve',     2021, 'Sci-Fi',   0, NULL);

INSERT INTO reseñas (pelicula_id, comentario) VALUES
    (1, 'Una obra maestra del cine. Actuaciones perfectas.'),
    (2, 'Visualmente impresionante. La música de Zimmer es increíble.');

SELECT * FROM peliculas;
*/


-- =============================================================================
-- OPCIÓN B: Base de datos de LIBROS leídos
-- =============================================================================

/*
CREATE TABLE libros (
    id        INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo    TEXT NOT NULL,
    autor     TEXT NOT NULL,
    genero    TEXT,
    paginas   INTEGER,
    leido     INTEGER DEFAULT 0,
    fecha_fin TEXT
);

INSERT INTO libros (titulo, autor, genero, paginas, leido) VALUES
    ('El Quijote',            'Miguel de Cervantes', 'Clásico',  863, 0),
    ('Cien años de soledad',  'Gabriel García Márquez', 'Novela', 471, 1),
    ('Sapiens',               'Yuval Noah Harari',   'Historia', 498, 1),
    ('Atomic Habits',         'James Clear',          'Personal', 320, 1);

SELECT titulo, autor, leido FROM libros ORDER BY titulo;
*/


-- =============================================================================
-- OPCIÓN C: Base de datos de GASTOS personales
-- =============================================================================

/*
CREATE TABLE categorias (
    id     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE
);

CREATE TABLE gastos (
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    descripcion  TEXT    NOT NULL,
    monto        REAL    NOT NULL CHECK (monto > 0),
    categoria_id INTEGER,
    fecha        TEXT    DEFAULT (date('now')),
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

INSERT INTO categorias (nombre) VALUES
    ('Comida'), ('Transporte'), ('Entretenimiento'), ('Salud'), ('Educación');

INSERT INTO gastos (descripcion, monto, categoria_id) VALUES
    ('Almuerzo en el trabajo',  150.00, 1),
    ('Bus del mes',             300.00, 2),
    ('Netflix',                  89.00, 3),
    ('Farmacia',                 45.50, 4),
    ('Libro de programación',   250.00, 5),
    ('Supermercado',            800.00, 1);

-- Total gastado por categoría
SELECT c.nombre AS categoria, SUM(g.monto) AS total
FROM gastos g JOIN categorias c ON c.id = g.categoria_id
GROUP BY c.id ORDER BY total DESC;
*/


-- =============================================================================
-- TU PROPIO DISEÑO — Escribe aquí tu base de datos personalizada
-- =============================================================================

-- Piensa en algo que uses en tu vida diaria:
-- ¿Tienes una colección? ¿Quieres rastrear algo? ¿Un inventario?
--
-- Pasos:
-- 1. Define qué datos quieres guardar
-- 2. Crea las tablas con CREATE TABLE
-- 3. Inserta datos de prueba con INSERT
-- 4. Practica SELECT, UPDATE, DELETE sobre tus propios datos

-- Escribe tu código aquí:



-- Cuando termines, valida que todo funciona:
SELECT name AS mis_tablas FROM sqlite_master WHERE type = 'table';
