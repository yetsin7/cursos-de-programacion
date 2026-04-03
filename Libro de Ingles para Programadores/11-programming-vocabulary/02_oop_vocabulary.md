# OOP Vocabulary

## Vocabulario de Programacion Orientada a Objetos

La Programacion Orientada a Objetos (Object-Oriented Programming / OOP) es uno de
los paradigmas mas usados. Dominar su vocabulario en ingles es esencial para leer
documentacion, participar en code reviews y comunicarte con equipos internacionales.

---

## Conceptos Fundamentales

| Termino | Pronunciacion | Significado |
|---------|--------------|-------------|
| **Class** | /klæs/ "clas" | Plantilla o molde para crear objetos |
| **Object** | /ˈɒbdʒɪkt/ "OB-yekt" | Instancia concreta de una clase |
| **Instance** | /ˈɪnstəns/ "INS-tans" | Un objeto creado a partir de una clase |
| **Method** | /ˈmɛθəd/ "ME-zod" | Funcion que pertenece a una clase |
| **Property** | /ˈprɒpərti/ "PRO-per-ti" | Dato que pertenece a un objeto |
| **Attribute** | /ˈætrɪbjuːt/ "A-tri-biut" | Sinonimo de property en algunos lenguajes |

### Ejemplos en Oraciones

- "Create a new **class** called `User`." (Crea una nueva clase llamada `User`.)
- "This **object** represents a product in the store." (Este objeto representa un producto en la tienda.)
- "Each **instance** of the class has its own state." (Cada instancia de la clase tiene su propio estado.)
- "Call the `save` **method** to persist the data." (Llama al metodo `save` para persistir los datos.)
- "The `name` **property** is required." (La propiedad `name` es requerida.)

```dart
// Ejemplo en Dart
class User {
  String name;       // property / attribute
  int age;           // property / attribute

  User(this.name, this.age);  // constructor

  String greet() {   // method
    return 'Hello, $name';
  }
}

var user = User('Alice', 25);  // object / instance
```

---

## Constructores y Destructores

| Termino | Pronunciacion | Significado |
|---------|--------------|-------------|
| **Constructor** | /kənˈstrʌktər/ "con-STRAK-tor" | Metodo que inicializa un objeto al crearlo |
| **Destructor** | /dɪˈstrʌktər/ "di-STRAK-tor" | Metodo que limpia recursos al destruir un objeto |

- "The **constructor** sets the initial values." (El constructor establece los valores iniciales.)
- "The **destructor** frees allocated memory." (El destructor libera la memoria asignada.)

---

## Los 4 Pilares de OOP

| Termino | Pronunciacion | Significado |
|---------|--------------|-------------|
| **Inheritance** | /ɪnˈhɛrɪtəns/ "in-JE-ri-tans" | Una clase hereda de otra |
| **Polymorphism** | /ˌpɒliˈmɔːrfɪzəm/ "po-li-MOR-fi-sem" | Un mismo metodo se comporta diferente segun la clase |
| **Encapsulation** | /ɪnˌkæpsjuˈleɪʃən/ "in-cap-siu-LEI-shon" | Ocultar los datos internos de una clase |
| **Abstraction** | /æbˈstrækʃən/ "ab-STRAK-shon" | Mostrar solo lo esencial, ocultar la complejidad |

### Ejemplos en Oraciones

- "The `Admin` class uses **inheritance** to extend `User`." (La clase `Admin` usa herencia para extender `User`.)
- "**Polymorphism** allows different classes to respond to the same method." (El polimorfismo permite que diferentes clases respondan al mismo metodo.)
- "**Encapsulation** protects the internal state of the object." (La encapsulacion protege el estado interno del objeto.)
- "**Abstraction** hides the implementation details." (La abstraccion oculta los detalles de implementacion.)

---

## Interfaces y Clases Abstractas

