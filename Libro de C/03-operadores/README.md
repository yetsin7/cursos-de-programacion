# Capítulo 03 — Operadores

Los operadores son las piezas que permiten transformar datos. Gracias a ellos un programa puede
sumar, comparar, decidir, activar banderas, validar condiciones y construir expresiones más
complejas. En C esto es especialmente importante porque el lenguaje trabaja muy cerca del hardware
y algunas operaciones afectan directamente la representación binaria de los datos.

## Qué aprenderás aquí

- Cómo C calcula expresiones aritméticas y lógicas
- Qué diferencia hay entre asignar, comparar y modificar una variable
- Cómo se comportan los operadores a nivel de bits
- Por qué la precedencia importa y cómo evitar errores sutiles
- Cuándo conviene escribir expresiones simples en lugar de "ingeniosas"

## Qué está pasando dentro del software y del hardware

Cuando escribes una expresión como `a + b`, el compilador la traduce a instrucciones de máquina
que la CPU ejecuta usando registros y memoria. Si haces una comparación como `a > b`, la CPU no
"entiende" mayor o menor como una idea abstracta: compara patrones de bits y luego activa una
condición interna que el programa interpreta como verdadero o falso.

En C los valores booleanos suelen representarse como enteros: `0` significa falso y cualquier
otro valor significa verdadero. Esto hace que el lenguaje sea muy flexible, pero también más fácil
de usar mal si no se entiende qué valor real hay en memoria.

## Ideas clave del capítulo

### 1. Operadores aritméticos

| Operador | Uso | Ejemplo | Resultado |
|----------|-----|---------|-----------|
| `+` | Sumar | `8 + 2` | `10` |
| `-` | Restar | `8 - 2` | `6` |
| `*` | Multiplicar | `8 * 2` | `16` |
| `/` | Dividir | `8 / 2` | `4` |
| `%` | Resto | `8 % 3` | `2` |

La división entre enteros descarta la parte decimal. `5 / 2` da `2`, no `2.5`. Para obtener
decimales, al menos uno de los operandos debe ser `float` o `double`.

### 2. Operadores de asignación

`=` guarda un valor en una variable. Los operadores compuestos ahorran escritura:

```c
x = 10;
x += 5;   /* ahora x vale 15 */
x *= 2;   /* ahora x vale 30 */
```

Aquí no solo cambia una fórmula: cambia el contenido real almacenado en memoria.

### 3. Incremento y decremento

```c
int x = 5;
int a = x++;  /* a = 5, luego x pasa a 6 */
int b = ++x;  /* primero x pasa a 7, luego b = 7 */
```

La diferencia entre pre y post incremento importa mucho dentro de expresiones, bucles y acceso a
arreglos.

### 4. Comparación

| Operador | Significado |
|----------|-------------|
| `==` | Igual |
| `!=` | Distinto |
| `>` | Mayor |
| `<` | Menor |
| `>=` | Mayor o igual |
| `<=` | Menor o igual |

El error más famoso de principiantes es confundir `=` con `==`. El primero modifica un valor. El
segundo compara dos valores.

### 5. Operadores lógicos

| Operador | Significado |
|----------|-------------|
| `&&` | y |
| `||` | o |
| `!` | no |

Se usan para construir condiciones más expresivas:

```c
if (edad >= 18 && tieneIdentificacion) {
    printf("Acceso permitido\n");
}
```

### 6. Operadores bit a bit

Estos operadores trabajan directamente sobre los bits de un número entero:

| Operador | Uso |
|----------|-----|
| `&` | AND bit a bit |
| `|` | OR bit a bit |
| `^` | XOR bit a bit |
| `~` | invertir bits |
| `<<` | desplazar a la izquierda |
| `>>` | desplazar a la derecha |

Son muy usados en sistemas embebidos, drivers, protocolos, compresión y manejo de banderas.

### 7. Operador ternario

Es una forma compacta de decidir entre dos valores:

```c
int mayor = (a > b) ? a : b;
```

Debe usarse cuando mejora la lectura. Si hace el código más difícil de entender, conviene usar
`if` y `else`.

### 8. `sizeof`

`sizeof` indica cuántos bytes ocupa un tipo o variable:

```c
printf("%zu\n", sizeof(int));
printf("%zu\n", sizeof(double));
```

Esto ayuda a entender cuánta memoria consumen los datos y será fundamental cuando llegues a
punteros, arreglos y memoria dinámica.

## Errores comunes

- Usar `=` cuando querías usar `==`
- Pensar que `5 / 2` devuelve `2.5`
- Olvidar que `x++` y `++x` no siempre producen el mismo resultado
- Escribir expresiones demasiado largas sin paréntesis
- Usar operadores bit a bit sin entender qué bits cambian

## Cómo estudiar este capítulo

1. Ejecuta el archivo del capítulo y cambia valores manualmente.
2. Prueba divisiones entre enteros y entre decimales.
3. Escribe condiciones con `&&`, `||` y `!`.
4. Usa papel o una tabla para ver cómo cambian los bits con `&`, `|` y `<<`.
5. Si una expresión te parece confusa, reescríbela en pasos pequeños.

## Archivos de este capítulo

| Archivo | Descripción |
|---------|-------------|
| `01_operadores.c` | Ejemplos guiados de operadores aritméticos, lógicos, de comparación y bit a bit |

## Conexión con el siguiente capítulo

En este capítulo aprendiste a construir condiciones y expresiones. En el siguiente usarás esas
condiciones para decidir qué camino toma el programa y cuántas veces repite una tarea.
