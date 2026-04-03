// =============================================================================
// ARCHIVO: 04_dependency_injection.dart
// TEMA: Inyección de dependencias manual y con get_it
// =============================================================================
// CÓMO USAR: archivo Dart de referencia. Para ejecutar con get_it:
//   agregar en pubspec.yaml: get_it: ^7.7.0
//   y descomentar las secciones marcadas
// =============================================================================

// ignore_for_file: avoid_print
// import 'package:get_it/get_it.dart'; // Descomentar al agregar get_it

// =============================================================================
// CONTRATOS (Dominio)
// =============================================================================

/// Repositorio abstracto de productos.
abstract class ProductoRepository {
  Future<List<String>> obtenerProductos();
}

/// Servicio abstracto de autenticación.
abstract class AuthService {
  Future<bool> estaAutenticado();
  String? get usuarioActual;
}

// =============================================================================
// IMPLEMENTACIONES (Data)
// =============================================================================

/// Implementación del repositorio usando datos en memoria.
class ProductoRepositoryImpl implements ProductoRepository {
  @override
  Future<List<String>> obtenerProductos() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return ['Laptop', 'Mouse', 'Teclado', 'Monitor'];
  }
}

/// Implementación del repositorio para tests (mock).
class ProductoRepositoryMock implements ProductoRepository {
  @override
  Future<List<String>> obtenerProductos() async => ['Producto Test 1'];
}

/// Implementación del servicio de autenticación.
class AuthServiceImpl implements AuthService {
  String? _usuario;

  @override
  Future<bool> estaAutenticado() async {
    _usuario = 'usuario@ejemplo.com';
    return true;
  }

  @override
  String? get usuarioActual => _usuario;
}

// =============================================================================
// USE CASES (Dominio)
// =============================================================================

/// Use Case que depende de dos servicios inyectados.
class ObtenerProductosUseCase {
  final ProductoRepository _repositorio;
  final AuthService _auth;

  // Las dependencias se inyectan por constructor — no se crean internamente
  const ObtenerProductosUseCase({
    required ProductoRepository repositorio,
    required AuthService auth,
  })  : _repositorio = repositorio,
        _auth = auth;

  /// Solo retorna productos si el usuario está autenticado.
  Future<List<String>> execute() async {
    final autenticado = await _auth.estaAutenticado();
    if (!autenticado) throw Exception('No autenticado');
    return _repositorio.obtenerProductos();
  }
}

// =============================================================================
// INYECCIÓN MANUAL — simple service locator sin librerías
// =============================================================================

/// Service locator manual para apps pequeñas.
/// Registra e instancia dependencias una sola vez.
class ServiceLocator {
  static final ServiceLocator _instancia = ServiceLocator._();
  factory ServiceLocator() => _instancia;
  ServiceLocator._();

  // Mapa de dependencias registradas
  final Map<Type, Object> _dependencias = {};

  /// Registra una dependencia por su tipo.
  void registrar<T>(T instancia) {
    _dependencias[T] = instancia as Object;
  }

  /// Obtiene una dependencia registrada. Lanza si no existe.
  T obtener<T>() {
    final dep = _dependencias[T];
    if (dep == null) throw Exception('$T no registrado en ServiceLocator');
    return dep as T;
  }
}

/// Configura todas las dependencias de la app en un solo lugar.
/// Se llama en main() antes de runApp().
void configurarDependencias({bool esModo = false}) {
  final sl = ServiceLocator();

  // Registrar la implementación correcta según el entorno
  if (esModo) {
    sl.registrar<ProductoRepository>(ProductoRepositoryMock());
    print('[DI] Modo test — usando mocks');
  } else {
    sl.registrar<ProductoRepository>(ProductoRepositoryImpl());
    print('[DI] Modo producción — usando implementaciones reales');
  }

  // Servicios siempre reales
  sl.registrar<AuthService>(AuthServiceImpl());

  // Use Cases — reciben sus dependencias del service locator
  sl.registrar<ObtenerProductosUseCase>(
    ObtenerProductosUseCase(
      repositorio: sl.obtener<ProductoRepository>(),
      auth: sl.obtener<AuthService>(),
    ),
  );

  print('[DI] Dependencias configuradas exitosamente');
}

// =============================================================================
// CON GET_IT (comentado hasta agregar la dependencia)
// =============================================================================

// /// Instancia global del service locator de get_it.
// final getIt = GetIt.instance;
//
// /// Configura dependencias con get_it.
// void configurarConGetIt() {
//   // registerSingleton — una sola instancia para toda la app
//   getIt.registerSingleton<AuthService>(AuthServiceImpl());
//
//   // registerFactory — nueva instancia cada vez que se pide
//   getIt.registerFactory<ProductoRepository>(() => ProductoRepositoryImpl());
//
//   // registerLazySingleton — se crea solo cuando se usa por primera vez
//   getIt.registerLazySingleton<ObtenerProductosUseCase>(
//     () => ObtenerProductosUseCase(
//       repositorio: getIt<ProductoRepository>(),
//       auth: getIt<AuthService>(),
//     ),
//   );
//
//   // Para acceder: getIt<ObtenerProductosUseCase>().execute()
// }

// =============================================================================
// BENEFICIOS DE INYECCIÓN DE DEPENDENCIAS
// =============================================================================

/// Beneficios de la inyección de dependencias documentados como comentarios.
///
/// 1. TESTABILIDAD: se puede pasar un mock en los tests
///    final useCase = ObtenerProductosUseCase(
///      repositorio: ProductoRepositoryMock(), // <-- mock en tests
///      auth: AuthServiceMock(),
///    );
///
/// 2. DESACOPLAMIENTO: el use case no sabe qué implementación usa
///    Solo conoce la interfaz (abstract class).
///
/// 3. FLEXIBILIDAD: cambiar la implementación sin tocar el código del use case
///    Solo cambiar el registro en configurarDependencias().
///
/// 4. SINGLE SOURCE OF TRUTH: todas las dependencias en un solo lugar
///    Fácil ver qué implementación usa cada servicio.

// =============================================================================
// DEMOSTRACIÓN
// =============================================================================

Future<void> main() async {
  print('=== Inyección de Dependencias — Demostración ===\n');

  // ─── Escenario 1: Producción ────────────────────────────────────────────────
  print('--- Producción ---');
  configurarDependencias(esModo: false);

  final sl = ServiceLocator();
  final useCase = sl.obtener<ObtenerProductosUseCase>();
  final productos = await useCase.execute();
  print('Productos: $productos\n');

  // ─── Escenario 2: Tests con mocks ───────────────────────────────────────────
  print('--- Tests (con mocks) ---');
  // En tests se pasan los mocks directamente por constructor
  final useCaseTest = ObtenerProductosUseCase(
    repositorio: ProductoRepositoryMock(),
    auth: AuthServiceImpl(),
  );
  final productosTest = await useCaseTest.execute();
  print('Productos test: $productosTest\n');

  print('Ventajas demostradas:');
  print('  ✓ Use Case desacoplado de la implementación concreta');
  print('  ✓ Fácil de testear con mocks');
  print('  ✓ Una sola línea para cambiar la implementación');
}
