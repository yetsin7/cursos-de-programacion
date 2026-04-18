// ============================================================
// Capitulo 01 — Introduccion a C#
// Temas: salida por consola, variables, comentarios,
//        top-level statements y estructura basica
// ============================================================
//
// Este archivo ensena el primer contacto con C# mostrando dos ideas:
// 1. como escribir instrucciones que .NET pueda ejecutar;
// 2. como una aplicacion de consola produce salida visible.
//
// Cuando ejecutas este programa, .NET compila el codigo, carga el runtime y
// empieza a ejecutar las instrucciones de arriba hacia abajo.
// ============================================================

// --- Top-level statements (C# 9+) ---
// En C# moderno no hace falta declarar Main de forma explicita para ejemplos
// sencillos. El compilador genera la estructura necesaria automaticamente.

// Console.WriteLine envia texto a la consola y agrega salto de linea.
Console.WriteLine("¡Hola, mundo!");

// Console.Write no agrega salto de linea al final.
Console.Write("Nombre: ");
Console.WriteLine("C Sharp");

// Separador visual
Console.WriteLine("-----------------------------------");

// --- Variables basicas ---
// Una variable nombra un dato que el programa necesita conservar en memoria.
// C# puede declarar el tipo explicitamente o inferirlo con var.
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

// --- Estructura clasica con clase ---
// Aunque los top-level statements son comodos para aprender, en software real
// solemos organizar el codigo en clases, archivos y namespaces.
Console.WriteLine("\n--- Usando clase explícita ---");
Saludo.Mostrar("Mundo");
Saludo.Mostrar("Programador");

Console.WriteLine("\n--- Información del entorno ---");
Console.WriteLine($"Versión .NET   : {Environment.Version}");
Console.WriteLine($"Sistema Operativo: {Environment.OSVersion}");
Console.WriteLine($"Directorio actual: {Environment.CurrentDirectory}");

// ============================================================
// Clase auxiliar definida en el mismo archivo.
// En proyectos reales normalmente iria en su propio archivo .cs.
// ============================================================

/// <summary>
/// Clase de ejemplo para demostrar la estructura clase/metodo.
/// </summary>
static class Saludo
{
    /// <summary>
    /// Muestra un saludo personalizado en la consola.
    /// Recibe un nombre y construye un mensaje visible para el usuario.
    /// </summary>
    /// <param name="nombre">El nombre al que se saluda.</param>
    public static void Mostrar(string nombre)
    {
        Console.WriteLine($"¡Hola, {nombre}! Bienvenido a C#.");
    }
}
