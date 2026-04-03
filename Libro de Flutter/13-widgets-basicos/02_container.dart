// =============================================================================
// ARCHIVO: 02_container.dart
// TEMA: Container, BoxDecoration y espaciado en Flutter
// =============================================================================
//
// Container es uno de los widgets más versátiles de Flutter. Puede actuar
// como caja con dimensiones, color, bordes, sombras y gradientes. También
// aplica margin y padding alrededor y dentro de su contenido.
// SizedBox es la alternativa ligera para cuando solo necesitas espacio.
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
      title: 'Container Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const PantallaContainer(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA PRINCIPAL
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra Container con todas sus capacidades de decoración y espaciado.
class PantallaContainer extends StatelessWidget {
  const PantallaContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Container y BoxDecoration'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SeccionBasico(),
            SizedBox(height: 24),
            _SeccionDecoracion(),
            SizedBox(height: 24),
            _SeccionMarginPadding(),
            SizedBox(height: 24),
            _SeccionSizedBox(),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 1 — CONTAINER BÁSICO
// ────────────────────────────────────────────────────────────────────────────

/// Container sin hijo = espacio vacío con dimensiones definidas.
class _SeccionBasico extends StatelessWidget {
  const _SeccionBasico();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('1. Container básico',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // Container con solo color y dimensiones (sin hijo).
        // Se convierte en un bloque de color sólido.
        Container(
          width: 120,
          height: 60,
          // color y decoration son mutuamente excluyentes.
          // Si usas decoration, pon el color DENTRO de BoxDecoration.
          color: Colors.orange,
        ),
        const SizedBox(height: 8),

        // Container con hijo centrado.
        Container(
          width: 200,
          height: 80,
          color: Colors.orange.shade100,
          // alignment centra el hijo dentro del container.
          alignment: Alignment.center,
          child: const Text('Hijo centrado'),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 2 — BOXDECORATION
// ────────────────────────────────────────────────────────────────────────────

/// BoxDecoration permite agregar bordes, esquinas redondeadas, sombras y gradientes.
class _SeccionDecoracion extends StatelessWidget {
  const _SeccionDecoracion();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('2. BoxDecoration',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // Esquinas redondeadas con borderRadius.
        Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.orange,
            // borderRadius: redondea las 4 esquinas con el mismo radio.
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: const Text('Esquinas redondeadas',
              style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 8),

        // Borde con color y ancho.
        Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange, width: 2),
          ),
          alignment: Alignment.center,
          child: const Text('Con borde naranja'),
        ),
        const SizedBox(height: 8),

        // Sombra con boxShadow. Es una lista: puedes tener múltiples sombras.
        Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 12,   // difuminado de la sombra
                offset: const Offset(0, 4), // desplazamiento X, Y
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Text('Con sombra'),
        ),
        const SizedBox(height: 8),

        // Gradiente lineal de dos colores.
        Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [Colors.orange, Colors.deepOrange],
              // begin y end definen la dirección del gradiente.
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          alignment: Alignment.center,
          child: const Text('Gradiente',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 3 — MARGIN VS PADDING
// ────────────────────────────────────────────────────────────────────────────

/// Ilustra la diferencia entre margin (espacio exterior) y padding (interior).
class _SeccionMarginPadding extends StatelessWidget {
  const _SeccionMarginPadding();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('3. Margin vs Padding',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // MARGIN: espacio entre el Container y sus vecinos externos.
        // El fondo azul claro muestra dónde empieza el área del Container.
        ColoredBox(
          color: Colors.blue.shade50,
          child: Container(
            // margin empuja el container HACIA ADENTRO dentro de su padre.
            margin: const EdgeInsets.all(16),
            color: Colors.blue.shade200,
            child: const Text('Con margin de 16'),
          ),
        ),
        const SizedBox(height: 8),

        // PADDING: espacio entre el borde del Container y su hijo.
        // El color naranja llega hasta el borde, pero el texto tiene margen.
        Container(
          color: Colors.orange.shade200,
          // padding empuja el contenido HACIA EL CENTRO.
          padding: const EdgeInsets.all(16),
          child: const Text('Con padding de 16'),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 4 — SIZEBOX COMO ALTERNATIVA LIVIANA
// ────────────────────────────────────────────────────────────────────────────

/// SizedBox es más eficiente que Container cuando solo necesitas espacio o tamaño.
class _SeccionSizedBox extends StatelessWidget {
  const _SeccionSizedBox();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('4. SizedBox',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('↑ Esto usa SizedBox(height: 8) como separador'),

        // SizedBox.expand: ocupa todo el espacio disponible del padre.
        // SizedBox.shrink: colapsa a 0x0 (útil como placeholder invisible).
        const Text('SizedBox.shrink() →'),
        const SizedBox.shrink(), // ocupa 0 píxeles
        const Text('← nada de espacio'),

        const SizedBox(height: 8),
        // SizedBox como restricción de tamaño para un hijo.
        const SizedBox(
          width: 150,
          height: 40,
          child: ColoredBox(
            color: Colors.orange,
            child: Center(child: Text('150 x 40')),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Prueba BoxDecoration con shape: BoxShape.circle para hacer
//      un contenedor perfectamente circular.
//   2. Cambia LinearGradient por RadialGradient para un gradiente radial.
//   3. Usa EdgeInsets.only(left: 16, top: 8) en el padding para aplicar
//      espaciado asimétrico solo en ciertos lados.
//   4. Combina múltiples BoxShadow para crear efectos de profundidad complejos.
// =============================================================================
