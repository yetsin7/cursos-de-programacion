/**
 * Capítulo 05 — Funciones
 * Archivo: 01_funciones.cpp
 *
 * Demuestra:
 *   - Definición y llamada de funciones
 *   - Paso por valor, por referencia y por referencia constante
 *   - Parámetros con valores por defecto
 *   - Sobrecarga de funciones (mismo nombre, diferentes parámetros)
 *   - Funciones inline
 *   - Lambdas básicas (C++11)
 *   - Recursión con factorial y Fibonacci
 *
 * Compilar: g++ -std=c++17 -o funciones 01_funciones.cpp
 */

#include <iostream>
#include <string>
#include <vector>
#include <algorithm>  // Para std::sort con lambda

// -------------------------------------------------------------------------
// Prototipos (declaraciones adelantadas)
// Permiten usar las funciones antes de su definición completa
// -------------------------------------------------------------------------
int    sumar(int a, int b);
void   incrementar(int& valor);
void   mostrarNombre(const std::string& nombre);
double potencia(double base, int exponente = 2);
long long factorial(int n);

// -------------------------------------------------------------------------
// Sobrecarga: mismas nombre 'area', distintos parámetros
// -------------------------------------------------------------------------

// Calcula el área de un cuadrado
int area(int lado) {
    return lado * lado;
}

// Calcula el área de un rectángulo
double area(double base, double altura) {
    return base * altura;
}

// Calcula el área de un círculo
double area(double radio, bool esCirculo) {
    const double PI = 3.14159265358979;
    return PI * radio * radio;
}

// -------------------------------------------------------------------------
// Función inline: expansión en el punto de llamada (sin overhead de llamada)
// -------------------------------------------------------------------------
inline int cuadrado(int x) {
    return x * x;
}

// -------------------------------------------------------------------------
// Función recursiva: calcula el factorial de n
// Caso base: factorial(0) = factorial(1) = 1
// -------------------------------------------------------------------------
long long factorial(int n) {
    if (n <= 1) return 1;
    return static_cast<long long>(n) * factorial(n - 1);
}

// -------------------------------------------------------------------------
// Función recursiva: Fibonacci
// fib(0)=0, fib(1)=1, fib(n)=fib(n-1)+fib(n-2)
// -------------------------------------------------------------------------
int fibonacci(int n) {
    if (n <= 0) return 0;
    if (n == 1) return 1;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

// -------------------------------------------------------------------------
// Funciones con paso de parámetros
// -------------------------------------------------------------------------

// Recibe por valor: no modifica el original
int sumar(int a, int b) {
    return a + b;
}

// Recibe por referencia: modifica el original
void incrementar(int& valor) {
    valor++;
}

// Recibe por referencia constante: eficiente, no modifica
void mostrarNombre(const std::string& nombre) {
    std::cout << "Nombre: " << nombre << "\n";
}

// Parámetro con valor por defecto (exponente = 2)
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
    // 1. Funciones básicas
    // -------------------------------------------------------------------------
    cout << "=== FUNCIONES BÁSICAS ===\n";

    int resultado = sumar(8, 5);
    cout << "8 + 5 = " << resultado << "\n";

    // Paso por referencia: la variable original cambia
    int numero = 10;
    cout << "Antes: " << numero << "\n";
    incrementar(numero);
    cout << "Después de incrementar: " << numero << "\n";

    mostrarNombre("María García");

    // -------------------------------------------------------------------------
    // 2. Parámetros por defecto
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
    // 4. Función inline
    // -------------------------------------------------------------------------
    cout << "\n=== INLINE ===\n";

    for (int i = 1; i <= 5; i++) {
        cout << i << "² = " << cuadrado(i) << "\n";
    }

    // -------------------------------------------------------------------------
    // 5. Lambdas (C++11)
    // -------------------------------------------------------------------------
    cout << "\n=== LAMBDAS ===\n";

    // Lambda simple asignada a variable auto
    auto multiplicar = [](int a, int b) -> int { return a * b; };
    cout << "3 * 7 = " << multiplicar(3, 7) << "\n";

    // Lambda que captura variable del scope exterior por valor
    int descuento = 10;
    auto aplicarDescuento = [descuento](double precio) -> double {
        return precio * (1.0 - descuento / 100.0);
    };
    cout << "Precio $100 con " << descuento << "% descuento: $"
         << aplicarDescuento(100.0) << "\n";

    // Lambda con captura por referencia (puede modificar la variable)
    int acumulador = 0;
    auto acumular = [&acumulador](int valor) { acumulador += valor; };
    for (int i = 1; i <= 5; i++) acumular(i);
    cout << "Suma 1..5 con lambda: " << acumulador << "\n";

    // Lambda usada con algoritmo STL (sort)
    vector<int> nums = {5, 2, 8, 1, 9, 3};
    sort(nums.begin(), nums.end(), [](int a, int b) { return a > b; }); // Desc
    cout << "Ordenado descendente: ";
    for (int n : nums) cout << n << " ";
    cout << "\n";

    // -------------------------------------------------------------------------
    // 6. Recursión
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

    return 0;
}
