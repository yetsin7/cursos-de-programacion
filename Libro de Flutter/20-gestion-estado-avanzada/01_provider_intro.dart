// =============================================================================
// ARCHIVO: 01_provider_intro.dart
// TEMA: Gestión de estado con Provider — introducción
// =============================================================================
// CÓMO USAR: copiar como lib/main.dart y ejecutar flutter run
// DEPENDENCIA: agregar en pubspec.yaml: provider: ^6.1.2
// =============================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // ChangeNotifierProvider envuelve la app para que todo el árbol acceda al modelo
    ChangeNotifierProvider(
      create: (_) => CarritoModel(),
      child: const AppProvider(),
    ),
  );
}

// =============================================================================
// CAPA DE DOMINIO: modelo de datos
// =============================================================================

/// Representa un producto en la tienda.
class Producto {
  final String id;
  final String nombre;
  final double precio;
  const Producto({required this.id, required this.nombre, required this.precio});
}

/// Modelo del carrito de compras que notifica cambios a los widgets.
/// Extiende ChangeNotifier para poder llamar notifyListeners().
class CarritoModel extends ChangeNotifier {
  // Lista interna de productos agregados al carrito
  final List<Producto> _items = [];

  /// Retorna una copia inmutable de los items (encapsulamiento).
  List<Producto> get items => List.unmodifiable(_items);

  /// Total calculado de todos los items en el carrito.
  double get total => _items.fold(0, (suma, p) => suma + p.precio);

  /// Cantidad de items en el carrito.
  int get cantidad => _items.length;

  /// Agrega un producto al carrito y notifica a los widgets.
  void agregar(Producto producto) {
    _items.add(producto);
    notifyListeners(); // Dispara la reconstrucción de todos los widgets que escuchan
  }

  /// Elimina la última ocurrencia de un producto.
  void quitar(Producto producto) {
    _items.remove(producto);
    notifyListeners();
  }

  /// Limpia todo el carrito.
  void vaciar() {
    _items.clear();
    notifyListeners();
  }
}

// =============================================================================
// CAPA DE PRESENTACIÓN
// =============================================================================

/// App raíz. El provider ya fue declarado en main().
class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Intro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange)),
      home: const PantallaTienda(),
    );
  }
}

/// Pantalla principal con lista de productos y acceso al carrito.
class PantallaTienda extends StatelessWidget {
  const PantallaTienda({super.key});

  // Catálogo estático de productos de ejemplo
  static const _catalogo = [
    Producto(id: '1', nombre: 'Camiseta', precio: 19.99),
    Producto(id: '2', nombre: 'Pantalón', precio: 39.99),
    Producto(id: '3', nombre: 'Zapatos', precio: 59.99),
    Producto(id: '4', nombre: 'Gorra', precio: 14.99),
    Producto(id: '5', nombre: 'Mochila', precio: 49.99),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda'),
        centerTitle: true,
        actions: [
          // context.watch<T>() escucha cambios y reconstruye el widget
          // Solo reconstruye el Stack del ícono, no toda la pantalla
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const PantallaCarrito())),
              ),
              // Consumer<T> es equivalente a context.watch pero más granular
              Consumer<CarritoModel>(
                builder: (_, carrito, __) => carrito.cantidad == 0
                    ? const SizedBox.shrink()
                    : Positioned(
                        top: 6,
                        right: 6,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text('${carrito.cantidad}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10)),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _catalogo.length,
        itemBuilder: (context, i) => _TarjetaProducto(producto: _catalogo[i]),
      ),
    );
  }
}

/// Tarjeta de un producto con botón para agregar al carrito.
class _TarjetaProducto extends StatelessWidget {
  final Producto producto;
  const _TarjetaProducto({required this.producto});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.inventory_2_outlined, size: 36),
        title: Text(producto.nombre),
        subtitle: Text('\$${producto.precio.toStringAsFixed(2)}'),
        trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          // context.read<T>() lee sin suscribirse — no reconstruye este widget
          onPressed: () => context.read<CarritoModel>().agregar(producto),
        ),
      ),
    );
  }
}

/// Pantalla del carrito que muestra los items y el total.
class PantallaCarrito extends StatelessWidget {
  const PantallaCarrito({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch<CarritoModel>() reconstruye la pantalla cuando el carrito cambia
    final carrito = context.watch<CarritoModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Mi Carrito'), centerTitle: true),
      body: carrito.items.isEmpty
          ? const Center(child: Text('El carrito está vacío'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: carrito.items.length,
                    itemBuilder: (_, i) {
                      final item = carrito.items[i];
                      return ListTile(
                        title: Text(item.nombre),
                        subtitle: Text('\$${item.precio.toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => context.read<CarritoModel>().quitar(item),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total: \$${carrito.total.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      ElevatedButton(
                        onPressed: () => context.read<CarritoModel>().vaciar(),
                        child: const Text('Vaciar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
