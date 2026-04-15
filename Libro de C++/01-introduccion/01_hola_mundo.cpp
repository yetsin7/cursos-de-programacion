/**
 * Capítulo 01 — Introducción a C++
 * Archivo: 01_hola_mundo.cpp
 *
 * Demuestra los elementos básicos de un programa C++:
 *   - Directiva #include para incluir cabeceras
 *   - El namespace std y cómo usarlo
 *   - cout para mostrar texto en consola
 *   - cin para leer datos del usuario
 *   - endl y "\n" para saltos de línea
 *   - Comentarios de línea (//) y de bloque (/ * * /)
 *
 * Compilar: g++ -std=c++17 -o hola_mundo 01_hola_mundo.cpp
 */

#include <iostream>  // Necesario para cout, cin, endl
#include <string>    // Necesario para std::string

int main() {
    // -------------------------------------------------------------------------
    // 1. Salida básica con cout
    // -------------------------------------------------------------------------

    // std::cout es el flujo de salida estándar (consola)
    // El operador << inserta datos en el flujo
    std::cout << "¡Hola, mundo!" << std::endl;

    // endl inserta un salto de línea Y vacía el buffer del flujo
    // "\n" solo inserta el salto (más rápido en bucles)
    std::cout << "Primera línea\n";
    std::cout << "Segunda línea" << std::endl;

    // Se puede encadenar múltiples << en una sola instrucción
    int edad = 25;
    double pi = 3.14159;
    std::cout << "Edad: " << edad << ", Pi: " << pi << "\n";

    // -------------------------------------------------------------------------
    // 2. Entrada con cin
    // -------------------------------------------------------------------------

    std::string nombre;

    // cout sin endl para que el cursor quede en la misma línea
    std::cout << "\nIngresa tu nombre: ";

    // cin lee del teclado hasta el primer espacio en blanco
    std::cin >> nombre;

    // Saludo personalizado usando el nombre leído
    std::cout << "¡Hola, " << nombre << "! Bienvenido a C++.\n";

    // -------------------------------------------------------------------------
    // 3. Leer una línea completa (con espacios) usando getline
    // -------------------------------------------------------------------------

    // Es necesario limpiar el buffer de entrada antes de usar getline
    // porque cin >> deja el '\n' pendiente en el buffer
    std::cin.ignore();  // Descarta el '\n' que quedó en el buffer

    std::string frase;
    std::cout << "Escribe una frase completa: ";

    // getline lee toda la línea, incluyendo espacios
    std::getline(std::cin, frase);

    std::cout << "Escribiste: \"" << frase << "\"\n";

    // -------------------------------------------------------------------------
    // 4. Usando 'using namespace std' (alternativa común)
    // -------------------------------------------------------------------------

    // Con esta declaración, se puede omitir el prefijo std::
    // (solo se recomienda en archivos .cpp pequeños, nunca en cabeceras)
    using namespace std;

    int numero;
    cout << "\nIngresa un número entero: ";
    cin >> numero;
    cout << "El doble de " << numero << " es " << (numero * 2) << endl;

    // -------------------------------------------------------------------------
    // 5. Comentarios en C++
    // -------------------------------------------------------------------------

    // Este es un comentario de línea (solo aplica a esta línea)

    /*
     * Este es un comentario de bloque.
     * Puede abarcar múltiples líneas.
     * Se usa comúnmente para documentar funciones y clases.
     */

    cout << "\nPrograma finalizado correctamente.\n";

    // main() devuelve 0 para indicar que el programa terminó sin errores
    return 0;
}
