// =============================================================================
// ARCHIVO: 01_aritmeticos.dart
// TEMA: Operadores aritméticos en Dart y la librería dart:math
// =============================================================================
//
// Los operadores aritméticos son los más básicos, pero Dart tiene uno
// especial que no existe en Python de la misma forma: ~/ (división entera).
// También aprenderemos a usar la librería dart:math para operaciones
// matemáticas más avanzadas.
//
// CÓMO EJECUTAR:
//   dart run 01_aritmeticos.dart
//
// =============================================================================

// Importar la librería matemática de Dart para funciones avanzadas.
// dart:math es una librería estándar incluida con Dart — no necesitas instalar nada.
import 'dart:math';

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // OPERADORES BÁSICOS: +, -, *, /
  // ─────────────────────────────────────────────────────────────────────────

  int a = 10;
  int b = 3;

  print('--- Operadores básicos ---');
  print('a = $a, b = $b');
  print('a + b = ${a + b}');    // 13
  print('a - b = ${a - b}');    // 7
  print('a * b = ${a * b}');    // 30

  // IMPORTANTE: En Dart, / SIEMPRE devuelve double, incluso si el resultado
  // es un número entero exacto. Esto difiere de Python 2 (donde / era entero).
  print('a / b = ${a / b}');    // 3.3333... (tipo double)
  print('10 / 2 = ${10 / 2}');  // 5.0 — no 5, sino 5.0 (sigue siendo double)

  // ─────────────────────────────────────────────────────────────────────────
  // DIVISIÓN ENTERA: ~/ (el más especial de Dart)
  // ─────────────────────────────────────────────────────────────────────────

  // ~/ divide y descarta la parte decimal (trunca, no redondea).
  // En Python usarías // para esto.
  // En Dart se usa ~/ y SIEMPRE devuelve int.
  print('\n--- División entera ~/ ---');
  print('10 ~/ 3 = ${10 ~/ 3}');   // 3 (no 3.33, sino 3 exacto)
  print('10 ~/ 2 = ${10 ~/ 2}');   // 5 (tipo int, no double)
  print('7 ~/ 4 = ${7 ~/ 4}');     // 1

  // Comparación directa entre / y ~/:
  print('\n/ vs ~/:');
  print('10 / 3  = ${10 / 3}');    // 3.3333 (double)
  print('10 ~/ 3 = ${10 ~/ 3}');   // 3 (int)

  // ─────────────────────────────────────────────────────────────────────────
  // MÓDULO (RESTO): %
  // ─────────────────────────────────────────────────────────────────────────

  // El operador % devuelve el resto de la división entera.
  // Muy útil para verificar si un número es par/impar, o para ciclos.
  print('\n--- Módulo % ---');
  print('10 % 3 = ${10 % 3}');     // 1 (10 = 3×3 + 1)
  print('15 % 5 = ${15 % 5}');     // 0 (divisible exactamente)
  print('7 % 2 = ${7 % 2}');       // 1 (7 es impar)
  print('8 % 2 = ${8 % 2}');       // 0 (8 es par)

  // Truco para verificar paridad:
  for (int i = 1; i <= 6; i++) {
    String tipo = (i % 2 == 0) ? 'par' : 'impar';
    print('$i es $tipo');
  }

  // ─────────────────────────────────────────────────────────────────────────
  // NEGACIÓN: -x
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Negación ---');
  int positivo = 5;
  int negativo = -positivo; // Invierte el signo
  print('positivo: $positivo, negado: $negativo');

  // ─────────────────────────────────────────────────────────────────────────
  // LIBRERÍA dart:math — Operaciones matemáticas avanzadas
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- dart:math ---');

  // Raíz cuadrada
  print('sqrt(16) = ${sqrt(16)}');        // 4.0
  print('sqrt(2) = ${sqrt(2)}');          // 1.4142...

  // Potencia: pow(base, exponente) — devuelve num
  print('pow(2, 10) = ${pow(2, 10)}');    // 1024
  print('pow(3, 3) = ${pow(3, 3)}');      // 27

  // Valor absoluto (también disponible como método)
  print('abs(-15) = ${-15.abs()}');        // 15
  print('(-3.7).abs() = ${(-3.7).abs()}'); // 3.7

  // Máximo y mínimo entre dos valores
  print('max(5, 9) = ${max(5, 9)}');      // 9
  print('min(5, 9) = ${min(5, 9)}');      // 5

  // Redondeo: round (al más cercano), floor (hacia abajo), ceil (hacia arriba)
  double numero = 3.7;
  print('\nRedondeo de $numero:');
  print('round: ${numero.round()}');      // 4
  print('floor: ${numero.floor()}');      // 3
  print('ceil: ${numero.ceil()}');        // 4

  double numero2 = 3.2;
  print('Redondeo de $numero2:');
  print('round: ${numero2.round()}');     // 3
  print('floor: ${numero2.floor()}');     // 3
  print('ceil: ${numero2.ceil()}');       // 4

  // Constantes matemáticas incluidas en dart:math:
  print('\nConstantes matemáticas:');
  print('pi = $pi');       // 3.14159...
  print('e  = $e');        // 2.71828...
}

// =============================================================================
// EXPERIMENTA:
//   1. ¿Qué pasa con 5 ~/ 0? ¿Y con 5 / 0? Prueba ambos (uno lanza excepción,
//      el otro devuelve Infinity).
//   2. Usa pow() para calcular el cuadrado de los números del 1 al 10.
//   3. Calcula el área de un círculo con radio 7 usando pi de dart:math.
//   4. ¿Cuántos minutos completos hay en 1000 segundos? Usa ~/ y %.
//   5. Genera un número aleatorio con Random() de dart:math:
//      var rng = Random(); print(rng.nextInt(100)); — ¿qué hace nextInt()?
// =============================================================================
