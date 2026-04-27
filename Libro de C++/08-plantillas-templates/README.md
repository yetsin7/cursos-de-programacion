# Capítulo 08 — Plantillas (Templates)

## ¿Qué son los templates?

Los templates permiten escribir **código genérico** que funciona con cualquier tipo
de dato. El compilador genera versiones específicas para cada tipo que se use.

Son la base de la STL (Standard Template Library): `vector<T>`, `map<K,V>`, etc.

---

## Function Templates

```cpp
// Template de función: T es un parámetro de tipo
template <typename T>
T maximo(T a, T b) {
    return (a > b) ? a : b;
}

// El compilador genera versiones concretas según el tipo usado
maximo(3, 7);           // Instancia maximo<int>
maximo(3.14, 2.71);     // Instancia maximo<double>
maximo('a', 'z');       // Instancia maximo<char>
```

---

## Class Templates

```cpp
template <typename T>
class Caja {
private:
    T contenido;
public:
    Caja(T c) : contenido(c) {}
    T obtener() const { return contenido; }
};

Caja<int>    cajaInt(42);
Caja<string> cajaNombre("C++");
```

---

## Múltiples parámetros de tipo

```cpp
template <typename K, typename V>
class Par {
public:
    K clave;
    V valor;
    Par(K k, V v) : clave(k), valor(v) {}
};

Par<string, int> edad("Ana", 30);
```

---

## Especialización de templates

Permite definir una implementación especial para un tipo concreto:

```cpp
// Template general
template <typename T>
std::string aTexto(T val) {
    return std::to_string(val);
}

// Especialización para bool: comportamiento diferente
template <>
std::string aTexto<bool>(bool val) {
    return val ? "verdadero" : "falso";
}
```

---

## Ventajas sobre `void*` (estilo C)

| Carácterística | `void*` (C) | Templates (C++) |
|----------------|-------------|-----------------|
| Seguridad de tipos | No (casteo manual) | Sí (verificación en compilación) |
| Rendimiento | Overhead por casteo | Cero overhead (código inlined) |
| Legibilidad | Difícil de leer | Clara y expresiva |
| Errores | En tiempo de ejecución | En tiempo de compilación |

---

## Parámetros que no son tipos

Los templates también pueden recibir valores constantes como parámetros:

```cpp
template <typename T, int CAPACIDAD>
class ArrayFijo {
    T datos[CAPACIDAD];
public:
    int capacidad() const { return CAPACIDAD; }
};

ArrayFijo<int, 10> arr;     // Array de 10 enteros (tamaño fijo en compilación)
```

---

## Archivo de ejemplo

Ver: [01_templates.cpp](01_templates.cpp)
