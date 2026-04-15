# Capítulo 10 — Memoria Dinámica

## Tipos de memoria en C

| Área           | Cuándo se asigna    | Quién la libera         | Tamaño           |
|----------------|---------------------|-------------------------|------------------|
| **Stack**      | Al entrar a función | Automático al salir     | Fijo, limitado   |
| **Heap**       | Con malloc/calloc   | Tú (con free)           | Flexible, grande |
| **Datos (BSS)**| Al iniciar programa | El SO al terminar       | Fijo             |

---

## malloc — Asignar memoria

```c
#include <stdlib.h>

/* Asignar espacio para 10 enteros */
int *arr = malloc(10 * sizeof(int));

if (arr == NULL) {
    /* malloc devuelve NULL si no hay memoria disponible */
    fprintf(stderr, "Error: sin memoria\n");
    exit(1);
}

arr[0] = 42;   /* usar como arreglo normal */
```

> `malloc` **no inicializa** la memoria — puede contener basura.

---

## calloc — Asignar e inicializar a cero

```c
/* Asignar espacio para 10 enteros, inicializados en 0 */
int *arr = calloc(10, sizeof(int));
```

`calloc(n, size)` asigna `n` elementos de `size` bytes cada uno, inicializados a 0.

---

## realloc — Redimensionar memoria

```c
/* Cambiar el tamaño del bloque a 20 enteros */
int *temp = realloc(arr, 20 * sizeof(int));

if (temp == NULL) {
    /* realloc falló — el puntero original sigue siendo válido */
    free(arr);
    exit(1);
}

arr = temp;   /* actualizar el puntero solo si tuvo éxito */
```

> Nunca hacer `arr = realloc(arr, ...)` directamente — si falla, pierdes el puntero original.

---

## free — Liberar memoria

```c
free(arr);
arr = NULL;   /* buena práctica: evitar dangling pointer */
```

> Regla: **cada `malloc`/`calloc`/`realloc` debe tener exactamente un `free`**.

---

## Memory Leaks (fugas de memoria)

Un memory leak ocurre cuando se asigna memoria que nunca se libera.

```c
/* BUG: memory leak — arr nunca se libera */
void funcion_con_leak(void) {
    int *arr = malloc(100 * sizeof(int));
    /* ... usar arr ... */
    /* ¡FALTA free(arr)! */
}
```

---

## Detectar fugas con Valgrind

```bash
# Compilar con información de debug
gcc -g -o programa programa.c

# Ejecutar con Valgrind
valgrind --leak-check=full ./programa
```

Salida de Valgrind sin leaks:
```
All heap blocks were freed -- no leaks are possible
```

---

## AddressSanitizer (más moderno, sin Valgrind)

```bash
gcc -fsanitize=address -g -o programa programa.c
./programa
```

---

## Errores comunes

| Error                | Descripción                                        |
|----------------------|----------------------------------------------------|
| **Memory leak**      | malloc sin free correspondiente                    |
| **Double free**      | Llamar free dos veces al mismo puntero             |
| **Use after free**   | Usar un puntero después de liberarlo               |
| **Dangling pointer** | Puntero que apunta a memoria ya liberada           |
| **Buffer overflow**  | Escribir fuera de los límites asignados            |
| **Null dereference** | Desreferenciar NULL (malloc falló y no se verificó)|

---

## Archivos de este capítulo

| Archivo              | Descripción                                        |
|----------------------|----------------------------------------------------|
| `01_malloc_free.c`   | malloc, calloc, realloc, free, arreglos dinámicos  |

---

## Siguiente capítulo

→ **Capítulo 11:** Preprocesador
