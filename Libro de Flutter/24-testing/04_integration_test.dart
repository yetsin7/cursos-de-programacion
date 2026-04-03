// =============================================================================
// ARCHIVO: 04_integration_test.dart
// TEMA: Integration Tests — tests end-to-end de la app completa
// =============================================================================
// CÓMO USAR: guardar en integration_test/04_integration_test.dart
// Ejecutar en Android/iOS: flutter test integration_test/
// DEPENDENCIA: agregar en pubspec.yaml (dev_dependencies):
//   integration_test:
//     sdk: flutter
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// =============================================================================
// APP COMPLETA A TESTEAR — en una app real se importaría desde lib/main.dart
// =============================================================================

/// App de lista de tareas completa para demostrar integration tests.
void main() {
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized() es OBLIGATORIO
  // en integration tests — conecta el test con el framework de integración
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // ─── Tests de flujo completo ────────────────────────────────────────────────
  group('Integration Test — App de Tareas', () {
    testWidgets('flujo completo: agregar y eliminar tarea', (tester) async {
      // Iniciar la app completa — en una app real: await tester.pumpWidget(MyApp())
      await tester.pumpWidget(const MaterialApp(home: _AppTareas()));
      await tester.pumpAndSettle();

      // PASO 1: Verificar pantalla inicial vacía
      expect(find.text('No hay tareas'), findsOneWidget);
      expect(find.byKey(const Key('lista-tareas')), findsOneWidget);

      // PASO 2: Abrir el formulario para agregar tarea
      await tester.tap(find.byKey(const Key('boton-nueva-tarea')));
      await tester.pumpAndSettle();

      // Verificar que el diálogo apareció
      expect(find.byKey(const Key('campo-titulo-tarea')), findsOneWidget);

      // PASO 3: Escribir el título de la tarea
      await tester.enterText(
          find.byKey(const Key('campo-titulo-tarea')), 'Aprender Flutter');
      await tester.pump();

      // PASO 4: Guardar la tarea
      await tester.tap(find.byKey(const Key('boton-guardar-tarea')));
      await tester.pumpAndSettle();

      // PASO 5: Verificar que la tarea apareció en la lista
      expect(find.text('Aprender Flutter'), findsOneWidget);
      expect(find.text('No hay tareas'), findsNothing);

      // PASO 6: Completar la tarea
      await tester.tap(find.byKey(const Key('checkbox-tarea-0')));
      await tester.pump();

      // PASO 7: Verificar que está marcada como completada
      final checkbox = tester.widget<Checkbox>(
          find.byKey(const Key('checkbox-tarea-0')));
      expect(checkbox.value, isTrue);

      // PASO 8: Eliminar la tarea
      await tester.tap(find.byKey(const Key('boton-eliminar-tarea-0')));
      await tester.pumpAndSettle();

      // PASO 9: Verificar que la lista volvió a estar vacía
      expect(find.text('No hay tareas'), findsOneWidget);
    });

    testWidgets('flujo de búsqueda: filtrar tareas', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: _AppTareas()));
      await tester.pumpAndSettle();

      // Agregar múltiples tareas
      final tareas = ['Aprender Flutter', 'Aprender Dart', 'Publicar app'];
      for (final tarea in tareas) {
        await tester.tap(find.byKey(const Key('boton-nueva-tarea')));
        await tester.pumpAndSettle();
        await tester.enterText(
            find.byKey(const Key('campo-titulo-tarea')), tarea);
        await tester.tap(find.byKey(const Key('boton-guardar-tarea')));
        await tester.pumpAndSettle();
      }

      // Verificar que hay 3 tareas
      expect(find.byKey(const ValueKey('tarea-item')), findsNWidgets(3));

      // Buscar por "Aprender"
      await tester.enterText(
          find.byKey(const Key('campo-busqueda')), 'Aprender');
      await tester.pump();

      // Verificar que solo aparecen 2 tareas que contienen "Aprender"
      expect(find.byKey(const ValueKey('tarea-item')), findsNWidgets(2));
      expect(find.text('Publicar app'), findsNothing);
    });

    testWidgets('validación: no permite tareas vacías', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: _AppTareas()));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('boton-nueva-tarea')));
      await tester.pumpAndSettle();

      // Intentar guardar sin escribir nada
      await tester.tap(find.byKey(const Key('boton-guardar-tarea')));
      await tester.pump();

      // El diálogo debe seguir abierto (no se guardó)
      expect(find.byKey(const Key('campo-titulo-tarea')), findsOneWidget);
    });
  });
}

