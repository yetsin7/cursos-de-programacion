# Capítulo 12 — C++ Moderno (C++11/14/17)

## ¿Por qué "C++ moderno"?

C++11 fue una revolución en el lenguaje. Desde entonces, cada estándar ha añadido
carácterísticas que hacen el código más seguro, expresivo y eficiente:

- **C++11** (2011): la mayor actualización desde C++98. Base del C++ moderno.
- **C++14** (2014): mejoras menores y correcciones.
- **C++17** (2017): structured bindings, `if constexpr`, `std::optional`, `std::variant`.

---

## `auto` — Deducción de tipo

```cpp
auto x = 42;              // int
auto v = std::vector<int>{1, 2, 3};  // std::vector<int>
auto fn = [](int a) { return a * 2; }; // lambda
```

---

## Range-for (C++11)

```cpp
for (const auto& elem : contenedor) { ... }
```

---

## Lambdas (C++11)

```cpp
// [captura](params) -> retorno { cuerpo }
auto sumar = [](int a, int b) { return a + b; };

// Captura por valor [=] o por referencia [&]
int offset = 10;
auto con_offset = [offset](int x) { return x + offset; };
```

---

## Smart Pointers (C++11)

Reemplazan los punteros crudos y eliminan la necesidad de `delete` manual:

### `unique_ptr` — Propiedad única

```cpp
#include <memory>
auto p = std::make_unique<Persona>("Ana", 30);
// Se destruye automáticamente al salir del scope
// No se puede copiar, solo mover
```

### `shared_ptr` — Propiedad compartida

```cpp
auto sp1 = std::make_shared<Persona>("Carlos", 25);
auto sp2 = sp1;  // Ambos apuntan al mismo objeto
// Se destruye cuando el último shared_ptr que apunta a él es destruido
// (contador de referencias)
```

### `weak_ptr` — Referencia débil (no tiene propiedad)

```cpp
std::weak_ptr<Persona> wp = sp1;  // No incrementa el contador
if (auto locked = wp.lock()) {    // lock() devuelve shared_ptr o nullptr
    locked->saludar();
}
```

---

## Move semantics (C++11)

Permite transferir recursos en lugar de copiarlos (mucho más eficiente):

```cpp
std::string s1 = "hola";
std::string s2 = std::move(s1);  // s1 queda vacío, s2 tiene "hola"
// No se copió ningún carácter: se transfirió la propiedad del buffer
```

---

## `nullptr` (C++11)

Reemplaza `NULL` con un tipo propio y seguro: `std::nullptr_t`.

---

## Initializer list (C++11)

```cpp
std::vector<int> v = {1, 2, 3, 4, 5};  // Inicialización uniforme
std::map<std::string, int> m = {{"uno", 1}, {"dos", 2}};
```

---

## Structured bindings (C++17)

```cpp
auto [clave, valor] = *map.begin();  // Desempaqueta par<K,V>
auto [x, y, z] = std::tuple{1, 2.0, "tres"};
```

---

## `if constexpr` (C++17)

Evaluación condicional en tiempo de compilación:

```cpp
template <typename T>
void procesar(T valor) {
    if constexpr (std::is_integral_v<T>) {
        std::cout << "Entero: " << valor << "\n";
    } else {
        std::cout << "Otro tipo: " << valor << "\n";
    }
}
```

---

## Archivo de ejemplo

Ver: [01_moderno.cpp](01_moderno.cpp)
