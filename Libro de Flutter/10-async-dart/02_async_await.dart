// =============================================================================
// ARCHIVO: 02_async_await.dart
// TEMA: async/await en Dart
// =============================================================================
//
// async/await es azúcar sintáctico sobre Futures que hace el código asíncrono
// tan legible como el síncrono. Una función marcada con 'async' siempre retorna
// un Future. 'await' pausa la función (no el hilo) hasta que el Future completa.
//
// CÓMO EJECUTAR:
//   dart run 02_async_await.dart
//
// =============================================================================

// ────────────────────────────────────────────────────────────────────────────
// 1. async marca la función — await espera el Future
// ────────────────────────────────────────────────────────────────────────────

/// Simula obtener el nombre de usuario desde una API.
/// 'async' hace que la función retorne automáticamente Future<String>.
Future<String> obtenerNombreUsuario(int id) async {
  // await suspende esta función hasta que el delayed completa
  // El hilo NO se bloquea — puede atender otros eventos
  await Future.delayed(Duration(milliseconds: 200));

  // Simular datos del servidor
  Map<int, String> usuarios = {1: 'Ana García', 2: 'Bob Martínez', 3: 'Carlos López'};
  String? nombre = usuarios[id];
  if (nombre == null) throw Exception('Usuario $id no encontrado');
  return nombre;
}

/// Función simple que demuestra async/await básico.
Future<void> demoAsyncAwaitBasico() async {
  print('── async/await básico ──');

  print('Solicitando nombre...');
  String nombre = await obtenerNombreUsuario(1);
  print('Nombre obtenido: $nombre');

  // Múltiples awaits en secuencia
  String n1 = await obtenerNombreUsuario(1);
  String n2 = await obtenerNombreUsuario(2);
  print('Usuarios: $n1, $n2');
}

// ────────────────────────────────────────────────────────────────────────────
// 2. El tipo de retorno de async siempre es Future<T>
// ────────────────────────────────────────────────────────────────────────────

/// Calcula la suma de una lista de números de forma asíncrona.
/// async + return int → retorno real es Future<int>
Future<int> sumarAsync(List<int> numeros) async {
  // Simular un cálculo costoso
  await Future.delayed(Duration(milliseconds: 50));
  return numeros.fold(0, (acc, n) => acc + n);
}

/// Función que retorna void pero es asíncrona.
/// Future<void> indica que es async pero no produce un valor.
Future<void> guardarDato(String dato) async {
  await Future.delayed(Duration(milliseconds: 100));
  print('Dato guardado: $dato');
  // Sin return — automáticamente retorna Future<void>
}

// ────────────────────────────────────────────────────────────────────────────
// 3. try/catch con async/await
// ────────────────────────────────────────────────────────────────────────────

/// Simula cargar datos de un endpoint que puede fallar.
Future<Map<String, dynamic>> cargarDatos(String endpoint) async {
  await Future.delayed(Duration(milliseconds: 150));
  if (endpoint.contains('error')) {
    throw Exception('Endpoint no disponible: $endpoint');
  }
  return {'endpoint': endpoint, 'datos': [1, 2, 3], 'total': 3};
}

/// Demuestra manejo de errores con try/catch en funciones async.
Future<void> demoTryCatchAsync() async {
  print('\n── try/catch con async/await ──');

  // Caso exitoso
  try {
    Map<String, dynamic> datos = await cargarDatos('/api/usuarios');
    print('Datos cargados: $datos');
  } catch (e) {
    print('Error: $e');
  }

  // Caso con error
  try {
    Map<String, dynamic> datos = await cargarDatos('/api/error/datos');
    print('Datos: $datos'); // No llega aquí
  } catch (e) {
    print('Error capturado: $e');
  } finally {
    print('Limpieza completada.');
  }
}

// ────────────────────────────────────────────────────────────────────────────
// 4. Por qué async/await es mejor que .then()
// ────────────────────────────────────────────────────────────────────────────

