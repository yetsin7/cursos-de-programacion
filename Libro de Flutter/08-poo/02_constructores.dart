// =============================================================================
// ARCHIVO: 02_constructores.dart
// TEMA: Tipos de constructores en Dart
// =============================================================================
//
// Dart ofrece varios tipos de constructores, cada uno diseñado para un caso
// de uso específico. Conocerlos permite diseñar APIs de clases más expresivas,
// seguras y ergonómicas — fundamentales en Flutter (ThemeData, EdgeInsets, etc.)
//
// CÓMO EJECUTAR:
//   dart run 02_constructores.dart
//
// =============================================================================

// ────────────────────────────────────────────────────────────────────────────
// 1. CONSTRUCTOR POR DEFECTO Y PARÁMETROS DEL CONSTRUCTOR
// ────────────────────────────────────────────────────────────────────────────

/// Modelo de un punto en 2D con distintas formas de construcción.
class Punto {
  // Coordenada X
  final double x;
  // Coordenada Y
  final double y;

  /// Constructor principal con parámetros posicionales.
  /// La sintaxis this.x asigna directamente a las propiedades.
  Punto(this.x, this.y);

  /// Constructor nombrado: crea el punto en el origen (0, 0).
  Punto.origen() : x = 0, y = 0;

  /// Constructor nombrado: crea un punto solo en el eje X.
  Punto.enEjeX(double x) : x = x, y = 0;

  /// Constructor nombrado: crea un punto desde un Map.
  Punto.desdeMapa(Map<String, double> mapa)
      : x = mapa['x'] ?? 0,
        y = mapa['y'] ?? 0;

  /// Distancia al origen desde este punto.
  double get distanciaAlOrigen {
    // Usamos la fórmula de distancia euclídea
    return (x * x + y * y);
  }

  @override
  String toString() => 'Punto($x, $y)';
}

// ────────────────────────────────────────────────────────────────────────────
// 2. INITIALIZER LIST (:)
// ────────────────────────────────────────────────────────────────────────────

/// Representa una persona con validación en el constructor.
///
/// La initializer list (:) se ejecuta ANTES del cuerpo del constructor,
/// útil para validaciones y asignaciones de campos final.
class Persona {
  // Nombre normalizado (siempre Title Case)
  final String nombre;
  // Edad válida (mayor de 0)
  final int edad;

  /// Crea una Persona validando que la edad sea positiva.
  /// La normalización del nombre ocurre en la initializer list.
  Persona(String nombre, int edad)
      : nombre = _normalizarNombre(nombre),  // Se ejecuta antes del cuerpo
        edad = edad,
        assert(edad > 0, 'La edad debe ser positiva') {
    // Cuerpo del constructor — se ejecuta después de la initializer list
    print('Persona creada: $nombre, $edad años');
  }

  /// Normaliza el [nombre] a Title Case.
  static String _normalizarNombre(String nombre) {
    if (nombre.isEmpty) return nombre;
    return nombre[0].toUpperCase() + nombre.substring(1).toLowerCase();
  }

  @override
  String toString() => '$nombre ($edad años)';
}

// ────────────────────────────────────────────────────────────────────────────
// 3. CONSTRUCTOR FACTORY
// ────────────────────────────────────────────────────────────────────────────

/// Colores predefinidos con constructor factory para instancias únicas.
///
/// factory permite retornar una instancia existente del caché
/// en lugar de siempre crear objetos nuevos (patrón Flyweight).
class Color {
  // Componente rojo (0-255)
  final int r;
  // Componente verde (0-255)
  final int g;
  // Componente azul (0-255)
  final int b;

  // Caché de colores ya creados
  static final Map<String, Color> _cache = {};

  // Constructor privado: solo se llama desde el factory
  Color._interno(this.r, this.g, this.b);

  /// Factory: retorna del caché si ya existe, o crea y cachea uno nuevo.
  factory Color(int r, int g, int b) {
    String clave = '$r,$g,$b';
    // putIfAbsent crea solo si la clave no existe
    return _cache.putIfAbsent(clave, () => Color._interno(r, g, b));
  }

  /// Colores nombrados predefinidos mediante constructores factory nombrados.
  factory Color.rojo() => Color(255, 0, 0);
  factory Color.verde() => Color(0, 255, 0);
  factory Color.azul() => Color(0, 0, 255);
  factory Color.blanco() => Color(255, 255, 255);
  factory Color.negro() => Color(0, 0, 0);

