// =============================================================================
// ARCHIVO: 03_riverpod_intro.dart
// TEMA: Gestión de estado con Riverpod — introducción
// =============================================================================
// CÓMO USAR: copiar como lib/main.dart y ejecutar flutter run
// DEPENDENCIA: agregar en pubspec.yaml: flutter_riverpod: ^2.5.1
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// =============================================================================
// DECLARACIÓN DE PROVIDERS (fuera del widget, a nivel global)
// Los providers en Riverpod son globales pero lazy — solo se crean cuando se usan
// =============================================================================

/// Provider simple: valor inmutable que no cambia.
/// Se usa para constantes o servicios sin estado.
final mensajeBienvenidaProvider = Provider<String>((ref) {
  return '¡Bienvenido a Riverpod!';
});

/// StateProvider: estado simple que puede cambiar.
/// Ideal para valores primitivos como contadores, booleans, strings.
final contadorProvider = StateProvider<int>((ref) => 0);

/// StateProvider para el nombre del usuario.
final nombreUsuarioProvider = StateProvider<String>((ref) => 'Invitado');

// =============================================================================
// PUNTO DE ENTRADA — ProviderScope es obligatorio en la raíz
// =============================================================================

void main() {
  runApp(
    // ProviderScope almacena el estado de todos los providers
    // Es obligatorio envolver la app con ProviderScope
    const ProviderScope(
      child: AppRiverpodIntro(),
    ),
  );
}

/// App raíz que usa Riverpod.
class AppRiverpodIntro extends StatelessWidget {
  const AppRiverpodIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Intro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan)),
      home: const PantallaRiverpod(),
    );
  }
}

// =============================================================================
// WIDGETS — ConsumerWidget en lugar de StatelessWidget
// ConsumerWidget recibe un WidgetRef para interactuar con los providers
// =============================================================================

/// Pantalla principal. Usa ConsumerWidget para acceder a los providers.
class PantallaRiverpod extends ConsumerWidget {
  const PantallaRiverpod({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch() se suscribe al provider y reconstruye cuando cambia
    // Es equivalente a context.watch<T>() en Provider
    final mensaje = ref.watch(mensajeBienvenidaProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod Intro'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Mostrar el valor de un Provider simple
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Provider (inmutable)',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(mensaje, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 4),
                  const Text(
                    'Provider<String> — valor constante, nunca cambia.\n'
                    'Ideal para servicios, repositorios, constantes.',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const _SeccionContador(),
          const SizedBox(height: 16),
          const _SeccionNombre(),
          const SizedBox(height: 16),
          const _ExplicacionRefWatch(),
        ],
      ),
    );
  }
}

/// Sección que demuestra StateProvider con un contador.
class _SeccionContador extends ConsumerWidget {
  const _SeccionContador();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch(contadorProvider) retorna el valor actual y suscribe al cambio
    final contador = ref.watch(contadorProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('StateProvider<int>',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  // ref.read() lee sin suscribirse — se usa en callbacks
                  onPressed: () => ref.read(contadorProvider.notifier).state--,
                ),
                Text('$contador',
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => ref.read(contadorProvider.notifier).state++,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                // ref.read().state = valor para modificar StateProvider
                onPressed: () => ref.read(contadorProvider.notifier).state = 0,
                child: const Text('Reiniciar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sección que demuestra StateProvider con un texto y la diferencia entre
/// ref.watch() y ref.read().
class _SeccionNombre extends ConsumerStatefulWidget {
  const _SeccionNombre();

  @override
  ConsumerState<_SeccionNombre> createState() => _SeccionNombreState();
}

/// ConsumerStatefulWidget se usa cuando necesitas tanto estado local como providers.
class _SeccionNombreState extends ConsumerState<_SeccionNombre> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ref.watch() en el build — se reconstruye cuando cambia el nombre
    final nombre = ref.watch(nombreUsuarioProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('StateProvider<String> + ConsumerStatefulWidget',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Text('Hola, $nombre', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    decoration: const InputDecoration(
                      hintText: 'Nuevo nombre',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_ctrl.text.isNotEmpty) {
                      // ref.read() en un callback — no suscribe al widget
                      ref.read(nombreUsuarioProvider.notifier).state = _ctrl.text;
                      _ctrl.clear();
                    }
                  },
                  child: const Text('Cambiar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Card explicativa sobre ref.watch vs ref.read.
class _ExplicacionRefWatch extends StatelessWidget {
  const _ExplicacionRefWatch();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ref.watch() vs ref.read()',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onTertiaryContainer)),
            const SizedBox(height: 8),
            Text(
              '• ref.watch(p) — usar en build()\n'
              '  Suscribe el widget al provider. Se reconstruye cuando cambia.\n\n'
              '• ref.read(p) — usar en callbacks/eventos\n'
              '  Lee el valor sin suscribirse. NO reconstruye el widget.',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiaryContainer),
            ),
          ],
        ),
      ),
    );
  }
}