/// Modelo de pedido para el ejemplo.
class Pedido {
  // ID del pedido
  final String id;
  // Items del pedido
  final List<String> items;

  /// Crea un pedido con id e items.
  const Pedido(this.id, this.items);
}

/// Simula obtener el ID del usuario actual.
Future<String> obtenerIdUsuarioActual() =>
    Future.delayed(Duration(milliseconds: 100), () => 'USR-42');

/// Simula cargar los pedidos de un usuario.
Future<List<Pedido>> cargarPedidosDeUsuario(String idUsuario) =>
    Future.delayed(Duration(milliseconds: 150), () => [
      Pedido('PED-1', ['laptop', 'mouse']),
      Pedido('PED-2', ['teclado']),
    ]);

/// Simula calcular el total de un pedido.
Future<double> calcularTotal(Pedido pedido) =>
    Future.delayed(Duration(milliseconds: 50), () => pedido.items.length * 99.99);

/// VERSIÓN CON .then() — Callback hell / pyramid of doom.
Future<void> flujoConThen() {
  print('\n── Flujo con .then() (difícil de leer) ──');
  return obtenerIdUsuarioActual()
      .then((idUsuario) {
        print('Usuario: $idUsuario');
        return cargarPedidosDeUsuario(idUsuario);
      })
      .then((pedidos) {
        print('Pedidos: ${pedidos.length}');
        return calcularTotal(pedidos.first);
      })
      .then((total) {
        print('Total primer pedido: \$${total.toStringAsFixed(2)}');
      });
}

/// VERSIÓN CON async/await — Limpia y lineal.
Future<void> flujoConAwait() async {
  print('\n── Flujo con async/await (limpio y lineal) ──');

  String idUsuario = await obtenerIdUsuarioActual();
  print('Usuario: $idUsuario');

  List<Pedido> pedidos = await cargarPedidosDeUsuario(idUsuario);
  print('Pedidos: ${pedidos.length}');

  double total = await calcularTotal(pedidos.first);
  print('Total primer pedido: \$${total.toStringAsFixed(2)}');
}

// ────────────────────────────────────────────────────────────────────────────
// 5. Paralelismo con async/await + Future.wait
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra la diferencia entre await secuencial y paralelo.
Future<void> demoParalelismo() async {
  print('\n── Secuencial vs paralelo ──');

  Stopwatch sw = Stopwatch()..start();

  // SECUENCIAL: espera a que cada uno termine antes del siguiente
  String n1 = await obtenerNombreUsuario(1);
  String n2 = await obtenerNombreUsuario(2);
  String n3 = await obtenerNombreUsuario(3);
  print('Secuencial (${sw.elapsedMilliseconds}ms): $n1, $n2, $n3');

  sw.reset();

  // PARALELO: lanza los tres Futures al mismo tiempo con Future.wait
  List<String> nombres = await Future.wait([
    obtenerNombreUsuario(1),
    obtenerNombreUsuario(2),
    obtenerNombreUsuario(3),
  ]);
  print('Paralelo (${sw.elapsedMilliseconds}ms): ${nombres.join(", ")}');
  sw.stop();
}

Future<void> main() async {
  await demoAsyncAwaitBasico();

  print('\n── Tipos de retorno async ──');
  int suma = await sumarAsync([1, 2, 3, 4, 5]);
  print('Suma async: $suma');
  await guardarDato('configuración_inicial');

  await demoTryCatchAsync();
  await flujoConThen();
  await flujoConAwait();
  await demoParalelismo();

  print('\n¡main() async completado!');
}

// EXPERIMENTA:
//   - Implementa un retry automático: si falla, intenta de nuevo hasta 3 veces
//   - Crea una función async que descargue 5 URLs en paralelo y retorne la más rápida
//   - Prueba qué pasa si NO usas await en una llamada async — ¿cuándo se ejecuta?
//   - Implementa un timeout: si el Future tarda más de 1s, lanzar TimeoutException
