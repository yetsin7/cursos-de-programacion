/*
 * Capitulo 02 — Variables y Tipos de Datos
 * Archivo: 01_tipos_de_datos.c
 *
 * Este archivo conecta teoria y realidad:
 *   - muestra como C representa distintos tipos;
 *   - enseña que cada tipo ocupa memoria diferente;
 *   - relaciona datos, bytes y formato de impresion;
 *   - explica por que los cast cambian resultados.
 *
 * Compilar: gcc -Wall -Wextra -std=c11 -o tipos 01_tipos_de_datos.c
 */

#include <stdio.h>
#include <stdbool.h>   /* Permite usar bool, true y false */
#include <limits.h>    /* Define rangos maximos y minimos enteros */
#include <float.h>     /* Define rangos maximos para float y double */

int main(void) {

    /* -------------------------------------------------------
     * 1. Tipos enteros
     * -------------------------------------------------------
     * Estos tipos guardan numeros sin parte decimal.
     */
    printf("=== TIPOS ENTEROS ===\n");

    char letra = 'A';              /* 1 byte; tambien puede representar un numero */
    short contador = 1000;         /* entero pequeño */
    int edad = 30;                 /* entero mas comun */
    long poblacion = 8000000000L;  /* depende de la plataforma */
    long long estrellasViaLactea = 300000000000LL; /* entero grande */

    /* El mismo dato puede verse como letra o como codigo numerico. */
    printf("char   'A' = %c  (valor numerico ASCII: %d)\n", letra, letra);
    printf("short  = %d\n", contador);
    printf("int    = %d\n", edad);
    printf("long   = %ld\n", poblacion);
    printf("long long = %lld\n", estrellasViaLactea);

    /* -------------------------------------------------------
     * 2. Enteros sin signo
     * -------------------------------------------------------
     * unsigned usa el espacio disponible para valores positivos.
     */
    printf("\n=== ENTEROS SIN SIGNO ===\n");

    unsigned char byte = 255;           /* 0 a 255 */
    unsigned int habitantes = 3000000u;
    unsigned long long bytesEnTB = 1099511627776ULL; /* 1 terabyte en bytes */

    printf("unsigned char  = %u\n", byte);
    printf("unsigned int   = %u\n", habitantes);
    printf("unsigned long long = %llu\n", bytesEnTB);

    /* -------------------------------------------------------
     * 3. Tipos de punto flotante
     * -------------------------------------------------------
     * Se usan para decimales. Son utiles, pero no exactos en todos los casos.
     */
    printf("\n=== TIPOS FLOTANTES ===\n");

    float temperatura = 36.6f;          /* la 'f' indica literal float */
    double pi = 3.14159265358979323846;
    double precio = 1299.99;

    /* printf interpreta estos valores como decimales. */
    printf("float  temperatura = %f\n", temperatura);
    printf("double pi          = %.10f\n", pi);
    printf("double precio      = $%.2f\n", precio);

    /* -------------------------------------------------------
     * 4. Booleano
     * -------------------------------------------------------
     * bool mejora la claridad cuando solo existen dos estados.
     */
    printf("\n=== BOOLEANO ===\n");

    bool esMayor = true;
    bool tieneDeuda = false;

    /* No existe %b nativo en printf. bool se imprime como 1 o 0. */
    printf("esMayor   = %d  (%s)\n", esMayor,   esMayor   ? "verdadero" : "falso");
    printf("tieneDeuda = %d  (%s)\n", tieneDeuda, tieneDeuda ? "verdadero" : "falso");

    /* -------------------------------------------------------
     * 5. sizeof
     * -------------------------------------------------------
     * sizeof permite medir cuanta memoria ocupa cada tipo realmente.
     */
    printf("\n=== SIZEOF (tamano en bytes) ===\n");

    /* sizeof devuelve size_t, por eso usamos %zu. */
    printf("sizeof(char)      = %zu byte(s)\n", sizeof(char));
    printf("sizeof(short)     = %zu byte(s)\n", sizeof(short));
    printf("sizeof(int)       = %zu byte(s)\n", sizeof(int));
    printf("sizeof(long)      = %zu byte(s)\n", sizeof(long));
    printf("sizeof(long long) = %zu byte(s)\n", sizeof(long long));
    printf("sizeof(float)     = %zu byte(s)\n", sizeof(float));
    printf("sizeof(double)    = %zu byte(s)\n", sizeof(double));
    printf("sizeof(bool)      = %zu byte(s)\n", sizeof(bool));

    /* -------------------------------------------------------
     * 6. Rangos de los tipos
     * -------------------------------------------------------
     * Estos valores muestran los limites reales del tipo en la plataforma.
     */
    printf("\n=== RANGOS MAXIMOS ===\n");

    printf("INT_MAX  (maximo de int)    = %d\n",  INT_MAX);
    printf("INT_MIN  (minimo de int)    = %d\n",  INT_MIN);
    printf("UINT_MAX (maximo unsigned)  = %u\n",  UINT_MAX);
    printf("FLT_MAX  (maximo float)     = %e\n",  FLT_MAX);
    printf("DBL_MAX  (maximo double)    = %e\n",  DBL_MAX);

    /* -------------------------------------------------------
     * 7. Conversion de tipos
     * -------------------------------------------------------
     * Un cast cambia la forma en que se interpreta o calcula un valor.
     */
    printf("\n=== CONVERSION DE TIPOS ===\n");

    int numerador = 7;
    int denominador = 2;

    /* Sin cast, la division ocurre como entera y corta el decimal. */
    int divEntera = numerador / denominador;
    printf("7 / 2 (entera)  = %d\n", divEntera);

    /* Con cast a double, la operacion conserva la parte decimal. */
    double divDecimal = (double)numerador / denominador;
    printf("7 / 2 (decimal) = %.1f\n", divDecimal);

    /* Un char tambien puede verse como su codigo numerico. */
    char c = 'Z';
    int codigoAscii = (int)c;
    printf("'Z' como entero = %d\n", codigoAscii);

    char desdeCodigo = (char)65;
    printf("65 como char    = %c\n", desdeCodigo);

    printf("\n=== IDEAS CLAVE ===\n");
    printf("Cada tipo ocupa memoria distinta.\n");
    printf("El formato correcto en printf importa.\n");
    printf("Un cast puede cambiar el resultado final.\n");

    return 0;
}
