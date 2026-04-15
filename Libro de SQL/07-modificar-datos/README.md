# Capítulo 07 — Modificar Datos: INSERT, UPDATE, DELETE

## INSERT — Insertar filas

```sql
-- Insertar una fila
INSERT INTO books (book_number, short_name, long_name, book_color)
VALUES (999, 'Test', 'Libro de Prueba', '#FFFFFF');

-- Insertar múltiples filas a la vez
INSERT INTO books (book_number, short_name, long_name, book_color) VALUES
    (997, 'T1', 'Prueba Uno', '#FF0000'),
    (998, 'T2', 'Prueba Dos', '#00FF00');
```

---

## UPDATE — Modificar filas existentes

```sql
-- Actualizar un registro específico
UPDATE books SET book_color = '#123456' WHERE book_number = 10;

-- Actualizar múltiples columnas
UPDATE books
SET long_name = 'Nuevo Nombre', book_color = '#ABCDEF'
WHERE book_number = 999;

-- CUIDADO: sin WHERE, actualiza TODAS las filas
UPDATE books SET book_color = '#000000';  -- ¡modifica todos los libros!
```

---

## DELETE — Eliminar filas

```sql
-- Eliminar un registro específico
DELETE FROM books WHERE book_number = 999;

-- Eliminar varios registros
DELETE FROM books WHERE book_number IN (997, 998);

-- CUIDADO: sin WHERE, elimina TODOS los registros
DELETE FROM books;  -- ¡elimina todos los libros!
```

---

## UPSERT — INSERT OR REPLACE

SQLite tiene `INSERT OR REPLACE` (y `INSERT OR IGNORE`) para manejar conflictos:

```sql
-- Si ya existe el book_number, reemplaza; si no, inserta
INSERT OR REPLACE INTO books (book_number, short_name, long_name)
VALUES (10, 'Gn', 'Génesis Actualizado');

-- Si ya existe, ignora (no hace nada)
INSERT OR IGNORE INTO books (book_number, short_name, long_name)
VALUES (10, 'Gn', 'Este texto no se guardará');
```

---

## Archivos del capítulo

| Archivo | Contenido |
|---------|-----------|
| `01_insert_update_delete.sql` | CRUD completo con datos de prueba |
