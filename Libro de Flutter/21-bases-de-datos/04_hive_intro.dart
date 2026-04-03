// =============================================================================
// ARCHIVO: 04_hive_intro.dart
// TEMA: Base de datos NoSQL ultrarrápida con Hive
// =============================================================================
// CÓMO USAR: copiar como lib/main.dart y ejecutar flutter run
// DEPENDENCIA: agregar en pubspec.yaml:
//   hive_flutter: ^1.1.0
// =============================================================================

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// =============================================================================
// CONSTANTES
// =============================================================================

/// Nombre de la caja (box) de Hive para los favoritos.
const String _boxFavoritos = 'favoritos';

/// Nombre de la caja de configuraciones.
const String _boxConfig = 'configuracion';

// =============================================================================
// PUNTO DE ENTRADA — Hive requiere inicialización antes de runApp
// =============================================================================

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Hive con el directorio de la app
  await Hive.initFlutter();

  // Abrir las cajas antes de usarlas
  await Hive.openBox<String>(_boxFavoritos);
  await Hive.openBox(_boxConfig);

  runApp(const AppHive());
}

// =============================================================================
// APP
// =============================================================================

/// App raíz.
class AppHive extends StatelessWidget {
  const AppHive({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Intro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange)),
      home: const PantallaHive(),
    );
  }
}

/// Pantalla principal con dos tabs: favoritos y configuración.
class PantallaHive extends StatelessWidget {
  const PantallaHive({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hive Demo'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [Tab(text: 'Favoritos'), Tab(text: 'Config')],
          ),
        ),
        body: const TabBarView(
          children: [_TabFavoritos(), _TabConfig()],
        ),
      ),
    );
  }
}

// ─── Tab 1: Caja tipada de strings ───────────────────────────────────────────

/// Tab que demuestra una Box<String> para guardar una lista de favoritos.
class _TabFavoritos extends StatefulWidget {
  const _TabFavoritos();

  @override
  State<_TabFavoritos> createState() => _TabFavoritosState();
}

class _TabFavoritosState extends State<_TabFavoritos> {
  // Acceder a la caja tipada — Hive guarda el tipo en tiempo de compilación
  Box<String> get _caja => Hive.box<String>(_boxFavoritos);
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _ctrl,
                  decoration: const InputDecoration(
                    hintText: 'Agregar favorito',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  if (_ctrl.text.isNotEmpty) {
                    // box.add() agrega con clave autogenerada (índice)
                    _caja.add(_ctrl.text.trim());
                    _ctrl.clear();
                    setState(() {}); // Forzar reconstrucción
                  }
                },
                child: const Text('Agregar'),
              ),
            ],
          ),
        ),

        // ValueListenableBuilder escucha cambios en la caja automáticamente
        // Es la forma reactiva recomendada de usar Hive con Flutter
        Expanded(
          child: ValueListenableBuilder<Box<String>>(
            valueListenable: _caja.listenable(),
            builder: (_, caja, __) {
              if (caja.isEmpty) {
                return const Center(child: Text('No hay favoritos'));
              }
              return ListView.builder(
                itemCount: caja.length,
                itemBuilder: (_, i) {
                  final clave = caja.keyAt(i);
                  final valor = caja.getAt(i)!;

                  return ListTile(
                    leading: const Icon(Icons.star, color: Colors.amber),
                    title: Text(valor),
                    subtitle: Text('Clave: $clave'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      // box.delete() elimina por clave
                      onPressed: () => caja.delete(clave),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// ─── Tab 2: Caja sin tipo para configuraciones clave-valor ───────────────────

/// Tab que demuestra una Box sin tipo para configuraciones diversas.
class _TabConfig extends StatelessWidget {
  const _TabConfig();

  Box get _caja => Hive.box(_boxConfig);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _caja.listenable(),
      builder: (_, caja, __) {
        // Leer valores con valor por defecto
        final notificaciones = caja.get('notificaciones', defaultValue: true) as bool;
        final idioma = caja.get('idioma', defaultValue: 'es') as String;
        final tamanioFuente = caja.get('tamano_fuente', defaultValue: 14.0) as double;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Información sobre Hive
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ventajas de Hive',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer)),
                    const SizedBox(height: 4),
                    Text(
                      '• Más rápido que sqflite para listas de objetos\n'
                      '• No requiere SQL — API simple y orientada a objetos\n'
                      '• Funciona perfecto para datos locales simples\n'
                      '• ValueListenableBuilder para UI reactiva',
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Notificaciones — bool
            Card(
              child: SwitchListTile(
                title: const Text('Notificaciones'),
                subtitle: const Text('Tipo: bool'),
                value: notificaciones,
                // box.put(clave, valor) guarda o sobreescribe un valor
                onChanged: (v) => _caja.put('notificaciones', v),
              ),
            ),

            // Idioma — String
            Card(
              child: ListTile(
                title: const Text('Idioma'),
                subtitle: const Text('Tipo: String'),
                trailing: DropdownButton<String>(
                  value: idioma,
                  items: const [
                    DropdownMenuItem(value: 'es', child: Text('Español')),
                    DropdownMenuItem(value: 'en', child: Text('English')),
                  ],
                  onChanged: (v) => v != null ? _caja.put('idioma', v) : null,
                ),
              ),
            ),

            // Tamaño de fuente — double
            Card(
              child: ListTile(
                title: const Text('Tamaño de fuente'),
                subtitle: Text('${tamanioFuente.toStringAsFixed(0)}pt'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: tamanioFuente > 10
                          ? () =>
                              _caja.put('tamano_fuente', tamanioFuente - 2.0)
                          : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: tamanioFuente < 24
                          ? () =>
                              _caja.put('tamano_fuente', tamanioFuente + 2.0)
                          : null,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => _caja.clear(),
              icon: const Icon(Icons.restore),
              label: const Text('Restablecer configuración'),
            ),
          ],
        );
      },
    );
  }
}
