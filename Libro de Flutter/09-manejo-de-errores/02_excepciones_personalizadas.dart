// =============================================================================
// ARCHIVO: 02_excepciones_personalizadas.dart
// TEMA: Excepciones personalizadas y el Result pattern
// =============================================================================
//
// Las excepciones personalizadas hacen el código más expresivo: en lugar de
// capturar 'Exception' genérico, puedes atrapar 'UsuarioNoEncontradoException'
// y saber exactamente qué falló. El Result pattern es una alternativa funcional
// que hace los errores parte del tipo de retorno.
//
// CÓMO EJECUTAR:
//   dart run 02_excepciones_personalizadas.dart
//
// =============================================================================

// ────────────────────────────────────────────────────────────────────────────
// 1. EXCEPCIONES PERSONALIZADAS: implements Exception
// ────────────────────────────────────────────────────────────────────────────

/// Excepción base del dominio. Todas las excepciones de negocio la extienden.
class AppException implements Exception {
  final String mensaje;
  final String? codigo;
  const AppException(this.mensaje, {this.codigo});
  @override
  String toString() =>
      codigo != null ? 'AppException[$codigo]: $mensaje' : 'AppException: $mensaje';
}

/// Se lanza cuando no se encuentra un recurso por su ID (equivale a HTTP 404).
class RecursoNoEncontradoException extends AppException {
  final String tipoRecurso;
  final String id;
  RecursoNoEncontradoException(this.tipoRecurso, this.id)
      : super('$tipoRecurso con ID "$id" no encontrado', codigo: 'NOT_FOUND');
}

/// Se lanza cuando los datos de un campo no cumplen las reglas de negocio.
class ValidacionException extends AppException {
  final String campo;
  ValidacionException(this.campo, String mensaje)
      : super(mensaje, codigo: 'VALIDATION_ERROR');
  @override
  String toString() => 'ValidacionException[$campo]: $mensaje';
}

/// Se lanza cuando el usuario no tiene permisos para una operación.
class PermisosDenegadosException extends AppException {
  final String operacion;
  PermisosDenegadosException(this.operacion)
      : super('Permisos insuficientes para: $operacion', codigo: 'FORBIDDEN');
}

// ────────────────────────────────────────────────────────────────────────────
// 2. USO DE EXCEPCIONES PERSONALIZADAS EN UN SERVICIO
// ────────────────────────────────────────────────────────────────────────────

/// Modelo simple de usuario para el ejemplo.
class Usuario {
  // ID único del usuario
  final String id;
  // Nombre del usuario
  final String nombre;
  // Rol del usuario en el sistema
  final String rol;

  /// Crea un usuario con id, nombre y rol.
  const Usuario(this.id, this.nombre, this.rol);

  @override
  String toString() => 'Usuario($id: $nombre, rol: $rol)';
}

/// Servicio de usuarios con validación y excepciones descriptivas.
class ServicioUsuarios {
  // Base de datos simulada en memoria
  final Map<String, Usuario> _db = {
    'USR-1': Usuario('USR-1', 'Ana García', 'admin'),
    'USR-2': Usuario('USR-2', 'Bob Martínez', 'usuario'),
  };

  // Usuario actualmente autenticado (simula sesión)
  String? _usuarioActualId;

  /// Autentica al usuario con el [id] dado.
  void autenticar(String id) {
    if (!_db.containsKey(id)) {
      throw RecursoNoEncontradoException('Usuario', id);
    }
    _usuarioActualId = id;
    print('Autenticado: ${_db[id]}');
  }

  /// Obtiene un usuario por [id]. Lanza si no existe.
  Usuario obtener(String id) {
    Usuario? usuario = _db[id];
    if (usuario == null) {
      throw RecursoNoEncontradoException('Usuario', id);
    }
    return usuario;
  }

  /// Elimina un usuario. Solo el admin puede hacerlo.
  void eliminar(String id) {
    // Verificar permisos
    Usuario? actual = _usuarioActualId != null ? _db[_usuarioActualId] : null;
    if (actual == null || actual.rol != 'admin') {
      throw PermisosDenegadosException('eliminar usuario');
    }

    // Verificar que el usuario a eliminar existe
    if (!_db.containsKey(id)) {
      throw RecursoNoEncontradoException('Usuario', id);
    }

    _db.remove(id);
    print('Usuario $id eliminado.');
  }

