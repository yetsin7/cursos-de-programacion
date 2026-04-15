// ============================================================
// Capítulo 12 — Async y Tasks
// Temas: async/await, Task<T>, Task.Run, Task.WhenAll,
//        CancellationToken, HttpClient básico
// ============================================================

Console.WriteLine("=== async / await básico ===");

// Llamar un método async desde el programa principal
string mensaje = await SaludarAsync("Yetsin");
Console.WriteLine(mensaje);

Console.WriteLine("\n=== Task.Delay — simular operación lenta ===");

var inicio = DateTime.Now;
await SimularDescargaAsync("archivo.zip", 800);
Console.WriteLine($"Tiempo transcurrido: {(DateTime.Now - inicio).TotalMilliseconds:F0} ms");

Console.WriteLine("\n=== Task.Run — trabajo en el ThreadPool ===");

Console.WriteLine("Calculando número primo (CPU intensivo)...");
inicio = DateTime.Now;

// Task.Run mueve el trabajo pesado a un hilo secundario del ThreadPool
bool esPrimo = await Task.Run(() => EsPrimoLento(999_983));

Console.WriteLine($"¿999,983 es primo? {esPrimo}");
Console.WriteLine($"Tiempo: {(DateTime.Now - inicio).TotalMilliseconds:F0} ms");

Console.WriteLine("\n=== Tareas en paralelo con Task.WhenAll ===");

inicio = DateTime.Now;

// Ejecución secuencial (lenta): esperaría 300ms + 500ms + 200ms = 1000ms
// Ejecución paralela: espera solo lo que tarde la más lenta (~500ms)
var tareas = new[]
{
    SimularDescargaAsync("documento.pdf",  300),
    SimularDescargaAsync("imagen.png",     500),
    SimularDescargaAsync("datos.json",     200)
};

await Task.WhenAll(tareas);
Console.WriteLine($"Todas las descargas completadas en: {(DateTime.Now - inicio).TotalMilliseconds:F0} ms");

Console.WriteLine("\n=== Task con retorno de valor ===");

var tareaTemperatura = ObtenerTemperaturaAsync("Managua");
var tareaHumedad     = ObtenerHumedadAsync("Managua");

// Esperar ambas en paralelo
await Task.WhenAll(tareaTemperatura, tareaHumedad);

Console.WriteLine($"Temperatura : {tareaTemperatura.Result:F1}°C");
Console.WriteLine($"Humedad     : {tareaHumedad.Result:F1}%");

Console.WriteLine("\n=== Task.WhenAny — la primera en terminar ===");

var tareaRapida = EsperarAsync("Servidor A (300ms)", 300);
var tareaMedia  = EsperarAsync("Servidor B (700ms)", 700);
var tareaLenta  = EsperarAsync("Servidor C (1200ms)", 1200);

var primera = await Task.WhenAny(tareaRapida, tareaMedia, tareaLenta);
Console.WriteLine($"Primera en responder: {await primera}");

Console.WriteLine("\n=== CancellationToken — cancelar operaciones ===");

var cts = new CancellationTokenSource();
cts.CancelAfter(TimeSpan.FromMilliseconds(400)); // cancela después de 400ms

try
{
    await OperacionCancelableAsync("Proceso largo", 1000, cts.Token);
    Console.WriteLine("Operación completada (no debería llegar aquí)");
}
catch (OperationCanceledException)
{
    Console.WriteLine("Operación cancelada correctamente por timeout.");
}

Console.WriteLine("\n=== HttpClient — llamada HTTP real ===");

await EjecutarPeticionHttpAsync();

// ============================================================
// Métodos async del programa
// ============================================================

/// <summary>Simula un saludo asíncrono con pequeña demora.</summary>
async Task<string> SaludarAsync(string nombre)
{
    await Task.Delay(100);  // simula consulta a base de datos
    return $"¡Hola, {nombre}! Este mensaje fue generado de forma asíncrona.";
}

/// <summary>Simula la descarga de un archivo con demora configurable.</summary>
async Task SimularDescargaAsync(string nombre, int milisegundos)
{
    Console.WriteLine($"  Iniciando descarga: {nombre}");
    await Task.Delay(milisegundos);
    Console.WriteLine($"  Descarga completa : {nombre} ({milisegundos}ms)");
}

/// <summary>
/// Verifica si un número es primo usando un método lento intencional.
/// Diseñado para ejecutarse en Task.Run (CPU intensivo).
/// </summary>
bool EsPrimoLento(int n)
{
    if (n < 2) return false;
    for (int i = 2; i <= Math.Sqrt(n); i++)
        if (n % i == 0) return false;
    return true;
}

/// <summary>Simula la obtención de temperatura de forma asíncrona.</summary>
async Task<double> ObtenerTemperaturaAsync(string ciudad)
{
    await Task.Delay(300);
    return ciudad == "Managua" ? 34.5 : 22.0;
}

/// <summary>Simula la obtención de humedad de forma asíncrona.</summary>
async Task<double> ObtenerHumedadAsync(string ciudad)
{
    await Task.Delay(250);
    return ciudad == "Managua" ? 78.3 : 65.0;
}

/// <summary>Espera el tiempo indicado y retorna el nombre del servidor.</summary>
async Task<string> EsperarAsync(string nombre, int ms)
{
    await Task.Delay(ms);
    return nombre;
}

/// <summary>
/// Operación que respeta el CancellationToken en cada iteración.
/// Lanza OperationCanceledException si se cancela.
/// </summary>
async Task OperacionCancelableAsync(string nombre, int duracionMs, CancellationToken token)
{
    int pasos = duracionMs / 100;
    for (int i = 0; i < pasos; i++)
    {
        // Verifica si se solicitó cancelación antes de cada paso
        token.ThrowIfCancellationRequested();
        Console.WriteLine($"  [{nombre}] Paso {i + 1}/{pasos}");
        await Task.Delay(100, token);
    }
    Console.WriteLine($"  [{nombre}] Completado.");
}

/// <summary>
/// Ejemplo de HttpClient con manejo de errores y timeout.
/// Usa una API pública gratuita para demostrar el concepto.
/// </summary>
async Task EjecutarPeticionHttpAsync()
{
    using var cliente = new HttpClient
    {
        Timeout = TimeSpan.FromSeconds(5)
    };

    try
    {
        // API pública de ejemplo (no requiere autenticación)
        string url = "https://jsonplaceholder.typicode.com/todos/1";
        Console.WriteLine($"  GET {url}");

        string respuesta = await cliente.GetStringAsync(url);

        // Mostrar solo las primeras líneas del JSON
        var lineas = respuesta.Split('\n').Take(5);
        foreach (var linea in lineas)
            Console.WriteLine($"  {linea}");
    }
    catch (HttpRequestException ex)
    {
        Console.WriteLine($"  [HTTP Error] {ex.Message}");
        Console.WriteLine("  (Verifica tu conexión a internet para este ejemplo)");
    }
    catch (TaskCanceledException)
    {
        Console.WriteLine("  [Timeout] La petición tardó demasiado.");
    }
}
