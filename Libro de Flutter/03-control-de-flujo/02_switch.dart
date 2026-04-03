// =============================================================================
// ARCHIVO: 02_switch.dart
// TEMA: Switch en Dart — clásico, expression y pattern matching
// =============================================================================
//
// El switch en Dart evolucionó significativamente en Dart 3. Además del
// switch clásico basado en valores iguales, ahora existe el switch expression
// con pattern matching — una herramienta muy poderosa para escribir código
// más expresivo y conciso.
//
// CÓMO EJECUTAR:
//   dart run 02_switch.dart
//
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // SWITCH CLÁSICO — La versión original (compatible con Dart 2)
  // ─────────────────────────────────────────────────────────────────────────

  // El switch clásico compara un valor contra múltiples casos.
  // Cada case debe terminar con break para evitar que "caiga" al siguiente.
  // El default es el caso cuando ningún case coincide.
  String idioma = 'es';

  print('--- Switch clásico ---');
  switch (idioma) {
    case 'es':
      print('Español');
      break;
    case 'en':
      print('English');
      break;
    case 'fr':
      print('Français');
      break;
    case 'pt':
      print('Português');
      break;
    default:
      print('Idioma no reconocido: $idioma');
  }

  // Múltiples cases para el mismo bloque (fall-through intencional):
  // Si no pones break, "cae" al siguiente case.
  int mes = 4;
  print('\nMes $mes tiene:');
  switch (mes) {
    case 2:
      print('28 o 29 días');
      break;
    case 4:
    case 6:
    case 9:
    case 11:
      // Estos 4 meses comparten el mismo bloque gracias al fall-through
      print('30 días');
      break;
    default:
      print('31 días');
  }

  // ─────────────────────────────────────────────────────────────────────────
  // SWITCH EXPRESSION (DART 3) — Moderno, conciso, devuelve valor
  // ─────────────────────────────────────────────────────────────────────────

  // El switch expression NO necesita break — cada brazo es una expresión.
  // El _ es el caso por defecto (equivale al default del switch clásico).
  // Es una expresión, por lo tanto puede asignarse a una variable.
  print('\n--- Switch expression (Dart 3) ---');

  String nombreMes = switch (mes) {
    1 => 'Enero',
    2 => 'Febrero',
    3 => 'Marzo',
    4 => 'Abril',
    5 => 'Mayo',
    6 => 'Junio',
    7 => 'Julio',
    8 => 'Agosto',
    9 => 'Septiembre',
    10 => 'Octubre',
    11 => 'Noviembre',
    12 => 'Diciembre',
    _ => 'Mes inválido',
  };
  print('Mes $mes: $nombreMes');

  // ─────────────────────────────────────────────────────────────────────────
  // PATTERN MATCHING EN SWITCH (DART 3)
  // ─────────────────────────────────────────────────────────────────────────

  // Dart 3 introdujo pattern matching — puedes hacer switch sobre rangos,
  // tipos, y estructuras complejas con "guards" (condiciones con "when").
  print('\n--- Pattern matching con guards ---');

  int temperatura = 22;
  String clima = switch (temperatura) {
    < 0 => 'Helado',
    >= 0 && < 15 => 'Frío',
    >= 15 && < 25 => 'Templado',
    >= 25 && < 35 => 'Caluroso',
    _ => 'Muy caluroso',
  };
  print('$temperatura°C → $clima');

  // Switch con tipo (type patterns) — muy útil para polimorfismo:
  dynamic valor = 3.14;
  String descripcion = switch (valor) {
    int v when v > 0 => 'Entero positivo: $v',
    int v => 'Entero no positivo: $v',
    double v => 'Decimal: $v',
    String v => 'Texto: "$v"',
    _ => 'Tipo desconocido',
  };
  print('\nvalor: $valor → $descripcion');

  // ─────────────────────────────────────────────────────────────────────────
  // SWITCH CON ENUMS — Exhaustiveness checking
  // ─────────────────────────────────────────────────────────────────────────

  // Cuando haces switch sobre un enum, Dart verifica que hayas cubierto
  // todos los casos. Si falta alguno, el compilador da un error.
  // Esto previene bugs silenciosos cuando agregas nuevos valores al enum.
  print('\n--- Switch con enum ---');

  Estado estado = Estado.cargando;
  String mensaje = switch (estado) {
    Estado.inicial => 'Listo para comenzar',
    Estado.cargando => 'Cargando datos...',
    Estado.exito => '¡Datos cargados!',
    Estado.error => 'Ocurrió un error',
    // No necesitas default porque Dart verifica exhaustividad del enum
  };
  print('Estado actual: $mensaje');
}

/// Enum que representa los posibles estados de una operación asíncrona.
/// Este patrón es muy común en Flutter para manejar el estado de la UI.
enum Estado {
  /// Estado inicial antes de cualquier acción.
  inicial,

  /// La operación está en progreso.
  cargando,

  /// La operación completó exitosamente.
  exito,

  /// La operación falló.
  error,
}

// =============================================================================
// EXPERIMENTA:
//   1. Agrega un nuevo valor al enum "Estado" (ej: "pausado"). Observa
//      el error del compilador si no lo manejas en el switch.
//   2. Convierte el switch clásico de idiomas en un switch expression.
//   3. Usa pattern matching para clasificar un número como:
//      negativo, cero, positivo pequeño (1-100), positivo grande (>100).
//   4. Crea un enum "TipoWidget" con Card, Button, TextField, Icon y
//      usa switch expression para devolver el nombre en español de cada uno.
//   5. ¿Puedes hacer un switch sobre un String con pattern matching?
//      Prueba con diferentes palabras y usa _ para el default.
// =============================================================================
