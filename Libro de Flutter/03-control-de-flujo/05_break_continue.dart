// =============================================================================
// ARCHIVO: 05_break_continue.dart
// TEMA: break, continue y labels en Dart
// =============================================================================
//
// break y continue controlan el flujo dentro de los bucles.
// break sale completamente del bucle. continue salta a la siguiente iteración.
// Los labels permiten controlar bucles anidados de forma explícita — algo
// que en Python no existe nativamente pero que Dart soporta elegantemente.
//
// CÓMO EJECUTAR:
//   dart run 05_break_continue.dart
//
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // BREAK — Salir del bucle inmediatamente
  // ─────────────────────────────────────────────────────────────────────────

  // break detiene el bucle y continúa con el código que sigue después.
  // Se usa típicamente para salir cuando se encuentra un resultado o
  // cuando se cumple una condición de parada.
  print('--- break ---');

  for (int i = 0; i < 10; i++) {
    if (i == 5) {
      print('Encontré el 5 — saliendo del bucle');
      break; // Detiene el for completamente
    }
    print('i = $i');
  }
  print('Código después del for (se ejecuta normalmente)');

  // Ejemplo práctico: buscar un elemento en una lista
  print('\n--- Buscar elemento con break ---');
  List<String> nombres = ['Ana', 'Luis', 'María', 'Carlos', 'Pedro'];
  String buscar = 'María';
  bool encontrado = false;

  for (var nombre in nombres) {
    if (nombre == buscar) {
      encontrado = true;
      break; // No tiene sentido seguir buscando una vez encontrado
    }
  }

  print('¿"$buscar" encontrado? $encontrado');

  // ─────────────────────────────────────────────────────────────────────────
  // CONTINUE — Saltar a la siguiente iteración
  // ─────────────────────────────────────────────────────────────────────────

  // continue no sale del bucle — solo salta el resto del bloque actual
  // y va directo a la siguiente iteración.
  print('\n--- continue ---');

  for (int i = 0; i < 10; i++) {
    if (i % 2 == 0) {
      continue; // Saltar los números pares
    }
    print('Impar: $i'); // Solo imprime 1, 3, 5, 7, 9
  }

  // Ejemplo práctico: procesar solo los válidos de una lista
  print('\n--- Filtrar con continue ---');
  List<String?> datos = ['Flutter', null, 'Dart', '', 'Kotlin', null];

  for (var dato in datos) {
    if (dato == null || dato.isEmpty) {
      continue; // Saltar nulos y vacíos
    }
    print('Dato válido: $dato');
  }

  // ─────────────────────────────────────────────────────────────────────────
  // LABELS — Controlar bucles anidados
  // ─────────────────────────────────────────────────────────────────────────

  // Cuando tienes bucles anidados, break y continue normalmente afectan
  // solo el bucle más interno. Los labels permiten especificar exactamente
  // qué bucle quieres controlar.

  // Un label se escribe antes del bucle con el formato: nombreLabel:
  print('\n--- break con label (bucle externo) ---');

  // Sin label, break solo saldría del for interno.
  // Con el label "externo:", el break sale del for EXTERNO también.
  externo:
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (i == 1 && j == 1) {
        print('Saliendo de ambos bucles desde i=$i, j=$j');
        break externo; // Sale del bucle con label "externo:"
      }
      print('i=$i, j=$j');
    }
  }
  print('Después de los bucles anidados con break externo');

  // continue con label: salta a la siguiente iteración del bucle EXTERNO
  print('\n--- continue con label ---');

  externo2:
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (j == 1) {
        // Saltar al siguiente valor de i cuando j llega a 1
        print('Saltando al siguiente i desde i=$i, j=$j');
        continue externo2;
      }
      print('i=$i, j=$j');
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // BREAK EN SWITCH
  // ─────────────────────────────────────────────────────────────────────────

  // En el switch clásico, break es obligatorio al final de cada case
  // para evitar el fall-through (caer al siguiente case).
  print('\n--- break en switch ---');

  int codigo = 2;
  switch (codigo) {
    case 1:
      print('Código 1: éxito');
      break;
    case 2:
      print('Código 2: advertencia');
      break; // Sin este break, "caería" al case 3
    case 3:
      print('Código 3: error');
      break;
    default:
      print('Código desconocido');
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Elimina el "break" del case 2 del switch. ¿Qué pasa? ¿Se ejecuta case 3?
//   2. Crea un bucle for que genere coordenadas (x,y) del 0 al 4.
//      Usa break con label para detener todo cuando x+y == 5.
//   3. Usa continue para imprimir solo los strings de una lista mixta
//      [1, "hola", true, "mundo", 42] usando dynamic e "is".
//   4. Reescribe el ejemplo de búsqueda con break usando un método
//      como .contains() o .firstWhere(). ¿Cuál prefieres?
//   5. ¿Puedes usar break fuera de un bucle o switch? Pruébalo y
//      observa el error del compilador.
// =============================================================================
