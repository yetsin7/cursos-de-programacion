# Data Types Vocabulary

## Vocabulario de Tipos de Datos

Los tipos de datos son la base de cualquier lenguaje de programacion. Conocer sus
nombres en ingles y como pronunciarlos es fundamental para leer documentacion,
escribir codigo y comunicarte con otros desarrolladores.

---

## Tipos de Datos Primitivos

| Tipo | Pronunciacion | Significado | Ejemplo en codigo |
|------|--------------|-------------|-------------------|
| **String** | /strɪŋ/ "string" | Cadena de texto | `String name = "Alice";` |
| **Integer** | /ˈɪntɪdʒər/ "IN-teh-yer" | Numero entero | `int age = 25;` |
| **Float** | /floʊt/ "floht" | Numero decimal (precision simple) | `float price = 9.99f;` |
| **Double** | /ˈdʌbəl/ "DA-bol" | Numero decimal (doble precision) | `double pi = 3.14159;` |
| **Boolean** | /ˈbuːliən/ "BUU-li-an" | Verdadero o falso | `bool isActive = true;` |
| **Char** | /tʃɑːr/ "char" | Un solo caracter | `char letter = 'A';` |

### Ejemplos en Oraciones

- "This function **returns a string**." (Esta funcion devuelve una cadena de texto.)
- "The variable `age` is an **integer**." (La variable `age` es un entero.)
- "Use a **float** for approximate decimal values." (Usa un float para valores decimales aproximados.)
- "A **double** has more precision than a float." (Un double tiene mas precision que un float.)
- "The **boolean** flag indicates if the user is logged in." (La bandera booleana indica si el usuario ha iniciado sesion.)
- "A **char** holds a single character." (Un char contiene un solo caracter.)

---

## Tipos de Datos Compuestos / Colecciones

| Tipo | Pronunciacion | Significado | Ejemplo en codigo |
|------|--------------|-------------|-------------------|
| **Array** | /əˈreɪ/ "a-REI" | Coleccion de tamanio fijo | `int[] numbers = [1, 2, 3];` |
| **List** | /lɪst/ "list" | Coleccion ordenada y dinamica | `List<String> names = [];` |
| **Map** | /mæp/ "map" | Pares clave-valor | `Map<String, int> ages = {};` |
| **Dictionary** | /ˈdɪkʃəneri/ "DIK-sho-ne-ri" | Igual que Map (usado en Python/C#) | `dict = {"key": "value"}` |
| **Set** | /sɛt/ "set" | Coleccion sin duplicados | `Set<int> unique = {1, 2, 3};` |
| **Tuple** | /ˈtʌpəl/ o /ˈtuːpəl/ "TA-pol" o "TUU-pol" | Coleccion inmutable y ordenada | `(String, int) record = ("Alice", 25);` |

### Ejemplos en Oraciones

- "Store the results in an **array**." (Almacena los resultados en un arreglo.)
- "Add the item to the **list**." (Agrega el elemento a la lista.)
- "Look up the value in the **map** using the key." (Busca el valor en el mapa usando la clave.)
- "Python uses **dictionaries** for key-value pairs." (Python usa diccionarios para pares clave-valor.)
- "A **set** automatically removes duplicates." (Un set elimina duplicados automaticamente.)
- "Return a **tuple** with the name and age." (Devuelve una tupla con el nombre y la edad.)

---

## Tipos Especiales

| Tipo | Pronunciacion | Significado | Ejemplo en codigo |
|------|--------------|-------------|-------------------|
| **Enum** | /ˈiːnʌm/ "II-nam" | Conjunto de constantes nombradas | `enum Color { red, green, blue }` |
| **Void** | /vɔɪd/ "void" | Sin valor de retorno | `void printName() { ... }` |
| **Null** | /nʌl/ "nal" | Ausencia de valor | `String? name = null;` |
| **Undefined** | /ˌʌndɪˈfaɪnd/ "an-di-FAIND" | Variable declarada sin valor (JS) | `let x; // undefined` |

### Diferencia entre Null y Undefined

En muchos lenguajes, `null` significa "intencionalmente vacio". En JavaScript,
`undefined` significa "existe pero no se le ha asignado valor".

```javascript
// Ejemplo en JavaScript
let name;          // undefined - no se asigno valor
let age = null;    // null - intencionalmente vacio

console.log(typeof name);  // "undefined"
console.log(typeof age);   // "object" (peculiaridad de JS)
```

### Ejemplos en Oraciones

- "Use an **enum** to define a fixed set of options." (Usa un enum para definir un conjunto fijo de opciones.)
- "This method returns **void** — it doesn't return anything." (Este metodo retorna void, no devuelve nada.)
- "Check if the value is **null** before using it." (Verifica si el valor es nulo antes de usarlo.)
- "The variable is **undefined** because it was never assigned." (La variable es undefined porque nunca se le asigno valor.)

---

## Frases Comunes con Tipos de Datos

| Frase en Ingles | Significado en Espaniol |
|-----------------|------------------------|
| "What type does this function return?" | "Que tipo retorna esta funcion?" |
| "Cast the value to an integer." | "Convierte el valor a entero." |
| "This parameter expects a string." | "Este parametro espera una cadena." |
| "The list is empty." | "La lista esta vacia." |
| "Initialize the array with default values." | "Inicializa el arreglo con valores por defecto." |
| "The map contains duplicate keys." | "El mapa contiene claves duplicadas." |
| "Parse the string to a double." | "Convierte la cadena a un double." |
| "This variable is nullable." | "Esta variable puede ser nula." |

---

## Verbos Relacionados con Tipos de Datos

| Verbo | Pronunciacion | Significado | Ejemplo |
|-------|--------------|-------------|---------|
| **to cast** | /kæst/ | Convertir un tipo a otro | "Cast the float to an int." |
| **to parse** | /pɑːrs/ | Analizar y convertir texto | "Parse the JSON string." |
| **to initialize** | /ɪˈnɪʃəlaɪz/ | Dar valor inicial | "Initialize the list." |
| **to declare** | /dɪˈklɛr/ | Crear una variable | "Declare a boolean variable." |
| **to assign** | /əˈsaɪn/ | Dar valor a una variable | "Assign a value to the string." |
| **to convert** | /kənˈvɜːrt/ | Cambiar de un tipo a otro | "Convert the string to an integer." |

---

## Resumen

Los tipos de datos son el vocabulario mas basico en programacion. Recuerda:

- **Primitivos**: string, integer, float, double, boolean, char
- **Colecciones**: array, list, map, dictionary, set, tuple
- **Especiales**: enum, void, null, undefined

Practica usando estos terminos en oraciones completas para que se vuelvan naturales
en tu comunicacion tecnica diaria.
