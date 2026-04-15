/**
 * Capítulo 08 — Plantillas (Templates)
 * Archivo: 01_templates.cpp
 *
 * Demuestra:
 *   - Function templates: función genérica max() y swap()
 *   - Class templates: clase genérica Pila<T>
 *   - Múltiples parámetros de tipo: Par<K, V>
 *   - Especialización de template para un tipo específico
 *   - Template con parámetro de valor (no-type): ArrayFijo<T, N>
 *
 * Compilar: g++ -std=c++17 -o templates 01_templates.cpp
 */

#include <iostream>
#include <string>
#include <stdexcept>  // Para std::out_of_range

// -------------------------------------------------------------------------
// 1. Function template: máximo genérico
// Funciona con cualquier tipo que soporte el operador >
// -------------------------------------------------------------------------

/**
 * Devuelve el mayor de dos valores de cualquier tipo comparable.
 * @tparam T Tipo de los parámetros (se deduce automáticamente)
 * @param a Primer valor
 * @param b Segundo valor
 * @return El mayor de los dos
 */
template <typename T>
T maximo(T a, T b) {
    return (a > b) ? a : b;
}

// -------------------------------------------------------------------------
// 2. Function template: swap genérico
// -------------------------------------------------------------------------

/**
 * Intercambia los valores de dos variables de cualquier tipo.
 * @tparam T Tipo de las variables
 * @param a Primera variable (modificada)
 * @param b Segunda variable (modificada)
 */
template <typename T>
void intercambiar(T& a, T& b) {
    T temporal = a;
    a = b;
    b = temporal;
}

// -------------------------------------------------------------------------
// 3. Class template: Pila genérica (stack)
// Implementación simple de una pila LIFO con array dinámico
// -------------------------------------------------------------------------

/**
 * Pila<T> — Estructura de datos tipo pila (LIFO: Last In, First Out).
 * Funciona con cualquier tipo de dato.
 * @tparam T Tipo de los elementos almacenados
 */
template <typename T>
class Pila {
private:
    T*  datos;       // Array dinámico de elementos
    int tope;        // Índice del elemento en el tope
    int capacidad;   // Capacidad máxima actual

public:
    /**
     * Constructor: crea una pila con la capacidad indicada.
     * @param cap Capacidad máxima de la pila (por defecto 10)
     */
    explicit Pila(int cap = 10) : tope(-1), capacidad(cap) {
        datos = new T[capacidad];
    }

    // Destructor: libera la memoria del array dinámico
    ~Pila() {
        delete[] datos;
    }

    /**
     * Agrega un elemento al tope de la pila.
     * @param valor Elemento a agregar
     * @throws std::overflow_error Si la pila está llena
     */
    void push(const T& valor) {
        if (tope >= capacidad - 1) {
            throw std::overflow_error("Pila llena: no se puede hacer push");
        }
        datos[++tope] = valor;
    }

    /**
     * Elimina y devuelve el elemento del tope.
     * @return Elemento en el tope
     * @throws std::underflow_error Si la pila está vacía
     */
    T pop() {
        if (estaVacia()) {
            throw std::underflow_error("Pila vacía: no se puede hacer pop");
        }
        return datos[tope--];
    }

    /**
     * Devuelve el elemento del tope sin eliminarlo.
     * @return Referencia constante al elemento en el tope
     */
    const T& peek() const {
        if (estaVacia()) {
            throw std::underflow_error("Pila vacía: no hay elemento en el tope");
        }
        return datos[tope];
    }

    // Verifica si la pila está vacía
    bool estaVacia() const { return tope == -1; }

    // Devuelve el número de elementos actuales
    int tamanio() const { return tope + 1; }
};

// -------------------------------------------------------------------------
// 4. Class template con múltiples parámetros de tipo
// -------------------------------------------------------------------------

/**
 * Par<K, V> — Almacena un par clave-valor de tipos independientes.
 * @tparam K Tipo de la clave
 * @tparam V Tipo del valor
 */
template <typename K, typename V>
class Par {
public:
    K clave;
    V valor;

    Par(const K& k, const V& v) : clave(k), valor(v) {}

    void mostrar() const {
        std::cout << "(" << clave << ", " << valor << ")\n";
    }
};

// -------------------------------------------------------------------------
// 5. Especialización de template
// -------------------------------------------------------------------------

// Template general: convierte cualquier tipo a string
template <typename T>
std::string aTexto(T val) {
    return std::to_string(val);
}

// Especialización para bool: devuelve "verdadero"/"falso"
template <>
std::string aTexto<bool>(bool val) {
    return val ? "verdadero" : "falso";
}

