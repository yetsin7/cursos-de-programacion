/**
 * Capítulo 07 — Herencia y Polimorfismo
 * Archivo: 01_herencia.cpp
 *
 * Demuestra:
 *   - Herencia pública: clase base Animal, derivadas Perro y Gato
 *   - Funciones virtuales y polimorfismo dinámico
 *   - override para sobreescritura explícita (C++11)
 *   - final para bloquear herencia adicional (C++11)
 *   - Clases abstractas con métodos puramente virtuales (= 0)
 *   - Destructor virtual (necesario para polimorfismo correcto)
 *   - Puntero de clase base apuntando a objetos derivados
 *
 * Compilar: g++ -std=c++17 -o herencia 01_herencia.cpp
 */

#include <iostream>
#include <string>
#include <vector>
#include <memory>  // Para unique_ptr

// -------------------------------------------------------------------------
// Clase base abstracta: Animal
// Tiene métodos virtuales puros → no se puede instanciar directamente
// -------------------------------------------------------------------------

/**
 * Animal — Clase base abstracta que define la interfaz común para todos
 * los animales. Contiene comportamientos virtuales que deben implementarse
 * en las clases derivadas.
 */
class Animal {
protected:
    std::string nombre;
    int         edad;

public:
    /**
     * Constructor de Animal.
     * @param n   Nombre del animal
     * @param e   Edad en años
     */
    Animal(const std::string& n, int e) : nombre(n), edad(e) {}

    // Destructor virtual: OBLIGATORIO cuando se usa polimorfismo con punteros
    // Sin esto, se llamaría solo el destructor base al hacer delete
    virtual ~Animal() {
        std::cout << "[~Animal] Destruyendo a " << nombre << "\n";
    }

    // Métodos puramente virtuales (= 0): obligan a las clases derivadas a implementarlos
    virtual void hacerSonido() const = 0;   // Cada animal suena diferente
    virtual std::string tipo() const = 0;   // Cada animal tiene su tipo

    // Método concreto: comportamiento común a todos los animales
    void respirar() const {
        std::cout << nombre << " respira.\n";
    }

    // Método virtual con implementación por defecto (puede sobreescribirse)
    virtual void presentarse() const {
        std::cout << "Soy " << nombre << " (" << tipo() << "), "
                  << "tengo " << edad << " años.\n";
    }

    // Getters
    std::string getNombre() const { return nombre; }
    int         getEdad()   const { return edad;   }
};

// -------------------------------------------------------------------------
// Clase derivada: Perro
// -------------------------------------------------------------------------

/**
 * Perro — Representa un perro. Hereda de Animal e implementa
 * los métodos virtuales. Agrega comportamiento propio: ladrar y raza.
 */
class Perro : public Animal {
private:
    std::string raza;

public:
    /**
     * Constructor del Perro.
     * @param n    Nombre del perro
     * @param e    Edad en años
     * @param r    Raza del perro
     */
    Perro(const std::string& n, int e, const std::string& r = "Mestizo")
        : Animal(n, e), raza(r) {}

    ~Perro() override {
        std::cout << "[~Perro] Destruyendo al perro " << nombre << "\n";
    }

    // Implementación obligatoria de métodos virtuales puros
    void hacerSonido() const override {
        std::cout << nombre << ": ¡Guau, guau!\n";
    }

    std::string tipo() const override { return "Perro"; }

    // Sobreescritura del método concreto (opcional)
    void presentarse() const override {
        Animal::presentarse();  // Llama al método de la clase base
        std::cout << "  Raza: " << raza << "\n";
    }

    // Método propio (solo existe en Perro)
    void buscarPelota() const {
        std::cout << nombre << " busca la pelota... ¡La encontró!\n";
    }
};

// -------------------------------------------------------------------------
// Clase derivada: Gato
// -------------------------------------------------------------------------

/**
 * Gato — Representa un gato. Hereda de Animal, implementa los métodos
 * virtuales puros y agrega comportamiento único: ronronear.
 */
