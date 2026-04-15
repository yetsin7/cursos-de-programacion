# Capítulo 05 — Funciones

## ¿Qué es una función?

Una función es un bloque de código reutilizable con un nombre. Recibe datos (parámetros),
realiza una tarea y opcionalmente devuelve un resultado.

Las funciones son el mecanismo principal para:
- **Evitar repetición** de código
- **Dividir** programas complejos en partes manejables
- **Reutilizar** lógica en distintos contextos

---

## Anatomía de una función

```c
/* Prototipo — declara la función antes de usarla */
int sumar(int a, int b);

/* Definición — implementa la función */
int sumar(int a, int b) {
    return a + b;
}

/* Llamada */
int resultado = sumar(3, 4);   /* resultado = 7 */
```

### Partes

| Parte        | Ejemplo         | Descripción                              |
|--------------|-----------------|------------------------------------------|
| Tipo retorno | `int`           | Tipo del valor que devuelve la función   |
| Nombre       | `sumar`         | Identificador de la función              |
| Parámetros   | `(int a, int b)`| Variables que recibe la función          |
| Cuerpo       | `{ return a+b; }`| Código que se ejecuta                   |

### Función sin retorno

```c
void saludar(const char *nombre) {
    printf("Hola, %s!\n", nombre);
    /* no necesita return */
}
```

---

## Prototipos

En C, las funciones deben declararse antes de ser usadas. Si defines la función después de
`main()`, necesitas un **prototipo** antes de `main()`:

```c
#include <stdio.h>

/* Prototipo — solo la firma, sin cuerpo */
double calcularArea(double base, double altura);

int main(void) {
    printf("Area: %.2f\n", calcularArea(5.0, 3.0));
    return 0;
}

/* Definición completa — puede ir después de main */
double calcularArea(double base, double altura) {
    return (base * altura) / 2.0;
}
```

---

## Paso por valor vs paso por referencia

### Por valor (copia)

En C, los argumentos se pasan **por valor** por defecto. La función recibe una copia.

```c
void duplicar(int n) {
    n = n * 2;   /* solo modifica la copia local */
}

int x = 5;
duplicar(x);
printf("%d\n", x);   /* sigue siendo 5 */
```

### Por referencia (puntero)

Para modificar el original, se pasa la **dirección de memoria** (puntero):

```c
void duplicarRef(int *n) {
    *n = *n * 2;   /* modifica el valor en la dirección apuntada */
}

int x = 5;
duplicarRef(&x);   /* & obtiene la dirección de x */
printf("%d\n", x); /* ahora es 10 */
```

---

## Recursividad

Una función puede llamarse a sí misma. Debe tener un **caso base** que detenga la recursión.

```c
/* Factorial: n! = n * (n-1)! — caso base: 0! = 1 */
int factorial(int n) {
    if (n <= 0) return 1;          /* caso base */
    return n * factorial(n - 1);   /* llamada recursiva */
}
```

> La recursividad usa la pila (stack). Demasiadas llamadas recursivas producen **stack overflow**.

---

## Variables locales vs globales

```c
int globalX = 100;   /* variable global — accesible desde cualquier función */

void miFuncion(void) {
    int localY = 50;    /* variable local — solo existe dentro de esta función */
    printf("%d %d\n", globalX, localY);
}
/* localY deja de existir al salir de miFuncion */
```

> Preferir variables locales. Las globales dificultan el mantenimiento.

---

## Funciones inline (C99)

```c
/* inline sugiere al compilador que "pegue" el código en el lugar de la llamada */
static inline int cuadrado(int x) {
    return x * x;
}
```

---

## Archivos de este capítulo

| Archivo          | Descripción                                              |
|------------------|----------------------------------------------------------|
| `01_funciones.c` | Funciones básicas, recursividad, paso por valor/referencia|

---

## Siguiente capítulo

→ **Capítulo 06:** Arreglos y Strings
