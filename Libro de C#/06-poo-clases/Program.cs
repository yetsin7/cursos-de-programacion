// ============================================================
// Capítulo 06 — POO: Clases y objetos
// Temas: clases, propiedades, constructores, encapsulamiento,
//        static, record types (C# 9+), object initializers
// ============================================================

Console.WriteLine("=== Clase Persona básica ===");

var persona1 = new Persona("Ana García", 28);
var persona2 = new Persona("Luis Mendoza", 35, "Nicaragua");

Console.WriteLine(persona1.Presentarse());
Console.WriteLine(persona2.Presentarse());
Console.WriteLine($"¿Es mayor de edad? {persona1.EsMayorDeEdad()}");

Console.WriteLine("\n=== Object initializer ===");

// Se puede inicializar propiedades sin llamar el constructor con parámetros
var persona3 = new Persona
{
    Nombre = "Carlos",
    Edad   = 22,
    Pais   = "Honduras"
};
Console.WriteLine(persona3.Presentarse());

Console.WriteLine("\n=== Propiedades con validación ===");

var producto = new Producto("Café Nicaragüense", 5.50m);
Console.WriteLine(producto);

producto.Precio = 6.00m;
Console.WriteLine($"Precio actualizado: {producto.Precio:C2}");

// Intentar precio negativo lanza excepción (manejada)
try
{
    producto.Precio = -1.0m;
}
catch (ArgumentException ex)
{
    Console.WriteLine($"Error esperado: {ex.Message}");
}

Console.WriteLine("\n=== Miembros estáticos ===");

Console.WriteLine($"Instancias creadas: {Persona.TotalInstancias}");
new Persona("Extra 1", 20);
new Persona("Extra 2", 30);
Console.WriteLine($"Instancias creadas: {Persona.TotalInstancias}");

Console.WriteLine("\n=== Record types (C# 9+) ===");

var punto1 = new Punto(1.0, 2.0);
var punto2 = new Punto(1.0, 2.0);
var punto3 = new Punto(3.0, 4.0);

// Los records comparan por valor, no por referencia
Console.WriteLine($"punto1 == punto2: {punto1 == punto2}");  // true
Console.WriteLine($"punto1 == punto3: {punto1 == punto3}");  // false
Console.WriteLine($"punto1: {punto1}");                       // Punto { X = 1, Y = 2 }

// 'with' crea una copia modificando solo los campos indicados
var punto4 = punto1 with { X = 99.0 };
Console.WriteLine($"punto4 (copia de punto1 con X=99): {punto4}");

Console.WriteLine("\n=== Record con métodos personalizados ===");

var rect = new Rectangulo(4.0, 3.0);
Console.WriteLine($"Rectángulo {rect.Ancho}×{rect.Alto}");
Console.WriteLine($"Área      : {rect.Area():F2}");
Console.WriteLine($"Perímetro : {rect.Perimetro():F2}");

// ============================================================
// Definición de clases
// ============================================================

/// <summary>
/// Representa a una persona con nombre, edad y país de origen.
/// Demuestra propiedades, constructores y miembros estáticos.
/// </summary>
class Persona
{
    // Campo estático: cuenta todas las instancias creadas
    private static int _totalInstancias = 0;

    // Propiedad de solo lectura estática
    public static int TotalInstancias => _totalInstancias;

    // Propiedad con respaldo privado para validación
    private int _edad;

    /// <summary>Nombre completo de la persona.</summary>
    public string Nombre { get; set; } = "";

    /// <summary>Edad de la persona. No puede ser negativa.</summary>
    public int Edad
    {
        get => _edad;
        set => _edad = value >= 0
            ? value
            : throw new ArgumentOutOfRangeException(nameof(value), "La edad no puede ser negativa.");
    }

    /// <summary>País de origen.</summary>
    public string Pais { get; set; } = "Nicaragua";

    /// <summary>Propiedad calculada: nombre en mayúsculas.</summary>
    public string NombreMayus => Nombre.ToUpper();

    /// <summary>Constructor sin parámetros (para object initializer).</summary>
    public Persona()
    {
        _totalInstancias++;
    }

    /// <summary>Constructor con nombre y edad.</summary>
    public Persona(string nombre, int edad) : this()
    {
        Nombre = nombre;
        Edad   = edad;
    }

    /// <summary>Constructor con nombre, edad y país.</summary>
    public Persona(string nombre, int edad, string pais) : this(nombre, edad)
    {
        Pais = pais;
    }

    /// <summary>Devuelve una presentación completa de la persona.</summary>
    public string Presentarse() =>
        $"Hola, soy {Nombre}, tengo {Edad} años y soy de {Pais}.";

    /// <summary>Indica si la persona es mayor de edad (18+).</summary>
    public bool EsMayorDeEdad() => Edad >= 18;

    /// <summary>Representación textual del objeto.</summary>
    public override string ToString() => $"Persona({Nombre}, {Edad}, {Pais})";
}

/// <summary>
/// Representa un producto con nombre y precio validado.
/// Demuestra propiedades con lógica de acceso.
/// </summary>
class Producto
{
    private decimal _precio;

    /// <summary>Nombre del producto.</summary>
    public string Nombre { get; set; }

    /// <summary>Precio del producto. No puede ser negativo.</summary>
    public decimal Precio
    {
        get => _precio;
        set => _precio = value >= 0
            ? value
            : throw new ArgumentException("El precio no puede ser negativo.");
    }

    /// <summary>Crea un producto con nombre y precio inicial.</summary>
    public Producto(string nombre, decimal precio)
    {
        Nombre = nombre;
        Precio = precio;
    }

    /// <summary>Representación textual del producto.</summary>
    public override string ToString() => $"Producto: {Nombre} — {Precio:C2}";
}

/// <summary>
/// Punto en el espacio 2D usando record type inmutable.
/// Los records tienen igualdad por valor automáticamente.
/// </summary>
record Punto(double X, double Y);

/// <summary>
/// Rectángulo como record con métodos calculados.
/// </summary>
record Rectangulo(double Ancho, double Alto)
{
    /// <summary>Calcula el área del rectángulo.</summary>
    public double Area() => Ancho * Alto;

    /// <summary>Calcula el perímetro del rectángulo.</summary>
    public double Perimetro() => 2 * (Ancho + Alto);
}
