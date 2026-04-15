# Capítulo 01 — Introducción a SQL

## ¿Qué es SQL?

**SQL** (Structured Query Language) es el lenguaje estándar para interactuar con
bases de datos relacionales. Se pronuncia "S-Q-L" o "sequel".

Con SQL puedes:
- **Consultar** datos: `SELECT`
- **Insertar** datos: `INSERT`
- **Modificar** datos: `UPDATE`
- **Eliminar** datos: `DELETE`
- **Crear** tablas y estructuras: `CREATE`, `ALTER`, `DROP`

SQL no es un lenguaje de programación general — es un lenguaje de consulta
declarativo. Le dices **qué quieres**, no cómo obtenerlo.

---

## ¿Qué es una base de datos relacional?

Una base de datos relacional organiza los datos en **tablas**. Cada tabla tiene:
- **Columnas** (campos): definen el tipo de dato (nombre, edad, email...)
- **Filas** (registros): cada fila es un registro único

Las tablas se pueden **relacionar** entre sí a través de claves.

```
Tabla: books                    Tabla: verses
┌─────────────┬───────────┐     ┌─────────────┬─────────┬───────┬────────┐
│ book_number │ long_name │     │ book_number │ chapter │ verse │ text   │
├─────────────┼───────────┤     ├─────────────┼─────────┼───────┼────────┤
│ 10          │ Génesis   │◄────│ 10          │ 1       │ 1     │ En el  │
│ 20          │ Éxodo     │     │ 10          │ 1       │ 2     │ Y la   │
│ 430         │ Juan      │◄────│ 430         │ 3       │ 16    │ Porque │
└─────────────┴───────────┘     └─────────────┴─────────┴───────┴────────┘
```

---

## ¿Qué es SQLite?

SQLite es una base de datos relacional que **se almacena en un solo archivo**.
No requiere instalar un servidor. Es perfecta para aprender SQL.

Lo que aprendas en SQLite aplica directamente a:
- **PostgreSQL** — la más usada en producción
- **MySQL / MariaDB** — muy usada en hosting compartido
- **SQL Server** — entornos corporativos Microsoft

La sintaxis SQL es casi idéntica en todos ellos.

---

## Tu primera consulta SQL

```sql
-- Esto es un comentario en SQL (empieza con --)

-- Seleccionar todos los libros de la Biblia
SELECT * FROM books;

-- Seleccionar solo el nombre largo de los libros
SELECT long_name FROM books;

-- Seleccionar los primeros 5 libros
SELECT long_name FROM books LIMIT 5;
```

---

## Reglas básicas de sintaxis

1. **Las palabras clave no distinguen mayúsculas**: `SELECT` = `select` = `Select`
   Por convención se escriben en MAYÚSCULAS para distinguirlas de los nombres de tablas/columnas.

2. **Las consultas terminan con punto y coma** `;` (obligatorio cuando hay varias juntas)

3. **Los comentarios** van con `--` en una línea o entre `/* */` para multilínea

4. **Los textos** van entre comillas simples: `'Génesis'` (no dobles como en otros lenguajes)

5. **Los nombres** de tablas y columnas no van entre comillas (a menos que tengan espacios)

---

## Archivos del capítulo

| Archivo | Contenido |
|---------|-----------|
| `01_primeras_consultas.sql` | Tu primera consulta SQL, explorar la estructura de la BD |

---

## Herramientas recomendadas

| Herramienta | Uso | Enlace |
|-------------|-----|--------|
| DB Browser for SQLite | GUI visual, ideal para aprender | https://sqlitebrowser.org/ |
| SQLite CLI | Terminal, rápida para pruebas | `sqlite3 archivo.db` |
| VS Code + SQLite Viewer | Extensión para VS Code | Buscar en Extensions |
| TablePlus | GUI profesional (freemium) | https://tableplus.com/ |