  /// Crea un Color desde un string hexadecimal '#RRGGBB'.
  factory Color.desdeHex(String hex) {
    String limpio = hex.replaceAll('#', '');
    return Color(
      int.parse(limpio.substring(0, 2), radix: 16),
      int.parse(limpio.substring(2, 4), radix: 16),
      int.parse(limpio.substring(4, 6), radix: 16),
    );
  }

  @override
  String toString() => 'Color(r:$r, g:$g, b:$b)';
}

// ────────────────────────────────────────────────────────────────────────────
// 4. CONSTRUCTOR CONST (objetos inmutables en tiempo de compilación)
// ────────────────────────────────────────────────────────────────────────────

/// Dimensiones inmutables optimizadas con const.
///
/// Un objeto const se crea en tiempo de compilación y se reutiliza
/// (dos const con los mismos valores son el MISMO objeto en memoria).
class Dimensiones {
  // Ancho en píxeles
  final double ancho;
  // Alto en píxeles
  final double alto;

  /// Constructor const: todos los campos deben ser final.
  const Dimensiones(this.ancho, this.alto);

  // Constantes predefinidas — disponibles sin instanciar
  static const Dimensiones cuadrado = Dimensiones(100, 100);
  static const Dimensiones hd = Dimensiones(1280, 720);
  static const Dimensiones fhd = Dimensiones(1920, 1080);

  /// Área total en píxeles cuadrados.
  double get area => ancho * alto;

  @override
  String toString() => '${ancho.toInt()}×${alto.toInt()} (${area.toStringAsFixed(0)} px²)';
}

// ────────────────────────────────────────────────────────────────────────────
// 5. PARÁMETROS: POSICIONALES, NOMBRADOS Y REQUIRED
// ────────────────────────────────────────────────────────────────────────────

/// Configuración de un botón con parámetros nombrados.
///
/// Los parámetros nombrados ({}) son la norma en Flutter para widgets
/// con muchas opciones. required exige que el llamador los proporcione.
class BotonConfig {
  // Texto del botón
  final String texto;
  // Color del botón
  final String color;
  // Si el botón está habilitado
  final bool habilitado;
  // Callback al presionar (puede ser null si no se proporciona)
  final void Function()? alPresionar;

  /// Crea la configuración del botón con parámetros nombrados.
  const BotonConfig({
    required this.texto,           // Obligatorio
    this.color = 'azul',          // Opcional con valor por defecto
    this.habilitado = true,       // Opcional con valor por defecto
    this.alPresionar,             // Opcional, puede ser null
  });

  @override
  String toString() => 'Botón "$texto" ($color, habilitado: $habilitado)';
}

void main() {
  // ── Constructores nombrados ──
  print('── Punto: constructores nombrados ──');
  print(Punto(3, 4));
  print(Punto.origen());
  print(Punto.enEjeX(5));
  print(Punto.desdeMapa({'x': 2.5, 'y': -1.5}));

  // ── Initializer list ──
  print('\n── Persona: initializer list ──');
  Persona p = Persona('ana', 28);
  print(p);

  // ── Factory constructor ──
  print('\n── Color: factory con caché ──');
  Color c1 = Color.rojo();
  Color c2 = Color.rojo();
  print(c1);
  print('¿Misma instancia? ${identical(c1, c2)}'); // true (caché)
  print(Color.desdeHex('#1A2B3C'));

  // ── Constructor const ──
  print('\n── Dimensiones: constructor const ──');
  const d1 = Dimensiones(1920, 1080);
  const d2 = Dimensiones(1920, 1080);
  print(d1);
  print('¿Misma instancia? ${identical(d1, d2)}'); // true (const)
  print(Dimensiones.fhd);
  print(Dimensiones.cuadrado);

  // ── Parámetros nombrados ──
  print('\n── BotonConfig: parámetros nombrados ──');
  print(BotonConfig(texto: 'Aceptar'));
  print(BotonConfig(texto: 'Cancelar', color: 'rojo', habilitado: false));
}

// EXPERIMENTA:
//   - Agrega un constructor Punto.desdeString('3.0,4.0') que parsee el string
//   - Crea un factory que retorne subclases distintas según un parámetro tipo
//   - Usa assert en el constructor de Dimensiones para que ancho y alto sean > 0
//   - Intenta hacer Color un const completo — ¿qué impide que el caché funcione?
