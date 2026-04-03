import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/book.dart';
import '../providers/bible_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/book_card.dart';
import '../widgets/verse_of_day_card.dart';
import 'chapters_screen.dart';
import 'favorites_screen.dart';
import 'search_screen.dart';

/// Pantalla principal de la app Biblia RV60.
///
/// Muestra el versículo del día, la lista de libros del Antiguo Testamento
/// y la lista de libros del Nuevo Testamento en un ScrollView.
/// Desde aquí el usuario navega a capítulos, búsqueda y favoritos.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Carga de datos inicial de forma diferida para no bloquear el build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<BibleProvider>();
      provider.loadBooks();
      provider.loadRandomVerse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  // ─── AppBar ───────────────────────────────────────────────────────────────

  /// Construye la barra de navegación superior con acciones.
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Biblia RV60'),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Buscar',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SearchScreen()),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.star_border),
          tooltip: 'Favoritos',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FavoritesScreen()),
          ),
        ),
        _buildThemeToggle(context),
      ],
    );
  }

  /// Construye el botón de alternancia de tema claro/oscuro.
  Widget _buildThemeToggle(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return IconButton(
      icon: Icon(
        themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
      ),
      tooltip: themeProvider.isDarkMode ? 'Modo claro' : 'Modo oscuro',
      onPressed: () => themeProvider.toggle(),
    );
  }

  // ─── Cuerpo ───────────────────────────────────────────────────────────────

  /// Construye el cuerpo principal con el estado de la carga.
  Widget _buildBody(BuildContext context) {
    final provider = context.watch<BibleProvider>();
    if (provider.isBooksLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.booksState == LoadingState.error) {
      return _buildError(provider.errorMessage);
    }
    return _buildContent(context, provider);
  }

  /// Construye el mensaje de error cuando falla la carga de libros.
  Widget _buildError(String? message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 12),
          Text(
            'Error al cargar la Biblia.\n¿Está el archivo biblia_rv60.sqlite3 en assets/?',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
          if (message != null) ...[
            const SizedBox(height: 8),
            Text(message,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ],
      ),
    );
  }

  /// Construye el contenido principal: versículo del día + listas de libros.
  Widget _buildContent(BuildContext context, BibleProvider provider) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: VerseOfDayCard()),
        _buildTestamentSection('Antiguo Testamento', provider.oldTestamentBooks),
        _buildTestamentSection('Nuevo Testamento', provider.newTestamentBooks),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }

  // ─── Secciones de testamentos ─────────────────────────────────────────────

  /// Construye una sección con título y cuadrícula de libros.
  ///
  /// [title]: nombre del testamento.
  /// [books]: lista de libros a mostrar.
  Widget _buildTestamentSection(String title, List<Book> books) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(title),
          _buildBooksGrid(books),
        ],
      ),
    );
  }

  /// Encabezado de sección con borde lateral de color acento.
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }

  /// Cuadrícula de tarjetas de libros con 4 columnas.
  Widget _buildBooksGrid(List<Book> books) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: books.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.85,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
        ),
        itemBuilder: (_, index) {
          final book = books[index];
          return BookCard(
            book: book,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChaptersScreen(book: book),
              ),
            ),
          );
        },
      ),
    );
  }
}
