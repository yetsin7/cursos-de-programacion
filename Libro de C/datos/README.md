# Datos — Base de datos de la Biblia

## Archivo principal

```
../../datos/biblia_rv60.sqlite3
```

Este directorio referencia la base de datos SQLite con la Biblia Reina-Valera 1960, ubicada en:

```
C:/Users/Yetsin/Documents/Programacion/datos/biblia_rv60.sqlite3
```

---

## Estructura típica de la base de datos

La base de datos `biblia_rv60.sqlite3` suele tener la siguiente estructura:

```sql
-- Tabla de libros
CREATE TABLE libros (
    id        INTEGER PRIMARY KEY,
    nombre    TEXT NOT NULL,
    abrev     TEXT,
    testamento TEXT  -- 'Antiguo' o 'Nuevo'
);

-- Tabla de versículos
CREATE TABLE versiculos (
    id        INTEGER PRIMARY KEY,
    libro_id  INTEGER REFERENCES libros(id),
    capitulo  INTEGER NOT NULL,
    versiculo INTEGER NOT NULL,
    texto     TEXT NOT NULL
);
```

---

## Cómo acceder a SQLite desde C

### Requisitos

- Tener instalada la librería `libsqlite3`
- Header: `#include <sqlite3.h>`
- Compilar con: `gcc -o programa archivo.c -lsqlite3`

**Linux/Ubuntu:**
```bash
sudo apt install libsqlite3-dev
```

**macOS:**
```bash
brew install sqlite3
```

**Windows (MinGW):**
Descargar los amalgamation files de https://sqlite.org/download.html y compilar juntos:
```bash
gcc -o programa programa.c sqlite3.c -lpthread -ldl
```

---

## Ejemplo básico de conexión en C

```c
#include <stdio.h>
#include <sqlite3.h>

int main(void) {
    sqlite3 *db;
    int rc;

    /* Abrir (o crear) la base de datos */
    rc = sqlite3_open("../../datos/biblia_rv60.sqlite3", &db);

    if (rc != SQLITE_OK) {
        fprintf(stderr, "Error al abrir BD: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        return 1;
    }

    printf("Base de datos abierta correctamente.\n");

    /* Siempre cerrar la conexión al terminar */
    sqlite3_close(db);
    return 0;
}
```

Compilar:
```bash
gcc -o ejemplo ejemplo.c -lsqlite3
./ejemplo
```

---

## Consulta básica con callback

```c
#include <stdio.h>
#include <sqlite3.h>

/* Función callback: se llama por cada fila del resultado */
static int callback(void *datos, int cols, char **valores, char **nombres) {
    for (int i = 0; i < cols; i++) {
        printf("%s = %s\n", nombres[i], valores[i] ? valores[i] : "NULL");
    }
    printf("---\n");
    return 0;
}

int main(void) {
    sqlite3 *db;
    char *error = NULL;

    sqlite3_open("../../datos/biblia_rv60.sqlite3", &db);

    /* Ejecutar una consulta y usar el callback para imprimir resultados */
    sqlite3_exec(db, "SELECT * FROM libros LIMIT 3;", callback, NULL, &error);

    if (error) {
        fprintf(stderr, "Error SQL: %s\n", error);
        sqlite3_free(error);
    }

    sqlite3_close(db);
    return 0;
}
```

---

Ver el **capítulo 12** para un proyecto completo con esta base de datos.
