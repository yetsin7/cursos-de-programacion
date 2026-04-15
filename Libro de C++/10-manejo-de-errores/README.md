# Capítulo 10 — Manejo de Errores y Excepciones

## Excepciones en C++

C++ usa un mecanismo de **excepciones** para manejar errores en tiempo de ejecución:
- `throw`: lanza una excepción
- `try`: bloque que puede lanzar excepciones
- `catch`: captura y maneja la excepción

```cpp
try {
    // Código que puede fallar
    if (divisor == 0) throw std::runtime_error("División por cero");
    resultado = a / divisor;
} catch (const std::runtime_error& e) {
    std::cerr << "Error: " << e.what() << "\n";
} catch (const std::exception& e) {
    std::cerr << "Excepción estándar: " << e.what() << "\n";
} catch (...) {
    std::cerr << "Excepción desconocida\n";
}
```

---

## Jerarquía de excepciones estándar

```
std::exception
├── std::logic_error
│   ├── std::invalid_argument
│   ├── std::domain_error
│   ├── std::length_error
│   └── std::out_of_range
└── std::runtime_error
    ├── std::overflow_error
    ├── std::underflow_error
    └── std::range_error
```

Todas heredan de `std::exception` y tienen el método `what()` que devuelve
la descripción del error.

---

## Excepciones personalizadas

```cpp
// Hereda de std::exception o de alguna subclase
class ErrorBD : public std::runtime_error {
public:
    explicit ErrorBD(const std::string& mensaje)
        : std::runtime_error(mensaje) {}
};

// Lanzar
throw ErrorBD("No se pudo conectar a la base de datos");

// Capturar
catch (const ErrorBD& e) {
    std::cerr << "Error de BD: " << e.what() << "\n";
}
```

---

## `noexcept` (C++11)

Indica que una función **no lanzará excepciones**. El compilador puede optimizarla:

```cpp
int sumar(int a, int b) noexcept {
    return a + b;
}

// Si la función marcada noexcept lanza, se llama std::terminate()
```

---

## RAII — Resource Acquisition Is Initialization

Patrón fundamental en C++: los recursos se adquieren en el constructor y se
liberan en el destructor. Esto garantiza la limpieza incluso si hay excepciones:

```cpp
class Archivo {
    std::ofstream f;
public:
    Archivo(const std::string& ruta) { f.open(ruta); }
    ~Archivo() { if (f.is_open()) f.close(); }  // Se cierra siempre
};
```

---

## Mejores prácticas

1. Captura por referencia constante: `catch (const std::exception& e)`
2. Captura las excepciones más específicas primero
3. No uses excepciones para control de flujo normal
4. Prefiere `noexcept` en funciones que genuinamente no pueden fallar
5. Usa RAII para gestionar recursos (evita leaks aunque haya excepciones)

---

## Archivo de ejemplo

Ver: [01_excepciones.cpp](01_excepciones.cpp)
