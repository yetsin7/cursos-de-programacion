// ============================================================
// Capitulo 05 — Funciones y metodos
// Temas: metodos, out/ref/in, params, parametros opcionales,
//        metodos de extension, lambdas, Func y Action
// ============================================================
//
// Este archivo muestra como C# encapsula logica en metodos reutilizables.
// Tambien enseña variantes utiles para pasar datos y trabajar con funciones.
// ============================================================

Console.WriteLine("=== Métodos básicos ===");

Console.WriteLine(Sumar(5, 3));           // 8
Console.WriteLine(Multiplicar(4, 6));     // 24
Saludar("Yetsin");

Console.WriteLine("\n=== Parámetros out ===");

// out permite devolver informacion adicional.
if (Dividir(10, 2, out double resultado))
    Console.WriteLine($"10 / 2 = {resultado}");

if (!Dividir(5, 0, out double _))         // '_' descarta el out
    Console.WriteLine("No se puede dividir entre cero");

// TryParse usa exactamente este patron.
bool exito = int.TryParse("123", out int numero);
Console.WriteLine($"TryParse '123': exito={exito}, valor={numero}");

Console.WriteLine("\n=== Parámetros ref ===");

int valor = 5;
Console.WriteLine($"Antes de Duplicar: {valor}");
Duplicar(ref valor);
Console.WriteLine($"Después de Duplicar: {valor}");

Console.WriteLine("\n=== Parámetros params ===");

Console.WriteLine($"Suma(1,2,3)     = {SumarTodos(1, 2, 3)}");
Console.WriteLine($"Suma(1..5)      = {SumarTodos(1, 2, 3, 4, 5)}");
Console.WriteLine($"Suma(ninguno)   = {SumarTodos()}");

Console.WriteLine("\n=== Parámetros opcionales y con nombre ===");

Presentar("Ana");
Presentar("Luis", 30);
Presentar("Eva", pais: "México", edad: 25);

Console.WriteLine("\n=== Métodos de extensión ===");

string texto = "hola mundo";
Console.WriteLine(texto.Capitalizar());           // "Hola Mundo"
Console.WriteLine(texto.ContarPalabras());        // 2
Console.WriteLine("  espacios  ".SinEspacios());  // "espacios"

int[] numeros = { 3, 1, 4, 1, 5, 9, 2, 6 };
Console.WriteLine($"Mayor: {numeros.Mayor()}");
Console.WriteLine($"Menor: {numeros.Menor()}");

Console.WriteLine("\n=== Expresiones lambda ===");

// Lambda sin parámetros
Action saludar = () => Console.WriteLine("¡Lambda sin parámetros!");
saludar();

// Lambda con un parámetro (los paréntesis son opcionales con uno solo)
Action<string> mostrar = nombre => Console.WriteLine($"Hola, {nombre}");
mostrar("C#");

// Lambda con múltiples parámetros
Func<int, int, int> sumar      = (a, b) => a + b;
Func<int, int, int> multiplicar = (a, b) => a * b;
Console.WriteLine($"Lambda sumar(3,4)        : {sumar(3, 4)}");
Console.WriteLine($"Lambda multiplicar(3,4)  : {multiplicar(3, 4)}");

// Lambda con bloque de código
Func<int, string> clasificar = n =>
{
    if (n > 0) return "positivo";
    if (n < 0) return "negativo";
    return "cero";
};
Console.WriteLine($"Clasificar(-7): {clasificar(-7)}");

Console.WriteLine("\n=== Func, Action y Predicate ===");

Func<string, bool>  esVacio  = s => string.IsNullOrWhiteSpace(s);
Predicate<int>      esPar    = n => n % 2 == 0;

Console.WriteLine($"esVacio('')    : {esVacio("")}");
Console.WriteLine($"esVacio('abc') : {esVacio("abc")}");
Console.WriteLine($"esPar(4)       : {esPar(4)}");
Console.WriteLine($"esPar(7)       : {esPar(7)}");

// Pasar métodos como parámetros
Aplicar("hola mundo", s => Console.WriteLine(s.ToUpper()));
Aplicar("CSHARP", s => Console.WriteLine(s.ToLower()));

Console.WriteLine("\n=== Ideas clave ===");
Console.WriteLine("Los metodos organizan la logica y reducen duplicacion.");
Console.WriteLine("out y ref son utiles, pero no deben usarse sin motivo.");
Console.WriteLine("Las lambdas son funciones pequeñas muy practicas.");

// ============================================================
// Definicion de metodos locales al archivo
// ============================================================

/// <summary>Saluda a una persona por su nombre.</summary>
static void Saludar(string nombre) =>
    Console.WriteLine($"¡Hola, {nombre}! Bienvenido a C#.");

/// <summary>Retorna la suma de dos enteros.</summary>
static int Sumar(int a, int b) => a + b;

/// <summary>Retorna el producto de dos enteros.</summary>
static int Multiplicar(int a, int b) => a * b;

/// <summary>Divide a entre b. Retorna false si b es cero.</summary>
static bool Dividir(int a, int b, out double resultado)
{
    if (b == 0)
    {
        resultado = 0;
        return false;
    }
    resultado = (double)a / b;
    return true;
}

/// <summary>Duplica el valor pasado por referencia.</summary>
static void Duplicar(ref int x) => x *= 2;

/// <summary>Suma un numero variable de enteros con params.</summary>
static int SumarTodos(params int[] numeros) =>
    numeros.Length == 0 ? 0 : numeros.Sum();

/// <summary>Presenta a una persona con parametros opcionales.</summary>
static void Presentar(string nombre, int edad = 0, string pais = "Nicaragua") =>
    Console.WriteLine($"{nombre}, {edad} años, de {pais}");

/// <summary>Aplica una accion a un string.</summary>
static void Aplicar(string valor, Action<string> accion) => accion(valor);

// ============================================================
// Clase de metodos de extension
// ============================================================

/// <summary>Extensiones utiles para strings e int[].</summary>
static class Extensiones
{
    /// <summary>Pone en mayuscula la primera letra de cada palabra.</summary>
    public static string Capitalizar(this string texto) =>
        string.Join(" ", texto.Split(' ')
            .Select(p => p.Length > 0
                ? char.ToUpper(p[0]) + p[1..].ToLower()
                : p));

    /// <summary>Cuenta las palabras en un string.</summary>
    public static int ContarPalabras(this string texto) =>
        texto.Split(' ', StringSplitOptions.RemoveEmptyEntries).Length;

    /// <summary>Elimina espacios al inicio y al final.</summary>
    public static string SinEspacios(this string texto) => texto.Trim();

    /// <summary>Retorna el mayor elemento de un arreglo.</summary>
    public static int Mayor(this int[] arreglo) => arreglo.Max();

    /// <summary>Retorna el menor elemento de un arreglo.</summary>
    public static int Menor(this int[] arreglo) => arreglo.Min();
}
