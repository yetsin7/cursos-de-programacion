/*
 * Capítulo 10 — Memoria Dinámica
 * Archivo: 01_malloc_free.c
 *
 * Demuestra el uso de memoria dinámica en C:
 *   - malloc — asignar memoria sin inicializar
 *   - calloc — asignar memoria inicializada en cero
 *   - realloc — redimensionar bloques de memoria
 *   - free — liberar memoria (obligatorio para evitar leaks)
 *   - Arreglo dinámico que crece automáticamente
 *   - Lista dinámica de strings
 *
 * Compilar: gcc -Wall -std=c11 -o malloc_free 01_malloc_free.c
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Estructura de un arreglo dinámico que puede crecer */
typedef struct {
    int   *datos;      /* puntero al bloque de memoria dinámica */
    int    tamaño;     /* número de elementos actuales */
    int    capacidad;  /* capacidad total reservada */
} ArregloDinamico;

/* Prototipos */
ArregloDinamico *crearArreglo(int capacidadInicial);
void agregarElemento(ArregloDinamico *arr, int valor);
void imprimirArreglo(const ArregloDinamico *arr);
void liberarArreglo(ArregloDinamico *arr);

int main(void) {

    /* -------------------------------------------------------
     * 1. malloc — asignar memoria para N enteros
     * ------------------------------------------------------- */
    printf("=== MALLOC ===\n");

    int n = 5;
    int *arr = malloc(n * sizeof(int));   /* reservar espacio para 5 int */

    if (arr == NULL) {
        fprintf(stderr, "Error: no se pudo asignar memoria\n");
        return 1;
    }

    /* malloc NO inicializa — la memoria contiene valores basura */
    /* Hay que llenarla manualmente */
    for (int i = 0; i < n; i++) {
        arr[i] = (i + 1) * 10;
    }

    printf("Arreglo con malloc: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    free(arr);          /* liberar siempre */
    arr = NULL;         /* buena práctica: evitar dangling pointer */

    /* -------------------------------------------------------
     * 2. calloc — asignar memoria inicializada en cero
     * ------------------------------------------------------- */
    printf("\n=== CALLOC ===\n");

    int m = 8;
    int *zeros = calloc(m, sizeof(int));   /* calloc(cantidad, tamaño_por_elemento) */

    if (zeros == NULL) {
        fprintf(stderr, "Error: calloc falló\n");
        return 1;
    }

    printf("Arreglo calloc (todos cero): ");
    for (int i = 0; i < m; i++) {
        printf("%d ", zeros[i]);
    }
    printf("\n");

    free(zeros);
    zeros = NULL;

    /* -------------------------------------------------------
     * 3. realloc — redimensionar un bloque de memoria
     * ------------------------------------------------------- */
    printf("\n=== REALLOC ===\n");

    int *dinamico = malloc(3 * sizeof(int));
    if (!dinamico) return 1;

    dinamico[0] = 10;
    dinamico[1] = 20;
    dinamico[2] = 30;
    printf("Antes del realloc (3 elementos): ");
    for (int i = 0; i < 3; i++) printf("%d ", dinamico[i]);
    printf("\n");

    /* Ampliar a 6 elementos — los 3 primeros se conservan */
    int *temp = realloc(dinamico, 6 * sizeof(int));
    if (temp == NULL) {
        /* realloc falló — dinamico sigue siendo válido */
        free(dinamico);
        fprintf(stderr, "Error: realloc falló\n");
        return 1;
    }
    dinamico = temp;   /* actualizar puntero solo si tuvo éxito */

    dinamico[3] = 40;
    dinamico[4] = 50;
    dinamico[5] = 60;
    printf("Despues del realloc (6 elementos): ");
    for (int i = 0; i < 6; i++) printf("%d ", dinamico[i]);
    printf("\n");

    free(dinamico);
    dinamico = NULL;

    /* -------------------------------------------------------
     * 4. Strings dinámicos — duplicar y manipular strings
     * ------------------------------------------------------- */
    printf("\n=== STRINGS DINAMICOS ===\n");

    const char *original = "Hola, mundo dinamico!";
    size_t longitud = strlen(original) + 1;   /* +1 para el '\0' */

    char *copia = malloc(longitud * sizeof(char));
    if (!copia) return 1;

    strcpy(copia, original);
    printf("Copia: \"%s\"\n", copia);

    /* Concatenar dinámicamente */
    const char *extra = " ¡C es poderoso!";
    size_t nuevaLong = strlen(copia) + strlen(extra) + 1;

    char *concatenado = realloc(copia, nuevaLong);
    if (!concatenado) {
        free(copia);
        return 1;
    }
    copia = concatenado;
    strcat(copia, extra);
    printf("Concatenado: \"%s\"\n", copia);

    free(copia);
    copia = NULL;

    /* -------------------------------------------------------
     * 5. Arreglo dinámico que crece automáticamente
     * ------------------------------------------------------- */
    printf("\n=== ARREGLO DINAMICO AUTO-CRECIENTE ===\n");

    ArregloDinamico *lista = crearArreglo(4);

    for (int i = 1; i <= 10; i++) {
        agregarElemento(lista, i * i);   /* agregar cuadrados: 1, 4, 9, ... */
        printf("  Agregado %2d | tamaño=%d | capacidad=%d\n",
               i * i, lista->tamaño, lista->capacidad);
    }

    printf("\nArreglo final: ");
    imprimirArreglo(lista);

    liberarArreglo(lista);
    printf("Memoria liberada correctamente.\n");

    return 0;
}


/*
 * crearArreglo — Crea un arreglo dinámico con capacidad inicial.
 * Recibe: capacidadInicial — cuántos elementos reservar al inicio
 * Retorna: puntero al ArregloDinamico creado, o NULL si falla
 */
ArregloDinamico *crearArreglo(int capacidadInicial) {
    ArregloDinamico *arr = malloc(sizeof(ArregloDinamico));
    if (!arr) return NULL;

    arr->datos = malloc(capacidadInicial * sizeof(int));
    if (!arr->datos) {
        free(arr);
        return NULL;
    }

    arr->tamaño    = 0;
    arr->capacidad = capacidadInicial;
    return arr;
}

/*
 * agregarElemento — Agrega un valor al arreglo, duplicando capacidad si es necesario.
 * Recibe: arr — el arreglo dinámico, valor — el entero a agregar
 */
void agregarElemento(ArregloDinamico *arr, int valor) {
    /* Si el arreglo está lleno, duplicar la capacidad */
    if (arr->tamaño >= arr->capacidad) {
        int nuevaCapacidad = arr->capacidad * 2;
        int *temp = realloc(arr->datos, nuevaCapacidad * sizeof(int));
        if (!temp) {
            fprintf(stderr, "Error: no se pudo expandir el arreglo\n");
            return;
        }
        arr->datos     = temp;
        arr->capacidad = nuevaCapacidad;
    }
    arr->datos[arr->tamaño++] = valor;
}

/*
 * imprimirArreglo — Imprime todos los elementos del arreglo dinámico.
 */
void imprimirArreglo(const ArregloDinamico *arr) {
    printf("[");
    for (int i = 0; i < arr->tamaño; i++) {
        printf("%d", arr->datos[i]);
        if (i < arr->tamaño - 1) printf(", ");
    }
    printf("]\n");
}

/*
 * liberarArreglo — Libera toda la memoria del arreglo dinámico.
 * Siempre llamar esta función al terminar de usar el arreglo.
 */
void liberarArreglo(ArregloDinamico *arr) {
    if (arr) {
        free(arr->datos);
        free(arr);
    }
}
