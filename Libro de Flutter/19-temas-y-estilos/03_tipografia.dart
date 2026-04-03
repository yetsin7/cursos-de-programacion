// =============================================================================
// ARCHIVO: 03_tipografia.dart
// TEMA: Sistema tipográfico de Material 3 y Google Fonts
// =============================================================================
// CÓMO USAR: copiar como lib/main.dart y ejecutar flutter run
// DEPENDENCIA: agregar en pubspec.yaml: google_fonts: ^6.2.1
// =============================================================================

import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart'; // Descomentar al agregar dependencia

void main() => runApp(const AppTipografia());

/// App que demuestra el sistema tipográfico de Material 3.
class AppTipografia extends StatefulWidget {
  const AppTipografia({super.key});

  @override
  State<AppTipografia> createState() => _AppTipografiaState();
}

class _AppTipografiaState extends State<AppTipografia> {
  // Factor de escala del texto para demostrar accesibilidad
  double _escalaTexto = 1.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tipografía',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),

        // Para usar Google Fonts, descomenta estas líneas:
        // textTheme: GoogleFonts.nunitoTextTheme(),
        // O personalizar fuentes específicas:
        // textTheme: TextTheme(
        //   displayLarge: GoogleFonts.playfairDisplay(fontSize: 57),
        //   bodyLarge: GoogleFonts.nunito(fontSize: 16),
        // ),
      ),
      // Usar MediaQuery para controlar el textScaler globalmente
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(_escalaTexto),
          ),
          child: child!,
        );
      },
      home: PantallaTipografia(
        escala: _escalaTexto,
        alCambiarEscala: (v) => setState(() => _escalaTexto = v),
      ),
    );
  }
}

/// Pantalla que muestra todos los estilos del TextTheme de Material 3.
class PantallaTipografia extends StatelessWidget {
  final double escala;
  final ValueChanged<double> alCambiarEscala;

  const PantallaTipografia({
    super.key,
    required this.escala,
    required this.alCambiarEscala,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final tt = tema.textTheme; // TextTheme completo

    return Scaffold(
      appBar: AppBar(title: const Text('Tipografía Material 3'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Control de escala de texto (simula accesibilidad del sistema)
          _ControlEscala(escala: escala, alCambiar: alCambiarEscala),
          const Divider(height: 32),

          // Display: textos muy grandes para titulares llamativos
          _FilaTipografia('displayLarge', tt.displayLarge),
          _FilaTipografia('displayMedium', tt.displayMedium),
          _FilaTipografia('displaySmall', tt.displaySmall),
          const Divider(height: 24),

          // Headline: títulos de sección
          _FilaTipografia('headlineLarge', tt.headlineLarge),
          _FilaTipografia('headlineMedium', tt.headlineMedium),
          _FilaTipografia('headlineSmall', tt.headlineSmall),
          const Divider(height: 24),

          // Title: títulos de tarjetas y diálogos
          _FilaTipografia('titleLarge', tt.titleLarge),
          _FilaTipografia('titleMedium', tt.titleMedium),
          _FilaTipografia('titleSmall', tt.titleSmall),
          const Divider(height: 24),

          // Body: texto principal de contenido
          _FilaTipografia('bodyLarge', tt.bodyLarge),
          _FilaTipografia('bodyMedium', tt.bodyMedium),
          _FilaTipografia('bodySmall', tt.bodySmall),
          const Divider(height: 24),

          // Label: etiquetas de botones y chips
          _FilaTipografia('labelLarge', tt.labelLarge),
          _FilaTipografia('labelMedium', tt.labelMedium),
          _FilaTipografia('labelSmall', tt.labelSmall),
          const SizedBox(height: 32),

          // Ejemplo de uso en un componente real
          _EjemploArticulo(textTheme: tt),
        ],
      ),
    );
  }
}

/// Control deslizante para ajustar la escala del texto.
class _ControlEscala extends StatelessWidget {
  final double escala;
  final ValueChanged<double> alCambiar;
  const _ControlEscala({required this.escala, required this.alCambiar});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Escala de texto: ${escala.toStringAsFixed(1)}x',
            style: Theme.of(context).textTheme.titleMedium),
        Slider(
          value: escala,
          min: 0.8,
          max: 1.6,
          divisions: 8,
          label: '${escala.toStringAsFixed(1)}x',
          onChanged: alCambiar,
        ),
        Text(
          'Cambia esta escala para simular la configuración de accesibilidad del dispositivo.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

/// Fila que muestra el nombre y el estilo de un tipo de texto.
class _FilaTipografia extends StatelessWidget {
  final String nombre;
  final TextStyle? estilo;
  const _FilaTipografia(this.nombre, this.estilo);

  @override
  Widget build(BuildContext context) {
    if (estilo == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              nombre,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ),
          Expanded(
            child: Text('Texto de ejemplo', style: estilo),
          ),
        ],
      ),
    );
  }
}

/// Ejemplo realista de un artículo que usa el sistema tipográfico correctamente.
class _EjemploArticulo extends StatelessWidget {
  final TextTheme textTheme;
  const _EjemploArticulo({required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ejemplo de artículo', style: textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            )),
            const SizedBox(height: 4),
            Text('Tipografía consistente', style: textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text('Por el equipo de diseño  · 5 min de lectura',
                style: textTheme.bodySmall),
            const SizedBox(height: 12),
            Text(
              'El sistema tipográfico de Material 3 define 15 estilos '
              'organizados en 5 categorías: Display, Headline, Title, Body y Label. '
              'Cada uno tiene un propósito específico para mantener la jerarquía visual.',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text('Conclusión', style: textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              'Usar el TextTheme correctamente garantiza una UI coherente '
              'y accesible en todos los tamaños de pantalla.',
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
