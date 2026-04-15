/*
 * Capítulo 03 — Operadores
 * Archivo: 01_operadores.c
 *
 * Demuestra todos los tipos de operadores en C:
 *   - Aritméticos: +, -, *, /, %
 *   - Asignación compuesta: +=, -=, *=, /=, %=
 *   - Incremento/decremento: ++, --
 *   - Comparación: ==, !=, >, <, >=, <=
 *   - Lógicos: &&, ||, !
 *   - Bitwise: &, |, ^, ~, <<, >>
 *   - Ternario: condicion ? a : b
 *
 * Compilar: gcc -Wall -std=c11 -o operadores 01_operadores.c
 */

#include <stdio.h>
#include <stdbool.h>

int main(void) {

    /* -------------------------------------------------------
     * 1. Operadores aritméticos
     * ------------------------------------------------------- */
    printf("=== ARITMETICOS ===\n");

    int a = 10, b = 3;

    printf("%d + %d = %d\n", a, b, a + b);   /* suma */
    printf("%d - %d = %d\n", a, b, a - b);   /* resta */
    printf("%d * %d = %d\n", a, b, a * b);   /* multiplicación */
    printf("%d / %d = %d\n", a, b, a / b);   /* división entera (resultado: 3, no 3.33) */
    printf("%d %% %d = %d\n", a, b, a % b);  /* módulo: el resto de la división */

    /* División con punto flotante — cast explícito */
    printf("(double)%d / %d = %.4f\n", a, b, (double)a / b);

    /* -------------------------------------------------------
     * 2. Asignación compuesta
     * ------------------------------------------------------- */
    printf("\n=== ASIGNACION COMPUESTA ===\n");

    int x = 10;
    printf("x inicial = %d\n", x);
    x += 5;  printf("x += 5  => %d\n", x);
    x -= 3;  printf("x -= 3  => %d\n", x);
    x *= 2;  printf("x *= 2  => %d\n", x);
    x /= 4;  printf("x /= 4  => %d\n", x);
    x %= 3;  printf("x %%= 3  => %d\n", x);

    /* -------------------------------------------------------
     * 3. Incremento y decremento
     * ------------------------------------------------------- */
    printf("\n=== INCREMENTO / DECREMENTO ===\n");

    int n = 5;

    /* Post-incremento: devuelve el valor ANTES de incrementar */
    printf("n = %d, n++ = %d, luego n = %d\n", n, n++, n);

    /* Pre-incremento: incrementa PRIMERO y luego devuelve el nuevo valor */
    printf("n = %d, ++n = %d\n", n, ++n);

    /* Post-decremento */
    printf("n = %d, n-- = %d, luego n = %d\n", n, n--, n);

    /* -------------------------------------------------------
     * 4. Operadores de comparación
     * ------------------------------------------------------- */
    printf("\n=== COMPARACION ===\n");

    int p = 7, q = 10;

    /* Los operadores de comparación devuelven 1 (true) o 0 (false) */
    printf("%d == %d  => %d\n", p, q, p == q);
    printf("%d != %d  => %d\n", p, q, p != q);
    printf("%d >  %d  => %d\n", p, q, p > q);
    printf("%d <  %d  => %d\n", p, q, p < q);
    printf("%d >= %d  => %d\n", p, q, p >= q);
    printf("%d <= %d  => %d\n", p, q, p <= q);

    /* -------------------------------------------------------
     * 5. Operadores lógicos
     * ------------------------------------------------------- */
    printf("\n=== LOGICOS ===\n");

    bool llueve = true;
    bool tengoParaguas = false;
    bool mesMojo = !tengoParaguas && llueve;  /* true AND true */

    printf("llueve          = %d\n", llueve);
    printf("tengo paraguas  = %d\n", tengoParaguas);
    printf("me mojo (&&)    = %d\n", mesMojo);
    printf("puedo salir (||)= %d\n", !llueve || tengoParaguas);
    printf("NO llueve (!)   = %d\n", !llueve);

    /* -------------------------------------------------------
     * 6. Operadores bitwise (a nivel de bits)
     * ------------------------------------------------------- */
    printf("\n=== BITWISE ===\n");

    unsigned char byte1 = 0b10110101;  /* 181 en decimal */
    unsigned char byte2 = 0b11001100;  /* 204 en decimal */

    /* AND bit a bit: solo 1 si AMBOS bits son 1 */
    printf("AND (&): %d & %d = %d\n", byte1, byte2, byte1 & byte2);

    /* OR bit a bit: 1 si AL MENOS UN bit es 1 */
    printf("OR  (|): %d | %d = %d\n", byte1, byte2, byte1 | byte2);

    /* XOR bit a bit: 1 solo si los bits son DIFERENTES */
    printf("XOR (^): %d ^ %d = %d\n", byte1, byte2, byte1 ^ byte2);

    /* NOT bit a bit: invierte todos los bits */
    printf("NOT (~): ~%d = %u\n", byte1, (unsigned char)(~byte1));

    /* Desplazamiento a la izquierda: multiplicar por 2^n */
    printf("SHIFT IZQ (<<): 1 << 4 = %d  (2^4 = 16)\n", 1 << 4);

    /* Desplazamiento a la derecha: dividir entre 2^n */
    printf("SHIFT DER (>>): 64 >> 2 = %d  (64/4 = 16)\n", 64 >> 2);

    /* Ejemplo práctico: usar bits como flags */
    printf("\n--- Flags con bits ---\n");
    unsigned char permisos = 0b00000000;
    permisos |= (1 << 0);  /* activar bit 0 = permiso lectura */
    permisos |= (1 << 1);  /* activar bit 1 = permiso escritura */
    printf("Permisos activos: %u (lectura=%d, escritura=%d)\n",
           permisos,
           (permisos >> 0) & 1,  /* extraer bit 0 */
           (permisos >> 1) & 1); /* extraer bit 1 */

    /* -------------------------------------------------------
     * 7. Operador ternario
     * ------------------------------------------------------- */
    printf("\n=== TERNARIO ===\n");

    int edad = 20;
    /* Sintaxis: condicion ? valor_si_true : valor_si_false */
    const char *estado = (edad >= 18) ? "mayor de edad" : "menor de edad";
    printf("Con %d anios eres %s\n", edad, estado);

    int c = 15, d = 9;
    int maximo = (c > d) ? c : d;
    int minimo = (c < d) ? c : d;
    printf("max(%d, %d) = %d\n", c, d, maximo);
    printf("min(%d, %d) = %d\n", c, d, minimo);

    return 0;
}
