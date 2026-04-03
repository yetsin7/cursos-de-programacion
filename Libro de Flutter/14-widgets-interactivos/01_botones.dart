// =============================================================================
// ARCHIVO: 01_botones.dart
// TEMA: Botones avanzados y GestureDetector en Flutter
// =============================================================================
//
// Más allá de los botones básicos, Flutter ofrece SegmentedButton para
// selección de opciones, GestureDetector para gestos personalizados en
// cualquier widget, y opciones avanzadas de estilo con ButtonStyle.
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
      title: 'Botones Avanzados',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const PantallaBotones(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA PRINCIPAL
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra botones avanzados, SegmentedButton y GestureDetector.
class PantallaBotones extends StatefulWidget {
  const PantallaBotones({super.key});

  @override
  State<PantallaBotones> createState() => _PantallaBotonesState();
}

class _PantallaBotonesState extends State<PantallaBotones> {
  // Estado del SegmentedButton (puede ser múltiple con multiSelectionEnabled).
  final Set<String> _talla = {'M'};

  // Estado del GestureDetector.
  String _estadoGesto = 'Sin interacción';
  Color _colorCaja = Colors.indigo.shade100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Botones y GestureDetector'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSeccionSegmentedButton(),
            const SizedBox(height: 24),
            _buildSeccionLongPress(),
            const SizedBox(height: 24),
            _buildSeccionGestureDetector(),
          ],
        ),
      ),
    );
  }

  // ── SegmentedButton ─────────────────────────────────────────────────────

  /// SegmentedButton de Material 3: selector de una opción entre varias.
  Widget _buildSeccionSegmentedButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('SegmentedButton (Material 3)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        // SegmentedButton<T>: T es el tipo del valor de cada segmento.
        SegmentedButton<String>(
          // segments: cada botón del grupo.
          segments: const [
            ButtonSegment(value: 'XS', label: Text('XS')),
            ButtonSegment(value: 'S', label: Text('S')),
            ButtonSegment(value: 'M', label: Text('M')),
            ButtonSegment(value: 'L', label: Text('L')),
            ButtonSegment(value: 'XL', label: Text('XL')),
          ],
          // selected: Set<T> con los valores actualmente seleccionados.
          selected: _talla,
          // onSelectionChanged: recibe el nuevo Set<T> seleccionado.
          onSelectionChanged: (nuevaSeleccion) {
            setState(() => _talla = nuevaSeleccion);
          },
        ),
        const SizedBox(height: 8),
        Text('Talla seleccionada: ${_talla.first}'),
      ],
    );
  }

  // ── Long Press y variantes ───────────────────────────────────────────────

  /// Demuestra onLongPress y los constructores .icon() de los botones.
  Widget _buildSeccionLongPress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('onLongPress',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ElevatedButton(
          // onPressed: acción principal (tap corto).
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tap corto')),
            );
          },
          // onLongPress: acción secundaria (mantener presionado ~500ms).
          onLongPress: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Long press — acción adicional')),
            );
          },
          child: const Text('Presiona vs mantén presionado'),
        ),
        const SizedBox(height: 8),
        // InkWell: añade efecto ripple a cualquier widget sin que sea botón.
        InkWell(
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('InkWell tocado')),
          ),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.touch_app, color: Colors.indigo),
                SizedBox(width: 8),
                Text('InkWell — ripple en widget personalizado'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── GestureDetector ──────────────────────────────────────────────────────

  /// GestureDetector detecta cualquier gesto sobre su hijo.
  Widget _buildSeccionGestureDetector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('GestureDetector',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text(
          'Toca, mantén, toca doble o desliza la caja:',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          // onTap: toque rápido.
          onTap: () => setState(() {
            _estadoGesto = 'Tap';
            _colorCaja = Colors.indigo.shade200;
          }),
          // onDoubleTap: dos toques rápidos seguidos.
          onDoubleTap: () => setState(() {
            _estadoGesto = 'Doble tap';
            _colorCaja = Colors.green.shade200;
          }),
          // onLongPress: toque sostenido.
          onLongPress: () => setState(() {
            _estadoGesto = 'Long press';
            _colorCaja = Colors.red.shade200;
          }),
          // onHorizontalDragUpdate: deslizamiento horizontal.
          onHorizontalDragUpdate: (_) => setState(() {
            _estadoGesto = 'Arrastrando horizontal';
            _colorCaja = Colors.orange.shade200;
          }),
          // onHorizontalDragEnd: fin del arrastre.
          onHorizontalDragEnd: (_) => setState(() {
            _estadoGesto = 'Arrastre terminado';
            _colorCaja = Colors.indigo.shade100;
          }),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: _colorCaja,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              _estadoGesto,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Agrega multiSelectionEnabled: true al SegmentedButton para poder
//      seleccionar varias tallas simultáneamente.
//   2. Usa GestureDetector con onScaleUpdate para detectar el gesto de
//      "pinch to zoom" (pellizco para hacer zoom).
//   3. Prueba onVerticalDragUpdate para detectar deslizamientos verticales
//      y crear un efecto de "tirar para actualizar" manualmente.
// =============================================================================
