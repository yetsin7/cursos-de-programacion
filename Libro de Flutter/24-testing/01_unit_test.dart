// =============================================================================
// ARCHIVO: 01_unit_test.dart
// TEMA: Unit Tests en Dart/Flutter
// =============================================================================
// CÓMO USAR: guardar en test/01_unit_test.dart y ejecutar: flutter test
// DEPENDENCIA: agregar en pubspec.yaml (dev_dependencies):
//   test: ^1.25.0
//   mockito: ^5.4.4
//   build_runner: ^2.4.9
// =============================================================================

// ignore_for_file: avoid_print

import 'package:test/test.dart';

// =============================================================================
// CÓDIGO DE PRODUCCIÓN — en una app real estaría en lib/
// =============================================================================

/// Calculadora simple para demostrar unit tests.
class Calculadora {
  /// Suma dos números.
  double sumar(double a, double b) => a + b;

  /// Resta b de a.
  double restar(double a, double b) => a - b;

  /// Multiplica dos números.
  double multiplicar(double a, double b) => a * b;

  /// Divide a entre b. Lanza ArgumentError si b es cero.
  double dividir(double a, double b) {
    if (b == 0) throw ArgumentError('No se puede dividir por cero');
    return a / b;
  }

  /// Retorna el factorial de n. Solo para n >= 0.
  int factorial(int n) {
    if (n < 0) throw ArgumentError('n debe ser >= 0');
    if (n == 0 || n == 1) return 1;
    return n * factorial(n - 1);
  }
}

/// Validador de contraseñas con reglas de negocio.
class ValidadorPassword {
  static const int longitudMinima = 8;

  /// Verifica si la contraseña cumple los requisitos mínimos.
  bool esValido(String password) {
    if (password.length < longitudMinima) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false; // Mayúscula
    if (!password.contains(RegExp(r'[0-9]'))) return false; // Número
    return true;
  }

  /// Retorna un mensaje de error o null si la contraseña es válida.
  String? mensajeError(String password) {
    if (password.length < longitudMinima) {
      return 'Mínimo $longitudMinima caracteres';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Debe incluir al menos una mayúscula';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Debe incluir al menos un número';
    }
    return null;
  }
}

/// Carrito de compras para demostrar tests de estado.
class Carrito {
  final Map<String, int> _items = {};

  int get totalItems => _items.values.fold(0, (suma, cant) => suma + cant);
  bool get estaVacio => _items.isEmpty;
  Map<String, int> get items => Map.unmodifiable(_items);

  /// Agrega una cantidad de un producto. Lanza si cantidad <= 0.
  void agregar(String producto, {int cantidad = 1}) {
    if (cantidad <= 0) throw ArgumentError('Cantidad debe ser positiva');
    _items[producto] = (_items[producto] ?? 0) + cantidad;
  }

  /// Elimina un producto del carrito.
  void eliminar(String producto) => _items.remove(producto);

  /// Vacía el carrito.
  void vaciar() => _items.clear();

  /// Retorna true si el carrito contiene el producto.
  bool contiene(String producto) => _items.containsKey(producto);
}

// =============================================================================
// TESTS
// =============================================================================

