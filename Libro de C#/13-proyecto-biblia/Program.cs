// ============================================================
// Capítulo 13 — Proyecto Biblia
// Requisito: dotnet add package Microsoft.Data.Sqlite
// Base de datos: ../../datos/biblia_rv60.sqlite3
// ============================================================

using Microsoft.Data.Sqlite;

// Ruta relativa a la BD (relativa al directorio de ejecución)
const string RUTA_BD = "../../datos/biblia_rv60.sqlite3";

// Verificar que la base de datos existe antes de continuar
if (!File.Exists(RUTA_BD))
{
    Console.ForegroundColor = ConsoleColor.Red;
    Console.WriteLine($"ERROR: No se encontró la base de datos en: {RUTA_BD}");
    Console.WriteLine("Verifica que el archivo biblia_rv60.sqlite3 esté en la carpeta 'datos/'.");
    Console.ResetColor();
    return;
}

Console.WriteLine("=================================================");
Console.WriteLine("       Proyecto Biblia — Reina-Valera 1960       ");
Console.WriteLine("=================================================\n");

// Abrir la conexión una sola vez y reutilizarla en todas las consultas
using var conexion = new SqliteConnection($"Data Source={RUTA_BD}");
conexion.Open();
Console.WriteLine("Conexión exitosa a la base de datos.\n");

// ============================================================
// 1. Primeros 10 libros de la Biblia
// ============================================================
Console.WriteLine("--- 1. Primeros 10 libros de la Biblia ---");
MostrarPrimerosDiezLibros(conexion);

// ============================================================
// 2. Versículo famoso: Juan 3:16
// ============================================================
Console.WriteLine("\n--- 2. Juan 3:16 ---");
BuscarVersiculo(conexion, "Juan", 3, 16);

// ============================================================
// 3. Top 10 libros con más versículos
// ============================================================
Console.WriteLine("\n--- 3. Top 10 libros con más versículos ---");
MostrarTopLibrosPorVersiculos(conexion, 10);

// ============================================================
// 4. Buscar versículos por palabra clave
// ============================================================
Console.WriteLine("\n--- 4. Versículos que contienen 'amor' (primeros 5) ---");
BuscarPorPalabraClave(conexion, "amor", limite: 5);

// ============================================================
// 5. Estadísticas generales
// ============================================================
Console.WriteLine("\n--- 5. Estadísticas generales ---");
MostrarEstadisticas(conexion);

// ============================================================
// Definición de funciones
// ============================================================

/// <summary>
/// Lista los primeros 10 libros de la Biblia ordenados por su ID.
/// </summary>
static void MostrarPrimerosDiezLibros(SqliteConnection cn)
{
    using var cmd = cn.CreateCommand();
    cmd.CommandText = @"
        SELECT id, nombre, abrev, testamento
        FROM libro
        ORDER BY id
        LIMIT 10";

    using var lector = cmd.ExecuteReader();
    Console.WriteLine($"  {"ID",-4} {"Nombre",-20} {"Abrev",-8} {"Testamento"}");
    Console.WriteLine($"  {new string('-', 45)}");

    while (lector.Read())
    {
        int    id          = lector.GetInt32(0);
        string nombre      = lector.GetString(1);
        string abrev       = lector.GetString(2);
        string testamento  = lector.IsDBNull(3) ? "?" : lector.GetString(3);

        Console.WriteLine($"  {id,-4} {nombre,-20} {abrev,-8} {testamento}");
    }
}

/// <summary>
/// Busca y muestra un versículo específico por libro, capítulo y número.
/// Usa parámetros preparados para evitar SQL injection.
/// </summary>
static void BuscarVersiculo(SqliteConnection cn, string libro, int capitulo, int numero)
{
    using var cmd = cn.CreateCommand();
    cmd.CommandText = @"
        SELECT v.texto
        FROM versiculo v
        JOIN libro l ON l.id = v.libro_id
        WHERE l.nombre = @libro
          AND v.capitulo = @capitulo
          AND v.numero = @numero";

    // Parámetros preparados: previenen SQL injection
    cmd.Parameters.AddWithValue("@libro",    libro);
    cmd.Parameters.AddWithValue("@capitulo", capitulo);
    cmd.Parameters.AddWithValue("@numero",   numero);

    string? texto = (string?)cmd.ExecuteScalar();

    if (texto is not null)
        Console.WriteLine($"  {libro} {capitulo}:{numero} — {texto}");
    else
        Console.WriteLine($"  No se encontró {libro} {capitulo}:{numero}");
}

