// =============================================================================
// ARCHIVO: 05_ejercicios.dart
// TEMA: Ejercicios de práctica — Estado en Flutter
// =============================================================================
//
// Tres ejercicios progresivos para practicar StatelessWidget, StatefulWidget,
// setState y compartir estado entre widgets.
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
      title: 'Ejercicios Estado',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const PantallaEjercicios(),
    );
  }
}

class PantallaEjercicios extends StatelessWidget {
  const PantallaEjercicios({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicios — Módulo 15'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(tabs: [
              Tab(text: 'Lista'),
              Tab(text: 'Semáforo'),
              Tab(text: 'Carrito'),
            ]),
            const Expanded(
              child: TabBarView(children: [
                _EjercicioListaTareas(),
                _EjercicioSemaforo(),
                _EjercicioCarrito(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 1 — LISTA DE TAREAS
// ────────────────────────────────────────────────────────────────────────────

/// Lista de tareas con agregar, completar y eliminar.
class _EjercicioListaTareas extends StatefulWidget {
  const _EjercicioListaTareas();

  @override
  State<_EjercicioListaTareas> createState() =>
      _EjercicioListaTareasState();
}

class _EjercicioListaTareasState extends State<_EjercicioListaTareas> {
  final _controller = TextEditingController();

  // Cada tarea es un mapa con texto y estado de completado.
  final List<Map<String, dynamic>> _tareas = [
    {'texto': 'Aprender StatelessWidget', 'completada': true},
    {'texto': 'Aprender StatefulWidget', 'completada': true},
    {'texto': 'Practicar setState', 'completada': false},
    {'texto': 'Estudiar InheritedWidget', 'completada': false},
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _agregarTarea() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _tareas.add({'texto': _controller.text.trim(), 'completada': false});
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final completadas = _tareas.where((t) => t['completada'] == true).length;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _agregarTarea(),
                  decoration: const InputDecoration(
                    hintText: 'Nueva tarea...',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: _agregarTarea,
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$completadas/${_tareas.length} completadas'),
              TextButton(
                onPressed: () => setState(
                  () => _tareas.removeWhere((t) => t['completada'] == true),
                ),
                child: const Text('Eliminar completadas'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _tareas.length,
            itemBuilder: (context, index) {
              final tarea = _tareas[index];
              return CheckboxListTile(
                value: tarea['completada'] as bool,
                title: Text(
                  tarea['texto'] as String,
                  style: TextStyle(
                    decoration: tarea['completada'] == true
                        ? TextDecoration.lineThrough
                        : null,
                    color: tarea['completada'] == true
                        ? Colors.grey
                        : null,
                  ),
                ),
                onChanged: (v) => setState(() => tarea['completada'] = v),
                secondary: IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20),
                  onPressed: () => setState(() => _tareas.removeAt(index)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 2 — SEMÁFORO INTERACTIVO
// ────────────────────────────────────────────────────────────────────────────

/// Semáforo animado controlado por setState.
class _EjercicioSemaforo extends StatefulWidget {
  const _EjercicioSemaforo();

  @override
  State<_EjercicioSemaforo> createState() => _EjercicioSemaforoState();
}

class _EjercicioSemaforoState extends State<_EjercicioSemaforo> {
  // 0 = rojo, 1 = amarillo, 2 = verde
  int _estado = 0;

  static const _colores = [Colors.red, Colors.amber, Colors.green];
  static const _textos = ['STOP', 'PRECAUCIÓN', 'AVANZA'];

  void _avanzar() {
    setState(() => _estado = (_estado + 1) % 3);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: List.generate(3, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _estado == index
                          ? _colores[index]
                          : Colors.grey.shade700,
                      boxShadow: _estado == index
                          ? [
                              BoxShadow(
                                color: _colores[index].withValues(alpha: 0.5),
                                blurRadius: 16,
                                spreadRadius: 4,
                              ),
                            ]
                          : null,
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            _textos[_estado],
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: _colores[_estado],
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _avanzar,
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Siguiente estado'),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 3 — CARRITO DE COMPRAS
// ────────────────────────────────────────────────────────────────────────────

/// Carrito simple con lista de productos y contador de total.
class _EjercicioCarrito extends StatefulWidget {
  const _EjercicioCarrito();

  @override
  State<_EjercicioCarrito> createState() => _EjercicioCarritoState();
}

class _EjercicioCarritoState extends State<_EjercicioCarrito> {
  final List<Map<String, dynamic>> _productos = [
    {'nombre': 'Flutter en Acción', 'precio': 29.99, 'cantidad': 0},
    {'nombre': 'Dart Fundamentos', 'precio': 14.99, 'cantidad': 0},
    {'nombre': 'Clean Architecture', 'precio': 24.99, 'cantidad': 0},
    {'nombre': 'UI/UX Mobile', 'precio': 19.99, 'cantidad': 0},
  ];

  double get _total => _productos.fold(
        0,
        (suma, p) => suma + (p['precio'] as double) * (p['cantidad'] as int),
      );

  int get _itemsEnCarrito =>
      _productos.fold(0, (suma, p) => suma + (p['cantidad'] as int));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _productos.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final p = _productos[index];
              return Card(
                child: ListTile(
                  title: Text(p['nombre'] as String,
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text('\$${(p['precio'] as double).toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: p['cantidad'] > 0
                            ? () => setState(() => p['cantidad']-- )
                            : null,
                      ),
                      SizedBox(
                        width: 24,
                        child: Text('${p['cantidad']}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () => setState(() => p['cantidad']++ ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$_itemsEnCarrito items',
                  style: const TextStyle(fontWeight: FontWeight.w500)),
              Text('\$${_total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              FilledButton(
                onPressed: _itemsEnCarrito > 0 ? () {} : null,
                child: const Text('Comprar'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. En la lista de tareas, agrega la capacidad de reordenar con ReorderableListView.
//   2. En el semáforo, agrega un Timer.periodic para que cambie automáticamente
//      cada 3 segundos (recuerda cancelar el timer en dispose).
//   3. En el carrito, agrega persistencia local usando shared_preferences para
//      que las cantidades se recuerden al reiniciar la app.
// =============================================================================
