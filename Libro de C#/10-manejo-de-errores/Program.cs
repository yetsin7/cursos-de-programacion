// ============================================================
// Capítulo 10 — Manejo de errores
// Temas: try/catch/finally/throw, jerarquía de excepciones,
//        excepciones personalizadas, filtros 'when', using
// ============================================================

Console.WriteLine("=== try / catch / finally ===");

try
{
    int[] arreglo = { 1, 2, 3 };
    Console.WriteLine($"Accediendo índice 5: {arreglo[5]}");  // lanza excepción
}
catch (IndexOutOfRangeException ex)
{
    Console.WriteLine($"[Capturado] Índice fuera de rango: {ex.Message}");
}
finally
{
    Console.WriteLine("[Finally] Siempre se ejecuta, con o sin excepción.");
}

Console.WriteLine("\n=== Múltiples catch (del más específico al más general) ===");

void ProcesarEntrada(string entrada)
{
    try
    {
        int numero = int.Parse(entrada);
        int resultado = 100 / numero;
        Console.WriteLine($"  100 / {numero} = {resultado}");
    }
    catch (FormatException)
    {
        Console.WriteLine($"  [FormatException] '{entrada}' no es un número válido.");
    }
    catch (DivideByZeroException)
    {
        Console.WriteLine($"  [DivideByZeroException] No se puede dividir entre cero.");
    }
    catch (Exception ex)
    {
        Console.WriteLine($"  [Exception] Error inesperado: {ex.Message}");
    }
}

ProcesarEntrada("5");
ProcesarEntrada("abc");
ProcesarEntrada("0");

Console.WriteLine("\n=== Excepción personalizada: SaldoInsuficienteException ===");

var cuenta = new CuentaBancaria("NIC-001", 500m);
Console.WriteLine(cuenta.VerSaldo());

// Retiro exitoso
try
{
    cuenta.Retirar(200m);
    Console.WriteLine(cuenta.VerSaldo());
}
catch (SaldoInsuficienteException ex)
{
    Console.WriteLine($"[Error] {ex.Message}");
}

// Retiro que excede el saldo
try
{
    cuenta.Retirar(1000m);
}
catch (SaldoInsuficienteException ex)
{
    Console.WriteLine($"[Error] {ex.Message}");
    Console.WriteLine($"  Saldo actual   : {ex.SaldoActual:C2}");
    Console.WriteLine($"  Monto solicitado: {ex.MontoSolicitado:C2}");
}

Console.WriteLine("\n=== Filtro 'when' en catch ===");

void ProcesarNumero(int n)
{
    try
    {
        if (n < 0) throw new ArgumentException("El número no puede ser negativo.", nameof(n));
        if (n == 0) throw new ArgumentException("El número no puede ser cero.", nameof(n));
        Console.WriteLine($"  Procesado: {n}");
    }
    catch (ArgumentException ex) when (ex.Message.Contains("negativo"))
    {
        Console.WriteLine($"  [when negativo] {ex.Message}");
    }
    catch (ArgumentException ex) when (ex.Message.Contains("cero"))
    {
        Console.WriteLine($"  [when cero] {ex.Message}");
    }
}

ProcesarNumero(5);
ProcesarNumero(-3);
ProcesarNumero(0);

Console.WriteLine("\n=== Patrón using con IDisposable ===");

// La clase RecursoSimulado libera recursos al salir del bloque
using (var r1 = new RecursoSimulado("Conexión SQL"))
{
    r1.Ejecutar("SELECT 1");
    r1.Ejecutar("SELECT * FROM usuarios");
}

// Forma moderna (C# 8+): el recurso se libera al final del scope
using var r2 = new RecursoSimulado("Archivo de log");
r2.Ejecutar("Escribiendo línea 1");
r2.Ejecutar("Escribiendo línea 2");

Console.WriteLine("\n=== Relanzar excepción preservando stack trace ===");

void NivelProfundo()
{
    throw new InvalidOperationException("Error en la capa profunda.");
}

void NivelMedio()
{
    try { NivelProfundo(); }
    catch (Exception ex)
    {
        Console.WriteLine($"  NivelMedio capturó: {ex.Message}");
        throw;  // CORRECTO: relanza sin modificar el stack trace
    }
}

try { NivelMedio(); }
catch (Exception ex)
{
    Console.WriteLine($"  Nivel principal capturó: {ex.Message}");
}

// ============================================================
// Definición de clases y excepciones personalizadas
// ============================================================

/// <summary>
/// Excepción lanzada cuando no hay suficiente saldo para completar una operación.
/// Sigue las convenciones de excepción .NET (3 constructores estándar + uno personalizado).
/// </summary>
class SaldoInsuficienteException : Exception
{
    /// <summary>Saldo disponible al momento del error.</summary>
    public decimal SaldoActual { get; }

    /// <summary>Monto que se intentó retirar.</summary>
    public decimal MontoSolicitado { get; }

    public SaldoInsuficienteException() : base("Saldo insuficiente.") { }

    public SaldoInsuficienteException(string message) : base(message) { }

    public SaldoInsuficienteException(string message, Exception inner) : base(message, inner) { }

    /// <summary>Constructor con información detallada del error de saldo.</summary>
    public SaldoInsuficienteException(decimal saldoActual, decimal montoSolicitado)
        : base($"Saldo insuficiente: disponible {saldoActual:C2}, solicitado {montoSolicitado:C2}.")
    {
        SaldoActual     = saldoActual;
        MontoSolicitado = montoSolicitado;
    }
}

/// <summary>Cuenta bancaria simple con control de saldo.</summary>
class CuentaBancaria
{
    private decimal _saldo;
    public string Numero { get; }

    public CuentaBancaria(string numero, decimal saldoInicial)
    {
        Numero = numero;
        _saldo = saldoInicial;
    }

    /// <summary>Retira un monto. Lanza SaldoInsuficienteException si no hay fondos.</summary>
    public void Retirar(decimal monto)
    {
        if (monto <= 0)
            throw new ArgumentOutOfRangeException(nameof(monto), "El monto debe ser positivo.");

        if (monto > _saldo)
            throw new SaldoInsuficienteException(_saldo, monto);

        _saldo -= monto;
        Console.WriteLine($"  Retiro de {monto:C2} exitoso.");
    }

    /// <summary>Retorna el estado actual de la cuenta.</summary>
    public string VerSaldo() => $"  Cuenta {Numero} — Saldo: {_saldo:C2}";
}

/// <summary>Recurso simulado que implementa IDisposable para demostrar el patrón using.</summary>
class RecursoSimulado : IDisposable
{
    private readonly string _nombre;

    public RecursoSimulado(string nombre)
    {
        _nombre = nombre;
        Console.WriteLine($"  [{_nombre}] Recurso abierto.");
    }

    /// <summary>Simula la ejecución de una operación con el recurso.</summary>
    public void Ejecutar(string operacion) =>
        Console.WriteLine($"  [{_nombre}] Ejecutando: {operacion}");

    /// <summary>Libera el recurso. Llamado automáticamente por el bloque using.</summary>
    public void Dispose() =>
        Console.WriteLine($"  [{_nombre}] Recurso liberado (Dispose).");
}
