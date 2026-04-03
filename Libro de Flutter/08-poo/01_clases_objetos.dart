// =============================================================================
// ARCHIVO: 01_clases_objetos.dart
// TEMA: Clases y objetos en Dart
// =============================================================================
//
// Una clase es el plano de construcción de un objeto. Define qué propiedades
// tiene y qué puede hacer. En Dart, las clases son la unidad fundamental de
// abstracción y son la base de toda app Flutter.
//
// CÓMO EJECUTAR:
//   dart run 01_clases_objetos.dart
//
// =============================================================================

// ────────────────────────────────────────────────────────────────────────────
// 1. CLASE SIMPLE CON PROPIEDADES Y MÉTODOS
// ────────────────────────────────────────────────────────────────────────────

/// Representa un libro con título, autor y número de páginas.
///
/// Demuestra: propiedades, constructor, métodos de instancia y toString().
class Libro {
  // Título del libro (público, inmutable)
  final String titulo;
  // Autor del libro (público, inmutable)
  final String autor;
  // Número de páginas (público, inmutable)
  final int paginas;
  // Indica si el libro fue leído (público, mutable)
  bool leido;

  /// Crea un libro con los datos dados. Por defecto no está leído.
  Libro(this.titulo, this.autor, this.paginas, {this.leido = false});

  /// Marca el libro como leído.
  void marcarLeido() {
    leido = true;
  }

  /// Devuelve una clasificación según el número de páginas.
  String get clasificacion {
    if (paginas < 100) return 'Corto';
    if (paginas < 300) return 'Mediano';
    return 'Largo';
  }

  /// Devuelve una representación legible del libro.
  @override
  String toString() => '"$titulo" de $autor ($paginas pgs) — $clasificacion';
}

// ────────────────────────────────────────────────────────────────────────────
// 2. PROPIEDADES PRIVADAS CON _ Y GETTERS/SETTERS
// ────────────────────────────────────────────────────────────────────────────

/// Representa una cuenta bancaria con saldo privado y acceso controlado.
///
/// Demuestra: propiedades privadas (_), getters y setters para encapsulamiento.
class CuentaBancaria {
  // Propietario de la cuenta (público)
  final String propietario;
  // Saldo actual — privado para controlar acceso
  double _saldo;
  // Historial de transacciones
  final List<String> _historial = [];

  /// Crea una cuenta para [propietario] con [saldoInicial].
  CuentaBancaria(this.propietario, double saldoInicial)
      : _saldo = saldoInicial;

  // Getter: acceso de solo lectura al saldo
  double get saldo => _saldo;

  // Getter: acceso de solo lectura al historial (copia para inmutabilidad)
  List<String> get historial => List.unmodifiable(_historial);

  /// Deposita [monto] en la cuenta. Rechaza montos no positivos.
  void depositar(double monto) {
    if (monto <= 0) {
      print('Error: el monto debe ser positivo.');
      return;
    }
    _saldo += monto;
    _historial.add('+ \$${monto.toStringAsFixed(2)}');
    print('Depósito de \$${monto.toStringAsFixed(2)} exitoso.');
  }

  /// Retira [monto] de la cuenta si hay saldo suficiente.
  bool retirar(double monto) {
    if (monto <= 0) {
      print('Error: el monto debe ser positivo.');
      return false;
    }
    if (monto > _saldo) {
      print('Error: saldo insuficiente.');
      return false;
    }
    _saldo -= monto;
    _historial.add('- \$${monto.toStringAsFixed(2)}');
    print('Retiro de \$${monto.toStringAsFixed(2)} exitoso.');
    return true;
  }

  /// Devuelve un resumen de la cuenta.
  @override
  String toString() =>
      'Cuenta de $propietario — Saldo: \$${_saldo.toStringAsFixed(2)}';
}

// ────────────────────────────────────────────────────────────────────────────
// 3. SETTER CON VALIDACIÓN
// ────────────────────────────────────────────────────────────────────────────

/// Modelo de temperatura con validación de rango.
///
/// Demuestra: setter con lógica de validación para proteger el estado interno.
class Temperatura {
  // Valor en Celsius — validado por el setter
  double _celsius;

  /// Crea una temperatura, validando que esté en rango físico posible.
  Temperatura(double celsius) : _celsius = celsius {
    if (celsius < -273.15) {
      throw ArgumentError('Temperatura menor al cero absoluto no es posible.');
    }
  }

  // Getter: temperatura en Celsius
  double get celsius => _celsius;

  // Setter con validación de rango físico
  set celsius(double valor) {
    if (valor < -273.15) {
      throw ArgumentError('No puede ser menor al cero absoluto (-273.15°C).');
    }
    _celsius = valor;
  }

  // Getter computado: conversión a Fahrenheit
  double get fahrenheit => _celsius * 9 / 5 + 32;

  // Getter computado: conversión a Kelvin
  double get kelvin => _celsius + 273.15;

  @override
  String toString() =>
      '${_celsius.toStringAsFixed(1)}°C = '
      '${fahrenheit.toStringAsFixed(1)}°F = '
      '${kelvin.toStringAsFixed(1)}K';
}

void main() {
  // ── Libros ──
  print('── Clase Libro ──');
  Libro dart = Libro('Programming Dart', 'Kathy Walrath', 480);
  Libro haiku = Libro('Haiku', 'Matsuo Bashō', 50);

  print(dart);
  print(haiku);
  dart.marcarLeido();
  print('¿Leído? ${dart.leido}');

  // ── Cuenta bancaria ──
  print('\n── CuentaBancaria con propiedades privadas ──');
  CuentaBancaria cuenta = CuentaBancaria('María López', 1000.0);
  print(cuenta);

  cuenta.depositar(500.0);
  cuenta.retirar(200.0);
  cuenta.retirar(2000.0); // Saldo insuficiente
  print(cuenta);
  print('Historial: ${cuenta.historial}');

  // No se puede hacer: cuenta._saldo = 9999; // Error de compilación

  // ── Temperatura ──
  print('\n── Temperatura con getter/setter ──');
  Temperatura t = Temperatura(100.0);
  print(t); // 100.0°C = 212.0°F = 373.1K

  t.celsius = -40.0;
  print(t); // -40.0°C = -40.0°F = 233.1K

  try {
    t.celsius = -300.0; // Menor al cero absoluto
  } catch (e) {
    print('Error: $e');
  }
}

// EXPERIMENTA:
//   - Agrega un setter para 'fahrenheit' que convierta y guarde en _celsius
//   - Crea una clase Rectangulo con propiedades ancho/alto y getters area/perimetro
//   - Agrega el operador == a Libro para comparar dos libros por título y autor
//   - Prueba qué pasa si intentas acceder a cuenta._saldo desde fuera de la clase
