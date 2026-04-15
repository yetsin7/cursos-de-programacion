/**
 * Capítulo 11 — Archivos e I/O
 * Archivo: 01_archivos.cpp
 *
 * Demuestra:
 *   - Escribir en un archivo de texto con ofstream
 *   - Leer línea por línea con ifstream y getline
 *   - Agregar contenido sin sobrescribir (ios::app)
 *   - Leer y escribir con fstream
 *   - std::stringstream para procesamiento de strings en memoria
 *   - Manejo de errores al abrir archivos
 *
 * Compilar: g++ -std=c++17 -o archivos 01_archivos.cpp
 */

#include <iostream>
#include <fstream>    // ifstream, ofstream, fstream
#include <sstream>    // stringstream
#include <string>
#include <vector>
#include <stdexcept>

// Nombre del archivo de prueba que se crea y lee en este programa
const std::string ARCHIVO_PRUEBA = "notas_estudiantes.txt";

// -------------------------------------------------------------------------
// Funciones de escritura
// -------------------------------------------------------------------------

/**
 * Crea un archivo de texto con datos de ejemplo sobre estudiantes.
 * Sobrescribe el archivo si ya existe.
 * @param ruta Ruta del archivo a crear
 * @throws std::runtime_error si no se puede crear el archivo
 */
void crearArchivoEjemplo(const std::string& ruta) {
    std::ofstream archivo(ruta);  // Abre para escritura (sobrescribe)

    if (!archivo.is_open()) {
        throw std::runtime_error("No se pudo crear el archivo: " + ruta);
    }

    // Escribir encabezado y datos de estudiantes
    archivo << "# Notas de Estudiantes — Curso C++\n";
    archivo << "# Formato: Nombre,Nota1,Nota2,Nota3\n";
    archivo << "Ana García,90,85,92\n";
    archivo << "Carlos López,75,80,78\n";
    archivo << "Beatriz Ruiz,95,98,91\n";
    archivo << "David Soto,60,65,70\n";
    archivo << "Elena Martínez,88,82,79\n";

    std::cout << "Archivo creado: " << ruta << "\n";
    // El archivo se cierra automáticamente al destruirse 'archivo'
}

/**
 * Agrega una nueva entrada al archivo existente sin borrar el contenido previo.
 * @param ruta  Ruta del archivo
 * @param linea Línea a agregar
 */
void agregarLinea(const std::string& ruta, const std::string& linea) {
    // ios::app — modo append: escribe al final del archivo
    std::ofstream archivo(ruta, std::ios::app);

    if (!archivo.is_open()) {
        throw std::runtime_error("No se pudo abrir para append: " + ruta);
    }

    archivo << linea << "\n";
    std::cout << "Línea agregada: " << linea << "\n";
}

// -------------------------------------------------------------------------
// Funciones de lectura
// -------------------------------------------------------------------------

/**
 * Lee el archivo completo línea por línea y muestra su contenido.
 * Las líneas que empiezan con '#' se muestran como comentarios.
 * @param ruta Ruta del archivo a leer
 */
void leerArchivo(const std::string& ruta) {
    std::ifstream archivo(ruta);  // Abre para lectura

    if (!archivo.is_open()) {
        throw std::runtime_error("No se pudo abrir para lectura: " + ruta);
    }

    std::string linea;
    int numeroLinea = 0;

    std::cout << "\n--- Contenido de " << ruta << " ---\n";
    while (std::getline(archivo, linea)) {
        numeroLinea++;
        // Identificar comentarios (líneas que empiezan con #)
        if (!linea.empty() && linea[0] == '#') {
            std::cout << "[comentario] " << linea << "\n";
        } else {
            std::cout << "  Línea " << numeroLinea << ": " << linea << "\n";
        }
    }
    std::cout << "--- Fin (" << numeroLinea << " líneas) ---\n";
}

// -------------------------------------------------------------------------
// Procesamiento con stringstream
// -------------------------------------------------------------------------

/**
 * Estructura que almacena los datos de un estudiante.
 */
struct Estudiante {
    std::string nombre;
    double nota1, nota2, nota3;

