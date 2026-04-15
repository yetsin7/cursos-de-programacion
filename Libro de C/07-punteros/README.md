# Capítulo 07 — Punteros

## ¿Qué es un puntero?

Un puntero es una variable que almacena una **dirección de memoria** en lugar de un valor directo.
Es el concepto más importante (y más mal entendido) de C.

```
int x = 42;
         ┌──────────────┐
         │ dirección:   │   0x7ffd1234
         │ valor: 42    │
         └──────────────┘
              ↑
int *p = &x;  │ p almacena 0x7ffd1234
```

---

## Los dos operadores fundamentales

| Operador | Nombre          | Qué hace                                    |
|----------|-----------------|---------------------------------------------|
| `&`      | Address-of      | Obtiene la dirección de memoria de una variable |
| `*`      | Dereference     | Accede al valor en la dirección apuntada    |

```c
int x = 42;
int *p = &x;     /* p contiene la dirección de x */

printf("%p\n", (void*)p);   /* imprime la dirección: 0x7ffd1234 */
printf("%d\n", *p);         /* imprime el valor: 42 */

*p = 100;                   /* modifica x a través del puntero */
printf("%d\n", x);          /* imprime 100 */
```

---

## Tipos de punteros

```c
int   *pi;    /* puntero a int */
char  *pc;    /* puntero a char (= string) */
float *pf;    /* puntero a float */
void  *pv;    /* puntero genérico — no tiene tipo específico */
int  **ppi;   /* puntero a puntero a int */
```

---

## Puntero nulo

```c
int *p = NULL;   /* puntero que no apunta a nada válido */

if (p != NULL) {
    *p = 5;   /* seguro — solo acceder si no es NULL */
}
```

> Nunca desreferenciar un puntero NULL — causa **segmentation fault**.

---

## Aritmética de punteros

Al sumar `n` a un puntero, avanza `n * sizeof(tipo)` bytes en memoria.

```c
int arr[] = {10, 20, 30, 40, 50};
int *p = arr;          /* apunta al primer elemento (arr[0]) */

printf("%d\n", *p);    /* 10 */
p++;                   /* avanza sizeof(int) bytes = 4 bytes */
printf("%d\n", *p);    /* 20 */
printf("%d\n", *(p+2));/* 40 — dos posiciones adelante */
```

---

## Punteros y arreglos

En C, el nombre de un arreglo **es** un puntero al primer elemento:

```c
int arr[] = {1, 2, 3};

/* Estas dos expresiones son equivalentes */
printf("%d\n", arr[1]);    /* notación de arreglo */
printf("%d\n", *(arr+1));  /* notación de puntero */
```

---

## Punteros a funciones

Un puntero puede apuntar a una función, permitiendo pasarlas como argumentos.

```c
/* Declarar un puntero a función que toma dos int y devuelve int */
int (*operacion)(int, int);

int sumar(int a, int b) { return a + b; }
int restar(int a, int b) { return a - b; }

operacion = sumar;
printf("%d\n", operacion(3, 4));   /* 7 */

operacion = restar;
printf("%d\n", operacion(3, 4));   /* -1 */
```

---

## Errores comunes con punteros

| Error                         | Consecuencia                    |
|-------------------------------|---------------------------------|
| Desreferenciar NULL           | Segmentation fault              |
| Puntero sin inicializar       | Comportamiento indefinido       |
| Buffer overflow con punteros  | Corrupción de memoria           |
| Double free                   | Crash o vulnerabilidad          |
| Dangling pointer (puntero colgante) | Apunta a memoria liberada  |

---

## Archivos de este capítulo

| Archivo          | Descripción                                         |
|------------------|-----------------------------------------------------|
| `01_punteros.c`  | Ejemplos paso a paso de punteros en C               |

---

## Siguiente capítulo

→ **Capítulo 08:** Structs
