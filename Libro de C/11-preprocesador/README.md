# Capítulo 11 — El Preprocesador de C

Antes de que el compilador traduzca tu código a lenguaje máquina, el preprocesador realiza una
primera pasada sobre el texto fuente. Sustituye macros, incluye archivos y activa o desactiva
bloques de código según ciertas condiciones. Aunque trabaja "antes" del lenguaje C propiamente
dicho, influye muchísimo en cómo queda el programa final.

## Qué aprenderás aquí

- Qué hace el preprocesador y qué no hace
- Cómo usar `#include`, `#define` y `#undef`
- Qué es la compilación condicional
- Cómo funcionan los include guards
- Por qué una macro puede ser útil o peligrosa

## Qué está pasando dentro del software y del hardware

El preprocesador no entiende tipos, memoria ni lógica del programa. Solo transforma texto según
reglas. Después de esa etapa, el compilador recibe un archivo expandido y recién entonces analiza
sintaxis, tipos y generación de código.

Eso significa que una macro mal escrita puede introducir errores difíciles de ver, porque el
problema nace antes de compilar de verdad.

## Ideas clave del capítulo

### 1. `#include`

```c
#include <stdio.h>
#include "mi_modulo.h"
```

Sirve para insertar el contenido de otro archivo fuente o cabecera.

### 2. `#define`

```c
#define PI 3.1415926535
#define CUADRADO(x) ((x) * (x))
```

Una macro simple reemplaza texto. Una macro con parámetros puede parecer una función, pero no lo
es. Por eso los paréntesis son tan importantes.

### 3. Compilación condicional

```c
#ifdef DEBUG
printf("Valor interno: %d\n", x);
#endif
```

Permite activar o desactivar partes del código según símbolos definidos.

### 4. Include guards

```c
#ifndef MI_ARCHIVO_H
#define MI_ARCHIVO_H

/* contenido */

#endif
```

Evitan que un archivo `.h` se procese varias veces en la misma compilación.

### 5. Macros predefinidas

Macros como `__FILE__`, `__LINE__`, `__DATE__` y `__TIME__` ayudan en depuración y trazas.

## Cuándo esto resulta útil de verdad

- Reutilizar constantes globales
- Compartir declaraciones en headers
- Activar logs de depuración
- Adaptar código a distintas plataformas o configuraciones

## Errores comúnes

- Escribir macros sin paréntesis y obtener resultados inesperados
- Pensar que una macro se comporta exactamente como una función
- Duplicar definiciones por no usar include guards
- Abusar de macros cuando una constante o función sería más clara

## Cómo estudiar este capítulo

1. Escribe macros pequeñas y prueba expresiones complejas.
2. Compara una macro con una función equivalente.
3. Revisa headers reales y observa sus include guards.
4. Usa compilación condicional para mensajes de depuración.
5. Si algo parece inexplicable, recuerda que quizá el problema ocurrió antes de compilar.

## Archivos de este capítulo

| Archivo | Descripción |
|---------|-------------|
| `01_preprocesador.c` | Ejemplos prácticos de inclusión, macros y compilación condicional |

## Conexión con el siguiente capítulo

El siguiente capítulo une varias piezas del libro en un proyecto más real: consultar una base de
datos SQLite desde C.
