import 'package:flutter/material.dart';

/// Define los temas visual claro y oscuro de la app Biblia RV60.
///
/// Usa Material 3 con una paleta inspirada en pergamino y tinta bíblica:
/// - Claro: fondo pergamino suave, azul marino profundo como color primario.
/// - Oscuro: fondo casi negro, dorado antiguo como acento principal.
class AppTheme {
  AppTheme._(); // Constructor privado: clase de utilidades estática

  // ─── Colores base ─────────────────────────────────────────────────────────

  /// Azul marino profundo — evoca la solemnidad de un texto sagrado
  static const Color _primaryColor = Color(0xFF1A3A5C);

  /// Dorado antiguo — acento para favoritos y elementos destacados
  static const Color _goldColor = Color(0xFFC9A84C);

  /// Fondo crema suave para el tema claro — simula papel envejecido
  static const Color _creamBackground = Color(0xFFF5F0E8);

  // ─── Tema claro ───────────────────────────────────────────────────────────

  /// ThemeData para el modo claro con Material 3.
  ///
  /// Retorna: [ThemeData] configurado con colores de pergamino y azul marino.
  static ThemeData get lightTheme {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.light,
      background: _creamBackground,
      surface: const Color(0xFFFAF6EE),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: _creamBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: const Color(0xFFFAF6EE),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: _primaryColor,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          fontSize: 17,
          height: 1.7,
          color: Color(0xFF2C2C2C),
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          height: 1.6,
          color: Color(0xFF3C3C3C),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _goldColor,
        foregroundColor: Colors.white,
      ),
      iconTheme: const IconThemeData(color: _primaryColor),
    );
  }

  // ─── Tema oscuro ──────────────────────────────────────────────────────────

  /// ThemeData para el modo oscuro con Material 3.
  ///
  /// Retorna: [ThemeData] configurado con fondo oscuro y acento dorado.
  static ThemeData get darkTheme {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: _goldColor,
      brightness: Brightness.dark,
      background: const Color(0xFF121212),
      surface: const Color(0xFF1E1E1E),
      primary: _goldColor,
      onPrimary: Colors.black,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1A1A2E),
        foregroundColor: _goldColor,
        elevation: 2,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: _goldColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: const Color(0xFF1E1E1E),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: _goldColor,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          fontSize: 17,
          height: 1.7,
          color: Color(0xFFE0E0E0),
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          height: 1.6,
          color: Color(0xFFCCCCCC),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _goldColor,
        foregroundColor: Colors.black,
      ),
      iconTheme: const IconThemeData(color: _goldColor),
    );
  }

  /// Color dorado para uso externo (favoritos, íconos especiales)
  static Color get goldAccent => _goldColor;

  /// Color primario para uso externo
  static Color get primary => _primaryColor;
}
