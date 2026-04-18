// =============================================================================
// ARCHIVO: 01_listas.dart
// TEMA: List<T> en Dart
// EJECUCION: dart run 01_listas.dart
// =============================================================================
//
// List es una coleccion ordenada de elementos.
// En Flutter aparece constantemente para manejar datos y construir interfaces
// dinamicas como menus, tarjetas o listas de widgets.
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // CREAR LISTAS
  // ─────────────────────────────────────────────────────────────────────────

  print('--- Crear listas ---');

  // Dart puede inferir el tipo a partir de los elementos iniciales.
  var frutas = ['mango', 'banano', 'fresa'];
  print('frutas: $frutas');
  print('tipo: ${frutas.runtimeType}');  // List<String>

  // Tambien puedes declarar el tipo explicitamente.
  List<int> numeros = [10, 20, 30, 40, 50];
  print('numeros: $numeros');

  // Una lista vacia necesita tipo explicito para ser clara y segura.
  List<String> vacia = [];
  print('vacía: $vacia, longitud: ${vacia.length}');

  // List.filled crea una lista con tamaño definido.
  var fija = List<int>.filled(5, 0); // 5 elementos, todos con valor 0
  print('fija: $fija');

  // List.generate crea elementos usando una funcion.
  var cuadrados = List<int>.generate(6, (i) => i * i);
  print('cuadrados: $cuadrados');  // [0, 1, 4, 9, 16, 25]

  // ─────────────────────────────────────────────────────────────────────────
  // ACCESO Y MODIFICACION
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Acceso y modificación ---');

  var colores = ['rojo', 'verde', 'azul'];
  print('Primer elemento: ${colores[0]}');    // rojo
  print('Último elemento: ${colores.last}');  // azul
  print('Primero: ${colores.first}');         // rojo
  print('Longitud: ${colores.length}');       // 3

  // Cada posicion tiene un indice que empieza en 0.
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
  // OPERACIONES FUNCIONALES
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Operaciones funcionales ---');

  var precios = [10.0, 25.5, 8.0, 42.0, 15.75];

  // map transforma cada elemento.
  var preciosConIva = precios.map((p) => p * 1.15).toList();
  print('Con IVA: $preciosConIva');

  // where filtra elementos.
  var caros = precios.where((p) => p > 20).toList();
  print('Mayores a 20: $caros');

  // reduce combina todos los elementos en uno.
  double total = precios.reduce((acc, precio) => acc + precio);
  print('Total: $total');

  // fold se parece a reduce, pero recibe un valor inicial.
  double totalFold = precios.fold(0.0, (acc, precio) => acc + precio);
  print('Total con fold: $totalFold');

  // any verifica si al menos uno cumple la condicion.
  bool hayCaros = precios.any((p) => p > 40);
  print('¿Hay alguno > 40? $hayCaros');

  // every verifica si todos cumplen la condicion.
  bool todosPositivos = precios.every((p) => p > 0);
  print('¿Todos positivos? $todosPositivos');

  // ─────────────────────────────────────────────────────────────────────────
  // SPREAD OPERATOR
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Spread operator ---');

  var primeros = [1, 2, 3];
  var segundos = [4, 5, 6];

  // Spread inserta una lista dentro de otra.
  var combinados = [...primeros, ...segundos];
  print('Combinados: $combinados');

  var conExtras = [0, ...primeros, ...segundos, 7, 8];
  print('Con extras: $conExtras');

  // Spread null-safe evita fallar si la lista es null.
  List<int>? opcionales;
  var seguro = [1, 2, ...?opcionales, 3];
  print('Con spread null-safe: $seguro');  // [1, 2, 3] — opcionales era null

  // ─────────────────────────────────────────────────────────────────────────
  // ORDENAR LISTAS
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Ordenar ---');

  var desordenados = [3, 1, 4, 1, 5, 9, 2, 6];
  desordenados.sort(); // Modifica la lista original
  print('Ordenados ascendente: $desordenados');

  desordenados.sort((a, b) => b.compareTo(a)); // Descendente
  print('Ordenados descendente: $desordenados');

  // Tambien puedes ordenar usando una regla personalizada.
  var palabras = ['flutter', 'dart', 'programming', 'app'];
  palabras.sort((a, b) => a.length.compareTo(b.length));
  print('Por longitud: $palabras');
}

// =============================================================================
// QUE DEBERIAS ENTENDER AL TERMINAR
// - List guarda elementos ordenados por indice.
// - Puedes crear, buscar, modificar, ordenar y transformar listas.
// - map, where, reduce y fold son claves para trabajar datos reales.
// - Spread ayuda a combinar colecciones con claridad.
//
// PRACTICA GUIADA
// 1. Crea una lista de numeros y ordénala.
// 2. Elimina duplicados usando Set y vuelve a List.
// 3. Encadena where + map + reduce en una sola expresion.
// 4. Explica la diferencia entre sort() y toList()..sort().
// =============================================================================
