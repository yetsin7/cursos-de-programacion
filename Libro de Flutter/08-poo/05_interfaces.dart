// =============================================================================
// ARCHIVO: 05_interfaces.dart
// TEMA: Interfaces en Dart: implements, interface class, sealed class
// =============================================================================
//
// En Dart toda clase es automáticamente una interfaz implícita. 'implements'
// exige cumplir el contrato completo. Dart 3 añade 'interface class' y
// 'sealed class' para control más preciso sobre la herencia.
//
// CÓMO EJECUTAR:
//   dart run 05_interfaces.dart
//
// =============================================================================

// ────────────────────────────────────────────────────────────────────────────
// 1. TODA CLASE ES UNA INTERFAZ IMPLÍCITA
// ────────────────────────────────────────────────────────────────────────────

/// Contrato de repositorio para operaciones CRUD genéricas.
///
/// Cualquier clase que use 'implements Repositorio' debe implementar
/// TODOS sus métodos. No hereda la implementación — solo el contrato.
abstract interface class Repositorio<T> {
  /// Guarda un [elemento] y devuelve su ID asignado.
  Future<String> guardar(T elemento);

  /// Obtiene un elemento por [id]. Devuelve null si no existe.
  Future<T?> obtenerPorId(String id);

  /// Obtiene todos los elementos del repositorio.
  Future<List<T>> obtenerTodos();

  /// Elimina el elemento con [id]. Devuelve true si se eliminó.
  Future<bool> eliminar(String id);
}

// ────────────────────────────────────────────────────────────────────────────
// 2. extends vs implements — La diferencia fundamental
// ────────────────────────────────────────────────────────────────────────────

/// Clase base con comportamiento de logging.
class Logger {
  // Prefijo para los mensajes
  final String prefijo;

  /// Crea un logger con el [prefijo] dado.
  const Logger(this.prefijo);

  /// Registra un [mensaje] con el prefijo del logger.
  void registrar(String mensaje) {
    print('[$prefijo] $mensaje');
  }
}

/// ExtendedLogger HEREDA la implementación de Logger con extends.
/// No necesita reimplementar registrar() — lo usa directamente.
class LoggerExtendido extends Logger {
  /// Crea un logger extendido con nivel de severidad.
  LoggerExtendido() : super('EXTENDIDO');

  /// Agrega funcionalidad adicional encima de la heredada.
  void registrarError(String mensaje) {
    registrar('ERROR: $mensaje'); // Usa el método heredado
  }
}

/// LoggerFalso IMPLEMENTA la interfaz de Logger con implements.
/// Debe reimplementar TODOS los miembros públicos desde cero.
class LoggerFalso implements Logger {
  // Obligatorio implementar todos los miembros de la interfaz

  @override
  final String prefijo = 'FALSO';

  @override
  void registrar(String mensaje) {
    // Implementación diferente — descarta los mensajes
    print('[DESCARTADO]: $mensaje');
  }
}

// ────────────────────────────────────────────────────────────────────────────
// 3. interface class (Dart 3) — Clase diseñada solo para implementar
// ────────────────────────────────────────────────────────────────────────────

/// Define el contrato de un servicio de pagos.
/// 'interface class' prohíbe hacer 'extends' desde fuera de la librería —
/// solo se puede 'implements'. Garantiza que nadie hereda la implementación.
interface class ServicioPagos {
  /// Procesa un [pago] y devuelve el ID de la transacción.
  String procesarPago(double monto, String metodoPago) {
    // Implementación por defecto (en una librería real, esto sería abstracto)
    return 'TXN-${DateTime.now().millisecondsSinceEpoch}';
  }

  /// Verifica si un [metodoPago] está disponible.
  bool metodoDisponible(String metodoPago) => true;
}

/// Implementación de pagos con tarjeta que cumple el contrato de ServicioPagos.
class PagosTarjeta implements ServicioPagos {
  @override
  String procesarPago(double monto, String metodoPago) {
    print('Procesando \$${monto.toStringAsFixed(2)} con tarjeta...');
    return 'CARD-${monto.toInt()}-OK';
  }

