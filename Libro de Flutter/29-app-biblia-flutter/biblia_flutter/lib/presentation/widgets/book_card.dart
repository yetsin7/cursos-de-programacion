import 'package:flutter/material.dart';

import '../../domain/entities/book.dart';

/// Tarjeta de presentación de un libro bíblico en la pantalla principal.
///
/// Muestra el nombre corto del libro en grande, el nombre largo en pequeño
/// y una etiqueta que indica si pertenece al AT o NT. El color de fondo
/// se toma del campo book_color de la base de datos.
class BookCard extends StatelessWidget {
  /// Libro a mostrar en la tarjeta
  final Book book;

  /// Función a ejecutar cuando el usuario toca la tarjeta
  final VoidCallback onTap;

  const BookCard({
    super.key,
    required this.book,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color cardColor = book.color;
    final bool isLight = cardColor.computeLuminance() > 0.35;
    final Color textColor = isLight ? Colors.black87 : Colors.white;
    final Color subtitleColor =
        isLight ? Colors.black54 : Colors.white.withOpacity(0.75);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTestamentBadge(subtitleColor),
              const Spacer(),
              _buildShortName(textColor),
              const SizedBox(height: 2),
              _buildLongName(subtitleColor),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Sub-widgets ──────────────────────────────────────────────────────────

  /// Muestra la etiqueta "AT" o "NT" en la esquina superior de la tarjeta.
  Widget _buildTestamentBadge(Color color) {
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        book.isNewTestament ? 'NT' : 'AT',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  /// Nombre corto del libro en tipografía grande y en negrita.
  Widget _buildShortName(Color color) {
    return Text(
      book.shortName,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: color,
        height: 1.1,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Nombre largo del libro en tipografía pequeña.
  Widget _buildLongName(Color color) {
    return Text(
      book.longName,
      style: TextStyle(
        fontSize: 10,
        color: color,
        height: 1.2,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
