import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/verse.dart';

/// Modelo serializable de un favorito para almacenamiento en JSON.
class _FavoriteEntry {
  final String key;
  final int bookNumber;
  final int chapter;
  final int verseNumber;
  final String text;
  final String bookName;

  _FavoriteEntry({
    required this.key,
    required this.bookNumber,
    required this.chapter,
    required this.verseNumber,
    required this.text,
    required this.bookName,
  });

  /// Deserializa desde mapa JSON
  factory _FavoriteEntry.fromJson(Map<String, dynamic> json) =>
      _FavoriteEntry(
        key: json['key'] as String,
        bookNumber: json['bookNumber'] as int,
        chapter: json['chapter'] as int,
        verseNumber: json['verseNumber'] as int,
        text: json['text'] as String,
        bookName: json['bookName'] as String,
      );

  /// Serializa a mapa JSON
  Map<String, dynamic> toJson() => {
        'key': key,
        'bookNumber': bookNumber,
        'chapter': chapter,
        'verseNumber': verseNumber,
        'text': text,
        'bookName': bookName,
      };

  /// Convierte a entidad [Verse] de dominio
  Verse toVerse() => Verse(
        bookNumber: bookNumber,
        chapter: chapter,
        verseNumber: verseNumber,
        text: text,
        bookName: bookName,
      );
}

/// Proveedor de estado para los versículos favoritos del usuario.
///
/// Persiste los favoritos como JSON en [SharedPreferences] para que
/// sobrevivan al reinicio de la app. Usa la clave [Verse.favoriteKey]
/// como identificador único de cada favorito.
class FavoritesProvider extends ChangeNotifier {
  // ─── Constantes ───────────────────────────────────────────────────────────

  /// Clave de SharedPreferences para la lista de favoritos
  static const String _favoritesKey = 'verse_favorites';

  // ─── Estado ───────────────────────────────────────────────────────────────

  /// Mapa de favoritos: clave → entrada serializable
  final Map<String, _FavoriteEntry> _favorites = {};

  SharedPreferences? _prefs;

  // ─── Getters públicos ─────────────────────────────────────────────────────

  /// Lista de versículos favoritos como entidades de dominio
  List<Verse> get favorites =>
      _favorites.values.map((e) => e.toVerse()).toList();

  /// Número de favoritos guardados
  int get count => _favorites.length;

  // ─── Inicialización ───────────────────────────────────────────────────────

  /// Carga los favoritos persistidos al arrancar la app.
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final String? raw = _prefs?.getString(_favoritesKey);
    if (raw != null) {
      final List decoded = jsonDecode(raw) as List;
      for (final item in decoded) {
        final entry = _FavoriteEntry.fromJson(item as Map<String, dynamic>);
        _favorites[entry.key] = entry;
      }
    }
    notifyListeners();
  }

  // ─── Consultas ────────────────────────────────────────────────────────────

  /// Indica si un versículo está en favoritos.
  ///
  /// [verse]: versículo a verificar.
  bool isFavorite(Verse verse) => _favorites.containsKey(verse.favoriteKey);

  // ─── Acciones ─────────────────────────────────────────────────────────────

  /// Agrega un versículo a favoritos y persiste el cambio.
  ///
  /// [verse]: versículo a guardar como favorito.
  Future<void> addFavorite(Verse verse) async {
    _favorites[verse.favoriteKey] = _FavoriteEntry(
      key: verse.favoriteKey,
      bookNumber: verse.bookNumber,
      chapter: verse.chapter,
      verseNumber: verse.verseNumber,
      text: verse.text,
      bookName: verse.bookName ?? '',
    );
    await _persist();
    notifyListeners();
  }

  /// Elimina un versículo de favoritos y persiste el cambio.
  ///
  /// [verse]: versículo a eliminar de favoritos.
  Future<void> removeFavorite(Verse verse) async {
    _favorites.remove(verse.favoriteKey);
    await _persist();
    notifyListeners();
  }

  /// Alterna el estado de favorito de un versículo.
  ///
  /// Si está en favoritos lo elimina, si no, lo agrega.
  Future<void> toggleFavorite(Verse verse) async {
    isFavorite(verse) ? await removeFavorite(verse) : await addFavorite(verse);
  }

  // ─── Persistencia ─────────────────────────────────────────────────────────

  /// Guarda la lista actual de favoritos en SharedPreferences como JSON.
  Future<void> _persist() async {
    final List<Map<String, dynamic>> list =
        _favorites.values.map((e) => e.toJson()).toList();
    await _prefs?.setString(_favoritesKey, jsonEncode(list));
  }
}
