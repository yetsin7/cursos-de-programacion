# Capítulo 07 — herencia y polimorfismo

## ¿Qué es la herencia?

La herencia permite que una clase (**clase derivada / hija**) herede los miembros de otra (**clase base / padre**), reutilizando y extendiendo su comportamiento.

```csharp
// Clase base
class Animal
{
    public string Nombre { get; }
    public Animal(string nombre) => Nombre = nombre;

    public virtual string HacerSonido() => "...";
}

// Clase derivada
class Perro : Animal
{
    public Perro(string nombre) : base(nombre) { }

    // override reemplaza el método de la clase base
    public override string HacerSonido() => "¡Guau!";
}
```

---

## Palabras clave clave

| Palabra clave | Significado                                                        |
|---------------|--------------------------------------------------------------------|
| `virtual`     | El método puede ser sobreescrito en clases derivadas               |
| `override`    | Sobreescribe un método `virtual` o `abstract` de la clase base     |
| `abstract`    | El método no tiene implementación y DEBE ser sobreescrito          |
| `sealed`      | Impide que una clase se herede, o que un método se sobreescriba    |
| `base`        | Accede al constructor o métodos de la clase base                   |
| `protected`   | Visible solo en la clase y sus derivadas                           |
| `new`         | Oculta un método de la base (distinto a override, no polimórfico)  |

---

## Polimorfismo

El polimorfismo permite tratar objetos de tipos distintos como si fueran del tipo base:

```csharp
List<Animal> animales = new()
{
    new Perro("Rex"),
    new Gato("Misi"),
    new Pajaro("Piolín")
};

// Cada animal ejecuta su propia versión de HacerSonido()
foreach (Animal a in animales)
    Console.WriteLine($"{a.Nombre}: {a.HacerSonido()}");
```

---

## Clases abstractas

```csharp
abstract class Figura
{
    // Método abstracto: sin implementación
    public abstract double Area();

    // Método concreto: con implementación
    public void MostrarArea() =>
        Console.WriteLine($"Área: {Area():F2}");
}

class Circulo : Figura
{
    private double _radio;
    public Circulo(double radio) => _radio = radio;

    // Debe implementar todos los métodos abstractos
    public override double Area() => Math.PI * _radio * _radio;
}
```

**Diferencias entre clase abstracta e interfaz:**

| Carácterística              | Clase abstracta       | Interfaz                    |
|-----------------------------|-----------------------|-----------------------------|
| Puede tener estado          | Sí (campos)           | No (solo desde C# 8 default) |
| Constructor                 | Sí                    | No                          |
| herencia múltiple           | No (solo una base)    | Sí (múltiples interfaces)   |
| Modificadores de acceso     | Sí                    | Público por defecto         |
| Uso ideal                   | Compartir código base | Definir contratos           |

---

## `sealed` — Prevenir herencia

```csharp
sealed class Singleton
{
    // Esta clase no puede ser heredada
}

class Animal
{
    public virtual void Moverse() => Console.WriteLine("Me muevo");
}

class Perro : Animal
{
    // sealed en override impide que otras clases sobreescriban este método
    public sealed override void Moverse() => Console.WriteLine("Corro");
}
```

---

## Ejecutar el ejemplo

```bash
cd 07-herencia-y-polimorfismo
dotnet run
```
