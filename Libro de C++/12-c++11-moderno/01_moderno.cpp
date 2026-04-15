/**
 * Capítulo 12 — C++ Moderno (C++11/14/17)
 * Archivo: 01_moderno.cpp
 *
 * Demuestra las características más importantes del C++ moderno:
 *   - auto y deducción de tipo
 *   - Lambdas: captura por valor, referencia y mutable
 *   - unique_ptr y shared_ptr (smart pointers)
 *   - Move semantics con std::move
 *   - nullptr
 *   - Initializer list
 *   - Structured bindings (C++17)
 *   - if constexpr (C++17)
 *   - std::optional (C++17)
 *
 * Compilar: g++ -std=c++17 -o moderno 01_moderno.cpp
 */

#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <memory>    // unique_ptr, shared_ptr, weak_ptr, make_unique, make_shared
#include <optional>  // std::optional (C++17)
#include <algorithm>
#include <utility>   // std::move

// -------------------------------------------------------------------------
// Clase de ejemplo para demostrar smart pointers y move semantics
// -------------------------------------------------------------------------

/**
 * Recurso — Simula un recurso costoso (ej. conexión, buffer grande).
 * Muestra en consola cuándo se crea, copia y destruye.
 */
class Recurso {
private:
    std::string nombre;

public:
    explicit Recurso(const std::string& n) : nombre(n) {
        std::cout << "[Recurso] Creado: " << nombre << "\n";
    }

    // Constructor de copia (caro: copia todos los datos)
    Recurso(const Recurso& otro) : nombre(otro.nombre + "_copia") {
        std::cout << "[Recurso] COPIADO: " << nombre << "\n";
    }

    // Constructor de movimiento (barato: transfiere propiedad)
    Recurso(Recurso&& otro) noexcept : nombre(std::move(otro.nombre)) {
        otro.nombre = "[movido]";
        std::cout << "[Recurso] MOVIDO → " << nombre << "\n";
    }

    ~Recurso() {
        std::cout << "[Recurso] Destruido: " << nombre << "\n";
    }

    std::string getNombre() const { return nombre; }
};

// -------------------------------------------------------------------------
// Función con if constexpr (C++17): comportamiento según tipo en compilación
// -------------------------------------------------------------------------

/**
 * Describe el tipo de un valor en tiempo de compilación.
 * @tparam T Tipo del valor
 * @param val Valor a describir
 */
template <typename T>
void describir(const T& val) {
    if constexpr (std::is_integral_v<T>) {
        std::cout << "Entero: " << val << "\n";
    } else if constexpr (std::is_floating_point_v<T>) {
        std::cout << "Flotante: " << val << "\n";
    } else {
        std::cout << "Otro tipo: " << val << "\n";
    }
}

// -------------------------------------------------------------------------
// Función que devuelve std::optional (C++17)
// -------------------------------------------------------------------------

/**
 * Busca un elemento en un vector. Devuelve el valor si lo encuentra,
 * o un optional vacío si no.
 * @param v      Vector de búsqueda
 * @param target Valor a buscar
 * @return       std::optional<int> con el índice, o vacío si no se encontró
 */
std::optional<int> buscarIndice(const std::vector<int>& v, int target) {
    for (int i = 0; i < (int)v.size(); i++) {
        if (v[i] == target) return i;
    }
    return std::nullopt;  // Ausencia de valor (más seguro que retornar -1)
}

