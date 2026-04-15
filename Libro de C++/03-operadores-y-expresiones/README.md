# Capítulo 03 — Operadores y Expresiones

## Operadores aritméticos

| Operador | Nombre | Ejemplo | Resultado |
|----------|--------|---------|-----------|
| `+` | Suma | `5 + 3` | `8` |
| `-` | Resta | `5 - 3` | `2` |
| `*` | Multiplicación | `5 * 3` | `15` |
| `/` | División | `7 / 2` | `3` (entero) / `3.5` (flotante) |
| `%` | Módulo (resto) | `7 % 2` | `1` |
| `++` | Incremento | `a++` / `++a` | Postfijo / Prefijo |
| `--` | Decremento | `a--` / `--a` | Postfijo / Prefijo |

> **División entera**: `7 / 2` da `3`, no `3.5`. Para obtener flotante, usa `7.0 / 2` o `(double)7 / 2`.

---

## Operadores de comparación

| Operador | Significado | Ejemplo |
|----------|-------------|---------|
| `==` | Igual a | `a == b` |
| `!=` | Diferente de | `a != b` |
| `<` | Menor que | `a < b` |
| `>` | Mayor que | `a > b` |
| `<=` | Menor o igual | `a <= b` |
| `>=` | Mayor o igual | `a >= b` |

Todos devuelven `bool` (`true` o `false`).

---

## Operadores lógicos

| Operador | Nombre | Ejemplo | Descripción |
|----------|--------|---------|-------------|
| `&&` | AND lógico | `a && b` | `true` si **ambos** son verdaderos |
| `\|\|` | OR lógico | `a \|\| b` | `true` si **alguno** es verdadero |
| `!` | NOT lógico | `!a` | Invierte el valor booleano |

C++ usa **evaluación en cortocircuito**: en `a && b`, si `a` es `false`, `b` no se evalúa.

---

## Operadores de asignación

```cpp
a = 5;    // Asignación simple
a += 3;   // a = a + 3  → 8
a -= 2;   // a = a - 2  → 6
a *= 4;   // a = a * 4  → 24
a /= 6;   // a = a / 6  → 4
a %= 3;   // a = a % 3  → 1
```

---

## Operador ternario

El operador ternario `?:` es una forma compacta de `if/else` que **devuelve un valor**:

```cpp
// Sintaxis: condicion ? valor_si_true : valor_si_false
int max = (a > b) ? a : b;
std::string estado = (edad >= 18) ? "mayor de edad" : "menor de edad";
```

---

## Operadores propios de C++

### `new` y `delete` — Memoria dinámica

```cpp
// Reservar memoria dinámica en el heap
int* p = new int(42);       // Puntero a un entero inicializado en 42
int* arr = new int[10];     // Array de 10 enteros

// Liberar memoria (OBLIGATORIO para evitar fugas de memoria)
delete p;                   // Liberar un solo objeto
delete[] arr;               // Liberar un array

p   = nullptr;              // Buena práctica: anular el puntero tras liberar
arr = nullptr;
```

> En C++ moderno se prefieren los **smart pointers** (`unique_ptr`, `shared_ptr`)
> que liberan la memoria automáticamente. Ver capítulo 12.

### `::` — Operador de resolución de alcance

```cpp
std::cout     // Accede a 'cout' dentro del namespace 'std'
MiClase::metodo()   // Accede a un método estático de una clase
::variableGlobal    // Accede explícitamente a una variable global
```

### `->` — Acceso a miembro a través de puntero

```cpp
Persona* ptr = new Persona("Ana");
ptr->nombre;        // Equivale a (*ptr).nombre
ptr->saludar();     // Equivale a (*ptr).saludar()
```

### `sizeof` — Tamaño en bytes

```cpp
sizeof(int)    // 4 (generalmente)
sizeof(x)      // Tamaño de la variable x
```

### `typeid` — Información de tipo (RTTI)

```cpp
#include <typeinfo>
auto x = 3.14;
std::cout << typeid(x).name();  // Muestra el nombre del tipo
```

---

## Precedencia de operadores

De mayor a menor precedencia (simplificado):

1. `()` — Paréntesis
2. `++`, `--`, `!`, `-` (unarios)
3. `*`, `/`, `%`
4. `+`, `-`
5. `<`, `<=`, `>`, `>=`
6. `==`, `!=`
7. `&&`
8. `||`
9. `?:` (ternario)
10. `=`, `+=`, `-=`, etc.

**Consejo**: cuando haya duda, usa paréntesis para claridad.

---

## Archivo de ejemplo

Ver: [01_operadores.cpp](01_operadores.cpp)
