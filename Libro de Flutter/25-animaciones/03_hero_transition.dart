// ============================================================
// MÓDULO 25 — Transición Hero entre pantallas
// Archivo: 03_hero_transition.dart
//
// El widget Hero permite que un elemento "vuele" de una pantalla
// a otra durante la navegación. Flutter anima automáticamente
// el tamaño y la posición del widget mientras hace push/pop.
//
// Requisitos:
//   - El tag debe ser ÚNICO en toda la jerarquía de widgets activos.
//   - El mismo tag debe aparecer tanto en la pantalla de origen
//     como en la pantalla de destino.
//   - Funciona con Navigator.push y Navigator.pop sin código extra.
// ============================================================

import 'package:flutter/material.dart';

void main() => runApp(const AppHeroTransition());

/// Punto de entrada: configura el tema de la app.
class AppHeroTransition extends StatelessWidget {
  const AppHeroTransition({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hero Transition',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const PantallaGaleria(),
    );
  }
}

// ----------------------------------------------------------
// Modelo de dato para cada elemento de la galería.
// Encapsula id (usado como Hero tag), color y etiqueta.
// ----------------------------------------------------------
class ItemGaleria {
  /// Identificador único — se usa como tag del Hero.
  final String id;
  final Color color;
  final String etiqueta;
  final IconData icono;

  const ItemGaleria({
    required this.id,
    required this.color,
    required this.etiqueta,
    required this.icono,
  });
}

/// Datos de ejemplo para la galería.
const List<ItemGaleria> _items = [
  ItemGaleria(id: 'sol', color: Colors.amber, etiqueta: 'Sol', icono: Icons.wb_sunny),
  ItemGaleria(id: 'luna', color: Colors.indigo, etiqueta: 'Luna', icono: Icons.nightlight_round),
  ItemGaleria(id: 'estrella', color: Colors.deepPurple, etiqueta: 'Estrella', icono: Icons.star),
  ItemGaleria(id: 'nube', color: Colors.lightBlue, etiqueta: 'Nube', icono: Icons.cloud),
  ItemGaleria(id: 'fuego', color: Colors.deepOrange, etiqueta: 'Fuego', icono: Icons.local_fire_department),
  ItemGaleria(id: 'hoja', color: Colors.green, etiqueta: 'Hoja', icono: Icons.eco),
];

// ============================================================
// PANTALLA 1 — Galería de tarjetas
// ============================================================

/// Muestra una cuadrícula de tarjetas. Al tocar una tarjeta,
/// navega a [PantallaDetalle] con una transición Hero.
class PantallaGaleria extends StatelessWidget {
  const PantallaGaleria({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galería — toca una tarjeta'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final item = _items[index];
            return _TarjetaGaleria(item: item);
          },
        ),
      ),
    );
  }
}

/// Tarjeta individual con el widget Hero envolviendo el círculo de color.
/// Al tocar navega a PantallaDetalle pasando el mismo item.
class _TarjetaGaleria extends StatelessWidget {
  final ItemGaleria item;
  const _TarjetaGaleria({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PantallaDetalle(item: item),
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // El Hero envuelve el widget que "volará" a la siguiente pantalla.
            // El tag debe coincidir exactamente con el Hero en PantallaDetalle.
            Hero(
              tag: item.id,
              child: CircleAvatar(
                radius: 36,
                backgroundColor: item.color,
                child: Icon(item.icono, size: 36, color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            Text(item.etiqueta, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PANTALLA 2 — Detalle del elemento seleccionado
// ============================================================

/// Pantalla de detalle. El Hero con el mismo tag animará el
/// círculo desde la galería hasta esta pantalla de forma fluida.
class PantallaDetalle extends StatelessWidget {
  final ItemGaleria item;
  const PantallaDetalle({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.etiqueta),
        backgroundColor: item.color,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // MISMO tag que en la tarjeta → Flutter anima la transición.
            Hero(
              tag: item.id,
              child: CircleAvatar(
                radius: 90,
                backgroundColor: item.color,
                child: Icon(item.icono, size: 80, color: Colors.white),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              item.etiqueta,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'ID del Hero: "${item.id}"',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            // Ejemplo de flightShuttleBuilder: personaliza el widget
            // durante el vuelo (aquí solo documentado como referencia).
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: item.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: item.color.withOpacity(0.4)),
              ),
              child: const Text(
                'Tip: flightShuttleBuilder permite reemplazar el widget '
                'durante el vuelo, útil para transiciones con contenido diferente.',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Volver a la galería'),
            ),
          ],
        ),
      ),
    );
  }
}
