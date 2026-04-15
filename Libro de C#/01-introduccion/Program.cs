// ============================================================
// Capítulo 01 — Introducción a C#
// Temas: hola mundo, Console.WriteLine, variables básicas,
//        comentarios, namespaces, clases y el método Main
// ============================================================

// --- Top-level statements (C# 9+) ---
// A partir de C# 9 no es necesario declarar namespace ni clase.
// El compilador lo hace automáticamente. Ideal para scripts y aprendizaje.

// Imprimir texto en la consola
Console.WriteLine("¡Hola, mundo!");

// Console.Write no agrega salto de línea al final
Console.Write("Nombre: ");
Console.WriteLine("C Sharp");

// Separador visual
Console.WriteLine("-----------------------------------");

// --- Variables básicas ---
// En C# las variables tienen tipo explícito o se infiere con 'var'
string nombre = "Yetsin";       // cadena de texto
int edad = 30;                  // número entero
double altura = 1.75;           // número decimal (doble precisión)
bool activo = true;             // valor verdadero o falso

Console.WriteLine($"Nombre : {nombre}");
Console.WriteLine($"Edad   : {edad} años");
Console.WriteLine($"Altura : {altura} m");
Console.WriteLine($"Activo : {activo}");

Console.WriteLine("-----------------------------------");

// --- Comentarios en C# ---
// Esto es un comentario de una sola línea

/*
   Esto es un comentario
   de múltiples líneas
*/

/// <summary>
/// Esto es un comentario de documentación XML (usado por IntelliSense)
/// </summary>

// --- Estructura clásica con namespace y clase ---
// Aunque los top-level statements son más simples,
// en proyectos reales se organiza el código en namespaces y clases.
Console.WriteLine("\n--- Usando clase explícita ---");
Saludo.Mostrar("Mundo");
Saludo.Mostrar("Programador");

Console.WriteLine("\n--- Información del entorno ---");
Console.WriteLine($"Versión .NET   : {Environment.Version}");
Console.WriteLine($"Sistema Operativo: {Environment.OSVersion}");
Console.WriteLine($"Directorio actual: {Environment.CurrentDirectory}");

// ============================================================
// Clase auxiliar definida en el mismo archivo
// (en proyectos reales iría en su propio archivo .cs)
// ============================================================

/// <summary>
/// Clase de ejemplo para demostrar la estructura namespace/clase/método.
/// </summary>
static class Saludo
{
    /// <summary>
    /// Muestra un saludo personalizado en la consola.
    /// </summary>
    /// <param name="nombre">El nombre al que se saluda.</param>
    public static void Mostrar(string nombre)
    {
        Console.WriteLine($"¡Hola, {nombre}! Bienvenido a C#.");
    }
}