// Especialización para string: devuelve el valor tal cual (entre comillas)
template <>
std::string aTexto<std::string>(std::string val) {
    return "\"" + val + "\"";
}

// -------------------------------------------------------------------------
// 6. Template con parámetro de valor (non-type template parameter)
// -------------------------------------------------------------------------

/**
 * ArrayFijo<T, N> — Array con tamaño fijo determinado en tiempo de compilación.
 * @tparam T Tipo de los elementos
 * @tparam N Tamaño del array (constante en compilación)
 */
template <typename T, int N>
class ArrayFijo {
private:
    T datos[N];

public:
    // Acceso con verificación de bounds
    T& operator[](int i) {
        if (i < 0 || i >= N) throw std::out_of_range("Índice fuera de rango");
        return datos[i];
    }

    int capacidad() const { return N; }
};

int main() {
    using namespace std;

    // -------------------------------------------------------------------------
    // 1. Function template: maximo
    // -------------------------------------------------------------------------
    cout << "=== FUNCTION TEMPLATE: maximo ===\n";

    cout << "maximo(3, 7):           " << maximo(3, 7)           << "\n";
    cout << "maximo(3.14, 2.71):     " << maximo(3.14, 2.71)     << "\n";
    cout << "maximo('a', 'z'):       " << maximo('a', 'z')       << "\n";
    cout << "maximo(\"hola\",\"mundo\"): "
         << maximo(string("hola"), string("mundo")) << "\n";

    // -------------------------------------------------------------------------
    // 2. Function template: intercambiar
    // -------------------------------------------------------------------------
    cout << "\n=== FUNCTION TEMPLATE: intercambiar ===\n";

    int x = 5, y = 10;
    cout << "Antes:  x=" << x << ", y=" << y << "\n";
    intercambiar(x, y);
    cout << "Después: x=" << x << ", y=" << y << "\n";

    string s1 = "hola", s2 = "mundo";
    intercambiar(s1, s2);
    cout << "Strings: s1=" << s1 << ", s2=" << s2 << "\n";

    // -------------------------------------------------------------------------
    // 3. Class template: Pila<T>
    // -------------------------------------------------------------------------
    cout << "\n=== CLASS TEMPLATE: Pila<T> ===\n";

    Pila<int> pilaInt(5);
    pilaInt.push(10);
    pilaInt.push(20);
    pilaInt.push(30);
    cout << "Pila<int> — tope: " << pilaInt.peek() << ", tamaño: " << pilaInt.tamanio() << "\n";
    cout << "pop(): " << pilaInt.pop() << "\n";
    cout << "pop(): " << pilaInt.pop() << "\n";
    cout << "Tamaño tras pops: " << pilaInt.tamanio() << "\n";

    Pila<string> pilaStr(3);
    pilaStr.push("primero");
    pilaStr.push("segundo");
    cout << "Pila<string> — tope: " << pilaStr.peek() << "\n";

    // -------------------------------------------------------------------------
    // 4. Par<K, V>
    // -------------------------------------------------------------------------
    cout << "\n=== CLASS TEMPLATE: Par<K,V> ===\n";

    Par<string, int>    edadPar("María", 28);
    Par<string, double> precioPar("Manzana", 1.50);
    Par<int,    string> codigoPar(404, "No encontrado");

    edadPar.mostrar();
    precioPar.mostrar();
    codigoPar.mostrar();

    // -------------------------------------------------------------------------
    // 5. Especialización
    // -------------------------------------------------------------------------
    cout << "\n=== ESPECIALIZACIÓN ===\n";

    cout << "aTexto(42):       " << aTexto(42)              << "\n";
    cout << "aTexto(3.14):     " << aTexto(3.14)            << "\n";
    cout << "aTexto(true):     " << aTexto(true)            << "\n";  // Especializado
    cout << "aTexto(false):    " << aTexto(false)           << "\n";
    cout << "aTexto(string):   " << aTexto(string("C++17")) << "\n"; // Especializado

    // -------------------------------------------------------------------------
    // 6. ArrayFijo<T, N>
    // -------------------------------------------------------------------------
    cout << "\n=== TEMPLATE CON PARÁMETRO DE VALOR ===\n";

    ArrayFijo<int, 5> arr;
    for (int i = 0; i < arr.capacidad(); i++) arr[i] = i * i;
    cout << "ArrayFijo<int,5>: ";
    for (int i = 0; i < arr.capacidad(); i++) cout << arr[i] << " ";
    cout << "\n";

    return 0;
}
