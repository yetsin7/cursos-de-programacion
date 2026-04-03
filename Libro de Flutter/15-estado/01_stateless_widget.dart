// =============================================================================
// ARCHIVO: 01_stateless_widget.dart
// TEMA: StatelessWidget — widgets sin estado interno
// =============================================================================
//
// Un StatelessWidget describe una parte de la UI que depende SOLO de su
// configuración (parámetros / props). Dado los mismos parámetros, siempre
// produce la misma UI. No puede cambiar por sí solo: si sus datos cambian,
// el widget padre lo reconstruye con nuevos parámetros.
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
      title: 'StatelessWidget',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const PantallaStateless(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA PRINCIPAL
// ────────────────────────────────────────────────────────────────────────────

/// Pantalla de demostración de StatelessWidget y widgets reutilizables.
class PantallaStateless extends StatelessWidget {
  const PantallaStateless({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StatelessWidget'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SeccionConceptoStateless(),
            SizedBox(height: 24),
            _SeccionWidgetsReutilizables(),
            SizedBox(height: 24),
            _SeccionConstConstructor(),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 1 — CONCEPTO DE STATELESSWIDGET
// ────────────────────────────────────────────────────────────────────────────

/// Explica el concepto con un ejemplo de tarjeta de producto.
class _SeccionConceptoStateless extends StatelessWidget {
  const _SeccionConceptoStateless();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('StatelessWidget: siempre igual dado los mismos datos',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),

        // Reutilizamos el mismo widget con diferentes datos.
        // Cada instancia es independiente e inmutable.
        const TarjetaProducto(
          nombre: 'Flutter en Acción',
          precio: 29.99,
          categoria: 'Libros',
          icono: Icons.book,
        ),
        const SizedBox(height: 8),
        const TarjetaProducto(
          nombre: 'Curso Dart Avanzado',
          precio: 14.99,
          categoria: 'Cursos',
          icono: Icons.school,
        ),
        const SizedBox(height: 8),
        const TarjetaProducto(
          nombre: 'Diseño Material 3',
          precio: 0.0,
          categoria: 'Recursos',
          icono: Icons.design_services,
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// WIDGET REUTILIZABLE: TarjetaProducto
// ────────────────────────────────────────────────────────────────────────────

/// Tarjeta de producto reutilizable. Ejemplo de StatelessWidget bien diseñado.
///
/// Recibe sus datos vía constructor. Dado los mismos datos, siempre produce
/// la misma UI. Se puede usar en cualquier pantalla de la app.
///
/// Parámetros:
/// - [nombre]: nombre del producto a mostrar en el título
/// - [precio]: precio numérico. Si es 0.0 se muestra como "Gratis"
/// - [categoria]: categoría del producto (texto en chip)
/// - [icono]: ícono representativo del producto
class TarjetaProducto extends StatelessWidget {
  /// Nombre del producto.
  final String nombre;

  /// Precio en dólares. Si es 0, se muestra "Gratis".
  final double precio;

  /// Categoría para mostrar en el chip.
  final String categoria;

  /// Ícono representativo del producto.
  final IconData icono;

  // const constructor: permite que Flutter reutilice instancias idénticas
  // sin reconstruirlas. Siempre declara const en StatelessWidget.
  const TarjetaProducto({
    super.key,
    required this.nombre,
    required this.precio,
    required this.categoria,
    required this.icono,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icono, color: color.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nombre,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                // Chip para la categoría.
                Chip(
                  label: Text(categoria,
                      style: const TextStyle(fontSize: 11)),
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),
          Text(
            precio == 0 ? 'Gratis' : '\$${precio.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: precio == 0 ? Colors.green : color.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 2 — WIDGETS REUTILIZABLES
// ────────────────────────────────────────────────────────────────────────────

/// Muestra el poder de la reutilización: un widget definido una sola vez,
/// usado múltiples veces con distintos datos.
class _SeccionWidgetsReutilizables extends StatelessWidget {
  const _SeccionWidgetsReutilizables();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Widgets reutilizables',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        // _EtiquetaEstado reutilizado con distintos estados.
        const Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _EtiquetaEstado(texto: 'Activo', color: Colors.green),
            _EtiquetaEstado(texto: 'Pendiente', color: Colors.orange),
            _EtiquetaEstado(texto: 'Cancelado', color: Colors.red),
            _EtiquetaEstado(texto: 'En revisión', color: Colors.blue),
          ],
        ),
      ],
    );
  }
}

/// Etiqueta de estado (badge) reutilizable con color personalizable.
///
/// Ejemplo de widget pequeño y enfocado en una sola responsabilidad.
class _EtiquetaEstado extends StatelessWidget {
  final String texto;
  final Color color;

  const _EtiquetaEstado({required this.texto, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        texto,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 3 — CONST CONSTRUCTOR
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra la importancia del const constructor para la optimización.
class _SeccionConstConstructor extends StatelessWidget {
  const _SeccionConstConstructor();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('¿Por qué usar const?',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(
            '• const le dice a Flutter: "este widget NUNCA cambia"\n'
            '• Flutter puede reutilizar la misma instancia en memoria\n'
            '• Reduce reconstrucciones innecesarias del árbol\n'
            '• El análisis de Dart detecta automáticamente dónde agregarlo\n'
            '• Usa flutter analyze para encontrar dónde falta const',
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Agrega un parámetro optional (con valor por defecto) a TarjetaProducto:
//      final bool enOferta; con @override y un badge "OFERTA" condicional.
//   2. Extrae el chip de categoría a su propio widget _ChipCategoria
//      para que sea reutilizable independientemente.
//   3. Intenta usar const en todos los lugares posibles y observa las
//      advertencias del linter: te indicará dónde es aplicable.
// =============================================================================
