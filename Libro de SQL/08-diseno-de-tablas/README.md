# Capítulo 08 — Diseño de Tablas

## CREATE TABLE — Crear una tabla

```sql
CREATE TABLE usuarios (
    id      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre  TEXT    NOT NULL,
    email   TEXT    UNIQUE NOT NULL,
    edad    INTEGER CHECK (edad >= 0 AND edad <= 150),
    activo  INTEGER DEFAULT 1   -- 1 = true, 0 = false en SQLite
);
```

---

## Tipos de datos en SQLite

SQLite usa un sistema de tipos flexible llamado **Type Affinity**:

| Tipo | Uso | Ejemplos |
|------|-----|---------|
| `INTEGER` | Números enteros | id, book_number, chapter, verse |
| `REAL` | Números decimales | precio, promedio |
| `TEXT` | Cadenas de texto | nombre, email, long_name |
| `BLOB` | Datos binarios | imágenes, archivos |
| `NUMERIC` | Números (entero o decimal) | dinero, porcentajes |

---

## Constraints (Restricciones)

| Constraint | Descripción |
|------------|-------------|
| `PRIMARY KEY` | Identificador único de la fila |
| `NOT NULL` | El campo no puede ser NULL |
| `UNIQUE` | El valor debe ser único en toda la tabla |
| `DEFAULT valor` | Valor por defecto si no se especifica |
| `CHECK (condición)` | Valida que el valor cumpla una condición |
| `FOREIGN KEY` | Referencia a la clave primaria de otra tabla |

---

## FOREIGN KEY — Claves foráneas

Las claves foráneas mantienen la integridad referencial entre tablas:

```sql
CREATE TABLE verses (
    book_number INTEGER NOT NULL,
    chapter     INTEGER NOT NULL,
    verse       INTEGER NOT NULL,
    text        TEXT    NOT NULL,
    FOREIGN KEY (book_number) REFERENCES books(book_number)
        ON DELETE CASCADE   -- si se borra el libro, se borran sus versículos
);
```

> **Nota:** En SQLite, las FOREIGN KEY deben activarse explícitamente:
> `PRAGMA foreign_keys = ON;`

---

## ALTER TABLE — Modificar una tabla

```sql
-- Agregar una columna nueva
ALTER TABLE books ADD COLUMN is_poetry INTEGER DEFAULT 0;

-- Renombrar la tabla (SQLite 3.25+)
ALTER TABLE old_name RENAME TO new_name;
```

---

## DROP TABLE — Eliminar una tabla

```sql
-- Eliminar una tabla (¡irreversible!)
DROP TABLE IF EXISTS tabla_temporal;
```

---

## Archivos del capítulo

| Archivo | Contenido |
|---------|-----------|
| `01_create_tables.sql` | Crear tablas con constraints y relaciones |
| `02_alter_drop.sql` | Modificar y eliminar tablas |
