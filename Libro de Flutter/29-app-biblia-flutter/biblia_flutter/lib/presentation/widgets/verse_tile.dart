import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/verse.dart';
import '../providers/favorites_provider.dart';

/// Elemento de lista que representa un versículo bíblico.
///
/// Muestra el número del versículo en negrita y el texto a continuación.
/// Al mantener presionado, aparece un menú contextual para agregar/quitar
/// de favoritos o copiar el texto al portapapeles.
class VerseTile extends StatelessWidget {
  /// Versículo a mostrar
  final Verse verse;

  /// Si es true, muestra también la referencia (libro/capítulo) — útil en búsqueda
  final bool showReference;

  const VerseTile({
    super.key,
    required this.verse,
    this.showReference = false,
  });

  @override
  Widget build(BuildContext context) {
    final favProvider = context.watch<FavoritesProvider>();
    final bool isFav = favProvider.isFavorite(verse);

    return InkWell(
      onLongPress: () => _showContextMenu(context, verse, isFav, favProvider),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVerseNumber(context),
            const SizedBox(width: 10),
            Expanded(child: _buildVerseContent(context, isFav)),
          ],
        ),
      ),
    );
  }

  // ─── Sub-widgets ──────────────────────────────────────────────────────────

  /// Muestra el número del versículo en un bloque compacto de color acento.
  Widget _buildVerseNumber(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '${verse.verseNumber}',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  /// Muestra la referencia (en búsqueda) y el texto del versículo.
  Widget _buildVerseContent(BuildContext context, bool isFav) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showReference) ...[
          Text(
            verse.reference,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 2),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                verse.text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            if (isFav) ...[
              const SizedBox(width: 6),
              const Icon(Icons.star, size: 14, color: Color(0xFFC9A84C)),
            ],
          ],
        ),
      ],
    );
  }

  // ─── Menú contextual ──────────────────────────────────────────────────────

  /// Muestra un menú con opciones para el versículo seleccionado.
  ///
  /// Opciones: agregar/quitar favorito, copiar al portapapeles.
  void _showContextMenu(
    BuildContext context,
    Verse verse,
    bool isFav,
    FavoritesProvider favProvider,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: Icon(
                isFav ? Icons.star : Icons.star_border,
                color: const Color(0xFFC9A84C),
              ),
              title: Text(isFav ? 'Quitar de favoritos' : 'Agregar a favoritos'),
              onTap: () {
                Navigator.pop(context);
                favProvider.toggleFavorite(verse);
              },
            ),
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('Copiar versículo'),
              onTap: () {
                Navigator.pop(context);
                final text = '${verse.text} — ${verse.reference}';
                Clipboard.setData(ClipboardData(text: text));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Versículo copiado')),
                );
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
