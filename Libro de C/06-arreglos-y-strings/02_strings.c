/*
 * Capítulo 06 — Arreglos y Strings
 * Archivo: 02_strings.c
 *
 * Demuestra el manejo de strings (cadenas de texto) en C:
 *   - Declaración de strings con char[]
 *   - Recorrer un string carácter por carácter
 *   - Funciones de string.h: strlen, strcpy, strcat, strcmp, strchr, strstr
 *   - Convertir entre mayúsculas y minúsculas
 *   - Invertir un string
 *
 * Compilar: gcc -Wall -std=c11 -o strings 02_strings.c
 */

#include <stdio.h>
#include <string.h>    /* strlen, strcpy, strcat, strcmp, etc. */
#include <ctype.h>     /* toupper, tolower, isalpha, isdigit, etc. */

/* Prototipos */
void invertirString(char *s);
int contarPalabras(const char *s);
void aMayusculas(char *s);
void aMinusculas(char *s);

int main(void) {

    /* -------------------------------------------------------
     * 1. Declaración de strings
     * ------------------------------------------------------- */
    printf("=== DECLARACION DE STRINGS ===\n");

    /* String literal — el compilador agrega '\0' automáticamente */
    char saludo[] = "Hola, mundo!";

    /* String con espacio reservado */
    char nombre[50] = "Carlos";

    /* String vacío */
    char vacio[100] = "";

    printf("saludo: \"%s\"\n", saludo);
    printf("nombre: \"%s\"\n", nombre);
    printf("vacio:  \"%s\"\n", vacio);

    /* -------------------------------------------------------
     * 2. strlen — longitud del string (sin el '\0')
     * ------------------------------------------------------- */
    printf("\n=== STRLEN ===\n");

    printf("strlen(\"%s\") = %zu\n", saludo, strlen(saludo));
    printf("strlen(\"%s\") = %zu\n", nombre, strlen(nombre));

    /* sizeof incluye el '\0', strlen no */
    printf("sizeof(\"%s\") = %zu (incluye el nulo)\n", nombre, sizeof(nombre));

    /* -------------------------------------------------------
     * 3. strcpy / strncpy — copiar strings
     * ------------------------------------------------------- */
    printf("\n=== STRCPY / STRNCPY ===\n");

    char destino[50];

    /* strcpy copia src en dest (incluyendo '\0') */
    strcpy(destino, "Libro de C");
    printf("strcpy: \"%s\"\n", destino);

    /* strncpy es más seguro: copia máximo n caracteres */
    strncpy(destino, "Aprendiendo C desde cero", sizeof(destino) - 1);
    destino[sizeof(destino) - 1] = '\0';  /* garantizar terminación */
    printf("strncpy: \"%s\"\n", destino);

    /* -------------------------------------------------------
     * 4. strcat / strncat — concatenar strings
     * ------------------------------------------------------- */
    printf("\n=== STRCAT ===\n");

    char frase[100] = "Hola";
    strcat(frase, ", ");
    strcat(frase, "mundo");
    strcat(frase, "!");
    printf("Concatenado: \"%s\"\n", frase);

    /* -------------------------------------------------------
     * 5. strcmp — comparar strings (sensible a mayúsculas)
     * ------------------------------------------------------- */
    printf("\n=== STRCMP ===\n");

    const char *s1 = "manzana";
    const char *s2 = "naranja";
    const char *s3 = "manzana";

    /* strcmp retorna 0 si son iguales, <0 si s1 < s2, >0 si s1 > s2 */
    printf("strcmp(\"%s\", \"%s\") = %d\n", s1, s2, strcmp(s1, s2));
    printf("strcmp(\"%s\", \"%s\") = %d (iguales)\n", s1, s3, strcmp(s1, s3));

    /* Forma correcta de comparar strings (NUNCA usar s1 == s2 para strings) */
    if (strcmp(s1, s3) == 0) {
        printf("Los strings son iguales\n");
    }

    /* -------------------------------------------------------
     * 6. strchr y strstr — buscar dentro de strings
     * ------------------------------------------------------- */
    printf("\n=== BUSQUEDA EN STRINGS ===\n");

    const char *texto = "El lenguaje C fue creado por Dennis Ritchie";

    /* strchr: busca la primera ocurrencia de un carácter */
    char *pos = strchr(texto, 'C');
    if (pos) {
        printf("Primera 'C' encontrada en posicion %ld: \"%s\"\n",
               pos - texto, pos);
    }

    /* strstr: busca la primera ocurrencia de un substring */
    char *sub = strstr(texto, "Dennis");
    if (sub) {
        printf("Substring 'Dennis' encontrado: \"%s\"\n", sub);
    }

    /* -------------------------------------------------------
     * 7. Recorrer un string carácter por carácter
     * ------------------------------------------------------- */
    printf("\n=== RECORRER CARACTER A CARACTER ===\n");

    const char *palabra = "PROGRAMACION";
    printf("Caracteres de \"%s\":\n", palabra);
    for (int i = 0; palabra[i] != '\0'; i++) {
        printf("  [%d] = '%c' (ASCII %d)\n", i, palabra[i], (int)palabra[i]);
    }

    /* -------------------------------------------------------
     * 8. Conversión de mayúsculas/minúsculas
     * ------------------------------------------------------- */
    printf("\n=== MAYUSCULAS / MINUSCULAS ===\n");

    char texto2[] = "Hola Mundo desde C";
    printf("Original:   \"%s\"\n", texto2);

    aMayusculas(texto2);
    printf("Mayusculas: \"%s\"\n", texto2);

    aMinusculas(texto2);
    printf("Minusculas: \"%s\"\n", texto2);

    /* -------------------------------------------------------
     * 9. Invertir un string
     * ------------------------------------------------------- */
    printf("\n=== INVERTIR STRING ===\n");

    char frase2[] = "radar";
    printf("Original:  \"%s\"\n", frase2);
    invertirString(frase2);
    printf("Invertido: \"%s\"\n", frase2);

    /* Verificar si es palíndromo */
    char prueba[] = "anilina";
    char copia[50];
    strcpy(copia, prueba);
    invertirString(copia);
    if (strcmp(prueba, copia) == 0) {
        printf("\"%s\" es palindromo\n", prueba);
    }

    /* -------------------------------------------------------
     * 10. Contar palabras
     * ------------------------------------------------------- */
    printf("\n=== CONTAR PALABRAS ===\n");

    const char *oracion = "El cielo es azul y el mar tambien";
    printf("\"%s\"\nPalabras: %d\n", oracion, contarPalabras(oracion));

    return 0;
}


