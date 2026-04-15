# Capítulo 09 — STL: Contenedores y Algoritmos

## ¿Qué es la STL?

La **Standard Template Library (STL)** es la biblioteca estándar de C++ que provee:
- **Contenedores**: estructuras de datos genéricas (`vector`, `map`, `set`, etc.)
- **Algoritmos**: funciones genéricas (`sort`, `find`, `count`, etc.) en `<algorithm>`
- **Iteradores**: puente entre contenedores y algoritmos

---

## Contenedores principales

### `std::vector` — Array dinámico

```cpp
#include <vector>
std::vector<int> nums = {1, 2, 3, 4, 5};

nums.push_back(6);      // Agrega al final: O(1) amortizado
nums.pop_back();        // Elimina el último
nums.size();            // Número de elementos
nums[2];                // Acceso por índice (sin verificación)
nums.at(2);             // Acceso por índice (con verificación, lanza excepción)
nums.front();           // Primer elemento
nums.back();            // Último elemento
nums.clear();           // Vaciar
nums.empty();           // ¿Está vacío?
```

### `std::map` — Árbol ordenado clave→valor

```cpp
#include <map>
std::map<std::string, int> edades;
edades["Ana"]   = 30;
edades["Carlos"] = 25;

// Buscar
auto it = edades.find("Ana");
if (it != edades.end()) {
    std::cout << it->second;  // 30
}
```

### `std::unordered_map` — Hash map (búsqueda O(1))

```cpp
#include <unordered_map>
std::unordered_map<std::string, int> config;
config["max_items"] = 100;
// Más rápido que map para búsquedas, pero sin orden
```

### `std::set` — Conjunto de valores únicos y ordenados

```cpp
#include <set>
std::set<int> conjunto = {3, 1, 4, 1, 5, 9, 2};
// Almacena: {1, 2, 3, 4, 5, 9} (sin duplicados, ordenado)
conjunto.insert(7);
conjunto.count(3);   // 1 si existe, 0 si no
```

### `std::list` — Lista doblemente enlazada

```cpp
#include <list>
std::list<int> lista = {1, 2, 3};
lista.push_front(0);   // Inserción al inicio: O(1)
lista.push_back(4);
```

### `std::queue` y `std::stack`

```cpp
#include <queue>
#include <stack>
std::queue<int> cola;   // FIFO: push/front/pop
std::stack<int> pila;   // LIFO: push/top/pop
```

---

## Iteradores

```cpp
std::vector<int> v = {1, 2, 3, 4, 5};

// Iterador clásico
for (auto it = v.begin(); it != v.end(); ++it) {
    std::cout << *it << " ";
}

// Range-for (equivalente, más limpio)
for (const auto& elem : v) {
    std::cout << elem << " ";
}
```

---

## Algoritmos de `<algorithm>`

```cpp
#include <algorithm>

std::sort(v.begin(), v.end());              // Ordenar ascendente
std::sort(v.begin(), v.end(), std::greater<int>()); // Descendente

auto it = std::find(v.begin(), v.end(), 3); // Buscar valor

int cnt = std::count(v.begin(), v.end(), 5); // Contar ocurrencias

auto it2 = std::find_if(v.begin(), v.end(),  // Buscar con predicado
    [](int x) { return x > 3; });

std::for_each(v.begin(), v.end(),            // Aplicar función a cada elemento
    [](int& x) { x *= 2; });

std::reverse(v.begin(), v.end());            // Invertir
std::fill(v.begin(), v.end(), 0);            // Rellenar con valor
```

---

## Cuándo usar cada contenedor

| Contenedor | Uso ideal |
|------------|-----------|
| `vector` | Lista dinámica general, acceso por índice |
| `list` | Muchas inserciones/eliminaciones en el medio |
| `map` | Diccionario ordenado por clave |
| `unordered_map` | Diccionario rápido sin orden |
| `set` | Colección sin duplicados y ordenada |
| `queue` | Cola de tareas (FIFO) |
| `stack` | Pila de llamadas, historial (LIFO) |

---

## Archivo de ejemplo

Ver: [01_stl.cpp](01_stl.cpp)
