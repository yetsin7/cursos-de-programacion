import '../repositories/bible_repository.dart';

/// Caso de uso: obtener los capítulos disponibles de un libro.
///
/// Permite que la pantalla de capítulos solicite los números de capítulo
/// sin conocer ningún detalle de la capa de datos.
class GetChapters {
  /// Repositorio del que se obtendrán los capítulos
  final BibleRepository repository;

  /// [repository]: implementación de [BibleRepository] inyectada.
  GetChapters(this.repository);

  /// Ejecuta el caso de uso para un libro específico.
  ///
  /// [bookNumber]: número del libro (1-66).
  ///
  /// Retorna: lista ordenada de enteros con los números de capítulo.
  Future<List<int>> execute(int bookNumber) =>
      repository.getChapters(bookNumber);
}
