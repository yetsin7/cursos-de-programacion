// =============================================================================
// ARCHIVO: 05_bloc_intro.dart
// TEMA: BLoC con Cubit — gestión de estado reactiva
// =============================================================================
// CÓMO USAR: copiar como lib/main.dart y ejecutar flutter run
// DEPENDENCIA: agregar en pubspec.yaml: flutter_bloc: ^8.1.5
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const AppBlocIntro());

// =============================================================================
// CUBIT — versión simplificada de BLoC sin eventos explícitos
// Ideal cuando la lógica no es tan compleja como para necesitar BLoC completo
// =============================================================================

/// Estado del contador para el Cubit.
/// En BLoC/Cubit se usa un clase de estado para mantener todos los datos.
class ContadorState {
  final int valor;
  final String mensaje;
  const ContadorState({required this.valor, required this.mensaje});
}

/// ContadorCubit gestiona el estado del contador.
/// Cubit es la versión simplificada de BLoC: tiene métodos en lugar de eventos.
class ContadorCubit extends Cubit<ContadorState> {
  /// Estado inicial del Cubit.
  ContadorCubit()
      : super(const ContadorState(valor: 0, mensaje: 'Valor inicial'));

  /// Incrementa el contador y actualiza el mensaje.
  void incrementar() =>
      emit(ContadorState(valor: state.valor + 1, mensaje: 'Incrementado'));

  /// Decrementa el contador, sin ir por debajo de cero.
  void decrementar() {
    if (state.valor > 0) {
      emit(ContadorState(valor: state.valor - 1, mensaje: 'Decrementado'));
    } else {
      emit(const ContadorState(valor: 0, mensaje: 'No puede ser negativo'));
    }
  }

  /// Resetea el contador a cero.
  void reiniciar() =>
      emit(const ContadorState(valor: 0, mensaje: 'Reiniciado'));
}

// =============================================================================
// CUBIT PARA LISTA DE COMPRAS
// =============================================================================

/// Estado de la lista de compras.
class ListaComprasState {
  final List<String> items;
  final bool mostrarAgregado;
  const ListaComprasState({required this.items, this.mostrarAgregado = false});
}

/// Cubit para gestionar una lista de compras.
class ListaComprasCubit extends Cubit<ListaComprasState> {
  ListaComprasCubit()
      : super(const ListaComprasState(items: ['Leche', 'Pan', 'Huevos']));

  /// Agrega un item a la lista.
  void agregar(String item) {
    final nuevaLista = [...state.items, item];
    emit(ListaComprasState(items: nuevaLista, mostrarAgregado: true));
    // Ocultar la notificación después de un momento
    Future.delayed(
      const Duration(seconds: 2),
      () => emit(ListaComprasState(items: state.items)),
    );
  }

  /// Elimina un item de la lista por su índice.
  void eliminar(int indice) {
    final nuevaLista = List<String>.from(state.items)..removeAt(indice);
    emit(ListaComprasState(items: nuevaLista));
  }
}

// =============================================================================
// APP Y PANTALLAS
// =============================================================================

/// App raíz con BlocProvider para proveer los Cubits.
class AppBlocIntro extends StatelessWidget {
  const AppBlocIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ContadorCubit()),
        BlocProvider(create: (_) => ListaComprasCubit()),
      ],
      child: MaterialApp(
        title: 'BLoC Intro',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
        home: const PantallaBlocIntro(),
      ),
    );
  }
}

/// Pantalla con dos tabs: contador con Cubit y lista de compras.
class PantallaBlocIntro extends StatelessWidget {
  const PantallaBlocIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BLoC / Cubit'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [Tab(text: 'Contador'), Tab(text: 'Lista')],
          ),
        ),
        body: const TabBarView(
          children: [_TabContador(), _TabListaCompras()],
        ),
      ),
    );
  }
}

// ─── Tab 1: Contador con BlocBuilder y BlocListener ──────────────────────────

/// Tab del contador que demuestra BlocBuilder y BlocListener.
class _TabContador extends StatelessWidget {
  const _TabContador();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContadorCubit, ContadorState>(
      // BlocListener ejecuta código ante cambios de estado pero NO reconstruye UI
      // Ideal para: SnackBars, navegación, diálogos
      listenWhen: (anterior, actual) => actual.mensaje == 'No puede ser negativo',
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El valor no puede ser negativo'),
            duration: Duration(seconds: 1),
          ),
        );
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // BlocBuilder reconstruye el widget cuando el estado cambia
            BlocBuilder<ContadorCubit, ContadorState>(
              // buildWhen optimiza: solo reconstruye cuando el valor cambia
              buildWhen: (anterior, actual) => anterior.valor != actual.valor,
              builder: (context, state) {
                return Column(
                  children: [
                    Text(
                      '${state.valor}',
                      style: const TextStyle(
                          fontSize: 72, fontWeight: FontWeight.bold),
                    ),
                    Text(state.mensaje,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                );
              },
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: 'dec',
                  onPressed: () =>
                      context.read<ContadorCubit>().decrementar(),
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  heroTag: 'inc',
                  onPressed: () =>
                      context.read<ContadorCubit>().incrementar(),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.read<ContadorCubit>().reiniciar(),
              child: const Text('Reiniciar'),
            ),
            const SizedBox(height: 32),
            _TarjetaCuandoUsarBloc(),
          ],
        ),
      ),
    );
  }
}

// ─── Tab 2: Lista de compras ──────────────────────────────────────────────────

/// Tab de lista de compras con Cubit.
class _TabListaCompras extends StatefulWidget {
  const _TabListaCompras();

  @override
  State<_TabListaCompras> createState() => _TabListaComprasState();
}

class _TabListaComprasState extends State<_TabListaCompras> {
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
        // BlocBuilder — reconstruye la lista cuando cambia el estado
        BlocBuilder<ListaComprasCubit, ListaComprasState>(
          builder: (context, state) {
            return Column(
              children: [
                if (state.mostrarAgregado)
                  Container(
                    color: Colors.green.shade100,
                    padding: const EdgeInsets.all(8),
                    child: const Row(
                      children: [
                        Icon(Icons.check, color: Colors.green),
                        SizedBox(width: 8),
                        Text('Item agregado', style: TextStyle(color: Colors.green)),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (_, i) => ListTile(
                      leading: const Icon(Icons.check_box_outline_blank),
                      title: Text(state.items[i]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () =>
                            context.read<ListaComprasCubit>().eliminar(i),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _ctrl,
                  decoration: const InputDecoration(
                    hintText: 'Agregar item',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  if (_ctrl.text.isNotEmpty) {
                    context.read<ListaComprasCubit>().agregar(_ctrl.text);
                    _ctrl.clear();
                  }
                },
                child: const Text('Agregar'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Tarjeta con guía de cuándo usar BLoC.
class _TarjetaCuandoUsarBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('¿Cuándo usar BLoC?',
                  style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 4),
              const Text(
                '✓ Apps muy grandes con equipos grandes\n'
                '✓ Lógica de negocio muy compleja\n'
                '✓ Necesidad de auditar cada cambio de estado\n'
                '✗ No recomendado para apps pequeñas o medianas',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
