// =============================================================================
// ARCHIVO: 03_golden_test.dart
// TEMA: Golden Tests — snapshot tests de la UI de Flutter
// =============================================================================
// CÓMO USAR: guardar en test/03_golden_test.dart y ejecutar: flutter test
// Para CREAR los golden files: flutter test --update-goldens
// DEPENDENCIA: flutter_test ya viene incluido en Flutter SDK
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// =============================================================================
// WIDGETS A TESTEAR — componentes de diseño que no deben cambiar
// =============================================================================

/// Tarjeta de perfil de usuario con diseño definido.
/// Este es un candidato perfecto para golden test — su diseño debe ser estable.
class TarjetaPerfil extends StatelessWidget {
  final String nombre;
  final String rol;
  final Color colorAvatar;
  final bool esVerificado;

  const TarjetaPerfil({
    super.key,
    required this.nombre,
    required this.rol,
    this.colorAvatar = Colors.blue,
    this.esVerificado = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: colorAvatar,
              child: Text(
                nombre[0].toUpperCase(),
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(nombre,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      if (esVerificado) ...[
                        const SizedBox(width: 4),
                        const Icon(Icons.verified, color: Colors.blue, size: 18),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(rol, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Chip de estado de un pedido con colores semánticos.
class ChipEstadoPedido extends StatelessWidget {
  final String estado;
  const ChipEstadoPedido({super.key, required this.estado});

  Color get _color {
    switch (estado.toLowerCase()) {
      case 'pendiente': return Colors.orange;
      case 'enviado': return Colors.blue;
      case 'entregado': return Colors.green;
      case 'cancelado': return Colors.red;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.15),
        border: Border.all(color: _color),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        estado,
        style: TextStyle(color: _color, fontWeight: FontWeight.w600, fontSize: 13),
      ),
    );
  }
}

// =============================================================================
// GOLDEN TESTS
// =============================================================================

void main() {
  // Configurar el tamaño de pantalla de referencia para todos los golden tests
  // Es importante que sea consistente para evitar falsos positivos
  const tamanioPantalla = Size(400, 300);

  group('Golden Tests — TarjetaPerfil', () {
    testWidgets('tarjeta de perfil básica', (tester) async {
      // Configurar el tamaño de pantalla del test
      tester.view.physicalSize = tamanioPantalla;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: TarjetaPerfil(
                nombre: 'Ana García',
                rol: 'Desarrolladora Flutter',
                colorAvatar: Colors.purple,
                esVerificado: true,
              ),
            ),
          ),
        ),
      );

      // matchesGoldenFile() compara la UI renderizada con la imagen de referencia.
      // La primera vez que se corre (o con --update-goldens), CREA el archivo.
      // Las siguientes veces, COMPARA con el archivo existente.
      // Si la UI cambió y no era intencional, el test FALLA.
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/tarjeta_perfil_basica.png'),
      );
    });

    testWidgets('tarjeta sin verificar', (tester) async {
      tester.view.physicalSize = tamanioPantalla;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: TarjetaPerfil(
                nombre: 'Carlos López',
                rol: 'Diseñador UX',
                colorAvatar: Colors.teal,
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/tarjeta_perfil_sin_verificar.png'),
      );
    });
  });

  group('Golden Tests — ChipEstadoPedido', () {
    testWidgets('todos los estados de pedido', (tester) async {
      tester.view.physicalSize = const Size(400, 400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChipEstadoPedido(estado: 'pendiente'),
                  SizedBox(height: 8),
                  ChipEstadoPedido(estado: 'enviado'),
                  SizedBox(height: 8),
                  ChipEstadoPedido(estado: 'entregado'),
                  SizedBox(height: 8),
                  ChipEstadoPedido(estado: 'cancelado'),
                ],
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/chips_estados.png'),
      );
    });
  });

  group('Golden Tests — Modo oscuro', () {
    testWidgets('tarjeta en modo oscuro', (tester) async {
      tester.view.physicalSize = tamanioPantalla;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          // Forzar modo oscuro para el golden test
          theme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
          ),
          home: const Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: TarjetaPerfil(
                nombre: 'María Rodríguez',
                rol: 'Product Manager',
                colorAvatar: Colors.indigo,
                esVerificado: true,
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/tarjeta_perfil_oscuro.png'),
      );
    });
  });
}

// =============================================================================
// GUÍA DE USO DE GOLDEN TESTS
// =============================================================================
//
// CREAR golden files por primera vez:
//   flutter test --update-goldens
//
// VERIFICAR que no hay regresiones visuales:
//   flutter test
//
// ACTUALIZAR golden files después de cambios intencionales de diseño:
//   flutter test --update-goldens
//
// CUÁNDO son útiles:
//   ✓ Componentes de diseño reutilizables (tarjetas, chips, botones custom)
//   ✓ Temas y paletas de colores
//   ✓ Detectar cambios no intencionales en la UI
//   ✓ Documentación visual del diseño
//
// CUÁNDO NO usarlos:
//   ✗ Pantallas completas con muchos elementos dinámicos
//   ✗ Widgets que dependen de datos en tiempo real
//   ✗ Si el equipo trabaja en distintos sistemas operativos (el rendering difiere)
