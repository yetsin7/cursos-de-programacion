# Capítulo 11 — Archivos e I/O

## El namespace `System.IO`

Contiene todas las clases para trabajar con el sistema de archivos:

| Clase / Struct   | Propósito                                              |
|------------------|--------------------------------------------------------|
| `File`           | Métodos estáticos para leer/escribir/copiar archivos   |
| `FileInfo`       | Información y operaciones sobre un archivo específico  |
| `Directory`      | Métodos estáticos para directorios                     |
| `DirectoryInfo`  | Información y operaciones sobre un directorio          |
| `Path`           | Manipulación de rutas de archivos                      |
| `StreamReader`   | Leer texto de flujos                                   |
| `StreamWriter`   | Escribir texto en flujos                               |
| `FileStream`     | Acceso a nivel de bytes a archivos                     |

---

## Leer archivos

```csharp
// Forma rápida: leer todo el contenido
string contenido = File.ReadAllText("datos.txt");

// Leer línea por línea
string[] lineas = File.ReadAllLines("datos.txt");

// StreamReader: más eficiente para archivos grandes
using var lector = new StreamReader("datos.txt");
while (!lector.EndOfStream)
{
    string? linea = lector.ReadLine();
    Console.WriteLine(linea);
}
```

---

## Escribir archivos

```csharp
// Crear o sobreescribir
File.WriteAllText("salida.txt", "Hola, mundo!");

// Agregar al final
File.AppendAllText("log.txt", "Nueva entrada\n");

// StreamWriter para múltiples escrituras
using var escritor = new StreamWriter("reporte.txt", append: true);
escritor.WriteLine("Línea 1");
escritor.WriteLine("Línea 2");
```

---

## Operaciones con rutas — `Path`

```csharp
string ruta = @"C:\proyectos\app\datos.json";

Path.GetFileName(ruta)           // "datos.json"
Path.GetFileNameWithoutExtension(ruta) // "datos"
Path.GetExtension(ruta)          // ".json"
Path.GetDirectoryName(ruta)      // "C:\proyectos\app"
Path.Combine("C:\\app", "datos", "config.json") // combina partes
Path.GetTempPath()               // directorio temporal del sistema
```

---

## `File` — Métodos útiles

```csharp
File.Exists("archivo.txt")           // ¿existe?
File.Copy("origen.txt", "destino.txt")
File.Move("viejo.txt", "nuevo.txt")
File.Delete("basura.txt")
File.GetCreationTime("datos.txt")
File.GetLastWriteTime("datos.txt")
```

---

## JSON con `System.Text.Json`

Disponible en .NET sin instalar paquetes externos:

```csharp
using System.Text.Json;

// Serializar objeto → JSON
var persona = new Persona("Ana", 28);
string json = JsonSerializer.Serialize(persona, new JsonSerializerOptions
{
    WriteIndented = true          // formato legible
});

// Deserializar JSON → objeto
var personaRecuperada = JsonSerializer.Deserialize<Persona>(json);
```

---

## Ejecutar el ejemplo

```bash
cd 11-archivos-e-io
dotnet run
```
