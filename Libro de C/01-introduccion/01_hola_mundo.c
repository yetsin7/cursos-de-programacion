/*
 * Capitulo 01 — Introduccion a C
 * Archivo: 01_hola_mundo.c
 *
 * Este programa introduce la estructura minima de C y te ayuda a relacionar
 * el codigo con lo que ocurre realmente en la computadora:
 *   - el compilador traduce tu archivo a lenguaje maquina;
 *   - el sistema operativo carga el ejecutable en memoria;
 *   - la funcion main() es el punto de entrada;
 *   - printf envia salida visible a la consola.
 *
 * Compilar: gcc -Wall -Wextra -std=c11 -o hola_mundo 01_hola_mundo.c
 * Ejecutar: hola_mundo.exe   (Windows)
 *           ./hola_mundo     (Linux/macOS)
 */

/* Incluir la libreria de entrada/salida estandar */
#include <stdio.h>

/*
 * main — Funcion principal del programa.
 * Todo programa C necesita una funcion main().
 * Cuando el sistema operativo inicia el ejecutable, transfiere el control aqui.
 * Retornar 0 significa que el programa termino correctamente.
 */
int main(void) {

    /* -------------------------------------------------------
     * 1. Hola mundo básico
     * ------------------------------------------------------- */

    /* printf envia texto formateado a la salida estandar */
    /* \n representa un salto de linea */
    printf("Hola, mundo!\n");

    /* -------------------------------------------------------
     * 2. Variables básicas
     * ------------------------------------------------------- */

    /* int guarda un numero entero */
    int edad = 25;

    /* float guarda un numero decimal de precision simple */
    float temperatura = 36.6f;   /* la 'f' final indica literal float */

    /* double guarda un decimal con mas precision que float */
    double pi = 3.14159265358979;

    /* char guarda un solo caracter */
    char inicial = 'C';

    /* -------------------------------------------------------
     * 3. Imprimir variables con printf y especificadores de formato
     * ------------------------------------------------------- */

    printf("\n--- Variables basicas ---\n");

    /* %d imprime un entero decimal */
    printf("Edad: %d anios\n", edad);

    /* %f imprime valores decimales */
    printf("Temperatura: %f grados\n", temperatura);

    /* %.2f imprime con exactamente 2 decimales */
    printf("Pi (2 decimales): %.2f\n", pi);

    /* %c imprime un caracter */
    printf("Inicial: %c\n", inicial);

    /* -------------------------------------------------------
     * 4. Constantes con #define
     * ------------------------------------------------------- */

    /* const crea un valor que no deberia cambiar durante la ejecucion */
    const int DIAS_SEMANA = 7;
    printf("Dias en una semana: %d\n", DIAS_SEMANA);

    /* -------------------------------------------------------
     * 5. Operaciones aritméticas simples
     * ------------------------------------------------------- */

    printf("\n--- Operaciones simples ---\n");

    int a = 10;
    int b = 3;

    /* La division entre enteros descarta la parte decimal */
    printf("%d + %d = %d\n", a, b, a + b);
    printf("%d - %d = %d\n", a, b, a - b);
    printf("%d * %d = %d\n", a, b, a * b);
    printf("%d / %d = %d  (division entera)\n", a, b, a / b);
    printf("%d %% %d = %d (modulo/resto)\n", a, b, a % b);  /* %% imprime el signo % literal */

    /* -------------------------------------------------------
     * 6. Cadena de texto (string) básica
     * ------------------------------------------------------- */

    printf("\n--- Cadena de texto ---\n");

    /* En C, un string es un arreglo de char terminado en '\0' */
    char nombre[] = "Estudiante";

    /* %s imprime una cadena de texto */
    printf("Hola, %s! Bienvenido al Libro de C.\n", nombre);

    /* El programa retorna 0 para indicar que termino sin errores */
    return 0;
}
