/*
 * Capítulo 02 — Variables y Tipos de Datos
 * Archivo: 01_tipos_de_datos.c
 *
 * Demuestra todos los tipos primitivos de C:
 *   - Enteros: char, short, int, long, long long (con y sin signo)
 *   - Flotantes: float, double
 *   - Carácter: char
 *   - Booleano: bool (stdbool.h, C99)
 *   - Uso de sizeof para ver tamaño en bytes
 *   - Especificadores de formato en printf
 *
 * Compilar: gcc -Wall -std=c11 -o tipos 01_tipos_de_datos.c
 */

#include <stdio.h>
#include <stdbool.h>   /* necesario para usar bool, true, false en C99/C11 */
#include <limits.h>    /* contiene INT_MAX, CHAR_MAX, etc. */
#include <float.h>     /* contiene FLT_MAX, DBL_MAX, etc. */

int main(void) {

    /* -------------------------------------------------------
     * 1. Tipos enteros
     * ------------------------------------------------------- */
    printf("=== TIPOS ENTEROS ===\n");

    char letra = 'A';              /* 1 byte — también usado como entero pequeño */
    short contador = 1000;         /* 2 bytes — entero pequeño */
    int edad = 30;                 /* 4 bytes — entero más común */
    long poblacion = 8000000000L;  /* 4 u 8 bytes según plataforma */
    long long estrellasViaLactea = 300000000000LL; /* 8 bytes — entero muy grande */

    /* %c para char como carácter, %d para char como número */
    printf("char   'A' = %c  (valor numerico ASCII: %d)\n", letra, letra);
    printf("short  = %d\n", contador);
    printf("int    = %d\n", edad);
    printf("long   = %ld\n", poblacion);
    printf("long long = %lld\n", estrellasViaLactea);

    /* -------------------------------------------------------
     * 2. Enteros sin signo (unsigned) — solo valores positivos
     * ------------------------------------------------------- */
    printf("\n=== ENTEROS SIN SIGNO ===\n");

    unsigned char byte = 255;           /* 0 a 255 */
    unsigned int habitantes = 3000000u;
    unsigned long long bytesEnTB = 1099511627776ULL; /* 1 terabyte en bytes */

    printf("unsigned char  = %u\n", byte);
    printf("unsigned int   = %u\n", habitantes);
    printf("unsigned long long = %llu\n", bytesEnTB);

    /* -------------------------------------------------------
     * 3. Tipos de punto flotante
     * ------------------------------------------------------- */
    printf("\n=== TIPOS FLOTANTES ===\n");

    float temperatura = 36.6f;          /* la 'f' es obligatoria para float */
    double pi = 3.14159265358979323846;
    double precio = 1299.99;

    /* %f para float/double — por defecto muestra 6 decimales */
    printf("float  temperatura = %f\n", temperatura);
    /* %.10f muestra 10 decimales */
    printf("double pi          = %.10f\n", pi);
    /* %.2f muestra exactamente 2 decimales (ideal para precios) */
    printf("double precio      = $%.2f\n", precio);

    /* -------------------------------------------------------
     * 4. Booleano (C99 con stdbool.h)
     * ------------------------------------------------------- */
    printf("\n=== BOOLEANO ===\n");

    bool esMayor = true;
    bool tieneDeuda = false;

    /* No hay especificador %b nativo — se imprime como entero: 1 o 0 */
    printf("esMayor   = %d  (%s)\n", esMayor,   esMayor   ? "verdadero" : "falso");
    printf("tieneDeuda = %d  (%s)\n", tieneDeuda, tieneDeuda ? "verdadero" : "falso");

    /* -------------------------------------------------------
     * 5. sizeof — tamaño en bytes de cada tipo
     * ------------------------------------------------------- */
    printf("\n=== SIZEOF (tamano en bytes) ===\n");

    /* sizeof retorna un valor de tipo size_t — usar %zu para imprimirlo */
    printf("sizeof(char)      = %zu byte(s)\n", sizeof(char));
    printf("sizeof(short)     = %zu byte(s)\n", sizeof(short));
    printf("sizeof(int)       = %zu byte(s)\n", sizeof(int));
    printf("sizeof(long)      = %zu byte(s)\n", sizeof(long));
    printf("sizeof(long long) = %zu byte(s)\n", sizeof(long long));
    printf("sizeof(float)     = %zu byte(s)\n", sizeof(float));
    printf("sizeof(double)    = %zu byte(s)\n", sizeof(double));
    printf("sizeof(bool)      = %zu byte(s)\n", sizeof(bool));

    /* -------------------------------------------------------
     * 6. Rangos de los tipos (desde limits.h y float.h)
     * ------------------------------------------------------- */
    printf("\n=== RANGOS MAXIMOS ===\n");

    printf("INT_MAX  (maximo de int)    = %d\n",  INT_MAX);
    printf("INT_MIN  (minimo de int)    = %d\n",  INT_MIN);
    printf("UINT_MAX (maximo unsigned)  = %u\n",  UINT_MAX);
    printf("FLT_MAX  (maximo float)     = %e\n",  FLT_MAX);  /* %e = notación científica */
    printf("DBL_MAX  (maximo double)    = %e\n",  DBL_MAX);

    /* -------------------------------------------------------
     * 7. Conversión de tipos (casting)
     * ------------------------------------------------------- */
    printf("\n=== CONVERSION DE TIPOS ===\n");

    int numerador = 7;
    int denominador = 2;

    /* División entera — descarta el decimal */
    int divEntera = numerador / denominador;
    printf("7 / 2 (entera)  = %d\n", divEntera);

    /* Cast explícito a double antes de dividir */
    double divDecimal = (double)numerador / denominador;
    printf("7 / 2 (decimal) = %.1f\n", divDecimal);

    /* Conversión de char a int y viceversa */
    char c = 'Z';
    int codigoAscii = (int)c;
    printf("'Z' como entero = %d\n", codigoAscii);

    char desdeCodigo = (char)65;
    printf("65 como char    = %c\n", desdeCodigo);

    return 0;
}
