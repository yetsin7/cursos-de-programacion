/**
 * Capitulo 05 — Funciones
 * Archivo: 01_funciones.cpp
 *
 * Este archivo muestra como C++ organiza logica reutilizable con funciones.
 * Tambien enseña como cambia el comportamiento segun pases datos por valor,
 * referencia o referencia constante.
 *
 * Compilar: g++ -std=c++17 -Wall -Wextra -o funciones 01_funciones.cpp
 */

#include <iostream>
#include <string>
#include <vector>
#include <algorithm>  // Para std::sort con lambda

// -------------------------------------------------------------------------
// Prototipos
// Permiten usar funciones antes de su definicion completa.
// -------------------------------------------------------------------------
int    sumar(int a, int b);
void   incrementar(int& valor);
void   mostrarNombre(const std::string& nombre);
double potencia(double base, int exponente = 2);
long long factorial(int n);

// -------------------------------------------------------------------------
// Sobrecarga: mismo nombre, distintos parametros
// -------------------------------------------------------------------------

// Calcula el area de un cuadrado
int area(int lado) {
    return lado * lado;
}

// Calcula el area de un rectangulo
double area(double base, double altura) {
    return base * altura;
}

// Calcula el area de un circulo
double area(double radio, bool esCirculo) {
    const double PI = 3.14159265358979;
    return PI * radio * radio;
}

// -------------------------------------------------------------------------
// Funcion inline
// -------------------------------------------------------------------------
inline int cuadrado(int x) {
    return x * x;
}

// -------------------------------------------------------------------------
// Funcion recursiva: factorial
// -------------------------------------------------------------------------
long long factorial(int n) {
    if (n <= 1) return 1;
    return static_cast<long long>(n) * factorial(n - 1);
}

// -------------------------------------------------------------------------
// Funcion recursiva: Fibonacci
// -------------------------------------------------------------------------
int fibonacci(int n) {
    if (n <= 0) return 0;
    if (n == 1) return 1;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

// -------------------------------------------------------------------------
// Funciones con paso de parametros
// -------------------------------------------------------------------------

// Recibe por valor: no modifica el original
int sumar(int a, int b) {
    return a + b;
}

// Recibe por referencia: modifica el original
void incrementar(int& valor) {
    valor++;
}

// Recibe por referencia constante: evita copia y no modifica
void mostrarNombre(const std::string& nombre) {
    std::cout << "Nombre: " << nombre << "\n";
}

// Parametro con valor por defecto
double potencia(double base, int exponente) {
    double resultado = 1.0;
    for (int i = 0; i < exponente; i++) {
        resultado *= base;
    }
    return resultado;
}

int main() {
    using namespace std;

    // -------------------------------------------------------------------------
    // 1. Funciones basicas
    // -------------------------------------------------------------------------
    cout << "=== FUNCIONES BÁSICAS ===\n";

    int resultado = sumar(8, 5);
    cout << "8 + 5 = " << resultado << "\n";

    // Por referencia, la variable original cambia.
    int numero = 10;
    cout << "Antes: " << numero << "\n";
    incrementar(numero);
    cout << "Después de incrementar: " << numero << "\n";

    mostrarNombre("María García");

    // -------------------------------------------------------------------------
    // 2. Parametros por defecto
    // -------------------------------------------------------------------------
    cout << "\n=== PARÁMETROS POR DEFECTO ===\n";

    cout << "5^2 (defecto) = " << potencia(5.0)    << "\n";
    cout << "5^3           = " << potencia(5.0, 3) << "\n";
    cout << "2^10          = " << potencia(2.0, 10)<< "\n";

    // -------------------------------------------------------------------------
    // 3. Sobrecarga de funciones
    // -------------------------------------------------------------------------
    cout << "\n=== SOBRECARGA (area) ===\n";

    cout << "Área cuadrado lado=6:         " << area(6)            << "\n";
    cout << "Área rectángulo 4.5 x 3.2:    " << area(4.5, 3.2)     << "\n";
    cout << "Área círculo radio=5:         " << area(5.0, true)    << "\n";

    // -------------------------------------------------------------------------
    // 4. Funcion inline
    // -------------------------------------------------------------------------
    cout << "\n=== INLINE ===\n";

    for (int i = 1; i <= 5; i++) {
        cout << i << "² = " << cuadrado(i) << "\n";
    }

    // -------------------------------------------------------------------------
    // 5. Lambdas (C++11)
    // -------------------------------------------------------------------------
    cout << "\n=== LAMBDAS ===\n";

    // Una lambda es una funcion anonima.
    auto multiplicar = [](int a, int b) -> int { return a * b; };
    cout << "3 * 7 = " << multiplicar(3, 7) << "\n";

    // Captura por valor: usa una copia del dato externo.
    int descuento = 10;
    auto aplicarDescuento = [descuento](double precio) -> double {
        return precio * (1.0 - descuento / 100.0);
    };
    cout << "Precio $100 con " << descuento << "% descuento: $"
         << aplicarDescuento(100.0) << "\n";

    // Captura por referencia: puede modificar la variable externa.
    int acumulador = 0;
    auto acumular = [&acumulador](int valor) { acumulador += valor; };
    for (int i = 1; i <= 5; i++) acumular(i);
    cout << "Suma 1..5 con lambda: " << acumulador << "\n";

    // Las lambdas se usan mucho con algoritmos STL.
    vector<int> nums = {5, 2, 8, 1, 9, 3};
    sort(nums.begin(), nums.end(), [](int a, int b) { return a > b; }); // Desc
    cout << "Ordenado descendente: ";
    for (int n : nums) cout << n << " ";
    cout << "\n";

    // -------------------------------------------------------------------------
    // 6. Recursion
    // -------------------------------------------------------------------------
    cout << "\n=== RECURSIÓN ===\n";

    cout << "Factoriales:\n";
    for (int i = 0; i <= 10; i++) {
        cout << i << "! = " << factorial(i) << "\n";
    }

    cout << "\nSecuencia Fibonacci (primeros 8 términos): ";
    for (int i = 0; i < 8; i++) {
        cout << fibonacci(i) << " ";
    }
    cout << "\n";

    cout << "\n=== IDEAS CLAVE ===\n";
    cout << "Las funciones dividen logica en piezas reutilizables.\n";
    cout << "Pasar por valor no es igual que pasar por referencia.\n";
    cout << "Las lambdas ayudan a expresar logica pequeña en el lugar.\n";

    return 0;
}
