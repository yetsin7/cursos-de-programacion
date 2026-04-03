import '../../core/database/database_helper.dart';
import '../../domain/entities/book.dart';
import '../../domain/entities/verse.dart';
import '../../domain/repositories/bible_repository.dart';
import '../models/book_model.dart';
import '../models/verse_model.dart';

/// Implementación concreta de [BibleRepository] usando SQLite.
///
/// Toda la comunicación con la base de datos pasa por [DatabaseHelper].
/// Esta clase convierte los mapas SQLite en entidades de dominio usando
/// los modelos de la capa de datos.
class BibleRepositoryImpl implements BibleRepository {
  /// Instancia del helper de base de datos (singleton)
  final DatabaseHelper _dbHelper;

  /// [dbHelper]: instancia del [DatabaseHelper]. Se inyecta para
  /// facilitar pruebas unitarias con mocks.
  BibleRepositoryImpl({DatabaseHelper? dbHelper})
      : _dbHelper = dbHelper ?? DatabaseHelper();

  // ─── Libros ───────────────────────────────────────────────────────────────

  /// Obtiene los 66 libros ordenados por número de libro.
  @override
  Future<List<Book>> getBooks() async {
    final rows = await _dbHelper.rawQuery(
      'SELECT book_number, short_name, long_name, book_color '
      'FROM books ORDER BY book_number',
    );
    return rows.map((row) => BookModel.fromMap(row)).toList();
  }

  // ─── Capítulos ────────────────────────────────────────────────────────────

  /// Obtiene los números de capítulo distintos de un libro.
  ///
  /// [bookNumber]: número del libro (1-66).
  @override
  Future<List<int>> getChapters(int bookNumber) async {
    final rows = await _dbHelper.rawQuery(
      'SELECT DISTINCT chapter FROM verses '
      'WHERE book_number = ? ORDER BY chapter',
      [bookNumber],
    );
    return rows.map((row) => row['chapter'] as int).toList();
  }

  // ─── Versículos ───────────────────────────────────────────────────────────

  /// Obtiene todos los versículos de un capítulo específico.
  ///
  /// [bookNumber]: número del libro.
  /// [chapter]: número de capítulo.
  @override
  Future<List<Verse>> getVerses(int bookNumber, int chapter) async {
    final rows = await _dbHelper.rawQuery(
      'SELECT v.book_number, v.chapter, v.verse, v.text, b.long_name '
      'FROM verses v '
      'JOIN books b ON v.book_number = b.book_number '
      'WHERE v.book_number = ? AND v.chapter = ? '
      'ORDER BY v.verse',
      [bookNumber, chapter],
    );
    return rows.map((row) => VerseModel.fromMap(row)).toList();
  }

  // ─── Búsqueda ─────────────────────────────────────────────────────────────

  /// Busca versículos que contengan el texto dado en toda la Biblia.
  ///
  /// [query]: texto a buscar. La búsqueda usa LIKE con wildcards en SQLite.
  @override
  Future<List<Verse>> searchVerses(String query) async {
    if (query.trim().isEmpty) return [];
    final rows = await _dbHelper.rawQuery(
      'SELECT v.book_number, v.chapter, v.verse, v.text, b.long_name '
      'FROM verses v '
      'JOIN books b ON v.book_number = b.book_number '
      'WHERE v.text LIKE ? '
      'ORDER BY v.book_number, v.chapter, v.verse '
      'LIMIT 200',
      ['%$query%'],
    );
    return rows.map((row) => VerseModel.fromMap(row)).toList();
  }

  // ─── Versículo aleatorio ──────────────────────────────────────────────────

  /// Obtiene un versículo aleatorio de toda la Biblia usando ORDER BY RANDOM().
  ///
  /// SQLite soporta ORDER BY RANDOM() de forma nativa, lo que es eficiente
  /// para la cantidad de versículos de la Biblia (~31,000).
  @override
  Future<Verse> getRandomVerse() async {
    final rows = await _dbHelper.rawQuery(
      'SELECT v.book_number, v.chapter, v.verse, v.text, b.long_name '
      'FROM verses v '
      'JOIN books b ON v.book_number = b.book_number '
      'ORDER BY RANDOM() LIMIT 1',
    );
    if (rows.isEmpty) {
      // Versículo de respaldo si la BD no está disponible
      return const Verse(
        bookNumber: 43,
        chapter: 3,
        verseNumber: 16,
        text:
            'Porque de tal manera amó Dios al mundo, que ha dado a su Hijo unigénito, '
            'para que todo aquel que en él cree, no se pierda, mas tenga vida eterna.',
        bookName: 'Juan',
      );
    }
    return VerseModel.fromMap(rows.first);
  }
}
