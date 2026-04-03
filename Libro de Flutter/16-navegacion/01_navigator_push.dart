// =============================================================================
// ARCHIVO: 01_navigator_push.dart
// TEMA: Navegación básica con Navigator.push y pop
// =============================================================================
//
// Navigator.push agrega una pantalla a la pila de navegación.
// Navigator.pop elimina la pantalla actual y vuelve a la anterior.
// Se pueden pasar datos hacia adelante vía el constructor de la pantalla,
// y recibir datos al volver usando Navigator.pop(context, resultado) con await.
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
      title: 'Navigator.push',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const PantallaListaProductos(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// MODELO DE DATOS
// ────────────────────────────────────────────────────────────────────────────

/// Modelo simple de producto para la demostración de navegación.
class Producto {
  final int id;
  final String nombre;
  final double precio;
  final String descripcion;
  final IconData icono;

  const Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.descripcion,
    required this.icono,
  });
}

// Datos de prueba.
const _productos = [
  Producto(
    id: 1,
    nombre: 'Flutter en Acción',
    precio: 29.99,
    descripcion: 'Libro completo sobre Flutter con ejemplos prácticos.',
    icono: Icons.book,
  ),
  Producto(
    id: 2,
    nombre: 'Curso Dart Avanzado',
    precio: 14.99,
    descripcion: 'Aprende las características avanzadas de Dart 3.x.',
    icono: Icons.school,
  ),
  Producto(
    id: 3,
    nombre: 'Clean Architecture',
    precio: 24.99,
    descripcion: 'Principios SOLID aplicados a proyectos Flutter reales.',
    icono: Icons.architecture,
  ),
];

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA 1 — LISTA DE PRODUCTOS
// ────────────────────────────────────────────────────────────────────────────

/// Pantalla principal con lista de productos.
/// Navega a PantallaDetalle al tocar un producto y espera si el usuario
/// agregó el item al carrito.
class PantallaListaProductos extends StatefulWidget {
  const PantallaListaProductos({super.key});

  @override
  State<PantallaListaProductos> createState() =>
      _PantallaListaProductosState();
}

class _PantallaListaProductosState extends State<PantallaListaProductos> {
  final List<Producto> _carrito = [];

  /// Navega al detalle y espera el resultado (si el usuario agregó al carrito).
  Future<void> _abrirDetalle(Producto producto) async {
    // await Navigator.push retorna el valor pasado en Navigator.pop(context, valor).
    // Si el usuario presiona el botón de atrás, retorna null.
    final resultado = await Navigator.push<bool>(
      context,
      // MaterialPageRoute: transición estándar de Material Design.
      MaterialPageRoute(
        builder: (context) => PantallaDetalle(producto: producto),
      ),
    );

    // resultado es true si el usuario tocó "Agregar al carrito".
    if (resultado == true && mounted) {
      setState(() => _carrito.add(producto));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${producto.nombre} agregado al carrito')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Badge del carrito.
          Stack(
            alignment: Alignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.shopping_cart),
              ),
              if (_carrito.isNotEmpty)
                Positioned(
                  top: 8,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${_carrito.length}',
                      style: const TextStyle(
                          color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _productos.length,
        itemBuilder: (context, index) {
          final producto = _productos[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: Icon(producto.icono,
                  color: Theme.of(context).colorScheme.primary),
              title: Text(producto.nombre,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('\$${producto.precio.toStringAsFixed(2)}'),
              trailing: const Icon(Icons.chevron_right),
              // Navega al tocar el item.
              onTap: () => _abrirDetalle(producto),
            ),
          );
        },
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA 2 — DETALLE DEL PRODUCTO
// ────────────────────────────────────────────────────────────────────────────

/// Pantalla de detalle que recibe un Producto y puede enviar un resultado de vuelta.
class PantallaDetalle extends StatelessWidget {
  /// Producto a mostrar. Se recibe vía el constructor.
  final Producto producto;

  const PantallaDetalle({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        // El botón de atrás (<) se crea automáticamente porque
        // hay un Navigator con una ruta anterior en la pila.
        title: Text(producto.nombre),
        backgroundColor: color.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ícono grande del producto.
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: color.primaryContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(producto.icono, size: 64, color: color.primary),
            ),
            const SizedBox(height: 24),
            Text(
              producto.nombre,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '\$${producto.precio.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              producto.descripcion,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            // Botones de acción.
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilledButton.icon(
                  onPressed: () {
                    // Navigator.pop(context, valor) retorna 'valor' al caller.
                    // El await en la pantalla anterior recibirá true.
                    Navigator.pop(context, true);
                  },
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Agregar al carrito'),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () {
                    // Navigator.pop sin valor retorna null.
                    Navigator.pop(context);
                  },
                  child: const Text('Volver sin agregar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Usa Navigator.pushReplacement() en lugar de push() para que al volver
//      no se pueda regresar a la pantalla anterior (ej: pantalla de login).
//   2. Agrega Navigator.pushAndRemoveUntil() para navegar a una pantalla
//      y limpiar todo el historial anterior (útil en logout o splash).
//   3. Prueba PageRouteBuilder para crear una transición personalizada
//      (ej: fade, slide, scale) en lugar de MaterialPageRoute.
// =============================================================================
