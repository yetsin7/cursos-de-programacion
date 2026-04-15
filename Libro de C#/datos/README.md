# Datos — Base de datos de la Biblia

Esta carpeta contiene los datos compartidos utilizados en los capítulos avanzados del libro.

---

## Archivo principal

```
biblia_rv60.sqlite3
```

Ubicación relativa desde la raíz del libro:

```
../../datos/biblia_rv60.sqlite3
```

---

## Estructura de la base de datos

La base de datos SQLite contiene los textos de la **Reina-Valera 1960** organizados en las siguientes tablas:

```sql
-- Libros de la Biblia
CREATE TABLE libro (
    id       INTEGER PRIMARY KEY,
    nombre   TEXT NOT NULL,
    abrev    TEXT NOT NULL,
    testamento TEXT -- 'AT' o 'NT'
);

-- Versículos
CREATE TABLE versiculo (
    id       INTEGER PRIMARY KEY,
    libro_id INTEGER NOT NULL,
    capitulo INTEGER NOT NULL,
    numero   INTEGER NOT NULL,
    texto    TEXT NOT NULL,
    FOREIGN KEY (libro_id) REFERENCES libro(id)
);
```

---

## Uso desde C# con Microsoft.Data.Sqlite

### 1. Instalar el paquete NuGet

```bash
dotnet add package Microsoft.Data.Sqlite
```

### 2. Ejemplo básico de conexión

```csharp
using Microsoft.Data.Sqlite;

// Ruta relativa a la base de datos
string rutaBD = "../../datos/biblia_rv60.sqlite3";

using var conexion = new SqliteConnection($"Data Source={rutaBD}");
conexion.Open();

// Consultar todos los libros
using var comando = conexion.CreateCommand();
comando.CommandText = "SELECT id, nombre FROM libro ORDER BY id";

using var lector = comando.ExecuteReader();
while (lector.Read())
{
    Console.WriteLine($"{lector.GetInt32(0)}. {lector.GetString(1)}");
}
```

### 3. Consultar un versículo específico (Juan 3:16)

```csharp
using var cmd = conexion.CreateCommand();
cmd.CommandText = @"
    SELECT v.texto
    FROM versiculo v
    JOIN libro l ON l.id = v.libro_id
    WHERE l.nombre = 'Juan'
      AND v.capitulo = 3
      AND v.numero = 16";

string? versiculo = (string?)cmd.ExecuteScalar();
Console.WriteLine(versiculo);
```

### 4. Contar versículos por libro

```csharp
using var cmd = conexion.CreateCommand();
cmd.CommandText = @"
    SELECT l.nombre, COUNT(*) as total
    FROM versiculo v
    JOIN libro l ON l.id = v.libro_id
    GROUP BY l.id, l.nombre
    ORDER BY total DESC
    LIMIT 10";

using var lector = cmd.ExecuteReader();
while (lector.Read())
{
    Console.WriteLine($"{lector.GetString(0)}: {lector.GetInt32(1)} versículos");
}
```

---

## Notas

- La ruta `../../datos/biblia_rv60.sqlite3` es relativa al directorio de ejecución del proyecto
- Si ejecutas desde el directorio del capítulo con `dotnet run`, la ruta funciona correctamente
- El archivo SQLite debe estar presente antes de ejecutar cualquier ejemplo del capítulo 13
