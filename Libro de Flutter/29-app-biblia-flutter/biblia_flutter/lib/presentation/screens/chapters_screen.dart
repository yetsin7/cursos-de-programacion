import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/book.dart';
import '../providers/bible_provider.dart';
import 'reading_screen.dart';

/// Pantalla de selección de capítulo de un libro bíblico.
///
/// Muestra una cuadrícula de botones con los números de capítulo
/// disponibles para el libro recibido como parámetro.
class ChaptersScreen extends StatefulWidget {
  /// Libro cuyo listado de capítulos se mostrará
  final Book book;

  const ChaptersScreen({super.key, required this.book});

  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BibleProvider>().loadChapters(widget.book.bookNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.book.longName)),
      body: _buildBody(context),
    );
  }

  // ─── Cuerpo ───────────────────────────────────────────────────────────────

  /// Construye el contenido principal según el estado de carga.
  Widget _buildBody(BuildContext context) {
    final provider = context.watch<BibleProvider>();
    final chapters = provider.chapters;

    if (chapters.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBookHeader(),
        Expanded(child: _buildChaptersGrid(context, chapters)),
      ],
    );
  }

  // ─── Encabezado del libro ─────────────────────────────────────────────────

  /// Muestra el nombre largo del libro y cuántos capítulos tiene.
  Widget _buildBookHeader() {
    return Container(
      width: double.infinity,
      color: widget.book.color.withOpacity(0.15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.book.longName,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            widget.book.isNewTestament ? 'Nuevo Testamento' : 'Antiguo Testamento',
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // ─── Cuadrícula de capítulos ──────────────────────────────────────────────

  /// Construye la cuadrícula de botones de capítulo.
  ///
  /// [chapters]: lista de números de capítulo disponibles.
  Widget _buildChaptersGrid(BuildContext context, List<int> chapters) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: chapters.length,
      itemBuilder: (_, index) {
        final int chapter = chapters[index];
        return _buildChapterButton(context, chapter);
      },
    );
  }

  /// Construye un botón individual de capítulo.
  ///
  /// [chapter]: número del capítulo que representa el botón.
  Widget _buildChapterButton(BuildContext context, int chapter) {
    return Material(
      color: widget.book.color.withOpacity(0.9),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ReadingScreen(book: widget.book, chapter: chapter),
          ),
        ),
        child: Center(
          child: Text(
            '$chapter',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: widget.book.color.computeLuminance() > 0.35
                  ? Colors.black87
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
