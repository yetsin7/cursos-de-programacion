// ============================================================
// Capítulo 08 — Interfaces y abstracciones
// Temas: interfaces, implementación explícita, default methods
//        (C# 8+), IComparable, IDisposable, interfaz personalizada
// ============================================================

Console.WriteLine("=== Interfaz personalizada IDescribible ===");

IDescribible[] elementos =
{
    new Libro("El Quijote", "Cervantes", 863),
    new Pelicula("Interstellar", 2014, 169),
    new Cancion("Bohemian Rhapsody", "Queen", 354)
};

foreach (IDescribible e in elementos)
    Console.WriteLine($"  {e.Describir()}");

Console.WriteLine("\n=== IComparable<T> — Ordenamiento ===");

List<Empleado> empleados = new()
{
    new Empleado("Ana",   45_000m),
    new Empleado("Luis",  62_000m),
    new Empleado("María", 38_000m),
    new Empleado("Pedro", 71_000m)
};

// Sort() usa CompareTo() automáticamente
empleados.Sort();

Console.WriteLine("Ordenados por salario (ascendente):");
foreach (var e in empleados)
    Console.WriteLine($"  {e.Nombre,-8} : {e.Salario:C0}");

Console.WriteLine("\n=== Default interface methods (C# 8+) ===");

ILogger logger = new ConsoleLogger("MiApp");
logger.LogInfo("Aplicación iniciada");
logger.LogError("Algo salió mal");
logger.Log("Mensaje sin formato");

Console.WriteLine("\n=== Implementación explícita ===");

var viajero = new Viajero("Carlos");

// Se puede llamar directamente a los métodos propios de la clase
viajero.Presentarse();

// Los métodos de la interfaz solo se acceden a través del tipo de la interfaz
((ITerrestre)viajero).Moverse();
((IAereo)viajero).Moverse();

Console.WriteLine("\n=== IDisposable — Patrón using ===");

// 'using' garantiza que Dispose() se llame aunque ocurra una excepción
using (var recurso = new RecursoExterno("base_de_datos"))
{
    recurso.Usar();
    recurso.Usar();
}
// Aquí ya se llamó a Dispose() automáticamente

// Con la sintaxis moderna (C# 8+) sin bloque {}
using var recurso2 = new RecursoExterno("archivo_log");
recurso2.Usar();
// Dispose() se llama al salir del scope (fin del método)

// ============================================================
// Definición de interfaces y clases
// ============================================================

/// <summary>Contrato que garantiza que un objeto puede describirse a sí mismo.</summary>
interface IDescribible
{
    /// <summary>Retorna una descripción del objeto.</summary>
    string Describir();
}

/// <summary>Contrato para elementos con metadatos de creación.</summary>
interface IMetadatable
{
    /// <summary>Año de creación o publicación.</summary>
    int Anio { get; }
}

/// <summary>Interfaz de logging con métodos por defecto (C# 8+).</summary>
interface ILogger
{
    /// <summary>Registra un mensaje sin formato.</summary>
    void Log(string mensaje);

    /// <summary>Registra un mensaje de error con prefijo automático.</summary>
    void LogError(string mensaje) => Log($"[ERROR] {mensaje}");

    /// <summary>Registra un mensaje informativo con prefijo automático.</summary>
    void LogInfo(string mensaje)  => Log($"[INFO]  {mensaje}");
}

/// <summary>Interfaz para movimiento terrestre.</summary>
interface ITerrestre { void Moverse(); }

/// <summary>Interfaz para movimiento aéreo.</summary>
interface IAereo     { void Moverse(); }

/// <summary>Libro que implementa IDescribible e IMetadatable.</summary>
class Libro : IDescribible, IMetadatable
{
    public string Titulo  { get; }
    public string Autor   { get; }
    public int    Paginas { get; }
    public int    Anio    { get; } = 0;

    public Libro(string titulo, string autor, int paginas)
    {
        Titulo  = titulo;
        Autor   = autor;
        Paginas = paginas;
    }

    /// <summary>Describe el libro con título, autor y páginas.</summary>
    public string Describir() => $"Libro: '{Titulo}' de {Autor} ({Paginas} págs.)";
}

/// <summary>Película que implementa IDescribible.</summary>
class Pelicula : IDescribible
{
    public string Titulo   { get; }
    public int    Anio     { get; }
    public int    Minutos  { get; }

    public Pelicula(string titulo, int anio, int minutos)
    {
        Titulo  = titulo;
        Anio    = anio;
        Minutos = minutos;
    }

    public string Describir() => $"Película: '{Titulo}' ({Anio}) — {Minutos} min";
}

/// <summary>Canción que implementa IDescribible.</summary>
class Cancion : IDescribible
{
    public string Titulo    { get; }
    public string Artista   { get; }
    public int    Duracion  { get; }

    public Cancion(string titulo, string artista, int duracionSegundos)
    {
        Titulo   = titulo;
        Artista  = artista;
        Duracion = duracionSegundos;
    }

    public string Describir() =>
        $"Canción: '{Titulo}' - {Artista} ({Duracion / 60}:{Duracion % 60:D2})";
}

/// <summary>Empleado con ordenamiento por salario via IComparable.</summary>
class Empleado : IComparable<Empleado>
{
    public string  Nombre  { get; }
    public decimal Salario { get; }

    public Empleado(string nombre, decimal salario)
    {
        Nombre  = nombre;
        Salario = salario;
    }

    /// <summary>Compara por salario para permitir ordenamiento automático.</summary>
    public int CompareTo(Empleado? other) =>
        Salario.CompareTo(other?.Salario ?? 0);
}

/// <summary>Logger que escribe en la consola. Implementa ILogger.</summary>
class ConsoleLogger : ILogger
{
    private readonly string _contexto;
    public ConsoleLogger(string contexto) => _contexto = contexto;

    /// <summary>Escribe el mensaje en la consola con contexto.</summary>
    public void Log(string mensaje) =>
        Console.WriteLine($"  [{_contexto}] {mensaje}");
}

/// <summary>Viajero que puede moverse por tierra o por aire (implementación explícita).</summary>
class Viajero : ITerrestre, IAereo
{
    public string Nombre { get; }
    public Viajero(string nombre) => Nombre = nombre;

    public void Presentarse() => Console.WriteLine($"  Soy {Nombre}, puedo viajar de distintas formas.");

    /// <summary>Movimiento terrestre (accesible solo via ITerrestre).</summary>
    void ITerrestre.Moverse() => Console.WriteLine($"  {Nombre} viaja en tren por tierra.");

    /// <summary>Movimiento aéreo (accesible solo via IAereo).</summary>
    void IAereo.Moverse() => Console.WriteLine($"  {Nombre} vuela en avión.");
}

/// <summary>
/// Recurso externo que debe liberarse. Implementa IDisposable.
/// Permite el uso del patrón 'using'.
/// </summary>
class RecursoExterno : IDisposable
{
    private readonly string _nombre;
    private bool _liberado = false;

    public RecursoExterno(string nombre)
    {
        _nombre = nombre;
        Console.WriteLine($"  [{_nombre}] Recurso abierto.");
    }

    /// <summary>Simula el uso del recurso.</summary>
    public void Usar() => Console.WriteLine($"  [{_nombre}] Usando el recurso...");

    /// <summary>Libera el recurso. Llamado automáticamente por 'using'.</summary>
    public void Dispose()
    {
        if (!_liberado)
        {
            Console.WriteLine($"  [{_nombre}] Recurso liberado (Dispose).");
            _liberado = true;
        }
    }
}
