/**
 * Capítulo 02 — Variables y Tipos de Datos
 * Archivo: 01_tipos.cpp
 *
 * Demuestra:
 *   - Tipos primitivos: bool, char, int, long, float, double
 *   - std::string para cadenas de texto
 *   - auto para deducción automática de tipo (C++11)
 *   - const y constexpr para valores inmutables
 *   - nullptr para punteros nulos seguros (C++11)
 *   - sizeof para conocer el tamaño en bytes de cada tipo
 *
 * Compilar: g++ -std=c++17 -o tipos 01_tipos.cpp
 */

#include <iostream>
#include <string>
#include <climits>   // Para INT_MAX, INT_MIN, etc.
#include <cfloat>    // Para DBL_MAX, FLT_MAX, etc.

// Constantes globales definidas en tiempo de compilación
constexpr double PI           = 3.14159265358979323846;
constexpr int    MAX_INTENTOS = 3;

int main() {
    using namespace std;

    // -------------------------------------------------------------------------
    // 1. Tipos enteros
    // -------------------------------------------------------------------------
    cout << "=== TIPOS ENTEROS ===\n";

    bool     esCierto = true;
    char     letra    = 'A';
    int      entero   = -2147483648;
    unsigned int uEntero = 4294967295U;
    long long grande  = 9223372036854775807LL;

    cout << "bool:               " << esCierto  << " (1=true, 0=false)\n";
    cout << "char:               " << letra     << " (código ASCII: " << (int)letra << ")\n";
    cout << "int:                " << entero    << "\n";
    cout << "unsigned int:       " << uEntero   << "\n";
    cout << "long long:          " << grande    << "\n";

    // Tamaños en memoria
    cout << "\n--- Tamaños (sizeof) ---\n";
    cout << "sizeof(bool):       " << sizeof(bool)      << " bytes\n";
    cout << "sizeof(char):       " << sizeof(char)      << " bytes\n";
    cout << "sizeof(int):        " << sizeof(int)       << " bytes\n";
    cout << "sizeof(long long):  " << sizeof(long long) << " bytes\n";

    // -------------------------------------------------------------------------
    // 2. Tipos de punto flotante
    // -------------------------------------------------------------------------
    cout << "\n=== TIPOS FLOTANTES ===\n";

    float  flotante  = 3.14f;       // El sufijo 'f' indica float (no double)
    double doble     = 3.14159265;
    long double lDoble = 3.14159265358979323846L;

    cout << "float:              " << flotante  << "\n";
    cout << "double:             " << doble     << "\n";
    cout << "long double:        " << (double)lDoble << "\n";
    cout << "sizeof(float):      " << sizeof(float)       << " bytes\n";
    cout << "sizeof(double):     " << sizeof(double)      << " bytes\n";

    // -------------------------------------------------------------------------
    // 3. std::string — Cadenas de texto
    // -------------------------------------------------------------------------
    cout << "\n=== STRING ===\n";

    string nombre   = "C++17";
    string lenguaje = "Lenguaje: " + nombre;  // Concatenación

    cout << "Cadena:             " << lenguaje         << "\n";
    cout << "Longitud:           " << lenguaje.length()<< " caracteres\n";
    cout << "Primer carácter:    " << lenguaje[0]      << "\n";
    cout << "Subcadena [0,8]:    " << lenguaje.substr(0, 8) << "\n";

    // Buscar una subcadena
    size_t posicion = lenguaje.find("C++");
    if (posicion != string::npos) {
        cout << "\"C++\" encontrado en posición: " << posicion << "\n";
    }

    // -------------------------------------------------------------------------
    // 4. auto — Deducción automática de tipo (C++11)
    // -------------------------------------------------------------------------
    cout << "\n=== AUTO ===\n";

    auto enteroAuto   = 42;          // int
    auto dobleAuto    = 2.718;       // double
    auto boolAuto     = false;       // bool
    auto stringAuto   = string("hola auto");  // std::string

    cout << "auto int:    " << enteroAuto   << "\n";
    cout << "auto double: " << dobleAuto    << "\n";
    cout << "auto bool:   " << boolAuto     << "\n";
    cout << "auto string: " << stringAuto   << "\n";

    // -------------------------------------------------------------------------
    // 5. const y constexpr
    // -------------------------------------------------------------------------
    cout << "\n=== CONST Y CONSTEXPR ===\n";

    const int    limiteEdad = 18;   // Constante en tiempo de ejecución
    // constexpr PI ya definida globalmente

    cout << "const limiteEdad:   " << limiteEdad    << "\n";
    cout << "constexpr PI:       " << PI            << "\n";
    cout << "constexpr MAX_INTENTOS: " << MAX_INTENTOS << "\n";

    // El área de un círculo con radio 5 (calculado con constexpr PI)
    double radio = 5.0;
    double area  = PI * radio * radio;
    cout << "Área círculo r=5:   " << area << "\n";

    // -------------------------------------------------------------------------
    // 6. nullptr — Puntero nulo seguro (C++11)
    // -------------------------------------------------------------------------
    cout << "\n=== NULLPTR ===\n";

    int* ptrNulo = nullptr;  // Puntero nulo tipado

    // Verificar antes de usar el puntero
    if (ptrNulo == nullptr) {
        cout << "El puntero es nulo (seguro de verificar con nullptr)\n";
    }

    // Asignar y usar el puntero
    int valor = 99;
    ptrNulo   = &valor;     // Ahora apunta a 'valor'
    cout << "Valor apuntado:     " << *ptrNulo << "\n";

    ptrNulo = nullptr;      // Reasignar a nulo después de usar
    cout << "Puntero liberado con nullptr\n";

    return 0;
}
