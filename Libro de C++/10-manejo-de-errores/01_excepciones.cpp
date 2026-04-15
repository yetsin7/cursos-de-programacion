/**
 * Capítulo 10 — Manejo de Errores y Excepciones
 * Archivo: 01_excepciones.cpp
 *
 * Demuestra:
 *   - try / catch / throw básico
 *   - Jerarquía de excepciones estándar: std::exception, std::runtime_error,
 *     std::out_of_range, std::invalid_argument
 *   - Múltiples bloques catch (del más específico al más general)
 *   - Catch-all con ...
 *   - Excepciones personalizadas (herencia de std::runtime_error)
 *   - noexcept en funciones que no pueden lanzar
 *   - Re-lanzar una excepción con throw;
 *
 * Compilar: g++ -std=c++17 -o excepciones 01_excepciones.cpp
 */

#include <iostream>
#include <string>
#include <stdexcept>   // runtime_error, invalid_argument, out_of_range, etc.
#include <vector>

// -------------------------------------------------------------------------
// Excepciones personalizadas
// -------------------------------------------------------------------------

/**
 * ErrorValidacion — Se lanza cuando los datos de entrada son inválidos.
 * Hereda de std::invalid_argument para integrarse en la jerarquía estándar.
 */
class ErrorValidacion : public std::invalid_argument {
private:
    std::string campo;  // Campo que falló la validación

public:
    /**
     * Constructor que almacena el campo y el mensaje de error.
     * @param campoNombre Nombre del campo con error
     * @param mensaje     Descripción del error
     */
    ErrorValidacion(const std::string& campoNombre, const std::string& mensaje)
        : std::invalid_argument("Campo '" + campoNombre + "': " + mensaje)
        , campo(campoNombre)
    {}

    // Devuelve el nombre del campo que falló
    std::string getCampo() const { return campo; }
};

/**
 * ErrorCalculoMatematico — Se lanza en operaciones matemáticas inválidas.
 */
class ErrorCalculoMatematico : public std::runtime_error {
public:
    explicit ErrorCalculoMatematico(const std::string& operacion)
        : std::runtime_error("Operación inválida: " + operacion)
    {}
};

// -------------------------------------------------------------------------
// Funciones que lanzan excepciones
// -------------------------------------------------------------------------

/**
 * Divide dos números enteros. Lanza excepción si el divisor es cero.
 * @param a   Dividendo
 * @param b   Divisor
 * @return    Resultado de la división
 * @throws ErrorCalculoMatematico si b == 0
 */
double dividir(double a, double b) {
    if (b == 0.0) {
        throw ErrorCalculoMatematico("división por cero (" +
            std::to_string(a) + " / 0)");
    }
    return a / b;
}

/**
 * Valida y registra una edad. Lanza excepción si es inválida.
 * @param edad Edad a validar
 * @throws ErrorValidacion si la edad está fuera de rango
 */
void registrarEdad(int edad) {
    if (edad < 0 || edad > 150) {
        throw ErrorValidacion("edad",
            "debe estar entre 0 y 150 (recibido: " + std::to_string(edad) + ")");
    }
    std::cout << "Edad registrada correctamente: " << edad << "\n";
}

/**
 * Accede a un elemento de un vector con verificación de índice.
 * @param v      Vector de enteros
 * @param indice Índice a acceder
 * @return       Valor en la posición indicada
 * @throws std::out_of_range si el índice es inválido
 */
int obtenerElemento(const std::vector<int>& v, int indice) {
    return v.at(indice);  // at() lanza std::out_of_range si índice es inválido
}

/**
 * Función que no lanza excepciones (marcada noexcept).
 * El compilador puede optimizarla mejor.
 * @param a Primer número
 * @param b Segundo número
 * @return  Suma de los dos números
 */
int sumarSeguro(int a, int b) noexcept {
    return a + b;
}

/**
 * Función interna que lanza y luego re-lanza la excepción.
 * Muestra cómo propagar excepciones con información adicional.
 */
void procesarArchivo(const std::string& ruta) {
    try {
        if (ruta.empty()) {
            throw std::invalid_argument("La ruta del archivo no puede estar vacía");
        }
        std::cout << "Procesando: " << ruta << "\n";
    } catch (const std::invalid_argument& e) {
        std::cerr << "[procesarArchivo] Capturado: " << e.what() << "\n";
        throw;  // Re-lanza la misma excepción al caller
    }
}

int main() {
    using namespace std;

    // -------------------------------------------------------------------------
    // 1. try/catch básico con excepciones estándar
    // -------------------------------------------------------------------------
    cout << "=== DIVISIÓN CON MANEJO DE ERRORES ===\n";

    double resultados[] = {10.0, 5.0, 0.0};  // El divisor 0 causará excepción

    for (double divisor : resultados) {
        try {
            double res = dividir(20.0, divisor);
            cout << "20 / " << divisor << " = " << res << "\n";
        } catch (const ErrorCalculoMatematico& e) {
            cerr << "Error matemático: " << e.what() << "\n";
        }
    }

    // -------------------------------------------------------------------------
    // 2. Excepción personalizada con campo
    // -------------------------------------------------------------------------
    cout << "\n=== VALIDACIÓN CON EXCEPCIÓN PERSONALIZADA ===\n";

    int edades[] = {25, -5, 200, 40};
    for (int e : edades) {
        try {
            registrarEdad(e);
        } catch (const ErrorValidacion& ev) {
            cerr << "Error de validación — Campo: " << ev.getCampo()
                 << " — " << ev.what() << "\n";
        }
    }

    // -------------------------------------------------------------------------
    // 3. Múltiples catch (del más específico al más general)
    // -------------------------------------------------------------------------
    cout << "\n=== MÚLTIPLES CATCH ===\n";

    vector<int> datos = {10, 20, 30};

    int indices[] = {1, 5, -1};  // 5 y -1 son inválidos
    for (int idx : indices) {
        try {
            int val = obtenerElemento(datos, idx);
            cout << "datos[" << idx << "] = " << val << "\n";
        } catch (const std::out_of_range& e) {
            // Captura específica para índice fuera de rango
            cerr << "Índice fuera de rango (" << idx << "): " << e.what() << "\n";
        } catch (const std::exception& e) {
            // Captura genérica para cualquier excepción estándar
            cerr << "Excepción estándar: " << e.what() << "\n";
        } catch (...) {
            // Catch-all: captura cualquier tipo de excepción
            cerr << "Excepción desconocida al acceder índice " << idx << "\n";
        }
    }

    // -------------------------------------------------------------------------
    // 4. noexcept en acción
    // -------------------------------------------------------------------------
    cout << "\n=== NOEXCEPT ===\n";

    cout << "sumarSeguro(15, 27) = " << sumarSeguro(15, 27) << "\n";
    cout << "¿sumarSeguro lanza excepciones? "
         << (noexcept(sumarSeguro(1, 2)) ? "No" : "Sí") << "\n";

    // -------------------------------------------------------------------------
    // 5. Re-lanzar excepción
    // -------------------------------------------------------------------------
    cout << "\n=== RE-LANZAR EXCEPCIÓN ===\n";

    try {
        procesarArchivo("");  // Lanzará y re-lanzará
    } catch (const std::invalid_argument& e) {
        cerr << "[main] Re-capturado desde procesarArchivo: " << e.what() << "\n";
    }

    try {
        procesarArchivo("datos/biblia.sqlite3");  // OK
    } catch (const exception& e) {
        cerr << "Error inesperado: " << e.what() << "\n";
    }

    cout << "\nPrograma completado.\n";
    return 0;
}
