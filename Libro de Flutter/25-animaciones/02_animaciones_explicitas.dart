// ============================================================
// MÓDULO 25 — Animaciones explícitas en Flutter
// Archivo: 02_animaciones_explicitas.dart
//
// Las animaciones explícitas dan control total: pausar, repetir,
// revertir y sincronizar múltiples animaciones.
//
// Conceptos:
//   - AnimationController con TickerProviderStateMixin (vsync)
//   - Tween<double>, CurvedAnimation
//   - AnimatedBuilder para reconstruir eficientemente
//   - Curvas: linear, easeIn, easeOut, elasticOut, bounceIn
//   - forward(), reverse(), repeat(), stop(), dispose()
// ============================================================

import 'package:flutter/material.dart';

void main() => runApp(const AppAnimacionesExplicitas());

/// Punto de entrada de la app de animaciones explícitas.
class AppAnimacionesExplicitas extends StatelessWidget {
  const AppAnimacionesExplicitas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animaciones Explícitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      home: const PantallaControlAnimacion(),
    );
  }
}

/// Demuestra el ciclo de vida completo de AnimationController
/// con tres animaciones simultáneas y selección de curva.
///
/// Usa [TickerProviderStateMixin] para sincronizar el controller
/// con el vsync del dispositivo y no consumir recursos innecesarios.
class PantallaControlAnimacion extends StatefulWidget {
  const PantallaControlAnimacion({super.key});

  @override
  State<PantallaControlAnimacion> createState() => _Estado();
}

class _Estado extends State<PantallaControlAnimacion>
    with TickerProviderStateMixin {

  /// Controller principal: dura 1.5 segundos.
  late final AnimationController _ctrl;

  /// Animación de rotación: 0 → 1 vuelta completa.
  late final Animation<double> _rotacion;

  /// Animación de escala con curva elástica: 0.5 → 1.5.
  late final Animation<double> _escala;

  /// Animación de color: azul → naranja.
  late final Animation<Color?> _color;

  Curve _curva = Curves.linear;
  bool _activo = false;
  bool _repitiendo = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);

    // Tween de rotación (linear para que gire uniformemente)
    _rotacion = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.linear));

    // Tween de escala con curva elástica para efecto rebote
    _escala = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));

    // Tween de color de azul a naranja
    _color = ColorTween(begin: Colors.blue, end: Colors.deepOrange).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));

    // Actualizar botones cuando la animación termina
    _ctrl.addStatusListener((status) {
      if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
        setState(() { _activo = false; if (status == AnimationStatus.dismissed) _repitiendo = false; });
      }
    });
  }

  /// CRÍTICO: siempre liberar el controller para evitar memory leaks.
  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _play()    { setState(() { _activo = true; _repitiendo = false; }); _ctrl.forward(from: 0); }
  void _reverse() { setState(() => _activo = true); _ctrl.reverse(from: 1); }
  void _repeat()  { setState(() { _activo = true; _repitiendo = true; }); _ctrl.repeat(); }
  void _pause()   { setState(() { _activo = false; _repitiendo = false; }); _ctrl.stop(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animaciones Explícitas'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          _panelAnimaciones(),
          const SizedBox(height: 20),
          _panelCurvas(),
          const SizedBox(height: 20),
          _panelBotones(),
          const SizedBox(height: 20),
          _panelProgreso(),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // AnimatedBuilder reconstruye solo este subtree, no toda la
  // pantalla — fundamental para el rendimiento en animaciones.
  // ----------------------------------------------------------
  Widget _panelAnimaciones() {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Rotación lineal
            Column(children: [
              RotationTransition(turns: _rotacion,
                  child: const Icon(Icons.settings, size: 64, color: Colors.indigo)),
              const SizedBox(height: 4),
              const Text('Rotación', style: TextStyle(fontSize: 12)),
            ]),
            // Escala con elasticOut
            Column(children: [
              Transform.scale(scale: _escala.value,
                  child: const Icon(Icons.favorite, size: 48, color: Colors.red)),
              const SizedBox(height: 4),
              const Text('Escala (elastic)', style: TextStyle(fontSize: 12)),
            ]),
            // Color interpolado
            Column(children: [
              CircleAvatar(radius: 32, backgroundColor: _color.value),
              const SizedBox(height: 4),
              const Text('Color', style: TextStyle(fontSize: 12)),
            ]),
          ],
        );
      },
    );
  }

  /// Selector de curvas: cambia el comportamiento sin modificar el Tween.
  Widget _panelCurvas() {
    final curvas = {
      'linear': Curves.linear,
      'easeIn': Curves.easeIn,
      'easeOut': Curves.easeOut,
      'elasticOut': Curves.elasticOut,
      'bounceIn': Curves.bounceIn,
    };
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Curva:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            children: curvas.entries.map((e) => ChoiceChip(
              label: Text(e.key),
              selected: _curva == e.value,
              onSelected: (_) => setState(() => _curva = e.value),
            )).toList(),
          ),
        ],
      ),
    );
  }

  /// Botones: Play, Revertir, Repetir, Pausar.
  Widget _panelBotones() {
    return Wrap(
      spacing: 8,
      children: [
        ElevatedButton.icon(onPressed: _activo ? null : _play,    icon: const Icon(Icons.play_arrow), label: const Text('Play')),
        ElevatedButton.icon(onPressed: _activo ? null : _reverse, icon: const Icon(Icons.replay),    label: const Text('Revertir')),
        ElevatedButton.icon(onPressed: _repitiendo ? null : _repeat, icon: const Icon(Icons.loop),   label: const Text('Repetir')),
        ElevatedButton.icon(onPressed: _activo ? _pause : null,   icon: const Icon(Icons.pause),     label: const Text('Pausar')),
      ],
    );
  }

  /// Barra de progreso que muestra el valor actual del controller (0.0 → 1.0).
  Widget _panelProgreso() {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(children: [
          Text('Progreso: ${(_ctrl.value * 100).toStringAsFixed(0)}%'),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: _ctrl.value),
        ]),
      ),
    );
  }
}
