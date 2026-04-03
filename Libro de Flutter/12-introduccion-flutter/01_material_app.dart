// =============================================================================
// ARCHIVO: 01_material_app.dart
// TEMA: La raíz de toda app Flutter — MaterialApp
// =============================================================================
//
// MaterialApp es el widget raíz de cualquier app que sigue las guías de diseño
// Material (Google). Configura el tema, el título, la navegación y el idioma
// de toda la aplicación desde un único lugar.
//
// CÓMO USAR:
//   1. Crea un proyecto Flutter: flutter create mi_app
//   2. Reemplaza lib/main.dart con este archivo
//   3. Ejecuta: flutter run
//
// =============================================================================
import 'package:flutter/material.dart';

// Punto de entrada de toda aplicación Flutter.
// runApp() infla el widget raíz y lo conecta con la pantalla del dispositivo.
void main() {
  runApp(const MiApp());
}

// ────────────────────────────────────────────────────────────────────────────
// WIDGET RAÍZ
// ────────────────────────────────────────────────────────────────────────────

/// Widget raíz de la aplicación.
///
/// Es un StatelessWidget porque la configuración de la app no cambia
/// en tiempo de ejecución. Se marca como [const] para que Flutter pueda
/// reutilizarlo sin reconstruirlo innecesariamente.
class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Título de la app: aparece en el switcher de tareas del SO.
      title: 'Mi Primera App',

      // Oculta el banner rojo de "DEBUG" en la esquina superior derecha.
      debugShowCheckedModeBanner: false,

      // useMaterial3: true activa el diseño Material 3 (You), el más moderno.
      // Material 2 es el anterior; Material 3 tiene esquinas más redondeadas,
      // paletas de color dinámicas y componentes actualizados.
      theme: ThemeData(
        // ColorScheme.fromSeed genera una paleta completa y armoniosa
        // a partir de un solo color semilla. Flutter calcula automáticamente
        // primary, secondary, surface, background, error, etc.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          // brightness: Brightness.dark → activaría el tema oscuro
        ),
        useMaterial3: true,
      ),

      // darkTheme: opcional — se activa si el SO está en modo oscuro.
      // Si no se define, Flutter usa el theme claro siempre.
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),

      // themeMode controla qué tema se usa:
      // ThemeMode.system → sigue el SO (recomendado)
      // ThemeMode.light  → siempre claro
      // ThemeMode.dark   → siempre oscuro
      themeMode: ThemeMode.system,

      // home es la primera pantalla que ve el usuario.
      // Equivale a la ruta '/'.
      home: const PantallaInicio(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA PRINCIPAL
// ────────────────────────────────────────────────────────────────────────────

/// Primera pantalla de la app.
///
/// Scaffold provee la estructura visual básica de una pantalla Material:
/// barra superior, cuerpo, botón flotante, barra inferior, drawer, etc.
class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    // Theme.of(context) accede al ThemeData configurado en MaterialApp.
    // Usar los colores del tema garantiza consistencia y soporte de
    // modo oscuro automático.
    final colores = Theme.of(context).colorScheme;
    final tipografia = Theme.of(context).textTheme;

    return Scaffold(
      // AppBar: la barra superior de la pantalla.
      appBar: AppBar(
        // backgroundColor del AppBar tomado del tema actual.
        backgroundColor: colores.inversePrimary,
        title: const Text('MaterialApp — Módulo 12'),
      ),

      // body: el contenido principal de la pantalla.
      // Ocupa todo el espacio entre el AppBar y el fondo.
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text muestra una cadena de texto en pantalla.
            Text(
              '¡Hola, Flutter!',
              // textTheme.headlineMedium usa el estilo tipográfico del tema,
              // respetando la fuente, el tamaño y el peso definidos globalmente.
              style: tipografia.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Esta es tu primera app con MaterialApp',
              style: tipografia.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Muestra el color primario del tema para ilustrar ColorScheme.
            _TarjetaColor(
              etiqueta: 'Color primario del tema',
              color: colores.primary,
            ),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// WIDGET AUXILIAR REUTILIZABLE
// ────────────────────────────────────────────────────────────────────────────

/// Muestra un recuadro de color con una etiqueta descriptiva.
///
/// Ejemplo de widget reutilizable extraído del cuerpo principal para
/// mantener el código limpio y con responsabilidades bien separadas.
class _TarjetaColor extends StatelessWidget {
  /// Texto descriptivo que aparece encima del recuadro.
  final String etiqueta;

  /// Color que se mostrará en el recuadro.
  final Color color;

  const _TarjetaColor({required this.etiqueta, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(etiqueta, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        Container(
          width: 120,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            // borderRadius redondea las esquinas del contenedor.
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Cambia el seedColor a Colors.teal o Colors.orange y observa cómo
//      toda la paleta de la app cambia automáticamente.
//   2. Cambia themeMode a ThemeMode.dark para forzar el tema oscuro.
//   3. Agrega locale: const Locale('es') en MaterialApp y observa que
//      los textos del sistema (botones de diálogos, etc.) pasan a español.
//   4. Agrega supportedLocales: [Locale('es'), Locale('en')] para declarar
//      los idiomas soportados por tu app.
// =============================================================================
