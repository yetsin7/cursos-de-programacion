// ============================================================
// Capítulo 07 — Herencia y polimorfismo
// Temas: herencia, virtual/override/sealed, clases abstractas,
//        protected, polimorfismo, base keyword
// Jerarquía: Animal → Perro, Gato, Pajaro
// ============================================================

Console.WriteLine("=== Herencia básica ===");

var perro = new Perro("Rex", "Labrador");
var gato  = new Gato("Misi");
Console.WriteLine(perro.Describirse());
Console.WriteLine(gato.Describirse());

Console.WriteLine("\n=== Polimorfismo ===");

// Lista de tipo base Animal que contiene distintos tipos derivados
List<Animal> animales = new()
{
    new Perro("Rex", "Labrador"),
    new Perro("Canela", "Chihuahua"),
    new Gato("Misi"),
    new Gato("Pelusa"),
    new Pajaro("Piolín", true)
};

foreach (Animal a in animales)
{
    // Cada animal ejecuta SU versión del método (polimorfismo dinámico)
    Console.WriteLine($"  {a.Nombre,8} | {a.HacerSonido(),-12} | {a.Moverse()}");
}

Console.WriteLine("\n=== Verificación de tipo con 'is' y 'as' ===");

foreach (Animal a in animales)
{
    // 'is' con pattern variable (C# 7+)
    if (a is Perro p)
        Console.WriteLine($"  {p.Nombre} es un Perro de raza {p.Raza}");

    if (a is Pajaro pajaro && pajaro.PuedaVolar)
        Console.WriteLine($"  {pajaro.Nombre} es un Pájaro que puede volar");
}

Console.WriteLine("\n=== Clase abstracta Figura ===");

List<Figura> figuras = new()
{
    new Circulo(5),
    new Rectangulo(4, 6),
    new Triangulo(3, 4, 5)
};

foreach (Figura f in figuras)
{
    // MostrarInfo está definido en la clase abstracta (método concreto)
    f.MostrarInfo();
}

Console.WriteLine("\n=== 'base' — llamar al constructor/método padre ===");

var animal = new AnimalDomestico("Buddy", "Juan Pérez");
Console.WriteLine(animal.Describirse());

// ============================================================
// Jerarquía de clases Animal
// ============================================================

/// <summary>
/// Clase base abstracta para todos los animales.
/// Define el contrato que deben cumplir las clases derivadas.
/// </summary>
abstract class Animal
{
    /// <summary>Nombre del animal.</summary>
    public string Nombre { get; }

    /// <summary>Constructor base que inicializa el nombre.</summary>
    protected Animal(string nombre)
    {
        Nombre = nombre;
    }

    /// <summary>Sonido característico del animal (debe sobreescribirse).</summary>
    public abstract string HacerSonido();

    /// <summary>Forma de moverse del animal (puede sobreescribirse).</summary>
    public virtual string Moverse() => "camina";

    /// <summary>Descripción completa del animal usando los métodos virtuales.</summary>
    public virtual string Describirse() =>
        $"{GetType().Name} '{Nombre}': hace '{HacerSonido()}' y {Moverse()}";
}

/// <summary>Representa un perro con raza específica.</summary>
class Perro : Animal
{
    /// <summary>Raza del perro.</summary>
    public string Raza { get; }

    /// <summary>Crea un perro con nombre y raza.</summary>
    public Perro(string nombre, string raza) : base(nombre)
    {
        Raza = raza;
    }

    /// <summary>Los perros ladran.</summary>
    public override string HacerSonido() => "¡Guau!";

    /// <summary>Los perros corren.</summary>
    public override string Moverse() => "corre";

    /// <summary>Descripción incluyendo la raza.</summary>
    public override string Describirse() =>
        base.Describirse() + $" | Raza: {Raza}";
}

/// <summary>Representa un gato doméstico.</summary>
class Gato : Animal
{
    public Gato(string nombre) : base(nombre) { }

    /// <summary>Los gatos maúllan.</summary>
    public override string HacerSonido() => "¡Miau!";

    /// <summary>Los gatos se deslizan sigilosamente.</summary>
    public override string Moverse() => "se desliza";
}

/// <summary>Representa un pájaro que puede o no volar.</summary>
class Pajaro : Animal
{
    /// <summary>Indica si el pájaro puede volar.</summary>
    public bool PuedaVolar { get; }

    public Pajaro(string nombre, bool puedaVolar) : base(nombre)
    {
        PuedaVolar = puedaVolar;
    }

    /// <summary>Los pájaros pían.</summary>
    public override string HacerSonido() => "¡Pío!";

    /// <summary>Los pájaros vuelan si pueden, si no, caminan.</summary>
    public override string Moverse() => PuedaVolar ? "vuela" : "camina";
}

/// <summary>Animal doméstico con dueño (herencia de Animal).</summary>
class AnimalDomestico : Animal
{
    protected string NombreDuenio { get; }

    public AnimalDomestico(string nombre, string nombreDuenio) : base(nombre)
    {
        NombreDuenio = nombreDuenio;
    }

    public override string HacerSonido() => "...";

    public override string Describirse() =>
        base.Describirse() + $" | Dueño: {NombreDuenio}";
}

// ============================================================
// Jerarquía abstracta de Figuras geométricas
// ============================================================

/// <summary>
/// Clase abstracta base para figuras geométricas.
/// Define el contrato de área y proporciona un método concreto.
/// </summary>
abstract class Figura
{
    /// <summary>Calcula el área de la figura (debe implementarse).</summary>
    public abstract double Area();

    /// <summary>Calcula el perímetro de la figura (debe implementarse).</summary>
    public abstract double Perimetro();

    /// <summary>Imprime la información completa de la figura.</summary>
    public void MostrarInfo()
    {
        Console.WriteLine($"  {GetType().Name,-12} | Área: {Area(),8:F2} | Perímetro: {Perimetro(),8:F2}");
    }
}

/// <summary>Figura circular definida por su radio.</summary>
class Circulo : Figura
{
    private readonly double _radio;
    public Circulo(double radio) => _radio = radio;
    public override double Area() => Math.PI * _radio * _radio;
    public override double Perimetro() => 2 * Math.PI * _radio;
}

/// <summary>Rectángulo definido por ancho y alto.</summary>
class Rectangulo : Figura
{
    private readonly double _ancho, _alto;
    public Rectangulo(double ancho, double alto) { _ancho = ancho; _alto = alto; }
    public override double Area() => _ancho * _alto;
    public override double Perimetro() => 2 * (_ancho + _alto);
}

/// <summary>Triángulo rectángulo definido por sus tres lados.</summary>
class Triangulo : Figura
{
    private readonly double _a, _b, _c;
    public Triangulo(double a, double b, double c) { _a = a; _b = b; _c = c; }
    public override double Area()
    {
        // Fórmula de Herón
        double s = (_a + _b + _c) / 2;
        return Math.Sqrt(s * (s - _a) * (s - _b) * (s - _c));
    }
    public override double Perimetro() => _a + _b + _c;
}
