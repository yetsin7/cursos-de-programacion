// =============================================================================
// ARCHIVO: 03_ejercicios.dart
// TEMA: Ejercicios de manejo de errores
// =============================================================================
//
// Cuatro ejercicios prácticos que integran try/catch, excepciones
// personalizadas y el Result pattern. Cada uno simula un escenario
// real de una aplicación Flutter.
//
// CÓMO EJECUTAR:
//   dart run 03_ejercicios.dart
//
// =============================================================================

/// Imprime el encabezado de un ejercicio numerado.
void ejercicio(int n, String titulo) {
  print('\n${'═' * 55}');
  print('EJERCICIO $n: $titulo');
  print('═' * 55);
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 1: Parser de configuración
// Parsear un mapa de configuración, lanzando excepciones descriptivas
// si faltan claves obligatorias o los valores tienen formato incorrecto.
// ────────────────────────────────────────────────────────────────────────────

/// Excepción para claves obligatorias ausentes en la configuración.
class ClaveFaltanteException implements Exception {
  // Nombre de la clave que falta
  final String clave;
  /// Crea la excepción para la [clave] faltante.
  const ClaveFaltanteException(this.clave);
  @override
  String toString() => 'ClaveFaltanteException: Se requiere la clave "$clave"';
}

/// Excepción para valores con formato incorrecto.
class FormatoInvalidoException implements Exception {
  // Nombre del campo con formato incorrecto
  final String campo;
  // Valor que se recibió
  final String valorRecibido;
  // Formato esperado
  final String formatoEsperado;
  /// Crea la excepción de formato para el [campo] dado.
  const FormatoInvalidoException(this.campo, this.valorRecibido, this.formatoEsperado);
  @override
  String toString() =>
      'FormatoInvalidoException[$campo]: '
      'Se recibió "$valorRecibido", se esperaba $formatoEsperado';
}

/// Configuración parseada de la app.
class ConfigApp {
  // URL del servidor API
  final String apiUrl;
  // Puerto del servidor
  final int puerto;
  // Tiempo de espera en segundos
  final int timeoutSegundos;
  // Si el modo debug está activo
  final bool debug;

  /// Crea la configuración con los valores dados.
  const ConfigApp({
    required this.apiUrl,
    required this.puerto,
    required this.timeoutSegundos,
    required this.debug,
  });

  @override
  String toString() =>
      'ConfigApp(url: $apiUrl, puerto: $puerto, '
      'timeout: ${timeoutSegundos}s, debug: $debug)';
}

/// Parsea el [mapa] de configuración en un objeto ConfigApp.
///
/// Lanza [ClaveFaltanteException] si falta una clave obligatoria.
/// Lanza [FormatoInvalidoException] si un valor tiene tipo incorrecto.
ConfigApp parsearConfig(Map<String, dynamic> mapa) {
  // Verificar clave 'api_url'
  if (!mapa.containsKey('api_url')) throw ClaveFaltanteException('api_url');
  String apiUrl = mapa['api_url'].toString();
  if (!apiUrl.startsWith('http')) {
    throw FormatoInvalidoException('api_url', apiUrl, 'URL que empiece con http/https');
  }

  // Verificar clave 'puerto'
  if (!mapa.containsKey('puerto')) throw ClaveFaltanteException('puerto');
  int? puerto = int.tryParse(mapa['puerto'].toString());
  if (puerto == null || puerto < 1 || puerto > 65535) {
    throw FormatoInvalidoException('puerto', mapa['puerto'].toString(), 'entero entre 1 y 65535');
  }

  // 'timeout' con valor por defecto si no está presente
  int timeoutSegundos = 30;
  if (mapa.containsKey('timeout')) {
    int? t = int.tryParse(mapa['timeout'].toString());
    if (t == null || t <= 0) {
      throw FormatoInvalidoException('timeout', mapa['timeout'].toString(), 'entero positivo');
    }
    timeoutSegundos = t;
  }

  // 'debug' con valor por defecto false
  bool debug = mapa['debug'] == true || mapa['debug'] == 'true';

  return ConfigApp(
    apiUrl: apiUrl,
    puerto: puerto,
    timeoutSegundos: timeoutSegundos,
    debug: debug,
  );
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 2: Calculadora segura con Result
// Implementar operaciones matemáticas que devuelven Result<double, String>
// en lugar de lanzar excepciones.
// ────────────────────────────────────────────────────────────────────────────

/// Resultado de una operación matemática.
sealed class ResultadoMath {}

/// Operación exitosa con el [valor] numérico resultante.
class MathExito extends ResultadoMath {
  // Valor numérico del resultado
  final double valor;
  /// Crea un resultado exitoso con el [valor] dado.
  const MathExito(this.valor);
  @override
  String toString() => valor.toStringAsFixed(6);
}

/// Operación fallida con el [error] descriptivo.
class MathError extends ResultadoMath {
  // Descripción del error matemático
  final String error;
  /// Crea un error matemático con la descripción dada.
  const MathError(this.error);
  @override
  String toString() => 'Error: $error';
}

/// Calculadora que devuelve Result en lugar de lanzar excepciones.
class CalculadoraSegura {
  /// División segura: error si b == 0.
  ResultadoMath dividir(double a, double b) {
    if (b == 0) return MathError('División por cero: $a / $b');
    return MathExito(a / b);
  }

  /// Raíz cuadrada segura: error si n < 0.
  ResultadoMath raizCuadrada(double n) {
    if (n < 0) return MathError('Raíz cuadrada de número negativo: $n');
    double resultado = n;
    for (int i = 0; i < 50; i++) {
      resultado = (resultado + n / resultado) / 2;
    }
    return n == 0 ? MathExito(0) : MathExito(resultado);
  }

  /// Logaritmo natural seguro: error si n <= 0.
  ResultadoMath logaritmo(double n) {
    if (n <= 0) return MathError('Logaritmo de número no positivo: $n');
    // Aproximación de ln(n) para demostrar el patrón
    // En producción se usaría dart:math
    return MathExito(_ln(n));
  }

  /// Calcula ln(x) usando la serie de Taylor (aproximación).
  double _ln(double x) {
    if (x <= 0) return double.negativeInfinity;
    // Usando la identidad: ln(x) = 2 * arctanh((x-1)/(x+1))
    double y = (x - 1) / (x + 1);
    double suma = 0;
    double potencia = y;
    for (int i = 0; i < 100; i++) {
      suma += potencia / (2 * i + 1);
      potencia *= y * y;
    }
    return 2 * suma;
  }
}

// ────────────────────────────────────────────────────────────────────────────
// MAIN: Ejecutar todos los ejercicios
// ────────────────────────────────────────────────────────────────────────────

void main() {
  // --- Ejercicio 1: Parser de configuración ---
  ejercicio(1, 'Parser de configuración con excepciones personalizadas');

  List<Map<String, dynamic>> configs = [
    // Configuración válida
    {'api_url': 'https://api.ejemplo.com', 'puerto': '8080', 'debug': true},
    // Sin api_url
    {'puerto': '3000'},
    // Puerto inválido
    {'api_url': 'https://api.com', 'puerto': '99999'},
    // URL con formato incorrecto
    {'api_url': 'ftp://servidor.com', 'puerto': '80'},
    // Timeout inválido
    {'api_url': 'https://api.com', 'puerto': '443', 'timeout': '-5'},
  ];

  for (Map<String, dynamic> config in configs) {
    try {
      ConfigApp cfg = parsearConfig(config);
      print('Config válida: $cfg');
    } on ClaveFaltanteException catch (e) {
      print('Falta clave: $e');
    } on FormatoInvalidoException catch (e) {
      print('Formato incorrecto: $e');
    }
  }

  // --- Ejercicio 2: Calculadora segura ---
  ejercicio(2, 'Calculadora segura con Result pattern');

  CalculadoraSegura calc = CalculadoraSegura();

  List<ResultadoMath> resultados = [
    calc.dividir(10, 3),
    calc.dividir(5, 0),
    calc.raizCuadrada(16),
    calc.raizCuadrada(-4),
    calc.logaritmo(2.718281828),
    calc.logaritmo(-1),
  ];

  for (ResultadoMath r in resultados) {
    switch (r) {
      case MathExito(valor: var v):
        print('Resultado: ${v.toStringAsFixed(4)}');
      case MathError(error: var e):
        print('Error: $e');
    }
  }

  print('\n¡Todos los ejercicios completados!');
}

// EXPERIMENTA:
//   - Agrega una operación potencia(base, exponente) a la calculadora
//   - Extiende parsearConfig para manejar una lista de 'hosts_permitidos'
//   - Implementa un try/catch que atrape CUALQUIER excepción y la convierta a Result
//   - Crea una cadena de operaciones con Result donde cada paso depende del anterior
