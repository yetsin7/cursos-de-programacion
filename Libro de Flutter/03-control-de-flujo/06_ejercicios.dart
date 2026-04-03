// =============================================================================
// ARCHIVO: 06_ejercicios.dart
// TEMA: Ejercicios prácticos — Módulo 03: Control de flujo
// =============================================================================
//
// Ejercicios que combinan if/else, switch, for, while, break y continue.
// Intenta resolverlos antes de ver las soluciones comentadas.
//
// CÓMO EJECUTAR:
//   dart run 06_ejercicios.dart
//
// =============================================================================

void main() {
  print('====== EJERCICIOS — MÓDULO 03: CONTROL DE FLUJO ======\n');

  ejercicio1();
  ejercicio2();
  ejercicio3();
  ejercicio4();
  ejercicio5();
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 1 — FizzBuzz (clásico de entrevistas)
// ─────────────────────────────────────────────────────────────────────────────

/// Para cada número del 1 al 30:
/// - Si es divisible por 3 y por 5: imprime "FizzBuzz"
/// - Si es divisible solo por 3: imprime "Fizz"
/// - Si es divisible solo por 5: imprime "Buzz"
/// - Si no: imprime el número
void ejercicio1() {
  print('--- EJERCICIO 1: FizzBuzz ---');

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  // IMPORTANTE: verificar divisible por 3 Y 5 PRIMERO (orden importa)
  for (int i = 1; i <= 30; i++) {
    if (i % 3 == 0 && i % 5 == 0) {
      print('FizzBuzz');
    } else if (i % 3 == 0) {
      print('Fizz');
    } else if (i % 5 == 0) {
      print('Buzz');
    } else {
      print(i);
    }
  }
  print('');
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 2 — Número primo
// ─────────────────────────────────────────────────────────────────────────────

/// Escribe una función que determine si un número es primo.
/// Un número primo es divisible solo por 1 y por sí mismo.
/// Pruébala con: 2, 7, 10, 13, 25, 97.
void ejercicio2() {
  print('--- EJERCICIO 2: Número primo ---');

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  bool esPrimo(int n) {
    if (n < 2) return false;
    // Solo necesitamos verificar hasta la raíz cuadrada de n.
    // Si n tiene un divisor > sqrt(n), el otro divisor < sqrt(n) ya fue visto.
    for (int i = 2; i * i <= n; i++) {
      if (n % i == 0) return false; // Encontró divisor → no es primo
    }
    return true;
  }

  for (int n in [2, 7, 10, 13, 25, 97]) {
    print('$n es primo: ${esPrimo(n)}');
  }
  print('');
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 3 — Suma con while
// ─────────────────────────────────────────────────────────────────────────────

/// Encuentra la suma acumulada de 1 + 2 + 3 + ... hasta que la suma
/// supere 100. Imprime cuántos números necesitaste sumar y la suma final.
void ejercicio3() {
  print('--- EJERCICIO 3: Suma acumulada ---');

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  int suma = 0;
  int n = 0;

  while (suma <= 100) {
    n++;
    suma += n;
  }

  print('Se necesitaron $n números');
  print('Suma final: $suma (1 + 2 + ... + $n)');
  print('');
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 4 — Clasificador con switch expression
// ─────────────────────────────────────────────────────────────────────────────

/// Dado un código de estado HTTP, devuelve una descripción en español:
/// 200: "OK — Éxito"
/// 201: "Creado"
/// 400: "Solicitud incorrecta"
/// 401: "No autorizado"
/// 403: "Prohibido"
/// 404: "No encontrado"
/// 500: "Error interno del servidor"
/// Otro: "Código desconocido: XXX"
/// Prueba con varios códigos.
void ejercicio4() {
  print('--- EJERCICIO 4: Códigos HTTP ---');

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  String describirHttp(int codigo) {
    return switch (codigo) {
      200 => 'OK — Éxito',
      201 => 'Creado',
      400 => 'Solicitud incorrecta',
      401 => 'No autorizado',
      403 => 'Prohibido',
      404 => 'No encontrado',
      500 => 'Error interno del servidor',
      _ => 'Código desconocido: $codigo',
    };
  }

  for (int codigo in [200, 201, 401, 404, 500, 418]) {
    print('HTTP $codigo → ${describirHttp(codigo)}');
  }
  print('');
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 5 — Pirámide de asteriscos
// ─────────────────────────────────────────────────────────────────────────────

/// Imprime una pirámide de asteriscos de altura N.
/// Para N = 5, la salida debe ser:
///     *
///    ***
///   *****
///  *******
/// *********
void ejercicio5() {
  print('--- EJERCICIO 5: Pirámide ---');

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  void piramide(int altura) {
    for (int fila = 1; fila <= altura; fila++) {
      // Espacios a la izquierda: decrece con cada fila
      int espacios = altura - fila;
      // Asteriscos: crece de 1 a 2*altura-1 (siempre impares)
      int asteriscos = 2 * fila - 1;

      String linea = ' ' * espacios + '*' * asteriscos;
      print(linea);
    }
  }

  piramide(5);
}

// =============================================================================
// EXPERIMENTA:
//   1. Modifica FizzBuzz para que también imprima "Dart" en múltiplos de 7.
//   2. Lista todos los primos entre 1 y 100. ¿Cuántos son?
//   3. Modifica la pirámide para que sea invertida (de ancho a estrecho).
//   4. Agrega al clasificador HTTP rangos: 2xx = éxito, 4xx = cliente, 5xx = servidor.
//   5. Crea una función que genere los primeros N números de la secuencia
//      de Fibonacci usando while.
// =============================================================================
