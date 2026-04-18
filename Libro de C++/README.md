# Libro de C++ — De cero a PRO

Guia completa de C++ desde los fundamentos hasta programacion moderna, con
enfoque en rendimiento, control de recursos y pensamiento tecnico profundo.

---

## ¿Para quien es este libro?

- Programadores con conocimientos básicos de cualquier lenguaje (Python, Java, etc.)
- Desarrolladores que ya saben C y quieren dar el salto a C++
- Estudiantes que quieren aprender C++ con ejemplos prácticos y compilables

No se requiere experiencia previa en C++, pero si ayuda conocer variables,
condicionales y bucles en cualquier lenguaje.

## Que aprenderas

Este libro te ayudara a entender:

- como C++ extiende a C con abstracciones mas potentes;
- como trabajar con objetos, memoria y recursos;
- como escribir software rapido sin perder claridad;
- como pensar el costo real de cada decision tecnica.

---

## Relacion con software y hardware

C++ se usa mucho cuando importa el rendimiento porque te permite trabajar muy
cerca de la maquina, pero con herramientas mas ricas que C. Eso significa que
muchos ejemplos te ayudaran a conectar:

- instrucciones del codigo;
- uso de CPU y memoria;
- costo de copias y referencias;
- vida util de objetos y recursos.

## Cómo compilar los ejemplos

Todos los archivos `.cpp` se compilan con **g++** usando el estándar C++17:

```bash
# Compilación básica
g++ -std=c++17 -o programa archivo.cpp

# Con mensajes de advertencia (recomendado)
g++ -std=c++17 -Wall -Wextra -o programa archivo.cpp

# Capítulo 13 (usa SQLite3, requiere la librería instalada)
g++ -std=c++17 -o explorar 01_explorar_bd.cpp -lsqlite3
```

### Requisitos

- **g++** versión 7 o superior (incluido en GCC / MinGW en Windows)
- **SQLite3** (solo para el capítulo 13): `sudo apt install libsqlite3-dev` en Linux,
  o descargar las amalgamation headers en Windows.

---

## Tabla de contenidos

| # | Capítulo | Temas principales |
|---|----------|-------------------|
| 01 | [Introducción](01-introduccion/README.md) | Hola mundo, cin/cout, namespaces, diferencias con C |
| 02 | [Variables y tipos](02-variables-y-tipos/README.md) | Tipos primitivos, auto, string, bool, nullptr, const, constexpr |
| 03 | [Operadores y expresiones](03-operadores-y-expresiones/README.md) | Aritméticos, lógicos, comparación, ternario, new/delete |
| 04 | [Control de flujo](04-control-de-flujo/README.md) | if/else, switch, while, for, range-for, break/continue |
| 05 | [Funciones](05-funciones/README.md) | Sobrecarga, referencias, parámetros por defecto, inline, lambdas |
| 06 | [POO — Clases](06-poo-clases/README.md) | Clases, objetos, constructores, destructores, encapsulación |
| 07 | [Herencia y polimorfismo](07-herencia-y-polimorfismo/README.md) | Herencia, virtual, override, final, clases abstractas |
| 08 | [Plantillas (Templates)](08-plantillas-templates/README.md) | Function templates, class templates, especialización |
| 09 | [STL — Contenedores](09-stl-contenedores/README.md) | vector, map, set, iteradores, algoritmos de `<algorithm>` |
| 10 | [Manejo de errores](10-manejo-de-errores/README.md) | try/catch/throw, std::exception, excepciones personalizadas |
| 11 | [Archivos e I/O](11-archivos-e-io/README.md) | ifstream, ofstream, fstream, stringstream |
| 12 | [C++11 Moderno](12-c++11-moderno/README.md) | auto, lambdas, smart pointers, move semantics, nullptr |
| 13 | [Proyecto Biblia](13-proyecto-biblia/README.md) | SQLite3 en C++, consultas reales a la BD de la Biblia |

---

## Base de datos de la Biblia

A partir del **capítulo 11**, algunos ejemplos usan la base de datos SQLite de la Biblia
Reina-Valera 1960, ubicada en:

```
../../datos/biblia_rv60.sqlite3
```

Esta ruta es relativa a cada subcarpeta de capítulo. Ver
[datos/README.md](datos/README.md) para detalles de uso y estructura de la BD.

---

## Estructura del proyecto

```
Libro de C++/
├── README.md                  ← Este archivo
├── datos/
│   └── README.md              ← Info sobre la BD de la Biblia
├── 01-introduccion/
├── 02-variables-y-tipos/
├── 03-operadores-y-expresiones/
├── 04-control-de-flujo/
├── 05-funciones/
├── 06-poo-clases/
├── 07-herencia-y-polimorfismo/
├── 08-plantillas-templates/
├── 09-stl-contenedores/
├── 10-manejo-de-errores/
├── 11-archivos-e-io/
├── 12-c++11-moderno/
└── 13-proyecto-biblia/
```
