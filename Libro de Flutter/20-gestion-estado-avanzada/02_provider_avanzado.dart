// =============================================================================
// ARCHIVO: 02_provider_avanzado.dart
// TEMA: Provider avanzado — MultiProvider, ProxyProvider, FutureProvider, Selector
// =============================================================================
// CÓMO USAR: copiar como lib/main.dart y ejecutar flutter run
// DEPENDENCIA: agregar en pubspec.yaml: provider: ^6.1.2
// =============================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // MultiProvider permite declarar múltiples providers en un solo lugar
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsuarioModel()),
        // ProxyProvider depende de UsuarioModel — se recrea cuando cambia
        ProxyProvider<UsuarioModel, CarritoService>(
          update: (_, usuario, anterior) =>
              CarritoService(usuario: usuario, anterior: anterior),
        ),
        // FutureProvider carga datos asíncronos una sola vez al iniciar
        FutureProvider<List<String>>(
          create: (_) => _cargarCategorias(),
          initialData: const [],
          catchError: (_, e) => ['Error al cargar'],
        ),
      ],
      child: const AppProviderAvanzado(),
    ),
  );
}

/// Simula una carga asíncrona de categorías desde una API o base de datos.
Future<List<String>> _cargarCategorias() async {
  await Future.delayed(const Duration(seconds: 2));
  return ['Electrónica', 'Ropa', 'Hogar', 'Deportes', 'Libros'];
}

// =============================================================================
// MODELOS
// =============================================================================

/// Modelo del usuario autenticado.
class UsuarioModel extends ChangeNotifier {
  String _nombre = 'Invitado';
  bool _esPremium = false;

  String get nombre => _nombre;
  bool get esPremium => _esPremium;

  /// Actualiza el nombre del usuario.
  void setNombre(String nombre) {
    _nombre = nombre;
    notifyListeners();
  }

  /// Activa o desactiva la cuenta premium.
  void togglePremium() {
    _esPremium = !_esPremium;
    notifyListeners();
  }
}

/// Servicio del carrito que depende del usuario activo.
/// Se recrea automáticamente cuando UsuarioModel notifica cambios.
class CarritoService {
  final UsuarioModel usuario;
  final CarritoService? anterior;
  final List<String> _items;

  CarritoService({required this.usuario, this.anterior})
      : _items = anterior?._items ?? [];

  List<String> get items => List.unmodifiable(_items);

  /// Descuento disponible según si el usuario es premium.
  double get descuento => usuario.esPremium ? 0.15 : 0.0;

  /// Agrega un item preservando los items anteriores.
  void agregar(String item) => _items.add(item);
}

// =============================================================================
// PRESENTACIÓN
// =============================================================================

/// App raíz.
class AppProviderAvanzado extends StatelessWidget {
  const AppProviderAvanzado({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Avanzado',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal)),
      home: const PantallaAvanzada(),
    );
  }
}

/// Pantalla principal que demuestra todos los providers.
class PantallaAvanzada extends StatelessWidget {
  const PantallaAvanzada({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Provider Avanzado'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SeccionUsuario(),
          SizedBox(height: 16),
          _SeccionCarrito(),
          SizedBox(height: 16),
          _SeccionCategorias(),
          SizedBox(height: 16),
          _SeccionSelector(),
        ],
      ),
    );
  }
}

/// Sección que demuestra ChangeNotifierProvider con UsuarioModel.
class _SeccionUsuario extends StatelessWidget {
  const _SeccionUsuario();

  @override
  Widget build(BuildContext context) {
    // Selector<T,S> solo reconstruye cuando cambia la propiedad seleccionada
    // Evita reconstrucciones innecesarias cuando otras propiedades cambian
    final nombre = context.select<UsuarioModel, String>((u) => u.nombre);
    final esPremium = context.select<UsuarioModel, bool>((u) => u.esPremium);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ChangeNotifierProvider',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ListTile(
              leading: CircleAvatar(child: Text(nombre[0])),
              title: Text(nombre),
              subtitle: Text(esPremium ? 'Usuario Premium ★' : 'Usuario estándar'),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () =>
                      context.read<UsuarioModel>().setNombre('Ana López'),
                  child: const Text('Cambiar nombre'),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () => context.read<UsuarioModel>().togglePremium(),
                  child: Text(esPremium ? 'Quitar premium' : 'Ser premium'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Sección que demuestra ProxyProvider — CarritoService depende de UsuarioModel.
class _SeccionCarrito extends StatelessWidget {
  const _SeccionCarrito();

  @override
  Widget build(BuildContext context) {
    final carrito = context.watch<CarritoService>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ProxyProvider', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'CarritoService depende de UsuarioModel.\n'
              'Usuario: ${carrito.usuario.nombre}\n'
              'Descuento: ${(carrito.descuento * 100).toInt()}%\n'
              'Items: ${carrito.items.isEmpty ? "vacío" : carrito.items.join(", ")}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                context.read<CarritoService>().agregar('Producto ${DateTime.now().second}');
                // Forzar reconstrucción cambiando el modelo padre
                context.read<UsuarioModel>().notifyListeners();
              },
              child: const Text('Agregar item'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sección que demuestra FutureProvider para datos asíncronos.
class _SeccionCategorias extends StatelessWidget {
  const _SeccionCategorias();

  @override
  Widget build(BuildContext context) {
    // FutureProvider retorna initialData mientras el Future no resuelve
    final categorias = context.watch<List<String>>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('FutureProvider', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            if (categorias.isEmpty)
              const Row(
                children: [
                  SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2)),
                  SizedBox(width: 8),
                  Text('Cargando categorías...'),
                ],
              )
            else
              Wrap(
                spacing: 8,
                children: categorias
                    .map((c) => Chip(label: Text(c)))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}

/// Sección que demuestra Selector para optimizar reconstrucciones.
class _SeccionSelector extends StatelessWidget {
  const _SeccionSelector();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Selector<T,S>',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer)),
            const SizedBox(height: 8),
            // Selector solo reconstruye este widget cuando cambia 'esPremium'
            // aunque UsuarioModel notifique otros cambios
            Selector<UsuarioModel, bool>(
              selector: (_, u) => u.esPremium,
              builder: (_, esPremium, __) => Text(
                esPremium
                    ? 'Este widget solo se reconstruyó porque esPremium cambió'
                    : 'Selector optimiza: evita reconstrucciones innecesarias',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondaryContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
