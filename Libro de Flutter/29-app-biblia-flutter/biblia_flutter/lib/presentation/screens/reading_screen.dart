import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/book.dart';
import '../../domain/entities/verse.dart';
import '../providers/bible_provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/verse_tile.dart';

/// Pantalla de lectura de un capítulo bíblico.
///
/// Muestra todos los versículos del capítulo seleccionado en orden.
/// Permite marcar versículos como favoritos y compartir el capítulo completo.
class ReadingScreen extends StatefulWidget {
  /// Libro al que pertenece el capítulo
  final Book book;

  /// Número del capítulo a mostrar
  final int chapter;

  const ReadingScreen({super.key, required this.book, required this.chapter});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<BibleProvider>()
          .loadVerses(widget.book.bookNumber, widget.chapter);
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

  /// Construye la barra superior con título y botón de compartir.
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('${widget.book.longName} ${widget.chapter}'),
      actions: [
        IconButton(
          icon: const Icon(Icons.share),
          tooltip: 'Compartir capítulo',
          onPressed: () => _shareChapter(context),
        ),
      ],
    );
  }

  // ─── Cuerpo ───────────────────────────────────────────────────────────────

  /// Construye el cuerpo según el estado de carga de los versículos.
  Widget _buildBody(BuildContext context) {
    final provider = context.watch<BibleProvider>();
    if (provider.isVersesLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.versesState == LoadingState.error) {
      return _buildErrorState();
    }
    if (provider.verses.isEmpty) {
      return const Center(child: Text('No hay versículos disponibles.'));
    }
    return _buildVersesList(context, provider.verses);
  }

  /// Mensaje de error si no se pudieron cargar los versículos.
  Widget _buildErrorState() {
    return const Center(
      child: Text('Error al cargar los versículos. Intenta de nuevo.'),
    );
  }

  // ─── Lista de versículos ──────────────────────────────────────────────────

  /// Construye la lista de versículos con encabezado del capítulo.
  Widget _buildVersesList(BuildContext context, List<Verse> verses) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 32),
      itemCount: verses.length + 1, // +1 para el encabezado
      itemBuilder: (_, index) {
        if (index == 0) return _buildChapterHeader(context, verses.length);
        return Column(
          children: [
            VerseTile(verse: verses[index - 1]),
            if (index < verses.length) const Divider(height: 1, indent: 16),
          ],
        );
      },
    );
  }

  /// Encabezado del capítulo con el nombre del libro y cantidad de versículos.
  Widget _buildChapterHeader(BuildContext context, int verseCount) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: widget.book.color.withOpacity(0.4),
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 40,
            decoration: BoxDecoration(
              color: widget.book.color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.book.longName} ${widget.chapter}',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 18,
                    ),
              ),
              Text(
                '$verseCount versículos',
                style:
                    const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Compartir ────────────────────────────────────────────────────────────

  /// Comparte el capítulo completo usando el portapapeles del sistema.
  void _shareChapter(BuildContext context) {
    final verses = context.read<BibleProvider>().verses;
    if (verses.isEmpty) return;
    final buffer = StringBuffer();
    buffer.writeln('${widget.book.longName} ${widget.chapter}');
    buffer.writeln('Reina-Valera 1960\n');
    for (final v in verses) {
      buffer.writeln('${v.verseNumber}. ${v.text}');
    }
    Clipboard.setData(ClipboardData(text: buffer.toString()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Capítulo copiado al portapapeles')),
    );
  }
}