/// <summary>
/// Muestra los libros con más versículos en orden descendente.
/// </summary>
static void MostrarTopLibrosPorVersiculos(SqliteConnection cn, int limite)
{
    using var cmd = cn.CreateCommand();
    cmd.CommandText = @"
        SELECT l.nombre, COUNT(v.id) AS total
        FROM versiculo v
        JOIN libro l ON l.id = v.libro_id
        GROUP BY l.id, l.nombre
        ORDER BY total DESC
        LIMIT @limite";

    cmd.Parameters.AddWithValue("@limite", limite);

    using var lector = cmd.ExecuteReader();
    int posicion = 1;

    Console.WriteLine($"  {"#",-4} {"Libro",-20} {"Versículos",10}");
    Console.WriteLine($"  {new string('-', 36)}");

    while (lector.Read())
    {
        string nombre = lector.GetString(0);
        int    total  = lector.GetInt32(1);
        Console.WriteLine($"  {posicion,-4} {nombre,-20} {total,10:N0}");
        posicion++;
    }
}

/// <summary>
/// Busca versículos que contienen una palabra clave (búsqueda parcial con LIKE).
/// </summary>
static void BuscarPorPalabraClave(SqliteConnection cn, string palabraClave, int limite = 5)
{
    using var cmd = cn.CreateCommand();
    cmd.CommandText = @"
        SELECT l.nombre, v.capitulo, v.numero, v.texto
        FROM versiculo v
        JOIN libro l ON l.id = v.libro_id
        WHERE v.texto LIKE @patron
        ORDER BY l.id, v.capitulo, v.numero
        LIMIT @limite";

    // LIKE con % busca la palabra en cualquier posición del texto
    cmd.Parameters.AddWithValue("@patron", $"%{palabraClave}%");
    cmd.Parameters.AddWithValue("@limite", limite);

    using var lector = cmd.ExecuteReader();
    bool hayResultados = false;

    while (lector.Read())
    {
        hayResultados = true;
        string libro     = lector.GetString(0);
        int    capitulo  = lector.GetInt32(1);
        int    numero    = lector.GetInt32(2);
        string texto     = lector.GetString(3);

        // Truncar texto largo para mejor visualización
        string textoCorto = texto.Length > 80 ? texto[..80] + "..." : texto;
        Console.WriteLine($"  {libro} {capitulo}:{numero}");
        Console.WriteLine($"    {textoCorto}");
    }

    if (!hayResultados)
        Console.WriteLine($"  No se encontraron versículos con '{palabraClave}'.");
}

/// <summary>
/// Muestra estadísticas generales de la base de datos.
/// Usa múltiples consultas escalares para recopilar los datos.
/// </summary>
static void MostrarEstadisticas(SqliteConnection cn)
{
    // Total de libros
    int totalLibros = EjecutarEscalar<int>(cn, "SELECT COUNT(*) FROM libro");

    // Total de versículos
    int totalVersiculos = EjecutarEscalar<int>(cn, "SELECT COUNT(*) FROM versiculo");

    // Total de capítulos únicos
    int totalCapitulos = EjecutarEscalar<int>(cn,
        "SELECT COUNT(DISTINCT libro_id || '-' || capitulo) FROM versiculo");

    // Libro con más versículos
    string? libroMasVersiculos = (string?)EjecutarEscalarObjeto(cn, @"
        SELECT l.nombre
        FROM versiculo v
        JOIN libro l ON l.id = v.libro_id
        GROUP BY l.id
        ORDER BY COUNT(*) DESC
        LIMIT 1");

    // Versículo más largo
    string? versMasLargo = (string?)EjecutarEscalarObjeto(cn, @"
        SELECT l.nombre || ' ' || v.capitulo || ':' || v.numero
        FROM versiculo v
        JOIN libro l ON l.id = v.libro_id
        ORDER BY LENGTH(v.texto) DESC
        LIMIT 1");

    Console.WriteLine($"  Total de libros     : {totalLibros:N0}");
    Console.WriteLine($"  Total de capítulos  : {totalCapitulos:N0}");
    Console.WriteLine($"  Total de versículos : {totalVersiculos:N0}");
    Console.WriteLine($"  Libro más extenso   : {libroMasVersiculos ?? "N/A"}");
    Console.WriteLine($"  Versículo más largo : {versMasLargo ?? "N/A"}");
}

/// <summary>
/// Ejecuta una consulta que retorna un único valor escalar de tipo T.
/// </summary>
static T EjecutarEscalar<T>(SqliteConnection cn, string sql)
{
    using var cmd = cn.CreateCommand();
    cmd.CommandText = sql;
    return (T)Convert.ChangeType(cmd.ExecuteScalar()!, typeof(T));
}

/// <summary>
/// Ejecuta una consulta escalar y retorna el resultado como object (puede ser null).
/// </summary>
static object? EjecutarEscalarObjeto(SqliteConnection cn, string sql)
{
    using var cmd = cn.CreateCommand();
    cmd.CommandText = sql;
    var resultado = cmd.ExecuteScalar();
    return resultado == DBNull.Value ? null : resultado;
}
