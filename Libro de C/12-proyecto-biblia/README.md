# Capítulo 12 — Proyecto Biblia: SQLite3 en C

## Objetivo del capítulo

Este es el proyecto final del libro. Usaremos todo lo aprendido (structs, punteros, strings,
manejo de archivos, memoria dinámica) para construir un programa que consulte la base de datos
de la Biblia Reina-Valera 1960 usando SQLite3 desde C puro.

---

## ¿Qué es SQLite?

SQLite es el motor de base de datos más usado del mundo. Está embebido en Android, iOS, Firefox,
Chrome, Python y miles de aplicaciones. No requiere servidor — la base de datos es un único
archivo `.sqlite3`.

---

## Ruta de la base de datos

```
../../datos/biblia_rv60.sqlite3
```

Desde los archivos de este capítulo (dentro de `12-proyecto-biblia/`), la ruta relativa a la
base de datos es:

```
../../datos/biblia_rv60.sqlite3
```

---

## Instalación de SQLite3

### Linux (Debian/Ubuntu)

```bash
sudo apt install libsqlite3-dev
```

### macOS

```bash
brew install sqlite3
```

### Windows (MinGW / MSYS2)

```bash
pacman -S mingw-w64-x86_64-sqlite3
```

O usar el amalgamation (un solo archivo .c + .h):

1. Descargar `sqlite-amalgamation-*.zip` desde https://sqlite.org/download.html
2. Copiar `sqlite3.c` y `sqlite3.h` en el directorio del proyecto
3. Compilar incluyendo `sqlite3.c` directamente:

```bash
gcc -o programa 01_explorar_bd.c sqlite3.c -lpthread
```

---

## Cómo compilar

```bash
# Linux / macOS (con libsqlite3 instalada)
gcc -Wall -std=c11 -o explorar 01_explorar_bd.c -lsqlite3

# Windows con amalgamation en el mismo directorio
gcc -Wall -std=c11 -o explorar 01_explorar_bd.c sqlite3.c -lpthread
```

---

## Esquema de la base de datos biblia_rv60.sqlite3

La base de datos tiene típicamente estas tablas:

```sql
-- Libros de la Biblia
CREATE TABLE libros (
    id         INTEGER PRIMARY KEY,
    nombre     TEXT NOT NULL,
    abrev      TEXT,
    testamento TEXT   -- 'Antiguo' o 'Nuevo'
);

-- Versículos
CREATE TABLE versiculos (
    id        INTEGER PRIMARY KEY,
    libro_id  INTEGER NOT NULL,
    capitulo  INTEGER NOT NULL,
    versiculo INTEGER NOT NULL,
    texto     TEXT NOT NULL,
    FOREIGN KEY (libro_id) REFERENCES libros(id)
);
```

---

## API de SQLite3 en C

### Flujo básico

```c
sqlite3 *db;
char *error;

/* 1. Abrir la base de datos */
sqlite3_open("ruta/archivo.sqlite3", &db);

/* 2. Ejecutar consulta con callback */
sqlite3_exec(db, "SELECT ...", callback_fn, datos_usuario, &error);

/* 3. Cerrar la base de datos */
sqlite3_close(db);
```

### Prepared statements (más seguro — evita SQL injection)

```c
sqlite3_stmt *stmt;

/* Preparar la consulta con parámetros (? = placeholder) */
sqlite3_prepare_v2(db, "SELECT * FROM versiculos WHERE libro_id = ?", -1, &stmt, NULL);

/* Vincular el parámetro */
sqlite3_bind_int(stmt, 1, 43);   /* libro_id = 43 (Juan) */

/* Ejecutar fila por fila */
while (sqlite3_step(stmt) == SQLITE_ROW) {
    int cap = sqlite3_column_int(stmt, 2);
    int ver = sqlite3_column_int(stmt, 3);
    const char *txt = (const char*)sqlite3_column_text(stmt, 4);
    printf("%d:%d %s\n", cap, ver, txt);
}

/* Finalizar el statement */
sqlite3_finalize(stmt);
```

---

## Funciones clave de la API

| Función                      | Descripción                                     |
|------------------------------|-------------------------------------------------|
| `sqlite3_open(file, &db)`    | Abrir/crear base de datos                       |
| `sqlite3_close(db)`          | Cerrar conexión                                 |
| `sqlite3_exec(db, sql, cb, arg, &err)` | Ejecutar SQL con callback            |
| `sqlite3_prepare_v2(...)`    | Compilar una consulta preparada                 |
| `sqlite3_bind_int/text(...)`  | Vincular parámetros a la consulta               |
| `sqlite3_step(stmt)`         | Ejecutar un paso (obtener una fila)             |
| `sqlite3_column_int(stmt, i)`| Obtener columna entera de la fila actual        |
| `sqlite3_column_text(stmt, i)`| Obtener columna texto de la fila actual        |
| `sqlite3_finalize(stmt)`     | Liberar el statement compilado                  |
| `sqlite3_errmsg(db)`         | Obtener mensaje de error                        |

---

## Archivos de este capítulo

| Archivo             | Descripción                                              |
|---------------------|----------------------------------------------------------|
| `01_explorar_bd.c`  | Programa completo: listar libros, buscar Juan 3:16       |

---

## ¡Fin del libro!

Has llegado al capítulo final. Si llegaste aquí leyendo y practicando cada capítulo anterior,
ya tienes una base sólida en C:

- Tipos, variables, operadores
- Control de flujo y funciones
- Arreglos, strings y punteros
- Structs, archivos y memoria dinámica
- El preprocesador
- SQLite3 desde C

**Siguientes pasos sugeridos:**
- Estudiar estructuras de datos en C (listas enlazadas, árboles, tablas hash)
- Aprender C++ (orientación a objetos sobre la base de C)
- Explorar sistemas embebidos (Arduino, STM32)
- Contribuir a proyectos open source escritos en C
