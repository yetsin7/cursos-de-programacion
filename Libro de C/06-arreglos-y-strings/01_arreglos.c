/*
 * Capítulo 06 — Arreglos y Strings
 * Archivo: 01_arreglos.c
 *
 * Demuestra el uso de arreglos en C:
 *   - Arreglos unidimensionales (declaración, acceso, recorrido)
 *   - Arreglos bidimensionales (matrices)
 *   - Pasar arreglos a funciones
 *   - Algoritmo de ordenamiento burbuja
 *
 * Compilar: gcc -Wall -std=c11 -o arreglos 01_arreglos.c
 */

#include <stdio.h>

/* Prototipos de funciones auxiliares */
void imprimirArreglo(const int arr[], int tamano);
void ordenarBurbuja(int arr[], int tamano);
int buscarLineal(const int arr[], int tamano, int objetivo);
void imprimirMatriz(int filas, int cols, int mat[filas][cols]);

int main(void) {

    /* -------------------------------------------------------
     * 1. Arreglo unidimensional básico
     * ------------------------------------------------------- */
    printf("=== ARREGLO UNIDIMENSIONAL ===\n");

    int temperaturas[7] = {22, 19, 25, 28, 21, 18, 24};
    int numDias = 7;

    printf("Temperaturas de la semana:\n");
    for (int i = 0; i < numDias; i++) {
        printf("  Dia %d: %d°C\n", i + 1, temperaturas[i]);
    }

    /* Calcular el promedio usando el arreglo */
    int suma = 0;
    for (int i = 0; i < numDias; i++) {
        suma += temperaturas[i];
    }
    printf("Promedio: %.1f°C\n", (double)suma / numDias);

    /* -------------------------------------------------------
     * 2. Encontrar máximo y mínimo
     * ------------------------------------------------------- */
    printf("\n=== MAXIMO Y MINIMO ===\n");

    int maximo = temperaturas[0];
    int minimo = temperaturas[0];

    for (int i = 1; i < numDias; i++) {
        if (temperaturas[i] > maximo) maximo = temperaturas[i];
        if (temperaturas[i] < minimo) minimo = temperaturas[i];
    }

    printf("Temperatura maxima: %d°C\n", maximo);
    printf("Temperatura minima: %d°C\n", minimo);

    /* -------------------------------------------------------
     * 3. Ordenamiento burbuja
     * ------------------------------------------------------- */
    printf("\n=== ORDENAMIENTO BURBUJA ===\n");

    int numeros[] = {64, 34, 25, 12, 22, 11, 90};
    int n = 7;

    printf("Antes de ordenar: ");
    imprimirArreglo(numeros, n);

    ordenarBurbuja(numeros, n);

    printf("Despues de ordenar: ");
    imprimirArreglo(numeros, n);

    /* -------------------------------------------------------
     * 4. Búsqueda lineal
     * ------------------------------------------------------- */
    printf("\n=== BUSQUEDA LINEAL ===\n");

    int objetivo = 25;
    int posicion = buscarLineal(numeros, n, objetivo);

    if (posicion >= 0) {
        printf("Numero %d encontrado en posicion %d\n", objetivo, posicion);
    } else {
        printf("Numero %d no encontrado\n", objetivo);
    }

    /* -------------------------------------------------------
     * 5. Arreglo bidimensional (matriz)
     * ------------------------------------------------------- */
    printf("\n=== MATRIZ 3x4 ===\n");

    int matriz[3][4] = {
        {1,  2,  3,  4},
        {5,  6,  7,  8},
        {9, 10, 11, 12}
    };

    imprimirMatriz(3, 4, matriz);

    /* Sumar todos los elementos de la matriz */
    int total = 0;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 4; j++) {
            total += matriz[i][j];
        }
    }
    printf("Suma de todos los elementos: %d\n", total);

    /* -------------------------------------------------------
     * 6. Inicializar arreglo con todos en cero
     * ------------------------------------------------------- */
    printf("\n=== INICIALIZACION EN CERO ===\n");

    /* {0} inicializa el primer elemento en 0 y el resto también en 0 */
    int ceros[10] = {0};
    printf("Arreglo de ceros: ");
    imprimirArreglo(ceros, 10);

    return 0;
}


/*
 * imprimirArreglo — Imprime los elementos de un arreglo entero en una línea.
 * Recibe: arr — puntero al primer elemento, tamano — cantidad de elementos
 */
void imprimirArreglo(const int arr[], int tamano) {
    printf("[");
    for (int i = 0; i < tamano; i++) {
        printf("%d", arr[i]);
        if (i < tamano - 1) printf(", ");
    }
    printf("]\n");
}

/*
 * ordenarBurbuja — Ordena un arreglo de enteros en orden ascendente.
 * Algoritmo: compara pares adyacentes e intercambia si están fuera de orden.
 * Complejidad: O(n^2) — adecuado para arreglos pequeños.
 * Recibe: arr — el arreglo a ordenar, tamano — número de elementos
 */
void ordenarBurbuja(int arr[], int tamano) {
    for (int i = 0; i < tamano - 1; i++) {
        for (int j = 0; j < tamano - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                /* intercambiar elementos */
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}

/*
 * buscarLineal — Busca un valor en el arreglo elemento por elemento.
 * Recibe: arr — arreglo, tamano — cantidad de elementos, objetivo — valor a buscar
 * Retorna: índice del elemento si se encuentra, -1 si no está
 */
int buscarLineal(const int arr[], int tamano, int objetivo) {
    for (int i = 0; i < tamano; i++) {
        if (arr[i] == objetivo) return i;
    }
    return -1;
}

/*
 * imprimirMatriz — Imprime una matriz bidimensional con formato tabular.
 * Recibe: filas y cols — dimensiones, mat — la matriz
 */
void imprimirMatriz(int filas, int cols, int mat[filas][cols]) {
    for (int i = 0; i < filas; i++) {
        printf("  [ ");
        for (int j = 0; j < cols; j++) {
            printf("%3d ", mat[i][j]);
        }
        printf("]\n");
    }
}