void main() {
  // ─── group() agrupa tests relacionados ───────────────────────────────────────
  group('Calculadora', () {
    late Calculadora calc;

    // setUp() se ejecuta ANTES de cada test del grupo
    setUp(() {
      calc = Calculadora();
      print('  setUp: nueva instancia de Calculadora creada');
    });

    // tearDown() se ejecuta DESPUÉS de cada test
    tearDown(() {
      print('  tearDown: test completado');
    });

    test('sumar: 2 + 3 = 5', () {
      // Arrange — preparar los datos
      const a = 2.0, b = 3.0;

      // Act — ejecutar la acción
      final resultado = calc.sumar(a, b);

      // Assert — verificar el resultado
      expect(resultado, equals(5.0));
    });

    test('sumar: números negativos', () {
      expect(calc.sumar(-5, 3), equals(-2));
    });

    test('restar: 10 - 4 = 6', () {
      expect(calc.restar(10, 4), equals(6));
    });

    test('multiplicar: 3 * 4 = 12', () {
      expect(calc.multiplicar(3, 4), equals(12));
    });

    test('dividir: 10 / 2 = 5', () {
      expect(calc.dividir(10, 2), equals(5));
    });

    test('dividir por cero lanza ArgumentError', () {
      // throwsA verifica que se lance una excepción específica
      expect(() => calc.dividir(10, 0), throwsA(isA<ArgumentError>()));
    });

    test('factorial(0) = 1', () => expect(calc.factorial(0), equals(1)));
    test('factorial(5) = 120', () => expect(calc.factorial(5), equals(120)));

    test('factorial negativo lanza ArgumentError', () {
      expect(() => calc.factorial(-1), throwsArgumentError);
    });
  });

  // ─── Tests del ValidadorPassword ────────────────────────────────────────────
  group('ValidadorPassword', () {
    late ValidadorPassword validador;

    setUp(() => validador = ValidadorPassword());

    test('contraseña válida retorna true', () {
      expect(validador.esValido('Segura123'), isTrue);
    });

    test('contraseña muy corta retorna false', () {
      expect(validador.esValido('Ab1'), isFalse);
    });

    test('sin mayúscula retorna false', () {
      expect(validador.esValido('sinmayus1'), isFalse);
    });

    test('sin número retorna false', () {
      expect(validador.esValido('SinNumero'), isFalse);
    });

    test('mensajeError retorna null para contraseña válida', () {
      expect(validador.mensajeError('Segura123'), isNull);
    });

    test('mensajeError retorna mensaje para contraseña corta', () {
      final mensaje = validador.mensajeError('Ab1');
      expect(mensaje, isNotNull);
      expect(mensaje, contains('8')); // Debe mencionar el límite
    });

    group('casos límite', () {
      test('exactamente 8 caracteres con mayúscula y número', () {
        expect(validador.esValido('Abcdef1g'.substring(0, 8)), isTrue);
      });
    });
  });

  // ─── Tests del Carrito ───────────────────────────────────────────────────────
  group('Carrito', () {
    late Carrito carrito;

    setUp(() => carrito = Carrito());

    test('carrito nuevo está vacío', () {
      expect(carrito.estaVacio, isTrue);
      expect(carrito.totalItems, equals(0));
    });

    test('agregar producto aumenta total', () {
      carrito.agregar('Leche');
      expect(carrito.totalItems, equals(1));
      expect(carrito.contiene('Leche'), isTrue);
    });

    test('agregar con cantidad personalizada', () {
      carrito.agregar('Pan', cantidad: 3);
      expect(carrito.totalItems, equals(3));
      expect(carrito.items['Pan'], equals(3));
    });

    test('agregar el mismo producto suma cantidades', () {
      carrito.agregar('Leche');
      carrito.agregar('Leche');
      expect(carrito.items['Leche'], equals(2));
    });

    test('eliminar producto', () {
      carrito.agregar('Leche');
      carrito.eliminar('Leche');
      expect(carrito.estaVacio, isTrue);
    });

    test('vaciar carrito', () {
      carrito.agregar('Leche');
      carrito.agregar('Pan');
      carrito.vaciar();
      expect(carrito.estaVacio, isTrue);
    });

    test('agregar cantidad negativa lanza ArgumentError', () {
      expect(() => carrito.agregar('Leche', cantidad: -1), throwsArgumentError);
    });

    test('items retorna copia inmutable', () {
      carrito.agregar('Leche');
      final items = carrito.items;
      // Verificar que no se puede modificar el mapa retornado
      expect(() => items['Nuevo'] = 1, throwsA(anything));
    });
  });

  // ─── Tests asíncronos ────────────────────────────────────────────────────────
  group('Tests asíncronos', () {
    test('Future que retorna valor', () async {
      // Los tests pueden ser async/await
      final resultado = await Future.delayed(
        const Duration(milliseconds: 10),
        () => 42,
      );
      expect(resultado, equals(42));
    });

    test('Future que lanza excepción', () async {
      expect(
        () async {
          await Future.delayed(const Duration(milliseconds: 10));
          throw Exception('Error esperado');
        },
        throwsException,
      );
    });
  });
}

// =============================================================================
// NOTA SOBRE MOCKITO
// =============================================================================
// Para usar mockito, primero definir las clases a mockear:
//
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// @GenerateMocks([ProductoRepository])
// void main() { ... }
//
// Luego generar los mocks: dart run build_runner build
//
// Uso en tests:
// final mockRepo = MockProductoRepository();
// when(mockRepo.obtenerProductos()).thenAnswer((_) async => ['test']);
// verify(mockRepo.obtenerProductos()).called(1);