  @override
  bool metodoDisponible(String metodoPago) =>
      ['visa', 'mastercard', 'amex'].contains(metodoPago.toLowerCase());
}

/// Implementación de pagos digitales.
class PagosDigitales implements ServicioPagos {
  @override
  String procesarPago(double monto, String metodoPago) {
    print('Procesando \$${monto.toStringAsFixed(2)} via $metodoPago...');
    return 'DIGI-${monto.toInt()}-OK';
  }

  @override
  bool metodoDisponible(String metodoPago) =>
      ['paypal', 'stripe', 'mercadopago'].contains(metodoPago.toLowerCase());
}

// ────────────────────────────────────────────────────────────────────────────
// 4. sealed class (Dart 3) — Para pattern matching exhaustivo
// ────────────────────────────────────────────────────────────────────────────

/// Resultado de una operación de negocio.
///
/// 'sealed' garantiza que todas las subclases estén en este archivo.
/// Esto permite al compilador verificar que un switch es exhaustivo.
sealed class ResultadoOperacion {
  // Constructor constante para permitir instancias const en las subclases
  const ResultadoOperacion();
}

/// Indica que la operación fue exitosa, con los datos resultantes.
class Exito extends ResultadoOperacion {
  // Datos del resultado exitoso
  final dynamic datos;
  /// Crea un resultado exitoso con los [datos] provistos.
  const Exito(this.datos);
}

/// Indica que la operación falló, con el mensaje de error.
class Falla extends ResultadoOperacion {
  // Descripción del error
  final String mensaje;
  // Código de error opcional
  final int? codigo;
  /// Crea una falla con el [mensaje] de error y [codigo] opcional.
  const Falla(this.mensaje, {this.codigo});
}

/// Indica que la operación está en progreso.
class EnProceso extends ResultadoOperacion {
  // Porcentaje de progreso (0.0 a 1.0)
  final double progreso;
  /// Crea un estado de progreso con el porcentaje dado.
  const EnProceso(this.progreso);
}

/// Procesa un resultado usando switch exhaustivo — el compilador verifica
/// que todos los casos de la sealed class estén cubiertos.
String procesarResultado(ResultadoOperacion resultado) {
  // El compilador garantiza que este switch cubre TODOS los casos
  return switch (resultado) {
    Exito(datos: var d) => 'Éxito: $d',
    Falla(mensaje: var m, codigo: var c) =>
        'Error${c != null ? " $c" : ""}: $m',
    EnProceso(progreso: var p) =>
        'Progreso: ${(p * 100).toStringAsFixed(0)}%',
  };
}

void main() {
  // ── extends vs implements ──
  print('── extends vs implements ──');
  LoggerExtendido le = LoggerExtendido();
  le.registrar('Mensaje normal');
  le.registrarError('Algo falló');

  LoggerFalso lf = LoggerFalso();
  lf.registrar('Este mensaje se descarta');

  // ── interface class ──
  print('\n── interface class: ServicioPagos ──');
  List<ServicioPagos> servicios = [PagosTarjeta(), PagosDigitales()];
  for (ServicioPagos s in servicios) {
    String txn = s.procesarPago(99.99, 'visa');
    print('  Transacción: $txn');
    print('  ¿visa disponible? ${s.metodoDisponible('visa')}');
  }

  // ── sealed class + switch exhaustivo ──
  print('\n── sealed class: ResultadoOperacion ──');
  List<ResultadoOperacion> resultados = [
    Exito({'id': 42, 'nombre': 'Ana'}),
    Falla('Conexión rechazada', codigo: 503),
    EnProceso(0.75),
  ];

  for (ResultadoOperacion r in resultados) {
    print(procesarResultado(r));
  }
}

// EXPERIMENTA:
//   - Crea una sealed class 'Estado' con Cargando, Cargado y Error para un widget
//   - Implementa Repositorio<String> con almacenamiento en memoria (Map)
//   - Prueba implementar múltiples interfaces: class X implements A, B, C {}
//   - Compara: ¿qué error obtienes con 'extends ServicioPagos' vs 'implements'?