/*
 * invertirString — Invierte un string in-place.
 * Recibe: s — puntero al string a invertir
 * Modifica el string original sin crear uno nuevo.
 */
void invertirString(char *s) {
    int izq = 0;
    int der = (int)strlen(s) - 1;
    while (izq < der) {
        char temp = s[izq];
        s[izq] = s[der];
        s[der] = temp;
        izq++;
        der--;
    }
}

/*
 * contarPalabras — Cuenta palabras separadas por espacios.
 * Recibe: s — string de entrada
 * Retorna: número de palabras encontradas
 */
int contarPalabras(const char *s) {
    int count = 0;
    int dentroDepalabra = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] != ' ' && !dentroDepalabra) {
            dentroDepalabra = 1;
            count++;
        } else if (s[i] == ' ') {
            dentroDepalabra = 0;
        }
    }
    return count;
}

/*
 * aMayusculas — Convierte todos los caracteres del string a mayúsculas.
 * Recibe: s — puntero al string (se modifica in-place)
 */
void aMayusculas(char *s) {
    for (int i = 0; s[i] != '\0'; i++) {
        s[i] = (char)toupper((unsigned char)s[i]);
    }
}

/*
 * aMinusculas — Convierte todos los caracteres del string a minúsculas.
 * Recibe: s — puntero al string (se modifica in-place)
 */
void aMinusculas(char *s) {
    for (int i = 0; s[i] != '\0'; i++) {
        s[i] = (char)tolower((unsigned char)s[i]);
    }
}
