import 'package:flutter/material.dart';

import '../../domain/entities/book.dart';
import '../../domain/entities/verse.dart';
import '../../domain/usecases/get_books.dart';
import '../../domain/usecases/get_chapters.dart';
import '../../domain/usecases/get_random_verse.dart';
import '../../domain/usecases/get_verses.dart';
import '../../domain/usecases/search_verses.dart';

/// Estados posibles de carga para la UI
enum LoadingState { idle, loading, success, error }

/// Proveedor central de estado para todos los datos bíblicos.
///
/// Gestiona: lista de libros, capítulos del libro seleccionado, versículos
/// del capítulo actual, resultados de búsqueda y versículo del día.
/// Notifica a los widgets suscritos cuando cambia cualquier estado.
class BibleProvider extends ChangeNotifier {
  // ─── Casos de uso ─────────────────────────────────────────────────────────

  final GetBooks _getBooks;
  final GetChapters _getChapters;
  final GetVerses _getVerses;
  final SearchVerses _searchVerses;
  final GetRandomVerse _getRandomVerse;

  /// Constructor con inyección de todos los casos de uso necesarios.
  BibleProvider({
    required GetBooks getBooks,
    required GetChapters getChapters,
    required GetVerses getVerses,
    required SearchVerses searchVerses,
    required GetRandomVerse getRandomVerse,
  })  : _getBooks = getBooks,
        _getChapters = getChapters,
        _getVerses = getVerses,
        _searchVerses = searchVerses,
        _getRandomVerse = getRandomVerse;

  // ─── Estado ───────────────────────────────────────────────────────────────

  List<Book> _books = [];
  List<int> _chapters = [];
  List<Verse> _verses = [];
  List<Verse> _searchResults = [];
  Verse? _randomVerse;

  LoadingState _booksState = LoadingState.idle;
  LoadingState _versesState = LoadingState.idle;
  LoadingState _searchState = LoadingState.idle;

  String? _errorMessage;

  // ─── Getters públicos ─────────────────────────────────────────────────────

  List<Book> get books => _books;
  List<Book> get oldTestamentBooks =>
      _books.where((b) => b.isOldTestament).toList();
  List<Book> get newTestamentBooks =>
      _books.where((b) => b.isNewTestament).toList();
  List<int> get chapters => _chapters;
  List<Verse> get verses => _verses;
  List<Verse> get searchResults => _searchResults;
  Verse? get randomVerse => _randomVerse;

  LoadingState get booksState => _booksState;
  LoadingState get versesState => _versesState;
  LoadingState get searchState => _searchState;

  bool get isBooksLoading => _booksState == LoadingState.loading;
  bool get isVersesLoading => _versesState == LoadingState.loading;
  bool get isSearching => _searchState == LoadingState.loading;

  String? get errorMessage => _errorMessage;

  // ─── Acciones ─────────────────────────────────────────────────────────────

  /// Carga la lista completa de libros de la Biblia.
  ///
  /// Se llama una sola vez al iniciar la pantalla principal.
  Future<void> loadBooks() async {
    _booksState = LoadingState.loading;
    _errorMessage = null;
    notifyListeners();
    try {
      _books = await _getBooks.execute();
      _booksState = LoadingState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _booksState = LoadingState.error;
    }
    notifyListeners();
  }

  /// Carga los capítulos de un libro específico.
  ///
  /// [bookNumber]: número del libro seleccionado por el usuario.
  Future<void> loadChapters(int bookNumber) async {
    _chapters = await _getChapters.execute(bookNumber);
    notifyListeners();
  }

  /// Carga los versículos de un capítulo específico.
  ///
  /// [bookNumber]: número del libro.
  /// [chapter]: número del capítulo.
  Future<void> loadVerses(int bookNumber, int chapter) async {
    _versesState = LoadingState.loading;
    _verses = [];
    notifyListeners();
    try {
      _verses = await _getVerses.execute(bookNumber, chapter);
      _versesState = LoadingState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _versesState = LoadingState.error;
    }
    notifyListeners();
  }

  /// Busca versículos por texto en toda la Biblia.
  ///
  /// [query]: texto ingresado por el usuario en el buscador.
  Future<void> search(String query) async {
    if (query.trim().length < 2) {
      _searchResults = [];
      _searchState = LoadingState.idle;
      notifyListeners();
      return;
    }
    _searchState = LoadingState.loading;
    notifyListeners();
    try {
      _searchResults = await _searchVerses.execute(query);
      _searchState = LoadingState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _searchState = LoadingState.error;
    }
    notifyListeners();
  }

  /// Obtiene un nuevo versículo aleatorio para mostrar en la pantalla principal.
  Future<void> loadRandomVerse() async {
    try {
      _randomVerse = await _getRandomVerse.execute();
      notifyListeners();
    } catch (_) {
      // Silencioso: si falla, no se muestra el versículo del día
    }
  }

  /// Limpia los resultados de búsqueda cuando el usuario cierra el buscador.
  void clearSearch() {
    _searchResults = [];
    _searchState = LoadingState.idle;
    notifyListeners();
  }
}
