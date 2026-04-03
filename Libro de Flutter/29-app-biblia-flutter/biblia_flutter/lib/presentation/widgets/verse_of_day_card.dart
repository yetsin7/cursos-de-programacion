import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/verse.dart';
import '../providers/bible_provider.dart';

/// Tarjeta que muestra el versículo del día en la pantalla principal.
///
/// Presenta un versículo aleatorio con su referencia y un botón para
/// obtener otro. El diseño usa un gradiente que evoca papel sagrado.
class VerseOfDayCard extends StatelessWidget {
  const VerseOfDayCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BibleProvider>();
    final Verse? verse = provider.randomVerse;

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: _buildGradient(context),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: verse == null
              ? _buildLoadingState(context)
              : _buildVerseContent(context, verse, provider),
        ),
      ),
    );
  }

  // ─── Gradiente de fondo ───────────────────────────────────────────────────

  /// Construye el gradiente de fondo de la tarjeta según el tema actual.
  BoxDecoration _buildGradient(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [const Color(0xFF1A1A2E), const Color(0xFF2D2D44)]
            : [const Color(0xFF1A3A5C), const Color(0xFF2C5F8A)],
      ),
    );
  }

  // ─── Estado de carga ──────────────────────────────────────────────────────

  /// Muestra un indicador mientras se carga el versículo aleatorio.
  Widget _buildLoadingState(BuildContext context) {
    return const SizedBox(
      height: 80,
      child: Center(
        child: CircularProgressIndicator(color: Colors.white54),
      ),
    );
  }

  // ─── Contenido del versículo ──────────────────────────────────────────────

  /// Construye el contenido principal con el versículo y su referencia.
  Widget _buildVerseContent(
    BuildContext context,
    Verse verse,
    BibleProvider provider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 12),
        _buildVerseText(verse),
        const SizedBox(height: 12),
        _buildFooter(verse, provider),
      ],
    );
  }

  /// Construye el encabezado con ícono y etiqueta "Versículo del día".
  Widget _buildHeader() {
    return Row(
      children: [
        const Icon(Icons.auto_awesome, color: Color(0xFFC9A84C), size: 20),
        const SizedBox(width: 8),
        Text(
          'Versículo del día',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 13,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  /// Construye el texto del versículo con tipografía serif suave.
  Widget _buildVerseText(Verse verse) {
    return Text(
      '"${verse.text}"',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        height: 1.6,
        fontStyle: FontStyle.italic,
      ),
      maxLines: 6,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Construye el pie con la referencia y el botón para obtener otro versículo.
  Widget _buildFooter(Verse verse, BibleProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '— ${verse.reference}',
          style: const TextStyle(
            color: Color(0xFFC9A84C),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.refresh, color: Colors.white70, size: 20),
          tooltip: 'Otro versículo',
          onPressed: () => provider.loadRandomVerse(),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}
