// =============================================================================
// ARCHIVO: 02_modo_oscuro.dart
// TEMA: Modo claro y oscuro con ThemeMode y ColorScheme adaptable
// =============================================================================
// CÓMO USAR: copiar como lib/main.dart y ejecutar flutter run
// =============================================================================

import 'package:flutter/material.dart';

void main() => runApp(const AppModoOscuro());

/// App raíz con soporte completo de modo claro y oscuro.
/// El ThemeMode se controla desde un ValueNotifier compartido.
class AppModoOscuro extends StatefulWidget {
  const AppModoOscuro({super.key});

  @override
  State<AppModoOscuro> createState() => _AppModoOscuroState();
}

class _AppModoOscuroState extends State<AppModoOscuro> {
  // ThemeMode.system respeta la preferencia del sistema operativo por defecto
  ThemeMode _modoTema = ThemeMode.system;

  /// Cambia el modo del tema y reconstruye la app.
  void _cambiarModo(ThemeMode modo) => setState(() => _modoTema = modo);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modo Oscuro',
      debugShowCheckedModeBanner: false,

      // Tema claro: ColorScheme con brillantez clara
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),

      // Tema oscuro: mismo color semilla pero con brillantez oscura
      // Flutter genera automáticamente los colores adecuados para modo oscuro
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),

      // themeMode determina cuál de los dos temas se usa
      themeMode: _modoTema,

      home: PantallaModoOscuro(modoActual: _modoTema, alCambiar: _cambiarModo),
    );
  }
}

/// Pantalla que permite al usuario cambiar entre modos de tema.
class PantallaModoOscuro extends StatelessWidget {
  final ThemeMode modoActual;
  final ValueChanged<ThemeMode> alCambiar;

  const PantallaModoOscuro({
    super.key,
    required this.modoActual,
    required this.alCambiar,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final colores = tema.colorScheme;

    // Detectar el brillo real del sistema (útil con ThemeMode.system)
    final brilloSistema = MediaQuery.platformBrightnessOf(context);
    final esModoOscuro = brilloSistema == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modo Oscuro'),
        centerTitle: true,
        actions: [
          // Switch rápido claro/oscuro en el AppBar
          IconButton(
            icon: Icon(
              modoActual == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
            ),
            tooltip: 'Cambiar modo',
            onPressed: () => alCambiar(
              modoActual == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Información del modo actual
            Card(
              color: colores.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(
                      esModoOscuro ? Icons.nightlight_round : Icons.wb_sunny,
                      size: 48,
                      color: colores.onPrimaryContainer,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Modo del sistema: ${esModoOscuro ? "Oscuro" : "Claro"}',
                      style: TextStyle(
                        color: colores.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'ThemeMode actual: ${_nombreModo(modoActual)}',
                      style: TextStyle(color: colores.onPrimaryContainer),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Selector de modo con tres opciones
            Text('Seleccionar modo:', style: tema.textTheme.titleMedium),
            const SizedBox(height: 8),
            _SelectorModo(modoActual: modoActual, alCambiar: alCambiar),
            const SizedBox(height: 20),

            // Muestra que los colores se adaptan automáticamente
            Text('Colores adaptativos:', style: tema.textTheme.titleMedium),
            const SizedBox(height: 8),
            _DemoColoresAdaptativos(colores: colores),
          ],
        ),
      ),
    );
  }

  /// Retorna el nombre legible del ThemeMode.
  String _nombreModo(ThemeMode modo) {
    switch (modo) {
      case ThemeMode.system:
        return 'Sistema';
      case ThemeMode.light:
        return 'Claro';
      case ThemeMode.dark:
        return 'Oscuro';
    }
  }
}

/// Widget con tres botones para seleccionar el ThemeMode.
class _SelectorModo extends StatelessWidget {
  final ThemeMode modoActual;
  final ValueChanged<ThemeMode> alCambiar;

  const _SelectorModo({required this.modoActual, required this.alCambiar});

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ThemeMode>(
      segments: const [
        ButtonSegment(
          value: ThemeMode.light,
          icon: Icon(Icons.light_mode),
          label: Text('Claro'),
        ),
        ButtonSegment(
          value: ThemeMode.system,
          icon: Icon(Icons.brightness_auto),
          label: Text('Sistema'),
        ),
        ButtonSegment(
          value: ThemeMode.dark,
          icon: Icon(Icons.dark_mode),
          label: Text('Oscuro'),
        ),
      ],
      selected: {modoActual},
      onSelectionChanged: (seleccion) => alCambiar(seleccion.first),
    );
  }
}

/// Muestra varios componentes con colores que se adaptan automáticamente al modo.
class _DemoColoresAdaptativos extends StatelessWidget {
  final ColorScheme colores;
  const _DemoColoresAdaptativos({required this.colores});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: Icon(Icons.palette, color: colores.primary),
            title: const Text('Primary'),
            subtitle: Text('${colores.primary}'),
            trailing: CircleAvatar(backgroundColor: colores.primary, radius: 14),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.layers, color: colores.secondary),
            title: const Text('Secondary'),
            trailing: CircleAvatar(backgroundColor: colores.secondary, radius: 14),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.crop_square, color: colores.surface),
            title: const Text('Surface'),
            trailing: CircleAvatar(
              backgroundColor: colores.surface,
              radius: 14,
              child: Icon(Icons.check, size: 14, color: colores.onSurface),
            ),
          ),
        ),
      ],
    );
  }
}
