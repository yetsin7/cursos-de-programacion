// =============================================================================
// ARCHIVO: 04_mixins.dart
// TEMA: Mixins en Dart
// =============================================================================
//
// Un mixin es un conjunto de métodos y propiedades que puede "mezclarse"
// en múltiples clases sin herencia directa. Resuelven el problema de la
// herencia múltiple de forma controlada y sin ambigüedad del diamante.
// En Flutter se usan ampliamente: TickerProviderStateMixin, etc.
//
// CÓMO EJECUTAR:
//   dart run 04_mixins.dart
//
// =============================================================================

// ────────────────────────────────────────────────────────────────────────────
// 1. MIXIN BÁSICO
// ────────────────────────────────────────────────────────────────────────────

/// Mixin que añade capacidad de logging a cualquier clase.
///
/// Cualquier clase que use 'with Loggable' obtiene estos métodos sin herencia.
mixin Loggable {
  /// Lista de mensajes de log registrados.
  final List<String> _logs = [];

  /// Registra un [mensaje] con timestamp.
  void log(String mensaje) {
    String entrada = '[${DateTime.now().toIso8601String()}] $mensaje';
    _logs.add(entrada);
    print('LOG: $mensaje');
  }

  /// Imprime todos los mensajes de log registrados.
  void mostrarLogs() {
    print('--- Logs (${_logs.length} entradas) ---');
    for (String l in _logs) {
      print('  $l');
    }
  }
}

/// Mixin que añade capacidad de serialización a un objeto.
///
/// La clase que lo use debe implementar toMap() para definir sus datos.
mixin Serializable {
  /// Convierte el objeto a un Map<String, dynamic> para serialización.
  /// La clase que usa este mixin debe implementar este método.
  Map<String, dynamic> toMap();

  /// Convierte el objeto a una representación JSON-like.
  String toJson() {
    Map<String, dynamic> mapa = toMap();
    StringBuffer sb = StringBuffer('{');
    mapa.forEach((clave, valor) {
      sb.write('"$clave": ${valor is String ? '"$valor"' : valor}, ');
    });
    String resultado = sb.toString();
    if (resultado.length > 1) {
      resultado = resultado.substring(0, resultado.length - 2);
    }
    return '$resultado}';
  }
}

/// Mixin que añade soporte de validación de datos.
mixin Validable {
  // Mapa de errores por campo: clave = nombre del campo, valor = error
  final Map<String, String> _errores = {};

  /// Agrega un [error] para el [campo] dado.
  void agregarError(String campo, String error) {
    _errores[campo] = error;
  }

  /// Elimina el error del [campo] dado.
  void limpiarError(String campo) {
    _errores.remove(campo);
  }

  /// Verifica si hay errores activos.
  bool get esValido => _errores.isEmpty;

  /// Devuelve todos los errores como lista de strings.
  List<String> get errores => _errores.entries
      .map((e) => '${e.key}: ${e.value}')
      .toList();
}

// ────────────────────────────────────────────────────────────────────────────
// 2. CLASES QUE USAN MÚLTIPLES MIXINS
// ────────────────────────────────────────────────────────────────────────────

/// Producto que combina logging, serialización y validación con mixins.
///
/// Hereda de Object (implícito) y usa tres mixins con 'with'.
class Producto with Loggable, Serializable, Validable {
  // Nombre del producto
  String nombre;
  // Precio del producto
  double precio;
  // Stock disponible
  int stock;

  /// Crea un producto con nombre, precio y stock.
  Producto(this.nombre, this.precio, this.stock);

  /// Valida los campos del producto y registra los resultados.
  void validar() {
    limpiarError('nombre');
    limpiarError('precio');
    limpiarError('stock');

    if (nombre.isEmpty) agregarError('nombre', 'No puede estar vacío');
    if (precio <= 0) agregarError('precio', 'Debe ser mayor a 0');
    if (stock < 0) agregarError('stock', 'No puede ser negativo');

    log(esValido ? 'Validación exitosa' : 'Validación fallida: $errores');
  }

  /// Implementación requerida por el mixin Serializable.
  @override
  Map<String, dynamic> toMap() => {
    'nombre': nombre,
    'precio': precio,
    'stock': stock,
  };

  @override
  String toString() => 'Producto($nombre, \$$precio, stock: $stock)';
}

