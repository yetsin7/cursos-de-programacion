# Números y Matemáticas en Inglés

## Introducción

Trabajar con números es parte fundamental de la programación. En esta lección aprenderás a decir números cardinales, ordinales, operaciones matemáticas y los sistemas numéricos más usados en desarrollo de software.

---

## Números cardinales (Cardinal Numbers)

### 0-20

| Número | Inglés | Número | Inglés |
|--------|--------|--------|--------|
| 0 | zero | 11 | eleven |
| 1 | one | 12 | twelve |
| 2 | two | 13 | thirteen |
| 3 | three | 14 | fourteen |
| 4 | four | 15 | fifteen |
| 5 | five | 16 | sixteen |
| 6 | six | 17 | seventeen |
| 7 | seven | 18 | eighteen |
| 8 | eight | 19 | nineteen |
| 9 | nine | 20 | twenty |
| 10 | ten | | |

### Decenas

| Número | Inglés | Número | Inglés |
|--------|--------|--------|--------|
| 20 | twenty | 60 | sixty |
| 30 | thirty | 70 | seventy |
| 40 | forty | 80 | eighty |
| 50 | fifty | 90 | ninety |

> **Nota:** "forty" NO lleva "u". Es un error muy común escribir "fourty".

### Números compuestos (21-99)

Se forman con decena + guion + unidad: **twenty-one** (21), **thirty-five** (35), **ninety-nine** (99).

### Centenas, miles y más

| Número | Inglés |
|--------|--------|
| 100 | one hundred |
| 200 | two hundred |
| 256 | two hundred fifty-six |
| 404 | four hundred four (o "four-oh-four") |
| 500 | five hundred |
| 1,000 | one thousand |
| 1,024 | one thousand twenty-four |
| 10,000 | ten thousand |
| 100,000 | one hundred thousand |
| 1,000,000 | one million |

> **Importante:** En inglés se usa **coma** para separar miles (1,000) y **punto** para decimales (3.14). Es al revés que en muchos países hispanohablantes.

### Formas especiales del cero

| Contexto | Se dice | Ejemplo |
|----------|---------|---------|
| Matemáticas/general | **zero** | The value is zero |
| Código HTTP | **oh** | A 404 is "four-oh-four" |
| Versión de software | **oh** o **zero** | Version 2.0 = "two point oh/zero" |
| Número de teléfono | **oh** | 555-0123 = "five-five-five-oh-one-two-three" |

---

## Números ordinales (Ordinal Numbers)

Indican posición u orden. Se usan con fechas y para describir índices.

| Cardinal | Ordinal | Abreviatura |
|----------|---------|-------------|
| one | first | 1st |
| two | second | 2nd |
| three | third | 3rd |
| four | fourth | 4th |
| five | fifth | 5th |
| ten | tenth | 10th |
| twelve | twelfth | 12th |
| twenty | twentieth | 20th |
| twenty-one | twenty-first | 21st |
| hundred | hundredth | 100th |

### En programación

| Inglés | Español |
|--------|---------|
| The **first** element of the array | El **primer** elemento del arreglo |
| The **second** parameter is optional | El **segundo** parámetro es opcional |
| The **third** commit fixed the bug | El **tercer** commit arregló el bug |

> **Recuerda:** Los arrays empiezan en index 0, pero en lenguaje natural decimos "the first element" (no "the zeroth element").

---

## Operaciones matemáticas

| Operación | Símbolo | Verbo | Cómo se lee |
|-----------|---------|-------|-------------|
| Suma | + | **add** | "five plus three equals eight" (5 + 3 = 8) |
| Resta | - | **subtract** | "ten minus four equals six" (10 - 4 = 6) |
| Multiplicación | * / x | **multiply** | "three times seven equals twenty-one" (3 × 7 = 21) |
| División | / | **divide** | "twenty divided by four equals five" (20 / 4 = 5) |
| Módulo | % | **modulo** | "ten modulo three equals one" (10 % 3 = 1) |
| Potencia | ** / ^ | **raise to the power** | "two to the power of eight" (2^8) |
| Raíz cuadrada | √ | **square root** | "the square root of sixteen is four" |

### Expresiones comunes en código

| Código | Cómo se lee en inglés |
|--------|-----------------------|
| `x = 5 + 3` | "x equals five plus three" |
| `count += 1` | "count plus equals one" o "increment count by one" |
| `total -= tax` | "total minus equals tax" |
| `result = a * b` | "result equals a times b" |
| `avg = sum / count` | "average equals sum divided by count" |
| `remainder = n % 2` | "remainder equals n modulo two" |
| `x++` | "x plus plus" o "increment x" |
| `y--` | "y minus minus" o "decrement y" |

### Comparaciones

