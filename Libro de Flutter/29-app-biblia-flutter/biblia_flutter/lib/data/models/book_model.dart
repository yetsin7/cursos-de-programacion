import '../../domain/entities/book.dart';

/// Modelo de datos para la entidad Book.
///
/// Extiende [Book] y añade capacidades de serialización/deserialización
/// desde mapas SQLite. Sigue el patrón Data Transfer Object (DTO) de
/// Clean Architecture: los modelos viven en la capa de datos, no en el dominio.
class BookModel extends Book {
  /// Constructor que delega al constructor constante del padre.
  const BookModel({
    required super.bookNumber,
    required super.shortName,
    required super.longName,
    required super.bookColor,
  });

  // ─── Fábrica desde SQLite ─────────────────────────────────────────────────

  /// Crea un [BookModel] desde un mapa proveniente de sqflite.
  ///
  /// [map]: resultado de una fila de la tabla `books`.
  ///
  /// Esquema esperado:
  /// - `book_number`: INTEGER
  /// - `short_name`: TEXT
  /// - `long_name`: TEXT
  /// - `book_color`: TEXT (hexadecimal, ej. "#1A3A5C")
  ///
  /// Retorna: instancia de [BookModel] con los valores del mapa.
  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      bookNumber: (map['book_number'] as int?) ?? 0,
      shortName: (map['short_name'] as String?) ?? '',
      longName: (map['long_name'] as String?) ?? '',
      bookColor: (map['book_color'] as String?) ?? '#1A3A5C',
    );
  }

  // ─── Serialización ────────────────────────────────────────────────────────

  /// Convierte el modelo a un mapa compatible con sqflite.
  ///
  /// Retorna: [Map<String, dynamic>] con las claves de la tabla `books`.
  Map<String, dynamic> toMap() {
    return {
      'book_number': bookNumber,
      'short_name': shortName,
      'long_name': longName,
      'book_color': bookColor,
    };
  }

  // ─── Conversión a entidad de dominio ──────────────────────────────────────

  /// Convierte el modelo en la entidad pura [Book] del dominio.
  ///
  /// Aunque BookModel ya extiende Book, este método es útil para
  /// devolver explícitamente el tipo del dominio sin exponer el modelo.
  Book toEntity() => Book(
        bookNumber: bookNumber,
        shortName: shortName,
        longName: longName,
        bookColor: bookColor,
      );
}
