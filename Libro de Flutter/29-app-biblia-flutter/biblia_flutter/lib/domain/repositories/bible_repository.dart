import '../entities/book.dart';
import '../entities/verse.dart';

/// Contrato abstracto del repositorio bíblico.
///
/// Define la interfaz que la capa de datos debe implementar. Esto permite
/// que la capa de dominio y la presentación no dependan de ninguna
/// implementación concreta (sqflite, API, mock, etc.).
///
/// Sigue el principio de Inversión de Dependencias (D de SOLID).
abstract class BibleRepository {
  /// Obtiene la lista completa de los 66 libros de la Biblia.
  ///
  /// Los libros vienen ordenados por [Book.bookNumber] de 1 a 66.
  ///
  /// Retorna: lista de [Book] con todos los libros del canon bíblico.
  Future<List<Book>> getBooks();

  /// Obtiene los números de capítulo disponibles para un libro específico.
  ///
  /// [bookNumber]: número del libro (1-66).
  ///
  /// Retorna: lista ordenada de enteros con los números de capítulo.
  /// Ejemplo: [1, 2, 3, ..., 50] para Génesis.
  Future<List<int>> getChapters(int bookNumber);

  /// Obtiene todos los versículos de un capítulo específico.
  ///
  /// [bookNumber]: número del libro (1-66).
  /// [chapter]: número del capítulo.
  ///
  /// Retorna: lista de [Verse] ordenada por número de versículo.
  Future<List<Verse>> getVerses(int bookNumber, int chapter);

  /// Busca versículos que contengan el texto indicado en toda la Biblia.
  ///
  /// La búsqueda no distingue mayúsculas/minúsculas (LIKE en SQLite).
  ///
  /// [query]: texto a buscar (mínimo recomendado: 3 caracteres).
  ///
  /// Retorna: lista de [Verse] con todos los resultados encontrados,
  /// incluyendo el nombre del libro para mostrar la referencia completa.
  Future<List<Verse>> searchVerses(String query);

  /// Obtiene un versículo aleatorio de toda la Biblia.
  ///
  /// Útil para el "versículo del día" en la pantalla principal.
  ///
  /// Retorna: un [Verse] aleatorio con su referencia completa.
  Future<Verse> getRandomVerse();
}
