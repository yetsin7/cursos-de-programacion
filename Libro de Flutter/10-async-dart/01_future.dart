// =============================================================================
// ARCHIVO: 01_future.dart
// TEMA: Future en Dart — promesas de valores futuros
// =============================================================================
//
// Un Future representa un valor que se completará en algún momento futuro.
// Es la abstracción central de la asincronía en Dart. Antes de async/await,
// se encadenaban con .then() y .catchError(). Hoy se prefiere async/await,
// pero entender Future directamente es fundamental.
//
// CÓMO EJECUTAR:
//   dart run 01_future.dart
//
// =============================================================================

// ────────────────────────────────────────────────────────────────────────────
// 1. Future.value y Future.delayed
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra la creación de Futures con value y delayed.
Future<void> demoFutureBasico() async {
  print('── Future básico ──');

  // Future.value: se completa inmediatamente con el valor dado
  Future<int> inmediato = Future.value(42);
  int valor = await inmediato;
  print('Future.value: $valor');

  // Future.delayed: se completa después del tiempo dado
  print('Esperando 500ms...');
  String resultado = await Future.delayed(
    Duration(milliseconds: 500),
    () => 'completado después de 500ms',
  );
  print('Future.delayed: $resultado');

  // Future<void>: para operaciones sin valor de retorno
  await Future.delayed(Duration(milliseconds: 100));
  print('Future<void> completado.');
}

// ────────────────────────────────────────────────────────────────────────────
// 2. then, catchError, whenComplete
// ────────────────────────────────────────────────────────────────────────────

/// Simula una petición HTTP que puede fallar.
Future<String> simularPeticionHttp(String url, {bool fallar = false}) {
  return Future.delayed(Duration(milliseconds: 300), () {
    if (fallar) throw Exception('Error de red: no se pudo conectar a $url');
    return '{"status": 200, "url": "$url"}';
  });
}

/// Demuestra el encadenamiento con .then() y .catchError().
Future<void> demoThenCatchError() async {
  print('\n── .then() / .catchError() / .whenComplete() ──');

  // Encadenamiento exitoso
  await simularPeticionHttp('https://api.ejemplo.com/usuarios')
      .then((respuesta) {
        print('Respuesta: $respuesta');
        return respuesta.length; // Transforma el valor
      })
      .then((longitud) {
        print('Longitud de respuesta: $longitud caracteres');
      })
      .catchError((error) {
        print('Error: $error');
      })
      .whenComplete(() {
        // Siempre se ejecuta — equivale a finally
        print('Petición completada (éxito o error).');
      });

  // Con error
  print('\nSimulando error de red:');
  await simularPeticionHttp('https://api.ejemplo.com/datos', fallar: true)
      .then((data) => print('Datos: $data'))
      .catchError((e) => print('Capturado: $e'))
      .whenComplete(() => print('Petición fallida completada.'));
}

// ────────────────────────────────────────────────────────────────────────────
// 3. Future<T> con tipos específicos
// ────────────────────────────────────────────────────────────────────────────

/// Modelo de producto para el ejemplo.
class Producto {
  // ID del producto
  final String id;
  // Nombre del producto
  final String nombre;
  // Precio del producto
  final double precio;

  /// Crea un producto con id, nombre y precio.
  const Producto(this.id, this.nombre, this.precio);

  @override
  String toString() => '$nombre (\$${precio.toStringAsFixed(2)})';
}

/// Simula la carga de un producto desde la base de datos.
Future<Producto> cargarProducto(String id) {
  return Future.delayed(Duration(milliseconds: 200), () {
    // Base de datos simulada
    const productos = {
      'P1': Producto('P1', 'Laptop', 999.99),
      'P2': Producto('P2', 'Mouse', 29.99),
      'P3': Producto('P3', 'Teclado', 79.99),
    };
    Producto? p = productos[id];
    if (p == null) throw Exception('Producto $id no encontrado');
    return p;
  });
}

// ────────────────────────────────────────────────────────────────────────────
// 4. Future.wait — Ejecutar múltiples Futures en paralelo
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra Future.wait para ejecutar múltiples operaciones en paralelo.
Future<void> demoFutureWait() async {
  print('\n── Future.wait (paralelo) ──');

  Stopwatch sw = Stopwatch()..start();

  // Sin paralelismo: secuencial (lento)
  // Producto p1 = await cargarProducto('P1'); // 200ms
  // Producto p2 = await cargarProducto('P2'); // 200ms más = 400ms total

  // Con Future.wait: paralelo (rápido)
  // Las tres cargas se lanzan SIMULTÁNEAMENTE
  List<Producto> productos = await Future.wait([
    cargarProducto('P1'),
    cargarProducto('P2'),
    cargarProducto('P3'),
  ]);

  sw.stop();
  print('Cargados en paralelo (${sw.elapsedMilliseconds}ms):');
  for (Producto p in productos) {
    print('  - $p');
  }

  // Future.wait con manejo de errores
  print('\nFuture.wait con un error:');
  try {
    await Future.wait([
      cargarProducto('P1'),
      cargarProducto('P999'), // Lanzará error
      cargarProducto('P2'),
    ]);
  } catch (e) {
    // Si cualquier Future falla, Future.wait lanza el primer error
    print('Error en wait: $e');
  }

  // eagerError: true (por defecto) — falla tan pronto como un Future falla
  // eagerError: false — espera a que todos terminen antes de lanzar
}

// ────────────────────────────────────────────────────────────────────────────
// 5. Future.any y Future.error
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra Future.any (el primero que complete) y Future.error.
Future<void> demoFutureAny() async {
  print('\n── Future.any y Future.error ──');

  // Future.any: retorna cuando el PRIMERO de los Futures completa
  Future<String> resultado = Future.any([
    Future.delayed(Duration(milliseconds: 300), () => 'servidor 1 (300ms)'),
    Future.delayed(Duration(milliseconds: 100), () => 'servidor 2 (100ms)'),
    Future.delayed(Duration(milliseconds: 200), () => 'servidor 3 (200ms)'),
  ]);
  print('Más rápido: ${await resultado}'); // servidor 2

  // Future.error: crea un Future que falla inmediatamente
  Future<int> fallido = Future.error(Exception('Error intencional'));
  try {
    await fallido;
  } catch (e) {
    print('Future.error atrapado: $e');
  }
}

Future<void> main() async {
  await demoFutureBasico();
  await demoThenCatchError();

  print('\n── cargarProducto con Future<Producto> ──');
  await cargarProducto('P1').then((p) => print('Cargado: $p'));

  await demoFutureWait();
  await demoFutureAny();

  print('\n¡Programa asíncrono completado!');
}

// EXPERIMENTA:
//   - Mide el tiempo de 3 cargas secuenciales vs Future.wait paralelo
//   - Implementa un timeout con Future.any([operacion, Future.delayed(...)])
//   - Crea un Future que reintenta automáticamente hasta 3 veces si falla
//   - Prueba qué pasa si haces await dentro de un forEach — ¿funciona como esperas?
