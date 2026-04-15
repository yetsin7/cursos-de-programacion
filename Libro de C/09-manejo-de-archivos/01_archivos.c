/*
 * Capítulo 09 — Manejo de Archivos
 * Archivo: 01_archivos.c
 *
 * Demuestra operaciones de archivo en C:
 *   - fopen, fclose, fprintf, fgets
 *   - Escribir y leer archivos de texto
 *   - Append — agregar datos sin borrar
 *   - Leer línea por línea
 *   - fseek, ftell para posicionamiento
 *   - Contar líneas y palabras
 *
 * Compilar: gcc -Wall -std=c11 -o archivos 01_archivos.c
 * Nota: se crean archivos temporales en el directorio actual
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Nombre del archivo temporal de prueba */
#define ARCHIVO_TEXTO "prueba_alumnos.txt"

/* Prototipos */
void escribirArchivo(const char *ruta);
void leerArchivo(const char *ruta);
void agregarLinea(const char *ruta, const char *linea);
long obtenerTamano(const char *ruta);
int contarLineas(const char *ruta);

int main(void) {

    /* -------------------------------------------------------
     * 1. Escribir un archivo de texto
     * ------------------------------------------------------- */
    printf("=== ESCRIBIR ARCHIVO ===\n");
    escribirArchivo(ARCHIVO_TEXTO);
    printf("Archivo '%s' creado.\n", ARCHIVO_TEXTO);

    /* -------------------------------------------------------
     * 2. Leer el archivo completo línea por línea
     * ------------------------------------------------------- */
    printf("\n=== LEER ARCHIVO ===\n");
    leerArchivo(ARCHIVO_TEXTO);

    /* -------------------------------------------------------
     * 3. Agregar una línea al final (append)
     * ------------------------------------------------------- */
    printf("\n=== AGREGAR LINEA (APPEND) ===\n");
    agregarLinea(ARCHIVO_TEXTO, "5,Elena Torres,19,9.8");
    printf("Linea agregada.\n");

    /* Volver a leer para verificar el append */
    printf("\nContenido actualizado:\n");
    leerArchivo(ARCHIVO_TEXTO);

    /* -------------------------------------------------------
     * 4. Información del archivo
     * ------------------------------------------------------- */
    printf("\n=== INFO DEL ARCHIVO ===\n");
    printf("Tamano: %ld bytes\n", obtenerTamano(ARCHIVO_TEXTO));
    printf("Lineas: %d\n", contarLineas(ARCHIVO_TEXTO));

    /* -------------------------------------------------------
     * 5. Leer un campo específico con fscanf
     * ------------------------------------------------------- */
    printf("\n=== FSCANF — LEER CAMPO ESPECIFICO ===\n");

    FILE *f = fopen(ARCHIVO_TEXTO, "r");
    if (f == NULL) {
        perror("No se pudo abrir el archivo");
        return 1;
    }

    char linea[256];
    int id;
    char nombre[60];
    int edad;
    double promedio;

    printf("Alumnos con promedio >= 8.5:\n");
    while (fgets(linea, sizeof(linea), f) != NULL) {
        /* Saltar la línea de encabezado */
        if (linea[0] == '#') continue;

        /* Parsear la línea CSV: id,nombre,edad,promedio */
        if (sscanf(linea, "%d,%59[^,],%d,%lf", &id, nombre, &edad, &promedio) == 4) {
            if (promedio >= 8.5) {
                printf("  ID %d: %s (promedio: %.1f)\n", id, nombre, promedio);
            }
        }
    }
    fclose(f);

    /* -------------------------------------------------------
     * 6. fseek y ftell — posicionamiento en archivo
     * ------------------------------------------------------- */
    printf("\n=== FSEEK / FTELL ===\n");

    f = fopen(ARCHIVO_TEXTO, "r");
    if (f) {
        /* Ir al final para conocer el tamaño */
        fseek(f, 0, SEEK_END);
        long tamaño = ftell(f);
        printf("Tamano via ftell: %ld bytes\n", tamaño);

        /* Volver al inicio */
        rewind(f);
        fgets(linea, sizeof(linea), f);
        printf("Primera linea: %s", linea);

        fclose(f);
    }

    /* -------------------------------------------------------
     * 7. Limpiar — eliminar el archivo temporal
     * ------------------------------------------------------- */
    if (remove(ARCHIVO_TEXTO) == 0) {
        printf("\nArchivo temporal '%s' eliminado.\n", ARCHIVO_TEXTO);
    }

    return 0;
}


/*
 * escribirArchivo — Crea y escribe un archivo de texto con datos de alumnos.
 * Recibe: ruta — ruta del archivo a crear
 * Nota: sobreescribe si ya existe (modo "w")
 */
void escribirArchivo(const char *ruta) {
    FILE *f = fopen(ruta, "w");
    if (f == NULL) {
        perror("Error al crear archivo");
        return;
    }

    /* Escribir encabezado como comentario */
    fprintf(f, "# Registro de alumnos: id,nombre,edad,promedio\n");

    /* Escribir datos CSV */
    fprintf(f, "1,Juan Perez,20,8.5\n");
    fprintf(f, "2,Laura Sanchez,22,9.1\n");
    fprintf(f, "3,Miguel Torres,19,7.8\n");
    fprintf(f, "4,Sofia Ramirez,21,9.5\n");

    fclose(f);
}

/*
 * leerArchivo — Lee e imprime el contenido completo de un archivo.
 * Recibe: ruta — ruta del archivo a leer
 */
void leerArchivo(const char *ruta) {
    FILE *f = fopen(ruta, "r");
    if (f == NULL) {
        perror("Error al leer archivo");
        return;
    }

    char linea[256];
    int nLinea = 1;
    while (fgets(linea, sizeof(linea), f) != NULL) {
        printf("  [%2d] %s", nLinea++, linea);
    }

    fclose(f);
}

/*
 * agregarLinea — Agrega una línea al final de un archivo existente.
 * Recibe: ruta — ruta del archivo, linea — texto a agregar
 */
void agregarLinea(const char *ruta, const char *linea) {
    FILE *f = fopen(ruta, "a");   /* modo append: agrega sin borrar */
    if (f == NULL) {
        perror("Error al abrir en modo append");
        return;
    }
    fprintf(f, "%s\n", linea);
    fclose(f);
}

/*
 * obtenerTamano — Devuelve el tamaño en bytes de un archivo.
 * Recibe: ruta — ruta del archivo
 * Retorna: tamaño en bytes, o -1 si no se puede abrir
 */
long obtenerTamano(const char *ruta) {
    FILE *f = fopen(ruta, "r");
    if (f == NULL) return -1;
    fseek(f, 0, SEEK_END);
    long tamaño = ftell(f);
    fclose(f);
    return tamaño;
}

/*
 * contarLineas — Cuenta cuántas líneas tiene un archivo.
 * Recibe: ruta — ruta del archivo
 * Retorna: número de líneas (contando '\n')
 */
int contarLineas(const char *ruta) {
    FILE *f = fopen(ruta, "r");
    if (f == NULL) return -1;

    int count = 0;
    char linea[512];
    while (fgets(linea, sizeof(linea), f) != NULL) {
        count++;
    }
    fclose(f);
    return count;
}