// ────────────────────────────────────────────────────────────────────────────
// 3. MIXIN CON 'on' — Restricción de uso
// ────────────────────────────────────────────────────────────────────────────

/// Clase base abstracta para animaciones.
abstract class Animable {
  /// Inicia la animación.
  void animar();
  /// Detiene la animación.
  void detener();
}

/// Mixin que añade efectos de rebote — SOLO puede usarse en clases Animable.
///
/// La restricción 'on Animable' garantiza que el mixin tiene acceso
/// a los métodos de Animable en tiempo de compilación.
mixin EfectoRebote on Animable {
  // Número de rebotes del efecto
  int _rebotes = 0;

  /// Inicia el efecto de rebote llamando también a animar() del padre.
  void rebotar(int veces) {
    _rebotes = veces;
    animar(); // Podemos llamar métodos de Animable gracias a 'on'
    print('Efecto rebote: $veces veces');
  }

  /// Devuelve cuántos rebotes se ejecutaron.
  int get totalRebotes => _rebotes;
}

/// Widget animado que combina la clase base con el mixin restringido.
class WidgetAnimado extends Animable with EfectoRebote {
  // Nombre del widget
  final String nombre;

  /// Crea un widget animado con el [nombre] dado.
  WidgetAnimado(this.nombre);

  @override
  void animar() => print('$nombre: animando...');

  @override
  void detener() => print('$nombre: detenido.');
}

// ────────────────────────────────────────────────────────────────────────────
// 4. DIFERENCIA: mixin vs class vs abstract class
// ────────────────────────────────────────────────────────────────────────────

// abstract class Volador {}   → Define contrato SIN implementación
// class Ave extends Volador {}→ Hereda e implementa — solo UN padre
// mixin Volador {}            → Añade comportamiento a CUALQUIER clase

/// Mixin de ejemplo: comportamiento de natación reutilizable.
mixin Nadador {
  /// Permite que el objeto nade.
  void nadar() => print('${runtimeType} está nadando.');
}

/// Mixin de ejemplo: comportamiento de vuelo reutilizable.
mixin Volador {
  /// Permite que el objeto vuele.
  void volar() => print('${runtimeType} está volando.');
}

/// Animal base con comportamiento básico.
class Animal {
  // Nombre del animal
  final String nombre;
  /// Crea un animal con el [nombre] dado.
  const Animal(this.nombre);
  /// El animal emite un sonido.
  void hacerSonido() => print('$nombre hace un sonido.');
}

/// Pato: animal que nada Y vuela (herencia múltiple de comportamiento).
/// Dart lo resuelve elegantemente con mixins sin ambigüedad.
class Pato extends Animal with Nadador, Volador {
  /// Crea un pato.
  const Pato() : super('Pato');

  @override
  void hacerSonido() => print('Pato: ¡Cuac!');
}

/// Pez: animal que solo nada.
class Pez extends Animal with Nadador {
  /// Crea un pez con el [nombre] dado.
  const Pez(String nombre) : super(nombre);
}

void main() {
  // ── Mixins múltiples ──
  print('── Producto con Loggable + Serializable + Validable ──');
  Producto laptop = Producto('Laptop Pro', 1299.99, 5);
  laptop.validar();
  print(laptop.toJson());

  print('\n── Validación con errores ──');
  Producto invalido = Producto('', -100.0, -1);
  invalido.validar();
  print('¿Válido? ${invalido.esValido}');
  print('Errores: ${invalido.errores}');

  // ── Mixin con on ──
  print('\n── EfectoRebote con restricción on Animable ──');
  WidgetAnimado boton = WidgetAnimado('BotónPrimario');
  boton.rebotar(3);
  boton.detener();

  // ── Herencia múltiple de comportamiento ──
  print('\n── Mixins Nadador y Volador ──');
  Pato pato = Pato();
  pato.hacerSonido();
  pato.nadar();
  pato.volar();

  Pez salmon = Pez('Salmón');
  salmon.nadar();
  // salmon.volar(); // Error: Pez no tiene el mixin Volador
}

// EXPERIMENTA:
//   - Crea un mixin Comparable con métodos menorQue() y mayorQue()
//   - Prueba usar EfectoRebote en una clase que NO extienda Animable — ¿qué error?