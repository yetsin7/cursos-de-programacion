// =============================================================================
// ARCHIVO: 05_ejercicios.dart
// TEMA: Ejercicios de programación asíncrona
// =============================================================================
//
// Cuatro ejercicios prácticos que integran Future, async/await, Stream
// y manejo de errores asíncronos. Simulan escenarios reales de apps Flutter.
//
// CÓMO EJECUTAR:
//   dart run 05_ejercicios.dart
//
// =============================================================================

import 'dart:async';

/// Imprime el encabezado de un ejercicio numerado.
void ejercicio(int n, String titulo) {
  print('\n${'═' * 55}');
  print('EJERCICIO $n: $titulo');
  print('═' * 55);
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 1: Retry automático
// Implementar una función que reintenta una operación async fallida
// hasta N veces con espera exponencial entre intentos.
// ────────────────────────────────────────────────────────────────────────────

/// Ejecuta [operacion] con reintentos en caso de falla.
///
/// Reintenta hasta [maxIntentos] veces con espera exponencial:
/// primer reintento después de [baseMs]ms, segundo después de 2×[baseMs]ms, etc.
/// Lanza la última excepción si se agotan todos los intentos.
Future<T> conReintentos<T>(
  Future<T> Function() operacion, {
  int maxIntentos = 3,
  int baseMs = 100,
}) async {
  int intento = 0;

  while (true) {
    try {
      return await operacion();
    } catch (e) {
      intento++;
      if (intento >= maxIntentos) {
        print('Todos los intentos agotados ($maxIntentos). Último error: $e');
        rethrow;
      }
      int espera = baseMs * intento; // Espera exponencial simple
      print('Intento $intento falló. Reintentando en ${espera}ms...');
      await Future.delayed(Duration(milliseconds: espera));
    }
  }
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 2: Timeout personalizado
// Implementar una función que cancela una operación si tarda demasiado.
// ────────────────────────────────────────────────────────────────────────────

/// Excepción lanzada cuando una operación supera su tiempo límite.
class TimeoutPersonalizadoException implements Exception {
  // Descripción de la operación que expiró
  final String operacion;
  // Tiempo máximo en milisegundos
  final int limiteMs;
  /// Crea la excepción con la [operacion] que superó el [limiteMs].
  const TimeoutPersonalizadoException(this.operacion, this.limiteMs);
  @override
  String toString() => 'Timeout: "$operacion" superó ${limiteMs}ms';
}

/// Ejecuta [operacion] con un límite de tiempo [limiteMs].
///
/// Si la operación tarda más del límite, lanza TimeoutPersonalizadoException.
Future<T> conTimeout<T>(
  Future<T> Function() operacion,
  int limiteMs, {
  String nombre = 'operación',
}) async {
  return await operacion().timeout(
    Duration(milliseconds: limiteMs),
    onTimeout: () {
      throw TimeoutPersonalizadoException(nombre, limiteMs);
    },
  );
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 3: Stream acumulador
// Crear un Stream que emita la suma acumulada de una secuencia de números.
// ────────────────────────────────────────────────────────────────────────────

/// Emite la suma acumulada de los valores de [fuente].
///
/// Por cada valor emitido por [fuente], emite la suma total hasta ese punto.
/// Ejemplo: [1, 2, 3, 4] → [1, 3, 6, 10]
Stream<int> sumaAcumulada(Stream<int> fuente) async* {
  int suma = 0;
  await for (int valor in fuente) {
    suma += valor;
    yield suma;
  }
}

/// Genera un Stream de números aleatorios simulados.
Stream<int> generarValores(List<int> valores, {int retardoMs = 80}) async* {
  for (int v in valores) {
    await Future.delayed(Duration(milliseconds: retardoMs));
    yield v;
  }
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 4: Pipeline asíncrono
// Implementar un pipeline de transformaciones asíncronas encadenadas.
// ────────────────────────────────────────────────────────────────────────────

/// Modelo de producto para el pipeline.
class ProductoRaw {
  // Nombre del producto (puede estar mal formateado)
  final String nombre;
  // Precio como string (puede ser inválido)
  final String precioStr;
  /// Crea el producto raw.
  const ProductoRaw(this.nombre, this.precioStr);
}

/// Producto validado y normalizado.
class ProductoValido {
  // Nombre normalizado
  final String nombre;
  // Precio validado
  final double precio;
  // Precio con descuento calculado
  final double precioConDescuento;
  /// Crea el producto validado.
  const ProductoValido(this.nombre, this.precio, this.precioConDescuento);
  @override
  String toString() =>
      '$nombre: \$${precio.toStringAsFixed(2)} '
      '(con descuento: \$${precioConDescuento.toStringAsFixed(2)})';
}

/// Simula normalizar el nombre en un servicio externo.
Future<String> normalizarNombre(String nombre) async {
  await Future.delayed(Duration(milliseconds: 50));
  return nombre.trim().toLowerCase()
      .split(' ')
      .map((p) => p.isEmpty ? p : p[0].toUpperCase() + p.substring(1))
      .join(' ');
}

/// Simula obtener el descuento aplicable desde un servicio de precios.
Future<double> obtenerDescuento(double precio) async {
  await Future.delayed(Duration(milliseconds: 50));
  // Descuento del 10% para precios > 50, 5% para el resto
  return precio > 50 ? 0.10 : 0.05;
}

/// Procesa un ProductoRaw a través del pipeline completo.
///
/// Devuelve null si el producto no es válido (precio no parseable).
Future<ProductoValido?> procesarProducto(ProductoRaw raw) async {
  // Validar precio
  double? precio = double.tryParse(raw.precioStr);
  if (precio == null || precio <= 0) {
    print('  Descartado "${raw.nombre}": precio inválido "${raw.precioStr}"');
    return null;
  }

  // Paso 1: normalizar nombre
  String nombreNorm = await normalizarNombre(raw.nombre);

  // Paso 2: obtener descuento
  double descuento = await obtenerDescuento(precio);
  double precioFinal = precio * (1 - descuento);

  return ProductoValido(nombreNorm, precio, precioFinal);
}

// ────────────────────────────────────────────────────────────────────────────
// MAIN: Ejecutar todos los ejercicios
// ────────────────────────────────────────────────────────────────────────────

Future<void> main() async {
  // --- Ejercicio 1: Retry automático ---
  ejercicio(1, 'Retry automático con espera exponencial');

  int intentos = 0;
  try {
    String resultado = await conReintentos(
      () async {
        intentos++;
        if (intentos < 3) throw Exception('Fallo simulado #$intentos');
        return 'éxito en intento $intentos';
      },
      maxIntentos: 3,
      baseMs: 50,
    );
    print('Resultado: $resultado');
  } catch (e) {
    print('Error final: $e');
  }

  // --- Ejercicio 2: Timeout ---
  ejercicio(2, 'Timeout personalizado');

  // Operación que completa dentro del tiempo límite
  try {
    String r = await conTimeout(
      () => Future.delayed(Duration(milliseconds: 100), () => 'completado'),
      500,
      nombre: 'carga de datos',
    );
    print('Éxito: $r');
  } on TimeoutPersonalizadoException catch (e) {
    print('Error: $e');
  }

  // Operación que excede el tiempo límite
  try {
    await conTimeout(
      () => Future.delayed(Duration(milliseconds: 500), () => 'lento'),
      100,
      nombre: 'carga lenta',
    );
  } on TimeoutPersonalizadoException catch (e) {
    print('Timeout capturado: $e');
  }

  // --- Ejercicio 3: Stream acumulador ---
  ejercicio(3, 'Stream de suma acumulada');

  Stream<int> valores = generarValores([5, 3, 8, 2, 7]);
  Stream<int> acumulado = sumaAcumulada(valores);

  print('Valores → Suma acumulada:');
  await for (int suma in acumulado) {
    print('  Total: $suma');
  }

  // --- Ejercicio 4: Pipeline asíncrono ---
  ejercicio(4, 'Pipeline asíncrono de productos');

  List<ProductoRaw> productosRaw = [
    ProductoRaw('  laptop pro  ', '999.99'),
    ProductoRaw('MOUSE inalámbrico', '29.99'),
    ProductoRaw('teclado mecánico', 'precio_invalido'), // Inválido
    ProductoRaw('monitor 4K', '399.99'),
    ProductoRaw('auriculares', '-10'),  // Precio negativo
  ];

  print('Procesando ${productosRaw.length} productos en paralelo...');
  Stopwatch sw = Stopwatch()..start();

  // Procesar todos en paralelo con Future.wait
  List<ProductoValido?> resultados = await Future.wait(
    productosRaw.map(procesarProducto),
  );

  sw.stop();

  // Filtrar los null (productos inválidos)
  List<ProductoValido> validos = resultados.whereType<ProductoValido>().toList();

  print('Procesados en ${sw.elapsedMilliseconds}ms:');
  for (ProductoValido p in validos) {
    print('  $p');
  }
  print('Válidos: ${validos.length} / ${productosRaw.length}');

  print('\n¡Todos los ejercicios completados!');
}

// EXPERIMENTA:
//   - Combina retry + timeout: reintentar pero abortar si un intento tarda demasiado
//   - Crea un stream de "ventana deslizante" que emita promedios de los últimos N valores
//   - Implementa un caché async: si el resultado ya fue calculado, devolver del caché
//   - Crea un pipeline donde cada etapa puede ser cancelada con CancelToken
