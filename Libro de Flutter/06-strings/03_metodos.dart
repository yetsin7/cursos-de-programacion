// =============================================================================
// ARCHIVO: 03_metodos.dart
// TEMA: Métodos principales del tipo String en Dart
// =============================================================================
//
// Dart proporciona una API rica para manipular strings. Este archivo recorre
// los métodos más usados en el desarrollo cotidiano: transformación de caso,
// búsqueda, división, reemplazo, relleno y comparación.
//
// CÓMO EJECUTAR:
//   dart run 03_metodos.dart
//
// =============================================================================

/// Imprime un encabezado de sección para organizar la salida en consola.
void seccion(String titulo) {
  print('\n── $titulo ──');
}

void main() {
  // ────────────────────────────────────────────────────────────────────────────
  // 1. TRANSFORMACIÓN DE CASO Y ESPACIOS
  // ────────────────────────────────────────────────────────────────────────────
  seccion('Caso y espacios');

  String texto = '  Hola, Mundo Flutter!  ';

  print(texto.toLowerCase());   // '  hola, mundo flutter!  '
  print(texto.toUpperCase());   // '  HOLA, MUNDO FLUTTER!  '
  print(texto.trim());          // 'Hola, Mundo Flutter!'  (ambos lados)
  print(texto.trimLeft());      // 'Hola, Mundo Flutter!  ' (solo izquierda)
  print(texto.trimRight());     // '  Hola, Mundo Flutter!' (solo derecha)

  // ────────────────────────────────────────────────────────────────────────────
  // 2. BÚSQUEDA: contains, startsWith, endsWith
  // ────────────────────────────────────────────────────────────────────────────
  seccion('Búsqueda booleana');

  String frase = 'El rápido zorro marrón salta sobre el perro perezoso';

  print(frase.contains('zorro'));         // true
  print(frase.contains('gato'));          // false
  print(frase.startsWith('El'));          // true
  print(frase.startsWith('el'));          // false (case-sensitive)
  print(frase.endsWith('perezoso'));      // true

  // startsWith acepta posición inicial opcional
  print(frase.startsWith('rápido', 3));  // true (busca desde índice 3)

  // ────────────────────────────────────────────────────────────────────────────
  // 3. BÚSQUEDA DE POSICIÓN: indexOf, lastIndexOf
  // ────────────────────────────────────────────────────────────────────────────
  seccion('indexOf / lastIndexOf');

  String cadena = 'abcabcabc';

  print(cadena.indexOf('b'));         // 1  (primera ocurrencia)
  print(cadena.lastIndexOf('b'));     // 7  (última ocurrencia)
  print(cadena.indexOf('b', 2));      // 4  (busca desde posición 2)
  print(cadena.indexOf('z'));         // -1 (no encontrado)

  // ────────────────────────────────────────────────────────────────────────────
  // 4. DIVISIÓN Y UNIÓN: split, join
  // ────────────────────────────────────────────────────────────────────────────
  seccion('split / join');

  String csv = 'manzana,naranja,pera,uva';

  // split devuelve List<String>
  List<String> frutas = csv.split(',');
  print(frutas);           // [manzana, naranja, pera, uva]
  print(frutas.length);    // 4

  // join une una lista de strings con un separador
  String reunida = frutas.join(' | ');
  print(reunida);          // manzana | naranja | pera | uva

  // split con string vacío divide en caracteres individuales
  List<String> letras = 'Dart'.split('');
  print(letras);           // [D, a, r, t]

  // ────────────────────────────────────────────────────────────────────────────
  // 5. REEMPLAZO: replaceAll, replaceFirst
  // ────────────────────────────────────────────────────────────────────────────
  seccion('replaceAll / replaceFirst');

  String original = 'el gato y el gato duermen';

  // replaceAll reemplaza TODAS las ocurrencias
  print(original.replaceAll('gato', 'perro'));
  // 'el perro y el perro duermen'

  // replaceFirst reemplaza SOLO la primera ocurrencia
  print(original.replaceFirst('gato', 'perro'));
  // 'el perro y el gato duermen'

  // replaceFirst con startIndex: empieza a buscar desde esa posición
  print(original.replaceFirst('gato', 'perro', 10));
  // 'el gato y el perro duermen'

  // También acepta RegExp para reemplazos con patrones
  String con = 'abc123def456';
  print(con.replaceAll(RegExp(r'\d+'), '#'));
  // 'abc#def#'

  // ────────────────────────────────────────────────────────────────────────────
  // 6. SUBCADENAS: substring
  // ────────────────────────────────────────────────────────────────────────────
  seccion('substring');

  String lenguaje = 'DartFlutter';

  // substring(inicio) hasta el final
  print(lenguaje.substring(4));      // Flutter

  // substring(inicio, fin) — fin es exclusivo
  print(lenguaje.substring(0, 4));   // Dart
  print(lenguaje.substring(4, 11));  // Flutter

  // ────────────────────────────────────────────────────────────────────────────
  // 7. RELLENO: padLeft, padRight
  // ────────────────────────────────────────────────────────────────────────────
  seccion('padLeft / padRight');

  String numero = '42';

  // padLeft rellena a la izquierda hasta alcanzar la longitud deseada
  print(numero.padLeft(6));        // '    42' (rellena con espacios)
  print(numero.padLeft(6, '0'));   // '000042' (rellena con '0')

  // padRight rellena a la derecha
  print(numero.padRight(6, '-'));  // '42----'

  // Útil para tablas alineadas en consola
  for (int i = 1; i <= 5; i++) {
    print('Ítem ${i.toString().padLeft(2, '0')}: ${'*' * i}');
  }

  // ────────────────────────────────────────────────────────────────────────────
  // 8. COMPARACIÓN: == y compareTo
  // ────────────────────────────────────────────────────────────────────────────
  seccion('Comparación');

  String s1 = 'manzana';
  String s2 = 'manzana';
  String s3 = 'naranja';

  // == compara contenido (no referencia), case-sensitive
  print(s1 == s2);  // true
  print(s1 == s3);  // false

  // compareTo sigue el orden lexicográfico Unicode
  // Retorna: 0 si iguales, negativo si s1 < s3, positivo si s1 > s3
  print(s1.compareTo(s2));  // 0
  print(s1.compareTo(s3));  // negativo ('m' < 'n')
  print(s3.compareTo(s1));  // positivo ('n' > 'm')

  // Para comparar sin distinción de mayúsculas/minúsculas:
  String a = 'Flutter';
  String b = 'flutter';
  print(a.toLowerCase() == b.toLowerCase()); // true
}

// EXPERIMENTA:
//   - Usa replaceAll con RegExp(r'\s+') para colapsar múltiples espacios en uno
//   - Implementa una función titleCase(String s) usando split, map y join
//   - Prueba padLeft para formatear una tabla de precios con decimales alineados
//   - Verifica qué devuelve 'abc'.indexOf('') — el resultado puede sorprenderte
