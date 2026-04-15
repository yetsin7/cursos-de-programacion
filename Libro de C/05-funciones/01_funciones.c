/*
 * Capítulo 05 — Funciones
 * Archivo: 01_funciones.c
 *
 * Demuestra el uso de funciones en C:
 *   - Funciones con y sin retorno (void)
 *   - Prototipos
 *   - Paso por valor vs paso por referencia (punteros)
 *   - Recursividad (factorial, Fibonacci)
 *   - Funciones auxiliares reutilizables
 *
 * Compilar: gcc -Wall -std=c11 -o funciones 01_funciones.c
 */

#include <stdio.h>
#include <math.h>   /* para sqrt — compilar con -lm si da error de linkeo */

/* -------------------------------------------------------
 * Prototipos — declaraciones antes de main
 * ------------------------------------------------------- */

/* Suma dos enteros y devuelve el resultado */
int sumar(int a, int b);

/* Saluda a una persona por nombre (no devuelve nada) */
void saludar(const char *nombre);

/* Calcula el área de un triángulo */
double areaTriangulo(double base, double altura);

/* Intercambia dos enteros — necesita punteros para modificar los originales */
void intercambiar(int *a, int *b);

/* Calcula el factorial de n de forma recursiva */
long long factorial(int n);

/* Calcula el n-ésimo número de Fibonacci de forma recursiva */
int fibonacci(int n);

/* Determina si un número es primo */
int esPrimo(int n);

/* Eleva base a la potencia exp (versión propia, sin libmath) */
double potencia(double base, int exp);


/* -------------------------------------------------------
 * Función principal
 * ------------------------------------------------------- */
int main(void) {

    /* 1. Función básica con retorno */
    printf("=== FUNCIONES BASICAS ===\n");
    int resultado = sumar(15, 27);
    printf("sumar(15, 27) = %d\n", resultado);

    /* 2. Función void */
    saludar("Estudiante");

    /* 3. Función con double */
    double area = areaTriangulo(8.0, 5.5);
    printf("Area del triangulo (base=8, altura=5.5) = %.2f\n", area);

    /* 4. Paso por valor: los originales NO cambian */
    printf("\n=== PASO POR VALOR ===\n");
    int x = 10, y = 20;
    printf("Antes: x=%d, y=%d\n", x, y);
    /* Si la función recibiera copias (no punteros), x e y no cambiarían */
    printf("(el valor no cambia porque se pasa copia)\n");

    /* 5. Paso por referencia con punteros: los originales SÍ cambian */
    printf("\n=== PASO POR REFERENCIA ===\n");
    int a = 100, b = 200;
    printf("Antes de intercambiar: a=%d, b=%d\n", a, b);
    intercambiar(&a, &b);  /* & obtiene la dirección de memoria */
    printf("Despues de intercambiar: a=%d, b=%d\n", a, b);

    /* 6. Recursividad: factorial */
    printf("\n=== RECURSIVIDAD — FACTORIAL ===\n");
    for (int i = 0; i <= 10; i++) {
        printf("%2d! = %lld\n", i, factorial(i));
    }

    /* 7. Recursividad: Fibonacci */
    printf("\n=== RECURSIVIDAD — FIBONACCI ===\n");
    printf("Primeros 10 numeros de Fibonacci: ");
    for (int i = 0; i < 10; i++) {
        printf("%d ", fibonacci(i));
    }
    printf("\n");

    /* 8. Función esPrimo */
    printf("\n=== NUMEROS PRIMOS (1-30) ===\n");
    for (int i = 2; i <= 30; i++) {
        if (esPrimo(i)) {
            printf("%d ", i);
        }
    }
    printf("\n");

    /* 9. Función potencia */
    printf("\n=== POTENCIAS ===\n");
    printf("2^10 = %.0f\n", potencia(2.0, 10));
    printf("3^5  = %.0f\n", potencia(3.0, 5));
    printf("5^0  = %.0f\n", potencia(5.0, 0));

    return 0;
}


/* -------------------------------------------------------
 * Implementaciones de las funciones
 * ------------------------------------------------------- */

/*
 * sumar — Suma dos enteros.
 * Recibe: a, b — los dos operandos
 * Retorna: la suma de a y b
 */
int sumar(int a, int b) {
    return a + b;
}

/*
 * saludar — Imprime un saludo personalizado.
 * Recibe: nombre — cadena de texto con el nombre
 * Retorna: nada (void)
 */
void saludar(const char *nombre) {
    printf("Hola, %s! Bienvenido al Libro de C.\n", nombre);
}

/*
 * areaTriangulo — Calcula el area de un triangulo.
 * Recibe: base y altura del triangulo
 * Retorna: el area calculada como double
 */
double areaTriangulo(double base, double altura) {
    return (base * altura) / 2.0;
}

/*
 * intercambiar — Intercambia los valores de dos variables enteras.
 * Recibe: punteros a los dos enteros que se desean intercambiar
 * Retorna: nada, pero modifica los valores originales via punteros
 */
void intercambiar(int *a, int *b) {
    int temporal = *a;   /* guardar el valor de a */
    *a = *b;             /* a toma el valor de b */
    *b = temporal;       /* b toma el valor original de a */
}

/*
 * factorial — Calcula n! de forma recursiva.
 * Recibe: n — número no negativo
 * Retorna: n! como long long (para manejar valores grandes)
 * Caso base: 0! = 1 y 1! = 1
 */
long long factorial(int n) {
    if (n <= 1) return 1;              /* caso base */
    return (long long)n * factorial(n - 1); /* llamada recursiva */
}

/*
 * fibonacci — Devuelve el n-esimo numero de la serie de Fibonacci.
 * Recibe: n — posicion en la serie (0 = primer elemento)
 * Retorna: el numero de Fibonacci correspondiente
 * Nota: esta versión es simple pero ineficiente para n grande (O(2^n))
 */
int fibonacci(int n) {
    if (n <= 0) return 0;   /* caso base: F(0) = 0 */
    if (n == 1) return 1;   /* caso base: F(1) = 1 */
    return fibonacci(n - 1) + fibonacci(n - 2);  /* F(n) = F(n-1) + F(n-2) */
}

/*
 * esPrimo — Determina si un numero entero positivo es primo.
 * Recibe: n — el número a evaluar
 * Retorna: 1 si es primo, 0 si no lo es
 * Algoritmo: prueba divisibilidad hasta la raiz cuadrada de n
 */
int esPrimo(int n) {
    if (n < 2) return 0;
    if (n == 2) return 1;
    if (n % 2 == 0) return 0;   /* eliminar pares rápidamente */
    for (int i = 3; (long long)i * i <= n; i += 2) {
        if (n % i == 0) return 0;
    }
    return 1;
}

/*
 * potencia — Calcula base elevado a exp (exponente entero).
 * Recibe: base — número base (double), exp — exponente (int)
 * Retorna: base^exp como double
 */
double potencia(double base, int exp) {
    if (exp == 0) return 1.0;      /* cualquier número a la 0 = 1 */
    if (exp < 0) return 1.0 / potencia(base, -exp);
    return base * potencia(base, exp - 1);  /* recursividad */
}