| Símbolo | Inglés | Ejemplo leído |
|---------|--------|---------------|
| == | equals / is equal to | "x equals five" |
| != | is not equal to / does not equal | "x does not equal y" |
| > | is greater than | "a is greater than b" |
| < | is less than | "a is less than b" |
| >= | is greater than or equal to | "x is greater than or equal to zero" |
| <= | is less than or equal to | "count is less than or equal to ten" |

---

## Sistemas numéricos en programación

### Binario (Binary)

| Decimal | Binario | Cómo se lee |
|---------|---------|-------------|
| 0 | 0b0000 | "zero in binary" |
| 1 | 0b0001 | "one in binary" |
| 8 | 0b1000 | "eight in binary is one-zero-zero-zero" |
| 255 | 0b11111111 | "two fifty-five in binary is eight ones" |

### Hexadecimal (Hex)

| Decimal | Hex | Cómo se lee |
|---------|-----|-------------|
| 0 | 0x00 | "zero-x-zero-zero" o "hex zero" |
| 15 | 0x0F | "zero-x-zero-F" o "hex F" |
| 255 | 0xFF | "zero-x-F-F" o "hex F-F" |
| Color blanco | #FFFFFF | "hash F-F-F-F-F-F" o "hex white" |
| Color negro | #000000 | "hash all zeros" o "hex black" |

> **Letras hex:** A se pronuncia "ay", B "bee", C "see", D "dee", E "ee", F "ef".

### Octal (Octal)

| Decimal | Octal | Contexto |
|---------|-------|----------|
| 7 | 0o7 | Permisos Unix: "seven" |
| 755 | 0o755 | "seven-five-five" (rwxr-xr-x) |
| 644 | 0o644 | "six-four-four" (rw-r--r--) |

---

## Números de versión (Version Numbers)

| Versión | Cómo se lee |
|---------|-------------|
| 1.0 | "one point oh" o "one point zero" |
| 2.1 | "two point one" |
| 3.14 | "three point fourteen" o "three point one four" |
| 3.14.1 | "three point fourteen point one" |
| 16.04 | "sixteen point oh four" (Ubuntu) |
| v2.0.0 | "version two point oh point oh" |

### Versionado semántico (Semantic Versioning)

```
MAJOR.MINOR.PATCH → mayor.menor.parche

v3.2.1 → "version three point two point one"
        → major: 3, minor: 2, patch: 1
```

| Término | Inglés | Ejemplo |
|---------|--------|---------|
| Versión mayor | major version | "We released major version five" |
| Versión menor | minor version | "This is a minor version bump" |
| Parche | patch | "The patch fixes the security issue" |

---

## Tamaños y unidades de almacenamiento

| Unidad | Inglés | Ejemplo |
|--------|--------|---------|
| bit | bit | "a 64-bit operating system" |
| byte | byte /bait/ | "the file is 500 bytes" |
| KB | kilobyte | "a 4 kilobyte page" |
| MB | megabyte | "the image is 2 megabytes" |
| GB | gigabyte | "16 gigabytes of RAM" |
| TB | terabyte | "a one terabyte hard drive" |

---

## Ejercicios

### Ejercicio 1: Escribe en inglés

1. 42 → ___
2. 100 → ___
3. 256 → ___
4. 1,024 → ___
5. 404 → ___
6. 1,000,000 → ___

### Ejercicio 2: Lee las operaciones en inglés

1. 15 + 7 = 22 → ___
2. 100 - 36 = 64 → ___
3. 8 * 12 = 96 → ___
4. 45 / 9 = 5 → ___
5. 17 % 5 = 2 → ___
6. 2^10 = 1024 → ___

### Ejercicio 3: Lee las versiones

1. v1.0.0 → ___
2. v3.14.2 → ___
3. v16.04 → ___

### Ejercicio 4: Traduce

1. El primer elemento del arreglo es cero.
2. El archivo pesa 2 megabytes.
3. X es mayor que Y.
4. La versión tres punto dos corrige el bug.

---

### Respuestas

**Ejercicio 1:** 1. forty-two, 2. one hundred, 3. two hundred fifty-six, 4. one thousand twenty-four, 5. four hundred four / four-oh-four, 6. one million

**Ejercicio 2:**
1. Fifteen plus seven equals twenty-two.
2. One hundred minus thirty-six equals sixty-four.
3. Eight times twelve equals ninety-six.
4. Forty-five divided by nine equals five.
5. Seventeen modulo five equals two.
6. Two to the power of ten equals one thousand twenty-four.

**Ejercicio 3:**
1. Version one point oh point oh.
2. Version three point fourteen point two.
3. Version sixteen point oh four.

**Ejercicio 4:**
1. The first element of the array is zero.
2. The file is 2 megabytes. / The file weighs 2 megabytes.
3. X is greater than Y.
4. Version three point two fixes the bug.
