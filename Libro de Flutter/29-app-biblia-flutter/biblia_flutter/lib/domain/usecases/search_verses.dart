import '../entities/verse.dart';
import '../repositories/bible_repository.dart';

/// Caso de uso: buscar versículos por texto en toda la Biblia.
///
/// Valida que la consulta tenga al menos 2 caracteres antes de consultar
/// el repositorio, evitando búsquedas vacías que devuelven toda la BD.
class SearchVerses {
  /// Repositorio donde se realizará la búsqueda
  final BibleRepository repository;

  /// [repository]: implementación de [BibleRepository] inyectada.
  SearchVerses(this.repository);

  /// Ejecuta la búsqueda de versículos.
  ///
  /// [query]: texto a buscar (mínimo 2 caracteres).
  ///
  /// Retorna: lista de [Verse] con resultados. Lista vacía si la consulta
  /// es muy corta o no hay resultados.
  Future<List<Verse>> execute(String query) {
    if (query.trim().length < 2) return Future.value([]);
    return repository.searchVerses(query.trim());
  }
}
