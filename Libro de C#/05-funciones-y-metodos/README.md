# Capítulo 05 — Funciones y métodos

## Métodos básicos

En C# las funciones se llaman **métodos** y deben pertenecer a una clase o struct.

```csharp
// Método que no retorna valor
static void Saludar(string nombre)
{
    Console.WriteLine($"Hola, {nombre}!");
}

// Método que retorna un valor
static int Sumar(int a, int b)
{
    return a + b;
}

// Método con expresión (expression-bodied, C# 6+)
static int Multiplicar(int a, int b) => a * b;
```

---

## Parámetros especiales

### `out` — Devuelve un valor adicional

```csharp
static bool Dividir(int a, int b, out double resultado)
{
    if (b == 0) { resultado = 0; return false; }
    resultado = (double)a / b;
    return true;
}

// Uso
if (Dividir(10, 2, out double res))
    Console.WriteLine(res);  // 5.0
```

### `ref` — Pasa por referencia (puede leer y modificar)

```csharp
static void Duplicar(ref int x) => x *= 2;

int n = 5;
Duplicar(ref n);  // n ahora es 10
```

### `in` — Pasa por referencia pero solo lectura

```csharp
static void Mostrar(in int x) => Console.WriteLine(x);
// x no puede ser modificado dentro del método
```

### `params` — Número variable de parámetros

```csharp
static int Sumar(params int[] numeros) => numeros.Sum();

Console.WriteLine(Sumar(1, 2, 3, 4, 5));  // 15
```

---

## Parámetros opcionales y con nombre

```csharp
static void Presentar(string nombre, int edad = 0, string país = "Nicaragua")
{
    Console.WriteLine($"{nombre}, {edad} años, de {país}");
}

Presentar("Ana");                          // usa valores por defecto
Presentar("Luis", 30);
Presentar("Eva", país: "México", edad: 25); // parámetros con nombre
```

---

## Métodos de extensión

Agregan métodos a tipos existentes sin modificarlos ni heredarlos:

```csharp
// Deben estar en una clase estática
static class ExtensionesString
{
    public static string EnMayusculas(this string texto) =>
        texto.ToUpper();
}

// Uso
string saludo = "hola";
Console.WriteLine(saludo.EnMayusculas());  // "HOLA"
```

---

## Expresiones lambda

Funciones anónimas, muy usadas con LINQ y delegados:

```csharp
// Lambda sin parámetros
Action saludar = () => Console.WriteLine("¡Hola!");

// Lambda con un parámetro
Action<string> mostrar = nombre => Console.WriteLine($"Hola, {nombre}");

// Lambda con múltiples parámetros y retorno
Func<int, int, int> sumar = (a, b) => a + b;
```

---

## `Func` y `Action`

```csharp
// Action: no retorna valor
Action<string>       imprimir   = s => Console.WriteLine(s);

// Func: retorna un valor (el último tipo es el retorno)
Func<int, int, int>  sumar      = (a, b) => a + b;
Func<string, bool>   esVacio    = s => string.IsNullOrEmpty(s);

// Predicate: caso especial de Func<T, bool>
Predicate<int>       esPar      = n => n % 2 == 0;
```

---

## Ejecutar el ejemplo

```bash
cd 05-funciones-y-metodos
dotnet run
```
