import 'package:flutter/material.dart';

import '../../core/utils/text_utils.dart';

/// Entidad de dominio que representa un libro de la Biblia.
///
/// Es un objeto inmutable que no depende de ninguna capa de datos ni de Flutter
/// (excepto por Color, que es un tipo de valor puro). Sigue el principio de
/// que las entidades del dominio no conocen la infraestructura.
class Book {
  /// Número del libro en el canon bíblico (1 = Génesis, 66 = Apocalipsis)
  final int bookNumber;

  /// Nombre corto para tarjetas y referencias compactas (ej. "Gén")
  final String shortName;

  /// Nombre completo del libro (ej. "Génesis")
  final String longName;

  /// Color hexadecimal asignado al libro en la BD (ej. "#1A3A5C")
  final String bookColor;

  /// Constructor constante para máximo rendimiento al reconstruir listas
  const Book({
    required this.bookNumber,
    required this.shortName,
    required this.longName,
    required this.bookColor,
  });

  // ─── Propiedades derivadas ────────────────────────────────────────────────

  /// Indica si el libro pertenece al Nuevo Testamento (libros 40-66).
  ///
  /// Los primeros 39 libros forman el Antiguo Testamento según el canon protestante.
  bool get isNewTestament => bookNumber > 39;

  /// Indica si el libro pertenece al Antiguo Testamento (libros 1-39).
  bool get isOldTestament => bookNumber <= 39;

  /// Convierte el color hexadecimal de la BD en un objeto Color de Flutter.
  ///
  /// Retorna: [Color] listo para usar en widgets. Si el hex es inválido,
  /// devuelve azul marino por defecto.
  Color get color => Color(TextUtils.hexColorToInt(bookColor));

  // ─── Igualdad ─────────────────────────────────────────────────────────────

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Book &&
          runtimeType == other.runtimeType &&
          bookNumber == other.bookNumber;

  @override
  int get hashCode => bookNumber.hashCode;

  @override
  String toString() => 'Book($bookNumber: $longName)';
}
