/*
 * Capítulo 12 — Proyecto Biblia
 * Archivo: 01_explorar_bd.c
 *
 * Programa completo que usa SQLite3 en C para consultar la Biblia
 * Reina-Valera 1960. Demuestra:
 *   - Abrir una base de datos SQLite
 *   - Listar los primeros 5 libros de la Biblia
 *   - Contar versículos por testamento
 *   - Buscar Juan 3:16 con prepared statement
 *   - Búsqueda de texto libre en versículos
 *   - Manejo correcto de errores y cierre de recursos
 *
 * Ruta de la BD: ../../datos/biblia_rv60.sqlite3
 *
 * Compilar (Linux/macOS):
 *   gcc -Wall -std=c11 -o explorar 01_explorar_bd.c -lsqlite3
 *
 * Compilar (Windows con amalgamation):
 *   gcc -Wall -std=c11 -o explorar 01_explorar_bd.c sqlite3.c -lpthread
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sqlite3.h>

/* Ruta relativa a la base de datos desde este directorio */
#define RUTA_BD "../../datos/biblia_rv60.sqlite3"

/* -------------------------------------------------------
 * Prototipos de funciones
 * ------------------------------------------------------- */
sqlite3 *abrirBaseDatos(const char *ruta);
void cerrarBaseDatos(sqlite3 *db);
void listarPrimerosCincoLibros(sqlite3 *db);
void contarVersiculosPorTestamento(sqlite3 *db);
void buscarVersiculo(sqlite3 *db, int libroId, int capitulo, int versiculo);
void buscarTexto(sqlite3 *db, const char *termino, int limite);
void imprimirSeparador(const char *titulo);

int main(void) {

    printf("╔══════════════════════════════════════════════════╗\n");
    printf("║     PROYECTO BIBLIA — SQLite3 en C              ║\n");
    printf("║     Biblia Reina-Valera 1960                     ║\n");
    printf("╚══════════════════════════════════════════════════╝\n\n");

    /* -------------------------------------------------------
     * 1. Abrir la base de datos
     * ------------------------------------------------------- */
    sqlite3 *db = abrirBaseDatos(RUTA_BD);
    if (db == NULL) {
        fprintf(stderr, "No se pudo abrir la base de datos: %s\n", RUTA_BD);
        fprintf(stderr, "Verifica que el archivo existe en ../../datos/\n");
        return 1;
    }
    printf("Base de datos abierta: %s\n\n", RUTA_BD);

    /* -------------------------------------------------------
     * 2. Listar los primeros 5 libros
     * ------------------------------------------------------- */
    listarPrimerosCincoLibros(db);

    /* -------------------------------------------------------
     * 3. Contar versículos por testamento
     * ------------------------------------------------------- */
    contarVersiculosPorTestamento(db);

    /* -------------------------------------------------------
     * 4. Buscar Juan 3:16
     * libro_id de Juan en la RV60 = 43
     * ------------------------------------------------------- */
    imprimirSeparador("JUAN 3:16");
    buscarVersiculo(db, 43, 3, 16);

    /* -------------------------------------------------------
     * 5. Buscar Génesis 1:1
     * libro_id de Génesis = 1
     * ------------------------------------------------------- */
    imprimirSeparador("GENESIS 1:1");
    buscarVersiculo(db, 1, 1, 1);

    /* -------------------------------------------------------
     * 6. Búsqueda de texto libre
     * ------------------------------------------------------- */
    imprimirSeparador("BUSQUEDA: 'amor'");
    buscarTexto(db, "amor", 5);

    /* -------------------------------------------------------
     * 7. Cerrar la base de datos
     * ------------------------------------------------------- */
    cerrarBaseDatos(db);
    printf("\nConexion cerrada. ¡Programa finalizado!\n");

    return 0;
}


/*
 * abrirBaseDatos — Abre una conexión a la base de datos SQLite.
 * Recibe: ruta — ruta al archivo .sqlite3
 * Retorna: puntero al handle de la BD, o NULL si falla
 */
sqlite3 *abrirBaseDatos(const char *ruta) {
    sqlite3 *db = NULL;
    int rc = sqlite3_open(ruta, &db);

    if (rc != SQLITE_OK) {
        fprintf(stderr, "Error al abrir BD: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        return NULL;
    }
    return db;
}

/*
 * cerrarBaseDatos — Cierra la conexión a SQLite de forma segura.
 * Recibe: db — handle de la base de datos
 */
void cerrarBaseDatos(sqlite3 *db) {
    if (db) {
        sqlite3_close(db);
    }
}

/*
 * listarPrimerosCincoLibros — Consulta y muestra los primeros 5 libros.
 * Recibe: db — conexión activa a la base de datos
 */
void listarPrimerosCincoLibros(sqlite3 *db) {
    imprimirSeparador("PRIMEROS 5 LIBROS DE LA BIBLIA");

    const char *sql = "SELECT id, nombre, abrev, testamento "
                      "FROM libros ORDER BY id ASC LIMIT 5;";

    sqlite3_stmt *stmt;
    int rc = sqlite3_prepare_v2(db, sql, -1, &stmt, NULL);

    if (rc != SQLITE_OK) {
        fprintf(stderr, "Error al preparar consulta: %s\n", sqlite3_errmsg(db));
        return;
    }

    printf("  %-4s %-25s %-8s %s\n", "ID", "Nombre", "Abrev", "Testamento");
    printf("  %-4s %-25s %-8s %s\n", "----", "-------------------------",
           "--------", "-----------");

    /* sqlite3_step devuelve SQLITE_ROW por cada fila disponible */
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        int id         = sqlite3_column_int(stmt, 0);
        const char *nombre    = (const char*)sqlite3_column_text(stmt, 1);
        const char *abrev     = (const char*)sqlite3_column_text(stmt, 2);
        const char *testamento = (const char*)sqlite3_column_text(stmt, 3);

        printf("  %-4d %-25s %-8s %s\n",
               id,
               nombre     ? nombre     : "(sin nombre)",
               abrev      ? abrev      : "-",
               testamento ? testamento : "-");
    }

    /* Siempre finalizar el statement para liberar recursos */
    sqlite3_finalize(stmt);
    printf("\n");
}

