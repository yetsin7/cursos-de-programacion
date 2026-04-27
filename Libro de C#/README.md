# Libro de C# — De cero a PRO

Guía práctica y progresiva para aprender C# moderno (.NET 8+) entendiendo como
se comporta una aplicación de consola o de backend dentro del ecosistema .NET.

---

## ¿Para quien es este libro?

- Personas que quieren aprender a programar desde cero usando C#
- Desarrolladores de otros lenguajes (Java, Python, JS) que quieren migrar a .NET
- Estudiantes que buscan entender C# moderno con ejemplos ejecutables
- Cualquier persona que quiera entender el ecosistema .NET de forma ordenada

## Que aprenderas

Este libro explica C# como lenguaje y como plataforma:

- sintaxis clara y tipada;
- como .NET compila y ejecuta el código;
- como se organizan clases, objetos y colecciones;
- como se maneja memoria de forma administrada;
- como construir programas confiables y mantenibles.

---

## Requisitos previos

Solo necesitas tener instalado el SDK de .NET 8 o superior.

### Instalar .NET SDK

1. Ve a [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download)
2. Descarga el **.NET 8 SDK** (o superior) para tu sistema operativo
3. Instálalo siguiendo el asistente
4. Verifica la instalación abriendo una terminal:

```bash
dotnet --version
# Debe mostrar algo como: 8.0.xxx
```

---

## Que ocurre cuando ejecutas C#

Cuando corres un programa en C#:

- el código se compila a un lenguaje intermedio;
- el runtime de .NET lo carga;
- el recolector de basura administra gran parte de la memoria;
- el programa usa CPU, RAM, disco o red según la lógica que escribiste.

Esto hace que C# sea amigable para aprender y muy potente para software real.

---

## Crear y ejecutar un proyecto

Cada capítulo tiene su propio `Program.cs`. Para ejecutarlo:

```bash
# Crear un nuevo proyecto de consola
dotnet new console -n MiProyecto
cd MiProyecto

# Ejecutar el proyecto
dotnet run

# Compilar sin ejecutar
dotnet build
```

Si quieres ejecutar directamente el `Program.cs` de un capítulo:

```bash
cd 01-introduccion
dotnet run
```

---

## Tabla de capítulos

| #  | Capítulo                        | Temas principales                                          |
|----|---------------------------------|------------------------------------------------------------|
| 01 | Introducción                    | Qué es C#, .NET, hola mundo, estructura básica             |
| 02 | Variables y tipos               | Tipos primitivos, var, nullable, const, interpolación      |
| 03 | Operadores                      | Aritméticos, lógicos, ternario, null-coalescing            |
| 04 | Control de flujo                | if/else, switch expression, foreach, while, pattern match  |
| 05 | funciones y métodos             | Parámetros, lambdas, Func, Action, métodos de extensión    |
| 06 | POO — Clases                    | Clases, propiedades, constructores, records                |
| 07 | herencia y polimorfismo         | virtual/override, clases abstractas, sealed                |
| 08 | Interfaces y abstracciones      | Interfaces, default methods, comparación con abstractas    |
| 09 | Colecciones y LINQ              | List, Dictionary, HashSet, LINQ completo                   |
| 10 | Manejo de errores               | try/catch/finally, excepciones personalizadas, using       |
| 11 | Archivos e I/O                  | File, Stream, Path, Directory, JSON                        |
| 12 | Async y Tasks                   | async/await, Task<T>, CancellationToken, HttpClient        |
| 13 | Proyecto Biblia                 | SQLite con Microsoft.Data.Sqlite, consultas reales         |

---

## Base de datos de la Biblia

A partir del capítulo 11 se usa opcionalmente, y en el **capítulo 13** se usa directamente la base de datos SQLite de la Biblia ubicada en:

```
../../datos/biblia_rv60.sqlite3
```

Esta base de datos contiene los textos de la Reina-Valera 1960 organizados en tablas de libros, capítulos y versículos.

Para el capítulo 13, necesitas instalar el paquete NuGet:

```bash
dotnet add package Microsoft.Data.Sqlite
```

---

## convenciones del libro

- Todos los comentarios en el código están en **español**
- El código es compatible con **.NET 8+**
- Cada `Program.cs` es autocontenido y ejecutable por separado
- Ningún archivo supera las 200 líneas

---

## Estructura del proyecto

```
Libro de C#/
├── README.md                  ← Este archivo
├── datos/
│   └── README.md              ← Información sobre la BD de la Biblia
├── 01-introduccion/
├── 02-variables-y-tipos/
├── 03-operadores/
├── 04-control-de-flujo/
├── 05-funciones-y-metodos/
├── 06-poo-clases/
├── 07-herencia-y-polimorfismo/
├── 08-interfaces-y-abstracciones/
├── 09-colecciones-y-linq/
├── 10-manejo-de-errores/
├── 11-archivos-e-io/
├── 12-async-y-tasks/
└── 13-proyecto-biblia/
```
