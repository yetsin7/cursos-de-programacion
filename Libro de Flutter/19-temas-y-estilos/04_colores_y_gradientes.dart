// =============================================================================
// ARCHIVO: 04_colores_y_gradientes.dart
// TEMA: Sistema de colores, opacidad y gradientes en Flutter
// =============================================================================
// CÓMO USAR: copiar como lib/main.dart y ejecutar flutter run
// =============================================================================

import 'package:flutter/material.dart';

void main() => runApp(const AppColores());

/// App que demuestra el sistema de colores y gradientes de Flutter.
class AppColores extends StatelessWidget {
  const AppColores({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colores y Gradientes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      home: const PantallaColores(),
    );
  }
}

/// Pantalla con demos de colores, opacidad y gradientes.
class PantallaColores extends StatelessWidget {
  const PantallaColores({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Colores y Gradientes'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SeccionFormasColor(),
          SizedBox(height: 20),
          _SeccionOpacidad(),
          SizedBox(height: 20),
          _SeccionGradientes(),
          SizedBox(height: 20),
          _SeccionColorScheme(),
        ],
      ),
    );
  }
}

/// Muestra las diferentes formas de definir un color en Flutter.
class _SeccionFormasColor extends StatelessWidget {
  const _SeccionFormasColor();

  @override
  Widget build(BuildContext context) {
    return _Seccion(
      titulo: 'Formas de definir colores',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          // Colors.*: constantes predefinidas de Material Design
          _MuestraColor('Colors.red', Colors.red),
          _MuestraColor('Colors.blue[700]', Colors.blue[700]!),
          // Color(0xFFRRGGBB): hexadecimal con alpha al inicio
          // FF = completamente opaco, 00 = completamente transparente
          _MuestraColor('0xFF6750A4', const Color(0xFF6750A4)),
          // fromARGB(alpha, red, green, blue) — valores de 0 a 255
          _MuestraColor('fromARGB', const Color.fromARGB(255, 220, 84, 30)),
          // fromRGBO(red, green, blue, opacity) — opacity de 0.0 a 1.0
          _MuestraColor('fromRGBO', const Color.fromRGBO(30, 140, 90, 1.0)),
        ],
      ),
    );
  }
}

/// Demuestra el uso de opacidad en colores.
class _SeccionOpacidad extends StatelessWidget {
  const _SeccionOpacidad();

  @override
  Widget build(BuildContext context) {
    const colorBase = Color(0xFF6750A4);
    return _Seccion(
      titulo: 'Opacidad con withOpacity()',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _MuestraColor('100%', colorBase.withOpacity(1.0)),
          _MuestraColor('75%', colorBase.withOpacity(0.75)),
          _MuestraColor('50%', colorBase.withOpacity(0.5)),
          _MuestraColor('25%', colorBase.withOpacity(0.25)),
          _MuestraColor('10%', colorBase.withOpacity(0.1)),
        ],
      ),
    );
  }
}

/// Muestra los tres tipos de gradientes disponibles en Flutter.
class _SeccionGradientes extends StatelessWidget {
  const _SeccionGradientes();

  @override
  Widget build(BuildContext context) {
    return _Seccion(
      titulo: 'Gradientes en BoxDecoration',
      child: Column(
        children: [
          // LinearGradient: de un punto a otro en línea recta
          _CajaGradiente(
            etiqueta: 'LinearGradient (horizontal)',
            gradiente: const LinearGradient(
              colors: [Color(0xFF6750A4), Color(0xFF03DAC6)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          const SizedBox(height: 12),
          _CajaGradiente(
            etiqueta: 'LinearGradient (diagonal)',
            gradiente: const LinearGradient(
              colors: [Colors.pink, Colors.orange, Colors.yellow],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          const SizedBox(height: 12),
          // RadialGradient: irradia desde un punto central hacia afuera
          _CajaGradiente(
            etiqueta: 'RadialGradient',
            gradiente: const RadialGradient(
              center: Alignment.center,
              radius: 0.8,
              colors: [Colors.white, Color(0xFF6750A4)],
            ),
          ),
          const SizedBox(height: 12),
          // SweepGradient: barre alrededor de un punto central
          _CajaGradiente(
            etiqueta: 'SweepGradient',
            gradiente: const SweepGradient(
              colors: [Colors.red, Colors.yellow, Colors.green, Colors.blue, Colors.red],
            ),
          ),
        ],
      ),
    );
  }
}

/// Muestra los roles del ColorScheme de Material 3.
class _SeccionColorScheme extends StatelessWidget {
  const _SeccionColorScheme();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _Seccion(
      titulo: 'Roles del ColorScheme (Material 3)',
      child: Column(
        children: [
          _FilaRol('primary / onPrimary', cs.primary, cs.onPrimary,
              'Acciones principales'),
          _FilaRol('secondary / onSecondary', cs.secondary, cs.onSecondary,
              'Acciones secundarias'),
          _FilaRol('tertiary / onTertiary', cs.tertiary, cs.onTertiary,
              'Contrastes y acentos'),
          _FilaRol('error / onError', cs.error, cs.onError, 'Errores y alertas'),
          _FilaRol('surface / onSurface', cs.surface, cs.onSurface,
              'Fondo de tarjetas'),
        ],
      ),
    );
  }
}

// ─── Widgets auxiliares ───────────────────────────────────────────────────────

/// Contenedor de sección con título.
class _Seccion extends StatelessWidget {
  final String titulo;
  final Widget child;
  const _Seccion({required this.titulo, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titulo, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

/// Cuadrado de color con etiqueta debajo.
class _MuestraColor extends StatelessWidget {
  final String etiqueta;
  final Color color;
  const _MuestraColor(this.etiqueta, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 64,
          child: Text(etiqueta,
              style: const TextStyle(fontSize: 10), textAlign: TextAlign.center),
        ),
      ],
    );
  }
}

/// Caja que aplica un gradiente como fondo.
class _CajaGradiente extends StatelessWidget {
  final String etiqueta;
  final Gradient gradiente;
  const _CajaGradiente({required this.etiqueta, required this.gradiente});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        gradient: gradiente,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(etiqueta,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, shadows: [
            Shadow(blurRadius: 4, color: Colors.black45),
          ])),
    );
  }
}

/// Fila que muestra un par de colores (fondo y texto) con descripción.
class _FilaRol extends StatelessWidget {
  final String nombre;
  final Color fondo;
  final Color texto;
  final String descripcion;
  const _FilaRol(this.nombre, this.fondo, this.texto, this.descripcion);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 36,
            decoration: BoxDecoration(
              color: fondo,
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
            ),
            alignment: Alignment.center,
            child: Text(nombre.split('/')[0].trim(),
                style: TextStyle(color: texto, fontSize: 10)),
          ),
          Container(
            width: 60,
            height: 36,
            decoration: BoxDecoration(
              color: texto,
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
            ),
            alignment: Alignment.center,
            child: Text('on', style: TextStyle(color: fondo, fontSize: 10)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(descripcion, style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
