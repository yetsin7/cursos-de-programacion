// =============================================================================
// ARCHIVO: 02_data_layer.dart
// TEMA: Clean Architecture — Capa de Datos
// =============================================================================
// CÓMO USAR: archivo Dart puro. Muestra cómo estructurar la capa de datos.
// Para ejecutar, copiar como lib/main.dart y agregar main() al final.
// =============================================================================

// ignore_for_file: avoid_print

// =============================================================================
// ENTIDADES DE DOMINIO (importadas desde domain — aquí replicadas para brevedad)
// =============================================================================

/// Entidad de dominio — no tiene dependencias de serialización.
class LibroDomain {
  final String id;
  final String titulo;
  final String autor;
  final bool disponible;

  const LibroDomain({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.disponible,
  });
}

/// Contrato del repositorio (definido en dominio).
abstract class LibroRepository {
  Future<List<LibroDomain>> obtenerTodos();
  Future<LibroDomain?> obtenerPorId(String id);
}

// =============================================================================
// MODELO DE DATOS — extiende o wrappea la entidad con capacidades de serialización
// =============================================================================

/// Modelo de libro para la capa de datos.
/// Tiene fromJson/toJson que la entidad de dominio no tiene.
/// Mapea entre el formato de la API/BD y la entidad de dominio.
class LibroModel {
  final String id;
  final String titulo;
  final String autor;
  final bool disponible;

  const LibroModel({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.disponible,
  });

  // ─── Deserialización desde JSON (respuesta de API) ─────────────────────────

  /// Crea un LibroModel desde JSON de la API.
  factory LibroModel.fromJson(Map<String, dynamic> json) {
    return LibroModel(
      id: json['id'].toString(),
      titulo: json['titulo'] as String? ?? json['title'] as String,
      autor: json['autor'] as String? ?? json['author'] as String,
      // La API puede retornar bool o int (0/1) — manejar ambos casos
      disponible: json['disponible'] == true || json['disponible'] == 1,
    );
  }

  /// Serializa a JSON para enviar a la API.
  Map<String, dynamic> toJson() => {
        'id': id,
        'titulo': titulo,
        'autor': autor,
        'disponible': disponible,
      };

  // ─── Mapeo a entidad de dominio ────────────────────────────────────────────

  /// Convierte el modelo a una entidad de dominio pura.
  /// La capa de datos siempre mapea hacia adentro (hacia el dominio).
  LibroDomain toDomain() {
    return LibroDomain(
      id: id,
      titulo: titulo,
      autor: autor,
      disponible: disponible,
    );
  }

  /// Crea un LibroModel desde una entidad de dominio (para persistir).
  factory LibroModel.fromDomain(LibroDomain entidad) {
    return LibroModel(
      id: entidad.id,
      titulo: entidad.titulo,
      autor: entidad.autor,
      disponible: entidad.disponible,
    );
  }
}

// =============================================================================
// DATA SOURCES — fuentes de datos abstractas e implementaciones
// =============================================================================

/// DataSource abstracto para libros remotos (API).
/// Permite cambiar la implementación sin afectar el repositorio.
abstract class LibroRemoteDataSource {
  /// Obtiene la lista completa de libros del servidor.
  Future<List<LibroModel>> obtenerLibros();

  /// Obtiene un libro específico del servidor.
  Future<LibroModel?> obtenerLibroPorId(String id);
}

/// DataSource abstracto para libros locales (caché).
abstract class LibroLocalDataSource {
  Future<List<LibroModel>> obtenerLibrosCacheados();
  Future<void> cachearLibros(List<LibroModel> libros);
  Future<bool> tieneCacheValido();
}

/// Implementación del DataSource remoto.
/// En un proyecto real haría peticiones HTTP reales.
class LibroRemoteDataSourceImpl implements LibroRemoteDataSource {
  @override
  Future<List<LibroModel>> obtenerLibros() async {
    // Simulación de petición HTTP
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      LibroModel.fromJson({
        'id': '1', 'titulo': 'Clean Architecture', 'autor': 'Robert C. Martin',
        'disponible': true,
      }),
      LibroModel.fromJson({
        'id': '2', 'titulo': 'Refactoring', 'autor': 'Martin Fowler',
        'disponible': true,
      }),
    ];
  }

  @override
  Future<LibroModel?> obtenerLibroPorId(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final libros = await obtenerLibros();
    return libros.cast<LibroModel?>().firstWhere(
          (l) => l?.id == id,
          orElse: () => null,
        );
  }
}

