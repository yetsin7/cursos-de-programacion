# Capítulo 01 — Introducción a C++

## ¿Qué es C++?

C++ es un lenguaje de programación de propósito general creado por **Bjarne Stroustrup**
en 1979 como una extensión de C. Es un lenguaje **compilado**, **fuertemente tipado** y
multiparadigma: soporta programación procedural, orientada a objetos y genérica.

---

## Diferencias clave entre C y C++

| Característica | C | C++ |
|----------------|---|-----|
| Paradigma | Procedural | Multiparadigma (POO + procedural + genérico) |
| I/O estándar | `printf` / `scanf` | `cout` / `cin` |
| Strings | `char[]` + funciones de `<string.h>` | `std::string` (clase completa) |
| Memoria dinámica | `malloc` / `free` | `new` / `delete` (y smart pointers) |
| Clases | No (solo `struct`) | Sí, con encapsulación completa |
| Namespaces | No | Sí (`namespace std`, etc.) |
| Sobrecarga | No | Sí (funciones y operadores) |
| Templates | No | Sí (programación genérica) |
| Manejo de errores | Códigos de retorno | Excepciones (`try/catch/throw`) |
| Extensión típica | `.c` | `.cpp` |

---

## El archivo de cabecera `<iostream>`

`<iostream>` es la cabecera estándar de C++ para entrada/salida. Contiene:

- `std::cout` — flujo de salida estándar (consola)
- `std::cin`  — flujo de entrada estándar (teclado)
- `std::cerr` — flujo de error estándar
- `std::endl` — manipulador que inserta `\n` y vacía el buffer

```cpp
#include <iostream>  // Cabecera necesaria para cout y cin
```

---

## Namespaces

Un **namespace** es un espacio de nombres que agrupa identificadores para evitar
colisiones. La biblioteca estándar de C++ vive en el namespace `std`.

```cpp
// Sin using namespace: se debe calificar completamente
std::cout << "Hola" << std::endl;

// Con using namespace std: se omite el prefijo std::
using namespace std;
cout << "Hola" << endl;

// Recomendado en proyectos grandes: importar solo lo necesario
using std::cout;
using std::endl;
```

> **Buena práctica:** Evita `using namespace std;` en archivos de cabecera (`.h`),
> ya que puede contaminar otros archivos que lo incluyan.

---

## cin y cout vs printf/scanf

```cpp
// C: printf / scanf
printf("Ingresa tu nombre: ");
char nombre[50];
scanf("%s", nombre);
printf("Hola, %s!\n", nombre);

// C++: cout / cin (más seguro y expresivo)
std::string nombre;
std::cout << "Ingresa tu nombre: ";
std::cin >> nombre;
std::cout << "Hola, " << nombre << "!\n";
```

Ventajas de `cout`/`cin`:
- No requieren especificadores de formato (`%d`, `%s`, etc.)
- Son extensibles: puedes sobrecargar `<<` y `>>` para tus propias clases
- Más seguros: evitan desbordamientos de buffer comunes con `scanf`

---

## Compilar y ejecutar

```bash
# Compilar
g++ -std=c++17 -o hola_mundo 01_hola_mundo.cpp

# Ejecutar
./hola_mundo          # Linux / macOS
hola_mundo.exe        # Windows
```

---

## Archivo de ejemplo

Ver: [01_hola_mundo.cpp](01_hola_mundo.cpp)
