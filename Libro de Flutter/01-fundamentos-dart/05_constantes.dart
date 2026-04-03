// =============================================================================
// ARCHIVO: 05_constantes.dart
// TEMA: const y final — constantes en Dart
// =============================================================================
//
// Dart tiene dos palabras clave para declarar valores que no cambian:
// "const" y "final". Aunque parecen similares, tienen diferencias importantes.
// Entender cuándo usar cada una es esencial, especialmente en Flutter,
// donde "const" tiene implicaciones de rendimiento muy significativas.
//
// CÓMO EJECUTAR:
//   dart run 05_constantes.dart
//
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // FINAL — Un valor asignado una sola vez (en tiempo de ejecución)
  // ─────────────────────────────────────────────────────────────────────────

  // "final" significa que la variable solo puede ser asignada UNA VEZ.
  // Una vez asignada, no puedes cambiarla.
  // El valor se conoce en TIEMPO DE EJECUCIÓN (puede venir de una función,
  // de la red, del usuario, etc.).
  final String nombre = 'Flutter';
  final int anioCreacion = 2017;

  print('--- final ---');
  print('Nombre: $nombre');
  print('Año de creación: $anioCreacion');

  // Esto causaría error de compilación:
  // nombre = 'React'; // ERROR: The final variable 'nombre' can only be set once.

  // El tipo puede inferirse con final:
  final version = 3.0; // Dart infiere que es double
  print('Versión: $version (tipo: ${version.runtimeType})');

  // El valor de final puede calcularse en tiempo de ejecución:
  final ahora = DateTime.now(); // No se conoce hasta que el programa corre
  print('Ahora: $ahora');

  // ─────────────────────────────────────────────────────────────────────────
  // CONST — Constante en tiempo de COMPILACIÓN
  // ─────────────────────────────────────────────────────────────────────────

  // "const" es una constante que el compilador evalúa ANTES de ejecutar
  // el programa. El valor debe ser conocido completamente en tiempo de
  // compilación: no puede depender de cálculos dinámicos ni del entorno.
  const double pi = 3.14159265358979;
  const int diasPorSemana = 7;
  const String appNombre = 'Mi App Flutter';

  print('\n--- const ---');
  print('Pi: $pi');
  print('Días por semana: $diasPorSemana');
  print('Nombre de la app: $appNombre');

  // Esto causaría error porque DateTime.now() no se conoce en compilación:
  // const tiempoActual = DateTime.now(); // ERROR: no es constante de compilación

  // ─────────────────────────────────────────────────────────────────────────
  // DIFERENCIA CLAVE: final vs const
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- final vs const ---');

  // FINAL: el valor se asigna una vez, pero puede calcularse al ejecutar.
  final List<int> listaFinal = [1, 2, 3];
  listaFinal.add(4); // VÁLIDO: puedes modificar el contenido de la lista
  print('listaFinal: $listaFinal'); // [1, 2, 3, 4]

  // CONST: la lista en sí es inmutable. No puedes modificar su contenido.
  const List<int> listaConst = [10, 20, 30];
  // listaConst.add(40); // ERROR: Unsupported operation: Cannot add to an unmodifiable list
  print('listaConst: $listaConst');

  // Resumen visual:
  // ┌─────────────┬────────────────────────────────────────────────────────┐
  // │             │ final                    │ const                       │
  // ├─────────────┼──────────────────────────┼─────────────────────────────┤
  // │ Cuándo se   │ Tiempo de ejecución       │ Tiempo de compilación       │
  // │ evalúa      │                           │                             │
  // │ Puede venir │ Sí (red, usuario, hora)   │ No (solo literales)         │
  // │ de runtime  │                           │                             │
  // │ Contenido   │ Modificable (si es List)  │ Completamente inmutable     │
  // │ de objetos  │                           │                             │
  // └─────────────┴──────────────────────────┴─────────────────────────────┘

  // ─────────────────────────────────────────────────────────────────────────
  // CONST EN FLUTTER — Por qué importa el rendimiento
  // ─────────────────────────────────────────────────────────────────────────

  // En Flutter, marcar un widget como "const" le dice al motor de renderizado
  // que ese widget NUNCA va a cambiar. Flutter puede reutilizarlo en memoria
  // en lugar de recrearlo cada vez que la pantalla se redibuja.
  // Esto mejora significativamente el rendimiento.

  // Ejemplo de cómo se ve en Flutter (solo como referencia de código):
  //
  //   Widget build(BuildContext context) {
  //     return const Text('Hola mundo'); // Flutter nunca lo recrea
  //   }
  //
  // vs
  //
  //   Widget build(BuildContext context) {
  //     return Text('Hola mundo'); // Flutter lo recrea en cada rebuild
  //   }

  print('\n--- const en colecciones ---');

  // Las colecciones const son canónicas: dos const con el mismo contenido
  // son el MISMO objeto en memoria. Dart las comparte.
  const lista1 = [1, 2, 3];
  const lista2 = [1, 2, 3];
  print('lista1 == lista2: ${lista1 == lista2}');           // true
  print('son idénticas: ${identical(lista1, lista2)}');     // true (mismo objeto)

  // Con final, son objetos distintos aunque tengan el mismo contenido:
  final listaA = [1, 2, 3];
  final listaB = [1, 2, 3];
  print('listaA == listaB: ${listaA == listaB}');           // true (mismo contenido)
  print('son idénticas: ${identical(listaA, listaB)}');     // false (objetos distintos)
}

// =============================================================================
// EXPERIMENTA:
//   1. Intenta modificar listaConst agregando un elemento. Lee el error.
//   2. Crea una const con tu nombre y un final con la hora actual.
//      ¿Por qué uno es const y el otro no puede serlo?
//   3. Declara const PI = 3.14 y calcula el área de un círculo con radio 5.
//   4. Compara dos listas final con identical() y dos listas const con identical().
//      Anota la diferencia.
//   5. Busca un archivo de Flutter en GitHub y cuenta cuántos widgets usan "const".
//      Observa el patrón.
// =============================================================================
