# Capítulo 06 — POO: Clases y objetos

## ¿Qué es la Programación Orientada a Objetos?

La POO organiza el código alrededor de **objetos** que combinan datos (propiedades) y comportamiento (métodos). Los cuatro pilares son:

1. **Encapsulamiento**: ocultar los detalles internos
2. **herencia**: reutilizar código de clases existentes
3. **Polimorfismo**: un mismo método con comportamientos distintos
4. **Abstracción**: simplificar la complejidad

---

## Clases y objetos

```csharp
// Definición de clase
class Persona
{
    // Propiedades auto-implementadas
    public string Nombre { get; set; } = "";
    public int Edad { get; set; }

    // Constructor
    public Persona(string nombre, int edad)
    {
        Nombre = nombre;
        Edad = edad;
    }

    // Método
    public string Presentarse() =>
        $"Hola, soy {Nombre} y tengo {Edad} años.";
}

// Creación de objeto (instancia)
var persona = new Persona("Ana", 28);
Console.WriteLine(persona.Presentarse());
```

---

## Propiedades

### Propiedad auto-implementada
```csharp
public string Nombre { get; set; }
```

### Propiedad con lógica de validación
```csharp
private int _edad;
public int Edad
{
    get => _edad;
    set => _edad = value >= 0 ? value : throw new ArgumentException("Edad inválida");
}
```

### Propiedad de solo lectura
```csharp
public string Nombre { get; }          // solo se asigna en el constructor
public string NombreMayus => Nombre.ToUpper();  // calculada
```

### `init` — Solo se asigna en la inicialización (C# 9+)
```csharp
public string Nombre { get; init; }   // puede asignarse con object initializer
var p = new Persona { Nombre = "Luis" };
// p.Nombre = "otro"; ← error en tiempo de compilación
```

---

## Constructores

```csharp
class Producto
{
    // Constructor principal
    public Producto(string nombre, decimal precio)
    {
        Nombre = nombre;
        Precio = precio;
    }

    // Constructor secundario que delega al principal
    public Producto(string nombre) : this(nombre, 0.0m) { }

    // Constructor sin parámetros
    public Producto() : this("Sin nombre", 0.0m) { }
}
```

---

## Modificadores de acceso

| Modificador          | Acceso                                |
|----------------------|---------------------------------------|
| `public`             | Desde cualquier parte                 |
| `private`            | Solo dentro de la clase               |
| `protected`          | Clase + clases derivadas              |
| `internal`           | Solo dentro del mismo ensamblado      |
| `protected internal` | Ensamblado actual + clases derivadas  |
| `private protected`  | Clase actual + derivadas del ensamblado |

---

## Record types (C# 9+)

Los `record` son clases inmutables por defecto, ideales para datos:

```csharp
// Record con propiedades posicionales
record Punto(double X, double Y);

var p1 = new Punto(1.0, 2.0);
var p2 = new Punto(1.0, 2.0);

Console.WriteLine(p1 == p2);  // true (igualdad por valor, no referencia)
Console.WriteLine(p1);         // Punto { X = 1, Y = 2 }

// Crear copia modificando solo algunos campos
var p3 = p1 with { X = 5.0 };
```

---

## `static` — Miembros de clase

```csharp
class Contador
{
    // Campo estático: compartido por todas las instancias
    private static int _total = 0;

    public Contador() => _total++;

    // Propiedad estática
    public static int Total => _total;
}
```

---

## Ejecutar el ejemplo

```bash
cd 06-poo-clases
dotnet run
```
