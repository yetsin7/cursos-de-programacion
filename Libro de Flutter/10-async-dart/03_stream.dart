// =============================================================================
// ARCHIVO: 03_stream.dart
// TEMA: Streams en Dart — flujos de datos a lo largo del tiempo
// =============================================================================
//
// Un Stream emite múltiples valores de forma asíncrona a lo largo del tiempo.
// Mientras Future es "un valor en el futuro", Stream es "muchos valores
// en el futuro". En Flutter los StreamBuilders reaccionan a estos eventos
// para actualizar la UI automáticamente.
//
// CÓMO EJECUTAR:
//   dart run 03_stream.dart
//
// =============================================================================

import 'dart:async';

// ────────────────────────────────────────────────────────────────────────────
// 1. CREAR STREAMS CON async*
// ────────────────────────────────────────────────────────────────────────────

/// Genera números del 1 al [hasta] con un retraso entre cada uno.
///
/// 'async*' marca una función generadora asíncrona.
/// 'yield' emite un valor al Stream sin terminar la función.
Stream<int> generarNumeros(int hasta, {int retardoMs = 100}) async* {
  for (int i = 1; i <= hasta; i++) {
    await Future.delayed(Duration(milliseconds: retardoMs));
    yield i; // Emite el valor i al Stream
  }
  // Cuando la función termina, el Stream se cierra automáticamente
}

/// Genera el Stream de Fibonacci infinitamente.
/// Con takeWhile() o take() el consumidor decide cuándo parar.
Stream<int> fibonacci() async* {
  int a = 0, b = 1;
  while (true) {
    yield a;
    int temp = a + b;
    a = b;
    b = temp;
    await Future.delayed(Duration(milliseconds: 50));
  }
}

// ────────────────────────────────────────────────────────────────────────────
// 2. CONSUMIR STREAMS CON listen()
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra el método listen() para suscribirse a un Stream.
Future<void> demoListen() async {
  print('── Stream con listen() ──');

  Stream<int> numeros = generarNumeros(5);

  // listen() retorna StreamSubscription — guárdalo para cancelar luego
  Completer<void> completer = Completer();

  StreamSubscription<int> suscripcion = numeros.listen(
    // onData: se llama por cada valor emitido
    (numero) => print('Recibido: $numero'),
    // onError: se llama si el Stream emite un error
    onError: (e) => print('Error en stream: $e'),
    // onDone: se llama cuando el Stream se cierra
    onDone: () {
      print('Stream completado.');
      completer.complete();
    },
  );

  await completer.future;
  await suscripcion.cancel(); // Liberar recursos
}

// ────────────────────────────────────────────────────────────────────────────
// 3. CONSUMIR STREAMS CON await for
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra 'await for' para consumir streams de forma secuencial.
///
/// 'await for' procesa un valor a la vez — más legible que listen().
Future<void> demoAwaitFor() async {
  print('\n── Stream con await for ──');

  // Suma todos los números del stream
  int suma = 0;
  await for (int n in generarNumeros(10, retardoMs: 30)) {
    suma += n;
    // break sale del loop Y cancela el stream automáticamente
    if (suma > 30) {
      print('Suma superó 30, deteniendo. Suma: $suma');
      break;
    }
  }

  // Fibonacci con take(): toma solo los primeros N elementos
  print('\nPrimeros 8 Fibonacci:');
  List<int> fibs = [];
  await for (int n in fibonacci().take(8)) {
    fibs.add(n);
  }
  print(fibs);
}

// ────────────────────────────────────────────────────────────────────────────
// 4. TRANSFORMAR STREAMS: map, where, take, skip
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra los operadores de transformación de streams.
Future<void> demoTransformaciones() async {
  print('\n── Transformaciones de Stream ──');

  Stream<int> base = generarNumeros(10, retardoMs: 20);

  // Encadenar transformaciones como en Iterable
  Stream<String> transformado = base
      .where((n) => n % 2 == 0)         // Solo pares
      .map((n) => n * n)                 // Elevar al cuadrado
      .take(3)                           // Solo los primeros 3
      .map((n) => 'cuadrado: $n');       // Formatear como string

  await for (String msg in transformado) {
    print(msg);
  }

  // distinct(): filtra valores duplicados consecutivos
  Stream<int> conRepetidos = Stream.fromIterable([1, 1, 2, 2, 3, 1, 1]);
  List<int> sinRepetidos = await conRepetidos.distinct().toList();
  print('Sin repetidos consecutivos: $sinRepetidos'); // [1, 2, 3, 1]
}

