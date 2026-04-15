# Capítulo 01 — Introducción a C#

## ¿Qué es C#?

**C#** (pronunciado "C Sharp") es un lenguaje de programación moderno, orientado a objetos y con tipado estático, desarrollado por Microsoft como parte de la plataforma **.NET**. Fue creado por Anders Hejlsberg y lanzado en el año 2000.

C# combina la potencia de C++ con la simplicidad de Java, añadiendo características modernas como LINQ, async/await, pattern matching y records.

---

## ¿Qué es .NET?

**.NET** es la plataforma de desarrollo de Microsoft que incluye:

- **CLR** (Common Language Runtime): el motor de ejecución que compila el código a lenguaje máquina
- **BCL** (Base Class Library): miles de clases listas para usar (colecciones, I/O, red, criptografía, etc.)
- **SDK**: herramientas de compilación, ejecución y publicación (`dotnet` CLI)

A partir de **.NET 5**, Microsoft unificó .NET Framework y .NET Core en una sola plataforma multiplataforma (Windows, Linux, macOS).

---

## C# vs Java

| Característica         | C#                             | Java                          |
|------------------------|--------------------------------|-------------------------------|
| Empresa                | Microsoft                      | Oracle                        |
| Plataforma             | .NET (multiplataforma)         | JVM (multiplataforma)         |
| Propiedades            | Nativas (`get`/`set`)          | Getters/setters manuales      |
| Delegados y eventos    | Integrados en el lenguaje      | Interfaces funcionales        |
| LINQ                   | Integrado                      | Streams API (más verboso)     |
| Nullable reference     | Desde C# 8                     | Optional (externo)            |
| Records                | Desde C# 9                     | Desde Java 16                 |
| async/await            | Desde C# 5                     | CompletableFuture (más complejo) |

---

## El ecosistema .NET

- **ASP.NET Core**: framework web (APIs REST, MVC, Razor Pages, Blazor)
- **Entity Framework Core**: ORM para bases de datos
- **MAUI**: desarrollo móvil y de escritorio multiplataforma
- **WPF / WinForms**: aplicaciones de escritorio Windows
- **Blazor**: aplicaciones web con C# en el navegador (WebAssembly)
- **NuGet**: gestor de paquetes (equivalente a npm o Maven)

---

## Estructura básica de un programa C#

```csharp
// Espacio de nombres: organiza el código en grupos lógicos
namespace MiPrograma
{
    // Clase: unidad básica de organización del código
    class Program
    {
        // Método Main: punto de entrada del programa
        static void Main(string[] args)
        {
            Console.WriteLine("¡Hola, mundo!");
        }
    }
}
```

Con **top-level statements** (C# 9+), puedes simplificarlo a:

```csharp
Console.WriteLine("¡Hola, mundo!");
```

---

## Ejecutar el ejemplo

```bash
cd 01-introduccion
dotnet run
```
