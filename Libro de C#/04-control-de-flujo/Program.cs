// ============================================================
// Capitulo 04 — Control de flujo
// Temas: if/else, switch, switch expression,
//        foreach, for, while, do-while, pattern matching
// ============================================================
//
// Este archivo muestra como C# elige caminos y repite acciones.
// Controlar el flujo es esencial para reglas, validaciones y recorridos.
// ============================================================

Console.WriteLine("=== if / else if / else ===");

int temperatura = 35;
if (temperatura > 30)
    Console.WriteLine("Hace mucho calor");
else if (temperatura > 20)
    Console.WriteLine("Temperatura agradable");
else if (temperatura > 10)
    Console.WriteLine("Un poco fresco");
else
    Console.WriteLine("Hace frío");

Console.WriteLine("\n=== switch clásico ===");

int diaSemana = 3;
switch (diaSemana)
{
    case 1: Console.WriteLine("Lunes");     break;
    case 2: Console.WriteLine("Martes");    break;
    case 3: Console.WriteLine("Miércoles"); break;
    case 4: Console.WriteLine("Jueves");    break;
    case 5: Console.WriteLine("Viernes");   break;
    case 6:
    case 7: Console.WriteLine("Fin de semana"); break;
    default: Console.WriteLine("Día inválido"); break;
}

Console.WriteLine("\n=== switch expression (C# 8+) ===");

// Forma moderna: devuelve un valor directamente.
string nombreDia = diaSemana switch
{
    1 => "Lunes",
    2 => "Martes",
    3 => "Miércoles",
    4 => "Jueves",
    5 => "Viernes",
    6 or 7 => "Fin de semana",
    _ => "Invalido"
};
Console.WriteLine($"Día {diaSemana}: {nombreDia}");

// Tambien puede expresar rangos de forma compacta.
int puntos = 82;
string calificacion = puntos switch
{
    >= 90 => "A — Excelente",
    >= 80 => "B — Muy bueno",
    >= 70 => "C — Bueno",
    >= 60 => "D — Regular",
    _     => "F — Insuficiente"
};
Console.WriteLine($"Puntos {puntos}: {calificacion}");

Console.WriteLine("\n=== Pattern matching básico ===");

// 'is' puede verificar tipo y crear una variable utilizable.
object valor = 42;
if (valor is int numero && numero > 0)
    Console.WriteLine($"Es un entero positivo: {numero}");

// switch tambien puede trabajar por tipo y condicion.
object[] valores = { 42, -5, 0, "hola", 3.14, null! };
foreach (object v in valores)
{
    string descripcion = v switch
    {
        int n when n > 0 => $"Entero positivo: {n}",
        int n when n < 0 => $"Entero negativo: {n}",
        int              => "Cero",
        string s         => $"Texto: '{s}'",
        double d         => $"Decimal: {d}",
        null             => "Nulo",
        _                => "Tipo desconocido"
    };
    Console.WriteLine($"  {descripcion}");
}

Console.WriteLine("\n=== Bucle for ===");

// Un for es util cuando controlas un contador.
for (int i = 1; i <= 5; i++)
    Console.WriteLine($"  3 × {i} = {3 * i}");

Console.WriteLine("\n=== Bucle foreach ===");

string[] frutas = { "mango", "papaya", "aguacate", "maracuyá", "guanábana" };
foreach (string fruta in frutas)
    Console.WriteLine($"  🍀 {fruta}");

// foreach recorre elementos de una coleccion con claridad.
Console.WriteLine();
foreach ((int indice, string fruta) in frutas.Select((f, i) => (i, f)))
    Console.WriteLine($"  [{indice}] {fruta}");

Console.WriteLine("\n=== Bucle while ===");

int contador = 1;
while (contador <= 5)
{
    Console.Write($"{contador} ");
    contador++;
}
Console.WriteLine();

Console.WriteLine("\n=== Bucle do-while ===");

// do-while ejecuta el bloque al menos una vez.
int intentos = 0;
do
{
    intentos++;
    Console.WriteLine($"  Intento #{intentos}");
} while (intentos < 3);

Console.WriteLine("\n=== break y continue ===");

Console.Write("Números (saltando múltiplos de 3, parando en 10): ");
for (int i = 1; i <= 15; i++)
{
    if (i % 3 == 0) continue;  // salta múltiplos de 3
    if (i > 10)     break;     // para al superar 10
    Console.Write($"{i} ");
}
Console.WriteLine();

Console.WriteLine("\n=== Bucles anidados ===");

// Los bucles anidados aparecen mucho en tablas y matrices.
Console.WriteLine("  ×  | 1  2  3");
Console.WriteLine("  ---|--------");
for (int fila = 1; fila <= 3; fila++)
{
    Console.Write($"  {fila}  |");
    for (int col = 1; col <= 3; col++)
        Console.Write($" {fila * col,2}");
    Console.WriteLine();
}

Console.WriteLine("\n=== Ideas clave ===");
Console.WriteLine("El flujo decide caminos y repeticiones.");
Console.WriteLine("switch expression resume casos discretos.");
Console.WriteLine("Elegir el bucle correcto mejora claridad.");
