# Capítulo 10 — Manejo de errores

## ¿Qué son las excepciones?

Una **excepción** es un evento que ocurre durante la ejecución de un programa que interrumpe el flujo normal. En C#, todas las excepciones heredan de `System.Exception`.

---

## `try` / `catch` / `finally`

```csharp
try
{
    // Código que puede fallar
    int resultado = 10 / 0;
}
catch (DivideByZeroException ex)
{
    // Se ejecuta si ocurre esa excepción específica
    Console.WriteLine($"Error: {ex.Message}");
}
catch (Exception ex)
{
    // Captura cualquier otra excepción
    Console.WriteLine($"Error inesperado: {ex.Message}");
}
finally
{
    // SIEMPRE se ejecuta, con o sin excepción
    Console.WriteLine("Esto siempre se ejecuta");
}
```

---

## Jerarquía de excepciones comúnes

```
System.Exception
├── System.SystemException
│   ├── System.ArgumentException
│   │   ├── System.ArgumentNullException
│   │   └── System.ArgumentOutOfRangeException
│   ├── System.InvalidOperationException
│   ├── System.NullReferenceException
│   ├── System.IndexOutOfRangeException
│   ├── System.OverflowException
│   ├── System.FormatException
│   ├── System.DivideByZeroException
│   └── System.IO.IOException
│       ├── System.IO.FileNotFoundException
│       └── System.IO.DirectoryNotFoundException
└── System.ApplicationException
    └── (tus excepciones personalizadas aquí)
```

---

## excepciones personalizadas

```csharp
// Convención: el nombre termina en "Exception"
class SaldoInsuficienteException : Exception
{
    public decimal SaldoActual  { get; }
    public decimal MontoSolicitado { get; }

    public SaldoInsuficienteException(decimal saldo, decimal monto)
        : base($"Saldo insuficiente. Tienes {saldo:C2}, necesitas {monto:C2}.")
    {
        SaldoActual    = saldo;
        MontoSolicitado = monto;
    }
}
```

---

## `throw` y `throw ex`

```csharp
// 'throw' (sin argumento): relanza la excepción preservando el stack trace
catch (Exception ex)
{
    Log(ex);
    throw;        // CORRECTO: preserva el stack trace original
    // throw ex;  // INCORRECTO: resetea el stack trace
}

// Lanzar excepción propia
if (saldo < monto)
    throw new SaldoInsuficienteException(saldo, monto);
```

---

## `when` — Filtro en catch

```csharp
catch (HttpRequestException ex) when (ex.StatusCode == HttpStatusCode.NotFound)
{
    Console.WriteLine("El recurso no fue encontrado (404)");
}
```

---

## `using` — Garantizar liberación de recursos

```csharp
// El objeto se libera (Dispose) al salir del bloque, incluso si hay excepción
using (var archivo = new StreamReader("datos.txt"))
{
    string contenido = archivo.ReadToEnd();
}

// Sintaxis moderna (C# 8+)
using var archivo = new StreamReader("datos.txt");
// se libera al salir del scope
```

---

## Buenas prácticas

1. Captura la excepción **más específica** primero
2. No captures `Exception` si no sabes cómo manejarla — déjala propagar
3. No uses excepciones para control de flujo normal
4. Siempre incluye `finally` o `using` para liberar recursos
5. Al relanzar, usa `throw` (sin argumento) para preservar el stack trace
6. Las excepciones personalizadas deben tener al menos 3 constructores (convención .NET)

---

## Ejecutar el ejemplo

```bash
cd 10-manejo-de-errores
dotnet run
```
