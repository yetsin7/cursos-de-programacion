# Capítulo 03 — Operadores

## Tipos de operadores en C

C tiene una gran variedad de operadores. Conocerlos todos te permite escribir código más conciso
y entender código escrito por otros.

---

## 1. Operadores aritméticos

| Operador | Significado       | Ejemplo       | Resultado |
|----------|-------------------|---------------|-----------|
| `+`      | Suma              | `5 + 3`       | `8`       |
| `-`      | Resta             | `5 - 3`       | `2`       |
| `*`      | Multiplicación    | `5 * 3`       | `15`      |
| `/`      | División          | `5 / 2`       | `2` (entera) |
| `%`      | Módulo (resto)    | `5 % 2`       | `1`       |

> La división entre enteros siempre produce un entero (se trunca).
> Para obtener decimales, uno de los operandos debe ser `float` o `double`.

---

## 2. Operadores de asignación

| Operador | Equivale a     | Ejemplo     |
|----------|----------------|-------------|
| `=`      | Asignar        | `x = 5`     |
| `+=`     | `x = x + n`   | `x += 3`    |
| `-=`     | `x = x - n`   | `x -= 2`    |
| `*=`     | `x = x * n`   | `x *= 4`    |
| `/=`     | `x = x / n`   | `x /= 2`    |
| `%=`     | `x = x % n`   | `x %= 3`    |

---

## 3. Operadores de incremento y decremento

```c
int x = 5;
x++;    /* post-incremento: usa x (5), luego suma 1 → x = 6 */
++x;    /* pre-incremento:  suma 1 primero → x = 7           */
x--;    /* post-decremento: usa x (7), luego resta 1 → x = 6 */
--x;    /* pre-decremento:  resta 1 primero → x = 5          */
```

---

## 4. Operadores de comparación

Devuelven `1` (verdadero) o `0` (falso).

| Operador | Significado       | Ejemplo   |
|----------|-------------------|-----------|
| `==`     | Igual a           | `a == b`  |
| `!=`     | Diferente de      | `a != b`  |
| `>`      | Mayor que         | `a > b`   |
| `<`      | Menor que         | `a < b`   |
| `>=`     | Mayor o igual     | `a >= b`  |
| `<=`     | Menor o igual     | `a <= b`  |

> ⚠️ No confundir `=` (asignación) con `==` (comparación). Es uno de los errores más comunes.

---

## 5. Operadores lógicos

| Operador | Significado | Ejemplo            |
|----------|-------------|--------------------|
| `&&`     | Y (AND)     | `a > 0 && b > 0`   |
| `\|\|`   | O (OR)      | `a > 0 \|\| b > 0` |
| `!`      | NO (NOT)    | `!(a == b)`        |

---

## 6. Operadores bitwise (a nivel de bits)

Operan directamente sobre los bits de los valores enteros.

| Operador | Significado         | Ejemplo (binario)          |
|----------|---------------------|----------------------------|
| `&`      | AND bit a bit       | `0b1010 & 0b1100 = 0b1000` |
| `\|`     | OR bit a bit        | `0b1010 \| 0b0101 = 0b1111`|
| `^`      | XOR bit a bit       | `0b1010 ^ 0b1100 = 0b0110` |
| `~`      | NOT bit a bit       | `~0b1010 = 0b0101...`      |
| `<<`     | Desplazamiento izq. | `1 << 3 = 8`               |
| `>>`     | Desplazamiento der. | `8 >> 1 = 4`               |

```c
int flags = 0b00000101;       /* bits 0 y 2 activos */
flags |=  (1 << 3);           /* activar bit 3 */
flags &= ~(1 << 0);           /* desactivar bit 0 */
```

---

## 7. Operador ternario

Forma compacta de una expresión if/else. Devuelve un valor.

```
condicion ? valor_si_verdad : valor_si_falso
```

```c
int max = (a > b) ? a : b;
printf("Es %s\n", edad >= 18 ? "mayor de edad" : "menor de edad");
```

---

## 8. Operador `sizeof`

Devuelve el tamaño en bytes de un tipo o variable. No es una función — es un operador del
compilador que se evalúa en tiempo de compilación.

```c
printf("%zu\n", sizeof(int));       /* 4 */
printf("%zu\n", sizeof(double));    /* 8 */
```

---

## 9. Precedencia de operadores (simplificada)

De mayor a menor prioridad:

1. `()` — paréntesis
2. `++` `--` (post), `!` `~` (unarios)
3. `*` `/` `%`
4. `+` `-`
5. `<<` `>>`
6. `<` `<=` `>` `>=`
7. `==` `!=`
8. `&` → `^` → `|`
9. `&&`
10. `||`
11. `?:` (ternario)
12. `=` `+=` `-=` etc.

> Regla práctica: usa paréntesis cuando tengas dudas. El código claro supera al código "inteligente".

---

## Archivos de este capítulo

| Archivo            | Descripción                            |
|--------------------|----------------------------------------|
| `01_operadores.c`  | Ejemplos de todos los operadores en C  |

---

## Siguiente capítulo

→ **Capítulo 04:** Control de flujo
