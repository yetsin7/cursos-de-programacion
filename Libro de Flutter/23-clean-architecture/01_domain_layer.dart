// =============================================================================
// ARCHIVO: 01_domain_layer.dart
// TEMA: Clean Architecture — Capa de Dominio
// =============================================================================
// CÓMO USAR: archivo Dart puro, no tiene runApp. Sirve como referencia de
// cómo estructurar la capa de dominio en un proyecto real.
// =============================================================================

// ignore_for_file: avoid_print

/// Este archivo demuestra la estructura de la CAPA DE DOMINIO.
/// La capa de dominio es el núcleo de la app:
///   - No tiene dependencias externas (ni Flutter, ni http, ni sqflite)
///   - Contiene las reglas de negocio puras
///   - Es la más estable y la menos propensa a cambiar

// =============================================================================
// ENTIDADES — objetos de dominio puros sin dependencias externas
// =============================================================================

/// Entidad Libro: representa un libro en el dominio de negocio.
/// No tiene fromJson ni toMap — esas pertenecen a la capa de datos.
class Libro {
  final String id;
  final String titulo;
  final String autor;
  final int anioPublicacion;
  final bool disponible;

  const Libro({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.anioPublicacion,
    required this.disponible,
  });

  /// Crea una copia del libro con algunos campos modificados.
  Libro copyWith({String? titulo, bool? disponible}) {
    return Libro(
      id: id,
      titulo: titulo ?? this.titulo,
      autor: autor,
      anioPublicacion: anioPublicacion,
      disponible: disponible ?? this.disponible,
    );
  }

  @override
  String toString() => 'Libro($id: "$titulo" por $autor)';
}

// =============================================================================
// FAILURES — representan los errores del dominio
// =============================================================================

/// Clase base para todos los errores de dominio.
/// Se usa en lugar de excepciones para un manejo más explícito.
abstract class Failure {
  final String mensaje;
  const Failure(this.mensaje);
}

/// Error cuando el libro solicitado no existe.
class LibroNoEncontradoFailure extends Failure {
  const LibroNoEncontradoFailure(String id)
      : super('El libro con id "$id" no fue encontrado');
}

/// Error de comunicación con la fuente de datos.
class ErrorRedFailure extends Failure {
  const ErrorRedFailure() : super('Error de red — verifica tu conexión');
}

/// Error cuando el servidor retorna una respuesta inválida.
class ErrorServidorFailure extends Failure {
  final int codigoHttp;
  const ErrorServidorFailure(this.codigoHttp)
      : super('Error del servidor: HTTP $codigoHttp');
}

// =============================================================================
// REPOSITORIO ABSTRACTO — contrato que la capa de datos debe cumplir
// =============================================================================

/// Repositorio abstracto de libros.
/// Define las operaciones disponibles sin implementar ninguna.
/// La capa de datos provee la implementación concreta.
abstract class LibroRepository {
  /// Obtiene todos los libros disponibles.
  Future<List<Libro>> obtenerTodos();

  /// Busca un libro por su id. Retorna null si no existe.
  Future<Libro?> obtenerPorId(String id);

  /// Guarda un libro (crear o actualizar).
  Future<void> guardar(Libro libro);

  /// Elimina un libro por su id.
  Future<void> eliminar(String id);

  /// Busca libros por título o autor.
  Future<List<Libro>> buscar(String query);
}

// =============================================================================
// USE CASES — lógica de negocio encapsulada en clases
// =============================================================================

/// Use Case: obtener todos los libros.
/// Cada Use Case tiene un único método execute() con una responsabilidad clara.
class ObtenerLibrosUseCase {
  final LibroRepository _repositorio;

  /// Recibe el repositorio por inyección de dependencias.
  const ObtenerLibrosUseCase(this._repositorio);

  /// Ejecuta la lógica: obtiene todos los libros ordenados por título.
  Future<List<Libro>> execute() async {
    final libros = await _repositorio.obtenerTodos();
    // Lógica de negocio: siempre retornar ordenados alfabéticamente
    libros.sort((a, b) => a.titulo.compareTo(b.titulo));
    return libros;
  }
}

/// Use Case: reservar un libro.
/// Contiene la regla de negocio de verificar disponibilidad antes de reservar.
class ReservarLibroUseCase {
  final LibroRepository _repositorio;

