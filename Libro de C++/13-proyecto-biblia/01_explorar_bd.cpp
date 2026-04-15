/**
 * Capítulo 13 — Proyecto: Explorador de la Biblia con SQLite3
 * Archivo: 01_explorar_bd.cpp
 *
 * Aplica los conceptos del libro en un proyecto real:
 *   - Clase EnvolturaBD con RAII (abre/cierra la BD automáticamente)
 *   - Consultas con parámetros enlazados (bind) para evitar SQL injection
 *   - Manejo de errores con excepciones personalizadas
 *   - Smart pointers y move semantics
 *   - STL: vector, string, optional
 *
 * Base de datos: ../../datos/biblia_rv60.sqlite3
 *
 * Compilar:
 *   Linux/macOS: g++ -std=c++17 -o explorar 01_explorar_bd.cpp -lsqlite3
 *   Windows:     g++ -std=c++17 -o explorar.exe 01_explorar_bd.cpp sqlite3.c
 */

#include <iostream>
#include <string>
#include <vector>
#include <stdexcept>
#include <optional>
#include <sqlite3.h>

// -------------------------------------------------------------------------
// Ruta de la base de datos (relativa a esta carpeta)
// -------------------------------------------------------------------------
const std::string RUTA_BD = "../../datos/biblia_rv60.sqlite3";

// -------------------------------------------------------------------------
// Excepción personalizada para errores de base de datos
// -------------------------------------------------------------------------

/**
 * ErrorBD — Se lanza cuando ocurre un error al interactuar con SQLite.
 */
class ErrorBD : public std::runtime_error {
public:
    explicit ErrorBD(const std::string& msg)
        : std::runtime_error("[ErrorBD] " + msg) {}
};

// -------------------------------------------------------------------------
// Estructura para un versículo
// -------------------------------------------------------------------------

/**
 * Versiculo — Representa un versículo de la Biblia.
 */
struct Versiculo {
    std::string libro;
    int         capitulo;
    int         numero;
    std::string texto;
};

// -------------------------------------------------------------------------
// Clase EnvolturaBD — Encapsula la conexión a SQLite con RAII
// -------------------------------------------------------------------------

/**
 * EnvolturaBD — Gestiona el ciclo de vida de una conexión SQLite3.
 * Sigue el patrón RAII: abre en el constructor, cierra en el destructor.
 * No es copiable (unique ownership sobre la conexión).
 */
class EnvolturaBD {
private:
    sqlite3* db;          // Handle nativo de SQLite
    std::string rutaBD;   // Ruta del archivo de base de datos

public:
    /**
     * Abre la base de datos en la ruta indicada.
     * @param ruta Ruta al archivo .sqlite3
     * @throws ErrorBD si no se puede abrir
     */
    explicit EnvolturaBD(const std::string& ruta) : db(nullptr), rutaBD(ruta) {
        int resultado = sqlite3_open(ruta.c_str(), &db);
        if (resultado != SQLITE_OK) {
            std::string error = sqlite3_errmsg(db);
            sqlite3_close(db);
            db = nullptr;
            throw ErrorBD("No se pudo abrir '" + ruta + "': " + error);
        }
        std::cout << "Conexión establecida con: " << ruta << "\n";
    }

    // Destructor: cierra la conexión automáticamente (RAII)
    ~EnvolturaBD() {
        if (db) {
            sqlite3_close(db);
            std::cout << "Conexión cerrada.\n";
        }
    }

    // No permitir copia (la conexión tiene dueño único)
    EnvolturaBD(const EnvolturaBD&)            = delete;
    EnvolturaBD& operator=(const EnvolturaBD&) = delete;

    // Permitir movimiento
    EnvolturaBD(EnvolturaBD&& otro) noexcept : db(otro.db), rutaBD(std::move(otro.rutaBD)) {
        otro.db = nullptr;
    }

    // -------------------------------------------------------------------------
    // Métodos de consulta
    // -------------------------------------------------------------------------

    /**
     * Devuelve la lista de todos los libros de la Biblia.
     * @return Vector de pares (id, nombre)
     */
    std::vector<std::pair<int, std::string>> obtenerLibros() {
        std::vector<std::pair<int, std::string>> libros;

        const char* sql = "SELECT id, name FROM books ORDER BY id;";
        sqlite3_stmt* stmt = nullptr;

        if (sqlite3_prepare_v2(db, sql, -1, &stmt, nullptr) != SQLITE_OK) {
            throw ErrorBD("Error preparando consulta de libros: " +
                          std::string(sqlite3_errmsg(db)));
        }

        // Iterar sobre las filas del resultado
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            int         id     = sqlite3_column_int(stmt, 0);
            const char* nombre = reinterpret_cast<const char*>(
                                     sqlite3_column_text(stmt, 1));
            libros.emplace_back(id, nombre ? nombre : "");
        }

