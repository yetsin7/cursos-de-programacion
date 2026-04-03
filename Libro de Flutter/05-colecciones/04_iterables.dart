// =============================================================================
// ARCHIVO: 04_iterables.dart
// TEMA: Iterable<T> en Dart — la clase base de colecciones, lazy evaluation y generators
// =============================================================================
//
// Iterable es la clase abstracta que implementan List, Set y otras colecciones.
// Entiender Iterable es importante porque los métodos como map() y where()
// no devuelven List sino Iterable — una secuencia perezosa que no se evalúa
// hasta que la necesitas. Los generators (sync* con yield) permiten crear
// Iterables de forma eficiente sin construir toda la colección en memoria.
//
// CÓMO EJECUTAR:
//   dart run 04_iterables.dart
//
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // ITERABLE — La clase base
  // ─────────────────────────────────────────────────────────────────────────

  print('--- Iterable básico ---');

  // List y Set son subtipos de Iterable. Puedes usar Iterable como tipo
  // cuando no te importa si es una lista o un set.
  Iterable<int> numeros = [1, 2, 3, 4, 5]; // Una List asignada a Iterable

  // Métodos disponibles en cualquier Iterable:
  print('primero: ${numeros.first}');
  print('último: ${numeros.last}');
  print('longitud: ${numeros.length}');
  print('¿vacío? ${numeros.isEmpty}');
  print('¿no vacío? ${numeros.isNotEmpty}');

  // ─────────────────────────────────────────────────────────────────────────
  // MÉTODOS COMUNES DE ITERABLE
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Métodos de Iterable ---');

  var datos = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5];

  // map: transforma cada elemento (LAZY — no ejecuta hasta que se consume):
  var dobles = datos.map((n) => n * 2);
  print('dobles (Iterable): $dobles');           // Iterable — aún no calculado
  print('dobles (Lista): ${dobles.toList()}');   // Ahora sí se calcula

  // where: filtra elementos (también LAZY):
  var mayoresDe4 = datos.where((n) => n > 4);
  print('\nmayores de 4: ${mayoresDe4.toList()}');

  // take: tomar los primeros N elementos:
  var primersCinco = datos.take(5);
  print('primeros 5: ${primersCinco.toList()}');

  // skip: omitir los primeros N elementos:
  var sinPrimerosTres = datos.skip(3);
  print('saltando 3: ${sinPrimerosTres.toList()}');

  // takeWhile: tomar mientras la condición sea true (para en la primera false):
  var hastaDosDígitos = datos.takeWhile((n) => n < 5);
  print('mientras < 5: ${hastaDosDígitos.toList()}');

  // skipWhile: saltar mientras sea true, luego tomar el resto:
  var desdePrimeroMayor = datos.skipWhile((n) => n < 5);
  print('desde primero >=5: ${desdePrimeroMayor.toList()}');

  // ─────────────────────────────────────────────────────────────────────────
  // LAZY EVALUATION — Por qué importa
  // ─────────────────────────────────────────────────────────────────────────

  // Cuando encadenas map() y where(), Dart NO procesa la colección completa
  // en cada paso — evalúa elemento por elemento solo cuando se necesita.
  // Esto es más eficiente en memoria para colecciones grandes.
  print('\n--- Lazy evaluation ---');

  var palabras = ['flutter', 'dart', 'widget', 'app', 'build', 'context'];

  // Esta cadena NO se ejecuta aquí todavía:
  var resultado = palabras
      .where((p) => p.length > 4)    // Paso 1: filtrar
      .map((p) => p.toUpperCase())   // Paso 2: transformar
      .take(3);                       // Paso 3: tomar solo 3

  // Solo se evalúa cuando se consume (toList, forEach, for-in, etc.):
  print('Resultado: ${resultado.toList()}');

  // ─────────────────────────────────────────────────────────────────────────
  // GENERATORS — sync* y yield
  // ─────────────────────────────────────────────────────────────────────────

  // Un generator es una función que produce valores uno a uno usando yield.
  // Se declara con sync* y devuelve un Iterable.
  // Es más eficiente que construir una lista completa cuando los valores
  // se calculan dinámicamente o solo necesitas consumir algunos.
  print('\n--- Generators ---');

  // Usar el generator definido abajo:
  var rango = generarRango(1, 10);
  print('Rango 1-10: ${rango.toList()}');

  var pares = generarPares(1, 20);
  print('Pares 1-20: ${pares.toList()}');

  // Fibonacci infinito — el generator no calcula todos de antemano:
  var primerosN = fibonacci().take(10);
  print('Fibonacci (10 primeros): ${primerosN.toList()}');

  // ─────────────────────────────────────────────────────────────────────────
  // CONVERTIR ITERABLES
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Convertir ---');

  Iterable<String> nombres = ['Ana', 'Luis', 'María', 'Carlos'];

  // toList(): Iterable → List (materializa la evaluación perezosa)
  List<String> comoLista = nombres.toList();
  print('Como List: $comoLista');

  // toSet(): Iterable → Set (elimina duplicados)
  var conDups = [1, 2, 2, 3, 3, 3];
  Set<int> comoSet = conDups.toSet();
  print('Con duplicados: $conDups → Set: $comoSet');

  // join(): Iterable<String> → String concatenado
  String unido = nombres.join(', ');
  print('Unido: $unido');

  // expand(): "aplanar" — cada elemento produce múltiples resultados:
  var listas = [[1, 2], [3, 4], [5, 6]];
  var plana = listas.expand((lista) => lista).toList();
  print('Aplanada: $plana');
}

/// Genera los enteros de [inicio] a [fin] (inclusive).
/// Ejemplo de generator sincrónico con sync* y yield.
Iterable<int> generarRango(int inicio, int fin) sync* {
  // yield entrega un valor al consumidor y "pausa" la ejecución.
  // La próxima vez que el consumidor pide un valor, continúa desde aquí.
  for (int i = inicio; i <= fin; i++) {
    yield i;
  }
}

/// Genera solo los números pares en un rango.
Iterable<int> generarPares(int inicio, int fin) sync* {
  for (int i = inicio; i <= fin; i++) {
    if (i % 2 == 0) yield i;
  }
}

/// Generator INFINITO de la secuencia de Fibonacci.
/// Como es infinito, siempre usa take(n) al consumirlo.
Iterable<int> fibonacci() sync* {
  int a = 0, b = 1;
  while (true) {
    yield a;
    // Calcular el siguiente par de valores:
    int siguiente = a + b;
    a = b;
    b = siguiente;
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Crea un generator que produzca los números primos indefinidamente.
//      Úsalo con take(20) para los primeros 20 primos.
//   2. Encadena 4 operaciones Iterable (where, map, skip, take) sobre una
//      lista de palabras. ¿Cuántas veces se evalúa cada elemento?
//   3. Usa expand() para "aplanar" una lista de frases en una lista de palabras:
//      ['hola mundo', 'dart flutter'] → ['hola', 'mundo', 'dart', 'flutter']
//   4. Compara construir List.generate(1000000, ...) vs un generator que
//      produce los mismos valores. ¿Cuál usa menos memoria conceptualmente?
//   5. Crea un generator "ciclo" que repita infinitamente los elementos
//      de una lista dada: ciclo([1,2,3]) → 1,2,3,1,2,3,1,2,3...
//      Úsalo con take(10).
// =============================================================================
