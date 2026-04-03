// =============================================================================
// ARCHIVO: 03_logicos.dart
// TEMA: Operadores lógicos en Dart — &&, ||, !
// =============================================================================
//
// Los operadores lógicos combinan valores booleanos para tomar decisiones.
// Dart tiene un comportamiento importante llamado "short-circuit evaluation"
// (evaluación en cortocircuito) que puede afectar el rendimiento y
// prevenir errores cuando se combina con null safety.
//
// CÓMO EJECUTAR:
//   dart run 03_logicos.dart
//
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // OPERADOR && — AND (Y lógico)
  // ─────────────────────────────────────────────────────────────────────────

  // && devuelve true SOLO si AMBOS operandos son true.
  // Si el primero es false, no evalúa el segundo (cortocircuito).
  print('--- AND (&&) ---');
  print('true  && true  = ${true && true}');    // true
  print('true  && false = ${true && false}');   // false
  print('false && true  = ${false && true}');   // false
  print('false && false = ${false && false}');  // false

  bool esMayor = true;
  bool tienePermiso = true;
  bool puedeAcceder = esMayor && tienePermiso;
  print('\n¿Puede acceder? $puedeAcceder');

  // ─────────────────────────────────────────────────────────────────────────
  // OPERADOR || — OR (O lógico)
  // ─────────────────────────────────────────────────────────────────────────

  // || devuelve true si AL MENOS UN operando es true.
  // Si el primero es true, no evalúa el segundo (cortocircuito).
  print('\n--- OR (||) ---');
  print('true  || true  = ${true || true}');    // true
  print('true  || false = ${true || false}');   // true
  print('false || true  = ${false || true}');   // true
  print('false || false = ${false || false}');  // false

  bool esMiembro = false;
  bool tieneCodigoInvitacion = true;
  bool puedeRegistrarse = esMiembro || tieneCodigoInvitacion;
  print('\n¿Puede registrarse? $puedeRegistrarse');

  // ─────────────────────────────────────────────────────────────────────────
  // OPERADOR ! — NOT (Negación)
  // ─────────────────────────────────────────────────────────────────────────

  // ! invierte el valor booleano.
  print('\n--- NOT (!) ---');
  print('!true  = ${!true}');    // false
  print('!false = ${!false}');   // true

  bool estaActivo = false;
  bool estaInactivo = !estaActivo;
  print('activo: $estaActivo, inactivo: $estaInactivo');

  // ─────────────────────────────────────────────────────────────────────────
  // SHORT-CIRCUIT EVALUATION — Evaluación en cortocircuito
  // ─────────────────────────────────────────────────────────────────────────

  // Dart deja de evaluar una expresión lógica tan pronto como el resultado
  // es determinado. Esto tiene dos implicaciones importantes:

  // 1. Rendimiento: evita evaluar expresiones costosas innecesariamente.
  // 2. Seguridad: permite verificar null antes de acceder a propiedades.

  print('\n--- Short-circuit evaluation ---');

  // Con &&: si el primero es false, el segundo NO se evalúa.
  // Esto permite verificar que algo no es null antes de usarlo:
  String? texto;
  // Sin cortocircuito, texto.length lanzaría error (texto es null).
  // Con &&, si texto es null → false, y .length nunca se evalúa.
  bool tieneContenido = texto != null && texto.length > 0;
  print('texto es null, tieneContenido: $tieneContenido');  // false (sin error)

  texto = 'Flutter';
  tieneContenido = texto != null && texto.length > 0;
  print('texto = "$texto", tieneContenido: $tieneContenido');  // true

  // Con ||: si el primero es true, el segundo NO se evalúa.
  // Ejemplo: verificar si el usuario es admin O si tiene rol específico.
  bool esAdmin = true;
  // Si esAdmin es true, la segunda condición ni se evalúa:
  bool puedeEditar = esAdmin || verificarRol('editor');
  print('\nesAdmin: $esAdmin, puedeEditar: $puedeEditar');

  // ─────────────────────────────────────────────────────────────────────────
  // COMBINACIONES COMPLEJAS
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Expresiones complejas ---');

  int edad = 22;
  bool tieneLicencia = true;
  bool tieneCarro = false;

  // Puede manejar: tiene licencia Y (tiene carro O es mayor de 25)
  bool puedeConducir = tieneLicencia && (tieneCarro || edad > 25);
  print('¿Puede conducir? $puedeConducir');  // false (no tiene carro y es menor de 25 no aplica)

  // Nota: los paréntesis no son obligatorios pero mejoran la legibilidad.
  // Sin paréntesis, && tiene precedencia sobre ||.
  // Es mejor ser explícito con paréntesis que depender de precedencia.

  // Múltiples condiciones encadenadas:
  bool condicionCompleja = (edad >= 18) && tieneLicencia && !tieneCarro;
  print('¿Mayor y con licencia pero sin carro? $condicionCompleja');
}

/// Simula verificar si un usuario tiene un rol específico.
/// En un caso real, consultaría una base de datos o un token.
bool verificarRol(String rol) {
  print('  (verificarRol("$rol") fue llamado)');
  return rol == 'admin';
}

// =============================================================================
// EXPERIMENTA:
//   1. Crea una variable "String? email" null. Usa && para verificar que no es
//      null Y que contiene "@" antes de imprimir "email válido".
//   2. Cambia el orden de las condiciones en el ejemplo del cortocircuito.
//      ¿Cuándo se llama verificarRol() y cuándo no?
//   3. Construye una condición que devuelva true si un número está entre 1 y 100.
//   4. ¿Cuál es la diferencia entre !a && !b  y  !(a || b) ?
//      (Ley de De Morgan — prueba con distintos valores de a y b)
//   5. Crea una función que valide si un string es un email básico:
//      no es null, tiene "@", tiene "." después del "@".
// =============================================================================
