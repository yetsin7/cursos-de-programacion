/**
 * Capitulo 01 — Introduccion a C++
 * Archivo: 01_hola_mundo.cpp
 *
 * Este archivo introduce la forma basica de un programa C++ y relaciona el
 * codigo con lo que ocurre en la maquina:
 *   - el compilador traduce el codigo fuente;
 *   - el sistema operativo carga el ejecutable;
 *   - main() se convierte en el punto de inicio;
 *   - cout y cin conectan el programa con la consola.
 *
 * Compilar: g++ -std=c++17 -Wall -Wextra -o hola_mundo 01_hola_mundo.cpp
 */

#include <iostream>  // Permite usar cout, cin y endl
#include <string>    // Permite usar std::string

int main() {
    // -------------------------------------------------------------------------
    // 1. Salida básica con cout
    // -------------------------------------------------------------------------

    // std::cout representa la salida estandar.
    // El operador << envia datos a ese flujo.
    std::cout << "¡Hola, mundo!" << std::endl;

    // endl inserta salto de linea y fuerza vaciado del buffer.
    // "\n" solo inserta el salto y suele ser mas eficiente.
    std::cout << "Primera línea\n";
    std::cout << "Segunda línea" << std::endl;

    // Se pueden encadenar varias salidas en una sola instruccion.
    int edad = 25;
    double pi = 3.14159;
    std::cout << "Edad: " << edad << ", Pi: " << pi << "\n";

    // -------------------------------------------------------------------------
    // 2. Entrada con cin
    // -------------------------------------------------------------------------

    std::string nombre;

    // Dejamos el cursor en la misma linea para que el usuario escriba ahi.
    std::cout << "\nIngresa tu nombre: ";

    // cin lee desde el teclado hasta encontrar un espacio o salto de linea.
    std::cin >> nombre;

    // Saludo personalizado usando el nombre leído
    std::cout << "¡Hola, " << nombre << "! Bienvenido a C++.\n";

    // -------------------------------------------------------------------------
    // 3. Leer una línea completa (con espacios) usando getline
    // -------------------------------------------------------------------------

    // Limpiamos el buffer antes de getline porque cin >> deja pendiente
    // el salto de linea de la entrada anterior.
    std::cin.ignore();

    std::string frase;
    std::cout << "Escribe una frase completa: ";

    // getline lee toda la línea, incluyendo espacios
    std::getline(std::cin, frase);

    std::cout << "Escribiste: \"" << frase << "\"\n";

    // -------------------------------------------------------------------------
    // 4. Usando 'using namespace std' (alternativa común)
    // -------------------------------------------------------------------------

    // Esta declaracion permite omitir std:: en un alcance pequeno.
    // Conviene evitarla en cabeceras para no contaminar nombres globales.
    using namespace std;

    int numero;
    cout << "\nIngresa un número entero: ";
    cin >> numero;
    cout << "El doble de " << numero << " es " << (numero * 2) << endl;

    // -------------------------------------------------------------------------
    // 5. Comentarios en C++
    // -------------------------------------------------------------------------

    // Este es un comentario de linea.

    /*
     * Este es un comentario de bloque.
     * Puede abarcar varias lineas.
     * Suele usarse para documentacion mas amplia.
     */

    cout << "\nPrograma finalizado correctamente.\n";

    // Devolver 0 comunica al sistema operativo que todo termino bien.
    return 0;
}