        sqlite3_finalize(stmt);
        return libros;
    }

    /**
     * Obtiene todos los versículos de un capítulo dado.
     * @param nombreLibro Nombre del libro (ej. "Génesis")
     * @param capitulo    Número de capítulo
     * @return            Vector de versículos
     */
    std::vector<Versiculo> obtenerCapitulo(const std::string& nombreLibro,
                                            int capitulo) {
        std::vector<Versiculo> versiculos;

        // Consulta parametrizada (? son los parámetros que se enlazan)
        const char* sql =
            "SELECT b.name, v.chapter, v.verse, v.text "
            "FROM verses v "
            "JOIN books b ON b.id = v.book_id "
            "WHERE b.name = ? AND v.chapter = ? "
            "ORDER BY v.verse;";

        sqlite3_stmt* stmt = nullptr;
        if (sqlite3_prepare_v2(db, sql, -1, &stmt, nullptr) != SQLITE_OK) {
            throw ErrorBD("Error preparando consulta de capítulo: " +
                          std::string(sqlite3_errmsg(db)));
        }

        // Enlazar parámetros (evita SQL injection)
        sqlite3_bind_text(stmt, 1, nombreLibro.c_str(), -1, SQLITE_STATIC);
        sqlite3_bind_int (stmt, 2, capitulo);

        while (sqlite3_step(stmt) == SQLITE_ROW) {
            Versiculo v;
            v.libro    = reinterpret_cast<const char*>(sqlite3_column_text(stmt, 0));
            v.capitulo = sqlite3_column_int(stmt, 1);
            v.numero   = sqlite3_column_int(stmt, 2);
            v.texto    = reinterpret_cast<const char*>(sqlite3_column_text(stmt, 3));
            versiculos.push_back(v);
        }

        sqlite3_finalize(stmt);
        return versiculos;
    }

    /**
     * Busca versículos que contengan una palabra o frase.
     * @param busqueda Texto a buscar (se usa con LIKE)
     * @param limite   Número máximo de resultados
     * @return         Vector de versículos encontrados
     */
    std::vector<Versiculo> buscarTexto(const std::string& busqueda, int limite = 10) {
        std::vector<Versiculo> resultados;

        const char* sql =
            "SELECT b.name, v.chapter, v.verse, v.text "
            "FROM verses v "
            "JOIN books b ON b.id = v.book_id "
            "WHERE v.text LIKE ? "
            "LIMIT ?;";

        sqlite3_stmt* stmt = nullptr;
        if (sqlite3_prepare_v2(db, sql, -1, &stmt, nullptr) != SQLITE_OK) {
            throw ErrorBD("Error preparando búsqueda de texto");
        }

        // El patrón LIKE usa % como comodín (cualquier texto)
        std::string patron = "%" + busqueda + "%";
        sqlite3_bind_text(stmt, 1, patron.c_str(), -1, SQLITE_TRANSIENT);
        sqlite3_bind_int (stmt, 2, limite);

        while (sqlite3_step(stmt) == SQLITE_ROW) {
            Versiculo v;
            v.libro    = reinterpret_cast<const char*>(sqlite3_column_text(stmt, 0));
            v.capitulo = sqlite3_column_int(stmt, 1);
            v.numero   = sqlite3_column_int(stmt, 2);
            v.texto    = reinterpret_cast<const char*>(sqlite3_column_text(stmt, 3));
            resultados.push_back(v);
        }

        sqlite3_finalize(stmt);
        return resultados;
    }

    /**
     * Cuenta el total de versículos en la base de datos.
     * @return Número total de versículos
     */
    int contarVersiculos() {
        const char* sql = "SELECT COUNT(*) FROM verses;";
        sqlite3_stmt* stmt = nullptr;
        sqlite3_prepare_v2(db, sql, -1, &stmt, nullptr);
        int total = 0;
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            total = sqlite3_column_int(stmt, 0);
        }
        sqlite3_finalize(stmt);
        return total;
    }
};

int main() {
    using namespace std;

    try {
        // Abrir la base de datos (RAII: se cerrará al salir del scope o por excepción)
        EnvolturaBD bd(RUTA_BD);

        // -------------------------------------------------------------------
        // 1. Información general
        // -------------------------------------------------------------------
        cout << "\n=== INFORMACIÓN GENERAL ===\n";
        cout << "Total de versículos: " << bd.contarVersiculos() << "\n";

        // -------------------------------------------------------------------
        // 2. Listar los primeros 10 libros
        // -------------------------------------------------------------------
        cout << "\n=== PRIMEROS 10 LIBROS ===\n";
        auto libros = bd.obtenerLibros();
        int mostrar = min((int)libros.size(), 10);
        for (int i = 0; i < mostrar; i++) {
            cout << "  " << libros[i].first << ". " << libros[i].second << "\n";
        }
        cout << "... (" << libros.size() << " libros en total)\n";

        // -------------------------------------------------------------------
        // 3. Mostrar Génesis capítulo 1 (primeros 5 versículos)
        // -------------------------------------------------------------------
        cout << "\n=== GÉNESIS 1 (primeros 5 versículos) ===\n";
        auto genesis = bd.obtenerCapitulo("Génesis", 1);
        for (int i = 0; i < min((int)genesis.size(), 5); i++) {
            const auto& v = genesis[i];
            cout << v.libro << " " << v.capitulo << ":" << v.numero
                 << " — " << v.texto << "\n\n";
        }

        // -------------------------------------------------------------------
        // 4. Buscar versículos con la palabra "amor"
        // -------------------------------------------------------------------
        cout << "\n=== BÚSQUEDA: 'amor' (top 5) ===\n";
        auto resultados = bd.buscarTexto("amor", 5);
        if (resultados.empty()) {
            cout << "No se encontraron resultados.\n";
        } else {
            for (const auto& v : resultados) {
                cout << v.libro << " " << v.capitulo << ":" << v.numero << "\n";
                cout << "  " << v.texto << "\n\n";
            }
        }

    } catch (const ErrorBD& e) {
        cerr << "Error de base de datos: " << e.what() << "\n";
        cerr << "Verifica que el archivo exista en: " << RUTA_BD << "\n";
        return 1;
    } catch (const exception& e) {
        cerr << "Error inesperado: " << e.what() << "\n";
        return 1;
    }

    return 0;
}
