import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/verse.dart';
import '../providers/favorites_provider.dart';
import '../widgets/verse_tile.dart';

/// Pantalla que muestra los versículos marcados como favoritos.
///
/// Permite ver y eliminar favoritos. Muestra un estado vacío
/// con mensaje de invitación si el usuario aún no tiene ninguno.
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  // ─── AppBar ───────────────────────────────────────────────────────────────

  /// Construye la barra superior con opción de limpiar todos los favoritos.
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final provider = context.watch<FavoritesProvider>();
    return AppBar(
      title: Text('Favoritos (${provider.count})'),
      actions: [
        if (provider.count > 0)
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'Limpiar todos',
            onPressed: () => _confirmClearAll(context, provider),
          ),
      ],
    );
  }

  // ─── Cuerpo ───────────────────────────────────────────────────────────────

  /// Construye el cuerpo según si hay o no favoritos guardados.
  Widget _buildBody(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;
    if (favorites.isEmpty) return _buildEmptyState(context);
    return _buildFavoritesList(favorites);
  }

  // ─── Estado vacío ─────────────────────────────────────────────────────────

  /// Muestra una pantalla de invitación cuando no hay favoritos.
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_border,
            size: 72,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.25),
          ),
          const SizedBox(height: 16),
          const Text(
            'Aún no tienes favoritos',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            'Mantén presionado cualquier versículo\npara agregarlo aquí.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // ─── Lista de favoritos ───────────────────────────────────────────────────

  /// Construye la lista de versículos favoritos con opción de eliminar.
  ///
  /// [favorites]: lista de versículos guardados como favoritos.
  Widget _buildFavoritesList(List<Verse> favorites) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: favorites.length,
      separatorBuilder: (_, __) => const Divider(height: 1, indent: 16),
      itemBuilder: (context, index) {
        final verse = favorites[index];
        return Dismissible(
          key: Key(verse.favoriteKey),
          direction: DismissDirection.endToStart,
          background: _buildDismissBackground(),
          onDismissed: (_) =>
              context.read<FavoritesProvider>().removeFavorite(verse),
          child: VerseTile(verse: verse, showReference: true),
        );
      },
    );
  }

  /// Fondo rojo que aparece al deslizar un favorito para eliminarlo.
  Widget _buildDismissBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      color: Colors.red.shade400,
      child: const Icon(Icons.delete, color: Colors.white),
    );
  }

  // ─── Diálogo de confirmación ──────────────────────────────────────────────

  /// Solicita confirmación antes de eliminar todos los favoritos.
  Future<void> _confirmClearAll(
    BuildContext context,
    FavoritesProvider provider,
  ) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('¿Limpiar favoritos?'),
        content: const Text(
          'Se eliminarán todos los versículos guardados. Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      for (final verse in List.of(provider.favorites)) {
        await provider.removeFavorite(verse);
      }
    }
  }
}
