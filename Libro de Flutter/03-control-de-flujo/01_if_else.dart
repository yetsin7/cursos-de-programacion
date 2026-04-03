// =============================================================================
// ARCHIVO: 01_if_else.dart
// TEMA: Condicionales en Dart — if, else if, else y operador ternario
// =============================================================================
//
// Las condicionales son la base de la lógica en cualquier programa.
// En Dart funcionan igual que en la mayoría de lenguajes, con la adición
// del operador ternario y el switch expression moderno de Dart 3.
//
// CÓMO EJECUTAR:
//   dart run 01_if_else.dart
//
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // IF BÁSICO
  // ─────────────────────────────────────────────────────────────────────────

  int temperatura = 28;

  // La condición dentro del if DEBE ser un bool.
  // En Dart no existe "truthy/falsy": solo true o false son válidos.
  if (temperatura > 30) {
    print('Hace calor ☀️');
  }

  // ─────────────────────────────────────────────────────────────────────────
  // IF - ELSE
  // ─────────────────────────────────────────────────────────────────────────

  int hora = 14;

  if (hora < 12) {
    print('Buenos días');
  } else {
    print('Buenas tardes/noches');
  }

  // ─────────────────────────────────────────────────────────────────────────
  // IF - ELSE IF - ELSE (cadena de condiciones)
  // ─────────────────────────────────────────────────────────────────────────

  // Solo se ejecuta el primer bloque cuya condición sea true.
  // El "else" al final actúa como caso por defecto.
  int nota = 75;

  if (nota >= 90) {
    print('Calificación: A — Excelente');
  } else if (nota >= 80) {
    print('Calificación: B — Bien');
  } else if (nota >= 70) {
    print('Calificación: C — Aprobado');
  } else if (nota >= 60) {
    print('Calificación: D — Regular');
  } else {
    print('Calificación: F — Reprobado');
  }

  // ─────────────────────────────────────────────────────────────────────────
  // CONDICIONALES CON NULL SAFETY
  // ─────────────────────────────────────────────────────────────────────────

  String? nombre;

  // Verificar si es null antes de usar:
  if (nombre != null) {
    print('Hola, $nombre');
  } else {
    print('Hola, invitado');
  }

  nombre = 'Carlos';

  // Con el operador ?. no necesitas if, pero el if es más explícito:
  if (nombre != null && nombre.isNotEmpty) {
    print('Nombre válido: $nombre');
  }

  // ─────────────────────────────────────────────────────────────────────────
  // OPERADOR TERNARIO — condición ? valor_si_true : valor_si_false
  // ─────────────────────────────────────────────────────────────────────────

  // El operador ternario es un if-else en una sola línea.
  // Es ideal para expresiones simples. Para lógica compleja, usa if normal.
  int edad = 20;
  String categoria = edad >= 18 ? 'Adulto' : 'Menor';
  print('\nEdad: $edad → $categoria');

  // Se puede anidar, pero evita hacerlo — perjudica la legibilidad:
  int puntos = 85;
  String nivel = puntos >= 90 ? 'Oro' : puntos >= 70 ? 'Plata' : 'Bronce';
  print('Puntos: $puntos → Nivel: $nivel');
  // Mejor versión de lo anterior: usar if-else if directamente.

  // En Flutter el ternario es muy común para alternar widgets:
  // Widget visible = estaActivo ? const ActiveWidget() : const InactiveWidget();

  // ─────────────────────────────────────────────────────────────────────────
  // SWITCH EXPRESSION DE DART 3 — Alternativa moderna al if-else if
  // ─────────────────────────────────────────────────────────────────────────

  // El switch expression es ideal cuando tienes muchos casos discretos.
  // Devuelve un valor directamente — es una expresión, no una sentencia.
  int diaSemana = 3;

  String nombreDia = switch (diaSemana) {
    1 => 'Lunes',
    2 => 'Martes',
    3 => 'Miércoles',
    4 => 'Jueves',
    5 => 'Viernes',
    6 => 'Sábado',
    7 => 'Domingo',
    _ => 'Día inválido',   // _ es el caso por defecto
  };

  print('\nDía $diaSemana: $nombreDia');

  // El switch expression también puede usarse con condiciones (guards):
  String categoria2 = switch (nota) {
    >= 90 => 'Excelente',
    >= 80 => 'Bien',
    >= 70 => 'Aprobado',
    >= 60 => 'Regular',
    _ => 'Reprobado',
  };
  print('Nota $nota → $categoria2');
}

// =============================================================================
// EXPERIMENTA:
//   1. Cambia "nota" a diferentes valores y verifica que la categoría cambia.
//   2. Crea un if-else que clasifique una temperatura: helado (<0), frío (0-15),
//      templado (15-25), caluroso (25-35), muy caluroso (>35).
//   3. Reescribe el clasificador de temperatura con el switch expression de Dart 3.
//   4. ¿Qué pasa si el operador ternario tiene una condición null sin ?
//      Por ejemplo: String? x; String y = x != null ? x : 'default';
//      Simplifica esto usando el operador ??.
//   5. Crea una función que reciba un mes (1-12) y devuelva su nombre en español.
//      Usa switch expression.
// =============================================================================
