// =============================================================================
// ARCHIVO: 02_comparacion.dart
// TEMA: Operadores de comparación en Dart
// =============================================================================
//
// Los operadores de comparación evalúan dos valores y devuelven un bool.
// En Dart es importante entender la diferencia entre igualdad de VALOR (==)
// e igualdad de REFERENCIA (identical()), especialmente con objetos complejos.
//
// CÓMO EJECUTAR:
//   dart run 02_comparacion.dart
//
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // OPERADORES BÁSICOS: ==, !=, <, >, <=, >=
  // ─────────────────────────────────────────────────────────────────────────

  int x = 10;
  int y = 20;

  print('--- Comparaciones numéricas ---');
  print('x = $x, y = $y');
  print('x == y: ${x == y}');    // false
  print('x != y: ${x != y}');    // true
  print('x < y: ${x < y}');      // true
  print('x > y: ${x > y}');      // false
  print('x <= 10: ${x <= 10}');  // true
  print('y >= 20: ${y >= 20}');  // true

  // ─────────────────────────────────────────────────────────────────────────
  // COMPARAR STRINGS
  // ─────────────────────────────────────────────────────────────────────────

  // En Dart, == compara el contenido de los strings (igual que Python).
  // No es como en Java donde == compara referencias.
  print('\n--- Comparaciones de String ---');
  String a = 'Flutter';
  String b = 'Flutter';
  String c = 'flutter'; // Diferente capitalización

  print('a == b: ${a == b}');   // true (mismo contenido)
  print('a == c: ${a == c}');   // false (mayúsculas importan)

  // Para comparar sin importar mayúsculas, normaliza primero:
  print('ignorar case: ${a.toLowerCase() == c.toLowerCase()}');  // true

  // Comparación lexicográfica (alfabética):
  print('"abc" < "abd": ${"abc" < "abd"}');    // true (c < d)
  print('"z" > "a": ${"z" > "a"}');            // true

  // ─────────────────────────────────────────────────────────────────────────
  // COMPARAR CON NULL
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Comparaciones con null ---');

  String? nombre; // null por defecto
  print('nombre == null: ${nombre == null}');   // true
  print('nombre != null: ${nombre != null}');   // false

  nombre = 'Ana';
  print('nombre == null: ${nombre == null}');   // false
  print('nombre != null: ${nombre != null}');   // true

  // ─────────────────────────────────────────────────────────────────────────
  // identical() — Comparar REFERENCIAS (no contenido)
  // ─────────────────────────────────────────────────────────────────────────

  // identical() devuelve true solo si las dos variables apuntan al MISMO
  // objeto en memoria. Diferente a == que compara el contenido/valor.
  print('\n--- identical() vs == ---');

  // Con Strings: Dart puede reutilizar el mismo objeto para literales iguales.
  // Este comportamiento se llama "string interning".
  const String s1 = 'hola';
  const String s2 = 'hola';
  print('s1 == s2: ${s1 == s2}');             // true (mismo valor)
  print('identical(s1, s2): ${identical(s1, s2)}'); // true (Dart reutiliza)

  // Con listas o mapas, los objetos siempre son distintos aunque tengan
  // el mismo contenido (a menos que sean const):
  var lista1 = [1, 2, 3];
  var lista2 = [1, 2, 3];
  print('\nlista1 == lista2: ${lista1 == lista2}');           // true (mismo contenido)
  print('identical(lista1, lista2): ${identical(lista1, lista2)}'); // false (distintos objetos)

  // Con const, Dart reutiliza el mismo objeto:
  const listaC1 = [1, 2, 3];
  const listaC2 = [1, 2, 3];
  print('identical(const1, const2): ${identical(listaC1, listaC2)}'); // true

  // ─────────────────────────────────────────────────────────────────────────
  // COMPARAR TIPOS: is y is!
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- is y is! ---');

  dynamic valor = 'Soy un texto';
  print('valor is String: ${valor is String}');    // true
  print('valor is int: ${valor is int}');          // false
  print('valor is! int: ${valor is! int}');        // true (negación de is)

  // El operador "is" también funciona con jerarquías de herencia:
  // Si "Gato" extiende "Animal", entonces gato is Animal == true
  // Esto es muy útil en Flutter con widgets y BuildContext.
}

// =============================================================================
// EXPERIMENTA:
//   1. ¿Qué devuelve null == null en Dart? Pruébalo.
//   2. Compara 1 == 1.0 — ¿int y double son iguales en valor?
//   3. Crea dos listas con el mismo contenido. ¿Son == ? ¿Son identical()?
//   4. ¿Qué pasa si usas < entre dos Strings? ¿Funciona? ¿En qué se basa?
//   5. Usa "is" para verificar si una variable dinámica es num
//      (recuerda que num es supertipo de int y double).
// =============================================================================
