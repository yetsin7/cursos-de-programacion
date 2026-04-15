# Capítulo 02 — Variables y Tipos de Datos

## Tipos primitivos en C++

C++ hereda los tipos primitivos de C y agrega algunos propios:

| Tipo | Tamaño típico | Rango / Descripción |
|------|--------------|---------------------|
| `bool` | 1 byte | `true` o `false` |
| `char` | 1 byte | Carácter ASCII (-128 a 127) |
| `int` | 4 bytes | Entero con signo (-2³¹ a 2³¹-1) |
| `unsigned int` | 4 bytes | Entero sin signo (0 a 2³²-1) |
| `long` | 4 u 8 bytes | Entero largo |
| `long long` | 8 bytes | Entero muy largo |
| `float` | 4 bytes | Punto flotante simple precisión |
| `double` | 8 bytes | Punto flotante doble precisión |
| `long double` | 12-16 bytes | Máxima precisión flotante |

> Usa `sizeof(tipo)` para verificar el tamaño real en tu plataforma.

---

## `std::string` — Cadenas de texto

A diferencia de C (que usa `char[]`), C++ tiene la clase `std::string`:

```cpp
#include <string>

std::string nombre = "C++";
std::string saludo = "Hola, " + nombre;  // Concatenación con +

// Longitud
int len = saludo.length();  // o saludo.size()

// Acceso a caracteres
char c = saludo[0];         // 'H'

// Subcadena
std::string sub = saludo.substr(0, 4);  // "Hola"

// Buscar
size_t pos = saludo.find("C++");        // posición o string::npos si no se encuentra
```

---

## `auto` — Deducción automática de tipo (C++11)

`auto` le indica al compilador que deduzca el tipo de la variable a partir del valor
de inicialización. El tipo se determina en **tiempo de compilación**, no en ejecución.

```cpp
auto x = 42;          // int
auto y = 3.14;        // double
auto z = true;        // bool
auto s = std::string("hola");  // std::string

// Muy útil con tipos complejos
auto it = miVector.begin();   // en lugar de std::vector<int>::iterator
```

---

## `const` y `constexpr`

```cpp
// const: valor que no cambia en tiempo de ejecución
const int MAX_EDAD = 120;

// constexpr: valor calculado y fijo en TIEMPO DE COMPILACIÓN
constexpr double PI = 3.14159265358979;
constexpr int CUADRADO_5 = 5 * 5;  // El compilador calcula 25
```

Diferencia clave: `const` puede inicializarse con un valor calculado en tiempo de
ejecución, mientras que `constexpr` **siempre** debe ser calculable en compilación.

---

## `nullptr` — Puntero nulo (C++11)

En C se usaba `NULL` (que es `0` o `(void*)0`). En C++11 se introdujo `nullptr`,
que tiene su propio tipo (`std::nullptr_t`) y evita ambigüedades:

```cpp
int* p = nullptr;   // Puntero nulo tipo-seguro

// NULL podría causar ambigüedad en sobrecarga de funciones
void funcion(int n);
void funcion(int* p);

funcion(NULL);     // ¿Llama la versión int o int*? Ambiguo
funcion(nullptr);  // Llama claramente la versión int*
```

---

## Inicialización uniforme (C++11)

C++11 introdujo la inicialización con llaves `{}` que es más segura porque
previene conversiones de tipo que pierden información:

```cpp
int a{42};            // OK
int b{3.14};          // ERROR de compilación (se perdería la parte decimal)
double c{3.14};       // OK
std::string s{"hola"};
```

---

## Archivo de ejemplo

Ver: [01_tipos.cpp](01_tipos.cpp)