    // Calcula el promedio de las tres notas
    double promedio() const { return (nota1 + nota2 + nota3) / 3.0; }
};

/**
 * Parsea una línea CSV de estudiante usando stringstream.
 * Formato esperado: "Nombre,Nota1,Nota2,Nota3"
 * @param linea Línea CSV a parsear
 * @return Estructura Estudiante con los datos extraídos
 */
Estudiante parsearLinea(const std::string& linea) {
    std::stringstream ss(linea);
    std::string token;
    Estudiante est;

    // Extraer el nombre (antes de la primera coma)
    std::getline(ss, est.nombre, ',');

    // Extraer las tres notas numéricas
    std::getline(ss, token, ','); est.nota1 = std::stod(token);
    std::getline(ss, token, ','); est.nota2 = std::stod(token);
    std::getline(ss, token);      est.nota3 = std::stod(token);

    return est;
}

/**
 * Lee el archivo de estudiantes, parsea cada línea y calcula promedios.
 * Ignora las líneas que empiezan con '#'.
 * @param ruta Ruta del archivo a procesar
 */
void procesarEstudiantes(const std::string& ruta) {
    std::ifstream archivo(ruta);
    if (!archivo.is_open()) {
        throw std::runtime_error("No se pudo abrir: " + ruta);
    }

    std::cout << "\n=== PROMEDIOS DE ESTUDIANTES ===\n";
    std::string linea;
    double totalPromedio = 0.0;
    int    count         = 0;

    while (std::getline(archivo, linea)) {
        // Saltar líneas vacías o comentarios
        if (linea.empty() || linea[0] == '#') continue;

        Estudiante est = parsearLinea(linea);
        double prom    = est.promedio();
        totalPromedio += prom;
        count++;

        std::string estado = (prom >= 70) ? "APROBADO" : "REPROBADO";
        std::cout << "  " << est.nombre
                  << " → Promedio: " << prom
                  << " [" << estado << "]\n";
    }

    if (count > 0) {
        std::cout << "Promedio de grupo: " << (totalPromedio / count) << "\n";
    }
}

// -------------------------------------------------------------------------
// Demostración de stringstream
// -------------------------------------------------------------------------

/**
 * Muestra el uso de stringstream para construir y parsear strings.
 */
void demostrarStringStream() {
    std::cout << "\n=== STRINGSTREAM ===\n";

    // Construir un string complejo como si fuera un flujo
    std::stringstream constructor;
    constructor << "Reporte " << 2024
                << " — Items: " << 42
                << " — Valor: " << 3.14;
    std::string reporteTexto = constructor.str();
    std::cout << "Construido: " << reporteTexto << "\n";

    // Parsear valores de un string
    std::stringstream parser("100 3.14 hola 42");
    int    n;
    double d;
    std::string s;
    int    n2;

    parser >> n >> d >> s >> n2;
    std::cout << "Parseado: int=" << n
              << ", double=" << d
              << ", string=" << s
              << ", int2=" << n2 << "\n";

    // Convertir número a string (alternativa a std::to_string)
    std::stringstream conv;
    conv << std::fixed;          // Formato fijo (no científico)
    conv.precision(2);           // 2 decimales
    conv << 1234.5678;
    std::cout << "Número formateado: " << conv.str() << "\n";
}

int main() {
    try {
        // Crear archivo de ejemplo
        std::cout << "=== ESCRITURA ===\n";
        crearArchivoEjemplo(ARCHIVO_PRUEBA);

        // Agregar una línea extra sin borrar el contenido
        agregarLinea(ARCHIVO_PRUEBA, "Fernando Torres,72,68,75");

        // Leer y mostrar el archivo completo
        std::cout << "\n=== LECTURA LÍNEA POR LÍNEA ===\n";
        leerArchivo(ARCHIVO_PRUEBA);

        // Procesar y calcular promedios
        procesarEstudiantes(ARCHIVO_PRUEBA);

        // Stringstream en memoria
        demostrarStringStream();

    } catch (const std::runtime_error& e) {
        std::cerr << "Error de archivo: " << e.what() << "\n";
        return 1;
    }

    return 0;
}
