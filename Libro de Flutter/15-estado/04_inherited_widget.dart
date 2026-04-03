// =============================================================================
// ARCHIVO: 04_inherited_widget.dart
// TEMA: InheritedWidget — compartir datos sin prop drilling
// =============================================================================
//
// InheritedWidget permite que cualquier descendiente en el árbol acceda
// a datos compartidos sin necesidad de pasarlos por cada nivel de widgets
// (prop drilling). Es la base interna de Provider, Theme y MediaQuery.
// Cuando los datos cambian, solo los widgets que lo usan se reconstruyen.
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
      title: 'InheritedWidget',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const PantallaInherited(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// INHERITED WIDGET — TEMA DE ACENTO PERSONALIZADO
// ────────────────────────────────────────────────────────────────────────────

/// InheritedWidget que comparte un color de acento con todos sus descendientes.
///
/// Cualquier widget dentro del árbol puede acceder al color de acento usando:
/// TemaAcento.of(context).colorAcento
///
/// Si el color cambia, SOLO los widgets que hayan llamado a TemaAcento.of()
/// con dependencia se reconstruyen (no todos los descendientes).
class TemaAcento extends InheritedWidget {
  /// Color de acento compartido con todos los descendientes.
  final Color colorAcento;

  /// Función para cambiar el color de acento (proporcionada por el padre).
  final VoidCallback onCambiarColor;

  const TemaAcento({
    super.key,
    required this.colorAcento,
    required this.onCambiarColor,
    required super.child,
  });

  /// Accede al TemaAcento más cercano en el árbol.
  ///
  /// Usa dependOnInheritedWidgetOfExactType para que el widget que llama
  /// se reconstruya cuando TemaAcento cambia.
  static TemaAcento of(BuildContext context) {
    final resultado =
        context.dependOnInheritedWidgetOfExactType<TemaAcento>();
    assert(resultado != null,
        'No se encontró TemaAcento en el árbol. Envuelve tu widget con TemaAcento.');
    return resultado!;
  }

  /// Versión que NO crea dependencia — solo lee el valor sin suscribirse.
  static TemaAcento? leerSinDependencia(BuildContext context) {
    return context.getInheritedWidgetOfExactType<TemaAcento>();
  }

  /// updateShouldNotify: retorna true si los datos cambiaron y los
  /// widgets dependientes deben reconstruirse.
  @override
  bool updateShouldNotify(TemaAcento oldWidget) {
    // Solo notifica si el color cambió.
    return colorAcento != oldWidget.colorAcento;
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA PRINCIPAL — PROVEE EL INHERITEDWIDGET
// ────────────────────────────────────────────────────────────────────────────

/// Pantalla raíz que provee TemaAcento a todo su subárbol.
class PantallaInherited extends StatefulWidget {
  const PantallaInherited({super.key});

  @override
  State<PantallaInherited> createState() => _PantallaInheritedState();
}

class _PantallaInheritedState extends State<PantallaInherited> {
  // Color de acento compartido a través de TemaAcento.
  Color _colorAcento = Colors.deepOrange;

  static const _colores = [
    Colors.deepOrange,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.red,
  ];
  int _indiceColor = 0;

  /// Cambia el color de acento al siguiente de la lista.
  void _cambiarColor() {
    setState(() {
      _indiceColor = (_indiceColor + 1) % _colores.length;
      _colorAcento = _colores[_indiceColor];
    });
  }

  @override
  Widget build(BuildContext context) {
    // TemaAcento envuelve todo el árbol de la pantalla.
    // Todos los descendientes pueden acceder a colorAcento via TemaAcento.of(context).
    return TemaAcento(
      colorAcento: _colorAcento,
      onCambiarColor: _cambiarColor,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('InheritedWidget'),
          backgroundColor: _colorAcento.withValues(alpha: 0.3),
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              _SeccionExplicacion(),
              SizedBox(height: 24),
              _NivelA(), // niveles anidados sin prop drilling
            ],
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// ÁRBOL DE WIDGETS — ACCESO SIN PROP DRILLING
// ────────────────────────────────────────────────────────────────────────────

/// Nivel A: accede directamente al InheritedWidget y lo muestra.
class _NivelA extends StatelessWidget {
  const _NivelA();

  @override
  Widget build(BuildContext context) {
    // context.dependOnInheritedWidgetOfExactType<TemaAcento>() en una línea:
    final tema = TemaAcento.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: tema.colorAcento, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Nivel A — colorAcento: ${tema.colorAcento}',
              style: TextStyle(color: tema.colorAcento, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          // El botón modifica el estado del ancestro a través del callback.
          ElevatedButton(
            onPressed: tema.onCambiarColor,
            style: ElevatedButton.styleFrom(backgroundColor: tema.colorAcento),
            child: const Text('Cambiar color desde Nivel A',
                style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 8),
          const _NivelB(),
        ],
      ),
    );
  }
}

/// Nivel B: widget intermedio que NO pasa el color manualmente — no hay prop drilling.
class _NivelB extends StatelessWidget {
  const _NivelB();

  @override
  Widget build(BuildContext context) {
    final color = TemaAcento.of(context).colorAcento;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nivel B — accede al color sin recibir prop',
              style: TextStyle(color: color)),
          const _NivelC(),
        ],
      ),
    );
  }
}

/// Nivel C: widget profundamente anidado que también accede al color directamente.
class _NivelC extends StatelessWidget {
  const _NivelC();

  @override
  Widget build(BuildContext context) {
    final color = TemaAcento.of(context).colorAcento;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Icon(Icons.circle, color: color, size: 16),
          const SizedBox(width: 8),
          Text('Nivel C — también accede al color',
              style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN EXPLICACIÓN
// ────────────────────────────────────────────────────────────────────────────

/// Explicación de las limitaciones del InheritedWidget.
class _SeccionExplicacion extends StatelessWidget {
  const _SeccionExplicacion();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.shade300),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Por qué existe Provider',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(
            'InheritedWidget es poderoso pero verboso:\n'
            '• Requiere mucho código boilerplate\n'
            '• No tiene métodos de actualización integrados\n'
            '• Difícil de combinar múltiples sources de datos\n\n'
            'Provider (pub.dev) resuelve todos estos problemas\n'
            'usando InheritedWidget internamente pero con\n'
            'una API mucho más simple y ergonómica.',
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Agrega un segundo dato al TemaAcento (ej: double tamañoFuente) y
//      úsalo en los widgets hijos para cambiar el tamaño de texto globalmente.
//   2. Observa cómo Theme.of(context), MediaQuery.of(context) y
//      Navigator.of(context) usan exactamente este mismo mecanismo
//      internamente — son InheritedWidgets del framework.
//   3. Instala el paquete 'provider' y refactoriza este ejemplo para usar
//      ChangeNotifierProvider + Consumer en lugar de InheritedWidget puro.
// =============================================================================
