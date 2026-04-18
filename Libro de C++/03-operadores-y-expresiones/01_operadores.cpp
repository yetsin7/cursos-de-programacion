/**
 * Capitulo 03 — Operadores y Expresiones
 * Archivo: 01_operadores.cpp
 *
 * Este archivo muestra como C++ transforma valores y evalua expresiones.
 * Tambien conecta algunos operadores con memoria y punteros, algo muy propio
 * del lenguaje.
 *
 * Compilar: g++ -std=c++17 -Wall -Wextra -o operadores 01_operadores.cpp
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
    // 1. Operadores aritmeticos
    // -------------------------------------------------------------------------
    cout << "=== ARITMÉTICOS ===\n";

    int a = 17, b = 5;
    cout << a << " + " << b << " = " << (a + b) << "\n";
    cout << a << " - " << b << " = " << (a - b) << "\n";
    cout << a << " * " << b << " = " << (a * b) << "\n";
    cout << a << " / " << b << " = " << (a / b) << " (división entera)\n";
    cout << a << " % " << b << " = " << (a % b) << " (módulo/resto)\n";

    // Para obtener division flotante, uno de los operandos debe ser double.
    cout << a << " / " << b << " = " << (static_cast<double>(a) / b)
         << " (división flotante)\n";

    // Prefijo y postfijo no hacen exactamente lo mismo.
    int c = 10;
    cout << "\nInicio c = " << c << "\n";
    cout << "c++ (postfijo): " << c++ << " (c ahora es " << c << ")\n";  // Usa 10, luego suma
    cout << "++c (prefijo):  " << ++c << " (c ahora es " << c << ")\n";  // Suma y usa 12

    // -------------------------------------------------------------------------
    // 2. Operadores de asignacion compuesta
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
    // 3. Operadores de comparacion
    // -------------------------------------------------------------------------
    cout << "\n=== COMPARACIÓN ===\n";

    int x = 10, y = 20;
    // boolalpha hace que cout muestre true/false en lugar de 1/0.
    cout << boolalpha;
    cout << x << " == " << y << " → " << (x == y) << "\n";
    cout << x << " != " << y << " → " << (x != y) << "\n";
    cout << x << " <  " << y << " → " << (x  < y) << "\n";
    cout << x << " >  " << y << " → " << (x  > y) << "\n";
    cout << x << " <= " << y << " → " << (x <= y) << "\n";
    cout << x << " >= " << y << " → " << (x >= y) << "\n";

    // -------------------------------------------------------------------------
    // 4. Operadores logicos
    // -------------------------------------------------------------------------
    cout << "\n=== LÓGICOS ===\n";

    bool p = true, q = false;
    cout << "p=" << p << ", q=" << q << "\n";
    cout << "p && q → " << (p && q) << "\n";  // AND: ambos deben ser true
    cout << "p || q → " << (p || q) << "\n";  // OR: basta uno
    cout << "!p     → " << (!p)     << "\n";  // NOT: invierte

    // El cortocircuito evita evaluar la segunda parte si no hace falta.
    int divisor = 0;
    // Si divisor == 0, la segunda condicion no se evalua.
    bool seguro = (divisor != 0) && (100 / divisor > 5);
    cout << "Cortocircuito &&: " << seguro << " (sin crash)\n";

    // -------------------------------------------------------------------------
    // 5. Operador ternario
    // -------------------------------------------------------------------------
    cout << "\n=== TERNARIO ===\n";

    int edad = 20;
    // El ternario devuelve un valor segun la condicion.
    string estado = (edad >= 18) ? "mayor de edad" : "menor de edad";
    cout << "Edad " << edad << ": " << estado << "\n";

    int m = 7, k = 3;
    int maximo = (m > k) ? m : k;
    cout << "Máximo de " << m << " y " << k << ": " << maximo << "\n";

    // -------------------------------------------------------------------------
    // 6. Operadores propios de C++: new, delete, ->
    // -------------------------------------------------------------------------
    cout << "\n=== NEW, DELETE, -> ===\n";

    // new reserva memoria en el heap y devuelve un puntero.
    int* numPtr = new int(42);
    cout << "Valor en heap (new): " << *numPtr << "\n";

    // delete libera la memoria reservada con new.
    delete numPtr;
    numPtr = nullptr;  // Evita dejar un puntero colgante

    // new con clase y operador ->
    Punto* pt = new Punto(3.5, 7.2);
    cout << "Usando ->: ";
    pt->mostrar();                      // -> accede al miembro del objeto apuntado
    cout << "Coordenada x: " << pt->x  << "\n";

    delete pt;
    pt = nullptr;

    // -------------------------------------------------------------------------
    // 7. Operador de resolucion de alcance ::
    // -------------------------------------------------------------------------
    cout << "\n=== RESOLUCIÓN DE ALCANCE (::) ===\n";

    // std:: es un namespace; :: accede al identificador dentro de el.
    cout << "El operador :: ya se usa en cada std::cout y std::string\n";

    cout << "\n=== IDEAS CLAVE ===\n";
    cout << "Una expresion puede calcular, comparar o acceder a memoria.\n";
    cout << "La division entera y la flotante no son lo mismo.\n";
    cout << "new y delete implican responsabilidad sobre memoria.\n";

    return 0;
}
