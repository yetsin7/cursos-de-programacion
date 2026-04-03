// =============================================================================
// ARCHIVO: 04_ejercicios.dart
// TEMA: Ejercicios prácticos de Strings
// =============================================================================
//
// Cinco ejercicios de dificultad progresiva para consolidar el manejo
// de strings en Dart. Cada ejercicio incluye el enunciado, una función
// para resolver y la solución comentada con explicación.
//
// CÓMO EJECUTAR:
//   dart run 04_ejercicios.dart
//
// =============================================================================

/// Imprime el encabezado de un ejercicio numerado.
void ejercicio(int n, String enunciado) {
  print('\n${'═' * 50}');
  print('EJERCICIO $n: $enunciado');
  print('═' * 50);
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 1: Invertir un string
// Dado un string, devuelve sus caracteres en orden inverso.
// Ejemplo: 'Flutter' → 'rettulF'
// ────────────────────────────────────────────────────────────────────────────

/// Invierte los caracteres de [texto] y devuelve el resultado.
///
/// Estrategia: dividir en lista de caracteres, invertir la lista, unir.
String invertirString(String texto) {
  // split('') divide en caracteres individuales
  // reversed devuelve un Iterable en orden inverso
  // join() une los caracteres sin separador
  return texto.split('').reversed.join();
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 2: Contar vocales
// Cuenta cuántas vocales (a, e, i, o, u — mayúsculas o minúsculas) tiene un string.
// Ejemplo: 'Programacion' → 5
// ────────────────────────────────────────────────────────────────────────────

/// Cuenta las vocales presentes en [texto], sin distinción de mayúsculas.
///
/// Incluye vocales con tilde (á, é, í, ó, ú) como vocales válidas.
int contarVocales(String texto) {
  // Convertimos a minúsculas para simplificar la comparación
  String lower = texto.toLowerCase();
  // Conjunto de vocales reconocidas (con y sin tilde)
  const vocales = {'a', 'e', 'i', 'o', 'u', 'á', 'é', 'í', 'ó', 'ú'};
  int contador = 0;
  for (String caracter in lower.split('')) {
    if (vocales.contains(caracter)) contador++;
  }
  return contador;
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 3: Verificar palíndromo
// Un palíndromo se lee igual de izquierda a derecha que de derecha a izquierda.
// Ejemplo: 'radar' → true | 'flutter' → false
// ────────────────────────────────────────────────────────────────────────────

/// Determina si [texto] es un palíndromo, ignorando mayúsculas y espacios.
///
/// Limpia el texto antes de comparar para manejar frases como "Anita lava la tina".
bool esPalindromo(String texto) {
  // Normalizar: minúsculas y sin espacios
  String limpio = texto.toLowerCase().replaceAll(' ', '');
  // Comparar con su versión invertida
  String invertido = limpio.split('').reversed.join();
  return limpio == invertido;
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 4: Convertir a Title Case
// Convierte cada palabra a su forma con inicial mayúscula.
// Ejemplo: 'hola mundo desde dart' → 'Hola Mundo Desde Dart'
// ────────────────────────────────────────────────────────────────────────────

/// Convierte [texto] a Title Case: primera letra de cada palabra en mayúscula.
///
/// Maneja palabras vacías que puedan resultar de múltiples espacios.
String titleCase(String texto) {
  if (texto.isEmpty) return texto;

  return texto
      .split(' ')                        // Dividir en palabras
      .where((p) => p.isNotEmpty)        // Ignorar espacios dobles
      .map((palabra) {
        // Primera letra en mayúscula + resto en minúscula
        return palabra[0].toUpperCase() + palabra.substring(1).toLowerCase();
      })
      .join(' ');                        // Reunir con espacio
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 5: Censurar palabras
// Reemplaza cada letra de las palabras prohibidas por asteriscos (*).
// Ejemplo: censurar('Esto es una tontería', ['tontería']) → 'Esto es una ********'
// ────────────────────────────────────────────────────────────────────────────

/// Reemplaza las palabras de [prohibidas] en [texto] por asteriscos.
///
/// La censura es insensible a mayúsculas/minúsculas: 'Tonto' y 'tonto'
/// se censuran igual. Preserva la longitud original de cada palabra.
String censurarPalabras(String texto, List<String> prohibidas) {
  String resultado = texto;

  for (String palabra in prohibidas) {
    // Expresión regular insensible a mayúsculas para encontrar la palabra
    RegExp patron = RegExp(RegExp.escape(palabra), caseSensitive: false);
    resultado = resultado.replaceAllMapped(patron, (match) {
      // Reemplazar cada carácter encontrado por '*'
      return '*' * match[0]!.length;
    });
  }

  return resultado;
}

// ────────────────────────────────────────────────────────────────────────────
// MAIN: Ejecutar y verificar todos los ejercicios
// ────────────────────────────────────────────────────────────────────────────

void main() {
  // --- Ejercicio 1: Invertir string ---
  ejercicio(1, 'Invertir un string');
  print(invertirString('Flutter'));     // rettulF
  print(invertirString('Dart 3.0'));    // 0.3 traD
  print(invertirString(''));            // (vacío)
  print(invertirString('a'));           // a

  // --- Ejercicio 2: Contar vocales ---
  ejercicio(2, 'Contar vocales');
  print(contarVocales('Programacion')); // 5
  print(contarVocales('Flutter'));      // 2
  print(contarVocales('Murciélago'));   // 5
  print(contarVocales('rhythm'));       // 0

  // --- Ejercicio 3: Verificar palíndromo ---
  ejercicio(3, 'Verificar palíndromo');
  print(esPalindromo('radar'));                  // true
  print(esPalindromo('Flutter'));                // false
  print(esPalindromo('Anita lava la tina'));     // true
  print(esPalindromo('A man a plan a canal'));   // false (falta la 'a' al final)

  // --- Ejercicio 4: Title Case ---
  ejercicio(4, 'Convertir a Title Case');
  print(titleCase('hola mundo desde dart'));        // Hola Mundo Desde Dart
  print(titleCase('EL RÁPIDO ZORRO MARRÓN'));       // El Rápido Zorro Marrón
  print(titleCase('una sola'));                     // Una Sola

  // --- Ejercicio 5: Censurar palabras ---
  ejercicio(5, 'Censurar palabras prohibidas');
  print(censurarPalabras('Esto es una tontería total', ['tontería']));
  // Esto es una ******** total
  print(censurarPalabras('El malo es muy MALO de verdad', ['malo']));
  // El **** es muy **** de verdad
  print(censurarPalabras('Todo está bien aquí', ['nada']));
  // Todo está bien aquí  (sin cambios)

  print('\n¡Todos los ejercicios completados!');
}

// EXPERIMENTA:
//   - Modifica esPalindromo para que también ignore puntuación (comas, puntos)
//   - Extiende titleCase para que no capitalice artículos cortos ('de', 'la', 'el')
//   - Crea una función que cuente la frecuencia de cada letra en un string
//   - Implementa un anagrama: ¿'listen' y 'silent' son anagramas?
