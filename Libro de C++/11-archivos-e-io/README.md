# Capítulo 11 — Archivos e I/O

## Flujos de E/S en C++

C++ usa **flujos (streams)** para todas las operaciones de entrada/salida:

| Clase | Uso |
|-------|-----|
| `std::ifstream` | Leer desde archivo (input file stream) |
| `std::ofstream` | Escribir en archivo (output file stream) |
| `std::fstream` | Leer y escribir en el mismo archivo |
| `std::stringstream` | Leer/escribir en un string en memoria |

Todos están en `<fstream>` (excepto `stringstream` que está en `<sstream>`).

---

## Abrir y cerrar archivos

```cpp
#include <fstream>

// Abrir al construir
std::ifstream entrada("datos.txt");
std::ofstream salida("resultado.txt");

// Verificar si se abrió correctamente
if (!entrada.is_open()) {
    std::cerr << "Error: no se pudo abrir el archivo\n";
}

// Cerrar explícitamente (también se cierra automáticamente al destruirse)
entrada.close();
```

---

## Modos de apertura

```cpp
// ofstream: por defecto sobrescribe el archivo
std::ofstream f("log.txt");

// Para agregar al final sin borrar el contenido existente
std::ofstream f("log.txt", std::ios::app);

// fstream con múltiples modos combinados
std::fstream f("datos.bin", std::ios::in | std::ios::out | std::ios::binary);
```

| Flag | Descripción |
|------|-------------|
| `ios::in` | Abrir para lectura |
| `ios::out` | Abrir para escritura |
| `ios::app` | Agregar al final |
| `ios::trunc` | Truncar (sobrescribir) |
| `ios::binary` | Modo binario |

---

## Leer archivos

```cpp
std::ifstream f("texto.txt");
std::string linea;

// Leer línea por línea
while (std::getline(f, linea)) {
    std::cout << linea << "\n";
}

// Leer palabra por palabra
std::string palabra;
while (f >> palabra) {
    std::cout << palabra << "\n";
}
```

---

## Escribir archivos

```cpp
std::ofstream f("salida.txt");
f << "Primera línea\n";
f << "Número: " << 42 << "\n";
```

---

## `std::stringstream` — Stream en memoria

Muy útil para convertir tipos a string y viceversa:

```cpp
#include <sstream>

// Construir un string complejo
std::stringstream ss;
ss << "Nombre: " << nombre << ", Edad: " << edad;
std::string resultado = ss.str();

// Parsear un string
std::stringstream parser("42 3.14 hola");
int n; double d; std::string s;
parser >> n >> d >> s;
```

---

## Archivo de ejemplo

Ver: [01_archivos.cpp](01_archivos.cpp)
