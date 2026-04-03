import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'data/repositories/bible_repository_impl.dart';
import 'domain/usecases/get_books.dart';
import 'domain/usecases/get_chapters.dart';
import 'domain/usecases/get_random_verse.dart';
import 'domain/usecases/get_verses.dart';
import 'domain/usecases/search_verses.dart';
import 'presentation/providers/bible_provider.dart';
import 'presentation/providers/favorites_provider.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/screens/home_screen.dart';

/// Punto de entrada de la app Biblia RV60.
///
/// Inicializa los providers de tema y favoritos antes de mostrar la UI,
/// luego arranca la app con MultiProvider que inyecta todas las
/// dependencias necesarias en el árbol de widgets.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialización de providers que requieren operaciones async antes de la UI
  final ThemeProvider themeProvider = ThemeProvider();
  final FavoritesProvider favoritesProvider = FavoritesProvider();

  await Future.wait([
    themeProvider.init(),
    favoritesProvider.init(),
  ]);

  runApp(
    MultiProvider(
      providers: _buildProviders(themeProvider, favoritesProvider),
      child: const BibliaApp(),
    ),
  );
}

/// Construye la lista de providers con sus dependencias inyectadas.
///
/// Se construye aquí para mantener main() limpio y legible.
/// El repositorio y los casos de uso se crean una sola vez y se
/// inyectan en BibleProvider.
List<ChangeNotifierProvider> _buildProviders(
  ThemeProvider themeProvider,
  FavoritesProvider favoritesProvider,
) {
  // Capa de datos
  final repo = BibleRepositoryImpl();

  // Casos de uso
  final getBooks = GetBooks(repo);
  final getChapters = GetChapters(repo);
  final getVerses = GetVerses(repo);
  final searchVerses = SearchVerses(repo);
  final getRandomVerse = GetRandomVerse(repo);

  return [
    ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
    ChangeNotifierProvider<FavoritesProvider>.value(value: favoritesProvider),
    ChangeNotifierProvider<BibleProvider>(
      create: (_) => BibleProvider(
        getBooks: getBooks,
        getChapters: getChapters,
        getVerses: getVerses,
        searchVerses: searchVerses,
        getRandomVerse: getRandomVerse,
      ),
    ),
  ];
}

/// Widget raíz de la app.
///
/// Escucha a [ThemeProvider] para cambiar el tema en tiempo real
/// sin necesidad de reiniciar la app.
class BibliaApp extends StatelessWidget {
  const BibliaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      title: 'Biblia RV60',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      home: const HomeScreen(),
    );
  }
}