  /// Crea un nuevo usuario validando nombre y rol.
  Usuario crear(String nombre, String rol) {
    if (nombre.trim().isEmpty) {
      throw ValidacionException('nombre', 'El nombre no puede estar vacío.');
    }
    if (!['admin', 'usuario', 'moderador'].contains(rol)) {
      throw ValidacionException('rol', 'Rol inválido: $rol');
    }
    String id = 'USR-${_db.length + 1}';
    Usuario nuevo = Usuario(id, nombre.trim(), rol);
    _db[id] = nuevo;
    return nuevo;
  }
}

// ────────────────────────────────────────────────────────────────────────────
// 3. RESULT PATTERN — Alternativa funcional a excepciones
// ────────────────────────────────────────────────────────────────────────────

/// Representa el resultado de una operación: éxito o error.
///
/// Hace los errores parte del tipo de retorno, forzando al llamador
/// a manejarlos explícitamente. Ideal para Clean Architecture.
sealed class Resultado<T> {
  const Resultado();
}

/// Éxito: contiene el valor resultante de la operación.
class Exitoso<T> extends Resultado<T> {
  final T datos;
  const Exitoso(this.datos);
}

/// Falla: contiene el mensaje y código de error.
class Fallido<T> extends Resultado<T> {
  final String error;
  final int? codigo;
  const Fallido(this.error, {this.codigo});
}

/// Servicio que usa Resultado en lugar de excepciones para errores esperados.
class ServicioProductos {
  final Map<String, double> _catalogo = {
    'PRD-1': 99.99,
    'PRD-2': 49.99,
    'PRD-3': 199.99,
  };

  /// Busca el precio de [id]. Devuelve Fallido si no existe.
  Resultado<double> buscarPrecio(String id) {
    double? precio = _catalogo[id];
    if (precio == null) return Fallido('"$id" no encontrado.', codigo: 404);
    return Exitoso(precio);
  }

  /// Aplica descuento a [id]. Valida el porcentaje (0-100).
  Resultado<double> aplicarDescuento(String id, double porcentaje) {
    if (porcentaje < 0 || porcentaje > 100) {
      return Fallido('Porcentaje inválido: $porcentaje', codigo: 400);
    }
    Resultado<double> r = buscarPrecio(id);
    return switch (r) {
      Exitoso(datos: var p) => Exitoso(p * (1 - porcentaje / 100)),
      Fallido() => r,
    };
  }
}

void main() {
  // ── Excepciones personalizadas ──
  print('── Excepciones personalizadas ──');
  ServicioUsuarios servicio = ServicioUsuarios();

  // Caso exitoso
  try {
    servicio.autenticar('USR-1');
    Usuario u = servicio.obtener('USR-2');
    print('Usuario encontrado: $u');
  } on RecursoNoEncontradoException catch (e) {
    print('No encontrado: $e');
  }

  // Recurso no encontrado
  try {
    servicio.obtener('USR-999');
  } on RecursoNoEncontradoException catch (e) {
    print('Capturado: $e');
  }

  // Permisos denegados (Bob no es admin)
  try {
    servicio.autenticar('USR-2');
    servicio.eliminar('USR-1');
  } on PermisosDenegadosException catch (e) {
    print('Capturado: $e');
  }

  // Validación de campos
  try {
    servicio.crear('', 'admin');
  } on ValidacionException catch (e) {
    print('Capturado: $e');
  }

  // ── Result pattern ──
  print('\n── Result pattern ──');
  ServicioProductos productos = ServicioProductos();

  Resultado<double> r1 = productos.buscarPrecio('PRD-1');
  Resultado<double> r2 = productos.buscarPrecio('PRD-999');
  Resultado<double> r3 = productos.aplicarDescuento('PRD-2', 20);
  Resultado<double> r4 = productos.aplicarDescuento('PRD-1', -5);

  for (Resultado<double> r in [r1, r2, r3, r4]) {
    switch (r) {
      case Exitoso(datos: var precio):
        print('Precio: \$${precio.toStringAsFixed(2)}');
      case Fallido(error: var msg, codigo: var code):
        print('Error ${code ?? ""}: $msg');
    }
  }
}

// EXPERIMENTA:
//   - Crea una ConflictoException para cuando se intenta crear un recurso duplicado
//   - Implementa Result.map() para transformar el valor exitoso
//   - Añade una propiedad 'causa' (Exception?) a AppException para encadenar errores
//   - Prueba usar Result en una función que lea datos de stdin con validación
