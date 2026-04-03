// =============================================================================
// ARCHIVO: 04_riverpod_avanzado.dart
// TEMA: Riverpod avanzado — NotifierProvider, AsyncNotifierProvider, family
// =============================================================================
// CÓMO USAR: copiar como lib/main.dart y ejecutar flutter run
// DEPENDENCIA: agregar en pubspec.yaml: flutter_riverpod: ^2.5.1
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// =============================================================================
// MODELOS
// =============================================================================

/// Modelo de una tarea en la lista de pendientes.
class Tarea {
  final int id;
  final String titulo;
  final bool completada;
  const Tarea({required this.id, required this.titulo, this.completada = false});

  /// Crea una copia con los campos modificados.
  Tarea copyWith({bool? completada}) =>
      Tarea(id: id, titulo: titulo, completada: completada ?? this.completada);
}

// =============================================================================
// NOTIFIER PROVIDERS — para lógica de negocio compleja
// =============================================================================

/// NotifierProvider: state management con lógica encapsulada en una clase.
/// Equivalente a ChangeNotifier pero más moderno y testeable.
class TareasNotifier extends Notifier<List<Tarea>> {
  /// Estado inicial de la lista de tareas.
  @override
  List<Tarea> build() {
    return [
      const Tarea(id: 1, titulo: 'Aprender Riverpod'),
      const Tarea(id: 2, titulo: 'Crear una app Flutter'),
      const Tarea(id: 3, titulo: 'Publicar en la tienda'),
    ];
  }

  /// Agrega una nueva tarea a la lista.
  void agregar(String titulo) {
    final nuevaId = state.isEmpty ? 1 : state.last.id + 1;
    state = [...state, Tarea(id: nuevaId, titulo: titulo)];
  }

  /// Cambia el estado de completada de una tarea.
  void toggleCompletada(int id) {
    state = state
        .map((t) => t.id == id ? t.copyWith(completada: !t.completada) : t)
        .toList();
  }

  /// Elimina una tarea de la lista.
  void eliminar(int id) {
    state = state.where((t) => t.id != id).toList();
  }
}

/// Provider que expone el TareasNotifier.
final tareasProvider = NotifierProvider<TareasNotifier, List<Tarea>>(TareasNotifier.new);

// =============================================================================
// ASYNC NOTIFIER PROVIDER — para datos asíncronos con lógica
// =============================================================================

/// Simula la obtención de posts desde una API.
Future<List<Map<String, String>>> _fetchPosts() async {
  await Future.delayed(const Duration(seconds: 2));
  // Simula datos que vendrían de un servidor
  return [
    {'titulo': 'Primeros pasos con Flutter', 'autor': 'Ana'},
    {'titulo': 'Clean Architecture explicada', 'autor': 'Carlos'},
    {'titulo': 'Riverpod vs Provider', 'autor': 'María'},
  ];
}

/// AsyncNotifierProvider para manejar datos asíncronos con estados loading/data/error.
class PostsNotifier extends AsyncNotifier<List<Map<String, String>>> {
  @override
  Future<List<Map<String, String>>> build() async {
    return _fetchPosts();
  }

  /// Fuerza la recarga de los posts (refresh).
  Future<void> recargar() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchPosts);
  }
}

final postsProvider =
    AsyncNotifierProvider<PostsNotifier, List<Map<String, String>>>(PostsNotifier.new);

// =============================================================================
// PROVIDER FAMILY — providers parametrizados
// =============================================================================

/// Provider parametrizado por userId para obtener el perfil de un usuario.
/// provider.family permite crear múltiples instancias del mismo provider con distintos parámetros.
final perfilUsuarioProvider = FutureProvider.family<String, int>((ref, userId) async {
  await Future.delayed(const Duration(milliseconds: 500));
  final nombres = {1: 'Ana García', 2: 'Carlos López', 3: 'María Rodríguez'};
  return nombres[userId] ?? 'Usuario $userId';
});

// =============================================================================
// APP
// =============================================================================

void main() => runApp(const ProviderScope(child: AppRiverpodAvanzado()));

/// App raíz.
class AppRiverpodAvanzado extends StatelessWidget {
  const AppRiverpodAvanzado({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Avanzado',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo)),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Riverpod Avanzado'),
            centerTitle: true,
            bottom: const TabBar(tabs: [
              Tab(text: 'Tareas'),
              Tab(text: 'Posts'),
              Tab(text: 'Perfiles'),
            ]),
          ),
          body: const TabBarView(children: [
            _TabTareas(),
            _TabPosts(),
            _TabPerfiles(),
          ]),
        ),
      ),
    );
  }
}

// ─── Tab 1: NotifierProvider ──────────────────────────────────────────────────

/// Tab que demuestra NotifierProvider con operaciones CRUD.
class _TabTareas extends ConsumerStatefulWidget {
  const _TabTareas();

  @override
  ConsumerState<_TabTareas> createState() => _TabTareasState();
}

class _TabTareasState extends ConsumerState<_TabTareas> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tareas = ref.watch(tareasProvider);

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
                      hintText: 'Nueva tarea', border: OutlineInputBorder(),
                      isDense: true),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  if (_ctrl.text.isNotEmpty) {
                    ref.read(tareasProvider.notifier).agregar(_ctrl.text);
                    _ctrl.clear();
                  }
                },
                child: const Text('Agregar'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: tareas.length,
            itemBuilder: (_, i) {
              final tarea = tareas[i];
              return CheckboxListTile(
                title: Text(
                  tarea.titulo,
                  style: TextStyle(
                      decoration:
                          tarea.completada ? TextDecoration.lineThrough : null),
                ),
                value: tarea.completada,
                onChanged: (_) =>
                    ref.read(tareasProvider.notifier).toggleCompletada(tarea.id),
                secondary: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () =>
                      ref.read(tareasProvider.notifier).eliminar(tarea.id),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ─── Tab 2: AsyncNotifierProvider con .when() ─────────────────────────────────

/// Tab que demuestra AsyncNotifierProvider y el método .when().
class _TabPosts extends ConsumerWidget {
  const _TabPosts();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postsProvider);

    return postsAsync.when(
      // Estado de carga
      loading: () => const Center(child: CircularProgressIndicator()),
      // Estado de error
      error: (e, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Error: $e'),
            ElevatedButton(
              onPressed: () =>
                  ref.read(postsProvider.notifier).recargar(),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
      // Estado con datos
      data: (posts) => Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (_, i) => ListTile(
                title: Text(posts[i]['titulo']!),
                subtitle: Text('por ${posts[i]['autor']!}'),
                leading: const Icon(Icons.article_outlined),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton.icon(
              onPressed: () => ref.read(postsProvider.notifier).recargar(),
              icon: const Icon(Icons.refresh),
              label: const Text('Recargar'),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Tab 3: provider.family ───────────────────────────────────────────────────

/// Tab que demuestra provider.family para providers parametrizados.
class _TabPerfiles extends ConsumerWidget {
  const _TabPerfiles();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Cada userId crea una instancia independiente del provider
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (_, i) {
        final userId = i + 1;
        // Pasar el parámetro al provider con .family
        final perfilAsync = ref.watch(perfilUsuarioProvider(userId));

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(child: Text('$userId')),
            title: perfilAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text('Error: $e'),
              data: (nombre) => Text(nombre),
            ),
            subtitle: Text('User ID: $userId'),
          ),
        );
      },
    );
  }
}
