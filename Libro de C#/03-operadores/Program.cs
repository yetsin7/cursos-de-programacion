// ============================================================
// Capitulo 03 — Operadores
// Temas: aritmeticos, comparacion, logicos, ternario,
//        null-coalescing (??), null-conditional (?.)
// ============================================================
//
// Este archivo muestra como C# transforma valores y toma decisiones.
// Cada operador participa en calculos, validaciones o control del flujo.
// ============================================================

Console.WriteLine("=== Operadores aritméticos ===");

int a = 10, b = 3;

Console.WriteLine($"a = {a}, b = {b}");
Console.WriteLine($"a + b  = {a + b}");
Console.WriteLine($"a - b  = {a - b}");
Console.WriteLine($"a * b  = {a * b}");
Console.WriteLine($"a / b  = {a / b}  (división entera, trunca)");
Console.WriteLine($"a % b  = {a % b}  (módulo / residuo)");

// Para obtener division real, al menos un operando debe ser decimal o flotante.
Console.WriteLine($"a / (double)b = {a / (double)b:F4}");

// Prefijo y postfijo no se comportan igual.
int x = 5;
Console.WriteLine($"\nx antes : {x}");
Console.WriteLine($"x++ (post): {x++}  → x queda en {x}");
x = 5;
Console.WriteLine($"++x (pre) : {++x}  → x queda en {x}");

Console.WriteLine("\n=== Operadores de asignación compuesta ===");

int n = 20;
Console.WriteLine($"n = {n}");
n += 5; Console.WriteLine($"n += 5  → {n}");
n -= 3; Console.WriteLine($"n -= 3  → {n}");
n *= 2; Console.WriteLine($"n *= 2  → {n}");
n /= 4; Console.WriteLine($"n /= 4  → {n}");
n %= 3; Console.WriteLine($"n %= 3  → {n}");

Console.WriteLine("\n=== Operadores de comparación ===");

int p = 5, q = 8;
Console.WriteLine($"p = {p}, q = {q}");
Console.WriteLine($"p == q  : {p == q}");
Console.WriteLine($"p != q  : {p != q}");
Console.WriteLine($"p >  q  : {p > q}");
Console.WriteLine($"p <  q  : {p < q}");
Console.WriteLine($"p >= q  : {p >= q}");
Console.WriteLine($"p <= q  : {p <= q}");

Console.WriteLine("\n=== Operadores lógicos ===");

bool v1 = true, v2 = false;
Console.WriteLine($"v1 = {v1}, v2 = {v2}");
Console.WriteLine($"v1 && v2  : {v1 && v2}  (AND)");
Console.WriteLine($"v1 || v2  : {v1 || v2}  (OR)");
Console.WriteLine($"!v1       : {!v1}       (NOT)");

// Cortocircuito: si v2 es false, la segunda condicion no se evalua.
string? texto = null;
bool resultado = v2 && texto!.Length > 0;  // no lanza excepción por cortocircuito
Console.WriteLine($"false && texto.Length > 0 : {resultado} (texto no se evalúa)");

Console.WriteLine("\n=== Operador ternario ===");

int edad = 20;
string categoria = edad >= 18 ? "Mayor de edad" : "Menor de edad";
Console.WriteLine($"Edad {edad}: {categoria}");

// Un ternario anidado funciona, pero puede dificultar la lectura.
int puntos = 75;
string nivel = puntos >= 90 ? "Excelente"
             : puntos >= 70 ? "Bueno"
             : puntos >= 50 ? "Regular"
             : "Insuficiente";
Console.WriteLine($"Puntos {puntos}: nivel = {nivel}");

Console.WriteLine("\n=== Operadores null modernos ===");

// ?? da un valor alternativo si el original es null.
string? nombre = null;
string nombreFinal = nombre ?? "Sin nombre";
Console.WriteLine($"nombre ?? 'Sin nombre' : {nombreFinal}");

// ??= asigna solo si el valor actual es null.
string? ciudad = null;
ciudad ??= "Managua";
Console.WriteLine($"ciudad ??= 'Managua'   : {ciudad}");

// Si ya tiene valor, ??= no hace nada
ciudad ??= "León";
Console.WriteLine($"ciudad ??= 'León'      : {ciudad}  (no cambió)");

// ?. accede de forma segura a un miembro si el objeto no es null.
string? textoNulo = null;
int? longitud = textoNulo?.Length;  // no lanza NullReferenceException
Console.WriteLine($"null?.Length           : {longitud ?? -1}");

string? textoReal = "¡Hola!";
int? longitudReal = textoReal?.Length;
Console.WriteLine($"'¡Hola!'?.Length       : {longitudReal}");

// Encadenar ?. y ?? es muy comun en codigo real.
string? linea = null;
int caracteres = linea?.Trim()?.Length ?? 0;
Console.WriteLine($"null?.Trim()?.Length ?? 0 : {caracteres}");

Console.WriteLine("\n=== Operadores bit a bit (ejemplo básico) ===");

int flags = 0b_1010;   // binario: 10 en decimal
int mascara = 0b_1100; // binario: 12 en decimal

Console.WriteLine($"flags   = {flags,4} ({Convert.ToString(flags, 2).PadLeft(4, '0')})");
Console.WriteLine($"mascara = {mascara,4} ({Convert.ToString(mascara, 2).PadLeft(4, '0')})");
Console.WriteLine($"AND (&) = {flags & mascara,4} ({Convert.ToString(flags & mascara, 2).PadLeft(4, '0')})");
Console.WriteLine($"OR  (|) = {flags | mascara,4} ({Convert.ToString(flags | mascara, 2).PadLeft(4, '0')})");
Console.WriteLine($"XOR (^) = {flags ^ mascara,4} ({Convert.ToString(flags ^ mascara, 2).PadLeft(4, '0')})");
Console.WriteLine($"<< 1    = {flags << 1,4} ({Convert.ToString(flags << 1, 2).PadLeft(4, '0')})");
Console.WriteLine($">> 1    = {flags >> 1,4} ({Convert.ToString(flags >> 1, 2).PadLeft(4, '0')})");

Console.WriteLine("\n=== Ideas clave ===");
Console.WriteLine("Los operadores cambian valores y tambien decisiones.");
Console.WriteLine("La division entera y la flotante no son lo mismo.");
Console.WriteLine("Los operadores de null son esenciales en C# moderno.");
