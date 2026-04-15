# Datos — Base de datos de la Biblia

Este directorio contiene la base de datos SQLite de la Biblia Reina-Valera 1960,
usada en los ejemplos de los capítulos 11 al 13.

---

## Ubicación del archivo

```
../../datos/biblia_rv60.sqlite3
```

La ruta anterior es **relativa** a cualquier subcarpeta de capítulo del libro.
En términos absolutos, el archivo se encuentra en:

```
<raiz-del-libro>/datos/biblia_rv60.sqlite3
```

---

## Estructura de la base de datos

La BD tiene (al menos) las siguientes tablas típicas en una Biblia SQLite:

```sql
-- Libros de la Biblia
CREATE TABLE books (
    id      INTEGER PRIMARY KEY,
    name    TEXT NOT NULL,       -- Nombre del libro (Génesis, Éxodo, ...)
    abbrev  TEXT                 -- Abreviatura
);

-- Versículos
CREATE TABLE verses (
    id      INTEGER PRIMARY KEY,
    book_id INTEGER NOT NULL,
    chapter INTEGER NOT NULL,
    verse   INTEGER NOT NULL,
    text    TEXT    NOT NULL
);
```

> Nota: el esquema exacto puede variar. Usa `.schema` en la CLI de sqlite3
> para inspeccionarlo: `sqlite3 biblia_rv60.sqlite3 ".schema"`

---

## Ejemplo de uso con sqlite3 desde C++

```cpp
#include <sqlite3.h>
#include <iostream>
#include <string>

int main() {
    // Abrir la base de datos
    sqlite3* db = nullptr;
    int resultado = sqlite3_open("../../datos/biblia_rv60.sqlite3", &db);

    if (resultado != SQLITE_OK) {
        std::cerr << "Error al abrir BD: " << sqlite3_errmsg(db) << "\n";
        return 1;
    }

    // Consulta: primer versículo de la Biblia
    const char* sql = "SELECT text FROM verses WHERE book_id=1 AND chapter=1 AND verse=1;";
    sqlite3_stmt* stmt = nullptr;

    sqlite3_prepare_v2(db, sql, -1, &stmt, nullptr);

    if (sqlite3_step(stmt) == SQLITE_ROW) {
        std::string texto = reinterpret_cast<const char*>(sqlite3_column_text(stmt, 0));
        std::cout << "Génesis 1:1 — " << texto << "\n";
    }

    // Liberar recursos
    sqlite3_finalize(stmt);
    sqlite3_close(db);
    return 0;
}
```

### Compilación

```bash
# Linux / macOS
g++ -std=c++17 -o ejemplo ejemplo.cpp -lsqlite3

# Windows con MinGW (sqlite3.dll debe estar en el PATH o mismo directorio)
g++ -std=c++17 -o ejemplo.exe ejemplo.cpp -lsqlite3
```

---

## Consultas útiles para explorar la BD

```sql
-- Listar todos los libros
SELECT id, name FROM books;

-- Contar versículos totales
SELECT COUNT(*) FROM verses;

-- Buscar versículos que contengan una palabra
SELECT b.name, v.chapter, v.verse, v.text
FROM verses v
JOIN books b ON b.id = v.book_id
WHERE v.text LIKE '%amor%'
LIMIT 10;

-- Obtener un capítulo completo (Salmos 23)
SELECT verse, text FROM verses
WHERE book_id = (SELECT id FROM books WHERE name = 'Salmos')
  AND chapter = 23
ORDER BY verse;
```