| Termino | Pronunciacion | Significado |
|---------|--------------|-------------|
| **Interface** | /ˈɪntərfeɪs/ "IN-ter-feis" | Contrato que define metodos sin implementacion |
| **Abstract class** | /ˈæbstrækt klæs/ "AB-strakt clas" | Clase que no se puede instanciar directamente |
| **Mixin** | /ˈmɪksɪn/ "MIK-sin" | Bloque de codigo reutilizable entre clases |

- "Implement the `Serializable` **interface**." (Implementa la interfaz `Serializable`.)
- "The **abstract class** defines the contract for all shapes." (La clase abstracta define el contrato para todas las formas.)
- "Use a **mixin** to share behavior between unrelated classes." (Usa un mixin para compartir comportamiento entre clases no relacionadas.)

---

## Modificadores y Palabras Clave

| Termino | Pronunciacion | Significado |
|---------|--------------|-------------|
| **Override** | /ˌoʊvərˈraɪd/ "over-RAID" | Reescribir un metodo heredado |
| **Super** | /ˈsuːpər/ "SUU-per" | Referencia a la clase padre |
| **Static** | /ˈstætɪk/ "STA-tik" | Pertenece a la clase, no a la instancia |
| **Final** | /ˈfaɪnəl/ "FAI-nal" | No se puede modificar ni heredar |
| **Const** | /kɒnst/ "const" | Valor constante en tiempo de compilacion |

- "**Override** the `toString` method." (Sobreescribe el metodo `toString`.)
- "Call **super** to invoke the parent constructor." (Llama a super para invocar el constructor padre.)
- "A **static** method can be called without an instance." (Un metodo estatico se puede llamar sin una instancia.)
- "Mark the class as **final** to prevent inheritance." (Marca la clase como final para prevenir herencia.)

---

## Getters, Setters y Singleton

| Termino | Pronunciacion | Significado |
|---------|--------------|-------------|
| **Getter** | /ˈɡɛtər/ "GUE-ter" | Metodo para obtener el valor de una propiedad |
| **Setter** | /ˈsɛtər/ "SE-ter" | Metodo para asignar el valor de una propiedad |
| **Singleton** | /ˈsɪŋɡəltən/ "SING-gol-ton" | Patron que garantiza una sola instancia |

```dart
class AppConfig {
  // Singleton
  static final AppConfig _instance = AppConfig._internal();
  factory AppConfig() => _instance;
  AppConfig._internal();

  String _apiUrl = '';

  // Getter
  String get apiUrl => _apiUrl;

  // Setter
  set apiUrl(String value) => _apiUrl = value;
}
```

- "Use a **getter** to expose the value." (Usa un getter para exponer el valor.)
- "The **setter** validates the input before assigning." (El setter valida la entrada antes de asignar.)
- "Implement a **singleton** for the database connection." (Implementa un singleton para la conexion a base de datos.)

---

## Frases Comunes en Conversaciones sobre OOP

| Ingles | Espaniol |
|--------|----------|
| "This class inherits from BaseWidget." | "Esta clase hereda de BaseWidget." |
| "You should override that method." | "Deberias sobreescribir ese metodo." |
| "Make the constructor private for the singleton." | "Haz el constructor privado para el singleton." |
| "The interface defines three methods." | "La interfaz define tres metodos." |
| "Encapsulate the logic inside the service." | "Encapsula la logica dentro del servicio." |
| "Is this method static or instance-level?" | "Este metodo es estatico o a nivel de instancia?" |

---

## Resumen

El vocabulario de OOP se divide en:

- **Basico**: class, object, instance, method, property, attribute
- **Inicializacion**: constructor, destructor
- **Pilares**: inheritance, polymorphism, encapsulation, abstraction
- **Contratos**: interface, abstract class, mixin
- **Modificadores**: override, super, static, final, const
- **Patrones**: getter, setter, singleton

Dominar estos terminos te permitira participar en discusiones tecnicas con confianza.