/// Implementación del DataSource local (caché en memoria para la demo).
class LibroLocalDataSourceImpl implements LibroLocalDataSource {
  List<LibroModel>? _cache;
  DateTime? _ultimaActualizacion;

  @override
  Future<List<LibroModel>> obtenerLibrosCacheados() async {
    return _cache ?? [];
  }

  @override
  Future<void> cachearLibros(List<LibroModel> libros) async {
    _cache = libros;
    _ultimaActualizacion = DateTime.now();
  }

  @override
  Future<bool> tieneCacheValido() async {
    if (_cache == null || _ultimaActualizacion == null) return false;
    // El caché es válido por 5 minutos
    final diferencia = DateTime.now().difference(_ultimaActualizacion!);
    return diferencia.inMinutes < 5;
  }
}

// =============================================================================
// REPOSITORIO CONCRETO — implementa el contrato del dominio
// =============================================================================

/// Implementación concreta del repositorio.
/// Coordina entre el DataSource remoto y el caché local.
/// La capa de presentación y dominio nunca ven este detalle.
class LibroRepositoryImpl implements LibroRepository {
  final LibroRemoteDataSource _remoto;
  final LibroLocalDataSource _local;

  const LibroRepositoryImpl({
    required LibroRemoteDataSource remoto,
    required LibroLocalDataSource local,
  }) : _remoto = remoto, _local = local;

  @override
  Future<List<LibroDomain>> obtenerTodos() async {
    // Estrategia: usar caché si es válido, sino ir al servidor
    if (await _local.tieneCacheValido()) {
      print('  [Repo] Usando datos del caché');
      final modelos = await _local.obtenerLibrosCacheados();
      return modelos.map((m) => m.toDomain()).toList();
    }

    print('  [Repo] Cargando desde el servidor...');
    final modelos = await _remoto.obtenerLibros();

    // Guardar en caché para la próxima vez
    await _local.cachearLibros(modelos);

    // Mapear modelos → entidades de dominio antes de retornar
    return modelos.map((m) => m.toDomain()).toList();
  }

  @override
  Future<LibroDomain?> obtenerPorId(String id) async {
    final modelo = await _remoto.obtenerLibroPorId(id);
    return modelo?.toDomain();
  }
}

// =============================================================================
// DEMOSTRACIÓN
// =============================================================================

Future<void> main() async {
  print('=== Capa de Datos — Demostración ===\n');

  // Construir el árbol de dependencias (en la app real esto va en el DI setup)
  final remoto = LibroRemoteDataSourceImpl();
  final local = LibroLocalDataSourceImpl();
  final repositorio = LibroRepositoryImpl(remoto: remoto, local: local);

  // Primera carga — va al servidor
  print('Primera carga:');
  final libros = await repositorio.obtenerTodos();
  for (final libro in libros) {
    print('  - ${libro.titulo} (${libro.disponible ? "disponible" : "no disponible"})');
  }

  // Segunda carga — usa el caché
  print('\nSegunda carga:');
  final librosCacheados = await repositorio.obtenerTodos();
  print('  ${librosCacheados.length} libros obtenidos del caché\n');

  // Demostrar mapeo JSON
  print('Mapeo JSON:');
  const jsonEjemplo = {
    'id': '99',
    'titulo': 'Test Driven Development',
    'autor': 'Kent Beck',
    'disponible': 1, // API retorna int en lugar de bool
  };
  final modeloDesdeJson = LibroModel.fromJson(jsonEjemplo);
  final entidad = modeloDesdeJson.toDomain();
  print('  JSON → Modelo → Entidad: ${entidad.titulo} (disponible: ${entidad.disponible})');
  print('  Entidad → JSON: ${modeloDesdeJson.toJson()}');
}
