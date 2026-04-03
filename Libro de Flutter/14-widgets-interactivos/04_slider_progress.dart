// =============================================================================
// ARCHIVO: 04_slider_progress.dart
// TEMA: Slider, RangeSlider e indicadores de progreso en Flutter
// =============================================================================
//
// Slider permite seleccionar un valor dentro de un rango deslizando el pulgar.
// RangeSlider permite seleccionar un rango entre dos valores. Los indicadores
// de progreso informan al usuario sobre operaciones en curso: LinearProgressIndicator
// y CircularProgressIndicator tienen modos determinado e indeterminado.
// RefreshIndicator añade "pull to refresh" a cualquier widget con scroll.
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
      title: 'Slider y Progreso',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const PantallaSlider(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA PRINCIPAL
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra Slider, RangeSlider y los distintos indicadores de progreso.
class PantallaSlider extends StatefulWidget {
  const PantallaSlider({super.key});

  @override
  State<PantallaSlider> createState() => _PantallaSliderState();
}

class _PantallaSliderState extends State<PantallaSlider> {
  // ── Estado de Sliders ────────────────────────────────────────────────────
  double _volumen = 0.5;
  double _brillo = 0.8;
  RangeValues _rango = const RangeValues(20, 60);

  // ── Estado de progreso ───────────────────────────────────────────────────
  // Progreso determinado: sabemos cuánto falta (0.0 a 1.0).
  double _progresoDescarga = 0.65;
  bool _cargando = false;

  // Lista de datos para el RefreshIndicator.
  List<String> _elementos = ['Elemento 1', 'Elemento 2', 'Elemento 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider y Progreso'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: RefreshIndicator(
        // onRefresh: función async que se llama al hacer pull to refresh.
        // DEBE ser async y retornar Future<void>.
        onRefresh: _simularRecarga,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSeccionSlider(),
            const SizedBox(height: 24),
            _buildSeccionRangeSlider(),
            const SizedBox(height: 24),
            _buildSeccionProgreso(),
            const SizedBox(height: 8),
            const Text(
              '↑ Desliza hacia abajo para activar RefreshIndicator',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 16),
            ..._elementos.map(
              (e) => Card(
                child: ListTile(
                  title: Text(e),
                  leading: const Icon(Icons.fiber_manual_record),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Sección Slider ───────────────────────────────────────────────────────

  /// Slider con divisiones, etiqueta y valor mostrado en tiempo real.
  Widget _buildSeccionSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Slider',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // Slider de volumen continuo (sin divisions).
        Row(
          children: [
            const Icon(Icons.volume_down),
            Expanded(
              child: Slider(
                // value: valor actual del slider (siempre entre min y max).
                value: _volumen,
                // min y max definen el rango del slider.
                min: 0.0,
                max: 1.0,
                // onChanged: se llama constantemente mientras se arrastra.
                onChanged: (v) => setState(() => _volumen = v),
              ),
            ),
            const Icon(Icons.volume_up),
            SizedBox(
              width: 36,
              child: Text(
                '${(_volumen * 100).round()}%',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Slider con divisions: divide el rango en segmentos discretos.
        // label: texto que aparece en el thumb al arrastrar.
        Row(
          children: [
            const Icon(Icons.brightness_low),
            Expanded(
              child: Slider(
                value: _brillo,
                min: 0,
                max: 1,
                // divisions: cantidad de posiciones discretas.
                divisions: 10,
                // label: texto del tooltip al arrastrar. Requiere divisions.
                label: '${(_brillo * 100).round()}%',
                onChanged: (v) => setState(() => _brillo = v),
              ),
            ),
            const Icon(Icons.brightness_high),
            SizedBox(
              width: 36,
              child: Text(
                '${(_brillo * 100).round()}%',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Sección RangeSlider ──────────────────────────────────────────────────

  /// RangeSlider para seleccionar un rango de precios.
  Widget _buildSeccionRangeSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('RangeSlider',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(
          'Precio: \$${_rango.start.round()} — \$${_rango.end.round()}',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        // RangeSlider tiene dos thumbs: uno para el inicio y otro para el fin.
        RangeSlider(
          values: _rango,
          min: 0,
          max: 200,
          divisions: 20,
          // labels: etiquetas para ambos thumbs.
          labels: RangeLabels(
            '\$${_rango.start.round()}',
            '\$${_rango.end.round()}',
          ),
          // onChanged recibe un RangeValues con los nuevos valores.
          onChanged: (rango) => setState(() => _rango = rango),
        ),
      ],
    );
  }

  // ── Sección Progreso ─────────────────────────────────────────────────────

  /// Indicadores de progreso determinados e indeterminados.
  Widget _buildSeccionProgreso() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Indicadores de progreso',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),

        // LinearProgressIndicator determinado: valor entre 0.0 y 1.0.
        const Text('Descarga (determinado):'),
        const SizedBox(height: 4),
        LinearProgressIndicator(value: _progresoDescarga),
        const SizedBox(height: 4),
        Text('${(_progresoDescarga * 100).round()}% completado'),

        const SizedBox(height: 16),

        // LinearProgressIndicator indeterminado: value: null = animación infinita.
        const Text('Procesando (indeterminado):'),
        const SizedBox(height: 4),
        const LinearProgressIndicator(), // sin value = indeterminado

        const SizedBox(height: 16),

        // CircularProgressIndicator determinado.
        Row(
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: CircularProgressIndicator(
                value: _progresoDescarga,
                strokeWidth: 6,
              ),
            ),
            const SizedBox(width: 16),
            // CircularProgressIndicator indeterminado.
            const SizedBox(
              width: 48,
              height: 48,
              child: CircularProgressIndicator(),
            ),
            const SizedBox(width: 16),
            const Text('Determinado   Indeterminado'),
          ],
        ),

        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _cargando ? null : _simularProgreso,
          child: Text(_cargando ? 'Cargando...' : 'Simular descarga'),
        ),
      ],
    );
  }

  /// Simula una operación de descarga incrementando el progreso gradualmente.
  Future<void> _simularProgreso() async {
    setState(() {
      _progresoDescarga = 0;
      _cargando = true;
    });
    for (int i = 0; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 150));
      if (mounted) setState(() => _progresoDescarga = i / 10);
    }
    if (mounted) setState(() => _cargando = false);
  }

  /// Simula la recarga de datos al hacer pull to refresh.
  Future<void> _simularRecarga() async {
    // Simula una llamada a la API con espera de 1.5 segundos.
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() {
        _elementos = [
          'Elemento actualizado 1',
          'Elemento actualizado 2',
          'Elemento nuevo ${DateTime.now().second}',
        ];
      });
    }
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Agrega onChangeStart y onChangeEnd al Slider para detectar cuándo
//      el usuario empieza y termina de arrastrar (ej: pausar audio).
//   2. Usa LinearProgressIndicator con backgroundColor para personalizar el
//      color del fondo de la barra de progreso.
//   3. Cambia el RefreshIndicator de color con color: Colors.orange y prueba
//      desplazamiento: trigger el refresh en el trigger de desplazamiento.
// =============================================================================
