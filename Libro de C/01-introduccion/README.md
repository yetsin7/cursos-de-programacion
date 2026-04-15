# Capítulo 01 — Introducción a C

## ¿Qué es C?

C es un lenguaje de programación de propósito general creado por **Dennis Ritchie** en los
Laboratorios Bell entre 1969 y 1973. Fue diseñado para reescribir el sistema operativo UNIX,
y desde entonces se convirtió en la base de casi toda la computación moderna.

Es un lenguaje **compilado**, **de tipado estático** y **de bajo nivel** (aunque de alto nivel
comparado con ensamblador). Esto significa que tienes control directo sobre la memoria y el
hardware.

---

## Breve historia

| Año  | Hito                                                              |
|------|-------------------------------------------------------------------|
| 1969 | Dennis Ritchie crea C en los Labs de AT&T/Bell                    |
| 1972 | C se usa para reescribir UNIX                                     |
| 1978 | Brian Kernighan y Ritchie publican "The C Programming Language"   |
| 1989 | ANSI estandariza C → **C89/C90**                                  |
| 1999 | Nueva versión → **C99** (agrega bool, `//` comentarios, etc.)     |
| 2011 | **C11** — mejoras de concurrencia y genéricos                     |
| 2018 | **C17/C18** — correcciones menores                                |
| 2023 | **C23** — la versión más reciente                                 |

---

## ¿Por qué aprender C hoy?

1. **Entiende cómo funciona la computadora de verdad** — memoria, registros, pila, heap
2. **Base para C++, Rust, Go, Zig** — todos tomaron ideas de C
3. **Sistemas operativos, drivers, embebidos** — escritos en C
4. **SQLite, Python, Git, Linux** — su núcleo está en C
5. **Rendimiento máximo** — cuando importa la velocidad, C gana

---

## Tu primer programa en C

Todo programa en C comienza con una función `main()`. Esta es la función que el sistema operativo
llama al ejecutar el programa.

```c
#include <stdio.h>

int main(void) {
    printf("Hola, mundo!\n");
    return 0;
}
```

### Desglose línea por línea

| Línea                 | Significado                                                  |
|-----------------------|--------------------------------------------------------------|
| `#include <stdio.h>`  | Incluye funciones de entrada/salida estándar (printf, scanf) |
| `int main(void)`      | Función principal; devuelve un entero; no recibe argumentos  |
| `printf(...)`         | Imprime texto en la consola                                  |
| `\n`                  | Salto de línea (newline)                                     |
| `return 0;`           | Indica que el programa terminó sin errores                   |

---

## Cómo compilar con GCC

```bash
# Compilar
gcc -o hola_mundo 01_hola_mundo.c

# Ejecutar
./hola_mundo        # Linux/macOS
hola_mundo.exe      # Windows
```

Con advertencias (siempre recomendado):

```bash
gcc -Wall -Wextra -std=c11 -o hola_mundo 01_hola_mundo.c
```

| Flag       | Significado                          |
|------------|--------------------------------------|
| `-Wall`    | Activa la mayoría de advertencias    |
| `-Wextra`  | Advertencias adicionales             |
| `-std=c11` | Usa el estándar C11                  |
| `-o nombre`| Nombre del archivo de salida         |

---

## Archivos de este capítulo

| Archivo             | Descripción                                      |
|---------------------|--------------------------------------------------|
| `01_hola_mundo.c`   | Hola mundo + variables básicas + printf          |

---

## Siguiente capítulo

→ **Capítulo 02:** Variables y tipos de datos
