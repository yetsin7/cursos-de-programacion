// =============================================================================
// ARCHIVO: 01_que_es_null_safety.dart
// TEMA: ¿Qué es y por qué existe el Null Safety en Dart?
// =============================================================================
//
// Antes de Dart 2.12, cualquier variable podía ser null en cualquier momento.
// Esto causaba crashes en producción difíciles de anticipar. Con null safety,
// el compilador garantiza que los tipos non-nullable nunca serán null,
// eliminando toda una categoría de bugs en tiempo de ejecución.
//
// CÓMO EJECUTAR:
//   dart run 01_que_es_null_safety.dart
//
// =============================================================================

// ────────────────────────────────────────────────────────────────────────────
// SIMULACIÓN: El problema que null safety resuelve
// ────────────────────────────────────────────────────────────────────────────

/// Simula una búsqueda en base de datos que puede o no encontrar un usuario.
/// En un lenguaje SIN null safety, esto podría devolver null sin advertirte.
String? buscarNombreUsuario(int id) {
  // Simulamos que el usuario con id=1 existe, los demás no
  if (id == 1) return 'Ana García';
  return null; // El usuario no fue encontrado
}

/// Demuestra el crash típico de NullPointerException en lenguajes sin null safety.
/// En Dart, este patrón es detectado en tiempo de COMPILACIÓN, no de ejecución.
void demoSinNullSafety() {
  print('\n── Sin null safety (problema clásico) ──');

  // En Java/Kotlin sin null safety harías:
  // String nombre = buscarNombre(99);  // Podría ser null
  // System.out.println(nombre.length()); // CRASH: NullPointerException

  // En Dart con null safety, el compilador NO te deja hacer esto:
  // String nombre = buscarNombreUsuario(99); // ERROR de compilación
  // El compilador dice: "buscarNombreUsuario devuelve String?, no String"

  print('En Dart, el compilador te protege ANTES de ejecutar el código.');
  print('No puedes asignar String? a String sin manejar el null explícitamente.');
}

// ────────────────────────────────────────────────────────────────────────────
// Tipos non-nullable: la regla por defecto en Dart 3.x
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra que los tipos básicos NO aceptan null por defecto.
void demoTiposNonNullable() {
  print('\n── Tipos non-nullable (seguros por defecto) ──');

  // Todos estos tipos son non-nullable: NUNCA serán null
  String nombre = 'Beatriz';
  int edad = 25;
  double altura = 1.70;
  bool activo = true;

  print('nombre: $nombre');
  print('edad: $edad');
  print('altura: $altura');
  print('activo: $activo');

  // Estas asignaciones causarían ERROR DE COMPILACIÓN:
  // String nombre2 = null;   // Error: null no puede asignarse a String
  // int edad2 = null;        // Error: null no puede asignarse a int
}

// ────────────────────────────────────────────────────────────────────────────
// Cuándo SÍ tiene sentido permitir null
// ────────────────────────────────────────────────────────────────────────────

/// Clase que modela un usuario con datos opcionales.
/// Algunos campos tienen lógica nullable: no todo usuario tiene un apodo
/// o una fecha de nacimiento registrada.
class Usuario {
  // Campos obligatorios: no pueden ser null
  final String nombre;
  final String email;

  // Campos opcionales: lógicamente pueden no existir
  final String? apodo;          // No todos los usuarios tienen apodo
  final DateTime? fechaNac;     // La app no siempre lo solicita
  final String? fotoPerfil;     // El usuario puede no haber subido foto

  /// Crea un usuario con campos obligatorios y opcionales.
  const Usuario({
    required this.nombre,
    required this.email,
    this.apodo,
    this.fechaNac,
    this.fotoPerfil,
  });
}

/// Demuestra el uso correcto de tipos nullable en un modelo real.
void demoCuandoUsarNullable() {
  print('\n── Cuándo usar tipos nullable ──');

  // Usuario con todos los datos
  final u1 = Usuario(
    nombre: 'Carlos',
    email: 'carlos@ejemplo.com',
    apodo: 'Carly',
    fotoPerfil: 'https://cdn.ejemplo.com/carlos.jpg',
  );

  // Usuario con solo los datos obligatorios
  final u2 = Usuario(
    nombre: 'Laura',
    email: 'laura@ejemplo.com',
    // apodo, fechaNac, fotoPerfil serán null automáticamente
  );

  // El compilador sabe que nombre y email son siempre seguros
  print('${u1.nombre} (${u1.apodo ?? "sin apodo"})');
  print('${u2.nombre} (${u2.apodo ?? "sin apodo"})');

  // Para usar apodo (que es String?), debemos manejar el null
  // El operador ?? provee un valor por defecto si es null
  String apodoU1 = u1.apodo ?? 'anónimo';
  String apodoU2 = u2.apodo ?? 'anónimo';
  print('Apodos: $apodoU1, $apodoU2');
}

// ────────────────────────────────────────────────────────────────────────────
// El flujo correcto con null safety
// ────────────────────────────────────────────────────────────────────────────

/// Muestra cómo manejar correctamente un valor nullable antes de usarlo.
void demoFlujoNullSafety() {
  print('\n── Flujo correcto con null safety ──');

  // Simulamos dos búsquedas: una exitosa y una fallida
  String? encontrado = buscarNombreUsuario(1);
  String? noEncontrado = buscarNombreUsuario(99);

  // El compilador EXIGE que manejemos el caso null antes de usar el valor
  // Opción A: verificación explícita con if
  if (encontrado != null) {
    // Dentro de este bloque, Dart sabe que 'encontrado' es String (no String?)
    print('Usuario encontrado: ${encontrado.toUpperCase()}');
  }

  // Opción B: valor por defecto con ??
  String nombre = noEncontrado ?? 'Usuario desconocido';
  print('Resultado: $nombre');

  // Opción C: retornar temprano si es null (early return pattern)
  procesarUsuario(noEncontrado);
  procesarUsuario(encontrado);
}

/// Procesa el nombre de un usuario, manejando el caso null con early return.
///
/// Recibe [nombre] que puede ser null y actúa apropiadamente en cada caso.
void procesarUsuario(String? nombre) {
  if (nombre == null) {
    print('No hay usuario que procesar.');
    return; // Early return: salir de la función
  }
  // Aquí Dart sabe que 'nombre' es String (promotion automático)
  print('Procesando: ${nombre.trim().toUpperCase()}');
}

void main() {
  demoSinNullSafety();
  demoTiposNonNullable();
  demoCuandoUsarNullable();
  demoFlujoNullSafety();

  print('\n── Resumen ──');
  print('• Non-nullable (String): NUNCA null. Seguro usar directamente.');
  print('• Nullable (String?): PUEDE ser null. Debes manejarlo.');
  print('• El compilador detecta el problema ANTES de ejecutar.');
}

// EXPERIMENTA:
//   - Intenta escribir: String s = null; y observa el error del compilador
//   - Crea una función que devuelva int? y llámala sin manejar el null
//   - Agrega más campos a la clase Usuario y decide cuáles son nullable
//   - Prueba el "type promotion": después de if(x != null), usa x sin ?
