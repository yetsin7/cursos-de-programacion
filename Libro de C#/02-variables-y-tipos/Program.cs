// ============================================================
// Capitulo 02 — Variables y tipos de datos
// Temas: enteros, decimales, texto, bool, var, object,
//        dynamic, nullable, const e interpolacion
// ============================================================
//
// Este archivo muestra como C# representa distintos tipos de datos y como esos
// tipos afectan la forma de guardar, convertir y mostrar informacion.
// ============================================================

Console.WriteLine("=== Tipos enteros ===");

byte  b = 255;
short s = 32_000;       // guiones bajos como separador visual (C# 7+)
int   i = 2_000_000;
long  l = 9_000_000_000L;

Console.WriteLine($"byte  : {b}");
Console.WriteLine($"short : {s}");
Console.WriteLine($"int   : {i}");
Console.WriteLine($"long  : {l}");

Console.WriteLine("\n=== Tipos decimales ===");

float   f  = 3.14f;          // sufijo 'f' obligatorio para float
double  d  = 3.141592653589;
decimal m  = 19.99m;         // sufijo 'm' obligatorio para decimal

Console.WriteLine($"float   : {f}");
Console.WriteLine($"double  : {d}");
Console.WriteLine($"decimal : {m}");

Console.WriteLine("\n=== Otros tipos primitivos ===");

bool   activo   = true;
char   letra    = 'C';
string texto    = "Hola, C#";

Console.WriteLine($"bool   : {activo}");
Console.WriteLine($"char   : {letra}");
Console.WriteLine($"string : {texto}");

Console.WriteLine("\n=== var — Inferencia de tipo ===");

// El compilador deduce el tipo automaticamente.
var nombre  = "Yetsin";         // inferido como string
var edad    = 30;               // inferido como int
var precio  = 99.95;            // inferido como double

Console.WriteLine($"nombre ({nombre.GetType().Name}) : {nombre}");
Console.WriteLine($"edad   ({edad.GetType().Name})   : {edad}");
Console.WriteLine($"precio ({precio.GetType().Name}) : {precio}");

Console.WriteLine("\n=== object y boxing ===");

// object es la base de todos los tipos en .NET.
object cualquierCosa = 42;         // boxing: int a object
Console.WriteLine($"object con int   : {cualquierCosa}");

cualquierCosa = "ahora es string";
Console.WriteLine($"object con string: {cualquierCosa}");

Console.WriteLine("\n=== dynamic ===");

dynamic dinamico = 10;
Console.WriteLine($"dynamic int   : {dinamico}");

dinamico = "ahora soy texto";
Console.WriteLine($"dynamic string: {dinamico}");

Console.WriteLine("\n=== Nullable types ===");

int?  edadNullable  = null;
bool? estadoNullable = null;

Console.WriteLine($"edadNullable tiene valor: {edadNullable.HasValue}");

// Asignar un valor y verificar
edadNullable = 25;
Console.WriteLine($"edadNullable.Value : {edadNullable.Value}");

// ?? devuelve un valor por defecto si el dato es null.
int edadFinal = edadNullable ?? 0;
Console.WriteLine($"edadFinal (??): {edadFinal}");

Console.WriteLine("\n=== const y readonly ===");

// const representa un valor fijo conocido al compilar.
const double PI      = 3.14159265358979;
const string VERSION = "1.0.0";

Console.WriteLine($"PI      : {PI}");
Console.WriteLine($"VERSION : {VERSION}");

Console.WriteLine("\n=== Interpolación de strings ===");

string ciudad  = "Managua";
int poblacion  = 1_042_641;
double temperatura = 34.5;

// La interpolacion vuelve mas legible el texto dinamico.
Console.WriteLine($"Ciudad: {ciudad}, Población: {poblacion:N0}");

// Formato de número con decimales
Console.WriteLine($"Temperatura: {temperatura:F1}°C");

// Formato de moneda
decimal salario = 15_500.75m;
Console.WriteLine($"Salario: {salario:C2}");

Console.WriteLine("\n=== Conversiones de tipo ===");

// Conversion implicita: C# la permite cuando es segura.
int entero  = 100;
long grande = entero;           // int → long es automático
double real = entero;           // int → double es automático
Console.WriteLine($"int→long: {grande}, int→double: {real}");

// Conversion explicita: puede perder informacion.
double pi    = 3.99;
int truncado = (int)pi;          // trunca la parte decimal
Console.WriteLine($"double→int (cast): {truncado}");

// Parse y TryParse convierten texto a numero.
string numeroTexto = "42";
int parseado = int.Parse(numeroTexto);
Console.WriteLine($"int.Parse: {parseado}");

bool exito = int.TryParse("no-es-numero", out int resultado);
Console.WriteLine($"TryParse 'no-es-numero': exito={exito}, resultado={resultado}");

// Convert ofrece otra forma comun de conversion.
string textoReal = "3.14";
double convertido = Convert.ToDouble(textoReal);
Console.WriteLine($"Convert.ToDouble: {convertido}");

Console.WriteLine("\n=== Ideas clave ===");
Console.WriteLine("Los tipos ayudan a prevenir errores antes de ejecutar.");
Console.WriteLine("var no vuelve dinamico al dato.");
Console.WriteLine("dynamic debe usarse con criterio.");
