import '../../core/utils/text_utils.dart';

/// Entidad de dominio que representa un versículo bíblico.
///
/// El texto almacenado en esta entidad ya está limpio de marcas Strong.
/// La limpieza se realiza en la capa de datos (repositorio), garantizando
/// que la capa de presentación siempre reciba texto listo para mostrar.
class Verse {
  /// Número del libro al que pertenece el versículo (1-66)
  final int bookNumber;

  /// Número de capítulo dentro del libro
  final int chapter;

  /// Número de versículo dentro del capítulo
  final int verseNumber;

  /// Texto del versículo ya limpiado de marcas Strong y espacios extra
  final String text;

  /// Nombre del libro (opcional, rellenado al hacer JOIN o búsquedas)
  final String? bookName;

  /// Constructor constante para máximo rendimiento al reconstruir listas
  const Verse({
    required this.bookNumber,
    required this.chapter,
    required this.verseNumber,
    required this.text,
    this.bookName,
  });

  // ─── Propiedades derivadas ────────────────────────────────────────────────

  /// Genera la referencia formateada si el nombre del libro está disponible.
  ///
  /// Ejemplo: "Juan 3:16" o "3:16" si bookName es nulo.
  String get reference {
    if (bookName != null) {
      return TextUtils.formatReference(bookName!, chapter, verseNumber);
    }
    return TextUtils.formatChapterVerse(chapter, verseNumber);
  }

  /// Genera una clave única para guardar/identificar favoritos.
  ///
  /// Formato: "LIBRO-CAPITULO-VERSICULO" (ej. "43-3-16")
  String get favoriteKey => '$bookNumber-$chapter-$verseNumber';

  // ─── Igualdad ─────────────────────────────────────────────────────────────

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Verse &&
          runtimeType == other.runtimeType &&
          bookNumber == other.bookNumber &&
          chapter == other.chapter &&
          verseNumber == other.verseNumber;

  @override
  int get hashCode =>
      bookNumber.hashCode ^ chapter.hashCode ^ verseNumber.hashCode;

  @override
  String toString() => 'Verse($bookNumber:$chapter:$verseNumber)';
}
