import '../entities/book.dart';
import '../repositories/bible_repository.dart';

/// Caso de uso: obtener todos los libros de la Biblia.
///
/// Encapsula la lógica de negocio para recuperar el catálogo completo
/// de libros. Siguiendo Clean Architecture, la pantalla llama al
/// caso de uso, no al repositorio directamente.
class GetBooks {
  /// Repositorio del que se obtendrán los libros
  final BibleRepository repository;

  /// [repository]: implementación de [BibleRepository] inyectada.
  GetBooks(this.repository);

  /// Ejecuta el caso de uso.
  ///
  /// Retorna: lista de 66 [Book] ordenados del 1 al 66.
  Future<List<Book>> execute() => repository.getBooks();
}
