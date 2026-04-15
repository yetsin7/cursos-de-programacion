/**
 * Capítulo 04 — Control de Flujo
 * Archivo: 01_control_flujo.cpp
 *
 * Demuestra:
 *   - if / else if / else
 *   - switch con break y fall-through
 *   - Bucle for clásico
 *   - Bucle while y do-while
 *   - Range-for de C++11 sobre vector y string
 *   - break y continue dentro de bucles
 *
 * Compilar: g++ -std=c++17 -o control_flujo 01_control_flujo.cpp
 */

#include <iostream>
#include <string>
#include <vector>

int main() {
    using namespace std;

    // -------------------------------------------------------------------------
    // 1. if / else if / else
    // -------------------------------------------------------------------------
    cout << "=== IF / ELSE ===\n";

    int nota = 75;

    if (nota >= 90) {
        cout << "Calificación: Sobresaliente (A)\n";
    } else if (nota >= 80) {
        cout << "Calificación: Notable (B)\n";
    } else if (nota >= 70) {
        cout << "Calificación: Bien (C)\n";
    } else if (nota >= 60) {
        cout << "Calificación: Suficiente (D)\n";
    } else {
        cout << "Calificación: Insuficiente (F)\n";
    }

    // -------------------------------------------------------------------------
    // 2. switch
    // -------------------------------------------------------------------------
    cout << "\n=== SWITCH ===\n";

    int diaSemana = 3;

    switch (diaSemana) {
        case 1: cout << "Lunes\n";     break;
        case 2: cout << "Martes\n";    break;
        case 3: cout << "Miércoles\n"; break;
        case 4: cout << "Jueves\n";    break;
        case 5: cout << "Viernes\n";   break;
        case 6:
        case 7: cout << "Fin de semana\n"; break;  // Fall-through intencional
        default:
            cout << "Día inválido\n";
            break;
    }

    // switch con char
    char opcion = 'B';
    switch (opcion) {
        case 'A': cout << "Elegiste la opción A\n"; break;
        case 'B': cout << "Elegiste la opción B\n"; break;
        case 'C': cout << "Elegiste la opción C\n"; break;
        default:  cout << "Opción no reconocida\n"; break;
    }

    // -------------------------------------------------------------------------
    // 3. Bucle for clásico
    // -------------------------------------------------------------------------
    cout << "\n=== FOR CLÁSICO ===\n";

    // Contar del 1 al 5
    for (int i = 1; i <= 5; i++) {
        cout << "Iteración " << i << "\n";
    }

    // Tabla de multiplicar del 3
    cout << "\nTabla del 3:\n";
    for (int i = 1; i <= 10; i++) {
        cout << "3 x " << i << " = " << (3 * i) << "\n";
    }

    // -------------------------------------------------------------------------
    // 4. Bucle while
    // -------------------------------------------------------------------------
    cout << "\n=== WHILE ===\n";

    int contador = 10;
    while (contador > 0) {
        cout << contador << " ";
        contador -= 3;  // Resta 3 en cada iteración
    }
    cout << "\n";

    // -------------------------------------------------------------------------
    // 5. Bucle do-while (ejecuta al menos una vez)
    // -------------------------------------------------------------------------
    cout << "\n=== DO-WHILE ===\n";

    int intentos = 0;
    int clave    = 1234;
    int entrada;

    do {
        intentos++;
        cout << "Intento " << intentos << " — ingresa la clave (1234): ";
        // Para no requerir input real en el demo, simulamos la entrada
        entrada = (intentos < 3) ? 0000 : 1234;
        cout << entrada << "\n";  // Mostramos la "entrada simulada"
    } while (entrada != clave && intentos < 3);

    if (entrada == clave) {
        cout << "¡Clave correcta!\n";
    } else {
        cout << "Demasiados intentos fallidos.\n";
    }

    // -------------------------------------------------------------------------
    // 6. Range-for (C++11) — Iterar sobre colecciones
    // -------------------------------------------------------------------------
    cout << "\n=== RANGE-FOR (C++11) ===\n";

    // Sobre un initializer_list directamente
    cout << "Planetas: ";
    for (const string& planeta : {"Mercurio", "Venus", "Tierra", "Marte"}) {
        cout << planeta << " ";
    }
    cout << "\n";

    // Sobre un vector — por referencia constante (sin copiar)
    vector<int> fibonacci = {1, 1, 2, 3, 5, 8, 13, 21};
    cout << "Fibonacci: ";
    for (const auto& num : fibonacci) {
        cout << num << " ";
    }
    cout << "\n";

    // Modificar elementos con referencia no-constante
    vector<double> precios = {9.99, 14.50, 3.75};
    for (auto& precio : precios) {
        precio *= 1.16;  // Aplicar IVA del 16%
    }
    cout << "Precios con IVA: ";
    for (const auto& precio : precios) {
        cout << precio << " ";
    }
    cout << "\n";

    // Sobre un string carácter por carácter
    string mensaje = "Hola";
    cout << "Caracteres: ";
    for (char ch : mensaje) {
        cout << ch << "-";
    }
    cout << "\n";

    // -------------------------------------------------------------------------
    // 7. break y continue
    // -------------------------------------------------------------------------
    cout << "\n=== BREAK Y CONTINUE ===\n";

    // continue: salta la iteración actual
    cout << "Impares del 1 al 10: ";
    for (int i = 1; i <= 10; i++) {
        if (i % 2 == 0) continue;  // Si es par, salta
        cout << i << " ";
    }
    cout << "\n";

    // break: sale del bucle completamente
    cout << "Hasta encontrar el 5: ";
    for (int i = 0; i < 10; i++) {
        if (i == 5) break;         // Sale cuando i llega a 5
        cout << i << " ";
    }
    cout << "\n";

    return 0;
}
