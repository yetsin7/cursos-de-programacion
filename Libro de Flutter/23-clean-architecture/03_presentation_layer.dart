// =============================================================================
// ARCHIVO: 03_presentation_layer.dart
// TEMA: Clean Architecture — Capa de Presentación con Flutter
// =============================================================================
// CÓMO USAR: copiar como lib/main.dart y ejecutar flutter run
// =============================================================================

import 'package:flutter/material.dart';

void main() => runApp(const AppPresentacion());

// =============================================================================
// CAPA DE DOMINIO (en una app real estaría en archivos separados)
// =============================================================================

/// Entidad de dominio pura.
class Pelicula {
  final String id;
  final String titulo;
  final String genero;
  final double calificacion;

  const Pelicula({
    required this.id,
    required this.titulo,
    required this.genero,
    required this.calificacion,
  });
}

/// Contrato del repositorio — definido en dominio.
abstract class PeliculaRepository {
  Future<List<Pelicula>> obtenerPeliculas();
  Future<void> guardarFavorita(String id);
}

/// Use Case de obtener películas.
class ObtenerPeliculasUseCase {
  final PeliculaRepository _repositorio;
  const ObtenerPeliculasUseCase(this._repositorio);

  /// Obtiene y ordena películas por calificación descendente.
  Future<List<Pelicula>> execute() async {
    final peliculas = await _repositorio.obtenerPeliculas();
    peliculas.sort((a, b) => b.calificacion.compareTo(a.calificacion));
    return peliculas;
  }
}

// =============================================================================
// CAPA DE DATOS (en una app real estaría en archivos separados)
// =============================================================================

/// Implementación del repositorio con datos simulados.
class PeliculaRepositoryImpl implements PeliculaRepository {
  @override
  Future<List<Pelicula>> obtenerPeliculas() async {
    // Simular latencia de red
    await Future.delayed(const Duration(seconds: 1));
    return const [
      Pelicula(id: '1', titulo: 'Inception', genero: 'Sci-Fi', calificacion: 8.8),
      Pelicula(id: '2', titulo: 'The Dark Knight', genero: 'Acción', calificacion: 9.0),
      Pelicula(id: '3', titulo: 'Interstellar', genero: 'Sci-Fi', calificacion: 8.6),
      Pelicula(id: '4', titulo: 'Pulp Fiction', genero: 'Drama', calificacion: 8.9),
      Pelicula(id: '5', titulo: 'The Matrix', genero: 'Sci-Fi', calificacion: 8.7),
    ];
  }

  @override
  Future<void> guardarFavorita(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    debugPrint('Película $id guardada como favorita');
  }
}

// =============================================================================
// CAPA DE PRESENTACIÓN — Estado con ChangeNotifier
// =============================================================================

/// Estados posibles de la pantalla de películas.
enum EstadoPeliculas { inicial, cargando, cargado, error }

/// Notifier que gestiona el estado de la pantalla de películas.
/// Llama al Use Case — nunca accede directamente al repositorio.
class PeliculasNotifier extends ChangeNotifier {
  final ObtenerPeliculasUseCase _useCase;

  EstadoPeliculas _estado = EstadoPeliculas.inicial;
  List<Pelicula> _peliculas = [];
  String? _mensajeError;
  final Set<String> _favoritas = {};

  PeliculasNotifier({required ObtenerPeliculasUseCase useCase})
      : _useCase = useCase;

  // Getters para exponer el estado de forma inmutable
  EstadoPeliculas get estado => _estado;
  List<Pelicula> get peliculas => List.unmodifiable(_peliculas);
  String? get mensajeError => _mensajeError;
  bool esFavorita(String id) => _favoritas.contains(id);

  /// Carga las películas ejecutando el use case.
  Future<void> cargar() async {
    _estado = EstadoPeliculas.cargando;
    _mensajeError = null;
    notifyListeners();

    try {
      _peliculas = await _useCase.execute();
      _estado = EstadoPeliculas.cargado;
    } catch (e) {
      _estado = EstadoPeliculas.error;
      _mensajeError = 'No se pudieron cargar las películas';
    }

    notifyListeners();
  }

