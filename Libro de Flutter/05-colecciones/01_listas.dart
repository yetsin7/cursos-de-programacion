// =============================================================================
// ARCHIVO: 01_listas.dart
// TEMA: List<T> en Dart — colecciones ordenadas
// =============================================================================
//
// List es la colección más usada en Dart (y en Flutter). Es una secuencia
// ordenada de elementos donde puedes tener duplicados. Los elementos se
// acceden por índice (empezando en 0). En Flutter usarás listas para
// construir widgets dinámicos: ListView.builder, Column con children, etc.
//
// CÓMO EJECUTAR:
//   dart run 01_listas.dart
//
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // CREAR LISTAS
  // ─────────────────────────────────────────────────────────────────────────

  print('--- Crear listas ---');

  // Lista con elementos iniciales (tipo inferido):
  var frutas = ['mango', 'banano', 'fresa'];
  print('frutas: $frutas');
  print('tipo: ${frutas.runtimeType}');  // List<String>

  // Lista con tipo explícito:
  List<int> numeros = [10, 20, 30, 40, 50];
  print('numeros: $numeros');

  // Lista vacía (debe tener tipo explícito):
  List<String> vacia = [];
  print('vacía: $vacia, longitud: ${vacia.length}');

  // Lista de longitud fija (no puede crecer ni reducir):
  var fija = List<int>.filled(5, 0); // 5 elementos, todos con valor 0
  print('fija: $fija');

  // Lista generada con una función:
  var cuadrados = List<int>.generate(6, (i) => i * i);
  print('cuadrados: $cuadrados');  // [0, 1, 4, 9, 16, 25]

  // ─────────────────────────────────────────────────────────────────────────
  // ACCESO Y MODIFICACIÓN
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Acceso y modificación ---');

  var colores = ['rojo', 'verde', 'azul'];
  print('Primer elemento: ${colores[0]}');    // rojo
  print('Último elemento: ${colores.last}');  // azul
  print('Primero: ${colores.first}');         // rojo
  print('Longitud: ${colores.length}');       // 3

  // Modificar un elemento por índice:
  colores[1] = 'amarillo';
  print('Después de modificar [1]: $colores');

  // ─────────────────────────────────────────────────────────────────────────
  // AGREGAR Y ELIMINAR ELEMENTOS
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Agregar y eliminar ---');

  var lista = <String>['a', 'b', 'c'];

  lista.add('d');                  // Agregar al final
  lista.addAll(['e', 'f']);        // Agregar múltiples al final
  lista.insert(0, 'Z');            // Insertar en posición específica
  print('Después de agregar: $lista');

  lista.remove('Z');               // Eliminar por valor (la primera ocurrencia)
  lista.removeAt(0);               // Eliminar por índice
  lista.removeLast();              // Eliminar el último
  print('Después de eliminar: $lista');

  // ─────────────────────────────────────────────────────────────────────────
  // BUSCAR ELEMENTOS
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Buscar ---');

  var lenguajes = ['Dart', 'Python', 'Kotlin', 'Dart', 'Swift'];
  print('¿Contiene "Dart"? ${lenguajes.contains("Dart")}');
  print('Índice de "Kotlin": ${lenguajes.indexOf("Kotlin")}');
  print('Último índice de "Dart": ${lenguajes.lastIndexOf("Dart")}');
  print('¿Está vacía? ${lenguajes.isEmpty}');

  // ─────────────────────────────────────────────────────────────────────────
  // OPERACIONES FUNCIONALES — map, where, reduce, fold, any, every
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Operaciones funcionales ---');

  var precios = [10.0, 25.5, 8.0, 42.0, 15.75];

  // map: transformar cada elemento (devuelve Iterable, necesita toList())
  var preciosConIva = precios.map((p) => p * 1.15).toList();
  print('Con IVA: $preciosConIva');

  // where: filtrar elementos (devuelve Iterable)
  var caros = precios.where((p) => p > 20).toList();
  print('Mayores a 20: $caros');

  // reduce: combinar todos los elementos en uno (la lista no puede estar vacía)
  double total = precios.reduce((acc, precio) => acc + precio);
  print('Total: $total');

  // fold: como reduce pero con valor inicial (funciona con lista vacía)
  double totalFold = precios.fold(0.0, (acc, precio) => acc + precio);
  print('Total con fold: $totalFold');

  // any: ¿al menos un elemento cumple la condición?
  bool hayCaros = precios.any((p) => p > 40);
  print('¿Hay alguno > 40? $hayCaros');

  // every: ¿TODOS los elementos cumplen la condición?
  bool todosPositivos = precios.every((p) => p > 0);
  print('¿Todos positivos? $todosPositivos');

  // ─────────────────────────────────────────────────────────────────────────
  // SPREAD OPERATOR — Combinar listas
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Spread operator ---');

  var primeros = [1, 2, 3];
  var segundos = [4, 5, 6];

  // Spread (...) inserta todos los elementos de una lista dentro de otra:
  var combinados = [...primeros, ...segundos];
  print('Combinados: $combinados');

  var conExtras = [0, ...primeros, ...segundos, 7, 8];
  print('Con extras: $conExtras');

  // Spread null-safe (...?): si la lista es null, no inserta nada
  List<int>? opcionales;
  var seguro = [1, 2, ...?opcionales, 3];
  print('Con spread null-safe: $seguro');  // [1, 2, 3] — opcionales era null

  // ─────────────────────────────────────────────────────────────────────────
  // ORDENAR LISTAS
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Ordenar ---');

  var desordenados = [3, 1, 4, 1, 5, 9, 2, 6];
  desordenados.sort(); // Modifica la lista original (in-place)
  print('Ordenados ascendente: $desordenados');

  desordenados.sort((a, b) => b.compareTo(a)); // Descendente
  print('Ordenados descendente: $desordenados');

  // Ordenar strings por longitud:
  var palabras = ['flutter', 'dart', 'programming', 'app'];
  palabras.sort((a, b) => a.length.compareTo(b.length));
  print('Por longitud: $palabras');
}

// =============================================================================
// EXPERIMENTA:
//   1. Crea una lista de 10 números aleatorios y ordénala. Luego elimina los
//      duplicados convirtiéndola a Set y de vuelta a List.
//   2. Usa List.generate() para crear los primeros 10 números de Fibonacci.
//   3. Encadena: where() + map() + reduce() en una sola expresión para
//      obtener la suma de los cuadrados de los números pares de [1..10].
//   4. Usa el spread operator para construir un menú de opciones combinando
//      opciones básicas con opciones admin condicionalmente.
//   5. ¿Qué diferencia hay entre lista.sort() y lista.toList()..sort()?
//      ¿Cuándo preferirías uno sobre el otro?
// =============================================================================
