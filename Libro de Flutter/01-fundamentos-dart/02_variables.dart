// =============================================================================
// ARCHIVO: 02_variables.dart
// TEMA: Variables y tipos básicos en Dart
// =============================================================================
//
// Dart es un lenguaje de tipado estático con inferencia de tipos.
// Esto significa que el tipo de una variable se conoce en tiempo de compilación,
// pero no siempre tienes que escribirlo explícitamente: Dart lo deduce.
//
// CÓMO EJECUTAR:
//   dart run 02_variables.dart
//
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // VAR — Inferencia de tipo automática
  // ─────────────────────────────────────────────────────────────────────────

  // Con "var", Dart infiere el tipo según el valor asignado.
  // Una vez que Dart deduce el tipo, NO puedes asignar un valor de otro tipo.
  var ciudad = 'Managua';       // Dart infiere: String
  var poblacion = 1_400_000;    // Dart infiere: int (los _ son separadores visuales)
  var temperatura = 32.5;       // Dart infiere: double
  var esCapital = true;         // Dart infiere: bool

  print('Ciudad: $ciudad');
  print('Población: $poblacion');
  print('Temperatura: $temperatura °C');
  print('¿Es capital? $esCapital');

  // Esto causaría un error en tiempo de compilación (tipo no coincide):
  // ciudad = 123; // ERROR: A value of type 'int' can't be assigned to 'String'

  // ─────────────────────────────────────────────────────────────────────────
  // TIPOS EXPLÍCITOS — Declarar el tipo manualmente
  // ─────────────────────────────────────────────────────────────────────────

  // En lugar de "var", puedes escribir el tipo directamente.
  // Esto hace el código más legible y autodocumentado.
  // Recomendado especialmente en parámetros de funciones y variables de clase.
  String nombre = 'Ana';
  int edad = 28;
  double altura = 1.65;
  bool estaActivo = false;

  print('\n--- Tipos explícitos ---');
  print('Nombre: $nombre (tipo: ${nombre.runtimeType})');
  print('Edad: $edad (tipo: ${edad.runtimeType})');
  print('Altura: $altura (tipo: ${altura.runtimeType})');
  print('Activo: $estaActivo (tipo: ${estaActivo.runtimeType})');

  // ─────────────────────────────────────────────────────────────────────────
  // VAR vs TIPO EXPLÍCITO — ¿Cuándo usar cada uno?
  // ─────────────────────────────────────────────────────────────────────────

  // Usa "var" cuando el tipo es obvio por el valor asignado:
  var lista = [1, 2, 3];          // Claramente una List<int>
  var mapa = {'a': 1, 'b': 2};   // Claramente un Map<String, int>

  // Usa tipo explícito cuando el tipo no es obvio, o para mayor claridad:
  List<String> nombres = [];          // Lista vacía — el tipo no se puede inferir
  Map<String, double> precios = {};   // Mapa vacío — mismo caso

  print('\n--- var vs tipo explícito ---');
  print('lista: $lista');
  print('mapa: $mapa');
  print('nombres vacía: $nombres');
  print('precios vacío: $precios');

  // ─────────────────────────────────────────────────────────────────────────
  // DYNAMIC — El tipo que acepta cualquier valor (usar con cuidado)
  // ─────────────────────────────────────────────────────────────────────────

  // "dynamic" desactiva la verificación de tipos en tiempo de compilación.
  // La variable puede cambiar de tipo en cualquier momento.
  // Es útil en casos específicos (JSON sin tipado, interop, etc.),
  // pero en general debes EVITARLO porque pierdes la seguridad de tipos.
  dynamic cualquierCosa = 'Soy un texto';
  print('\n--- dynamic ---');
  print('dynamic como String: $cualquierCosa');

  cualquierCosa = 42;
  print('dynamic como int: $cualquierCosa');

  cualquierCosa = [true, false, true];
  print('dynamic como List: $cualquierCosa');

  // El problema de dynamic: Dart no avisará si cometes un error de tipo.
  // El error ocurrirá en tiempo de ejecución, no de compilación.
  // Ejemplo peligroso (comentado para no romper el programa):
  // dynamic numero = 5;
  // print(numero.toUpperCase()); // Falla en ejecución: int no tiene toUpperCase()

  // ─────────────────────────────────────────────────────────────────────────
  // VARIABLES NO INICIALIZADAS Y NULL SAFETY
  // ─────────────────────────────────────────────────────────────────────────

  // En Dart con null safety (activado por defecto desde Dart 2.12),
  // una variable no puede ser null a menos que lo declares explícitamente.
  // El tipo "String?" significa "String o null".
  String? apodo;  // Declarada pero no inicializada → su valor es null
  print('\n--- Null safety básico ---');
  print('apodo sin inicializar: $apodo');  // Imprime: null

  apodo = 'Flutterista';
  print('apodo después de asignar: $apodo');

  // Esto causaría error (String sin ? no puede ser null):
  // String sinNull;
  // print(sinNull); // ERROR: must be assigned before it can be used
}

// =============================================================================
// EXPERIMENTA:
//   1. Intenta reasignar "ciudad" con un número. Lee el error del compilador.
//   2. Crea una variable "dynamic" y llama un método que no existe.
//      ¿Cuándo falla? ¿En compilación o en ejecución?
//   3. Crea variables con tipo explícito para tu nombre, edad y altura.
//   4. Declara una variable "String?" sin valor. ¿Qué imprime? Luego asígnale
//      un valor y vuelve a imprimirla.
//   5. Intenta declarar "String sinValor;" y usarla sin asignarle nada.
//      Lee el error de Dart.
// =============================================================================
