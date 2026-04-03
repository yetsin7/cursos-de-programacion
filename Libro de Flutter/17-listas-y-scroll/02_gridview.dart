// =============================================================================
// ARCHIVO: 02_gridview.dart
// TEMA: GridView y cuadrículas en Flutter
// =============================================================================
//
// GridView muestra items en una cuadrícula (filas y columnas). Las variantes
// más comunes son .builder (lazy, eficiente), .count (número fijo de columnas)
// y .extent (ancho fijo por item). SliverGridDelegate controla la distribución.
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
      title: 'GridView Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const PantallaGrid(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// DATOS DE PRUEBA
// ────────────────────────────────────────────────────────────────────────────

/// Modelo de categoría para la cuadrícula de ejemplo.
class Categoria {
  final String nombre;
  final IconData icono;
  final Color color;

  const Categoria({
    required this.nombre,
    required this.icono,
    required this.color,
  });
}

const _categorias = [
  Categoria(nombre: 'Flutter', icono: Icons.flutter_dash, color: Colors.blue),
  Categoria(nombre: 'Dart', icono: Icons.code, color: Colors.green),
  Categoria(nombre: 'Firebase', icono: Icons.local_fire_department, color: Colors.orange),
  Categoria(nombre: 'Diseño', icono: Icons.design_services, color: Colors.purple),
  Categoria(nombre: 'Testing', icono: Icons.bug_report, color: Colors.red),
  Categoria(nombre: 'CI/CD', icono: Icons.sync, color: Colors.teal),
  Categoria(nombre: 'Supabase', icono: Icons.storage, color: Colors.indigo),
  Categoria(nombre: 'Animación', icono: Icons.animation, color: Colors.pink),
  Categoria(nombre: 'Estado', icono: Icons.settings_backup_restore, color: Colors.brown),
  Categoria(nombre: 'Navegación', icono: Icons.map, color: Colors.cyan),
  Categoria(nombre: 'HTTP', icono: Icons.http, color: Colors.amber),
  Categoria(nombre: 'Listas', icono: Icons.list, color: Colors.deepOrange),
];

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA CON TABS
// ────────────────────────────────────────────────────────────────────────────

/// Tabs con las tres variantes de GridView.
class PantallaGrid extends StatelessWidget {
  const PantallaGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GridView'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: const TabBar(tabs: [
            Tab(text: '.builder'),
            Tab(text: '.count'),
            Tab(text: '.extent'),
          ]),
        ),
        body: const TabBarView(children: [
          _TabBuilder(),
          _TabCount(),
          _TabExtent(),
        ]),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// TAB 1 — GRIDVIEW.BUILDER
// ────────────────────────────────────────────────────────────────────────────

/// GridView.builder: versión eficiente con lazy loading. Para listas largas.
class _TabBuilder extends StatelessWidget {
  const _TabBuilder();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      // gridDelegate: define la estructura de la cuadrícula.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        // crossAxisCount: número de columnas.
        crossAxisCount: 3,
        // crossAxisSpacing: espacio entre columnas.
        crossAxisSpacing: 8,
        // mainAxisSpacing: espacio entre filas.
        mainAxisSpacing: 8,
        // childAspectRatio: relación ancho/alto de cada celda.
        // 1.0 = cuadrado, 0.75 = más alto que ancho, 1.5 = más ancho que alto.
        childAspectRatio: 0.9,
      ),
      itemCount: _categorias.length,
      itemBuilder: (context, index) {
        final cat = _categorias[index];
        return _TarjetaCategoria(categoria: cat);
      },
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// TAB 2 — GRIDVIEW.COUNT
// ────────────────────────────────────────────────────────────────────────────

/// GridView.count: cuadrícula con número fijo de columnas. Simple y directo.
/// Crea todos los items a la vez → solo para listas cortas.
class _TabCount extends StatelessWidget {
  const _TabCount();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(12),
      // crossAxisCount: número de columnas (requerido).
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      // childAspectRatio: ancho/alto. 2.0 = el doble de ancho que alto.
      childAspectRatio: 2.0,
      // children: lista directa de widgets (sin lazy loading).
      children: _categorias
          .take(8)
          .map((cat) => _TarjetaHorizontal(categoria: cat))
          .toList(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// TAB 3 — GRIDVIEW.EXTENT
// ────────────────────────────────────────────────────────────────────────────

/// GridView.extent: calcula el número de columnas automáticamente según
/// el ancho máximo permitido por item. Más adaptable a distintos tamaños de pantalla.
class _TabExtent extends StatelessWidget {
  const _TabExtent();

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      padding: const EdgeInsets.all(12),
      // maxCrossAxisExtent: ancho máximo de cada item en píxeles lógicos.
      // Flutter divide el ancho disponible entre este valor para calcular
      // cuántas columnas caben. En pantalla de 360dp → 2 columnas de 120dp.
      maxCrossAxisExtent: 160,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 0.85,
      children: _categorias
          .map((cat) => _TarjetaCategoria(categoria: cat))
          .toList(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// WIDGETS DE ITEM DE CUADRÍCULA
// ────────────────────────────────────────────────────────────────────────────

/// Tarjeta vertical de categoría para la cuadrícula.
class _TarjetaCategoria extends StatelessWidget {
  final Categoria categoria;
  const _TarjetaCategoria({required this.categoria});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: categoria.color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: categoria.color.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(categoria.icono, size: 36, color: categoria.color),
            const SizedBox(height: 6),
            Text(
              categoria.nombre,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: categoria.color,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Tarjeta horizontal de categoría para la cuadrícula de 2 columnas.
class _TarjetaHorizontal extends StatelessWidget {
  final Categoria categoria;
  const _TarjetaHorizontal({required this.categoria});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: categoria.color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: categoria.color.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(categoria.icono, color: categoria.color, size: 28),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                categoria.nombre,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: categoria.color,
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Cambia crossAxisCount a 4 en el primer tab y observa cómo las tarjetas
//      se vuelven más pequeñas automáticamente.
//   2. Usa SliverGridDelegateWithMaxCrossAxisExtent en GridView.builder para
//      que se adapte automáticamente a tablets con más columnas.
//   3. Mezcla GridView con una barra de búsqueda usando CustomScrollView:
//      SliverToBoxAdapter para el buscador + SliverGrid para la cuadrícula.
// =============================================================================
