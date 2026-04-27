# OOP Vocabulary

## Vocabulario de Programación Orientada a Objetos

La Programación Orientada a Objetos (Object-Oriented Programming / OOP) es uno de
los paradigmas mas usados. Dominar su vocabulario en ingles es esencial para leer
documentación, participar en code reviews y comunicarte con equipos internacionales.

---

## Conceptos Fundamentales

| Término | Pronunciacion | Significado |
|---------|--------------|-------------|
| **Class** | /klæs/ "clas" | Plantilla o molde para crear objetos |
| **Object** | /ˈɒbdʒɪkt/ "OB-yekt" | Instancia concreta de una clase |
| **Instance** | /ˈɪnstəns/ "INS-tans" | Un objeto creado a partir de una clase |
| **Method** | /ˈmɛθəd/ "ME-zod" | Función que pertenece a una clase |
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

| Término | Pronunciacion | Significado |
|---------|--------------|-------------|
| **Constructor** | /kənˈstrʌktər/ "con-STRAK-tor" | Método que inicializa un objeto al crearlo |
| **Destructor** | /dɪˈstrʌktər/ "di-STRAK-tor" | Método que limpia recursos al destruir un objeto |

- "The **constructor** sets the initial values." (El constructor establece los valores iniciales.)
- "The **destructor** frees allocated memory." (El destructor libera la memoria asignada.)

---

## Los 4 Pilares de OOP

| Término | Pronunciacion | Significado |
|---------|--------------|-------------|
| **Inheritance** | /ɪnˈhɛrɪtəns/ "in-JE-ri-tans" | Una clase hereda de otra |
| **Polymorphism** | /ˌpɒliˈmɔːrfɪzəm/ "po-li-MOR-fi-sem" | Un mismo método se comporta diferente según la clase |
| **Encapsulation** | /ɪnˌkæpsjuˈleɪʃən/ "in-cap-siu-LEI-shon" | Ocultar los datos internos de una clase |
| **Abstraction** | /æbˈstrækʃən/ "ab-STRAK-shon" | Mostrar solo lo esencial, ocultar la complejidad |

### Ejemplos en Oraciones

- "The `Admin` class uses **inheritance** to extend `User`." (La clase `Admin` usa herencia para extender `User`.)
- "**Polymorphism** allows different classes to respond to the same method." (El polimorfismo permite que diferentes clases respondan al mismo método.)
- "**Encapsulation** protects the internal state of the object." (La encapsulación protege el estado interno del objeto.)
- "**Abstraction** hides the implementation details." (La abstracción oculta los detalles de implementación.)

---

## Interfaces y Clases Abstractas

| Término | Pronunciacion | Significado |
|---------|--------------|-------------|
| **Interface** | /ˈɪntərfeɪs/ "IN-ter-feis" | Contrato que define métodos sin implementación |
| **Abstract class** | /ˈæbstrækt klæs/ "AB-strakt clas" | Clase que no se puede instanciar directamente |
| **Mixin** | /ˈmɪksɪn/ "MIK-sin" | Bloque de código reutilizable entre clases |

- "Implement the `Serializable` **interface**." (Implementa la interfaz `Serializable`.)
- "The **abstract class** defines the contract for all shapes." (La clase abstracta define el contrato para todas las formas.)
- "Use a **mixin** to share behavior between unrelated classes." (Usa un mixin para compartir comportamiento entre clases no relacionadas.)

---

## Modificadores y Palabras Clave

| Término | Pronunciacion | Significado |
|---------|--------------|-------------|
| **Override** | /ˌoʊvərˈraɪd/ "over-RAID" | Reescribir un método heredado |
| **Super** | /ˈsuːpər/ "SUU-per" | Referencia a la clase padre |
| **Static** | /ˈstætɪk/ "STA-tik" | Pertenece a la clase, no a la instancia |
| **Final** | /ˈfaɪnəl/ "FAI-nal" | No se puede modificar ni heredar |
| **Const** | /kɒnst/ "const" | Valor constante en tiempo de compilación |

- "**Override** the `toString` method." (Sobreescribe el metodo `toString`.)
- "Call **super** to invoke the parent constructor." (Llama a super para invocar el constructor padre.)
- "A **static** method can be called without an instance." (Un método estatico se puede llamar sin una instancia.)
- "Mark the class as **final** to prevent inheritance." (Marca la clase como final para prevenir herencia.)

---

## Getters, Setters y Singleton

| Término | Pronunciacion | Significado |
|---------|--------------|-------------|
| **Getter** | /ˈɡɛtər/ "GUE-ter" | Método para obtener el valor de una propiedad |
| **Setter** | /ˈsɛtər/ "SE-ter" | Método para asignar el valor de una propiedad |
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
- "Implement a **singleton** for the database connection." (Implementa un singleton para la conexión a base de datos.)

---

## Frases Comúnes en Conversaciones sobre OOP

| Ingles | Espaniol |
|--------|----------|
| "This class inherits from BaseWidget." | "Esta clase hereda de BaseWidget." |
| "You should override that method." | "Deberias sobreescribir ese método." |
| "Make the constructor private for the singleton." | "Haz el constructor privado para el singleton." |
| "The interface defines three methods." | "La interfaz define tres métodos." |
| "Encapsulate the logic inside the service." | "Encapsula la lógica dentro del servicio." |
| "Is this method static or instance-level?" | "Este método es estatico o a nivel de instancia?" |

---

## Resumen

El vocabulario de OOP se divide en:

- **Básico**: class, object, instance, method, property, attribute
- **Inicialización**: constructor, destructor
- **Pilares**: inheritance, polymorphism, encapsulation, abstraction
- **Contratos**: interface, abstract class, mixin
- **Modificadores**: override, super, static, final, const
- **Patrones**: getter, setter, singleton

Dominar estos términos te permitira participar en discusiones técnicas con confianza.
