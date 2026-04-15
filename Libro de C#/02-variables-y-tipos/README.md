# Capítulo 02 — Variables y tipos de datos

## Sistema de tipos en C#

C# es un lenguaje de **tipado estático**: el tipo de cada variable se define en tiempo de compilación. Esto permite detectar errores antes de ejecutar el programa.

---

## Tipos numéricos enteros

| Tipo     | Tamaño  | Rango                                         |
|----------|---------|-----------------------------------------------|
| `byte`   | 8 bits  | 0 a 255                                       |
| `short`  | 16 bits | -32,768 a 32,767                              |
| `int`    | 32 bits | -2,147,483,648 a 2,147,483,647                |
| `long`   | 64 bits | -9.2 × 10¹⁸ a 9.2 × 10¹⁸                     |
| `uint`   | 32 bits | 0 a 4,294,967,295 (sin signo)                 |

## Tipos numéricos decimales

| Tipo      | Precisión         | Uso recomendado              |
|-----------|-------------------|------------------------------|
| `float`   | ~7 dígitos        | Gráficos, juegos             |
| `double`  | ~15-16 dígitos    | Cálculos científicos         |
| `decimal` | 28-29 dígitos     | Dinero, contabilidad         |

## Otros tipos primitivos

| Tipo     | Descripción                          | Ejemplo              |
|----------|--------------------------------------|----------------------|
| `bool`   | Verdadero o falso                    | `true`, `false`      |
| `char`   | Un solo carácter Unicode             | `'A'`, `'ñ'`         |
| `string` | Cadena de texto (inmutable)          | `"Hola mundo"`       |
| `object` | Base de todos los tipos en .NET      | Puede almacenar todo |

---

## `var` — Inferencia de tipos

```csharp
var nombre = "Carlos";  // el compilador infiere que es string
var edad   = 25;        // el compilador infiere que es int
```

`var` no hace el tipo dinámico — sigue siendo estático, solo ahorra escribirlo.

---

## `dynamic` — Tipo dinámico

```csharp
dynamic x = 10;
x = "ahora soy string"; // válido en tiempo de ejecución
```

Con `dynamic`, el tipo se resuelve en tiempo de ejecución. Usar con precaución.

---

## Nullable types — Tipos anulables

Por defecto, los tipos de valor (`int`, `bool`, etc.) **no pueden ser `null`**. Para permitirlo:

```csharp
int? edad = null;     // entero anulable
bool? activo = null;  // bool anulable

// Comprobar si tiene valor
if (edad.HasValue)
    Console.WriteLine(edad.Value);

// Valor por defecto si es null
int edadFinal = edad ?? 0;
```

---

## `const` y `readonly`

```csharp
const double PI = 3.14159;          // constante en tiempo de compilación
readonly int maxIntentos = 3;       // solo se asigna una vez (en constructor)
```

| Característica | `const`                   | `readonly`                          |
|----------------|---------------------------|-------------------------------------|
| Cuándo se fija | Compilación               | Ejecución (constructor o declaración) |
| Puede ser campo de instancia | No          | Sí                                  |
| Tipo permitido | Solo primitivos y string  | Cualquier tipo                      |

---

## Interpolación de strings

```csharp
string nombre = "Ana";
int edad = 28;

// Interpolación con $""
Console.WriteLine($"Hola, {nombre}. Tienes {edad} años.");

// Formato dentro de la interpolación
double precio = 19.9;
Console.WriteLine($"Precio: {precio:C2}");  // moneda con 2 decimales
Console.WriteLine($"PI: {Math.PI:F4}");     // 4 decimales fijos
```

---

## Conversiones de tipos

```csharp
// Conversión implícita (sin pérdida de datos)
int n = 42;
long grande = n;       // int → long es seguro

// Conversión explícita (cast)
double d = 9.99;
int entero = (int)d;   // trunca: resultado es 9

// Conversión con métodos
string texto = "123";
int parseado = int.Parse(texto);
bool ok = int.TryParse("abc", out int resultado); // no lanza excepción
```

---

## Ejecutar el ejemplo

```bash
cd 02-variables-y-tipos
dotnet run
```
