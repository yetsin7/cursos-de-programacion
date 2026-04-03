// =============================================================================
// ARCHIVO: 07_ejercicios.dart
// TEMA: Ejercicios de práctica — Widgets básicos
// =============================================================================
//
// Tres ejercicios de layout para consolidar los conceptos del Módulo 13.
// Cada ejercicio incluye la descripción del objetivo, las instrucciones paso
// a paso y una solución de referencia.
//
// CÓMO USAR:
//   1. Crea un proyecto Flutter: flutter create mi_app
//   2. Reemplaza lib/main.dart con este archivo
//   3. Intenta resolver cada ejercicio ANTES de ver la solución
//   4. Ejecuta: flutter run
//
// =============================================================================
import 'package:flutter/material.dart';

void main() => runApp(const MiApp());

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicios — Widgets Básicos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const PantallaEjercicios(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA DE EJERCICIOS
// ────────────────────────────────────────────────────────────────────────────

/// Lista los tres ejercicios con su descripción y solución de referencia.
class PantallaEjercicios extends StatelessWidget {
  const PantallaEjercicios({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicios — Módulo 13'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _Ejercicio1(),
            SizedBox(height: 32),
            _Ejercicio2(),
            SizedBox(height: 32),
            _Ejercicio3(),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 1 — TARJETA DE PERFIL
// ────────────────────────────────────────────────────────────────────────────

/// EJERCICIO 1: Construye una tarjeta de perfil de usuario.
///
/// OBJETIVO: Crear una tarjeta que muestre la foto (CircleAvatar),
/// nombre, cargo y botones de acción (Seguir, Mensaje).
///
/// INSTRUCCIONES:
///   1. Usa un Container con BoxDecoration para la tarjeta con sombra
///   2. Dentro, usa Column para organizar verticalmente
///   3. CircleAvatar en la parte superior (radio 40)
///   4. Nombre en texto grande y negrita
///   5. Cargo en texto gris pequeño
///   6. Un Row con dos botones: FilledButton y OutlinedButton
class _Ejercicio1 extends StatelessWidget {
  const _Ejercicio1();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Encabezado del ejercicio.
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue.shade700,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Ejercicio 1 — Tarjeta de perfil',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),

        // Solución de referencia.
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  'https://picsum.photos/seed/perfil/100/100',
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'María García',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Desarrolladora Flutter Senior',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(onPressed: () {}, child: const Text('Seguir')),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Mensaje'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 2 — BARRA DE ESTADÍSTICAS
// ────────────────────────────────────────────────────────────────────────────

/// EJERCICIO 2: Construye una barra de estadísticas con tres columnas.
///
/// OBJETIVO: Crear un Row con 3 columnas de estadísticas (seguidores,
/// publicaciones, seguidos) separadas por divisores verticales.
///
/// INSTRUCCIONES:
///   1. Usa un Row con 3 hijos de tipo Expanded
///   2. Cada hijo es una Column con número grande (Text) y etiqueta (Text)
///   3. Separa las columnas con VerticalDivider o Container de 1px de ancho
///   4. Envuelve todo en un Container con borde y padding
class _Ejercicio2 extends StatelessWidget {
  const _Ejercicio2();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green.shade700,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Ejercicio 2 — Estadísticas',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),

        // Solución de referencia.
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                _ItemEstadistica(valor: '2.4K', etiqueta: 'Seguidores'),
                VerticalDivider(color: Colors.grey.shade300, thickness: 1),
                _ItemEstadistica(valor: '138', etiqueta: 'Publicaciones'),
                VerticalDivider(color: Colors.grey.shade300, thickness: 1),
                _ItemEstadistica(valor: '856', etiqueta: 'Seguidos'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Widget auxiliar para un ítem de estadística (número + etiqueta).
class _ItemEstadistica extends StatelessWidget {
  final String valor;
  final String etiqueta;

  const _ItemEstadistica({required this.valor, required this.etiqueta});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            valor,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            etiqueta,
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 3 — BANNER CON TEXTO SUPERPUESTO
// ────────────────────────────────────────────────────────────────────────────

/// EJERCICIO 3: Construye un banner con texto superpuesto sobre imagen.
///
/// OBJETIVO: Crear una tarjeta tipo banner de oferta usando Stack.
/// Debe mostrar un fondo de color/imagen, un badge "OFERTA" en la
/// esquina superior izquierda y texto de precio en la parte inferior.
///
/// INSTRUCCIONES:
///   1. Usa un Stack con clipBehavior: Clip.hardEdge
///   2. Capa 1: Container con gradiente de colores como fondo
///   3. Capa 2: Positioned (top, left) con un Container rojo → "OFERTA"
///   4. Capa 3: Positioned (bottom) con texto de título y precio
class _Ejercicio3 extends StatelessWidget {
  const _Ejercicio3();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.orange.shade700,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Ejercicio 3 — Banner de oferta',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),

        // Solución de referencia.
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 140,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Capa 1: fondo con gradiente.
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                // Capa 2: badge "OFERTA" en esquina superior izquierda.
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '🔥 OFERTA',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                // Capa 3: texto en la parte inferior.
                const Positioned(
                  bottom: 12,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Curso Flutter Completo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\$9.99  (antes \$49.99)',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
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
//   1. Modifica la tarjeta del Ejercicio 1 para agregar un counter de
//      publicaciones justo debajo del avatar usando Stack y Positioned.
//   2. En el Ejercicio 2, agrega animaciones de conteo usando TweenAnimationBuilder
//      para que los números aumenten desde 0 al valor final.
//   3. En el Ejercicio 3, agrega un botón "Ver oferta" en la esquina inferior
//      derecha usando Positioned(bottom, right).
// =============================================================================
