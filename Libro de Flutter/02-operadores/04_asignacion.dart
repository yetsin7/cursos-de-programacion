// =============================================================================
// ARCHIVO: 04_asignacion.dart
// TEMA: Operadores de asignación en Dart
// =============================================================================
//
// Más allá del simple "=", Dart tiene operadores de asignación compuestos
// que combinan una operación aritmética con la asignación. El más especial
// es ??= que solo asigna si la variable es null — muy usado en Flutter.
//
// CÓMO EJECUTAR:
//   dart run 04_asignacion.dart
//
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // ASIGNACIÓN BÁSICA: =
  // ─────────────────────────────────────────────────────────────────────────

  int contador = 0;
  String nombre = 'Flutter';
  bool activo = true;

  print('--- Asignación básica ---');
  print('contador: $contador, nombre: $nombre, activo: $activo');

  // ─────────────────────────────────────────────────────────────────────────
  // ASIGNACIONES COMPUESTAS: +=, -=, *=, /=, ~/=, %=
  // ─────────────────────────────────────────────────────────────────────────

  // Cada operador compuesto es un atajo de escritura.
  // a += b es exactamente igual a a = a + b
  print('\n--- Asignaciones compuestas ---');

  int valor = 10;
  print('valor inicial: $valor');

  valor += 5;   // valor = valor + 5 = 15
  print('después de += 5: $valor');

  valor -= 3;   // valor = valor - 3 = 12
  print('después de -= 3: $valor');

  valor *= 2;   // valor = valor * 2 = 24
  print('después de *= 2: $valor');

  // /= siempre devuelve double, igual que /
  double dValor = valor.toDouble();
  dValor /= 4;   // dValor = dValor / 4 = 6.0
  print('después de /= 4: $dValor');

  int iValor = 25;
  iValor ~/= 4;  // iValor = iValor ~/ 4 = 6 (división entera)
  print('25 ~/= 4 = $iValor');

  iValor %= 4;   // iValor = iValor % 4 = 2 (6 % 4 = 2)
  print('después de %= 4: $iValor');

  // También funciona con strings (+=):
  String texto = 'Hola';
  texto += ', Flutter';  // texto = texto + ', Flutter'
  texto += '!';
  print('texto concatenado: $texto');

  // ─────────────────────────────────────────────────────────────────────────
  // INCREMENTO Y DECREMENTO: ++ y --
  // ─────────────────────────────────────────────────────────────────────────

  // ++ suma 1 a la variable. -- resta 1.
  // Existen en versión prefija (++x) y posfija (x++).
  // La diferencia importa cuando se usan como expresión dentro de otra operación.
  print('\n--- Incremento y decremento ---');

  int i = 5;
  i++;  // equivalente a i += 1
  print('i después de i++: $i');  // 6

  i--;  // equivalente a i -= 1
  print('i después de i--: $i');  // 5

  // Diferencia entre ++x (prefijo) y x++ (posfijo):
  // ++x incrementa PRIMERO, luego devuelve el nuevo valor.
  // x++ devuelve el valor ACTUAL, luego incrementa.
  int a = 10;
  print('\nPrefijo vs Posfijo:');
  print('a = $a');
  print('en expresión con a++: ${a++}');  // imprime 10 (el valor antes del ++)
  print('ahora a = $a');                   // ahora a = 11

  int b = 10;
  print('b = $b');
  print('en expresión con ++b: ${++b}');  // imprime 11 (el valor después del ++)
  print('ahora b = $b');                   // b = 11

  // ─────────────────────────────────────────────────────────────────────────
  // ??= — ASIGNACIÓN CONDICIONAL NULL (exclusivo de Dart)
  // ─────────────────────────────────────────────────────────────────────────

  // ??= asigna un valor a la variable SOLO si la variable es null.
  // Si ya tiene un valor (no null), no hace nada.
  // Es muy común en Flutter para inicializar valores perezosamente.
  print('\n--- ??= (asignación si null) ---');

  String? apodo;
  print('apodo antes de ??=: $apodo');  // null

  apodo ??= 'Flutterista';  // apodo es null → se asigna
  print('apodo después de ??=: $apodo');  // Flutterista

  apodo ??= 'Otro nombre';  // apodo YA tiene valor → NO se asigna
  print('apodo después del segundo ??=: $apodo');  // Flutterista (no cambió)

  // Comparación: ??= vs if-null manual:
  // Con ??=:
  String? ciudad;
  ciudad ??= 'Managua';

  // Equivalente con if:
  // if (ciudad == null) {
  //   ciudad = 'Managua';
  // }

  print('\nciudad: $ciudad');

  // ─────────────────────────────────────────────────────────────────────────
  // ?? — OPERADOR NULL-COALESCING (para leer, no para asignar)
  // ─────────────────────────────────────────────────────────────────────────

  // ?? devuelve el valor de la izquierda si no es null,
  // o el valor de la derecha si ES null. No modifica la variable original.
  print('\n--- ?? (null-coalescing) ---');

  String? usuario;
  String nombreMostrar = usuario ?? 'Invitado';
  print('nombreMostrar: $nombreMostrar');  // Invitado (usuario era null)

  usuario = 'María';
  nombreMostrar = usuario ?? 'Invitado';
  print('nombreMostrar: $nombreMostrar');  // María (usuario ya tiene valor)
}

// =============================================================================
// EXPERIMENTA:
//   1. Usa ??= para inicializar una lista solo si es null.
//      Llama el bloque dos veces. ¿La lista se reinicia en el segundo llamado?
//   2. Simula un contador de puntaje con +=. Suma 10 puntos por acierto,
//      resta 5 por error, durante 5 rondas.
//   3. ¿Cuál es la diferencia entre  a = a ?? 'default'  y  a ??= 'default' ?
//      Son equivalentes? Compruébalo.
//   4. Usa el operador ++ en un bucle for sin escribir i = i + 1.
//   5. Crea una variable String? y usa ?? para mostrar un valor por defecto
//      en lugar del null. ¿Cuándo usarías ?? vs ??= ?
// =============================================================================