// ────────────────────────────────────────────────────────────────────────────
// 5. StreamController — Crear streams personalizados
// ────────────────────────────────────────────────────────────────────────────

/// Servicio que emite actualizaciones de precio en tiempo real.
/// Usa StreamController para tener control total sobre cuándo emitir eventos.
class ServicioPreciosTiempoReal {
  // Controller que administra el stream de precios
  final StreamController<double> _controller = StreamController<double>();

  // Suscripción al timer interno
  StreamSubscription<int>? _timer;

  /// Stream público de precios — los clientes se suscriben a este.
  Stream<double> get precios => _controller.stream;

  /// Inicia la emisión de precios simulados cada [intervaloMs] milisegundos.
  void iniciar(int intervaloMs) {
    double precio = 100.0;
    int tick = 0;

    _timer = Stream.periodic(Duration(milliseconds: intervaloMs)).listen((_) {
      // Simular variación de precio ±5%
      double variacion = (tick % 2 == 0 ? 1.02 : 0.98);
      precio *= variacion;
      tick++;

      if (!_controller.isClosed) {
        _controller.add(precio); // Emitir el nuevo precio
      }
    });
  }

  /// Detiene la emisión y cierra el stream.
  Future<void> detener() async {
    await _timer?.cancel();
    await _controller.close();
  }
}

/// Demuestra StreamController con un servicio de precios.
Future<void> demoStreamController() async {
  print('\n── StreamController: precios en tiempo real ──');

  ServicioPreciosTiempoReal servicio = ServicioPreciosTiempoReal();
  servicio.iniciar(150);

  int contador = 0;
  await for (double precio in servicio.precios) {
    print('Precio: \$${precio.toStringAsFixed(2)}');
    contador++;
    if (contador >= 5) break;
  }

  await servicio.detener();
  print('Servicio detenido.');
}

// ────────────────────────────────────────────────────────────────────────────
// 6. Broadcast vs Single-subscription
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra la diferencia entre streams de suscripción única y broadcast.
Future<void> demoBroadcast() async {
  print('\n── Single-subscription vs Broadcast ──');

  // Single-subscription: solo UN oyente a la vez (por defecto)
  Stream<int> single = Stream.fromIterable([1, 2, 3]);
  single.listen((n) => print('Oyente 1: $n'));
  // Si intentas: single.listen((n) => print('Oyente 2: $n'));
  // lanzará: Bad state: Stream has already been listened to.

  await Future.delayed(Duration(milliseconds: 50));

  // Broadcast: múltiples oyentes simultáneos
  StreamController<int> broadcastCtrl = StreamController<int>.broadcast();
  Stream<int> broadcast = broadcastCtrl.stream;

  // Dos oyentes simultáneos
  broadcast.listen((n) => print('Oyente A: $n'));
  broadcast.listen((n) => print('Oyente B: $n'));

  broadcastCtrl.add(10);
  broadcastCtrl.add(20);

  await Future.delayed(Duration(milliseconds: 50));
  await broadcastCtrl.close();
}

Future<void> main() async {
  await demoListen();
  await demoAwaitFor();
  await demoTransformaciones();
  await demoStreamController();
  await demoBroadcast();

  print('\n¡Todos los streams completados!');
}

// EXPERIMENTA:
//   - Crea un Stream que emita el clima cada 2 segundos con datos simulados
//   - Implementa un operador bufferCount(n) que agrupe valores en listas de n
//   - Usa stream.asyncMap() para transformar cada valor con una función async
//   - Crea un StreamTransformer personalizado que aplique debounce
