// =============================================================================
// ARCHIVO: 03_herencia.dart
// TEMA: Herencia en Dart: extends, super, abstract, override
// =============================================================================
//
// La herencia permite que una clase (hija) reutilice el código de otra (padre)
// y lo extienda o modifique. En Dart se usa 'extends'. Las clases abstractas
// definen contratos sin implementación. 'is' y 'as' permiten verificar tipos.
//
// CÓMO EJECUTAR:
//   dart run 03_herencia.dart
//
// =============================================================================

// ────────────────────────────────────────────────────────────────────────────
// 1. CLASE ABSTRACTA: define la estructura sin implementar todo
// ────────────────────────────────────────────────────────────────────────────

/// Clase base abstracta para todas las figuras geométricas.
///
/// Define la interfaz común: toda figura debe poder calcular su área
/// y perímetro. No puede instanciarse directamente — solo sus hijos.
abstract class Figura {
  // Color de la figura
  final String color;

  /// Crea una figura con el [color] dado.
  const Figura(this.color);

  /// Calcula el área de la figura. Cada subclase implementa su fórmula.
  double get area;

  /// Calcula el perímetro de la figura. Cada subclase implementa su fórmula.
  double get perimetro;

  /// Descripción general — método concreto en la clase abstracta.
  /// Las subclases lo heredan sin necesidad de sobreescribir.
  String describir() {
    return '${runtimeType} $color — Área: ${area.toStringAsFixed(2)}, '
        'Perímetro: ${perimetro.toStringAsFixed(2)}';
  }

  @override
  String toString() => describir();
}

// ────────────────────────────────────────────────────────────────────────────
// 2. CLASES HIJAS: extends + @override
// ────────────────────────────────────────────────────────────────────────────

/// Círculo que hereda de Figura e implementa área y perímetro.
class Circulo extends Figura {
  // Radio del círculo
  final double radio;

  /// Crea un círculo con [radio] y [color].
  /// super(color) llama al constructor del padre.
  const Circulo(this.radio, String color) : super(color);

  /// Área = π * r²
  @override
  double get area => 3.14159 * radio * radio;

  /// Perímetro (circunferencia) = 2 * π * r
  @override
  double get perimetro => 2 * 3.14159 * radio;
}

/// Rectángulo que hereda de Figura.
class Rectangulo extends Figura {
  // Ancho del rectángulo
  final double ancho;
  // Alto del rectángulo
  final double alto;

  /// Crea un rectángulo con [ancho], [alto] y [color].
  const Rectangulo(this.ancho, this.alto, String color) : super(color);

  /// Área = ancho × alto
  @override
  double get area => ancho * alto;

  /// Perímetro = 2 × (ancho + alto)
  @override
  double get perimetro => 2 * (ancho + alto);
}

/// Triángulo equilátero que hereda de Figura.
class TrianguloEquilatero extends Figura {
  // Longitud del lado
  final double lado;

  /// Crea un triángulo equilátero con el [lado] dado.
  const TrianguloEquilatero(this.lado, String color) : super(color);

  /// Área = (√3 / 4) × lado²
  @override
  double get area => (1.732 / 4) * lado * lado;

  /// Perímetro = 3 × lado
  @override
  double get perimetro => 3 * lado;
}

// ────────────────────────────────────────────────────────────────────────────
// 3. SOBREESCRIBIR MÉTODO CONCRETO
// ────────────────────────────────────────────────────────────────────────────

/// Cuadrado que extiende Rectángulo y sobreescribe describir().
///
/// Demuestra que se puede sobreescribir métodos concretos heredados.
class Cuadrado extends Rectangulo {
  /// Crea un cuadrado con [lado] de longitud igual en ambas dimensiones.
  const Cuadrado(double lado, String color) : super(lado, lado, color);

  /// Sobreescribe describir para mencionar que es un cuadrado.
  @override
  String describir() {
    return 'Cuadrado $color (lado: $ancho) — Área: ${area.toStringAsFixed(2)}';
  }
}

// ────────────────────────────────────────────────────────────────────────────
// 4. is y as: type checking y casting
// ────────────────────────────────────────────────────────────────────────────

/// Procesa una figura sin saber de antemano su tipo exacto.
///
/// Usa 'is' para verificar el tipo y acceder a propiedades específicas
/// de la subclase de forma segura (smart cast / type promotion).
void procesarFigura(Figura figura) {
  print('Procesando: ${figura.runtimeType}');

  // 'is' verifica si el objeto es de ese tipo (también funciona con herencia)
  if (figura is Circulo) {
    // Dentro del if, 'figura' es promovida a Circulo — acceso a .radio
    print('  Es un círculo de radio ${figura.radio}');
  } else if (figura is Rectangulo) {
    print('  Es un rectángulo de ${figura.ancho} × ${figura.alto}');
  }

  // 'is!' verifica que NO sea de ese tipo
  if (figura is! Cuadrado) {
    print('  No es un cuadrado.');
  }
}

/// Demuestra el casting explícito con 'as'.
void demoCasting() {
  print('\n── Casting con as ──');

  Figura figura = Circulo(5.0, 'rojo');

  // as convierte el tipo — lanza CastError si el tipo es incorrecto
  Circulo circulo = figura as Circulo; // Seguro porque sabemos que es Circulo
  print('Radio del círculo: ${circulo.radio}');

  // Casting inseguro — usar solo cuando se está seguro del tipo
  try {
    Rectangulo rect = figura as Rectangulo; // Lanza error: no es Rectangulo
    print(rect);
  } catch (e) {
    print('Error de casting: $e');
  }
}

void main() {
  // ── Instancias y polimorfismo ──
  print('── Figuras: herencia y polimorfismo ──');

  List<Figura> figuras = [
    Circulo(5.0, 'rojo'),
    Rectangulo(4.0, 6.0, 'azul'),
    TrianguloEquilatero(3.0, 'verde'),
    Cuadrado(4.0, 'amarillo'),
  ];

  for (Figura f in figuras) {
    print(f); // Llama a describir() polimórficamente
  }

  // ── is para verificación de tipo ──
  print('\n── Verificación de tipos con is ──');
  for (Figura f in figuras) {
    procesarFigura(f);
  }

  // ── Casting ──
  demoCasting();

  // ── Cuadrado hereda de Rectangulo, que hereda de Figura ──
  print('\n── Jerarquía de herencia ──');
  Cuadrado c = Cuadrado(5.0, 'morado');
  print('¿Es Cuadrado? ${c is Cuadrado}');       // true
  print('¿Es Rectangulo? ${c is Rectangulo}');   // true (herencia)
  print('¿Es Figura? ${c is Figura}');           // true (herencia)
  print('¿Es Circulo? ${c is Circulo}');         // false
}

// EXPERIMENTA:
//   - Crea una clase Elipse que extienda Figura con dos radios (a y b)
//   - Sobreescribe hashCode y == en Figura para comparar por área
//   - Agrega un método estático en Figura que compare dos figuras por área
//   - Prueba crear una instancia de Figura directamente — ¿qué error obtienes?
