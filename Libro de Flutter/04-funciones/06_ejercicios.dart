// =============================================================================
// ARCHIVO: 06_ejercicios.dart
// TEMA: Ejercicios prácticos — Módulo 04: Funciones
// =============================================================================
//
// Ejercicios que combinan todos los temas del módulo: declaración, parámetros,
// retorno, arrow functions, closures y callbacks.
//
// CÓMO EJECUTAR:
//   dart run 06_ejercicios.dart
//
// =============================================================================

void main() {
  print('====== EJERCICIOS — MÓDULO 04: FUNCIONES ======\n');

  ejercicio1();
  ejercicio2();
  ejercicio3();
  ejercicio4();
  ejercicio5();
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 1 — Temperatura en múltiples escalas
// ─────────────────────────────────────────────────────────────────────────────

/// Crea funciones para convertir entre Celsius, Fahrenheit y Kelvin.
/// - celsius a fahrenheit: F = C × 9/5 + 32
/// - fahrenheit a celsius: C = (F - 32) × 5/9
/// - celsius a kelvin: K = C + 273.15
/// Imprime la tabla de 0°C a 100°C cada 20 grados.
void ejercicio1() {
  print('--- EJERCICIO 1: Conversión de temperatura ---');

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  double cToF(double c) => c * 9 / 5 + 32;
  double fToC(double f) => (f - 32) * 5 / 9;
  double cToK(double c) => c + 273.15;

  print('Celsius | Fahrenheit | Kelvin');
  print('--------|------------|-------');
  for (double c = 0; c <= 100; c += 20) {
    print(
      '${c.toStringAsFixed(1).padLeft(7)} | '
      '${cToF(c).toStringAsFixed(1).padLeft(10)} | '
      '${cToK(c).toStringAsFixed(2).padLeft(7)}',
    );
  }

  // Verificar ida y vuelta:
  double original = 37.0;
  double enF = cToF(original);
  double vuelta = fToC(enF);
  print('\n${original}°C → ${enF}°F → ${vuelta.toStringAsFixed(2)}°C');
  print('');
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 2 — Pipeline funcional
// ─────────────────────────────────────────────────────────────────────────────

/// Dado una lista de palabras, aplica en cadena:
/// 1. Filtrar las que tienen más de 4 letras
/// 2. Convertir a mayúsculas
/// 3. Ordenar alfabéticamente
/// 4. Imprimir cada una numerada
/// Usa map(), where(), sort() y forEach() con arrow functions.
void ejercicio2() {
  print('--- EJERCICIO 2: Pipeline funcional ---');

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  var palabras = ['dart', 'flutter', 'ui', 'widget', 'app', 'clase', 'ok',
    'estado', 'build', 'io'];

  var resultado = palabras
      .where((p) => p.length > 4)          // Solo las largas
      .map((p) => p.toUpperCase())          // A mayúsculas
      .toList()..sort();                    // Ordenar (sort modifica in-place)

  for (int i = 0; i < resultado.length; i++) {
    print('${(i + 1).toString().padLeft(2)}. ${resultado[i]}');
  }
  print('');
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 3 — Memoización simple
// ─────────────────────────────────────────────────────────────────────────────

/// Crea una función que "memoize" (cachea) resultados de otra función.
/// Si la función ya fue llamada con el mismo argumento, devuelve el resultado
/// cacheado en lugar de recalcularlo.
/// Prueba con una función que calcula el n-ésimo número de Fibonacci.
void ejercicio3() {
  print('--- EJERCICIO 3: Memoización ---');

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  // El cache es compartido gracias al closure
  Map<int, int> cache = {};

  int fibonacci(int n) {
    if (n <= 1) return n;
    // Si ya calculamos este valor, devolver el cacheado
    if (cache.containsKey(n)) {
      print('  (usando cache para fib($n))');
      return cache[n]!;
    }
    int resultado = fibonacci(n - 1) + fibonacci(n - 2);
    cache[n] = resultado; // Guardar en cache
    return resultado;
  }

  print('Fibonacci(10) = ${fibonacci(10)}');
  print('Fibonacci(10) de nuevo = ${fibonacci(10)}'); // Usa cache
  print('Fibonacci(8) = ${fibonacci(8)}');            // Usa cache parcialmente
  print('');
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 4 — Función de orden superior
// ─────────────────────────────────────────────────────────────────────────────

/// Implementa una función "aplicarATodos" que recibe una lista de números y
/// una función de transformación, y devuelve una nueva lista transformada.
/// Luego úsala con: doblar, triplicar, cuadrado, y una función personalizada.
void ejercicio4() {
  print('--- EJERCICIO 4: Función de orden superior ---');

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  List<int> aplicarATodos(List<int> lista, int Function(int) transformar) {
    return lista.map(transformar).toList();
  }

  var numeros = [1, 2, 3, 4, 5];

  print('Original:  $numeros');
  print('Doblar:    ${aplicarATodos(numeros, (n) => n * 2)}');
  print('Triplicar: ${aplicarATodos(numeros, (n) => n * 3)}');
  print('Cuadrado:  ${aplicarATodos(numeros, (n) => n * n)}');
  print('Sumar 100: ${aplicarATodos(numeros, (n) => n + 100)}');
  print('');
}

// ─────────────────────────────────────────────────────────────────────────────
// EJERCICIO 5 — Validador de formulario
// ─────────────────────────────────────────────────────────────────────────────

/// Crea un sistema de validación usando funciones.
/// Cada validador es una función: String? Function(String?).
/// Devuelve null si es válido, o un mensaje de error si no lo es.
/// Implementa: requerido, minLongitud(n), maxLongitud(n), soloNumeros.
/// Prueba validando un campo de nombre y uno de código postal.
void ejercicio5() {
  print('--- EJERCICIO 5: Validador de formulario ---');

  // ── SOLUCIÓN ──────────────────────────────────────────────────────────────
  typedef Validador = String? Function(String?);

  // Validador: campo obligatorio
  Validador requerido = (valor) =>
    (valor == null || valor.isEmpty) ? 'Este campo es obligatorio' : null;

  // Fábrica de validadores: mínimo de caracteres
  Validador Function(int) minLongitud = (min) =>
    (valor) => (valor != null && valor.length >= min)
      ? null
      : 'Mínimo $min caracteres';

  // Fábrica de validadores: máximo de caracteres
  Validador Function(int) maxLongitud = (max) =>
    (valor) => (valor != null && valor.length <= max)
      ? null
      : 'Máximo $max caracteres';

  // Validador: solo dígitos numéricos
  Validador soloNumeros = (valor) =>
    (valor != null && RegExp(r'^\d+$').hasMatch(valor))
      ? null
      : 'Solo se permiten números';

  // Función que aplica todos los validadores en orden
  String? validar(String? valor, List<Validador> validadores) {
    for (var v in validadores) {
      final error = v(valor);
      if (error != null) return error; // Detener en el primer error
    }
    return null; // Todo válido
  }

  // Probar con distintos valores:
  void probar(String campo, String? valor, List<Validador> validators) {
    final error = validar(valor, validators);
    String display = valor == null ? '(null)' : '"$valor"';
    print('$campo $display → ${error ?? "✓ válido"}');
  }

  print('--- Nombre (requerido, 2-50 chars) ---');
  probar('nombre', null, [requerido, minLongitud(2), maxLongitud(50)]);
  probar('nombre', '', [requerido, minLongitud(2), maxLongitud(50)]);
  probar('nombre', 'A', [requerido, minLongitud(2), maxLongitud(50)]);
  probar('nombre', 'Ana', [requerido, minLongitud(2), maxLongitud(50)]);

  print('\n--- Código postal (requerido, 5 chars, solo números) ---');
  probar('código', null, [requerido, minLongitud(5), maxLongitud(5), soloNumeros]);
  probar('código', '1234', [requerido, minLongitud(5), maxLongitud(5), soloNumeros]);
  probar('código', 'ABCDE', [requerido, minLongitud(5), maxLongitud(5), soloNumeros]);
  probar('código', '12345', [requerido, minLongitud(5), maxLongitud(5), soloNumeros]);
}

// =============================================================================
// EXPERIMENTA:
//   1. En ejercicio 2, agrega un paso que filtre palabras que contengan 'a'.
//   2. En ejercicio 3, aplica memoización a potencia(base, exp) usando Map<String, int>.
//   3. En ejercicio 5, agrega un validador "sinEspacios" que rechace strings
//      con espacios intermedios.
//   4. Crea una función "componerValidadores" que combine dos en uno solo.
//   5. En ejercicio 4, crea una versión que opere sobre List<double> y acepte
//      transformaciones de double → double.
// =============================================================================
