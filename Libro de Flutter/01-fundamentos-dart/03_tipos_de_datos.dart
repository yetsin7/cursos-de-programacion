// =============================================================================
// ARCHIVO: 03_tipos_de_datos.dart
// TEMA: Tipos de datos en Dart y conversiones entre ellos
// =============================================================================
//
// Dart tiene un sistema de tipos rico y seguro. Todos los tipos son objetos,
// incluso los números y los booleanos. No existen los "tipos primitivos"
// como en Java o C++.
//
// CÓMO EJECUTAR:
//   dart run 03_tipos_de_datos.dart
//
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // int — Números enteros
  // ─────────────────────────────────────────────────────────────────────────

  // int puede almacenar enteros sin límite fijo en Dart nativo.
  // En la web (compilado a JS), está limitado a 53 bits.
  int positivo = 100;
  int negativo = -42;
  int grande = 1_000_000;   // Los guiones bajos mejoran la legibilidad
  int hex = 0xFF;           // Notación hexadecimal (255 en decimal)
  int binario = 0b1010;     // Notación binaria (10 en decimal)

  print('--- int ---');
  print('positivo: $positivo');
  print('negativo: $negativo');
  print('grande: $grande');
  print('hex 0xFF = $hex');
  print('binario 0b1010 = $binario');

  // ─────────────────────────────────────────────────────────────────────────
  // double — Números de punto flotante
  // ─────────────────────────────────────────────────────────────────────────

  // double representa números con decimales. Sigue el estándar IEEE 754.
  // Importante: los cálculos con double pueden tener imprecisiones de punto flotante.
  double pi = 3.14159265;
  double negativoDecimal = -0.5;
  double notacionCientifica = 1.5e3;  // 1500.0
  double pequeño = 1.5e-3;            // 0.0015

  print('\n--- double ---');
  print('pi: $pi');
  print('negativoDecimal: $negativoDecimal');
  print('1.5e3 = $notacionCientifica');
  print('1.5e-3 = $pequeño');

  // Ejemplo de imprecisión de punto flotante (comportamiento normal):
  print('0.1 + 0.2 = ${0.1 + 0.2}');  // No es exactamente 0.3

  // ─────────────────────────────────────────────────────────────────────────
  // num — El supertipo de int y double
  // ─────────────────────────────────────────────────────────────────────────

  // "num" puede contener tanto int como double.
  // Útil cuando quieres aceptar ambos tipos en una variable o parámetro.
  num enteroComoNum = 5;
  num decimalComoNum = 5.5;

  print('\n--- num ---');
  print('enteroComoNum: $enteroComoNum (tipo: ${enteroComoNum.runtimeType})');
  print('decimalComoNum: $decimalComoNum (tipo: ${decimalComoNum.runtimeType})');

  // ─────────────────────────────────────────────────────────────────────────
  // String — Texto
  // ─────────────────────────────────────────────────────────────────────────

  // Los Strings en Dart son secuencias de caracteres Unicode (UTF-16).
  // Soportan emojis, acentos, ñ y cualquier carácter internacional.
  String saludo = '¡Hola, mundo!';
  String conEmoji = 'Flutter 💙';
  String conEspanol = 'Ñoño, corazón, café';

  print('\n--- String ---');
  print(saludo);
  print(conEmoji);
  print(conEspanol);
  print('Longitud: ${saludo.length}');
  print('Mayúsculas: ${saludo.toUpperCase()}');
  print('Contiene "mundo": ${saludo.contains("mundo")}');

  // ─────────────────────────────────────────────────────────────────────────
  // bool — Booleanos
  // ─────────────────────────────────────────────────────────────────────────

  // Solo puede ser true o false. No existe "truthy/falsy" como en Python.
  // En Dart, 0, "", [] etc. NO son false — solo el literal false lo es.
  bool verdadero = true;
  bool falso = false;

  print('\n--- bool ---');
  print('verdadero: $verdadero');
  print('falso: $falso');
  print('AND: ${verdadero && falso}');
  print('OR: ${verdadero || falso}');
  print('NOT: ${!verdadero}');

  // ─────────────────────────────────────────────────────────────────────────
  // CONVERSIONES ENTRE TIPOS
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Conversiones ---');

  // String → int
  String textoNumero = '42';
  int convertido = int.parse(textoNumero);
  print('"$textoNumero" como int: $convertido');

  // String → double
  String textoDecimal = '3.14';
  double convertidoDouble = double.parse(textoDecimal);
  print('"$textoDecimal" como double: $convertidoDouble');

  // int → String
  int numero = 100;
  String comoTexto = numero.toString();
  print('$numero como String: "$comoTexto"');

  // double → int (trunca la parte decimal, no redondea)
  double decimal = 9.99;
  int truncado = decimal.toInt();
  print('$decimal como int (truncado): $truncado');

  // int → double
  int entero = 7;
  double comoDouble = entero.toDouble();
  print('$entero como double: $comoDouble');

  // Conversión segura (si falla, devuelve null en lugar de lanzar excepción):
  int? seguro = int.tryParse('no es número');  // Devuelve null
  int? seguro2 = int.tryParse('99');           // Devuelve 99
  print('tryParse de "no es número": $seguro');
  print('tryParse de "99": $seguro2');

  // ─────────────────────────────────────────────────────────────────────────
  // VERIFICAR EL TIPO CON is Y runtimeType
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Verificar tipos ---');

  dynamic valor = 'Soy un texto';
  print('¿Es String? ${valor is String}');
  print('¿Es int? ${valor is int}');
  print('Tipo en tiempo de ejecución: ${valor.runtimeType}');

  valor = 123;
  print('¿Es int ahora? ${valor is int}');
  print('Tipo ahora: ${valor.runtimeType}');
}

// =============================================================================
// EXPERIMENTA:
//   1. Prueba int.parse('abc') — ¿qué error lanza?
//   2. Compara int.parse() con int.tryParse() en un texto no numérico.
//   3. ¿Cuánto es 9 ~/ 2 en Dart? ¿Y 9 / 2? (pista: ~ es división entera)
//   4. Crea una variable "num" y asígnale primero un int, luego un double.
//   5. Verifica cuántos bytes ocupa un String con caracteres Unicode vs ASCII.
//      (Pista: usa .length y compara "abc" vs "café")
// =============================================================================
