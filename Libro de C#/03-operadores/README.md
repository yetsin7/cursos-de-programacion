# Capítulo 03 — Operadores

## Operadores aritméticos

| Operador | Descripción         | Ejemplo          | Resultado |
|----------|---------------------|------------------|-----------|
| `+`      | Suma                | `5 + 3`          | `8`       |
| `-`      | Resta               | `5 - 3`          | `2`       |
| `*`      | Multiplicación      | `5 * 3`          | `15`      |
| `/`      | División            | `7 / 2`          | `3` (enteros) |
| `%`      | Módulo (residuo)    | `7 % 2`          | `1`       |
| `++`     | Incremento          | `x++` o `++x`    | +1        |
| `--`     | Decremento          | `x--` o `--x`    | -1        |

> **Nota:** La división entre enteros siempre da un entero. Usa `7.0 / 2` para obtener `3.5`.

---

## Operadores de comparación

| Operador | Descripción        | Ejemplo    | Resultado |
|----------|--------------------|------------|-----------|
| `==`     | Igual              | `5 == 5`   | `true`    |
| `!=`     | Distinto           | `5 != 3`   | `true`    |
| `>`      | Mayor que          | `5 > 3`    | `true`    |
| `<`      | Menor que          | `3 < 5`    | `true`    |
| `>=`     | Mayor o igual      | `5 >= 5`   | `true`    |
| `<=`     | Menor o igual      | `3 <= 5`   | `true`    |

---

## Operadores lógicos

| Operador | Descripción    | Ejemplo              | Resultado         |
|----------|----------------|----------------------|-------------------|
| `&&`     | AND (y)        | `true && false`      | `false`           |
| `\|\|`   | OR (o)         | `true \|\| false`    | `true`            |
| `!`      | NOT (negación) | `!true`              | `false`           |

Los operadores `&&` y `||` tienen **evaluación de cortocircuito**: si el resultado ya está determinado por el primer operando, el segundo no se evalúa.

---

## Operadores de asignación

```csharp
int x = 10;
x += 5;    // x = x + 5  → 15
x -= 3;    // x = x - 3  → 12
x *= 2;    // x = x * 2  → 24
x /= 4;    // x = x / 4  → 6
x %= 4;    // x = x % 4  → 2
```

---

## Operador ternario

```csharp
condicion ? valorSiTrue : valorSiFalse
```

```csharp
int edad = 20;
string mensaje = edad >= 18 ? "Mayor de edad" : "Menor de edad";
```

---

## Operadores de null (modernos de C#)

### `??` — Null-coalescing (valor por defecto)

```csharp
string? nombre = null;
string resultado = nombre ?? "Sin nombre";  // "Sin nombre"
```

### `??=` — Null-coalescing assignment (C# 8+)

```csharp
string? valor = null;
valor ??= "predeterminado";  // asigna solo si es null
```

### `?.` — Null-conditional (acceso seguro)

```csharp
string? texto = null;
int? longitud = texto?.Length;  // no lanza NullReferenceException → null
```

### Encadenamiento de `?.` con `??`

```csharp
string? texto = null;
int longitud = texto?.Length ?? 0;  // 0 si texto es null
```

---

## Operadores bit a bit

| Operador | Descripción            |
|----------|------------------------|
| `&`      | AND bit a bit          |
| `\|`     | OR bit a bit           |
| `^`      | XOR bit a bit          |
| `~`      | Complemento (NOT)      |
| `<<`     | Desplazamiento izquierda |
| `>>`     | Desplazamiento derecha |

---

## Ejecutar el ejemplo

```bash
cd 03-operadores
dotnet run
```
