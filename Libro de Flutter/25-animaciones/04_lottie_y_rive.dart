// ============================================================
// MÓDULO 25 — Lottie y Rive: animaciones de diseñador
// Archivo: 04_lottie_y_rive.dart
//
// DEPENDENCIA: lottie: ^3.0.0 en pubspec.yaml
//
// Lottie reproduce archivos JSON exportados desde Adobe After Effects
// usando el plugin Bodymovin. Ideal para: loaders, empty states,
// celebraciones (éxito/error), íconos animados.
//
// NOTA: Descarga archivos .json en https://lottiefiles.com
//       Agregar en pubspec.yaml:
//         flutter:
//           assets: [ assets/lottie/ ]
// ============================================================

import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart'; // Descomentar con el paquete instalado

void main() => runApp(const AppLottieRive());

/// Punto de entrada de la demo de Lottie y Rive.
class AppLottieRive extends StatelessWidget {
  const AppLottieRive({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lottie y Rive',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan), useMaterial3: true),
      home: const PantallaLottie(),
    );
  }
}

/// Pantalla con tres secciones: Lottie básico, Lottie con control, y Lottie vs Rive.
class PantallaLottie extends StatefulWidget {
  const PantallaLottie({super.key});

  @override
  State<PantallaLottie> createState() => _PantallaLottieState();
}

class _PantallaLottieState extends State<PantallaLottie> with TickerProviderStateMixin {
  /// Controller que controla la reproducción de Lottie.
  /// Permite pausar, avanzar y sincronizar frames exactos.
  late final AnimationController _ctrl;
  int _tab = 0;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lottie y Rive'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: IndexedStack(
        index: _tab,
        children: [_seccionBasico(), _seccionControl(), _seccionComparativa()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.play_circle), label: 'Básico'),
          NavigationDestination(icon: Icon(Icons.tune), label: 'Control'),
          NavigationDestination(icon: Icon(Icons.compare), label: 'vs Rive'),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // Sección 1: Lottie básico desde assets y desde red.
  // ----------------------------------------------------------
  Widget _seccionBasico() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Lottie.asset y Lottie.network', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _placeholder(Colors.cyan, 'Lottie.asset("assets/lottie/loading.json")'),
          const SizedBox(height: 16),
          _codigo('''
// Desde assets locales:
Lottie.asset('assets/lottie/loading.json',
  width: 200, height: 200,
  repeat: true,
),

// Desde URL:
Lottie.network('https://assets.lottiefiles.com/lf20_xxxx.json'),
'''),
          const SizedBox(height: 8),
          const Text('Descarga archivos gratis en lottiefiles.com',
              style: TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // Sección 2: Lottie controlado con AnimationController.
  // Útil para disparar la animación en un evento específico.
  // ----------------------------------------------------------
  Widget _seccionControl() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Lottie con AnimationController', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _placeholder(Colors.green, 'Controlado por AnimationController'),
          const SizedBox(height: 16),
          _codigo('''
// Vincular controller de Flutter con Lottie:
Lottie.asset(
  'assets/lottie/success.json',
  controller: _ctrl,
  onLoaded: (comp) {
    _ctrl.duration = comp.duration;
    _ctrl.forward(); // Reproducir una vez
  },
),

// Reproducir y resetear:
_ctrl.forward().then((_) => _ctrl.reset());
'''),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () => _ctrl.forward(from: 0), child: const Text('Play')),
              ElevatedButton(onPressed: () => _ctrl.stop(), child: const Text('Pausa')),
              ElevatedButton(onPressed: () => _ctrl.repeat(), child: const Text('Bucle')),
            ],
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // Sección 3: Comparativa Lottie vs Rive.
  // ----------------------------------------------------------
  Widget _seccionComparativa() {
    const filas = [
      ['', 'Lottie', 'Rive'],
      ['Formato', 'JSON (AE)', '.riv'],
      ['Interactividad', 'Lineal', 'Máq. estados'],
      ['Tamaño', 'Mediano', 'Pequeño'],
      ['Aprendizaje', 'Bajo', 'Medio'],
      ['Ideal para', 'Loaders', 'Botones/chars'],
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Lottie vs Rive', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Table(
            border: TableBorder.all(color: Colors.grey.shade300),
            columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(2), 2: FlexColumnWidth(2)},
            children: filas.map((fila) {
              final esHeader = fila == filas.first;
              return TableRow(
                decoration: BoxDecoration(color: esHeader ? Colors.cyan.shade100 : null),
                children: fila.map((c) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(c, style: TextStyle(fontWeight: esHeader ? FontWeight.bold : FontWeight.normal, fontSize: 12)),
                )).toList(),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          _codigo('''
// Rive en Flutter (paquete: rive: ^0.12.x):
RiveAnimation.asset(
  'assets/animations/login.riv',
  stateMachines: ['ButtonMachine'],
  onInit: (artboard) {
    final ctrl = StateMachineController
        .fromArtboard(artboard, 'ButtonMachine');
    artboard.addController(ctrl!);
  },
),'''),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // Widgets auxiliares: placeholder y bloque de código
  // ----------------------------------------------------------

  /// Widget que simula visualmente un Lottie rotando un ícono.
  Widget _placeholder(Color color, String etiqueta) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Container(
        width: double.infinity,
        height: 140,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: _ctrl.value * 6.28,
              child: Icon(Icons.animation, size: 52, color: color),
            ),
            const SizedBox(height: 6),
            Text(etiqueta, style: TextStyle(fontSize: 11, color: color), textAlign: TextAlign.center),
            const Text('(Reemplazar con Lottie.asset real)', style: TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  /// Bloque de código con fondo oscuro estilo IDE.
  Widget _codigo(String c) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(8)),
    child: Text(c, style: const TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFFCCCCCC))),
  );
}
