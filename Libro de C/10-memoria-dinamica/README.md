# Capítulo 10 — Memoria Dinámica

La memoria dinámica permite pedir espacio durante la ejecución del programa, justo cuando se
necesita. Esto hace posible trabajar con tamaños variables, colecciones que crecen y estructuras
más realistas. También exige mucha disciplina, porque el lenguaje no libera esa memoria por ti.

## Qué aprenderás aquí

- Qué diferencia hay entre stack, heap y datos estáticos
- Cómo usar `malloc`, `calloc`, `realloc` y `free`
- Cómo comprobar si una reserva de memoria falló
- Qué son los memory leaks y los dangling pointers
- Cómo pensar la memoria como un recurso que debe administrarse

## Qué está pasando dentro del software y del hardware

La memoria automática de una función vive normalmente en la pila (`stack`) y desaparece sola al
salir de la función. La memoria dinámica vive en el montón (`heap`), una zona gestionada durante
la ejecución para bloques cuyo tamaño o duración no se conoce desde el principio.

Cuando llamas a `malloc`, la biblioteca solicita un bloque al gestor de memoria del sistema. Si ya
no existe memoria disponible suficiente, la función puede devolver `NULL`.

## Ideas clave del capítulo

### 1. `malloc`

```c
int *numeros = malloc(10 * sizeof(int));
```

Reserva memoria, pero no la inicializa.

### 2. `calloc`

```c
int *numeros = calloc(10, sizeof(int));
```

Reserva memoria e inicializa los bytes en cero.

### 3. `realloc`

```c
int *temporal = realloc(numeros, 20 * sizeof(int));
```

Sirve para cambiar el tamaño del bloque. Conviene guardar el resultado en una variable temporal
para no perder la referencia original si falla.

### 4. `free`

```c
free(numeros);
numeros = NULL;
```

Cada bloque reservado debe liberarse exactamente una vez.

## Problemas clásicos

### Memory leak

Pides memoria y nunca la liberas. El programa pierde acceso a ese bloque, pero el sistema sigue
considerándolo ocupado hasta que el proceso termina.

### Dangling pointer

Un puntero sigue apuntando a memoria ya liberada. Si vuelves a usarlo, el comportamiento es
indefinido.

### Double free

Liberas dos veces el mismo bloque. Esto puede causar fallos graves o vulnerabilidades.

## Cómo se conecta con software real

- Listas o buffers cuyo tamaño cambia
- Lectura de archivos grandes
- Estructuras dinámicas como pilas, colas o listas enlazadas
- Procesamiento de texto o datos de tamaño desconocido

## Errores comúnes

- No comprobar si `malloc` o `realloc` devolvieron `NULL`
- Olvidar llamar a `free`
- Usar memoria después de liberarla
- Escribir fuera del tamaño reservado
- Reservar menos bytes de los necesarios por calcular mal `sizeof`

## Cómo estudiar este capítulo

1. Reserva arreglos dinámicos pequeños y llénalos con datos.
2. Redimensiónalos y revisa si el contenido sigue correcto.
3. Libera siempre la memoria al terminar.
4. Imagina que cada `malloc` contrae una deuda que debes pagar con `free`.
5. Si puedes, usa herramientas como Valgrind o AddressSanitizer cuando trabajes fuera de este entorno.

## Archivos de este capítulo

| Archivo | Descripción |
|---------|-------------|
| `01_malloc_free.c` | Ejemplos de reserva, redimensión, liberación y errores frecuentes de memoria |

## Conexión con el siguiente capítulo

Ya entiendes mejor cómo se organiza el programa antes, durante y después de ejecutarse. El
siguiente paso es ver qué ocurre incluso antes de compilar: el trabajo del preprocesador.
