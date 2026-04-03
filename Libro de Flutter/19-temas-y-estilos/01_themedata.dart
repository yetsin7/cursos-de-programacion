// =============================================================================
// ARCHIVO: 01_themedata.dart
// TEMA: ThemeData y personalización de componentes con Material 3
// =============================================================================
// CÓMO USAR: copiar como lib/main.dart y ejecutar flutter run
// =============================================================================

import 'package:flutter/material.dart';

void main() => runApp(const AppThemeData());

/// Punto de entrada para la demostración de ThemeData.
class AppThemeData extends StatelessWidget {
  const AppThemeData({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThemeData Demo',
      debugShowCheckedModeBanner: false,
      // useMaterial3: true activa los componentes de Material Design 3
      theme: ThemeData(
        useMaterial3: true,
        // ColorScheme.fromSeed genera una paleta completa de 30+ colores
        // a partir de un único color semilla
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),

        // Personalizar el estilo global del AppBar
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),

        // Personalizar el estilo global de ElevatedButton
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),

        // Personalizar el estilo global de las Card
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const PantallaTheme(),
    );
  }
}

/// Pantalla principal que muestra componentes con el tema aplicado.
class PantallaTheme extends StatelessWidget {
  const PantallaTheme({super.key});

  @override
  Widget build(BuildContext context) {
    // Theme.of(context) accede al tema actual desde cualquier widget
    final tema = Theme.of(context);
    final colores = tema.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ThemeData Demo'),
        backgroundColor: colores.primaryContainer,
        foregroundColor: colores.onPrimaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Mostrar los colores principales del ColorScheme
            _SeccionColores(colores: colores),
            const SizedBox(height: 20),

            // Mostrar cómo se ven los botones con el tema
            _SeccionBotones(),
            const SizedBox(height: 20),

            // Sub-tema: aplicar un tema diferente solo a esta sección
            Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.orange,
                  brightness: Brightness.light,
                ),
              ),
              child: const _SeccionSubTema(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Muestra los colores principales del ColorScheme actual.
class _SeccionColores extends StatelessWidget {
  final ColorScheme colores;
  const _SeccionColores({required this.colores});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ColorScheme', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _ChipColor('primary', colores.primary, colores.onPrimary),
                _ChipColor('secondary', colores.secondary, colores.onSecondary),
                _ChipColor('tertiary', colores.tertiary, colores.onTertiary),
                _ChipColor('surface', colores.surface, colores.onSurface),
                _ChipColor('error', colores.error, colores.onError),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Chip visual para mostrar un color con su nombre.
class _ChipColor extends StatelessWidget {
  final String nombre;
  final Color fondo;
  final Color texto;
  const _ChipColor(this.nombre, this.fondo, this.texto);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: fondo, borderRadius: BorderRadius.circular(20)),
      child: Text(nombre, style: TextStyle(color: texto, fontSize: 12)),
    );
  }
}

/// Muestra los distintos tipos de botones con el tema aplicado.
class _SeccionBotones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Botones', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
                FilledButton(onPressed: () {}, child: const Text('Filled')),
                OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
                TextButton(onPressed: () {}, child: const Text('Text')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Sección con un sub-tema diferente aplicado mediante el widget Theme.
/// Demuestra cómo Theme sobreescribe el tema solo para sus descendientes.
class _SeccionSubTema extends StatelessWidget {
  const _SeccionSubTema();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sub-tema (naranja)',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Botón con sub-tema'),
            ),
          ],
        ),
      ),
    );
  }
}
