// =============================================================================
// ARCHIVO: 04_comentarios.dart
// TEMA: Tipos de comentarios en Dart y buenas prácticas
// =============================================================================
//
// Los comentarios son parte fundamental del código profesional.
// No solo explican qué hace el código, sino POR QUÉ existe esa decisión.
// Un código sin comentarios puede ser difícil de mantener incluso para su autor.
//
// CÓMO EJECUTAR:
//   dart run 04_comentarios.dart
//
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // COMENTARIOS DE LÍNEA — //
  // ─────────────────────────────────────────────────────────────────────────

  // Este es un comentario de línea.
  // Todo lo que está después de // hasta el final de la línea es ignorado.
  // Es el tipo de comentario más común en Dart.

  var x = 10; // También puedes poner comentarios al final de una línea de código

  // Uso correcto: explicar el por qué, no el qué obvio.
  // MAL comentario (describe lo obvio):
  var suma = x + 5; // suma x más 5

  // BUEN comentario (explica la razón de la decisión):
  // El límite máximo es 15 porque la API rechaza valores superiores
  var limiteMaximo = 15;

  print('x: $x, suma: $suma, límite: $limiteMaximo');

  // ─────────────────────────────────────────────────────────────────────────
  // COMENTARIOS DE BLOQUE — /* */
  // ─────────────────────────────────────────────────────────────────────────

  /*
    Este es un comentario de bloque.
    Puede ocupar varias líneas sin necesidad de // en cada una.

    Se usa típicamente para:
    - Deshabilitar temporalmente un bloque de código
    - Notas extensas durante el desarrollo
    - Separadores visuales en algunos equipos

    En la práctica, los comentarios de bloque son menos usados en Dart
    comparado con los de línea y los de documentación.
  */

  var activo = true;

  /* Código deshabilitado temporalmente:
  activo = verificarEstado();
  if (!activo) return;
  */

  print('activo: $activo');

  // ─────────────────────────────────────────────────────────────────────────
  // COMENTARIOS DE DOCUMENTACIÓN — ///
  // ─────────────────────────────────────────────────────────────────────────

  // Los comentarios /// son especiales: generan documentación automática.
  // Las herramientas como dart doc los convierten en documentación HTML.
  // Los IDEs (VS Code, Android Studio) los muestran al pasar el cursor.
  // Siempre usa /// para documentar clases, funciones y métodos públicos.

  // Aquí llamamos la función documentada más abajo:
  var resultado = calcularArea(base: 10, altura: 5);
  print('Área del triángulo: $resultado');

  var bienvenida = saludar('María');
  print(bienvenida);

  // ─────────────────────────────────────────────────────────────────────────
  // BUENAS PRÁCTICAS CON COMENTARIOS
  // ─────────────────────────────────────────────────────────────────────────

  // REGLA 1: Comenta el POR QUÉ, no el QUÉ.
  // El código ya dice qué hace. El comentario debe decir por qué lo hace así.

  // REGLA 2: Mantén los comentarios actualizados.
  // Un comentario desactualizado es peor que no tener comentario.

  // REGLA 3: No comentes lo obvio.
  var total = 0; // MAL: inicializar total en 0 — esto es obvio
  // BIEN: sin comentario (el código se explica solo)
  var contador = 0;

  for (var i = 1; i <= 5; i++) {
    // Acumular la suma de los primeros 5 números positivos
    total += i;
    contador++;
  }
  print('Total: $total, iteraciones: $contador');

  // REGLA 4: Usa TODO: para marcar tareas pendientes.
  // Las herramientas de desarrollo reconocen este patrón.
  // TODO(yetsin): agregar validación de rango para el precio

  // REGLA 5: Usa FIXME: para marcar bugs conocidos.
  // FIXME: este cálculo falla con números negativos — revisar
}

/// Calcula el área de un triángulo.
///
/// Usa la fórmula clásica: área = (base × altura) / 2.
/// Ambos parámetros deben ser positivos. Si se pasan valores negativos,
/// el resultado será matemáticamente incorrecto pero no lanzará error.
///
/// Parámetros:
/// - [base]: La base del triángulo en unidades de medida.
/// - [altura]: La altura perpendicular a la base.
///
/// Retorna el área como [double].
double calcularArea({required double base, required double altura}) {
  return (base * altura) / 2;
}

/// Genera un mensaje de bienvenida personalizado.
///
/// Crea un saludo formal en español para el [nombre] proporcionado.
/// El mensaje siempre incluye signos de exclamación de apertura y cierre.
///
/// Parámetros:
/// - [nombre]: El nombre de la persona a saludar.
///
/// Retorna un [String] con el mensaje completo.
String saludar(String nombre) {
  return '¡Bienvenido/a, $nombre!';
}

// =============================================================================
// EXPERIMENTA:
//   1. Pasa el cursor sobre "calcularArea" o "saludar" en tu IDE.
//      ¿Ves la documentación que escribiste con ///? Así funciona dart doc.
//   2. Escribe una función propia y documéntala con ///.
//   3. Prueba ejecutar "dart doc ." en la carpeta del módulo para generar HTML.
//   4. Busca en tu código (o en proyectos Flutter de GitHub) comentarios
//      con TODO: y FIXME:. ¿Cuántos encuentras?
//   5. Reescribe un comentario malo que hayas escrito antes.
//      ¿Ahora explica el POR QUÉ en lugar del QUÉ?
// =============================================================================
