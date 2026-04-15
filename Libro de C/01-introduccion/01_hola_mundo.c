/*
 * Capítulo 01 — Introducción a C
 * Archivo: 01_hola_mundo.c
 *
 * Primer programa en C. Demuestra:
 *   - La estructura básica de un programa C
 *   - Cómo imprimir texto con printf
 *   - Declaración de variables básicas
 *   - Comentarios de una línea y de bloque
 *
 * Compilar: gcc -Wall -o hola_mundo 01_hola_mundo.c
 * Ejecutar: ./hola_mundo
 */

/* Incluir la librería de entrada/salida estándar */
#include <stdio.h>

/*
 * main — Función principal del programa.
 * Todo programa C debe tener exactamente una función main().
 * El sistema operativo la llama al ejecutar el programa.
 * Retorna 0 si todo salió bien, cualquier otro valor indica error.
 */
int main(void) {

    /* -------------------------------------------------------
     * 1. Hola mundo básico
     * ------------------------------------------------------- */

    /* printf imprime texto formateado en la consola */
    /* \n es el carácter de nueva línea (newline) */
    printf("Hola, mundo!\n");

    /* -------------------------------------------------------
     * 2. Variables básicas
     * ------------------------------------------------------- */

    /* int — número entero (típicamente 4 bytes, rango ~-2 mil millones a +2 mil millones) */
    int edad = 25;

    /* float — número de punto flotante de precisión simple (4 bytes) */
    float temperatura = 36.6f;   /* la 'f' al final indica que es float, no double */

    /* double — punto flotante de doble precisión (8 bytes, más exacto que float) */
    double pi = 3.14159265358979;

    /* char — un solo carácter (1 byte) */
    char inicial = 'C';

    /* -------------------------------------------------------
     * 3. Imprimir variables con printf y especificadores de formato
     * ------------------------------------------------------- */

    printf("\n--- Variables basicas ---\n");

    /* %d imprime un entero (decimal) */
    printf("Edad: %d anios\n", edad);

    /* %f imprime un float o double */
    printf("Temperatura: %f grados\n", temperatura);

    /* %.2f imprime con exactamente 2 decimales */
    printf("Pi (2 decimales): %.2f\n", pi);

    /* %c imprime un carácter */
    printf("Inicial: %c\n", inicial);

    /* -------------------------------------------------------
     * 4. Constantes con #define
     * ------------------------------------------------------- */

    /* Las constantes se definen con #define antes de main() normalmente,
     * pero también se puede usar la palabra clave const */
    const int DIAS_SEMANA = 7;
    printf("Dias en una semana: %d\n", DIAS_SEMANA);

    /* -------------------------------------------------------
     * 5. Operaciones aritméticas simples
     * ------------------------------------------------------- */

    printf("\n--- Operaciones simples ---\n");

    int a = 10;
    int b = 3;

    /* División entera: el resultado se trunca (no redondea) */
    printf("%d + %d = %d\n", a, b, a + b);
    printf("%d - %d = %d\n", a, b, a - b);
    printf("%d * %d = %d\n", a, b, a * b);
    printf("%d / %d = %d  (division entera)\n", a, b, a / b);
    printf("%d %% %d = %d (modulo/resto)\n", a, b, a % b);  /* %% imprime el signo % literal */

    /* -------------------------------------------------------
     * 6. Cadena de texto (string) básica
     * ------------------------------------------------------- */

    printf("\n--- Cadena de texto ---\n");

    /* Las cadenas en C son arreglos de char terminados en '\0' (nulo) */
    char nombre[] = "Estudiante";

    /* %s imprime una cadena de texto */
    printf("Hola, %s! Bienvenido al Libro de C.\n", nombre);

    /* El programa retorna 0 para indicar que terminó sin errores */
    return 0;
}
