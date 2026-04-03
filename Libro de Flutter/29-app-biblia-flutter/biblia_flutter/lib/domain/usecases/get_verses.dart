import '../entities/verse.dart';
import '../repositories/bible_repository.dart';

/// Caso de uso: obtener los versículos de un capítulo específico.
///
/// Abstrae el origen de los datos (SQLite, API, caché) del widget de lectura.
class GetVerses {
  /// Repositorio del que se obtendrán los versículos
  final BibleRepository repository;

  /// [repository]: implementación de [BibleRepository] inyectada.
  GetVerses(this.repository);

  /// Ejecuta el caso de uso para un libro y capítulo específicos.
  ///
  /// [bookNumber]: número del libro (1-66).
  /// [chapter]: número del capítulo.
  ///
  /// Retorna: lista de [Verse] ordenada por número de versículo.
  Future<List<Verse>> execute(int bookNumber, int chapter) =>
      repository.getVerses(bookNumber, chapter);
}
