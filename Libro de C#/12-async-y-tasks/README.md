# Capítulo 12 — Async y Tasks

## ¿Por qué programación asíncrona?

En operaciones lentas (I/O, red, base de datos), el código **síncrono** bloquea el hilo de ejecución esperando la respuesta. El código **asíncrono** libera el hilo mientras espera, mejorando el rendimiento y la capacidad de respuesta.

```
Síncrono:   [tarea lenta......] [otra cosa]    ← espera bloqueando
Asíncrono:  [inicio] ···await··· [continúa]   ← el hilo es libre durante la espera
```

---

## `async` y `await`

```csharp
// Un método async debe retornar Task, Task<T>, o void (para event handlers)
async Task<string> ObtenerDatosAsync()
{
    // await "pausa" el método hasta que la Task termine
    // pero libera el hilo de ejecución mientras tanto
    await Task.Delay(1000);  // simula espera de 1 segundo
    return "datos obtenidos";
}

// Llamar un método async
string resultado = await ObtenerDatosAsync();
```

---

## `Task` y `Task<T>`

```csharp
// Task: operación asíncrona sin valor de retorno
async Task EjecutarAsync()
{
    await Task.Delay(500);
    Console.WriteLine("Listo");
}

// Task<T>: operación asíncrona que retorna un valor
async Task<int> ContarAsync()
{
    await Task.Delay(100);
    return 42;
}
```

---

## `Task.Run` — Ejecutar en el ThreadPool

```csharp
// Mueve trabajo CPU-intensivo a un hilo secundario
int resultado = await Task.Run(() =>
{
    // Este código corre en un hilo del ThreadPool
    return CalculoComplejo();
});
```

---

## Ejecutar varias tareas en paralelo

```csharp
// Secuencial (lento): espera una por una
var r1 = await TareaA();   // 2 segundos
var r2 = await TareaB();   // 3 segundos → total: 5 segundos

// Paralelo (rápido): todas a la vez
var t1 = TareaA();
var t2 = TareaB();
await Task.WhenAll(t1, t2);  // total: ~3 segundos (el máximo)

// Obtener resultados
var (res1, res2) = (t1.Result, t2.Result);
```

---

## `CancellationToken` — Cancelar tareas

```csharp
var cts = new CancellationTokenSource();

// Cancelar después de 2 segundos
cts.CancelAfter(TimeSpan.FromSeconds(2));

try
{
    await TareaLargaAsync(cts.Token);
}
catch (OperationCanceledException)
{
    Console.WriteLine("Tarea cancelada.");
}
```

---

## `HttpClient` — Llamadas HTTP

```csharp
using var cliente = new HttpClient();
cliente.BaseAddress = new Uri("https://api.ejemplo.com");

// GET
string json = await cliente.GetStringAsync("/datos");

// GET con deserialización automática
var datos = await cliente.GetFromJsonAsync<MiClase>("/endpoint");

// POST con JSON
var respuesta = await cliente.PostAsJsonAsync("/crear", nuevoObjeto);
```

---

## Reglas importantes

1. Un método `async` debe tener al menos un `await` (sino no es realmente asíncrono)
2. No uses `async void` excepto en event handlers
3. No uses `.Result` o `.Wait()` en código asíncrono — causa deadlocks
4. Pasa `CancellationToken` cuando el usuario pueda cancelar la operación
5. Nombra los métodos async con sufijo `Async` por convención

---

## Ejecutar el ejemplo

```bash
cd 12-async-y-tasks
dotnet run
```
