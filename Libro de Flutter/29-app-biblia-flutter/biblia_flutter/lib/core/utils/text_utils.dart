/// Utilidades de texto para la app Biblia RV60.
///
/// Provee funciones estáticas para limpiar y formatear el texto bíblico.
/// La base de datos RV60 contiene marcas Strong como `<S>7225</S>` que
/// son referencias léxicas y no deben mostrarse al usuario.
class TextUtils {
  TextUtils._(); // Constructor privado: clase de utilidades estática

  // ─── RegExp compilados una sola vez ───────────────────────────────────────

  /// Expresión regular para encontrar marcas Strong del tipo <S>NÚMERO</S>
  static final RegExp _strongMarkup = RegExp(r'<S>\d+</S>');

  /// Expresión regular para encontrar múltiples espacios consecutivos
  static final RegExp _multipleSpaces = RegExp(r'  +');

  // ─── Funciones públicas ───────────────────────────────────────────────────

  /// Limpia un versículo eliminando todas las marcas Strong y espacios extra.
  ///
  /// Las marcas Strong son etiquetas como `<S>7225</S>` insertadas por editores
  /// bíblicos para relacionar palabras con el diccionario léxico. Son útiles
  /// en herramientas de estudio, pero deben ocultarse en la lectura normal.
  ///
  /// [text]: texto crudo proveniente de la base de datos.
  ///
  /// Retorna: texto limpio, sin marcas Strong ni espacios innecesarios.
  ///
  /// Ejemplo:
  /// ```dart
  /// cleanVerseText('En el principio<S>7225</S> creó<S>1254</S> Dios')
  /// // → 'En el principio creó Dios'
  /// ```
  static String cleanVerseText(String text) {
    return text
        .replaceAll(_strongMarkup, '')
        .replaceAll(_multipleSpaces, ' ')
        .trim();
  }

  /// Formatea una referencia bíblica como "Génesis 1:1".
  ///
  /// [bookName]: nombre del libro (largo o corto, según contexto).
  /// [chapter]: número de capítulo.
  /// [verse]: número de versículo.
  ///
  /// Retorna: cadena formateada "Libro Capítulo:Versículo".
  ///
  /// Ejemplo:
  /// ```dart
  /// formatReference('Juan', 3, 16) // → 'Juan 3:16'
  /// ```
  static String formatReference(String bookName, int chapter, int verse) {
    return '$bookName $chapter:$verse';
  }

  /// Formatea una referencia bíblica usando solo capítulo y versículo.
  ///
  /// Útil cuando el nombre del libro ya está visible en la pantalla.
  ///
  /// [chapter]: número de capítulo.
  /// [verse]: número de versículo.
  ///
  /// Retorna: cadena "Capítulo:Versículo".
  static String formatChapterVerse(int chapter, int verse) {
    return '$chapter:$verse';
  }

  /// Convierte un color hexadecimal de texto a un entero ARGB para Flutter.
  ///
  /// [hex]: cadena hexadecimal con o sin '#', ejemplo '#1A3A5C' o '1A3A5C'.
  ///
  /// Retorna: entero ARGB completo con opacidad total (0xFF + hex).
  /// Si el formato es inválido, devuelve azul marino por defecto.
  static int hexColorToInt(String hex) {
    final String clean = hex.replaceAll('#', '').trim();
    if (clean.length == 6) {
      return int.tryParse('FF$clean', radix: 16) ?? 0xFF1A3A5C;
    }
    if (clean.length == 8) {
      return int.tryParse(clean, radix: 16) ?? 0xFF1A3A5C;
    }
    return 0xFF1A3A5C;
  }
}
