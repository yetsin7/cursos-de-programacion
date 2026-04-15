/*
 * Capítulo 07 — Punteros
 * Archivo: 01_punteros.c
 *
 * Demuestra el uso de punteros en C paso a paso:
 *   - Declarar y usar punteros (&, *)
 *   - Puntero nulo (NULL)
 *   - Aritmética de punteros
 *   - Relación entre punteros y arreglos
 *   - Punteros a funciones
 *   - Doble puntero (puntero a puntero)
 *
 * Compilar: gcc -Wall -std=c11 -o punteros 01_punteros.c
 */

#include <stdio.h>
#include <stdlib.h>   /* NULL */

/* Prototipos */
void duplicarConPuntero(int *valor);
void intercambiar(int *a, int *b);
int aplicar(int a, int b, int (*fn)(int, int));
int sumar(int a, int b);
int multiplicar(int a, int b);

int main(void) {

    /* -------------------------------------------------------
     * 1. Declarar y usar punteros
     * ------------------------------------------------------- */
    printf("=== PUNTERO BASICO ===\n");

    int x = 42;
    int *p = &x;     /* p almacena la dirección de x */

    /* %p imprime la dirección de memoria en hexadecimal */
    printf("x        = %d\n", x);
    printf("&x       = %p  (direccion de x)\n", (void*)&x);
    printf("p        = %p  (valor de p = direccion de x)\n", (void*)p);
    printf("*p       = %d  (valor al que apunta p)\n", *p);

    /* Modificar x a través del puntero */
    *p = 100;
    printf("Despues de *p = 100: x = %d\n", x);

    /* -------------------------------------------------------
     * 2. Puntero NULL — puntero que no apunta a nada válido
     * ------------------------------------------------------- */
    printf("\n=== PUNTERO NULL ===\n");

    int *nulo = NULL;
    printf("nulo = %p\n", (void*)nulo);

    /* Siempre verificar antes de desreferenciar */
    if (nulo != NULL) {
        printf("*nulo = %d\n", *nulo);
    } else {
        printf("El puntero es NULL — no se puede desreferenciar\n");
    }

    /* -------------------------------------------------------
     * 3. Paso por referencia — modificar variable desde función
     * ------------------------------------------------------- */
    printf("\n=== PASO POR REFERENCIA ===\n");

    int valor = 7;
    printf("Antes de duplicar: %d\n", valor);
    duplicarConPuntero(&valor);
    printf("Despues de duplicar: %d\n", valor);

    int a = 10, b = 99;
    printf("Antes de intercambiar: a=%d, b=%d\n", a, b);
    intercambiar(&a, &b);
    printf("Despues de intercambiar: a=%d, b=%d\n", a, b);

    /* -------------------------------------------------------
     * 4. Aritmética de punteros
     * ------------------------------------------------------- */
    printf("\n=== ARITMETICA DE PUNTEROS ===\n");

    int arr[] = {10, 20, 30, 40, 50};
    int *ptr = arr;   /* apunta al primer elemento */

    printf("Recorriendo el arreglo con puntero:\n");
    for (int i = 0; i < 5; i++) {
        printf("  ptr+%d = %p → valor = %d\n", i, (void*)(ptr+i), *(ptr+i));
    }

    /* El operador ++ avanza al siguiente elemento del tipo */
    printf("\nUsando ptr++:\n");
    for (int i = 0; i < 5; i++) {
        printf("  *ptr = %d\n", *ptr);
        ptr++;   /* avanza sizeof(int) bytes = 4 bytes */
    }

    /* Diferencia entre punteros da el número de elementos entre ellos */
    int *inicio = arr;
    int *fin    = arr + 4;
    printf("\nDiferencia fin-inicio = %ld elementos\n", fin - inicio);

    /* -------------------------------------------------------
     * 5. Equivalencia entre arreglos y punteros
     * ------------------------------------------------------- */
    printf("\n=== ARREGLOS Y PUNTEROS ===\n");

    int nums[] = {100, 200, 300};
    int *q = nums;

    /* Estas cuatro formas son equivalentes para acceder al elemento i */
    printf("nums[1]      = %d\n", nums[1]);
    printf("*(nums + 1)  = %d\n", *(nums + 1));
    printf("q[1]         = %d\n", q[1]);
    printf("*(q + 1)     = %d\n", *(q + 1));

    /* -------------------------------------------------------
     * 6. Punteros a funciones
     * ------------------------------------------------------- */
    printf("\n=== PUNTEROS A FUNCIONES ===\n");

    /* Declarar un puntero que puede apuntar a función int(int, int) */
    int (*operacion)(int, int);

    operacion = sumar;
    printf("sumar(5, 3)       = %d\n", operacion(5, 3));

    operacion = multiplicar;
    printf("multiplicar(5, 3) = %d\n", operacion(5, 3));

    /* Usar función de orden superior */
    printf("aplicar(sumar, 6, 4)       = %d\n", aplicar(6, 4, sumar));
    printf("aplicar(multiplicar, 6, 4) = %d\n", aplicar(6, 4, multiplicar));

    /* -------------------------------------------------------
     * 7. Doble puntero (puntero a puntero)
     * ------------------------------------------------------- */
    printf("\n=== DOBLE PUNTERO ===\n");

    int n = 55;
    int *p1 = &n;      /* puntero a int */
    int **pp = &p1;    /* puntero a puntero a int */

    printf("n    = %d\n", n);
    printf("*p1  = %d  (mismo que n)\n", *p1);
    printf("**pp = %d  (dos niveles de indirección)\n", **pp);

    /* Modificar n a través del doble puntero */
    **pp = 999;
    printf("Despues de **pp = 999: n = %d\n", n);

    return 0;
}


/*
 * duplicarConPuntero — Duplica el valor de la variable apuntada.
 * Recibe: valor — puntero al entero que se desea duplicar
 */
void duplicarConPuntero(int *valor) {
    *valor = *valor * 2;
}

/*
 * intercambiar — Intercambia los valores de dos variables enteras.
 * Recibe: a, b — punteros a los enteros que se desean intercambiar
 */
void intercambiar(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

/*
 * sumar — Suma dos enteros.
 */
int sumar(int a, int b) {
    return a + b;
}

/*
 * multiplicar — Multiplica dos enteros.
 */
int multiplicar(int a, int b) {
    return a * b;
}

/*
 * aplicar — Función de orden superior: aplica una función dada a dos argumentos.
 * Recibe: a, b — operandos, fn — puntero a la función a aplicar
 * Retorna: el resultado de fn(a, b)
 */
int aplicar(int a, int b, int (*fn)(int, int)) {
    return fn(a, b);
}
