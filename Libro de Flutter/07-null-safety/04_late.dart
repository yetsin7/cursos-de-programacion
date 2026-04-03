// =============================================================================
// ARCHIVO: 04_late.dart
// TEMA: La keyword 'late' en Dart
// =============================================================================
//
// 'late' es una promesa al compilador: "esta variable no es null, pero la
// inicializaré después de la declaración". Es fundamental en Flutter para
// campos que dependen de initState(), inyección de dependencias o providers.
// Usada incorrectamente, genera errores en runtime difíciles de depurar.
//
// CÓMO EJECUTAR:
//   dart run 04_late.dart
//
// =============================================================================

// ────────────────────────────────────────────────────────────────────────────
// 1. ¿Qué problema resuelve 'late'?
// ────────────────────────────────────────────────────────────────────────────

/// Clase que necesita inicializar _conexion después de la construcción.
/// Sin 'late', se vería forzada a usar String? aunque nunca sea null en uso.
class ServicioBaseDatos {
  // Sin late: necesitaríamos String? y manejar null en cada uso
  // String? _conexion;

  // Con late: declaramos que es non-nullable pero se inicializa después
  late String _conexion;

  /// Inicializa la conexión a la base de datos (simula trabajo asíncrono).
  void conectar(String servidor) {
    // Aquí podría haber lógica de conexión real
    _conexion = 'jdbc://$servidor:5432/midb';
    print('Conectado a: $_conexion');
  }

  /// Ejecuta una consulta usando la conexión ya inicializada.
  void consultar(String sql) {
    // Si _conexion no fue inicializada antes de esta llamada,
    // Dart lanzará: LateInitializationError: Field '_conexion' has not been initialized
    print('[$_conexion] Ejecutando: $sql');
  }
}

/// Demuestra el uso básico de late.
void demoLateBasico() {
  print('── late básico ──');

  ServicioBaseDatos servicio = ServicioBaseDatos();
  servicio.conectar('db.servidor.com');
  servicio.consultar('SELECT * FROM usuarios');
}

// ────────────────────────────────────────────────────────────────────────────
// 2. late con inicialización diferida (lazy initialization)
// ────────────────────────────────────────────────────────────────────────────

/// Clase que usa late para computación costosa bajo demanda.
/// El valor solo se calcula la primera vez que se accede — no antes.
class AnalizadorTexto {
  // Texto original para analizar
  final String texto;

  /// Lista de palabras: se calcula solo cuando se accede por primera vez.
  /// Dart garantiza que el inicializador se ejecuta exactamente una vez.
  late final List<String> palabras = texto
      .toLowerCase()
      .split(RegExp(r'\s+'))
      .where((p) => p.isNotEmpty)
      .toList();

  /// Frecuencia de cada palabra: también computada bajo demanda.
  late final Map<String, int> frecuencias = _calcularFrecuencias();

  /// Crea un analizador para el [texto] dado.
  AnalizadorTexto(this.texto);

  /// Calcula la frecuencia de cada palabra en el texto.
  Map<String, int> _calcularFrecuencias() {
    Map<String, int> mapa = {};
    for (String palabra in palabras) {
      mapa[palabra] = (mapa[palabra] ?? 0) + 1;
    }
    return mapa;
  }
}

/// Demuestra la inicialización perezosa con late.
void demoLateLazy() {
  print('\n── late con lazy initialization ──');

  String texto = 'el gato y el perro y el gato';
  AnalizadorTexto analizador = AnalizadorTexto(texto);

  // Primer acceso a 'palabras': se calcula ahora
  print('Total palabras: ${analizador.palabras.length}');
  print('Palabras: ${analizador.palabras}');

  // Primer acceso a 'frecuencias': se calcula ahora
  print('Frecuencias: ${analizador.frecuencias}');

  // Accesos posteriores: valor ya calculado, no se recalcula
  print('Palabra más frecuente: ${_masFrecuente(analizador.frecuencias)}');
}

/// Encuentra la palabra con mayor frecuencia en [frecuencias].
String _masFrecuente(Map<String, int> frecuencias) {
  return frecuencias.entries
      .reduce((a, b) => a.value >= b.value ? a : b)
      .key;
}

// ────────────────────────────────────────────────────────────────────────────
// 3. late final — Inmutable y diferida
// ────────────────────────────────────────────────────────────────────────────

