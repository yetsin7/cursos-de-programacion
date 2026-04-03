import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/verse.dart';
import '../providers/bible_provider.dart';
import '../widgets/verse_tile.dart';

/// Pantalla de búsqueda global en toda la Biblia.
///
/// Presenta un campo de búsqueda en el AppBar y muestra los resultados
/// en tiempo diferido (con debounce) para no saturar la BD con cada tecla.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    context.read<BibleProvider>().clearSearch();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildSearchAppBar(context),
      body: _buildBody(context),
    );
  }

  // ─── AppBar de búsqueda ───────────────────────────────────────────────────

  /// Construye el AppBar con el campo de texto de búsqueda integrado.
  PreferredSizeWidget _buildSearchAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: TextField(
        controller: _controller,
        focusNode: _focusNode,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: const InputDecoration(
          hintText: 'Buscar en la Biblia...',
          hintStyle: TextStyle(color: Colors.white60),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
        onChanged: (value) {
          if (value.trim().length >= 2) {
            context.read<BibleProvider>().search(value.trim());
          } else if (value.isEmpty) {
            context.read<BibleProvider>().clearSearch();
          }
        },
      ),
      actions: [
        if (_controller.text.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _controller.clear();
              context.read<BibleProvider>().clearSearch();
              setState(() {});
            },
          ),
      ],
    );
  }

  // ─── Cuerpo ───────────────────────────────────────────────────────────────

  /// Construye el cuerpo según el estado de la búsqueda.
  Widget _buildBody(BuildContext context) {
    final provider = context.watch<BibleProvider>();

    if (provider.searchState == LoadingState.idle) {
      return _buildIdleState();
    }
    if (provider.isSearching) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.searchResults.isEmpty) {
      return _buildEmptyState();
    }
    return _buildResults(provider.searchResults);
  }

  /// Estado inicial cuando no hay búsqueda activa.
  Widget _buildIdleState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search,
              size: 64,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
          const SizedBox(height: 16),
          const Text(
            'Escribe para buscar\nen los 31.000+ versículos',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ],
      ),
    );
  }

  /// Estado cuando no hay resultados para la búsqueda realizada.
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.sentiment_dissatisfied,
              size: 64,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
          const SizedBox(height: 16),
          const Text(
            'Sin resultados.',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          const Text(
            'Intenta con otras palabras',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }

  // ─── Lista de resultados ──────────────────────────────────────────────────

  /// Construye la lista de resultados de búsqueda.
  ///
  /// [results]: lista de versículos que coinciden con la consulta.
  Widget _buildResults(List<Verse> results) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildResultsCounter(results.length),
        Expanded(
          child: ListView.separated(
            itemCount: results.length,
            separatorBuilder: (_, __) =>
                const Divider(height: 1, indent: 16),
            itemBuilder: (_, index) =>
                VerseTile(verse: results[index], showReference: true),
          ),
        ),
      ],
    );
  }

  /// Muestra cuántos resultados se encontraron.
  Widget _buildResultsCounter(int count) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
      child: Text(
        '$count resultado${count != 1 ? 's' : ''}',
        style: const TextStyle(
          fontSize: 13,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
