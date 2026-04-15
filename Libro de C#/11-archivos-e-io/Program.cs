// ============================================================
// Capítulo 11 — Archivos e I/O
// Temas: File, FileInfo, StreamReader, StreamWriter,
//        Path, Directory, JSON con System.Text.Json
// ============================================================

using System.Text.Json;
using System.Text.Json.Serialization;

// Directorio de trabajo para los ejemplos
string dirTrabajo = Path.Combine(Path.GetTempPath(), "libro_csharp_cap11");
Directory.CreateDirectory(dirTrabajo);
Console.WriteLine($"Directorio de trabajo: {dirTrabajo}");

// ============================================================
// Escritura de archivos
// ============================================================
Console.WriteLine("\n=== Escribir archivo con File.WriteAllText ===");

string archivoTexto = Path.Combine(dirTrabajo, "notas.txt");
File.WriteAllText(archivoTexto, "Primera nota del capítulo 11.\n");
Console.WriteLine($"Archivo creado: {archivoTexto}");

// Agregar contenido sin sobreescribir
File.AppendAllText(archivoTexto, "Segunda nota agregada después.\n");
File.AppendAllText(archivoTexto, "Tercera nota también al final.\n");

// Escribir un arreglo de líneas
string archivoLineas = Path.Combine(dirTrabajo, "lista.txt");
string[] lineas = { "Mango", "Papaya", "Aguacate", "Guayaba", "Maracuyá" };
File.WriteAllLines(archivoLineas, lineas);
Console.WriteLine($"Archivo de líneas creado: {archivoLineas}");

// ============================================================
// Lectura de archivos
// ============================================================
Console.WriteLine("\n=== Leer archivo con File.ReadAllText ===");

string contenido = File.ReadAllText(archivoTexto);
Console.WriteLine(contenido);

Console.WriteLine("=== Leer líneas con File.ReadAllLines ===");

string[] frutasLeidas = File.ReadAllLines(archivoLineas);
for (int i = 0; i < frutasLeidas.Length; i++)
    Console.WriteLine($"  [{i}] {frutasLeidas[i]}");

// ============================================================
// StreamWriter — escritura eficiente
// ============================================================
Console.WriteLine("\n=== StreamWriter para múltiples líneas ===");

string archivoLog = Path.Combine(dirTrabajo, "log.txt");
using (var escritor = new StreamWriter(archivoLog, append: false))
{
    escritor.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss}] Inicio del log");
    escritor.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss}] Aplicación iniciada");
    escritor.WriteLine($"[{DateTime.Now:yyyy-MM-dd HH:mm:ss}] Procesando datos...");
}
Console.WriteLine($"Log escrito: {archivoLog}");

// ============================================================
// StreamReader — lectura eficiente (ideal para archivos grandes)
// ============================================================
Console.WriteLine("\n=== StreamReader línea por línea ===");

using (var lector = new StreamReader(archivoLog))
{
    while (!lector.EndOfStream)
    {
        string? linea = lector.ReadLine();
        Console.WriteLine($"  {linea}");
    }
}

// ============================================================
// Operaciones con Path
// ============================================================
Console.WriteLine("\n=== Path — manipulación de rutas ===");

string ruta = Path.Combine(dirTrabajo, "ejemplo", "config.json");
Console.WriteLine($"Ruta completa         : {ruta}");
Console.WriteLine($"GetFileName           : {Path.GetFileName(ruta)}");
Console.WriteLine($"GetFileNameWithoutExt : {Path.GetFileNameWithoutExtension(ruta)}");
Console.WriteLine($"GetExtension          : {Path.GetExtension(ruta)}");
Console.WriteLine($"GetDirectoryName      : {Path.GetDirectoryName(ruta)}");
Console.WriteLine($"GetTempPath           : {Path.GetTempPath()}");

// ============================================================
// FileInfo — información de un archivo
// ============================================================
Console.WriteLine("\n=== FileInfo ===");

var info = new FileInfo(archivoTexto);
Console.WriteLine($"Nombre    : {info.Name}");
Console.WriteLine($"Tamaño    : {info.Length} bytes");
Console.WriteLine($"Extensión : {info.Extension}");
Console.WriteLine($"Creado    : {info.CreationTime:yyyy-MM-dd HH:mm}");
Console.WriteLine($"Modificado: {info.LastWriteTime:yyyy-MM-dd HH:mm}");

// ============================================================
// JSON con System.Text.Json
// ============================================================
Console.WriteLine("\n=== Serializar objeto → JSON ===");

var personas = new List<PersonaJson>
{
    new("Ana García",    28, "ana@correo.com"),
    new("Luis Mendoza",  35, "luis@correo.com"),
    new("María López",   22, null)
};

var opciones = new JsonSerializerOptions
{
    WriteIndented = true,                                 // formato legible
    DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull // omite nulls
};

string json = JsonSerializer.Serialize(personas, opciones);
Console.WriteLine(json);

// Guardar JSON en archivo
string archivoJson = Path.Combine(dirTrabajo, "personas.json");
File.WriteAllText(archivoJson, json);
Console.WriteLine($"\nJSON guardado en: {archivoJson}");

Console.WriteLine("\n=== Deserializar JSON → objetos ===");

string jsonLeido = File.ReadAllText(archivoJson);
List<PersonaJson>? personasRecuperadas =
    JsonSerializer.Deserialize<List<PersonaJson>>(jsonLeido, opciones);

if (personasRecuperadas is not null)
{
    foreach (var p in personasRecuperadas)
        Console.WriteLine($"  {p.Nombre,-15} | {p.Edad} años | {p.Correo ?? "sin correo"}");
}

// ============================================================
// Limpieza del directorio temporal
// ============================================================
Console.WriteLine("\n=== Listar archivos creados ===");

foreach (string archivo in Directory.GetFiles(dirTrabajo))
    Console.WriteLine($"  {Path.GetFileName(archivo)} ({new FileInfo(archivo).Length} bytes)");

// ============================================================
// Tipos usados en los ejemplos
// ============================================================

/// <summary>Modelo de persona para demostrar serialización JSON.</summary>
record PersonaJson(
    [property: JsonPropertyName("nombre")] string Nombre,
    [property: JsonPropertyName("edad")]   int    Edad,
    [property: JsonPropertyName("correo")] string? Correo
);
