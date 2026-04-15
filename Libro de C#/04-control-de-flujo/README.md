# Capítulo 04 — Control de flujo

## `if` / `else if` / `else`

La estructura condicional más básica:

```csharp
int temperatura = 35;

if (temperatura > 30)
    Console.WriteLine("Hace calor");
else if (temperatura > 20)
    Console.WriteLine("Temperatura agradable");
else
    Console.WriteLine("Hace frío");
```

---

## `switch` clásico

```csharp
int dia = 3;
switch (dia)
{
    case 1: Console.WriteLine("Lunes"); break;
    case 2: Console.WriteLine("Martes"); break;
    case 3: Console.WriteLine("Miércoles"); break;
    default: Console.WriteLine("Otro día"); break;
}
```

---

## `switch` expression (C# 8+)

Forma moderna, más concisa y expresiva:

```csharp
int dia = 3;
string nombre = dia switch
{
    1 => "Lunes",
    2 => "Martes",
    3 => "Miércoles",
    4 => "Jueves",
    5 => "Viernes",
    6 or 7 => "Fin de semana",
    _ => "Inválido"    // _ es el caso por defecto
};
```

---

## Pattern matching básico (C# 7+)

```csharp
object valor = 42;

// is pattern
if (valor is int numero)
    Console.WriteLine($"Es un int: {numero}");

// switch con patterns
string descripcion = valor switch
{
    int n when n > 0    => "Entero positivo",
    int n when n < 0    => "Entero negativo",
    int                 => "Cero",
    string s            => $"Texto: {s}",
    null                => "Nulo",
    _                   => "Tipo desconocido"
};
```

---

## `for`

```csharp
for (int i = 0; i < 5; i++)
    Console.WriteLine(i);
```

---

## `foreach`

Itera colecciones de forma más limpia:

```csharp
string[] frutas = { "mango", "papaya", "aguacate" };
foreach (string fruta in frutas)
    Console.WriteLine(fruta);
```

---

## `while`

Se ejecuta mientras la condición sea verdadera:

```csharp
int contador = 0;
while (contador < 5)
{
    Console.WriteLine(contador);
    contador++;
}
```

---

## `do-while`

Similar a `while`, pero la condición se evalúa **al final** (se ejecuta al menos una vez):

```csharp
int n = 0;
do
{
    Console.WriteLine(n);
    n++;
} while (n < 3);
```

---

## `break` y `continue`

```csharp
for (int i = 0; i < 10; i++)
{
    if (i == 3) continue;  // salta el 3
    if (i == 7) break;     // termina el bucle
    Console.WriteLine(i);
}
// Imprime: 0, 1, 2, 4, 5, 6
```

---

## Ejecutar el ejemplo

```bash
cd 04-control-de-flujo
dotnet run
```
