import '../../core/utils/text_utils.dart';
import '../../domain/entities/verse.dart';

/// Modelo de datos para la entidad Verse.
///
/// Extiende [Verse] y añade capacidades de serialización/deserialización
/// desde mapas SQLite. Aplica la limpieza de marcas Strong en la
/// construcción desde el mapa, garantizando texto limpio en toda la app.
class VerseModel extends Verse {
  /// Constructor que delega al constructor del padre.
  const VerseModel({
    required super.bookNumber,
    required super.chapter,
    required super.verseNumber,
    required super.text,
    super.bookName,
  });

  // ─── Fábrica desde SQLite ─────────────────────────────────────────────────

  /// Crea un [VerseModel] desde un mapa proveniente de sqflite.
  ///
  /// Limpia automáticamente el texto de marcas Strong durante la construcción.
  ///
  /// [map]: resultado de una fila de la tabla `verses`.
  ///
  /// Esquema esperado:
  /// - `book_number`: INTEGER
  /// - `chapter`: INTEGER
  /// - `verse`: INTEGER
  /// - `text`: TEXT (puede contener marcas Strong como `<S>7225</S>`)
  /// - `long_name` (opcional): TEXT — nombre del libro, incluido en JOINs
  ///
  /// Retorna: instancia de [VerseModel] con texto limpiado.
  factory VerseModel.fromMap(Map<String, dynamic> map) {
    final String rawText = (map['text'] as String?) ?? '';
    return VerseModel(
      bookNumber: (map['book_number'] as int?) ?? 0,
      chapter: (map['chapter'] as int?) ?? 0,
      verseNumber: (map['verse'] as int?) ?? 0,
      text: TextUtils.cleanVerseText(rawText),
      bookName: map['long_name'] as String?,
    );
  }

  // ─── Serialización ────────────────────────────────────────────────────────

  /// Convierte el modelo a un mapa compatible con sqflite.
  ///
  /// Retorna: [Map<String, dynamic>] con las claves de la tabla `verses`.
  Map<String, dynamic> toMap() {
    return {
      'book_number': bookNumber,
      'chapter': chapter,
      'verse': verseNumber,
      'text': text,
    };
  }

  // ─── Conversión a entidad de dominio ──────────────────────────────────────

  /// Convierte el modelo en la entidad pura [Verse] del dominio.
  Verse toEntity() => Verse(
        bookNumber: bookNumber,
        chapter: chapter,
        verseNumber: verseNumber,
        text: text,
        bookName: bookName,
      );
}
