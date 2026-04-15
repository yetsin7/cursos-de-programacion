# Capítulo 13 — Proyecto: Explorador de la Biblia con SQLite3

## Objetivo

Aplicar los conocimientos de todo el libro en un proyecto real: un programa
que consulta la base de datos de la Biblia Reina-Valera 1960 usando SQLite3.

---

## Ruta de la base de datos

```
../../datos/biblia_rv60.sqlite3
```

La ruta es **relativa** a esta carpeta (`13-proyecto-biblia/`).

---

## Instalar SQLite3

### Linux (Debian/Ubuntu)
```bash
sudo apt install libsqlite3-dev
```

### macOS (con Homebrew)
```bash
brew install sqlite
```

### Windows (MinGW)
1. Descargar `sqlite-amalgamation-*.zip` desde https://sqlite.org/download.html
2. Copiar `sqlite3.h` y `sqlite3.c` al directorio del proyecto
3. Compilar incluyendo el fuente:

```bash
g++ -std=c++17 -o explorar.exe 01_explorar_bd.cpp sqlite3.c
```

---

## Compilación

```bash
# Linux / macOS (librería instalada en el sistema)
g++ -std=c++17 -Wall -o explorar 01_explorar_bd.cpp -lsqlite3

# Windows con MinGW y sqlite3.c en el mismo directorio
g++ -std=c++17 -o explorar.exe 01_explorar_bd.cpp sqlite3.c
```

---

## Uso de SQLite3 en C++

### Flujo básico

```
1. sqlite3_open()       → Abrir la BD (obtener handle)
2. sqlite3_prepare_v2() → Compilar consulta SQL (obtener statement)
3. sqlite3_bind_*()     → Enlazar parámetros (opcional, evita SQL injection)
4. sqlite3_step()       → Ejecutar y avanzar por las filas
5. sqlite3_column_*()   → Leer columnas de la fila actual
6. sqlite3_finalize()   → Liberar el statement
7. sqlite3_close()      → Cerrar la BD
```

### Códigos de retorno importantes

| Código | Significado |
|--------|-------------|
| `SQLITE_OK` | Operación exitosa |
| `SQLITE_ROW` | Hay una fila disponible |
| `SQLITE_DONE` | No hay más filas |
| `SQLITE_ERROR` | Error en la consulta |

---

## Clase `EnvolturaBD`

El archivo `01_explorar_bd.cpp` implementa una clase `EnvolturaBD` que encapsula
las operaciones de SQLite3, siguiendo el patrón RAII:
- El constructor abre la conexión
- El destructor la cierra automáticamente

---

## Estructura de la BD

```sql
-- Libros
SELECT id, name FROM books ORDER BY id;

-- Versículos
SELECT book_id, chapter, verse, text FROM verses
WHERE book_id = 1 AND chapter = 1;

-- Búsqueda por texto
SELECT b.name, v.chapter, v.verse, v.text
FROM verses v JOIN books b ON b.id = v.book_id
WHERE v.text LIKE '%amor%';
```

---

## Archivo de ejemplo

Ver: [01_explorar_bd.cpp](01_explorar_bd.cpp)
