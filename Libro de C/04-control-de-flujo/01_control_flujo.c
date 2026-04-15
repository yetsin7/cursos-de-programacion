/*
 * Capítulo 04 — Control de Flujo
 * Archivo: 01_control_flujo.c
 *
 * Demuestra todas las estructuras de control en C:
 *   - if / else if / else
 *   - switch / case / default
 *   - for
 *   - while
 *   - do-while
 *   - break y continue
 *
 * Compilar: gcc -Wall -std=c11 -o control 01_control_flujo.c
 */

#include <stdio.h>
#include <stdbool.h>

int main(void) {

    /* -------------------------------------------------------
     * 1. if / else if / else
     * ------------------------------------------------------- */
    printf("=== IF / ELSE ===\n");

    int nota = 75;

    if (nota >= 90) {
        printf("Calificacion: A (Excelente)\n");
    } else if (nota >= 80) {
        printf("Calificacion: B (Muy bien)\n");
    } else if (nota >= 70) {
        printf("Calificacion: C (Bien)\n");
    } else if (nota >= 60) {
        printf("Calificacion: D (Suficiente)\n");
    } else {
        printf("Calificacion: F (Reprobado)\n");
    }

    /* Condicional con variable booleana */
    bool esPar = (nota % 2 == 0);
    printf("El numero %d es %s\n", nota, esPar ? "par" : "impar");

    /* -------------------------------------------------------
     * 2. switch / case
     * ------------------------------------------------------- */
    printf("\n=== SWITCH ===\n");

    int diaSemana = 3;  /* 1=Lunes, 2=Martes, etc. */

    switch (diaSemana) {
        case 1:
            printf("Lunes\n");
            break;
        case 2:
            printf("Martes\n");
            break;
        case 3:
            printf("Miercoles\n");
            break;
        case 4:
            printf("Jueves\n");
            break;
        case 5:
            printf("Viernes\n");
            break;
        case 6:
        case 7:
            /* fall-through intencional: ambos casos comparten el mismo bloque */
            printf("Fin de semana\n");
            break;
        default:
            printf("Dia invalido\n");
    }

    /* Switch con char */
    char operacion = '+';
    int x = 8, y = 3;

    switch (operacion) {
        case '+': printf("%d + %d = %d\n", x, y, x + y); break;
        case '-': printf("%d - %d = %d\n", x, y, x - y); break;
        case '*': printf("%d * %d = %d\n", x, y, x * y); break;
        case '/': printf("%d / %d = %d\n", x, y, x / y); break;
        default:  printf("Operacion desconocida: %c\n", operacion);
    }

    /* -------------------------------------------------------
     * 3. Bucle for
     * ------------------------------------------------------- */
    printf("\n=== FOR ===\n");

    /* Contar del 1 al 5 */
    printf("Conteo: ");
    for (int i = 1; i <= 5; i++) {
        printf("%d ", i);
    }
    printf("\n");

    /* Tabla de multiplicar del 7 */
    printf("Tabla del 7:\n");
    for (int i = 1; i <= 10; i++) {
        printf("  7 x %2d = %2d\n", i, 7 * i);
    }

    /* for con decremento */
    printf("Cuenta regresiva: ");
    for (int i = 5; i >= 1; i--) {
        printf("%d ", i);
    }
    printf("¡Despegue!\n");

    /* -------------------------------------------------------
     * 4. Bucle while
     * ------------------------------------------------------- */
    printf("\n=== WHILE ===\n");

    /* Calcular la suma 1+2+3+...+100 */
    int suma = 0;
    int n = 1;
    while (n <= 100) {
        suma += n;
        n++;
    }
    printf("Suma de 1 a 100 = %d\n", suma);

    /* Encontrar la primera potencia de 2 mayor a 1000 */
    int potencia = 1;
    while (potencia <= 1000) {
        potencia *= 2;
    }
    printf("Primera potencia de 2 mayor a 1000: %d\n", potencia);

    /* -------------------------------------------------------
     * 5. Bucle do-while
     * ------------------------------------------------------- */
    printf("\n=== DO-WHILE ===\n");

    /* do-while garantiza que el cuerpo se ejecuta al menos una vez */
    int contador = 1;
    do {
        printf("Iteracion %d del do-while\n", contador);
        contador++;
    } while (contador <= 3);

    /* -------------------------------------------------------
     * 6. break y continue
     * ------------------------------------------------------- */
    printf("\n=== BREAK Y CONTINUE ===\n");

    /* break: salir del bucle cuando se encuentra el primer múltiplo de 7 */
    printf("Buscando el primer multiplo de 7 entre 1 y 100: ");
    for (int i = 1; i <= 100; i++) {
        if (i % 7 == 0) {
            printf("%d\n", i);
            break;  /* salimos del bucle inmediatamente */
        }
    }

    /* continue: imprimir solo los números impares del 1 al 15 */
    printf("Impares del 1 al 15: ");
    for (int i = 1; i <= 15; i++) {
        if (i % 2 == 0) continue;  /* salta los pares */
        printf("%d ", i);
    }
    printf("\n");

    /* Bucles anidados con break */
    printf("Tabla de multiplicar 3x3:\n");
    for (int i = 1; i <= 3; i++) {
        for (int j = 1; j <= 3; j++) {
            printf("%d*%d=%d  ", i, j, i * j);
        }
        printf("\n");
    }

    return 0;
}