  const ReservarLibroUseCase(this._repositorio);

  /// Reserva el libro con el id dado.
  /// Retorna el libro actualizado o lanza un Failure si no es posible.
  Future<Libro> execute(String libroId) async {
    final libro = await _repositorio.obtenerPorId(libroId);

    // Regla de negocio 1: el libro debe existir
    if (libro == null) {
      throw LibroNoEncontradoFailure(libroId);
    }

    // Regla de negocio 2: el libro debe estar disponible
    if (!libro.disponible) {
      throw const Failure('El libro ya está reservado') {};
    }

    // Actualizar estado y guardar
    final libroReservado = libro.copyWith(disponible: false);
    await _repositorio.guardar(libroReservado);
    return libroReservado;
  }
}

/// Use Case: buscar libros por texto.
class BuscarLibrosUseCase {
  final LibroRepository _repositorio;

  const BuscarLibrosUseCase(this._repositorio);

  /// Busca libros. Retorna lista vacía si el query está vacío.
  Future<List<Libro>> execute(String query) async {
    // Regla de negocio: no buscar con menos de 2 caracteres
    if (query.trim().length < 2) return [];
    return _repositorio.buscar(query.trim());
  }
}

// =============================================================================
// DEMOSTRACIÓN — punto de entrada para ver la capa de dominio en acción
// =============================================================================

/// Implementación en memoria del repositorio para la demostración.
/// En un proyecto real esta clase estaría en la capa de datos.
class LibroRepositoryEnMemoria implements LibroRepository {
  final List<Libro> _libros = [
    const Libro(
        id: '1', titulo: 'Clean Code', autor: 'Robert C. Martin',
        anioPublicacion: 2008, disponible: true),
    const Libro(
        id: '2', titulo: 'The Pragmatic Programmer', autor: 'David Thomas',
        anioPublicacion: 1999, disponible: true),
    const Libro(
        id: '3', titulo: 'Design Patterns', autor: 'Gang of Four',
        anioPublicacion: 1994, disponible: false),
  ];

  @override
  Future<List<Libro>> obtenerTodos() async => List.from(_libros);

  @override
  Future<Libro?> obtenerPorId(String id) async =>
      _libros.cast<Libro?>().firstWhere((l) => l?.id == id, orElse: () => null);

  @override
  Future<void> guardar(Libro libro) async {
    final idx = _libros.indexWhere((l) => l.id == libro.id);
    if (idx >= 0) {
      _libros[idx] = libro;
    } else {
      _libros.add(libro);
    }
  }

  @override
  Future<void> eliminar(String id) async => _libros.removeWhere((l) => l.id == id);

  @override
  Future<List<Libro>> buscar(String query) async => _libros
      .where((l) =>
          l.titulo.toLowerCase().contains(query.toLowerCase()) ||
          l.autor.toLowerCase().contains(query.toLowerCase()))
      .toList();
}

/// Demostración de los use cases en acción.
Future<void> main() async {
  final repositorio = LibroRepositoryEnMemoria();
  final obtenerLibros = ObtenerLibrosUseCase(repositorio);
  final buscarLibros = BuscarLibrosUseCase(repositorio);
  final reservarLibro = ReservarLibroUseCase(repositorio);

  print('=== Capa de Dominio — Demostración ===\n');

  // Obtener todos los libros (ordenados)
  final todos = await obtenerLibros.execute();
  print('Libros (ordenados):');
  for (final libro in todos) {
    print('  ${libro.disponible ? "✓" : "✗"} ${libro.titulo}');
  }

  // Buscar libros
  print('\nBúsqueda "clean":');
  final resultados = await buscarLibros.execute('clean');
  for (final libro in resultados) {
    print('  → ${libro.titulo}');
  }

  // Reservar un libro disponible
  print('\nReservando libro id=1...');
  try {
    final reservado = await reservarLibro.execute('1');
    print('  Reservado: ${reservado.titulo} (disponible: ${reservado.disponible})');
  } catch (e) {
    print('  Error: $e');
  }

  // Intentar reservar un libro no disponible
  print('\nIntentando reservar libro id=3 (no disponible)...');
  try {
    await reservarLibro.execute('3');
  } catch (e) {
    print('  Error esperado: $e');
  }
}
