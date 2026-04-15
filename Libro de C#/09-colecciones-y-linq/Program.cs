// ============================================================
// Capítulo 09 — Colecciones y LINQ
// Temas: List<T>, Dictionary<K,V>, HashSet<T>,
//        LINQ query syntax y method syntax
// ============================================================

// ============================================================
// List<T>
// ============================================================
Console.WriteLine("=== List<T> ===");

var frutas = new List<string> { "mango", "papaya", "aguacate", "guayaba", "maracuyá" };

frutas.Add("piña");
frutas.Insert(0, "banano");  // insertar al inicio
frutas.Remove("papaya");

Console.WriteLine($"Total: {frutas.Count}");
Console.WriteLine($"Contiene 'mango': {frutas.Contains("mango")}");
Console.WriteLine($"Índice de 'aguacate': {frutas.IndexOf("aguacate")}");
Console.WriteLine($"Frutas: {string.Join(", ", frutas)}");

// ============================================================
// Dictionary<K, V>
// ============================================================
Console.WriteLine("\n=== Dictionary<string, int> ===");

var poblaciones = new Dictionary<string, int>
{
    ["Managua"]  = 1_042_641,
    ["León"]     = 201_100,
    ["Masaya"]   = 166_588,
    ["Matagalpa"] = 150_600
};

poblaciones["Granada"] = 123_456;  // agregar nueva clave

Console.WriteLine($"Ciudades registradas: {poblaciones.Count}");

if (poblaciones.TryGetValue("León", out int pobLeon))
    Console.WriteLine($"León: {pobLeon:N0} habitantes");

Console.WriteLine("Todas las ciudades:");
foreach (var (ciudad, habitantes) in poblaciones.OrderByDescending(x => x.Value))
    Console.WriteLine($"  {ciudad,-12}: {habitantes,10:N0}");

// ============================================================
// HashSet<T>
// ============================================================
Console.WriteLine("\n=== HashSet<T> ===");

var tecnologias    = new HashSet<string> { "C#", "dotnet", "ASP.NET", "LINQ" };
var otrasTecnologias = new HashSet<string> { "C#", "Python", "LINQ", "Django" };

tecnologias.Add("C#");         // duplicado, no se agrega
tecnologias.Add("SQL Server"); // nuevo elemento

Console.WriteLine($"Tecnologías: {string.Join(", ", tecnologias)}");

// Operaciones de conjuntos (modifican la colección original)
var interseccion = new HashSet<string>(tecnologias);
interseccion.IntersectWith(otrasTecnologias);
Console.WriteLine($"Intersección: {string.Join(", ", interseccion)}");

var union = new HashSet<string>(tecnologias);
union.UnionWith(otrasTecnologias);
Console.WriteLine($"Unión: {string.Join(", ", union)}");

// ============================================================
// Datos de ejemplo para LINQ
// ============================================================
var productos = new List<Producto>
{
    new("Café Premium",      "Bebidas",    4.50m,  120),
    new("Té Verde",          "Bebidas",    3.00m,   85),
    new("Agua Mineral",      "Bebidas",    1.20m,  300),
    new("Pan Artesanal",     "Panadería",  2.80m,   60),
    new("Galletas Integrales","Panadería", 3.50m,   45),
    new("Miel de Abeja",     "Natural",    8.99m,   30),
    new("Aceite de Coco",    "Natural",   12.50m,   20),
    new("Jugo de Naranja",   "Bebidas",    5.00m,   90)
};

// ============================================================
// LINQ — Method syntax
// ============================================================
Console.WriteLine("\n=== LINQ — Where y Select ===");

var bebidasBaratas = productos
    .Where(p  => p.Categoria == "Bebidas" && p.Precio < 4.0m)
    .Select(p => $"{p.Nombre} ({p.Precio:C2})")
    .ToList();

Console.WriteLine("Bebidas baratas (< $4):");
bebidasBaratas.ForEach(b => Console.WriteLine($"  {b}"));

Console.WriteLine("\n=== LINQ — OrderBy y Take ===");

var top3Caros = productos
    .OrderByDescending(p => p.Precio)
    .Take(3)
    .Select(p => $"{p.Nombre}: {p.Precio:C2}");

Console.WriteLine("Top 3 más caros:");
foreach (var item in top3Caros)
    Console.WriteLine($"  {item}");

Console.WriteLine("\n=== LINQ — GroupBy ===");

var porCategoria = productos
    .GroupBy(p => p.Categoria)
    .OrderBy(g => g.Key);

foreach (var grupo in porCategoria)
{
    decimal totalStock = grupo.Sum(p => p.Precio * p.Stock);
    Console.WriteLine($"  {grupo.Key,-12} | {grupo.Count()} productos | Stock total: {totalStock:C2}");
}

Console.WriteLine("\n=== LINQ — Agregaciones ===");

Console.WriteLine($"Precio promedio : {productos.Average(p => p.Precio):C2}");
Console.WriteLine($"Precio más alto : {productos.Max(p => p.Precio):C2}");
Console.WriteLine($"Precio más bajo : {productos.Min(p => p.Precio):C2}");
Console.WriteLine($"Productos > $5  : {productos.Count(p => p.Precio > 5)}");
Console.WriteLine($"¿Alguno < $2?   : {productos.Any(p => p.Precio < 2.0m)}");
Console.WriteLine($"¿Todos > $1?    : {productos.All(p => p.Precio > 1.0m)}");

Console.WriteLine("\n=== LINQ — Query Syntax ===");

// Equivalente SQL para filtrar y ordenar
var consultaSQL =
    from p in productos
    where p.Precio > 3.0m
    orderby p.Categoria, p.Precio descending
    select new { p.Nombre, p.Categoria, p.Precio };

Console.WriteLine("Productos > $3 (query syntax):");
foreach (var p in consultaSQL)
    Console.WriteLine($"  [{p.Categoria}] {p.Nombre,-25} {p.Precio:C2}");

Console.WriteLine("\n=== LINQ — Distinct y Paginación ===");

var categorias = productos.Select(p => p.Categoria).Distinct().Order();
Console.WriteLine($"Categorías únicas: {string.Join(", ", categorias)}");

// Paginación manual con Skip + Take
int pagina = 1, tamanioPagina = 3;
var paginados = productos.Skip((pagina - 1) * tamanioPagina).Take(tamanioPagina);
Console.WriteLine($"\nPágina {pagina} ({tamanioPagina} por página):");
foreach (var p in paginados)
    Console.WriteLine($"  {p.Nombre}");

// ============================================================
// Tipo de dato local para los ejemplos
// ============================================================

/// <summary>Producto del catálogo con categoría, precio y stock.</summary>
record Producto(string Nombre, string Categoria, decimal Precio, int Stock);
