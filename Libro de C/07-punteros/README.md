# Capítulo 07 — Punteros

Los punteros son una de las ideas más poderosas de C y también una de las que más respeto merecen.
Permiten trabajar con direcciones de memoria de forma directa. Gracias a ellos existen muchas de
las capacidades que hacen a C tan rápido y flexible, pero también gran parte de sus errores más
peligrosos.

## Qué aprenderás aquí

- Qué es una dirección de memoria
- Qué almacena realmente un puntero
- Cómo usar `&` y `*`
- Qué relación hay entre punteros y arreglos
- Qué errores causan fallos como `segmentation fault`

## Qué está pasando dentro del software y del hardware

Cada variable vive en una dirección de memoria. Un puntero guarda esa dirección. Cuando
desreferencias un puntero con `*`, le dices al programa: "ve a esa dirección y trabaja con el
valor que está ahí".

Esto significa que el programa deja de operar solo con copias y comienza a manipular datos
reales en memoria. Por eso los punteros son esenciales para estructuras dinámicas, paso eficiente
de datos, manejo de archivos, librerías del sistema y trabajo cercano al hardware.

## Ideas clave del capítulo

### 1. Obtener una dirección con `&`

```c
int edad = 25;
int *puntero = &edad;
```

`puntero` no guarda `25`. Guarda la dirección donde está `edad`.

### 2. Acceder al valor con `*`

```c
printf("%d\n", *puntero);
```

Aquí el programa va a la dirección guardada y obtiene el valor real.

### 3. Modificar una variable a través del puntero

```c
*puntero = 30;
```

Eso cambia el contenido de `edad` sin usar directamente su nombre.

### 4. Punteros y arreglos

El nombre de un arreglo se comporta como una referencia al primer elemento:

```c
int numeros[] = {10, 20, 30};
int *p = numeros;
```

Por eso `numeros[1]` y `*(numeros + 1)` apuntan al mismo dato.

### 5. Puntero nulo

```c
int *p = NULL;
```

`NULL` indica que no hay una dirección válida. Antes de usar un puntero, conviene comprobar si no
es nulo.

### 6. Aritmética de punteros

Si sumas `1` a un puntero a `int`, no avanza 1 byte sino `sizeof(int)` bytes. El compilador ajusta
el salto según el tipo.

## Dónde aparecen en la vida real

- Parámetros que deben modificar datos originales
- Arreglos y strings
- Memoria dinámica con `malloc`
- Librerías del sistema
- Acceso a buffers, archivos y estructuras complejas

## Errores comunes

- Desreferenciar `NULL`
- Usar punteros sin inicializar
- Seguir usando un puntero después de liberar la memoria
- Escribir fuera de los límites de un bloque apuntado
- Confundir el valor guardado con la dirección guardada

## Cómo estudiar este capítulo

1. Dibuja variables y direcciones en papel.
2. Imprime tanto la dirección como el valor.
3. Practica con arreglos pequeños y recórrelos con punteros.
4. No intentes memorizar: entiende qué dirección apunta a qué dato.
5. Si algo falla, revisa primero si el puntero tiene un valor válido.

## Archivos de este capítulo

| Archivo | Descripción |
|---------|-------------|
| `01_punteros.c` | Ejemplos guiados de direcciones, desreferenciación y relación con arreglos |

## Conexión con el siguiente capítulo

Ahora que entiendes cómo referirte a datos en memoria, el siguiente paso es agrupar datos
relacionados dentro de estructuras más expresivas usando `struct`, `union` y `enum`.
