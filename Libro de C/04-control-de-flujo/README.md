# Capítulo 04 — Control de Flujo

## ¿Qué es el control de flujo?

Por defecto, C ejecuta las instrucciones de arriba a abajo, línea por línea. Las estructuras de
control permiten tomar decisiones (bifurcaciones) y repetir acciones (bucles).

---

## 1. Condicionales

### if / else if / else

```c
if (condicion) {
    /* se ejecuta si condicion es verdadera (distinto de 0) */
} else if (otra_condicion) {
    /* se ejecuta si la primera fue falsa y esta es verdadera */
} else {
    /* se ejecuta si ninguna condición anterior fue verdadera */
}
```

### switch

Útil cuando tienes múltiples casos para un mismo valor entero o char.

```c
switch (opcion) {
    case 1:
        printf("Elegiste 1\n");
        break;  /* sin break, continúa al siguiente case (fall-through) */
    case 2:
        printf("Elegiste 2\n");
        break;
    default:
        printf("Opción no válida\n");
}
```

> `switch` solo funciona con tipos enteros (`int`, `char`, `enum`). No funciona con `float`,
> `double` ni strings.

---

## 2. Bucles

### for

Ideal cuando sabes de antemano cuántas veces quieres repetir algo.

```c
/* for (inicialización; condición; actualización) */
for (int i = 0; i < 10; i++) {
    printf("%d\n", i);  /* imprime 0, 1, 2, ..., 9 */
}
```

### while

Se ejecuta mientras la condición sea verdadera. Puede no ejecutarse nunca si la condición
es falsa desde el principio.

```c
int i = 0;
while (i < 5) {
    printf("%d\n", i);
    i++;
}
```

### do-while

Como `while`, pero garantiza que el cuerpo se ejecute **al menos una vez**.

```c
int opcion;
do {
    printf("Ingresa un número entre 1 y 5: ");
    scanf("%d", &opcion);
} while (opcion < 1 || opcion > 5);
```

---

## 3. Control dentro de bucles

### break

Sale inmediatamente del bucle o switch más cercano.

```c
for (int i = 0; i < 100; i++) {
    if (i == 5) break;   /* sale del for cuando i llega a 5 */
    printf("%d ", i);    /* imprime: 0 1 2 3 4 */
}
```

### continue

Salta el resto del cuerpo del bucle y va directamente a la siguiente iteración.

```c
for (int i = 0; i < 10; i++) {
    if (i % 2 == 0) continue;   /* salta los pares */
    printf("%d ", i);            /* imprime solo impares: 1 3 5 7 9 */
}
```

### goto (no recomendado)

C tiene `goto`, pero su uso está desaconsejado porque produce código difícil de mantener.
La única excepción donde se acepta es para salir de múltiples bucles anidados.

---

## 4. Bucles infinitos

```c
/* Bucle infinito — necesita break o return para terminar */
while (1) {
    /* ... */
    if (condicion_de_salida) break;
}

/* Con for — idioma muy común en sistemas embebidos */
for (;;) {
    /* ... */
}
```

---

## Archivos de este capítulo

| Archivo               | Descripción                                       |
|-----------------------|---------------------------------------------------|
| `01_control_flujo.c`  | Ejemplos completos de if, switch, for, while, etc.|

---

## Siguiente capítulo

→ **Capítulo 05:** Funciones
