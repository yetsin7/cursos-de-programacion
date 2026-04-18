// =============================================================================
// ARCHIVO: 01_aritmeticos.dart
// TEMA: Operadores aritmeticos en Dart
// EJECUCION: dart run 01_aritmeticos.dart
// =============================================================================
//
// Este archivo explica como Dart calcula resultados numericos.
// Cada operacion toma valores, genera un resultado y ese resultado puede
// imprimirse, guardarse o usarse dentro de otra expresion.
// =============================================================================

// Importar dart:math permite usar funciones matematicas mas avanzadas.
import 'dart:math';

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // OPERADORES BASICOS: +, -, *, /
  // ─────────────────────────────────────────────────────────────────────────

  int a = 10;
  int b = 3;

  print('--- Operadores básicos ---');
  print('a = $a, b = $b');
  print('a + b = ${a + b}');    // 13
  print('a - b = ${a - b}');    // 7
  print('a * b = ${a * b}');    // 30

  // IMPORTANTE:
  // En Dart, / siempre devuelve double, incluso si el resultado es exacto.
  print('a / b = ${a / b}');    // 3.3333... (tipo double)
  print('10 / 2 = ${10 / 2}');  // 5.0 — no 5, sino 5.0 (sigue siendo double)

  // ─────────────────────────────────────────────────────────────────────────
  // DIVISION ENTERA: ~/
  // ─────────────────────────────────────────────────────────────────────────

  // ~/ divide y descarta la parte decimal.
  // En Dart, este operador devuelve int.
  print('\n--- División entera ~/ ---');
  print('10 ~/ 3 = ${10 ~/ 3}');   // 3 (no 3.33, sino 3 exacto)
  print('10 ~/ 2 = ${10 ~/ 2}');   // 5 (tipo int, no double)
  print('7 ~/ 4 = ${7 ~/ 4}');     // 1

  // Comparacion directa entre / y ~/
  print('\n/ vs ~/:');
  print('10 / 3  = ${10 / 3}');    // 3.3333 (double)
  print('10 ~/ 3 = ${10 ~/ 3}');   // 3 (int)

  // ─────────────────────────────────────────────────────────────────────────
  // MODULO (RESTO): %
  // ─────────────────────────────────────────────────────────────────────────

  // % devuelve el sobrante de la division entera.
  // Es muy util para paridad, divisibilidad y ciclos.
  print('\n--- Módulo % ---');
  print('10 % 3 = ${10 % 3}');     // 1 (10 = 3×3 + 1)
  print('15 % 5 = ${15 % 5}');     // 0 (divisible exactamente)
  print('7 % 2 = ${7 % 2}');       // 1 (7 es impar)
  print('8 % 2 = ${8 % 2}');       // 0 (8 es par)

  // Un uso clasico es detectar si un numero es par o impar.
  for (int i = 1; i <= 6; i++) {
    String tipo = (i % 2 == 0) ? 'par' : 'impar';
    print('$i es $tipo');
  }

  // ─────────────────────────────────────────────────────────────────────────
  // NEGACION: -x
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Negación ---');
  int positivo = 5;
  int negativo = -positivo; // Invierte el signo
  print('positivo: $positivo, negado: $negativo');

  // ─────────────────────────────────────────────────────────────────────────
  // LIBRERIA dart:math
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- dart:math ---');

  // Raiz cuadrada
  print('sqrt(16) = ${sqrt(16)}');        // 4.0
  print('sqrt(2) = ${sqrt(2)}');          // 1.4142...

  // Potencia: pow(base, exponente)
  print('pow(2, 10) = ${pow(2, 10)}');    // 1024
  print('pow(3, 3) = ${pow(3, 3)}');      // 27

  // Valor absoluto
  print('abs(-15) = ${-15.abs()}');        // 15
  print('(-3.7).abs() = ${(-3.7).abs()}'); // 3.7

  // Maximo y minimo entre dos valores
  print('max(5, 9) = ${max(5, 9)}');      // 9
  print('min(5, 9) = ${min(5, 9)}');      // 5

  // Redondeo: round, floor y ceil
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

  // Constantes matematicas incluidas en dart:math
  print('\nConstantes matemáticas:');
  print('pi = $pi');       // 3.14159...
  print('e  = $e');        // 2.71828...
}

// =============================================================================
// QUE DEBERIAS ENTENDER AL TERMINAR
// - / y ~/ no hacen lo mismo.
// - % ayuda mucho con divisibilidad y paridad.
// - dart:math agrega funciones listas para usar.
// - El resultado de una operacion puede cambiar de tipo.
//
// PRACTICA GUIADA
// 1. Prueba 5 ~/ 0 y 5 / 0.
// 2. Usa pow() para elevar numeros del 1 al 5 al cuadrado.
// 3. Calcula el area de un circulo de radio 7.
// 4. Calcula cuantos minutos completos hay en 1000 segundos con ~/ y %.
// =============================================================================
