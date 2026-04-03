import '../entities/verse.dart';
import '../repositories/bible_repository.dart';

/// Caso de uso: obtener un versículo aleatorio para el "versículo del día".
///
/// Proporciona una interfaz limpia para que la presentación solicite
/// un versículo nuevo sin acoplarse a la implementación de la BD.
class GetRandomVerse {
  /// Repositorio del que se obtendrá el versículo aleatorio
  final BibleRepository repository;

  /// [repository]: implementación de [BibleRepository] inyectada.
  GetRandomVerse(this.repository);

  /// Ejecuta el caso de uso.
  ///
  /// Retorna: un [Verse] aleatorio con su referencia completa (incluye bookName).
  Future<Verse> execute() => repository.getRandomVerse();
}
