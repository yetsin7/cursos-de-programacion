// =============================================================================
// ARCHIVO: 03_custom_scroll.dart
// TEMA: CustomScrollView y Slivers en Flutter
// =============================================================================
//
// CustomScrollView con Slivers es el sistema de scroll más flexible de Flutter.
// Permite combinar una SliverAppBar colapsable con listas, cuadrículas y
// widgets normales en un único scroll coordinado y eficiente.
// Los Slivers son fragmentos de scroll que se componen como capas.
//
// CÓMO USAR:
//   1. Crea un proyecto Flutter: flutter create mi_app
//   2. Reemplaza lib/main.dart con este archivo
//   3. Ejecuta: flutter run
//
// =============================================================================
import 'package:flutter/material.dart';

void main() => runApp(const MiApp());

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CustomScrollView',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const PantallaCustomScroll(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// DATOS DE PRUEBA
// ────────────────────────────────────────────────────────────────────────────

const _articulos = [
  'Introducción a Flutter y Dart',
  'Arquitectura Clean en Flutter',
  'Gestión de estado con Riverpod',
  'Animaciones avanzadas en Flutter',
  'Testing unitario y de widgets',
  'Integración con Firebase',
  'Publicar en Google Play',
  'Publicar en App Store',
  'Optimización de rendimiento',
  'Accesibilidad en Flutter',
];

const _etiquetas = [
  ('Flutter', Colors.blue),
  ('Dart', Colors.green),
  ('Mobile', Colors.orange),
  ('Backend', Colors.red),
  ('UI/UX', Colors.purple),
];

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA PRINCIPAL
// ────────────────────────────────────────────────────────────────────────────

/// Pantalla con CustomScrollView: SliverAppBar + SliverGrid + SliverList.
///
/// El scroll es unificado: el AppBar, la cuadrícula y la lista se mueven
/// como un único flujo de scroll coordinado.
class PantallaCustomScroll extends StatelessWidget {
  const PantallaCustomScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // CustomScrollView reemplaza al body + AppBar tradicional.
      // Sus hijos son Slivers (fragmentos de scroll eficientes).
      body: CustomScrollView(
        // physics: controla el comportamiento de rebote/inercia del scroll.
        physics: const BouncingScrollPhysics(),

        slivers: [
          // ── SliverAppBar ───────────────────────────────────────────────
          // AppBar que se colapsa al hacer scroll hacia abajo y reaparece
          // al hacer scroll hacia arriba.
          SliverAppBar(
            // expandedHeight: altura del AppBar cuando está completamente expandido.
            expandedHeight: 200,

            // floating: true → reaparece apenas se empiece a hacer scroll arriba.
            // false → solo reaparece cuando se llega al tope de la lista.
            floating: true,

            // pinned: true → el AppBar colapsado siempre permanece visible.
            // false → desaparece completamente al hacer scroll abajo.
            pinned: true,

            // snap: true (solo si floating:true) → el AppBar aparece/desaparece
            // de golpe en lugar de gradualmente.
            snap: false,

            backgroundColor: Theme.of(context).colorScheme.primaryContainer,

            // flexibleSpace: el contenido del AppBar expandido.
            flexibleSpace: FlexibleSpaceBar(
              // title: se muestra siempre, se ajusta al colapsar.
              title: const Text('CustomScrollView',
                  style: TextStyle(fontSize: 14)),
              // background: contenido visible solo cuando está expandido.
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primaryContainer,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40), // espacio para la barra de estado
                      Icon(Icons.school, size: 48, color: Colors.white),
                      SizedBox(height: 8),
                      Text('Libro de Flutter',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── SliverToBoxAdapter — para widgets normales en el scroll ────
          // Permite colocar cualquier widget (no Sliver) dentro del scroll.
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Etiquetas populares',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  _ChipsEtiquetas(),
                  SizedBox(height: 16),
                  Text('Categorías',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),

          // ── SliverGrid — cuadrícula dentro del scroll unificado ────────
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              // gridDelegate: mismo que en GridView.
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 2.5,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _CeldaCategoria(index: index),
                childCount: 4,
              ),
            ),
          ),

          // ── SliverToBoxAdapter — otro widget normal ────────────────────
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Text('Últimos artículos',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),

          // ── SliverList — lista vertical dentro del scroll unificado ────
          // Equivale a ListView.builder pero como Sliver.
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _ItemArticulo(
                titulo: _articulos[index],
                numero: index + 1,
              ),
              childCount: _articulos.length,
            ),
          ),

          // ── Padding inferior para el último item ──────────────────────
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// WIDGETS AUXILIARES
// ────────────────────────────────────────────────────────────────────────────

/// Fila de chips de etiquetas para la sección de filtros.
class _ChipsEtiquetas extends StatelessWidget {
  const _ChipsEtiquetas();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: _etiquetas
          .map((e) => Chip(
                label: Text(e.$1),
                backgroundColor: e.$2.withValues(alpha: 0.15),
                side: BorderSide(color: e.$2.withValues(alpha: 0.4)),
                labelStyle: TextStyle(color: e.$2, fontWeight: FontWeight.w500),
              ))
          .toList(),
    );
  }
}

/// Celda de categoría para el SliverGrid.
class _CeldaCategoria extends StatelessWidget {
  final int index;
  const _CeldaCategoria({required this.index});

  static const _datos = [
    ('Fundamentos', Icons.foundation, Colors.blue),
    ('Avanzado', Icons.rocket_launch, Colors.purple),
    ('Proyectos', Icons.work, Colors.green),
    ('Entrevistas', Icons.quiz, Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    final dato = _datos[index % _datos.length];
    return Container(
      decoration: BoxDecoration(
        color: (dato.$3 as Color).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(dato.$2, color: dato.$3 as Color, size: 20),
          const SizedBox(width: 6),
          Text(dato.$1,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: dato.$3 as Color,
                  fontSize: 12)),
        ],
      ),
    );
  }
}

/// Item de artículo para el SliverList.
class _ItemArticulo extends StatelessWidget {
  final String titulo;
  final int numero;
  const _ItemArticulo({required this.titulo, required this.numero});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Text('$numero',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary)),
          ),
          title: Text(titulo),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
      ),
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Cambia pinned: true a false y floating: false para ver cómo el AppBar
//      desaparece completamente al hacer scroll — no se puede recuperar hasta
//      que se llega al tope de la lista.
//   2. Agrega snap: true (con floating: true) para ver el efecto de que el
//      AppBar aparece y desaparece de golpe al cambiar de dirección.
//   3. Reemplaza SliverList por SliverFixedExtentList y dale itemExtent: 56
//      para una lista con altura fija — más eficiente porque Flutter no
//      necesita calcular la altura de cada item.
// =============================================================================