  /// Marca o desmarca una película como favorita.
  void toggleFavorita(String id) {
    if (_favoritas.contains(id)) {
      _favoritas.remove(id);
    } else {
      _favoritas.add(id);
    }
    notifyListeners();
  }
}

// =============================================================================
// WIDGETS — consumen el estado sin lógica de negocio
// =============================================================================

/// App raíz.
class AppPresentacion extends StatelessWidget {
  const AppPresentacion({super.key});

  @override
  Widget build(BuildContext context) {
    // Construir árbol de dependencias
    final repositorio = PeliculaRepositoryImpl();
    final useCase = ObtenerPeliculasUseCase(repositorio);
    final notifier = PeliculasNotifier(useCase: useCase);

    return MaterialApp(
      title: 'Clean Architecture - Presentación',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
      home: PantallaPeliculas(notifier: notifier),
    );
  }
}

/// Pantalla de películas — solo se encarga de mostrar el estado.
class PantallaPeliculas extends StatefulWidget {
  final PeliculasNotifier notifier;
  const PantallaPeliculas({super.key, required this.notifier});

  @override
  State<PantallaPeliculas> createState() => _PantallaPeliculasState();
}

class _PantallaPeliculasState extends State<PantallaPeliculas> {
  @override
  void initState() {
    super.initState();
    // Escuchar cambios del notifier para reconstruir la pantalla
    widget.notifier.addListener(_onEstadoCambia);
    // Cargar datos al iniciar
    widget.notifier.cargar();
  }

  @override
  void dispose() {
    widget.notifier.removeListener(_onEstadoCambia);
    super.dispose();
  }

  /// Forzar reconstrucción cuando el notifier notifica cambios.
  void _onEstadoCambia() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: widget.notifier.cargar,
          ),
        ],
      ),
      body: _construirCuerpo(widget.notifier),
    );
  }

  /// Construye el cuerpo según el estado actual del notifier.
  Widget _construirCuerpo(PeliculasNotifier notifier) {
    switch (notifier.estado) {
      case EstadoPeliculas.inicial:
        return const Center(child: Text('Iniciando...'));

      case EstadoPeliculas.cargando:
        return const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 12),
              Text('Cargando películas...'),
            ],
          ),
        );

      case EstadoPeliculas.error:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 8),
              Text(notifier.mensajeError ?? 'Error desconocido'),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: notifier.cargar, child: const Text('Reintentar')),
            ],
          ),
        );

      case EstadoPeliculas.cargado:
        return _ListaPeliculas(
          peliculas: notifier.peliculas,
          esFavorita: notifier.esFavorita,
          onToggleFavorita: notifier.toggleFavorita,
        );
    }
  }
}

/// Lista de películas — widget separado para mejor organización.
class _ListaPeliculas extends StatelessWidget {
  final List<Pelicula> peliculas;
  final bool Function(String) esFavorita;
  final void Function(String) onToggleFavorita;

  const _ListaPeliculas({
    required this.peliculas,
    required this.esFavorita,
    required this.onToggleFavorita,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: peliculas.length,
      itemBuilder: (_, i) {
        final pelicula = peliculas[i];
        return _TarjetaPelicula(
          pelicula: pelicula,
          esFavorita: esFavorita(pelicula.id),
          onToggleFavorita: () => onToggleFavorita(pelicula.id),
        );
      },
    );
  }
}

/// Tarjeta de película — widget atómico reutilizable.
class _TarjetaPelicula extends StatelessWidget {
  final Pelicula pelicula;
  final bool esFavorita;
  final VoidCallback onToggleFavorita;

  const _TarjetaPelicula({
    required this.pelicula,
    required this.esFavorita,
    required this.onToggleFavorita,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            pelicula.calificacion.toStringAsFixed(1),
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer),
          ),
        ),
        title: Text(pelicula.titulo,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(pelicula.genero),
        trailing: IconButton(
          icon: Icon(
            esFavorita ? Icons.favorite : Icons.favorite_border,
            color: esFavorita ? Colors.red : null,
          ),
          onPressed: onToggleFavorita,
        ),
      ),
    );
  }
}