/// Clase que combina late y final para un valor que se asigna una sola vez.
/// Útil para IDs generados, timestamps de creación, configuraciones de setup.
class Sesion {
  // ID de sesión: se genera al iniciar, nunca cambia
  late final String id;
  // Timestamp de creación: se registra al iniciar
  late final DateTime creadaEn;
  // Nombre del usuario: inmutable una vez establecido
  late final String usuario;

  /// Crea una sesión sin inicializar aún.
  Sesion();

  /// Inicia la sesión para el [nombreUsuario] dado.
  ///
  /// Solo puede llamarse una vez. Una segunda llamada lanzaría:
  /// LateInitializationError: Field 'id' has already been initialized.
  void iniciar(String nombreUsuario) {
    id = 'SES-${DateTime.now().millisecondsSinceEpoch}';
    creadaEn = DateTime.now();
    usuario = nombreUsuario;
    print('Sesión iniciada: $id para $usuario');
  }
}

/// Demuestra late final para valores inmutables de asignación diferida.
void demoLateFinal() {
  print('\n── late final ──');

  Sesion sesion = Sesion();
  sesion.iniciar('carlos@ejemplo.com');

  print('ID: ${sesion.id}');
  print('Usuario: ${sesion.usuario}');
  print('Creada: ${sesion.creadaEn}');

  // Intentar reasignar un late final lanza error:
  try {
    // sesion.id = 'otro-id'; // Error de compilación: id es final
    print('late final no permite reasignación (error de compilación)');
  } catch (e) {
    print('Error: $e');
  }
}

// ────────────────────────────────────────────────────────────────────────────
// 4. Error de acceso sin inicializar
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra qué ocurre si se accede a un late sin inicializar.
void demoErrorLate() {
  print('\n── Error: late sin inicializar ──');

  ServicioBaseDatos servicio = ServicioBaseDatos();

  // Acceder a _conexion sin llamar conectar() primero lanza LateInitializationError
  try {
    servicio.consultar('SELECT 1'); // _conexion no está inicializado
  } catch (e) {
    print('Error capturado: $e');
    print('Causa: se accedió a un late field antes de inicializarlo.');
  }
}

// ────────────────────────────────────────────────────────────────────────────
// 5. Patrón Flutter: late en StatefulWidget
// ────────────────────────────────────────────────────────────────────────────

/// Simula el patrón de uso de late en un StatefulWidget de Flutter.
/// En Flutter, los controllers y animations se inicializan en initState().
class SimuladorWidget {
  // En Flutter sería: late AnimationController _controller;
  late String _controllerSimulado;
  late List<String> _datos;

  /// Equivale a initState() en Flutter — se llama una vez al crear el widget.
  void initState() {
    // Se inicializan los late fields
    _controllerSimulado = 'AnimationController(duration: 300ms)';
    _datos = ['item1', 'item2', 'item3'];
    print('initState: controller y datos inicializados');
  }

  /// Equivale al método build() de Flutter.
  void build() {
    print('build: usando $_controllerSimulado');
    print('build: datos = $_datos');
  }

  /// Equivale a dispose() en Flutter — limpia recursos.
  void dispose() {
    print('dispose: liberando recursos de $_controllerSimulado');
  }
}

/// Demuestra el ciclo de vida típico con late en Flutter.
void demoPatronFlutter() {
  print('\n── Patrón Flutter: late en initState ──');

  SimuladorWidget widget = SimuladorWidget();
  widget.initState(); // Inicializa los late fields
  widget.build();     // Usa los late fields de forma segura
  widget.dispose();   // Libera recursos
}

void main() {
  demoLateBasico();
  demoLateLazy();
  demoLateFinal();
  demoErrorLate();
  demoPatronFlutter();

  print('\n── Reglas de uso de late ──');
  print('✓ Usa late cuando el valor se asigna antes del primer uso garantizado.');
  print('✓ Usa late final para valores que se asignan una sola vez.');
  print('✓ Usa late para lazy initialization costosa.');
  print('✗ Evita late si puedes inicializar en la declaración o constructor.');
  print('✗ Nunca accedas a un late field sin antes inicializarlo.');
}

// EXPERIMENTA:
//   - Crea una clase con late y accede a ella antes de initState — observa el error
//   - Usa late final para un valor que se calcula con una función costosa (fib(40))
//   - Compara late con String? en cuántas verificaciones null necesitas hacer
//   - Prueba late con una lista: late List<int> numeros = generarNumeros();
