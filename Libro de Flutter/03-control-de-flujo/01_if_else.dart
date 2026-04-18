// =============================================================================
// ARCHIVO: 01_if_else.dart
// TEMA: Condicionales en Dart
// EJECUCION: dart run 01_if_else.dart
// =============================================================================
//
// Las condicionales permiten que un programa tome decisiones.
// En lugar de ejecutar siempre el mismo camino, Dart puede evaluar una
// condicion y elegir que bloque usar.
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // IF BASICO
  // ─────────────────────────────────────────────────────────────────────────

  int temperatura = 28;

  // La condicion dentro del if debe ser bool.
  // En Dart no basta cualquier valor: solo true o false.
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
  // IF - ELSE IF - ELSE
  // ─────────────────────────────────────────────────────────────────────────

  // Solo se ejecuta el primer bloque cuya condicion sea true.
  // El else final actua como caso por defecto.
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

  String? nombre = DateTime.now().millisecond.isEven ? null : 'Invitado';

  // Verificar null antes de usar evita errores.
  if (nombre != null) {
    print('Hola, $nombre');
  } else {
    print('Hola, invitado');
  }

  nombre = 'Carlos';
  String nombreSeguro = nombre;

  // El if sigue siendo muy claro cuando quieres validar varias cosas.
  if (nombreSeguro.isNotEmpty) {
    print('Nombre valido: $nombreSeguro');
  }

  // ─────────────────────────────────────────────────────────────────────────
  // OPERADOR TERNARIO
  // ─────────────────────────────────────────────────────────────────────────

  // El ternario resume un if-else sencillo en una sola expresion.
  // Para logica compleja conviene usar if normal.
  int edad = 20;
  String categoria = edad >= 18 ? 'Adulto' : 'Menor';
  print('\nEdad: $edad → $categoria');

  // Se puede anidar, pero suele empeorar la lectura.
  int puntos = 85;
  String nivel = puntos >= 90 ? 'Oro' : puntos >= 70 ? 'Plata' : 'Bronce';
  print('Puntos: $puntos → Nivel: $nivel');
  // En casos asi, if-else if suele ser mas legible.

  // En Flutter el ternario es comun para alternar widgets.
  // Widget visible = estaActivo ? const ActiveWidget() : const InactiveWidget();

  // ─────────────────────────────────────────────────────────────────────────
  // SWITCH EXPRESSION DE DART 3
  // ─────────────────────────────────────────────────────────────────────────

  // El switch expression es util cuando tienes casos concretos.
  // Devuelve un valor directamente.
  int diaSemana = 3;

  String nombreDia = switch (diaSemana) {
    1 => 'Lunes',
    2 => 'Martes',
    3 => 'Miércoles',
    4 => 'Jueves',
    5 => 'Viernes',
    6 => 'Sábado',
    7 => 'Domingo',
    _ => 'Dia invalido',
  };

  print('\nDía $diaSemana: $nombreDia');

  // Tambien puede usarse con rangos o patrones.
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
// QUE DEBERIAS ENTENDER AL TERMINAR
// - if y else permiten elegir entre caminos.
// - El ternario sirve para decisiones cortas.
// - switch expression resume casos discretos de forma clara.
// - Validar null sigue siendo parte importante del flujo.
//
// PRACTICA GUIADA
// 1. Cambia nota a distintos valores.
// 2. Clasifica una temperatura con if-else.
// 3. Reescribe esa clasificacion con switch expression.
// 4. Crea una funcion que reciba un mes y devuelva su nombre.
// =============================================================================
