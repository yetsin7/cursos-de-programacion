# Capítulo 08 — Interfaces y abstracciones

## ¿Qué es una interfaz?

Una **interfaz** es un contrato que define qué métodos y propiedades debe tener una clase, sin implementarlos (a menos que se usen *default methods*). Es la forma de lograr **herencia múltiple** en C#.

```csharp
interface IDescribible
{
    string Describir();  // contrato: toda clase que implemente esto debe tener Describir()
}

class Producto : IDescribible
{
    public string Nombre { get; set; } = "";
    public string Describir() => $"Producto: {Nombre}";
}
```

---

## Implementación múltiple

Una clase puede implementar múltiples interfaces:

```csharp
class Empleado : IDescribible, IComparable<Empleado>, ICloneable
{
    public string Nombre { get; set; } = "";
    public decimal Salario { get; set; }

    public string Describir() => $"{Nombre} - {Salario:C2}";
    public int CompareTo(Empleado? other) => Salario.CompareTo(other?.Salario);
    public object Clone() => MemberwiseClone();
}
```

---

## Default interface methods (C# 8+)

A partir de C# 8, las interfaces pueden tener implementaciones por defecto:

```csharp
interface ILogger
{
    void Log(string mensaje);

    // Método con implementación por defecto
    void LogError(string mensaje) => Log($"[ERROR] {mensaje}");
    void LogInfo(string mensaje)  => Log($"[INFO]  {mensaje}");
}
```

---

## Implementación explícita

Cuando una clase implementa dos interfaces con el mismo nombre de método:

```csharp
interface IA { void Hacer(); }
interface IB { void Hacer(); }

class Clase : IA, IB
{
    // Implementación explícita: se invoca solo a través de la interfaz
    void IA.Hacer() => Console.WriteLine("IA.Hacer");
    void IB.Hacer() => Console.WriteLine("IB.Hacer");
}

var c = new Clase();
((IA)c).Hacer();  // IA.Hacer
((IB)c).Hacer();  // IB.Hacer
```

---

## Interfaces estándar del framework

| Interfaz               | Propósito                                    |
|------------------------|----------------------------------------------|
| `IComparable<T>`       | Comparación para ordenamiento                |
| `IEquatable<T>`        | Comparación de igualdad personalizada        |
| `IEnumerable<T>`       | Iteración con `foreach`                      |
| `IDisposable`          | Liberación de recursos (patrón `using`)      |
| `ICloneable`           | Clonación de objetos                         |
| `IFormattable`         | Formateo personalizado de `ToString()`       |

---

## Interfaces vs Clases abstractas

| Característica                | Interfaz                        | Clase abstracta                |
|-------------------------------|---------------------------------|--------------------------------|
| Puede tener campos            | No                              | Sí                             |
| Puede tener constructor       | No                              | Sí                             |
| Herencia múltiple             | Sí                              | No                             |
| Método sin implementar        | Sí (todos, salvo default)       | Solo los marcados `abstract`   |
| Modificadores de acceso       | `public` por defecto            | Todos los modificadores        |
| Cuando usarla                 | Definir un contrato compartido  | Compartir código base común    |

---

## Ejecutar el ejemplo

```bash
cd 08-interfaces-y-abstracciones
dotnet run
```