class Gato : public Animal {
private:
    bool esIndoor;  // Si es gato de interior o exterior

public:
    Gato(const std::string& n, int e, bool interior = true)
        : Animal(n, e), esIndoor(interior) {}

    ~Gato() override {
        std::cout << "[~Gato] Destruyendo al gato " << nombre << "\n";
    }

    void hacerSonido() const override {
        std::cout << nombre << ": ¡Miau!\n";
    }

    std::string tipo() const override { return "Gato"; }

    void presentarse() const override {
        Animal::presentarse();
        std::cout << "  Tipo: " << (esIndoor ? "Interior" : "Exterior") << "\n";
    }

    // Método propio de Gato
    void ronronear() const {
        std::cout << nombre << " ronronea: prrrrrr...\n";
    }
};

// -------------------------------------------------------------------------
// Clase derivada: Pajaro — heredada de Animal, marcada final
// (Nadie puede heredar de Pajaro)
// -------------------------------------------------------------------------

/**
 * Pajaro — Clase derivada final. Ninguna otra clase puede heredar de ella.
 */
class Pajaro final : public Animal {
public:
    Pajaro(const std::string& n, int e) : Animal(n, e) {}

    void hacerSonido() const override {
        std::cout << nombre << ": ¡Pío, pío!\n";
    }

    std::string tipo() const override { return "Pájaro"; }

    void volar() const {
        std::cout << nombre << " vuela por los aires.\n";
    }
};

// -------------------------------------------------------------------------
// Función polimórfica: acepta cualquier animal a través de la clase base
// -------------------------------------------------------------------------

/**
 * Hace que el animal se presente y emita su sonido.
 * Funciona con cualquier objeto derivado de Animal (polimorfismo).
 * @param animal Referencia constante a la clase base
 */
void interactuarConAnimal(const Animal& animal) {
    animal.presentarse();
    animal.hacerSonido();
    animal.respirar();
    std::cout << "---\n";
}

int main() {
    using namespace std;

    cout << "=== HERENCIA Y POLIMORFISMO ===\n\n";

    // -------------------------------------------------------------------------
    // 1. Crear objetos concretos
    // -------------------------------------------------------------------------
    Perro perro1("Rex", 3, "Pastor Alemán");
    Gato  gato1("Michi", 2, true);
    Pajaro pajaro1("Tweety", 1);

    cout << "=== PRESENTACIONES ===\n";
    interactuarConAnimal(perro1);
    interactuarConAnimal(gato1);
    interactuarConAnimal(pajaro1);

    // -------------------------------------------------------------------------
    // 2. Métodos propios (solo accesibles desde el tipo concreto)
    // -------------------------------------------------------------------------
    cout << "=== MÉTODOS PROPIOS ===\n";
    perro1.buscarPelota();
    gato1.ronronear();
    pajaro1.volar();

    // -------------------------------------------------------------------------
    // 3. Polimorfismo con punteros a la clase base
    // -------------------------------------------------------------------------
    cout << "\n=== POLIMORFISMO CON PUNTEROS ===\n";

    // Usamos unique_ptr para manejo automático de memoria (sin delete manual)
    vector<unique_ptr<Animal>> zoologico;
    zoologico.push_back(make_unique<Perro>("Buddy",    2, "Golden Retriever"));
    zoologico.push_back(make_unique<Gato> ("Luna",     4, false));
    zoologico.push_back(make_unique<Pajaro>("Pájaro", 1));
    zoologico.push_back(make_unique<Perro>("Max",      5, "Bulldog"));

    cout << "Recorriendo el zoológico:\n";
    for (const auto& animal : zoologico) {
        // Polimorfismo: hacerSonido() llama la versión correcta en cada caso
        cout << animal->getNombre() << " → ";
        animal->hacerSonido();
    }

    cout << "\n=== DESTRUCCIÓN (al salir del scope) ===\n";
    // Los destructores se llaman en orden inverso al de creación
    // unique_ptr libera la memoria automáticamente

    return 0;
}