/*
 * contarVersiculosPorTestamento — Muestra estadísticas de versículos.
 * Recibe: db — conexión activa
 */
void contarVersiculosPorTestamento(sqlite3 *db) {
    imprimirSeparador("ESTADISTICAS");

    const char *sql =
        "SELECT l.testamento, COUNT(v.id) AS total "
        "FROM versiculos v "
        "JOIN libros l ON v.libro_id = l.id "
        "GROUP BY l.testamento;";

    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) != SQLITE_OK) {
        fprintf(stderr, "Error: %s\n", sqlite3_errmsg(db));
        return;
    }

    while (sqlite3_step(stmt) == SQLITE_ROW) {
        const char *testamento = (const char*)sqlite3_column_text(stmt, 0);
        int total              = sqlite3_column_int(stmt, 1);
        printf("  Testamento %s: %d versiculos\n",
               testamento ? testamento : "Desconocido", total);
    }

    sqlite3_finalize(stmt);
    printf("\n");
}

/*
 * buscarVersiculo — Busca y muestra un versículo específico.
 * Recibe: db — conexión, libroId — ID del libro, capitulo y versiculo
 * Usa prepared statement con parámetros para evitar SQL injection.
 */
void buscarVersiculo(sqlite3 *db, int libroId, int capitulo, int versiculo) {
    const char *sql =
        "SELECT l.nombre, v.capitulo, v.versiculo, v.texto "
        "FROM versiculos v "
        "JOIN libros l ON v.libro_id = l.id "
        "WHERE v.libro_id = ? AND v.capitulo = ? AND v.versiculo = ?;";

    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) != SQLITE_OK) {
        fprintf(stderr, "Error al preparar: %s\n", sqlite3_errmsg(db));
        return;
    }

    /* Vincular los parámetros (índices comienzan en 1) */
    sqlite3_bind_int(stmt, 1, libroId);
    sqlite3_bind_int(stmt, 2, capitulo);
    sqlite3_bind_int(stmt, 3, versiculo);

    if (sqlite3_step(stmt) == SQLITE_ROW) {
        const char *libro = (const char*)sqlite3_column_text(stmt, 0);
        int cap  = sqlite3_column_int(stmt, 1);
        int ver  = sqlite3_column_int(stmt, 2);
        const char *texto = (const char*)sqlite3_column_text(stmt, 3);

        printf("  %s %d:%d\n", libro ? libro : "?", cap, ver);
        printf("  \"%s\"\n", texto ? texto : "(texto no disponible)");
    } else {
        printf("  Versiculo no encontrado.\n");
    }

    sqlite3_finalize(stmt);
    printf("\n");
}

/*
 * buscarTexto — Busca versículos que contengan un término.
 * Recibe: db — conexión, termino — texto a buscar, limite — máximo resultados
 */
void buscarTexto(sqlite3 *db, const char *termino, int limite) {
    const char *sql =
        "SELECT l.nombre, v.capitulo, v.versiculo, v.texto "
        "FROM versiculos v "
        "JOIN libros l ON v.libro_id = l.id "
        "WHERE v.texto LIKE ? "
        "LIMIT ?;";

    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) != SQLITE_OK) {
        fprintf(stderr, "Error: %s\n", sqlite3_errmsg(db));
        return;
    }

    /* Construir el patrón LIKE: %termino% */
    char patron[256];
    snprintf(patron, sizeof(patron), "%%%s%%", termino);

    sqlite3_bind_text(stmt, 1, patron, -1, SQLITE_STATIC);
    sqlite3_bind_int(stmt, 2, limite);

    int conteo = 0;
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        const char *libro = (const char*)sqlite3_column_text(stmt, 0);
        int cap   = sqlite3_column_int(stmt, 1);
        int ver   = sqlite3_column_int(stmt, 2);
        const char *texto = (const char*)sqlite3_column_text(stmt, 3);

        printf("  [%d] %s %d:%d\n", ++conteo, libro ? libro : "?", cap, ver);
        printf("       %s\n\n", texto ? texto : "(sin texto)");
    }

    if (conteo == 0) {
        printf("  Sin resultados para '%s'\n", termino);
    }

    sqlite3_finalize(stmt);
}

/*
 * imprimirSeparador — Imprime un separador visual con título centrado.
 * Recibe: titulo — texto del separador
 */
void imprimirSeparador(const char *titulo) {
    printf("--- %s ---\n", titulo);
}