// =============================================================================
// IMPLEMENTACIÓN DE LA APP DE TAREAS (para que el test funcione)
// =============================================================================

/// Modelo de tarea.
class _Tarea {
  final String titulo;
  bool completada;
  _Tarea(this.titulo) : completada = false;
}

/// App de tareas con búsqueda.
class _AppTareas extends StatefulWidget {
  const _AppTareas();

  @override
  State<_AppTareas> createState() => _AppTareasState();
}

class _AppTareasState extends State<_AppTareas> {
  final List<_Tarea> _tareas = [];
  String _busqueda = '';
  final _busquedaCtrl = TextEditingController();

  List<_Tarea> get _tareasFiltradas => _busqueda.isEmpty
      ? _tareas
      : _tareas
          .where((t) =>
              t.titulo.toLowerCase().contains(_busqueda.toLowerCase()))
          .toList();

  @override
  void dispose() {
    _busquedaCtrl.dispose();
    super.dispose();
  }

  Future<void> _agregarTarea() async {
    final ctrl = TextEditingController();
    final titulo = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Nueva tarea'),
        content: TextField(
          key: const Key('campo-titulo-tarea'),
          controller: ctrl,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Título'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            key: const Key('boton-guardar-tarea'),
            onPressed: () {
              if (ctrl.text.trim().isNotEmpty) {
                Navigator.pop(context, ctrl.text.trim());
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );

    if (titulo != null) {
      setState(() => _tareas.add(_Tarea(titulo)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtradas = _tareasFiltradas;

    return Scaffold(
      appBar: AppBar(title: const Text('Mis Tareas'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              key: const Key('campo-busqueda'),
              controller: _busquedaCtrl,
              decoration: const InputDecoration(
                hintText: 'Buscar tareas...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (v) => setState(() => _busqueda = v),
            ),
          ),
          Expanded(
            child: filtradas.isEmpty
                ? const Center(child: Text('No hay tareas'))
                : ListView.builder(
                    key: const Key('lista-tareas'),
                    itemCount: filtradas.length,
                    itemBuilder: (_, i) {
                      final tarea = filtradas[i];
                      return ListTile(
                        key: const ValueKey('tarea-item'),
                        leading: Checkbox(
                          key: Key('checkbox-tarea-$i'),
                          value: tarea.completada,
                          onChanged: (v) =>
                              setState(() => tarea.completada = v ?? false),
                        ),
                        title: Text(
                          tarea.titulo,
                          style: TextStyle(
                            decoration: tarea.completada
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        trailing: IconButton(
                          key: Key('boton-eliminar-tarea-$i'),
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => setState(() => _tareas.remove(tarea)),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('boton-nueva-tarea'),
        onPressed: _agregarTarea,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// =============================================================================
// DIFERENCIAS: Widget Test vs Integration Test
// =============================================================================
//
// Widget Test:
//   ✓ Rápido (milisegundos)
//   ✓ No requiere dispositivo o emulador
//   ✓ Ambiente controlado y aislado
//   ✗ No prueba interacciones del sistema real (cámara, GPS, etc.)
//   ✗ No prueba rendimiento real
//
// Integration Test:
//   ✓ Prueba la app completa en un dispositivo/emulador real
//   ✓ Detecta bugs de integración entre capas
//   ✓ Prueba rendimiento y tiempos de carga reales
//   ✗ Lento (segundos por test)
//   ✗ Requiere dispositivo o emulador
//   ✗ Más difícil de mantener
//
// Cuándo usar Integration Tests:
//   ✓ Flujos críticos del negocio (registro, login, pago)
//   ✓ CI/CD antes de publicar a producción
//   ✓ Smoke tests de funcionalidades principales