int main() {
    using namespace std;

    // -------------------------------------------------------------------------
    // 1. auto
    // -------------------------------------------------------------------------
    cout << "=== AUTO ===\n";
    auto entero  = 42;
    auto doble   = 3.14;
    auto texto   = string("C++ moderno");
    auto lista   = vector<int>{1, 2, 3, 4, 5};

    cout << "auto int:    " << entero << "\n";
    cout << "auto double: " << doble  << "\n";
    cout << "auto string: " << texto  << "\n";
    cout << "auto vector: ";
    for (const auto& n : lista) cout << n << " ";
    cout << "\n";

    // -------------------------------------------------------------------------
    // 2. Lambdas
    // -------------------------------------------------------------------------
    cout << "\n=== LAMBDAS ===\n";

    // Lambda simple
    auto cuadrado = [](int x) { return x * x; };
    cout << "cuadrado(7): " << cuadrado(7) << "\n";

    // Lambda con captura por valor
    double impuesto = 0.16;
    auto conIVA = [impuesto](double precio) {
        return precio * (1.0 + impuesto);
    };
    cout << "$100 con IVA: $" << conIVA(100.0) << "\n";

    // Lambda con captura por referencia (puede modificar la variable externa)
    int suma = 0;
    for_each(lista.begin(), lista.end(), [&suma](int n) { suma += n; });
    cout << "Suma acumulada: " << suma << "\n";

    // Lambda mutable: captura por valor pero puede modificar la copia
    int contador = 0;
    auto incrementarLocal = [contador]() mutable { return ++contador; };
    cout << "Lambda mutable: " << incrementarLocal()
         << ", " << incrementarLocal() << "\n";
    cout << "Original sin cambiar: " << contador << "\n";

    // -------------------------------------------------------------------------
    // 3. Smart Pointers
    // -------------------------------------------------------------------------
    cout << "\n=== UNIQUE_PTR ===\n";
    {
        // make_unique crea el objeto en el heap con propiedad única
        auto p1 = make_unique<Recurso>("Conexión-DB");
        cout << "Usando: " << p1->getNombre() << "\n";

        // Transferir propiedad con move (p1 queda vacío)
        auto p2 = move(p1);
        cout << "Transferido a p2: " << p2->getNombre() << "\n";
        cout << "p1 nulo tras move: " << (p1 == nullptr ? "Sí" : "No") << "\n";
    }  // p2 se destruye aquí automáticamente
    cout << "(unique_ptr liberado)\n";

    cout << "\n=== SHARED_PTR ===\n";
    {
        auto sp1 = make_shared<Recurso>("Buffer-Compartido");
        cout << "Conteo de refs: " << sp1.use_count() << "\n";
        {
            auto sp2 = sp1;  // Comparten el mismo objeto
            cout << "Conteo con sp2: " << sp1.use_count() << "\n";
        }  // sp2 se destruye, pero el objeto NO (sp1 aún existe)
        cout << "Conteo tras destruir sp2: " << sp1.use_count() << "\n";
    }  // sp1 se destruye → el objeto se libera
    cout << "(shared_ptr liberado)\n";

    // -------------------------------------------------------------------------
    // 4. Move semantics
    // -------------------------------------------------------------------------
    cout << "\n=== MOVE SEMANTICS ===\n";

    string original = "Cadena larga que podría ocupar mucha memoria";
    cout << "original antes: \"" << original << "\"\n";

    // std::move transfiere la propiedad del buffer interno (sin copiar)
    string destino = move(original);
    cout << "destino tras move: \"" << destino << "\"\n";
    cout << "original tras move: \"" << original << "\" (vacío)\n";

    // -------------------------------------------------------------------------
    // 5. Initializer list
    // -------------------------------------------------------------------------
    cout << "\n=== INITIALIZER LIST ===\n";

    vector<string> nombres = {"Ana", "Carlos", "Beatriz", "David"};
    map<string, int> edades = {{"Ana", 30}, {"Carlos", 25}, {"Beatriz", 28}};

    for (const auto& n : nombres) cout << n << " ";
    cout << "\n";

    // -------------------------------------------------------------------------
    // 6. Structured bindings (C++17)
    // -------------------------------------------------------------------------
    cout << "\n=== STRUCTURED BINDINGS (C++17) ===\n";

    for (const auto& [nombre, edad] : edades) {
        cout << nombre << ": " << edad << " años\n";
    }

    // -------------------------------------------------------------------------
    // 7. if constexpr (C++17)
    // -------------------------------------------------------------------------
    cout << "\n=== IF CONSTEXPR (C++17) ===\n";

    describir(42);
    describir(3.14);
    describir(string("hola"));

    // -------------------------------------------------------------------------
    // 8. std::optional (C++17)
    // -------------------------------------------------------------------------
    cout << "\n=== STD::OPTIONAL (C++17) ===\n";

    vector<int> datos = {10, 20, 30, 40, 50};
    for (int buscar : {30, 99, 10}) {
        auto idx = buscarIndice(datos, buscar);
        if (idx.has_value()) {
            cout << "Valor " << buscar << " encontrado en índice " << *idx << "\n";
        } else {
            cout << "Valor " << buscar << " no encontrado\n";
        }
    }

    return 0;
}
