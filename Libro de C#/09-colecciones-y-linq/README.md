# Capítulo 09 — Colecciones y LINQ

## Colecciones principales

### `List<T>` — Lista dinámica

```csharp
var nombres = new List<string> { "Ana", "Luis", "María" };

nombres.Add("Pedro");
nombres.Remove("Luis");
nombres.Insert(0, "Eva");      // insertar en posición 0

Console.WriteLine(nombres.Count);        // 3
Console.WriteLine(nombres.Contains("Ana")); // true
```

### `Dictionary<TKey, TValue>` — Mapa clave-valor

```csharp
var edades = new Dictionary<string, int>
{
    ["Ana"]   = 28,
    ["Luis"]  = 35,
    ["María"] = 22
};

edades["Pedro"] = 30;  // agregar o sobreescribir

if (edades.TryGetValue("Ana", out int edad))
    Console.WriteLine($"Ana tiene {edad} años");

foreach (var (clave, valor) in edades)
    Console.WriteLine($"{clave}: {valor}");
```

### `HashSet<T>` — Conjunto sin duplicados

```csharp
var tags = new HashSet<string> { "C#", "dotnet", "backend" };

tags.Add("C#");        // no agrega duplicado
tags.Add("linux");

Console.WriteLine(tags.Contains("C#"));  // true
Console.WriteLine(tags.Count);           // 4

// Operaciones de conjuntos
var otros = new HashSet<string> { "C#", "python" };
tags.IntersectWith(otros);  // solo los comunes
```

---

## LINQ — Language Integrated Query

LINQ permite realizar consultas sobre colecciones (y más) usando una sintaxis integrada en C#.

### Dos sintaxis equivalentes

```csharp
var numeros = new[] { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };

// Query syntax (similar a SQL)
var pares = from n in numeros
            where n % 2 == 0
            select n;

// Method syntax (más usada en la práctica)
var pares2 = numeros.Where(n => n % 2 == 0);
```

---

## Métodos LINQ más usados

| Método          | Descripción                                      |
|-----------------|--------------------------------------------------|
| `Where`         | Filtra elementos                                 |
| `Select`        | Proyecta (transforma) elementos                  |
| `OrderBy`       | Ordena ascendente                                |
| `OrderByDescending` | Ordena descendente                           |
| `GroupBy`       | Agrupa elementos                                 |
| `First`         | Primer elemento (lanza si no hay)               |
| `FirstOrDefault`| Primer elemento o valor por defecto             |
| `Single`        | Exactamente un elemento (lanza si hay más)      |
| `Count`         | Cuenta elementos                                 |
| `Sum`           | Suma valores                                     |
| `Average`       | Promedio                                         |
| `Max` / `Min`   | Máximo / mínimo                                  |
| `Any`           | ¿Hay algún elemento que cumpla la condición?    |
| `All`           | ¿Todos cumplen la condición?                    |
| `ToList`        | Materializa a `List<T>`                          |
| `ToArray`       | Materializa a arreglo                            |
| `ToDictionary`  | Materializa a `Dictionary`                       |
| `Distinct`      | Elimina duplicados                               |
| `Take` / `Skip` | Paginación                                       |
| `SelectMany`    | Aplana colecciones anidadas                      |
| `Join`          | Une dos colecciones por clave                    |

---

## Ejecución diferida

LINQ usa **ejecución diferida**: la consulta no se ejecuta hasta que se itera o se materializa con `ToList()`, `ToArray()`, etc.

```csharp
var query = numeros.Where(n => n > 5);  // no se ejecuta aquí
var resultado = query.ToList();          // se ejecuta aquí
```

---

## Ejecutar el ejemplo

```bash
cd 09-colecciones-y-linq
dotnet run
```
