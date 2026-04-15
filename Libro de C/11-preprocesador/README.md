# Capítulo 11 — El Preprocesador de C

## ¿Qué es el preprocesador?

El preprocesador es una herramienta que procesa el código fuente **antes** de que el compilador
lo vea. Realiza sustituciones de texto puro — no conoce tipos, funciones ni variables de C.

Las directivas del preprocesador comienzan con `#`.

---

## #include — Incluir archivos

```c
#include <stdio.h>       /* archivo del sistema — busca en directorios del sistema */
#include "mi_modulo.h"   /* archivo local — busca primero en el directorio actual */
```

---

## #define — Constantes y macros

### Constante simple

```c
#define PI 3.14159265358979
#define MAX_NOMBRE 50
#define VERSION "1.0.0"
```

### Macro con parámetros

```c
/* Macro que calcula el cuadrado de x */
#define CUADRADO(x)   ((x) * (x))

/* Macro para el valor absoluto */
#define ABS(x)        ((x) >= 0 ? (x) : -(x))

/* Macro para el máximo */
#define MAX(a, b)     ((a) > (b) ? (a) : (b))
```

> ⚠️ Siempre rodear los parámetros de macros con paréntesis para evitar problemas de precedencia:
> `CUADRADO(2+3)` → sin paréntesis: `2+3 * 2+3 = 11` (incorrecto)
> con paréntesis: `(2+3) * (2+3) = 25` (correcto)

### Macro multilínea

```c
#define IMPRIMIR_INFO(nombre, valor) \
    do { \
        printf("[INFO] %s = %d\n", (nombre), (valor)); \
    } while(0)
```

> El `do { ... } while(0)` es una técnica estándar para crear macros que se comporten
> correctamente como sentencias.

---

## #undef — Eliminar una definición

```c
#define MODO_DEBUG 1
/* ... usar MODO_DEBUG ... */
#undef MODO_DEBUG    /* a partir de aquí, MODO_DEBUG ya no existe */
```

---

## Compilación condicional

### #ifdef / #ifndef

```c
#ifdef MODO_DEBUG
    printf("DEBUG: valor = %d\n", x);
#endif

/* ifndef = "si NO está definido" */
#ifndef MAX_SIZE
    #define MAX_SIZE 100
#endif
```

### #if / #elif / #else

```c
#if VERSION_MAYOR >= 2
    printf("Versión 2 o superior\n");
#elif VERSION_MAYOR == 1
    printf("Versión 1\n");
#else
    printf("Versión desconocida\n");
#endif
```

---

## Include Guards — evitar inclusión doble

En archivos `.h` siempre se usan guardas de inclusión:

```c
/* archivo: mi_libreria.h */
#ifndef MI_LIBRERIA_H
#define MI_LIBRERIA_H

/* contenido del header */
void miFuncion(void);

#endif /* MI_LIBRERIA_H */
```

Alternativa moderna (no estándar pero ampliamente soportada):

```c
#pragma once
```

---

## Macros predefinidas por el compilador

| Macro          | Descripción                             |
|----------------|-----------------------------------------|
| `__FILE__`     | Nombre del archivo fuente               |
| `__LINE__`     | Número de línea actual                  |
| `__DATE__`     | Fecha de compilación                    |
| `__TIME__`     | Hora de compilación                     |
| `__func__`     | Nombre de la función actual (C99)       |

```c
printf("Error en %s, linea %d\n", __FILE__, __LINE__);
```

---

## Archivos de este capítulo

| Archivo              | Descripción                                      |
|----------------------|--------------------------------------------------|
| `01_preprocesador.c` | Ejemplos prácticos de todas las directivas       |

---

## Siguiente capítulo

→ **Capítulo 12:** Proyecto Biblia — SQLite3 en C
