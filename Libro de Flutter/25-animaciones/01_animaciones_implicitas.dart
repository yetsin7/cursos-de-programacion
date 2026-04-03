// ============================================================
// MÓDULO 25 — Animaciones implícitas en Flutter
// Archivo: 01_animaciones_implicitas.dart
//
// Las animaciones implícitas son la forma más sencilla de animar
// en Flutter: simplemente cambias un valor y Flutter se encarga
// de interpolar suavemente entre el estado anterior y el nuevo.
//
// Widgets cubiertos:
//   - AnimatedContainer
//   - AnimatedOpacity
//   - AnimatedPadding
//   - AnimatedAlign
//   - AnimatedSwitcher
//   - TweenAnimationBuilder
// ============================================================

import 'package:flutter/material.dart';

void main() => runApp(const AppAnimacionesImplicitas());

/// Punto de entrada: configura el tema y la ruta inicial.
class AppAnimacionesImplicitas extends StatelessWidget {
  const AppAnimacionesImplicitas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animaciones Implícitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const PantallaAnimaciones(),
    );
  }
}

/// Pantalla principal con todas las demostraciones de animaciones implícitas.
/// Cada sección muestra un tipo diferente y un botón para activarla.
class PantallaAnimaciones extends StatefulWidget {
  const PantallaAnimaciones({super.key});

  @override
  State<PantallaAnimaciones> createState() => _PantallaAnimacionesState();
}

class _PantallaAnimacionesState extends State<PantallaAnimaciones> {
  // --- Estado para AnimatedContainer ---
  bool _expandido = false;

  // --- Estado para AnimatedOpacity ---
  bool _visible = true;

  // --- Estado para AnimatedPadding ---
  bool _paddingGrande = false;

  // --- Estado para AnimatedAlign ---
  bool _derecha = false;

  // --- Estado para AnimatedSwitcher ---
  bool _mostrarIcono = true;

  // --- Estado para TweenAnimationBuilder ---
  double _escala = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animaciones Implícitas'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _seccionAnimatedContainer(),
          const Divider(height: 32),
          _seccionAnimatedOpacity(),
          const Divider(height: 32),
          _seccionAnimatedPadding(),
          const Divider(height: 32),
          _seccionAnimatedAlign(),
          const Divider(height: 32),
          _seccionAnimatedSwitcher(),
          const Divider(height: 32),
          _seccionTweenAnimationBuilder(),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // AnimatedContainer: anima tamaño, color y radio de borde
  // automáticamente al cambiar las propiedades.
  // ----------------------------------------------------------
  Widget _seccionAnimatedContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('AnimatedContainer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          width: _expandido ? 280 : 120,
          height: _expandido ? 120 : 60,
          decoration: BoxDecoration(
            color: _expandido ? Colors.indigo : Colors.blue[200],
            borderRadius: BorderRadius.circular(_expandido ? 24 : 8),
          ),
          child: const Center(child: Text('¡Tócame!', style: TextStyle(color: Colors.white))),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => setState(() => _expandido = !_expandido),
          child: Text(_expandido ? 'Contraer' : 'Expandir'),
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // AnimatedOpacity: desvanece o aparece un widget suavemente.
  // ----------------------------------------------------------
  Widget _seccionAnimatedOpacity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('AnimatedOpacity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 600),
          opacity: _visible ? 1.0 : 0.0,
          child: Container(
            width: 120, height: 60,
            color: Colors.orange,
            child: const Center(child: Text('Visible', style: TextStyle(color: Colors.white))),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => setState(() => _visible = !_visible),
          child: Text(_visible ? 'Ocultar' : 'Mostrar'),
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // AnimatedPadding: interpola el padding cuando cambia su valor.
  // ----------------------------------------------------------
  Widget _seccionAnimatedPadding() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('AnimatedPadding', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AnimatedPadding(
          duration: const Duration(milliseconds: 400),
          padding: EdgeInsets.only(left: _paddingGrande ? 80 : 0),
          child: Container(
            width: 100, height: 50,
            color: Colors.green,
            child: const Center(child: Text('Padding', style: TextStyle(color: Colors.white))),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => setState(() => _paddingGrande = !_paddingGrande),
          child: Text(_paddingGrande ? 'Resetear' : 'Mover'),
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // AnimatedAlign: mueve el hijo a lo largo del área disponible.
  // ----------------------------------------------------------
  Widget _seccionAnimatedAlign() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('AnimatedAlign', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 80,
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            alignment: _derecha ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 60, height: 60,
              decoration: const BoxDecoration(color: Colors.purple, shape: BoxShape.circle),
              child: const Center(child: Text('🏀', style: TextStyle(fontSize: 28))),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => setState(() => _derecha = !_derecha),
          child: Text(_derecha ? 'Izquierda' : 'Derecha'),
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // AnimatedSwitcher: aplica una transición al cambiar el widget hijo.
  // Importante: el nuevo widget debe tener una key diferente.
  // ----------------------------------------------------------
  Widget _seccionAnimatedSwitcher() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('AnimatedSwitcher', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation) =>
              ScaleTransition(scale: animation, child: child),
          child: _mostrarIcono
              ? const Icon(Icons.star, key: ValueKey('estrella'), size: 60, color: Colors.amber)
              : const Icon(Icons.favorite, key: ValueKey('corazon'), size: 60, color: Colors.red),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => setState(() => _mostrarIcono = !_mostrarIcono),
          child: const Text('Cambiar icono'),
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // TweenAnimationBuilder: animación implícita personalizada.
  // Controlas el rango (begin → end) y Flutter anima entre ellos.
  // ----------------------------------------------------------
  Widget _seccionTweenAnimationBuilder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('TweenAnimationBuilder', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 1.0, end: _escala),
          duration: const Duration(milliseconds: 500),
          curve: Curves.elasticOut,
          builder: (context, valor, child) {
            return Transform.scale(
              scale: valor,
              child: child,
            );
          },
          child: Container(
            width: 80, height: 80,
            color: Colors.teal,
            child: const Center(child: Text('Scale', style: TextStyle(color: Colors.white))),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton(
              onPressed: () => setState(() => _escala = 2.0),
              child: const Text('Agrandar'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => setState(() => _escala = 1.0),
              child: const Text('Normal'),
            ),
          ],
        ),
      ],
    );
  }
}
