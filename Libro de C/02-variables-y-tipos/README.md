# Capítulo 02 — Variables y Tipos de Datos

Este capítulo es clave porque en C los tipos no son un detalle menor. Aqui
aprenderas a relacionar datos, memoria y representacion binaria de una forma mas
directa que en muchos otros lenguajes.

---

## ¿Que es una variable en C?

Una variable es un nombre asociado a un espacio de memoria.
En C debes declarar el tipo antes de usarla, y eso le dice al compilador cuanta
memoria reservar y como interpretar los bits guardados ahi.

```c
int edad = 25;
double precio = 9.99;
```

No es lo mismo guardar un entero que un decimal: cambian el tamaño, el rango y
la forma en que la maquina los interpreta.

---

## ¿Que aprenderas?

Al terminar este capítulo deberias entender:

- que es una variable en memoria;
- que diferencia hay entre tipos enteros, flotantes y booleanos;
- por que `sizeof` importa;
- como imprimir cada tipo correctamente;
- cuando una conversion de tipos cambia el resultado.

---

## Tipos primitivos en C

### Enteros

| Tipo | Tamaño tipico | Uso general |
|---|---|---|
| `char` | 1 byte | Carácter o entero pequeño |
| `short` | 2 bytes | Entero pequeño |
| `int` | 4 bytes | Entero mas común |
| `long` | 4 u 8 bytes | Depende de plataforma |
| `long long` | 8 bytes | Enteros grandes |

También pueden ser `unsigned` para usar solo valores positivos.

### Punto flotante

| Tipo | Tamaño | Precision aproximada |
|---|---|---|
| `float` | 4 bytes | 6 a 7 dígitos |
| `double` | 8 bytes | 15 a 16 dígitos |
| `long double` | 12 a 16 bytes | Mas precision |

### Booleano

Desde C99 puedes usar:

```c
#include <stdbool.h>
bool activo = true;
```

---

## ¿Que pasa en la maquina?

Cuando declaras variables:

- el compilador organiza tipos y offsets;
- el programa reserva memoria al ejecutarse;
- cada tipo ocupa bytes concretos;
- `printf` necesita saber como interpretar esos bytes.

Por eso los especificadores de formato no son decoracion: si eliges el incorrecto,
puedes obtener resultados falsos o comportamiento inesperado.

---

## `sizeof` y memoria real

`sizeof` te permite medir cuantos bytes ocupa un tipo o una variable en tu
plataforma actual.

```c
printf("%zu\n", sizeof(int));
```

Esto te ayuda a dejar de pensar en tipos de forma abstracta.

---

## Especificadores de formato

| Tipo | Formato común |
|---|---|
| `int` | `%d` o `%i` |
| `unsigned` | `%u` |
| `long` | `%ld` |
| `long long` | `%lld` |
| `float` | `%f` |
| `double` | `%f` en `printf`, `%lf` en `scanf` |
| `char` | `%c` |
| `size_t` | `%zu` |
| `puntero` | `%p` |

---

## Cast y conversiones

Las conversiones cambian como se interpreta o calcula un valor.

```c
int a = 7, b = 2;
double resultado = (double)a / b;
```

Sin ese cast, la division ocurre como entera y perderias la parte decimal.

---

## Archivos de este capítulo

| Archivo | Descripción |
|---|---|
| `01_tipos_de_datos.c` | Tipos primitivos, `sizeof`, rangos y conversiones |

---

## Errores comúnes

- creer que todos los enteros ocupan siempre lo mismo;
- usar el especificador incorrecto en `printf`;
- pensar que `char` solo sirve para texto;
- olvidar que la division entre enteros recorta el decimal;
- no revisar `sizeof` en la plataforma real.

---

## Practica guiada

1. Ejecuta el archivo y observa tamaños reales.
2. Cambia valores por otros mas grandes.
3. Prueba un cast y luego quitale el cast.
4. Explica por que `char` puede imprimirse como letra y como número.

---

## Siguiente capítulo

→ **Capítulo 03:** Operadores
