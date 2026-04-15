/**
 * Capítulo 06 — POO: Clases y Objetos
 * Archivo: 01_clases.cpp
 *
 * Demuestra:
 *   - Definición de clase con atributos y métodos
 *   - Encapsulación: public, private, protected
 *   - Constructor por defecto y con parámetros
 *   - Lista de inicialización en constructores
 *   - Destructor
 *   - Getters y setters con validación
 *   - Puntero 'this'
 *   - Métodos const
 *   - Sobrecarga del operador <<
 *
 * Compilar: g++ -std=c++17 -o clases 01_clases.cpp
 */

#include <iostream>
#include <string>

/**
 * Clase Persona — Representa a una persona con nombre, edad y ocupación.
 * Demuestra los conceptos fundamentales de POO en C++:
 * encapsulación, constructores, destructor y métodos.
 */
class Persona {
private:
    // Atributos privados: solo accesibles desde dentro de la clase
    std::string nombre;
    int         edad;
    std::string ocupacion;

    // Contador estático compartido por todos los objetos de la clase
    static int totalPersonas;

public:
    // ---------------------------------------------------------------------
    // Constructores
    // ---------------------------------------------------------------------

    /**
     * Constructor por defecto: crea una persona sin datos.
     * La lista de inicialización (:) es más eficiente que asignar en el cuerpo.
     */
    Persona() : nombre("Desconocido"), edad(0), ocupacion("Sin especificar") {
        totalPersonas++;
        std::cout << "[Persona] Creado objeto por defecto. Total: "
                  << totalPersonas << "\n";
    }

    /**
     * Constructor con parámetros: inicializa todos los atributos.
     * @param n   Nombre de la persona
     * @param e   Edad (debe ser >= 0)
     * @param ocp Ocupación o profesión
     */
    Persona(const std::string& n, int e, const std::string& ocp = "No indicada")
        : nombre(n), edad(e >= 0 ? e : 0), ocupacion(ocp)
    {
        totalPersonas++;
        std::cout << "[Persona] Creado: " << nombre
                  << ". Total: " << totalPersonas << "\n";
    }

    // ---------------------------------------------------------------------
    // Destructor
    // ---------------------------------------------------------------------

    /**
     * Destructor: se llama automáticamente cuando el objeto es destruido.
     * Aquí solo muestra un mensaje; en casos reales liberaría recursos.
     */
    ~Persona() {
        totalPersonas--;
        std::cout << "[Persona] Destruido: " << nombre
                  << ". Quedan: " << totalPersonas << "\n";
    }

    // ---------------------------------------------------------------------
    // Getters (acceso de lectura a atributos privados)
    // const garantiza que el método no modifica el objeto
    // ---------------------------------------------------------------------

    std::string getNombre()    const { return nombre;    }
    int         getEdad()      const { return edad;      }
    std::string getOcupacion() const { return ocupacion; }

    // Método estático: accede al contador compartido
    static int getTotalPersonas() { return totalPersonas; }

    // ---------------------------------------------------------------------
    // Setters (acceso de escritura con validación)
    // ---------------------------------------------------------------------

    /**
     * Establece el nombre de la persona.
     * @param n Nuevo nombre (no puede estar vacío)
     */
    void setNombre(const std::string& n) {
        if (!n.empty()) {
            nombre = n;
        } else {
            std::cerr << "Error: el nombre no puede estar vacío.\n";
        }
    }

    /**
     * Establece la edad con validación de rango.
     * @param e Nueva edad (debe estar entre 0 y 150)
     */
    void setEdad(int e) {
        if (e >= 0 && e <= 150) {
            edad = e;
        } else {
            std::cerr << "Error: edad inválida (" << e << ").\n";
        }
    }

    /**
     * Establece la ocupación de la persona.
     * @param ocp Nueva ocupación
     */
    void setOcupacion(const std::string& ocp) {
        ocupacion = ocp;
    }

    // ---------------------------------------------------------------------
    // Métodos de comportamiento
    // ---------------------------------------------------------------------

    /**
     * Saluda mostrando los datos básicos de la persona.
     * Método const: no modifica el estado del objeto.
     */
    void saludar() const {
        std::cout << "Hola, soy " << nombre
                  << ", tengo " << edad << " años"
                  << " y soy " << ocupacion << ".\n";
    }

    /**
     * Verifica si la persona es mayor de edad.
     * @return true si edad >= 18
     */
    bool esMayorDeEdad() const {
        return edad >= 18;
    }

    /**
     * Cumple un año: incrementa la edad en 1.
     */
    void cumplirAnio() {
        edad++;
        std::cout << nombre << " cumplió un año. Ahora tiene " << edad << ".\n";
    }
};

// Definición del miembro estático (fuera de la clase)
int Persona::totalPersonas = 0;

// -------------------------------------------------------------------------
// Función auxiliar: muestra información completa de una persona
// -------------------------------------------------------------------------
void mostrarPersona(const Persona& p) {
    std::cout << "  Nombre:    " << p.getNombre()    << "\n"
              << "  Edad:      " << p.getEdad()      << "\n"
              << "  Ocupación: " << p.getOcupacion() << "\n"
              << "  Mayor edad: "
              << (p.esMayorDeEdad() ? "Sí" : "No") << "\n";
}

int main() {
    using namespace std;

    cout << "=== CLASES Y OBJETOS ===\n\n";

    // Crear objeto usando constructor por defecto
    Persona p1;
    mostrarPersona(p1);

    cout << "\n";

    // Crear objeto usando constructor con parámetros
    Persona p2("Ana Martínez", 30, "Ingeniera de Software");
    p2.saludar();

    cout << "\n";

    // Crear objeto con inicialización uniforme (C++11)
    Persona p3{"Carlos López", 16};
    mostrarPersona(p3);
    cout << "  ¿Mayor de edad? " << (p3.esMayorDeEdad() ? "Sí" : "No") << "\n";

    cout << "\n=== GETTERS Y SETTERS ===\n";

    Persona p4("Pedro", 25);
    p4.saludar();
    p4.setNombre("Pedro Sánchez");    // Actualizar nombre
    p4.setEdad(200);                  // Edad inválida → muestra error
    p4.setEdad(26);                   // Edad válida
    p4.setOcupacion("Médico");
    p4.saludar();

    cout << "\n=== MÉTODOS DE COMPORTAMIENTO ===\n";

    Persona p5("Lucía", 17, "Estudiante");
    p5.saludar();
    p5.cumplirAnio();
    cout << "¿Ahora es mayor de edad? "
         << (p5.esMayorDeEdad() ? "Sí" : "No") << "\n";

    cout << "\n=== CONTADOR ESTÁTICO ===\n";
    cout << "Total de personas activas: " << Persona::getTotalPersonas() << "\n";

    cout << "\n=== DESTRUCCIÓN DE OBJETOS (al salir de scope) ===\n";
    // Al terminar main(), todos los objetos locales son destruidos automáticamente

    return 0;
}
