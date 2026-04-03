// =============================================================================
// ARCHIVO: 03_bucle_for.dart
// TEMA: Bucle for en Dart — clásico, for-in, forEach e iteración de colecciones
// =============================================================================
//
// El bucle for en Dart tiene varias formas. El "for-in" es el más idiomático
// para recorrer colecciones (equivalente al "for" de Python sobre listas).
// forEach es funcional y muy usado con lambdas. Conocer cuándo usar cada
// uno mejora la legibilidad del código.
//
// CÓMO EJECUTAR:
//   dart run 03_bucle_for.dart
//
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // FOR CLÁSICO — Cuando necesitas el índice
  // ─────────────────────────────────────────────────────────────────────────

  // Estructura: for (inicialización; condición; incremento)
  // Úsalo cuando necesitas el índice o un contador explícito.
  print('--- For clásico ---');
  for (int i = 0; i < 5; i++) {
    print('Iteración $i');
  }

  // Contar hacia atrás:
  print('\nCuenta regresiva:');
  for (int i = 5; i >= 1; i--) {
    print('$i...');
  }
  print('¡Despegue!');

  // Saltar de a pasos de 2:
  print('\nNúmeros pares del 0 al 10:');
  for (int i = 0; i <= 10; i += 2) {
    print(i);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // FOR-IN — Iterar sobre cualquier Iterable (la forma más idiomática)
  // ─────────────────────────────────────────────────────────────────────────

  // for (var elemento in colección) es equivalente al "for x in lista" de Python.
  // Úsalo cuando no necesitas el índice — es más limpio y claro.
  print('\n--- For-in ---');

  List<String> frutas = ['mango', 'banano', 'papaya', 'guayaba'];
  for (var fruta in frutas) {
    print('Fruta: $fruta');
  }

  // Iterar sobre un Set:
  Set<int> numeros = {10, 20, 30, 40, 50};
  for (var numero in numeros) {
    print('Número: $numero');
  }

  // Iterar sobre un rango con Iterable.generate() o usando for clásico:
  // No existe range() como en Python, pero se puede simular:
  var rango = Iterable.generate(5, (i) => i + 1); // genera 1, 2, 3, 4, 5
  print('\nRango generado:');
  for (var n in rango) {
    print(n);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // FOREACH — Estilo funcional con lambdas
  // ─────────────────────────────────────────────────────────────────────────

  // forEach recibe una función que se ejecuta para cada elemento.
  // Es más conciso pero no permite break/continue dentro.
  print('\n--- forEach ---');

  List<String> lenguajes = ['Dart', 'Python', 'Kotlin', 'Swift'];
  lenguajes.forEach((lenguaje) {
    print('Lenguaje: $lenguaje');
  });

  // Con arrow function (aún más conciso cuando es una sola línea):
  lenguajes.forEach((l) => print('  → $l'));

  // ─────────────────────────────────────────────────────────────────────────
  // ITERAR SOBRE UN MAP — Claves, valores y entradas
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Iterar sobre Map ---');

  Map<String, int> edades = {
    'Ana': 28,
    'Luis': 34,
    'María': 22,
  };

  // Iterar sobre las entradas (clave + valor):
  for (var entrada in edades.entries) {
    print('${entrada.key} tiene ${entrada.value} años');
  }

  // Iterar solo sobre las claves:
  print('\nSolo claves:');
  for (var clave in edades.keys) {
    print(clave);
  }

  // Iterar solo sobre los valores:
  print('\nSolo valores:');
  for (var valor in edades.values) {
    print(valor);
  }

  // forEach en Map con la clave y valor directamente:
  print('\nforEach en Map:');
  edades.forEach((nombre, edad) => print('$nombre → $edad'));

  // ─────────────────────────────────────────────────────────────────────────
  // FOR CLÁSICO vs FOR-IN — Cuándo usar cada uno
  // ─────────────────────────────────────────────────────────────────────────

  List<String> colores = ['rojo', 'verde', 'azul'];

  // For clásico: cuando necesitas el índice
  print('\n--- For clásico con índice ---');
  for (int i = 0; i < colores.length; i++) {
    print('[$i] ${colores[i]}');
  }

  // For-in: cuando solo necesitas el elemento
  print('\n--- For-in (sin índice) ---');
  for (var color in colores) {
    print('Color: $color');
  }

  // Alternativa elegante con asMap() cuando necesitas índice en for-in:
  print('\n--- For-in con índice usando asMap() ---');
  for (var entrada in colores.asMap().entries) {
    print('[${entrada.key}] ${entrada.value}');
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Crea un for que imprima la tabla de multiplicar del 7 (7×1 hasta 7×12).
//   2. Usa for-in para sumar todos los números en una lista de enteros.
//   3. Itera un Map de precios e imprime solo los que cuestan más de 100.
//   4. ¿Puedes usar break dentro de un forEach? ¿Y en un for-in?
//      Intenta ambos y observa la diferencia.
//   5. Genera una lista de 10 números aleatorios y recórrela con forEach
//      imprimiendo solo los pares.
// =============================================================================
