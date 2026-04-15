# Capítulo 06 — Arreglos y Strings

## Arreglos (Arrays)

Un arreglo es una colección de elementos del **mismo tipo** almacenados en posiciones
contiguas de memoria. Se accede a cada elemento mediante su índice (comenzando en 0).

### Declaración e inicialización

```c
/* Declarar con tamaño fijo */
int numeros[5];                /* 5 enteros sin inicializar */
int edades[4] = {25, 30, 18, 45};  /* inicializar con valores */
int dias[] = {1, 2, 3, 4, 5}; /* el compilador deduce el tamaño: 5 */
```

### Acceso a elementos

```c
edades[0] = 25;   /* primer elemento (índice 0) */
edades[3] = 45;   /* cuarto elemento (índice 3) */
printf("%d\n", edades[1]);   /* imprime 30 */
```

> C **no verifica** que el índice esté dentro del rango. Acceder fuera de los límites
> produce **comportamiento indefinido** (uno de los bugs más peligrosos en C).

---

## Arreglos bidimensionales (matrices)

```c
int matriz[3][3] = {
    {1, 2, 3},
    {4, 5, 6},
    {7, 8, 9}
};

/* Acceso: matriz[fila][columna] */
printf("%d\n", matriz[1][2]);  /* fila 1, columna 2 → 6 */
```

---

## Arreglos y funciones

Cuando pasas un arreglo a una función, en realidad pasas un **puntero** al primer elemento.
La función puede modificar el arreglo original.

```c
void llenarCeros(int arr[], int tamano) {
    for (int i = 0; i < tamano; i++) {
        arr[i] = 0;
    }
}
```

---

## Strings (cadenas de texto)

En C, un string es simplemente un **arreglo de char** terminado en el carácter nulo `'\0'`.

```c
char saludo[] = "Hola";
/* en memoria: {'H', 'o', 'l', 'a', '\0'} — 5 bytes */

char nombre[20] = "Carlos";
/* reserva 20 bytes; usa 7 ('C','a','r','l','o','s','\0') */
```

---

## Funciones de string.h

```c
#include <string.h>
```

| Función                      | Descripción                              |
|------------------------------|------------------------------------------|
| `strlen(s)`                  | Longitud del string (sin el `\0`)        |
| `strcpy(dest, src)`          | Copia `src` en `dest`                    |
| `strncpy(dest, src, n)`      | Copia máximo `n` caracteres              |
| `strcat(dest, src)`          | Concatena `src` al final de `dest`       |
| `strncat(dest, src, n)`      | Concatena máximo `n` caracteres          |
| `strcmp(s1, s2)`             | Compara: 0 si iguales, <0 o >0 si no     |
| `strncmp(s1, s2, n)`         | Compara primeros `n` caracteres          |
| `strchr(s, c)`               | Puntero a primera ocurrencia de char `c` |
| `strstr(s, sub)`             | Puntero a primera ocurrencia de `sub`    |
| `sprintf(buf, fmt, ...)`     | Printf a buffer de char                  |

> ⚠️ `strcpy` y `strcat` no comprueban el tamaño del destino — pueden causar **buffer overflow**.
> Preferir `strncpy` y `strncat` o, mejor aún, `snprintf`.

---

## Leer strings con scanf y fgets

```c
char nombre[50];

/* scanf lee hasta el primer espacio */
scanf("%49s", nombre);

/* fgets lee una línea completa (más seguro) */
fgets(nombre, sizeof(nombre), stdin);
```

---

## Archivos de este capítulo

| Archivo          | Descripción                                             |
|------------------|---------------------------------------------------------|
| `01_arreglos.c`  | Arreglos 1D, 2D, ordenamiento burbuja                  |
| `02_strings.c`   | Strings, funciones de string.h, manipulación de texto  |

---

## Siguiente capítulo

→ **Capítulo 07:** Punteros
