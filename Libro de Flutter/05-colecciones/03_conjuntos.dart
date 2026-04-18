// =============================================================================
// ARCHIVO: 03_conjuntos.dart
// TEMA: Set<T> en Dart
// EJECUCION: dart run 03_conjuntos.dart
// =============================================================================
//
// Set guarda elementos sin duplicados.
// Es muy util cuando lo importante es saber si algo ya existe o asegurar
// unicidad de valores como permisos, IDs o etiquetas.
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // CREAR SETS
  // ─────────────────────────────────────────────────────────────────────────

  print('--- Crear Sets ---');

  // Los duplicados se eliminan automaticamente.
  var numeros = [1, 2, 3, 2, 1, 4].toSet();
  print('Set con duplicados: $numeros'); // {1, 2, 3, 4} — sin duplicados

  // Tambien puedes indicar el tipo de forma explicita.
  Set<String> idiomas = {'es', 'en', 'fr'};
  print('idiomas: $idiomas');

  // IMPORTANTE: {} sin tipo suele crear un Map vacio, no un Set.
  Set<int> vacio = {};   // Correcto: Set vacío
  var mapaVacio = {};    // Esto crea Map<dynamic, dynamic>, NO un Set
  print('Set vacío: $vacio (${vacio.runtimeType})');
  print('Mapa vacío: $mapaVacio (${mapaVacio.runtimeType})');

  // toSet() elimina duplicados al convertir desde una lista.
  List<String> listaConDuplicados = ['a', 'b', 'a', 'c', 'b', 'd'];
  Set<String> sinDuplicados = listaConDuplicados.toSet();
  print('\nLista con duplicados: $listaConDuplicados');
  print('Como Set (sin duplicados): $sinDuplicados');

  // ─────────────────────────────────────────────────────────────────────────
  // AGREGAR Y ELIMINAR
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Agregar y eliminar ---');

  Set<String> etiquetas = {'flutter', 'dart', 'mobile'};

  etiquetas.add('ui');       // Agregar un elemento
  etiquetas.add('flutter');  // Duplicado: se ignora
  etiquetas.addAll(['web', 'cross-platform']); // Agregar varios

  print('etiquetas: $etiquetas');
  print('longitud: ${etiquetas.length}');  // flutter no se duplicó

  etiquetas.remove('web');
  print('después de remove "web": $etiquetas');

  // ─────────────────────────────────────────────────────────────────────────
  // VERIFICAR PERTENENCIA
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Verificar pertenencia ---');

  // contains() suele ser muy rapido en Set.
  // Si solo quieres saber si algo existe, Set suele ser mejor que List.
  Set<String> permisosActivos = {'leer', 'escribir', 'ejecutar'};

  print('¿Puede leer? ${permisosActivos.contains("leer")}');
  print('¿Puede eliminar? ${permisosActivos.contains("eliminar")}');
  print('¿Tiene todos los de admin? ${permisosActivos.containsAll({"leer", "escribir"})}');

  // ─────────────────────────────────────────────────────────────────────────
  // OPERACIONES DE CONJUNTOS
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Operaciones de conjuntos ---');

  Set<int> A = {1, 2, 3, 4, 5};
  Set<int> B = {3, 4, 5, 6, 7};

  // union combina ambos conjuntos sin repetir.
  Set<int> union = A.union(B);
  print('A ∪ B = $union');   // {1, 2, 3, 4, 5, 6, 7}

  // intersection deja solo los elementos comunes.
  Set<int> interseccion = A.intersection(B);
  print('A ∩ B = $interseccion');  // {3, 4, 5}

  // difference deja los elementos de un conjunto que no estan en el otro.
  Set<int> diferencia = A.difference(B);
  print('A - B = $diferencia');    // {1, 2}

  Set<int> diferenciaInversa = B.difference(A);
  print('B - A = $diferenciaInversa');  // {6, 7}

  // Esto sirve en escenarios reales como permisos y selecciones.
  Set<String> conLectura = {'ana', 'luis', 'carlos', 'maría'};
  Set<String> conEscritura = {'luis', 'carlos'};
  Set<String> soloLectura = conLectura.difference(conEscritura);
  print('\nUsuarios solo con lectura: $soloLectura');

  // ─────────────────────────────────────────────────────────────────────────
  // SET vs LIST
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Set vs List ---');

  // List sirve mejor si importa el orden o el indice.
  // Set sirve mejor si importa la unicidad o busquedas rapidas.

  // ─────────────────────────────────────────────────────────────────────────
  // CONVERTIR ENTRE LIST Y SET
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Conversiones ---');

  List<int> lista = [5, 3, 1, 3, 5, 2, 1];
  print('Lista original: $lista');

  // Lista a Set: elimina duplicados.
  Set<int> conjunto = lista.toSet();
  print('Como Set: $conjunto');

  // Set a Lista: recupera acceso por indice.
  List<int> deVuelta = conjunto.toList();
  print('De vuelta a Lista: $deVuelta');

  // Este patron es comun para limpiar listas repetidas.
  List<int> sinDups = lista.toSet().toList();
  print('Lista sin duplicados: $sinDups');
}

// =============================================================================
// QUE DEBERIAS ENTENDER AL TERMINAR
// - Set evita duplicados automaticamente.
// - Es ideal para verificar existencia y trabajar unicidad.
// - union, intersection y difference resuelven problemas reales.
// - List y Set no se usan para lo mismo.
//
// PRACTICA GUIADA
// 1. Simula etiquetas seleccionadas sin duplicados.
// 2. Calcula union e interseccion entre dos sets.
// 3. Explica cuando conviene Set en vez de List.
// =============================================================================
