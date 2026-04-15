# Capítulo 02 — Variables y Tipos de Datos

## ¿Qué es una variable?

Una variable es un espacio con nombre en la memoria del computador que almacena un valor.
En C debes declarar el **tipo** de dato antes de usarla — el compilador reserva exactamente
la cantidad de bytes necesaria.

```c
int edad = 25;       /* reserva 4 bytes para un entero */
double precio = 9.99; /* reserva 8 bytes para un decimal */
```

---

## Tipos primitivos en C

### Enteros

| Tipo             | Tamaño típico | Rango aproximado                         |
|------------------|---------------|------------------------------------------|
| `char`           | 1 byte        | -128 a 127 (o 0 a 255 si unsigned)       |
| `short`          | 2 bytes       | -32,768 a 32,767                         |
| `int`            | 4 bytes       | -2,147,483,648 a 2,147,483,647           |
| `long`           | 4 u 8 bytes   | Depende de la plataforma                 |
| `long long`      | 8 bytes       | ±9.2 × 10¹⁸                             |

Todos pueden ser `unsigned` para eliminar el signo y duplicar el rango positivo:

```c
unsigned int positivo = 4000000000u;
```

### Punto flotante

| Tipo        | Tamaño  | Precisión          |
|-------------|---------|--------------------|
| `float`     | 4 bytes | ~6-7 dígitos       |
| `double`    | 8 bytes | ~15-16 dígitos     |
| `long double`| 12-16 bytes | aún más precisión |

### Carácter

```c
char letra = 'A';   /* almacena el código ASCII de 'A' = 65 */
```

### Booleano (C99 en adelante)

```c
#include <stdbool.h>

bool activo = true;
bool inactivo = false;
```

> En C clásico (C89), no existe `bool`. Se usa `int` donde 0 = falso, distinto de 0 = verdadero.

---

## El operador `sizeof`

`sizeof` devuelve el tamaño en bytes de un tipo o variable. Es muy útil para entender cuánta
memoria usa cada tipo en tu plataforma.

```c
printf("int ocupa %zu bytes\n", sizeof(int));
printf("double ocupa %zu bytes\n", sizeof(double));
```

> Usa `%zu` para imprimir valores de tipo `size_t` (lo que devuelve `sizeof`).

---

## Especificadores de formato para printf/scanf

| Tipo         | printf/scanf |
|--------------|--------------|
| `int`        | `%d` o `%i`  |
| `unsigned`   | `%u`         |
| `long`       | `%ld`        |
| `long long`  | `%lld`       |
| `float`      | `%f`         |
| `double`     | `%lf` (scanf), `%f` (printf) |
| `char`       | `%c`         |
| `string`     | `%s`         |
| `size_t`     | `%zu`        |
| `puntero`    | `%p`         |
| hexadecimal  | `%x` o `%X` |

---

## Constantes

```c
/* Con const — el compilador puede detectar modificaciones accidentales */
const double PI = 3.14159265358979;

/* Con #define — sustitución textual en tiempo de compilación */
#define MAX_NOMBRE 50
#define GRAVEDAD 9.81
```

---

## Conversión de tipos (casting)

```c
int a = 7, b = 2;

/* División entera — resultado: 3 (se pierde el .5) */
double resultado = a / b;

/* Cast explícito — resultado: 3.5 */
double correcto = (double)a / b;
```

---

## Archivos de este capítulo

| Archivo               | Descripción                                        |
|-----------------------|----------------------------------------------------|
| `01_tipos_de_datos.c` | Ejemplos de todos los tipos, sizeof, formato printf|

---

## Siguiente capítulo

→ **Capítulo 03:** Operadores
