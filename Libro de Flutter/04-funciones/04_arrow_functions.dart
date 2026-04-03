// =============================================================================
// ARCHIVO: 04_arrow_functions.dart
// TEMA: Arrow functions (funciones flecha) en Dart — sintaxis =>
// =============================================================================
//
// Dart permite escribir funciones de una sola expresión con la sintaxis =>.
// Se llaman "arrow functions" o "funciones flecha". Son exactamente iguales
// a las funciones normales en comportamiento, pero más concisas visualmente.
// Son muy usadas en Flutter especialmente con map(), where(), forEach() y
// en la definición de métodos cortos de clases.
//
// CÓMO EJECUTAR:
//   dart run 04_arrow_functions.dart
//
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // COMPARACIÓN: FUNCIÓN LARGA vs ARROW FUNCTION
  // ─────────────────────────────────────────────────────────────────────────

  print('--- Función larga vs arrow ---');

  // Función larga (con llaves y return explícito):
  int resultado1 = doblarLargo(5);
  print('Función larga: $resultado1');

  // Arrow function (una sola expresión, return implícito):
  int resultado2 = doblarArrow(5);
  print('Arrow function: $resultado2');

  // Son idénticas en comportamiento. Solo cambia la sintaxis.

  // ─────────────────────────────────────────────────────────────────────────
  // ARROW FUNCTIONS CON PARÁMETROS
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Arrow functions con parámetros ---');

  print(saludar('Flutter'));
  print(esMayorDeEdad(20));
  print(esMayorDeEdad(15));
  print(areaCirculo(5.0));

  // ─────────────────────────────────────────────────────────────────────────
  // ARROW FUNCTIONS CON COLECCIONES — El caso de uso más común
  // ─────────────────────────────────────────────────────────────────────────

  // Las arrow functions brillan cuando se usan con map(), where(), etc.
  // porque la transformación suele ser una sola expresión.
  print('\n--- Arrow con colecciones ---');

  List<int> numeros = [1, 2, 3, 4, 5, 6, 7, 8];

  // map() + arrow: transformar cada elemento
  var dobles = numeros.map((n) => n * 2).toList();
  print('Dobles: $dobles');

  // where() + arrow: filtrar elementos
  var pares = numeros.where((n) => n % 2 == 0).toList();
  print('Pares: $pares');

  // Equivalente con función larga (más verboso):
  var paresLargo = numeros.where((n) {
    return n % 2 == 0;
  }).toList();
  print('Pares (larga): $paresLargo');

  // forEach() + arrow: ejecutar para cada elemento
  numeros.where((n) => n > 5).forEach((n) => print('Mayor que 5: $n'));

  // ─────────────────────────────────────────────────────────────────────────
  // CUÁNDO USAR ARROW vs FUNCIÓN LARGA
  // ─────────────────────────────────────────────────────────────────────────

  // USA ARROW cuando:
  //   - La función tiene UNA SOLA expresión que devuelve un valor
  //   - Es un callback corto (map, where, sort)
  //   - Métodos getters o computados simples en clases

  // USA FUNCIÓN LARGA cuando:
  //   - Hay múltiples líneas de código
  //   - Hay variables locales
  //   - Hay condicionales complejas
  //   - El cuerpo no cabe cómodamente en una línea

  print('\n--- Cuándo usar cada una ---');

  List<String> frutas = ['mango', 'banano', 'fresa', 'papaya'];

  // BIEN: expresión simple → arrow
  var mayusculas = frutas.map((f) => f.toUpperCase()).toList();
  print('Mayúsculas: $mayusculas');

  // BIEN: lógica compleja → función larga
  var formateadas = frutas.map((fruta) {
    var primera = fruta[0].toUpperCase();
    var resto = fruta.substring(1).toLowerCase();
    return '$primera$resto';
  }).toList();
  print('Formateadas: $formateadas');

  // ─────────────────────────────────────────────────────────────────────────
  // ARROW FUNCTIONS COMO VARIABLES
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Arrow como variables ---');

  // Una arrow function puede asignarse a una variable de tipo función:
  int Function(int) triplicar = (n) => n * 3;
  print('triplicar(7) = ${triplicar(7)}');

  // Pasada como parámetro a otra función:
  var triples = numeros.map(triplicar).toList();
  print('Triples: $triples');

  // Con tipo inferido por var:
  var esPositivo = (int n) => n > 0;
  print('¿5 es positivo? ${esPositivo(5)}');
  print('¿-3 es positivo? ${esPositivo(-3)}');
}

/// Dobla un número — versión larga.
int doblarLargo(int n) {
  return n * 2;
}

/// Dobla un número — versión arrow.
int doblarArrow(int n) => n * 2;

/// Crea un saludo — arrow con interpolación.
String saludar(String nombre) => '¡Hola, $nombre!';

/// Verifica si la edad es mayor de edad — arrow con condición.
bool esMayorDeEdad(int edad) => edad >= 18;

/// Calcula el área de un círculo — arrow con expresión matemática.
double areaCirculo(double radio) => 3.14159 * radio * radio;

// =============================================================================
// EXPERIMENTA:
//   1. Convierte 3 funciones de los módulos anteriores en arrow functions.
//      ¿Son legibles?
//   2. Usa map() con arrow para convertir una lista de temperaturas Celsius a
//      Fahrenheit: F = C * 9/5 + 32.
//   3. Encadena map() y where() con arrows para obtener los cuadrados de los
//      números pares de una lista.
//   4. Crea una arrow function que ordene una lista con sort():
//      lista.sort((a, b) => a.compareTo(b));
//      ¿Qué hace compareTo?
//   5. ¿Puedes escribir una arrow function con un if? Prueba con el
//      operador ternario dentro del =>
// =============================================================================
