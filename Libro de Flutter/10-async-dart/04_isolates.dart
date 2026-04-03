// =============================================================================
// ARCHIVO: 04_isolates.dart
// TEMA: Isolates en Dart — verdadero paralelismo
// =============================================================================
//
// Los Isolates son los "hilos" de Dart, pero con memoria completamente
// separada. No comparten estado — se comunican por mensajes. Esto evita
// race conditions. Úsalos para trabajo CPU-intensivo que bloquearía el UI.
//
// CÓMO EJECUTAR:
//   dart run 04_isolates.dart
//
// =============================================================================

import 'dart:isolate';

// ────────────────────────────────────────────────────────────────────────────
// 1. Problema: trabajo CPU-intensivo bloquea el hilo principal
// ────────────────────────────────────────────────────────────────────────────

/// Calcula el n-ésimo número de Fibonacci de forma recursiva.
///
/// Esta implementación es INTENCIONALMENTE ineficiente para demostrar
/// que el trabajo pesado bloquea el hilo si no se aisla.
int fibonacci(int n) {
  if (n <= 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

/// Simula el problema: calcular fibonacci(40) bloquea el UI en Flutter.
Future<void> demoProblema() async {
  print('── Problema: trabajo pesado en el hilo principal ──');

  Stopwatch sw = Stopwatch()..start();

  // En Flutter, esto congela la UI durante el cálculo
  // El usuario no puede hacer scroll, tap, ni ver animaciones
  int resultado = fibonacci(38); // Cálculo costoso

  sw.stop();
  print('fibonacci(38) = $resultado (tardó ${sw.elapsedMilliseconds}ms)');
  print('Durante ese tiempo, la UI de Flutter estaría congelada.');
}

// ────────────────────────────────────────────────────────────────────────────
// 2. Solución: Isolate.run() para trabajo en background
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra Isolate.run() — la forma más simple de usar isolates.
///
/// Isolate.run() ejecuta la función en un isolate separado, devuelve
/// el resultado como Future y destruye el isolate automáticamente.
Future<void> demoIsolateRun() async {
  print('\n── Isolate.run() — background work ──');

  Stopwatch sw = Stopwatch()..start();

  print('Lanzando cálculo en isolate separado...');

  // El cálculo ocurre en otro isolate — el hilo principal NO se bloquea
  int resultado = await Isolate.run(() => fibonacci(38));

  sw.stop();
  print('fibonacci(38) = $resultado (tardó ${sw.elapsedMilliseconds}ms)');
  print('El hilo principal estuvo libre durante el cálculo.');
}

// ────────────────────────────────────────────────────────────────────────────
// 3. Múltiples tareas en paralelo con Isolates
// ────────────────────────────────────────────────────────────────────────────

/// Simula el procesamiento de un lote de datos (CPU-intensivo).
int procesarLote(List<int> datos) {
  // Simular trabajo pesado: suma con operaciones costosas
  int resultado = 0;
  for (int n in datos) {
    // Pequeño cálculo por elemento
    resultado += fibonacci(n % 20); // Máximo fibonacci(19)
  }
  return resultado;
}

/// Demuestra múltiples isolates ejecutándose en paralelo.
Future<void> demoMultiplesIsolates() async {
  print('\n── Múltiples isolates en paralelo ──');

  // Dividir trabajo en 3 lotes
  List<List<int>> lotes = [
    List.generate(5, (i) => i + 10),
    List.generate(5, (i) => i + 15),
    List.generate(5, (i) => i + 5),
  ];

  Stopwatch sw = Stopwatch()..start();

  // Lanzar los 3 isolates en PARALELO con Future.wait
  List<int> resultados = await Future.wait(
    lotes.map((lote) => Isolate.run(() => procesarLote(lote))),
  );

  sw.stop();
  print('Resultados de 3 isolates paralelos: $resultados');
  print('Tiempo total: ${sw.elapsedMilliseconds}ms');
}

// ────────────────────────────────────────────────────────────────────────────
// 4. Comunicación bidireccional con SendPort/ReceivePort
// ────────────────────────────────────────────────────────────────────────────

/// Función ejecutada en el isolate hijo.
/// Recibe un [mensaje] que contiene el SendPort del padre y los datos.
void funcionIsolateHijo(Map<String, dynamic> mensaje) {
  SendPort portPadre = mensaje['portPadre'] as SendPort;
  List<int> datos = List<int>.from(mensaje['datos'] as List);

  // Procesar y enviar resultados parciales al padre
  int suma = 0;
  for (int n in datos) {
    suma += n;
    // Enviar progreso al hilo principal
    portPadre.send({'tipo': 'progreso', 'valor': n, 'sumaAcumulada': suma});
  }

  // Enviar resultado final
  portPadre.send({'tipo': 'completado', 'resultado': suma});
}

/// Demuestra comunicación bidireccional entre isolates.
Future<void> demoComunicacionIsolates() async {
  print('\n── Comunicación con SendPort/ReceivePort ──');

  // Puerto donde el hilo principal escucha los mensajes del hijo
  ReceivePort portPrincipal = ReceivePort();

  // Lanzar el isolate hijo con los datos necesarios
  await Isolate.spawn(funcionIsolateHijo, {
    'portPadre': portPrincipal.sendPort,
    'datos': [10, 20, 30, 40, 50],
  });

  // Escuchar los mensajes del hijo
  await for (dynamic mensaje in portPrincipal) {
    if (mensaje['tipo'] == 'progreso') {
      print('  Progreso: +${mensaje['valor']} (acumulado: ${mensaje['sumaAcumulada']})');
    } else if (mensaje['tipo'] == 'completado') {
      print('Resultado final: ${mensaje['resultado']}');
      portPrincipal.close(); // Cerrar el puerto — termina el await for
    }
  }
}

// ────────────────────────────────────────────────────────────────────────────
// 5. Patrón en Flutter: cuándo usar Isolate.run()
// ────────────────────────────────────────────────────────────────────────────

/// Simula el parsing de un JSON grande (caso de uso real en Flutter).
Map<String, dynamic> parsearJsonGrande(String jsonStr) {
  // Simular trabajo costoso de parsing
  // En producción: jsonDecode(jsonStr) con string de MB
  Map<String, dynamic> resultado = {};
  for (int i = 0; i < 1000; i++) {
    resultado['clave_$i'] = 'valor_$i';
  }
  return resultado;
}

/// Demuestra el patrón recomendado para parsing en Flutter.
Future<void> demoPatronFlutter() async {
  print('\n── Patrón Flutter: Isolate.run para JSON ──');

  String jsonSimulado = '{"datos": [1,2,3]}';

  // En Flutter, NUNCA hagas esto en el hilo principal para JSON grande:
  // Map<String, dynamic> datos = jsonDecode(jsonGrande);

  // La forma correcta es usar Isolate.run:
  Map<String, dynamic> datos = await Isolate.run(
    () => parsearJsonGrande(jsonSimulado),
  );

  print('JSON procesado en isolate: ${datos.length} claves');
  print('Primera clave: ${datos['clave_0']}');
}

Future<void> main() async {
  await demoProblema();
  await demoIsolateRun();
  await demoMultiplesIsolates();
  await demoComunicacionIsolates();
  await demoPatronFlutter();

  print('\n── Resumen de cuándo usar Isolates ──');
  print('✓ Parsing de JSON o XML muy grandes (> 50KB)');
  print('✓ Procesamiento de imágenes o audio');
  print('✓ Criptografía y hashing intensivo');
  print('✓ Algoritmos de búsqueda o ordenamiento costosos');
  print('✗ Peticiones HTTP (usa async/await — el I/O no bloquea)');
  print('✗ Lecturas de base de datos (también son I/O no bloqueante)');
}

// EXPERIMENTA:
//   - Mide la diferencia de tiempo entre fibonacci(40) en main vs Isolate
//   - Implementa un pool de isolates para procesar N tareas en paralelo
//   - Crea un isolate que genere números primos y los envíe de uno en uno
//   - Prueba enviar un objeto complejo (con clases) entre isolates — ¿qué restricciones hay?
