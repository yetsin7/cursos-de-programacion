# Capítulo 06 — Arreglos y Strings

En cuanto un programa necesita manejar varios valores relacionados, una sola variable ya no basta.
Los arreglos permiten guardar muchos datos del mismo tipo, y los strings permiten representar
texto. En C ambos temas son especialmente importantes porque el lenguaje no esconde cómo se
almacenan realmente en memoria.

## Qué aprenderás aquí

- Qué es un arreglo y cómo se organiza en memoria
- Cómo recorrer arreglos de una y dos dimensiones
- Qué es realmente un string en C
- Cómo usar funciones comunes de `string.h`
- Qué riesgos existen al manipular texto sin cuidado

## Qué está pasando dentro del software y del hardware

Un arreglo ocupa una región continua de memoria. Eso significa que sus elementos están uno al lado
del otro. La CPU puede calcular la posición de cada elemento usando la dirección base y el tamaño
del tipo almacenado.

Un string en C no es un tipo mágico. Es un arreglo de `char` terminado en `'\0'`, un byte especial
que indica dónde termina el texto. Si ese byte falta o se sobrescribe, el programa puede leer más
allá de lo debido y producir errores graves.

## Ideas clave del capítulo

### 1. Arreglos

```c
int numeros[5] = {10, 20, 30, 40, 50};
```

Cada posición se accede por índice, empezando en `0`.

```c
printf("%d\n", numeros[2]);  /* 30 */
```

### 2. Arreglos multidimensionales

```c
int matriz[2][3] = {
    {1, 2, 3},
    {4, 5, 6}
};
```

Son útiles para tablas, rejillas, tableros y datos con filas y columnas.

### 3. Arreglos y funciones

Cuando envías un arreglo a una función, realmente se pasa una dirección al primer elemento. Por
eso la función puede modificar el contenido original.

### 4. Strings

```c
char saludo[] = "Hola";
```

En memoria eso equivale a:

```c
{'H', 'o', 'l', 'a', '\0'}
```

### 5. Funciones frecuentes de `string.h`

- `strlen` para medir longitud
- `strcmp` para comparar
- `strncpy` para copiar con límite
- `strncat` para concatenar con límite
- `strchr` y `strstr` para buscar
- `snprintf` para construir texto con más seguridad

## Riesgos importantes

C no revisa automáticamente si un índice está dentro de rango. Si escribes `numeros[10]` en un
arreglo de 5 elementos, puedes corromper memoria ajena.

Con strings ocurre algo similar: copiar más caracteres de los que caben en un buffer puede causar
buffer overflow, uno de los problemas clásicos de seguridad en software hecho en C.

## Errores comunes

- Olvidar que los índices comienzan en `0`
- Leer o escribir fuera del tamaño del arreglo
- Usar `strcpy` sin comprobar si el destino tiene espacio suficiente
- Creer que un string es un objeto especial y no un arreglo de `char`
- Confundir longitud visible con tamaño reservado en memoria

## Cómo estudiar este capítulo

1. Recorre arreglos con `for` e imprime índice y valor.
2. Modifica un arreglo dentro de una función y observa el cambio.
3. Crea strings cortos y mide su longitud con `strlen`.
4. Haz pruebas con buffers de distintos tamaños.
5. Piensa siempre cuántos bytes necesitas, no solo cuántas letras ves.

## Archivos de este capítulo

| Archivo | Descripción |
|---------|-------------|
| `01_arreglos.c` | Arreglos de una y dos dimensiones, recorridos y ejercicios prácticos |
| `02_strings.c` | Cadenas, funciones de `string.h` y manipulación segura de texto |

## Conexión con el siguiente capítulo

Este capítulo te acerca mucho al corazón de C. El siguiente paso es entender explícitamente las
direcciones de memoria mediante punteros.
