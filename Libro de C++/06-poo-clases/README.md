# Capítulo 06 — POO: Clases y Objetos

## ¿Qué es una clase?

Una **clase** es un molde (blueprint) que define la estructura y comportamiento de un
tipo de dato. Un **objeto** es una instancia concreta de esa clase.

```
Clase Persona     →   Objeto: persona1 (nombre="Ana", edad=30)
                  →   Objeto: persona2 (nombre="Carlos", edad=25)
```

---

## Estructura de una clase

```cpp
class NombreClase {
public:                     // Accesible desde cualquier lugar
    int atributoPublico;
    void metodoPublico();

protected:                  // Accesible desde la clase y sus derivadas
    int atributoProtegido;

private:                    // Solo accesible desde dentro de la clase
    int atributoPrivado;
};
```

---

## Encapsulación

Principio de ocultar los detalles internos y exponer solo lo necesario:

- `private`: datos internos que no deben manipularse directamente
- `public`: interfaz que expone la clase al exterior
- **Getters/Setters**: métodos para leer y escribir atributos privados con control

```cpp
class Persona {
private:
    std::string nombre;
    int edad;

public:
    std::string getNombre() const { return nombre; }
    void setNombre(const std::string& n) { nombre = n; }

    int getEdad() const { return edad; }
    void setEdad(int e) {
        if (e >= 0 && e <= 150) edad = e;  // Validación
    }
};
```

---

## Constructores

El **constructor** se llama automáticamente al crear un objeto. No tiene tipo de retorno.

```cpp
class Persona {
public:
    // Constructor por defecto
    Persona() : nombre("Sin nombre"), edad(0) {}

    // Constructor con parámetros
    Persona(const std::string& n, int e) : nombre(n), edad(e) {}

    // Lista de inicialización (:) es más eficiente que asignar en el cuerpo
};

Persona p1;                      // Usa constructor por defecto
Persona p2("Ana", 30);           // Usa constructor con parámetros
Persona p3 = {"Carlos", 25};     // Inicialización uniforme (C++11)
```

---

## Destructor

El **destructor** se llama automáticamente al destruir el objeto (sale de scope o `delete`).
Se usa para liberar recursos (memoria, archivos, conexiones):

```cpp
class Persona {
public:
    ~Persona() {
        std::cout << "Destruyendo a " << nombre << "\n";
    }
};
```

---

## `this` — Puntero al objeto actual

Dentro de los métodos, `this` es un puntero al objeto sobre el que se llama el método:

```cpp
void Persona::setNombre(const std::string& nombre) {
    this->nombre = nombre;  // 'this->nombre' es el atributo, 'nombre' es el parámetro
}
```

---

## Métodos `const`

Un método `const` garantiza que no modifica el objeto:

```cpp
std::string getNombre() const { return nombre; }  // No puede modificar 'nombre'
```

---

## Archivo de ejemplo

Ver: [01_clases.cpp](01_clases.cpp)
