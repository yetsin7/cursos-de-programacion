import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Proveedor de estado para el tema visual de la app.
///
/// Persiste la preferencia del usuario usando [SharedPreferences] para
/// que el tema seleccionado sobreviva al reinicio de la app.
class ThemeProvider extends ChangeNotifier {
  // ─── Constantes ───────────────────────────────────────────────────────────

  /// Clave de SharedPreferences para guardar el modo oscuro
  static const String _themeKey = 'is_dark_mode';

  // ─── Estado ───────────────────────────────────────────────────────────────

  /// Modo de tema actual (system/light/dark)
  ThemeMode _themeMode = ThemeMode.light;

  /// Referencia a SharedPreferences, inicializada en [init]
  SharedPreferences? _prefs;

  // ─── Getters públicos ─────────────────────────────────────────────────────

  /// Modo de tema activo para pasarlo a MaterialApp
  ThemeMode get themeMode => _themeMode;

  /// Indica si el modo oscuro está activo
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // ─── Inicialización ───────────────────────────────────────────────────────

  /// Inicializa el proveedor cargando la preferencia guardada.
  ///
  /// Debe llamarse en el arranque de la app antes de construir la UI.
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final bool isDark = _prefs?.getBool(_themeKey) ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // ─── Acciones ─────────────────────────────────────────────────────────────

  /// Alterna entre modo claro y modo oscuro.
  ///
  /// Persiste la nueva preferencia en SharedPreferences.
  Future<void> toggle() async {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _prefs?.setBool(_themeKey, isDarkMode);
    notifyListeners();
  }

  /// Establece el modo de tema directamente.
  ///
  /// [mode]: modo de tema a aplicar ([ThemeMode.light] o [ThemeMode.dark]).
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    await _prefs?.setBool(_themeKey, mode == ThemeMode.dark);
    notifyListeners();
  }
}
