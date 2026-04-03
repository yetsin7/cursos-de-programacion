// =============================================================================
// ARCHIVO: 04_stack.dart
// TEMA: Stack y Positioned — superponer widgets en Flutter
// =============================================================================
//
// Stack permite colocar widgets uno encima del otro (como capas en Photoshop).
// Positioned permite ubicar un widget en una posición exacta dentro del Stack.
// Es el widget ideal para badges, overlays, posiciones absolutas y efectos
// visuales como texto sobre imagen.
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
      title: 'Stack Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const PantallaStack(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA PRINCIPAL
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra Stack con Positioned y casos de uso reales.
class PantallaStack extends StatelessWidget {
  const PantallaStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack y Positioned'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SeccionStackBasico(),
            SizedBox(height: 24),
            _SeccionPositioned(),
            SizedBox(height: 24),
            _SeccionBadge(),
            SizedBox(height: 24),
            _SeccionTextoSobreImagen(),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 1 — STACK BÁSICO
// ────────────────────────────────────────────────────────────────────────────

/// Stack sin Positioned: los hijos sin posición se apilan en la esquina
/// superior izquierda (o según alignment del Stack).
class _SeccionStackBasico extends StatelessWidget {
  const _SeccionStackBasico();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('1. Stack básico',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: Stack(
            // alignment: dónde se colocan los hijos sin Positioned.
            // Por defecto es Alignment.topLeft.
            alignment: Alignment.topLeft,
            children: [
              // El primer hijo define el tamaño del Stack si no se especifica.
              Container(width: 120, height: 120, color: Colors.purple.shade100),
              Container(width: 90, height: 90, color: Colors.purple.shade300),
              Container(width: 60, height: 60, color: Colors.purple.shade500),
              Container(width: 30, height: 30, color: Colors.purple.shade700),
            ],
          ),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 2 — POSITIONED
// ────────────────────────────────────────────────────────────────────────────

/// Positioned ubica un widget en coordenadas absolutas dentro del Stack.
/// Puede usar top, bottom, left, right para anclarse a cualquier borde.
class _SeccionPositioned extends StatelessWidget {
  const _SeccionPositioned();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('2. Positioned',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          height: 150,
          child: Stack(
            children: [
              // Fondo que ocupa todo el Stack.
              Container(
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purple.shade200),
                ),
              ),

              // top+left: esquina superior izquierda.
              const Positioned(
                top: 8,
                left: 8,
                child: Text('↖ top:8 left:8',
                    style: TextStyle(fontSize: 12)),
              ),

              // top+right: esquina superior derecha.
              const Positioned(
                top: 8,
                right: 8,
                child: Text('top:8 right:8 ↗',
                    style: TextStyle(fontSize: 12)),
              ),

              // bottom+left: esquina inferior izquierda.
              const Positioned(
                bottom: 8,
                left: 8,
                child: Text('↙ bottom:8 left:8',
                    style: TextStyle(fontSize: 12)),
              ),

              // bottom+right: esquina inferior derecha.
              const Positioned(
                bottom: 8,
                right: 8,
                child: Text('bottom:8 right:8 ↘',
                    style: TextStyle(fontSize: 12)),
              ),

              // Centro exacto usando Positioned.fill + Align.
              const Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Centro', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 3 — BADGE (CASO DE USO REAL)
// ────────────────────────────────────────────────────────────────────────────

/// Ícono de carrito con badge de cantidad: patrón muy común en e-commerce.
class _SeccionBadge extends StatelessWidget {
  const _SeccionBadge();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('3. Badge sobre ícono',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            // Badge manual con Stack.
            Stack(
              clipBehavior: Clip.none, // permite que el badge sobresalga
              children: [
                const Icon(Icons.shopping_cart, size: 40),
                Positioned(
                  top: -6,
                  right: -6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 32),
            // Material 3 incluye Badge nativo.
            Badge(
              label: const Text('12'),
              child: const Icon(Icons.notifications, size: 40),
            ),
          ],
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 4 — TEXTO SOBRE IMAGEN (OVERLAY)
// ────────────────────────────────────────────────────────────────────────────

/// Tarjeta con texto superpuesto sobre un fondo de color (simula imagen).
class _SeccionTextoSobreImagen extends StatelessWidget {
  const _SeccionTextoSobreImagen();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('4. Texto sobre fondo (overlay)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 120,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand, // expande todos los hijos al tamaño del Stack
              children: [
                // Capa 1: fondo de color (en una app real sería Image.network).
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple.shade800, Colors.purple.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                // Capa 2: overlay oscuro semitransparente para legibilidad.
                Container(
                  color: Colors.black.withValues(alpha: 0.3),
                ),
                // Capa 3: texto encima de todo.
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Flutter para todos',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Aprende desde cero',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Cambia clipBehavior: Clip.none a Clip.hardEdge en el Stack del badge
//      para ver cómo se recorta el contenido que sobresale.
//   2. Usa Positioned.fill para crear un overlay que cubra toda la tarjeta
//      al detectar un hover (con MouseRegion en web/desktop).
//   3. Anima la posición de un Positioned usando AnimatedPositioned para
//      crear un elemento que se mueve suavemente por la pantalla.
// =============================================================================
