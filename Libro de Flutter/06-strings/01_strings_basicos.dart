// =============================================================================
// ARCHIVO: 01_strings_basicos.dart
// TEMA: Strings básicos en Dart
// =============================================================================
//
// Exploración de los fundamentos del tipo String en Dart: cómo crearlos,
// sus distintas formas literales, propiedades básicas y operaciones
// de concatenación e interpolación simple.
//
// CÓMO EJECUTAR:
//   dart run 01_strings_basicos.dart
//
// =============================================================================

void main() {
  // ────────────────────────────────────────────────────────────────────────────
  // 1. FORMAS DE CREAR STRINGS
  // ────────────────────────────────────────────────────────────────────────────

  // Comillas simples y dobles son equivalentes en Dart
  String conSimples = 'Hola, mundo';
  String conDobles = "Hola, mundo";

  print('¿Son iguales? ${conSimples == conDobles}'); // true

  // Útil mezclar cuando el texto contiene comillas
  String cita = 'Ella dijo "hola" y se fue.';
  String codigo = "Es el operador '??' de null-aware";
  print(cita);
  print(codigo);

  // ────────────────────────────────────────────────────────────────────────────
  // 2. RAW STRINGS (r'...')
  // ────────────────────────────────────────────────────────────────────────────

  // Sin raw: las secuencias \n, \t, etc. se interpretan como caracteres especiales
  String conEscape = 'Primera línea\nSegunda línea\tcon tabulación';
  print(conEscape);

  // Con raw (prefijo r): la barra invertida se trata como carácter literal
  String rawString = r'Primera línea\nSegunda línea\tcon tabulación';
  print(rawString); // Imprime todo en una línea, con \n y \t literales

  // Muy útil para rutas de Windows y expresiones regulares
  String rutaWindows = r'C:\Users\Yetsin\Documents';
  String regexDigitos = r'\d+\.\d+'; // Patrón: uno o más dígitos, punto, dígitos
  print('Ruta: $rutaWindows');
  print('Regex: $regexDigitos');

  // ────────────────────────────────────────────────────────────────────────────
  // 3. STRINGS MULTILÍNEA (triple comilla)
  // ────────────────────────────────────────────────────────────────────────────

  // Con triple comilla simple
  String poema = '''
Línea uno del poema,
línea dos con acento,
línea tres.''';

  print(poema);

  // Con triple comilla doble (equivalente)
  String json = """
{
  "nombre": "Ana",
  "edad": 30
}""";

  print(json);

  // ────────────────────────────────────────────────────────────────────────────
  // 4. LONGITUD Y ACCESO POR ÍNDICE
  // ────────────────────────────────────────────────────────────────────────────

  String palabra = 'Flutter';

  // .length devuelve el número de unidades de código UTF-16
  print('Longitud: ${palabra.length}'); // 7

  // Acceso por índice: devuelve un String de un carácter
  print('Primer carácter: ${palabra[0]}');  // F
  print('Último carácter: ${palabra[palabra.length - 1]}'); // r

  // Advertencia: con emojis, .length puede sorprender
  String emoji = '😀';
  print('Longitud del emoji: ${emoji.length}'); // 2 (par sustituto UTF-16)

  // ────────────────────────────────────────────────────────────────────────────
  // 5. isEmpty E isNotEmpty
  // ────────────────────────────────────────────────────────────────────────────

  String vacio = '';
  String noVacio = 'algo';

  // Siempre preferir isEmpty sobre == '' para mayor claridad
  print('¿Vacío? ${vacio.isEmpty}');       // true
  print('¿No vacío? ${noVacio.isNotEmpty}'); // true

  // ────────────────────────────────────────────────────────────────────────────
  // 6. CONCATENACIÓN CON + Y CON INTERPOLACIÓN
  // ────────────────────────────────────────────────────────────────────────────

  String nombre = 'Dart';
  String version = '3';

  // Concatenación con operador +
  String conPlus = 'Lenguaje: ' + nombre + ' versión ' + version;
  print(conPlus);

  // Interpolación con $ (forma idiomática y preferida en Dart)
  String conInterpolacion = 'Lenguaje: $nombre versión $version';
  print(conInterpolacion);

  // Dart también permite yuxtaponer literales de string (sin operador)
  String concatenadaLiteral = 'Hola, '
      'este es un string '
      'dividido en varias líneas de código.';
  print(concatenadaLiteral);

  // Para construir muchos strings dinámicos, StringBuffer es más eficiente
  StringBuffer sb = StringBuffer();
  for (int i = 1; i <= 3; i++) {
    sb.write('Elemento $i  ');
  }
  print(sb.toString());
}

// EXPERIMENTA:
//   - Cambia 'Flutter' por una palabra con ñ o tilde y observa .length
//   - Agrega un emoji dentro de un string multilínea
//   - Compara el rendimiento de + vs StringBuffer con muchas concatenaciones
//   - Prueba r'\n' dentro de un print() y verifica que no hace salto de línea
