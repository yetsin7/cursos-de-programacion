// =============================================================================
// ARCHIVO: 05_ejercicios.dart
// TEMA: Ejercicios prácticos — Módulo 02: Operadores
// =============================================================================
//
// Ejercicios prácticos que combinan todos los operadores del módulo.
// Intenta resolverlos antes de ver las soluciones comentadas.
//
// CÓMO EJECUTAR:
//   dart run 05_ejercicios.dart
//
// =============================================================================

import 'dart:math';

void main() {
  print('====== EJERCICIOS — MÓDULO 02: OPERADORES ======\n');

  ejercicio1();
  ejercicio2();
  ejercicio3();
  ejercicio4();
  ejercicio5();
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 1 — Convertir segundos
// ─────────────────────────────────────────────────────────────────────────────

/// Dado un número de segundos totales, calcula cuántas horas, minutos
/// y segundos restantes tiene.
/// Ejemplo: 3725 segundos → 1 hora, 2 minutos, 5 segundos.
void ejercicio1() {
  print('--- EJERCICIO 1: Convertir segundos ---');

  int totalSegundos = 3725;

  // Escribe tu solución aquí:
  // ...

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  // ~/ da el número de horas completas (3725 ~/ 3600 = 1)
  int horas = totalSegundos ~/ 3600;
  // El resto son los segundos que sobran después de las horas completas
  int restoSegundos = totalSegundos % 3600;
  int minutos = restoSegundos ~/ 60;
  int segundos = restoSegundos % 60;

  print('$totalSegundos segundos = $horas h, $minutos min, $segundos seg');
  print('');
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 2 — Verificar elegibilidad
// ─────────────────────────────────────────────────────────────────────────────

/// Un usuario puede acceder a una función premium si:
/// - Tiene 18 años o más, Y
/// - Está suscrito O tiene puntos >= 100
/// Prueba con tres combinaciones distintas de valores.
void ejercicio2() {
  print('--- EJERCICIO 2: Verificar elegibilidad ---');

  // Escribe tu solución aquí:
  // ...

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  void verificar(int edad, bool suscrito, int puntos) {
    bool esMayorDeEdad = edad >= 18;
    bool tienePremium = suscrito || puntos >= 100;
    bool puedeAcceder = esMayorDeEdad && tienePremium;
    print('Edad: $edad, Suscrito: $suscrito, Puntos: $puntos → '
        '${puedeAcceder ? "✓ ACCESO" : "✗ DENEGADO"}');
  }

  verificar(20, true, 50);   // Mayor, suscrito → acceso
  verificar(17, true, 200);  // Menor → denegado
  verificar(25, false, 150); // Mayor, no suscrito pero 150 pts → acceso
  print('');
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 3 — Calculadora básica
// ─────────────────────────────────────────────────────────────────────────────

/// Crea una función que reciba dos números y un operador (String: "+", "-",
/// "*", "/", "~/", "%") y devuelva el resultado como String.
/// Si el operador no es reconocido, devuelve "Operador inválido".
void ejercicio3() {
  print('--- EJERCICIO 3: Calculadora básica ---');

  // Escribe tu solución aquí:
  // ...

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  String calcular(num a, num b, String op) {
    return switch (op) {
      '+' => '$a $op $b = ${a + b}',
      '-' => '$a $op $b = ${a - b}',
      '*' => '$a $op $b = ${a * b}',
      // Prevenir división por cero antes de operar
      '/' when b != 0 => '$a $op $b = ${a / b}',
      '/' => 'Error: división por cero',
      '~/' when b != 0 => '$a $op $b = ${a ~/ b}',
      '~/' => 'Error: división por cero',
      '%' => '$a $op $b = ${a % b}',
      _ => 'Operador inválido: $op',
    };
  }

  print(calcular(10, 3, '+'));
  print(calcular(10, 3, '-'));
  print(calcular(10, 3, '*'));
  print(calcular(10, 3, '/'));
  print(calcular(10, 3, '~/'));
  print(calcular(10, 3, '%'));
  print(calcular(10, 0, '/'));
  print(calcular(10, 3, '^'));
  print('');
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 4 — Tabla de valores con ??=
// ─────────────────────────────────────────────────────────────────────────────

/// Tienes un mapa de configuración con algunas claves faltantes (null).
/// Usa ??= para establecer valores por defecto solo para las que son null.
/// Luego imprime el mapa completo.
void ejercicio4() {
  print('--- EJERCICIO 4: Valores por defecto con ??= ---');

  // Escribe tu solución aquí:
  // ...

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  Map<String, String?> config = {
    'idioma': 'es',
    'tema': null,         // Faltante — debe usar valor por defecto
    'fuente': null,       // Faltante — debe usar valor por defecto
    'region': 'NI',
    'moneda': null,       // Faltante — debe usar valor por defecto
  };

  // Asignar valores por defecto solo donde hay null:
  config['tema'] ??= 'claro';
  config['fuente'] ??= 'Roboto';
  config['moneda'] ??= 'USD';

  // 'idioma' y 'region' ya tenían valor → ??= no los cambia
  config['idioma'] ??= 'en';  // No cambia: ya era 'es'
  config['region'] ??= 'US';  // No cambia: ya era 'NI'

  print('Configuración final:');
  config.forEach((clave, valor) => print('  $clave: $valor'));
  print('');
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 5 — Distancia euclidiana
// ─────────────────────────────────────────────────────────────────────────────

/// Calcula la distancia euclidiana entre dos puntos (x1,y1) y (x2,y2).
/// Fórmula: sqrt((x2-x1)² + (y2-y1)²)
/// Usa pow() y sqrt() de dart:math.
/// Redondea el resultado a 2 decimales.
void ejercicio5() {
  print('--- EJERCICIO 5: Distancia euclidiana ---');

  // Escribe tu solución aquí:
  // ...

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  double distancia(double x1, double y1, double x2, double y2) {
    // pow() devuelve num, se castea a double para el cálculo
    double dx = pow(x2 - x1, 2).toDouble();
    double dy = pow(y2 - y1, 2).toDouble();
    return sqrt(dx + dy);
  }

  double d1 = distancia(0, 0, 3, 4);
  print('Distancia (0,0)→(3,4): ${d1.toStringAsFixed(2)}');   // 5.00

  double d2 = distancia(1, 1, 4, 5);
  print('Distancia (1,1)→(4,5): ${d2.toStringAsFixed(2)}');   // 5.00

  double d3 = distancia(0, 0, 1, 1);
  print('Distancia (0,0)→(1,1): ${d3.toStringAsFixed(2)}');   // 1.41
}

// =============================================================================
// EXPERIMENTA:
//   1. En el ejercicio 1, convierte también a días: ¿cuántos días hay en
//      100000 segundos?
//   2. En el ejercicio 3, agrega el operador "^" para potencia usando pow().
//   3. En el ejercicio 5, crea una función que calcule la distancia Manhattan:
//      |x2-x1| + |y2-y1| usando .abs().
//   4. Crea un contador de palabras: dado un texto, cuenta cuántas palabras
//      tiene usando .split(' ').length.
//   5. Usa el operador % para imprimir todos los múltiplos de 7 entre 1 y 100.
// =============================================================================
