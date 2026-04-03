// =============================================================================
// ARCHIVO: 06_ejercicios.dart
// TEMA: Ejercicios prácticos — Módulo 01: Fundamentos de Dart
// =============================================================================
//
// Estos ejercicios consolidan todo lo aprendido en el Módulo 01.
// Intenta resolverlos antes de ver las soluciones.
// Las soluciones están comentadas al final de cada ejercicio.
//
// CÓMO EJECUTAR:
//   dart run 06_ejercicios.dart
//
// =============================================================================

void main() {
  print('====== EJERCICIOS — MÓDULO 01: FUNDAMENTOS DE DART ======\n');

  ejercicio1();
  ejercicio2();
  ejercicio3();
  ejercicio4();
  ejercicio5();
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 1 — Presentación personal
// ─────────────────────────────────────────────────────────────────────────────

/// Ejercicio 1: Presentación personal con interpolación de strings.
///
/// Crea variables para: nombre, edad, ciudad, lenguaje favorito.
/// Imprime una presentación usando interpolación de strings.
/// La salida debe verse así:
///   Hola, me llamo [nombre]. Tengo [edad] años y vivo en [ciudad].
///   Mi lenguaje favorito actualmente es [lenguaje].
void ejercicio1() {
  print('--- EJERCICIO 1: Presentación personal ---');

  // Escribe tu solución aquí:
  // ...

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  var nombre = 'Carlos';
  var edad = 25;
  var ciudad = 'Managua';
  var lenguajeFavorito = 'Dart';

  print('Hola, me llamo $nombre. Tengo $edad años y vivo en $ciudad.');
  print('Mi lenguaje favorito actualmente es $lenguajeFavorito.');
  print('');
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 2 — Tipos y conversiones
// ─────────────────────────────────────────────────────────────────────────────

/// Ejercicio 2: Conversión de tipos de datos.
///
/// Tienes estos valores como Strings: "45", "3.7", "true"
/// Convierte cada uno a su tipo correcto (int, double, bool).
/// Luego imprime cada valor y su tipo con runtimeType.
/// Finalmente calcula: 45 * 3.7 e imprime el resultado.
void ejercicio2() {
  print('--- EJERCICIO 2: Tipos y conversiones ---');

  // Escribe tu solución aquí:
  // ...

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  String textoEntero = '45';
  String textoDecimal = '3.7';
  String textoBooleano = 'true';

  // Convertir a sus tipos correctos
  int entero = int.parse(textoEntero);
  double decimal = double.parse(textoDecimal);
  // bool no tiene parse() directo, se compara con el string "true"
  bool booleano = textoBooleano == 'true';

  print('"$textoEntero" → $entero (${entero.runtimeType})');
  print('"$textoDecimal" → $decimal (${decimal.runtimeType})');
  print('"$textoBooleano" → $booleano (${booleano.runtimeType})');
  print('Multiplicación: $entero × $decimal = ${entero * decimal}');
  print('');
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 3 — Constantes temáticas
// ─────────────────────────────────────────────────────────────────────────────

/// Ejercicio 3: Saber cuándo usar const y final.
///
/// Define lo siguiente y elige si usar const o final para cada uno:
/// - El nombre de tu aplicación (nunca cambia)
/// - La versión de la app (nunca cambia)
/// - La fecha y hora de inicio del programa (se conoce al ejecutar)
/// - El número máximo de intentos de login (nunca cambia)
/// Justifica en un comentario por qué usaste const o final en cada caso.
void ejercicio3() {
  print('--- EJERCICIO 3: const vs final ---');

  // Escribe tu solución aquí:
  // ...

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────

  // const: valor literal conocido en tiempo de compilación
  const String appNombre = 'MiBiblia';
  const String appVersion = '1.0.0';
  const int maxIntentosLogin = 3;

  // final: se calcula en tiempo de ejecución (DateTime.now() no es compilación)
  final DateTime inicio = DateTime.now();

  print('App: $appNombre v$appVersion');
  print('Máximo de intentos: $maxIntentosLogin');
  print('Inicio del programa: $inicio');
  print('');
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 4 — Detección segura de tipos
// ─────────────────────────────────────────────────────────────────────────────

/// Ejercicio 4: Conversión segura con tryParse.
///
/// Tienes una lista de strings que pueden o no ser números:
/// ["12", "flutter", "99.5", "hola", "0"]
/// Para cada string, intenta convertirlo a int y a double usando tryParse.
/// Si la conversión falla, imprime un mensaje indicando que no es un número.
/// Si tiene éxito, imprime el valor y su tipo.
void ejercicio4() {
  print('--- EJERCICIO 4: tryParse seguro ---');

  // Escribe tu solución aquí:
  // ...

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  var valores = ['12', 'flutter', '99.5', 'hola', '0'];

  for (var texto in valores) {
    var comoInt = int.tryParse(texto);
    var comoDouble = double.tryParse(texto);

    if (comoInt != null) {
      print('"$texto" → entero: $comoInt');
    } else if (comoDouble != null) {
      print('"$texto" → decimal: $comoDouble');
    } else {
      print('"$texto" → no es un número válido');
    }
  }
  print('');
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 5 — Manipulación de strings
// ─────────────────────────────────────────────────────────────────────────────

/// Ejercicio 5: Operaciones comunes con Strings.
///
/// Dado el texto: "  Aprendiendo Flutter desde cero  "
/// (con espacios al inicio y al final)
/// Realiza estas operaciones y muestra cada resultado:
/// 1. Eliminar espacios al inicio y al final (trim)
/// 2. Convertir a mayúsculas
/// 3. Convertir a minúsculas
/// 4. Contar cuántas letras tiene (sin espacios extremos)
/// 5. Verificar si contiene la palabra "Flutter"
/// 6. Reemplazar "cero" por "profesional"
void ejercicio5() {
  print('--- EJERCICIO 5: Manipulación de Strings ---');

  // Escribe tu solución aquí:
  // ...

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  var texto = '  Aprendiendo Flutter desde cero  ';

  var limpio = texto.trim();
  print('Original: "$texto"');
  print('Sin espacios: "$limpio"');
  print('Mayúsculas: "${limpio.toUpperCase()}"');
  print('Minúsculas: "${limpio.toLowerCase()}"');
  print('Longitud: ${limpio.length} caracteres');
  print('¿Contiene Flutter? ${limpio.contains("Flutter")}');
  print('Reemplazado: "${limpio.replaceAll("cero", "profesional")}"');
}

// =============================================================================
// EXPERIMENTA:
//   1. En el ejercicio 1, agrega más campos: trabajo, hobby, meta de aprendizaje.
//   2. En el ejercicio 4, también verifica si el número es mayor que 10.
//   3. En el ejercicio 5, divide el texto limpio en palabras con .split(' ')
//      e imprime cuántas palabras tiene.
//   4. Crea un ejercicio propio: convierte una temperatura de Celsius a
//      Fahrenheit usando la fórmula F = (C × 9/5) + 32.
//   5. Crea una constante con tu fecha de nacimiento (como String) y
//      calcula cuántos años tienes usando DateTime.
// =============================================================================
