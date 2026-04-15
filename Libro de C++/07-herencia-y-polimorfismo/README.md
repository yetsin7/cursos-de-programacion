# Capítulo 07 — Herencia y Polimorfismo

## Herencia

La herencia permite crear una clase nueva (**derivada**) basada en una existente (**base**),
reutilizando y extendiendo su funcionalidad:

```cpp
// Clase base
class Animal {
public:
    std::string nombre;
    void respirar() { std::cout << "Respirando...\n"; }
};

// Clase derivada: hereda de Animal
class Perro : public Animal {
public:
    void ladrar() { std::cout << "¡Guau!\n"; }
};

Perro rex;
rex.nombre = "Rex";   // Atributo heredado de Animal
rex.respirar();       // Método heredado de Animal
rex.ladrar();         // Método propio de Perro
```

---

## Tipos de herencia

| Especificador | public | protected | private |
|---------------|--------|-----------|---------|
| `public` | public | protected | inaccesible |
| `protected` | protected | protected | inaccesible |
| `private` | private | private | inaccesible |

La herencia `public` es la más común: preserva la visibilidad de los miembros.

---

## Polimorfismo y funciones virtuales

El **polimorfismo** permite tratar objetos de clases diferentes de forma uniforme
a través de un puntero/referencia a la clase base:

```cpp
class Animal {
public:
    virtual void hacerSonido() {  // virtual: permite ser sobreescrito
        std::cout << "Sonido genérico\n";
    }
};

class Perro : public Animal {
public:
    void hacerSonido() override { // override: indica sobreescritura explícita
        std::cout << "¡Guau!\n";
    }
};

// Polimorfismo en acción:
Animal* animal = new Perro();  // Puntero base apunta a objeto derivado
animal->hacerSonido();          // Llama a Perro::hacerSonido() → "¡Guau!"
```

> Sin `virtual`, `animal->hacerSonido()` llamaría a `Animal::hacerSonido()`.
> Con `virtual`, C++ usa la **tabla virtual (vtable)** para resolver en ejecución.

---

## `override` y `final` (C++11)

```cpp
class Gato : public Animal {
public:
    void hacerSonido() override final { // override: verifica que sobreescribe
        std::cout << "¡Miau!\n";        // final: nadie puede sobreescribir más
    }
};

class Animal final { ... };  // final en la clase: nadie puede heredar de ella
```

---

## Clases abstractas e interfaces

Una clase con al menos un **método puramente virtual** (`= 0`) es **abstracta**:
no se pueden crear instancias directas, solo usarla como interfaz.

```cpp
class Figura {               // Clase abstracta (tiene método puro)
public:
    virtual double area()   const = 0;  // Método puro: DEBE implementarse
    virtual double perimetro() const = 0;

    // Puede tener métodos concretos también
    void describir() const {
        std::cout << "Área: " << area() << ", Perímetro: " << perimetro() << "\n";
    }
};

class Circulo : public Figura {
private:
    double radio;
public:
    Circulo(double r) : radio(r) {}
    double area()      const override { return 3.14159 * radio * radio; }
    double perimetro() const override { return 2 * 3.14159 * radio; }
};
```

---

## Destructor virtual

Cuando se usa polimorfismo con punteros a clase base, el destructor de la base
**debe ser virtual** para que se llame el destructor correcto:

```cpp
class Animal {
public:
    virtual ~Animal() { /* limpia recursos base */ }
};
```

---

## Archivo de ejemplo

Ver: [01_herencia.cpp](01_herencia.cpp)
