# Capítulo 04 — Control de Flujo

## if / else

```cpp
if (condicion) {
    // Se ejecuta si condicion es true
} else if (otraCondicion) {
    // Se ejecuta si otraCondicion es true
} else {
    // Se ejecuta si ninguna condición anterior fue true
}
```

---

## switch

Ideal cuando se compara una variable contra múltiples valores constantes:

```cpp
switch (variable) {
    case 1:
        // ...
        break;          // break evita el "fall-through"
    case 2:
        // ...
        break;
    default:
        // Se ejecuta si ningún case coincide
        break;
}
```

> `switch` solo funciona con tipos enteros (`int`, `char`, `enum`), no con `string`.

---

## Bucle `for` clásico

```cpp
for (int i = 0; i < 10; i++) {
    // Se ejecuta 10 veces (i = 0, 1, ..., 9)
}
```

---

## Bucle `while`

```cpp
while (condicion) {
    // Se repite mientras la condición sea true
}
```

---

## Bucle `do-while`

Garantiza que el cuerpo se ejecute **al menos una vez**:

```cpp
do {
    // Se ejecuta al menos una vez
} while (condicion);
```

---

## Range-for (C++11) — Bucle sobre colecciones

Introducido en C++11, simplifica la iteración sobre cualquier colección:

```cpp
std::vector<int> numeros = {1, 2, 3, 4, 5};

// Por valor (copia cada elemento)
for (int n : numeros) {
    std::cout << n << "\n";
}

// Por referencia constante (más eficiente para tipos grandes)
for (const auto& n : numeros) {
    std::cout << n << "\n";
}

// Por referencia (permite modificar)
for (auto& n : numeros) {
    n *= 2;  // Duplica cada elemento
}
```

Funciona con: arrays, `vector`, `string`, `map`, `set`, y cualquier tipo que tenga
iteradores `begin()` y `end()`.

---

## `break` y `continue`

```cpp
for (int i = 0; i < 10; i++) {
    if (i == 5) break;      // Sale del bucle completamente
    if (i % 2 == 0) continue; // Salta esta iteración y va a la siguiente
    std::cout << i << "\n"; // Solo imprime 1, 3
}
```

---

## Inicializador en `if` (C++17)

C++17 permite declarar una variable dentro del `if` cuyo scope queda limitado al bloque:

```cpp
// La variable 'resultado' solo existe dentro del if/else
if (int resultado = calcular(); resultado > 0) {
    std::cout << "Positivo: " << resultado << "\n";
} else {
    std::cout << "No positivo: " << resultado << "\n";
}
// 'resultado' ya no existe aquí
```

---

## Archivo de ejemplo

Ver: [01_control_flujo.cpp](01_control_flujo.cpp)
