/**
 * Capítulo 03 — Operadores y Expresiones
 * Archivo: 01_operadores.cpp
 *
 * Demuestra:
 *   - Operadores aritméticos (+, -, *, /, %, ++, --)
 *   - Operadores de comparación (==, !=, <, >, <=, >=)
 *   - Operadores lógicos (&&, ||, !)
 *   - Operador ternario (?:)
 *   - Operadores de C++: new, delete, ::, ->
 *   - Operadores de asignación compuesta (+=, -=, etc.)
 *
 * Compilar: g++ -std=c++17 -o operadores 01_operadores.cpp
 */

#include <iostream>
#include <string>

// Clase simple usada para demostrar el operador ->
class Punto {
public:
    double x;
    double y;

    // Constructor que inicializa las coordenadas
    Punto(double cx, double cy) : x(cx), y(cy) {}

    // Muestra las coordenadas del punto
    void mostrar() const {
        std::cout << "Punto(" << x << ", " << y << ")\n";
    }
};

int main() {
    using namespace std;

    // -------------------------------------------------------------------------
    // 1. Operadores aritméticos
    // -------------------------------------------------------------------------
    cout << "=== ARITMÉTICOS ===\n";

    int a = 17, b = 5;
    cout << a << " + " << b << " = " << (a + b) << "\n";
    cout << a << " - " << b << " = " << (a - b) << "\n";
    cout << a << " * " << b << " = " << (a * b) << "\n";
    cout << a << " / " << b << " = " << (a / b) << " (división entera)\n";
    cout << a << " % " << b << " = " << (a % b) << " (módulo/resto)\n";

    // División flotante: basta con que uno de los operandos sea double
    cout << a << " / " << b << " = " << (static_cast<double>(a) / b)
         << " (división flotante)\n";

    // Incremento y decremento
    int c = 10;
    cout << "\nInicio c = " << c << "\n";
    cout << "c++ (postfijo): " << c++ << " (c ahora es " << c << ")\n";  // Usa 10, luego suma
    cout << "++c (prefijo):  " << ++c << " (c ahora es " << c << ")\n";  // Suma y usa 12

    // -------------------------------------------------------------------------
    // 2. Operadores de asignación compuesta
    // -------------------------------------------------------------------------
    cout << "\n=== ASIGNACIÓN COMPUESTA ===\n";

    int n = 20;
    cout << "n = " << n << "\n";
    n += 5;  cout << "n += 5  → " << n << "\n";
    n -= 3;  cout << "n -= 3  → " << n << "\n";
    n *= 2;  cout << "n *= 2  → " << n << "\n";
    n /= 4;  cout << "n /= 4  → " << n << "\n";
    n %= 3;  cout << "n %= 3  → " << n << "\n";

    // -------------------------------------------------------------------------
    // 3. Operadores de comparación
    // -------------------------------------------------------------------------
    cout << "\n=== COMPARACIÓN ===\n";

    int x = 10, y = 20;
    // boolalpha hace que cout muestre "true"/"false" en lugar de 1/0
    cout << boolalpha;
    cout << x << " == " << y << " → " << (x == y) << "\n";
    cout << x << " != " << y << " → " << (x != y) << "\n";
    cout << x << " <  " << y << " → " << (x  < y) << "\n";
    cout << x << " >  " << y << " → " << (x  > y) << "\n";
    cout << x << " <= " << y << " → " << (x <= y) << "\n";
    cout << x << " >= " << y << " → " << (x >= y) << "\n";

    // -------------------------------------------------------------------------
    // 4. Operadores lógicos
    // -------------------------------------------------------------------------
    cout << "\n=== LÓGICOS ===\n";

    bool p = true, q = false;
    cout << "p=" << p << ", q=" << q << "\n";
    cout << "p && q → " << (p && q) << "\n";  // AND: ambos deben ser true
    cout << "p || q → " << (p || q) << "\n";  // OR: basta uno
    cout << "!p     → " << (!p)     << "\n";  // NOT: invierte

    // Evaluación en cortocircuito
    int divisor = 0;
    // Si divisor == 0, la segunda condición NO se evalúa (evita división por cero)
    bool seguro = (divisor != 0) && (100 / divisor > 5);
    cout << "Cortocircuito &&: " << seguro << " (sin crash)\n";

    // -------------------------------------------------------------------------
    // 5. Operador ternario
    // -------------------------------------------------------------------------
    cout << "\n=== TERNARIO ===\n";

    int edad = 20;
    // condicion ? valor_si_verdadero : valor_si_falso
    string estado = (edad >= 18) ? "mayor de edad" : "menor de edad";
    cout << "Edad " << edad << ": " << estado << "\n";

    int m = 7, k = 3;
    int maximo = (m > k) ? m : k;  // Máximo entre m y k
    cout << "Máximo de " << m << " y " << k << ": " << maximo << "\n";

    // -------------------------------------------------------------------------
    // 6. Operadores propios de C++: new, delete, ->
    // -------------------------------------------------------------------------
    cout << "\n=== NEW, DELETE, -> ===\n";

    // new: reserva memoria en el heap y devuelve un puntero
    int* numPtr = new int(42);
    cout << "Valor en heap (new): " << *numPtr << "\n";

    // delete: libera la memoria reservada con new
    delete numPtr;
    numPtr = nullptr;  // Anulamos el puntero para evitar puntero colgante

    // new con clase y operador ->
    Punto* pt = new Punto(3.5, 7.2);
    cout << "Usando ->: ";
    pt->mostrar();                      // -> accede al miembro del objeto apuntado
    cout << "Coordenada x: " << pt->x  << "\n";

    delete pt;
    pt = nullptr;

    // -------------------------------------------------------------------------
    // 7. Operador de resolución de alcance ::
    // -------------------------------------------------------------------------
    cout << "\n=== RESOLUCIÓN DE ALCANCE (::) ===\n";

    // std:: es un namespace; :: accede al identificador dentro de él
    // Ya lo usamos en cada std::cout, std::string, etc.
    cout << "El operador :: ya se usa en cada std::cout y std::string\n";

    return 0;
}
