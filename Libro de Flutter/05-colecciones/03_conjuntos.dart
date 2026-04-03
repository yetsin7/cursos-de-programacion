// =============================================================================
// ARCHIVO: 03_conjuntos.dart
// TEMA: Set<T> en Dart — colecciones sin duplicados
// =============================================================================
//
// Set es una colección que NO permite elementos duplicados y NO garantiza
// un orden específico de los elementos. Es el equivalente al "set" de Python.
// En Flutter se usa cuando necesitas asegurarte de no tener duplicados:
// etiquetas seleccionadas, permisos únicos, IDs visitados, etc.
//
// CÓMO EJECUTAR:
//   dart run 03_conjuntos.dart
//
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // CREAR SETS
  // ─────────────────────────────────────────────────────────────────────────

  print('--- Crear Sets ---');

  // Set con elementos iniciales — los duplicados se ignoran automáticamente:
  var numeros = {1, 2, 3, 2, 1, 4};
  print('Set con duplicados: $numeros'); // {1, 2, 3, 4} — sin duplicados

  // Set con tipo explícito:
  Set<String> idiomas = {'es', 'en', 'fr'};
  print('idiomas: $idiomas');

  // Set vacío — IMPORTANTE: {} solo crea un Map vacío, no un Set vacío.
  // Para un Set vacío se necesita el tipo explícito:
  Set<int> vacio = {};   // Correcto: Set vacío
  var mapaVacio = {};    // Esto crea Map<dynamic, dynamic>, NO un Set
  print('Set vacío: $vacio (${vacio.runtimeType})');
  print('Mapa vacío: $mapaVacio (${mapaVacio.runtimeType})');

  // Crear Set desde una lista (elimina duplicados):
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
  etiquetas.add('flutter');  // Intentar agregar duplicado — se ignora
  etiquetas.addAll(['web', 'cross-platform']); // Agregar varios

  print('etiquetas: $etiquetas');
  print('longitud: ${etiquetas.length}');  // flutter no se duplicó

  etiquetas.remove('web');
  print('después de remove "web": $etiquetas');

  // ─────────────────────────────────────────────────────────────────────────
  // VERIFICAR PERTENENCIA
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Verificar pertenencia ---');

  // contains() en Set es O(1) — mucho más eficiente que List.contains() O(n)
  // Para grandes conjuntos de datos donde solo necesitas "¿existe?" usa Set.
  Set<String> permisosActivos = {'leer', 'escribir', 'ejecutar'};

  print('¿Puede leer? ${permisosActivos.contains("leer")}');
  print('¿Puede eliminar? ${permisosActivos.contains("eliminar")}');
  print('¿Tiene todos los de admin? ${permisosActivos.containsAll({"leer", "escribir"})}');

  // ─────────────────────────────────────────────────────────────────────────
  // OPERACIONES DE TEORÍA DE CONJUNTOS
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Operaciones de conjuntos ---');

  Set<int> A = {1, 2, 3, 4, 5};
  Set<int> B = {3, 4, 5, 6, 7};

  // UNIÓN: todos los elementos de ambos conjuntos (sin duplicados)
  Set<int> union = A.union(B);
  print('A ∪ B = $union');   // {1, 2, 3, 4, 5, 6, 7}

  // INTERSECCIÓN: solo los elementos comunes a ambos
  Set<int> interseccion = A.intersection(B);
  print('A ∩ B = $interseccion');  // {3, 4, 5}

  // DIFERENCIA: elementos de A que NO están en B
  Set<int> diferencia = A.difference(B);
  print('A - B = $diferencia');    // {1, 2}

  Set<int> diferenciaInversa = B.difference(A);
  print('B - A = $diferenciaInversa');  // {6, 7}

  // Ejemplo práctico: usuarios que tienen permiso A pero no permiso B
  Set<String> conLectura = {'ana', 'luis', 'carlos', 'maría'};
  Set<String> conEscritura = {'luis', 'carlos'};
  Set<String> soloLectura = conLectura.difference(conEscritura);
  print('\nUsuarios solo con lectura: $soloLectura');

  // ─────────────────────────────────────────────────────────────────────────
  // SET vs LIST — Cuándo usar cada uno
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Set vs List ---');

  // Usa LIST cuando:
  //   - El orden importa
  //   - Pueden haber duplicados
  //   - Necesitas acceso por índice
  //   - Construyes listas de widgets en Flutter

  // Usa SET cuando:
  //   - No pueden haber duplicados (IDs, etiquetas, permisos)
  //   - El orden no importa
  //   - Necesitas búsqueda rápida (contains es O(1) en Set, O(n) en List)
  //   - Necesitas operaciones de conjuntos (unión, intersección)

  // ─────────────────────────────────────────────────────────────────────────
  // CONVERTIR ENTRE LIST Y SET
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Conversiones ---');

  List<int> lista = [5, 3, 1, 3, 5, 2, 1];
  print('Lista original: $lista');

  // Lista → Set (elimina duplicados, pierde orden garantizado):
  Set<int> conjunto = lista.toSet();
  print('Como Set: $conjunto');

  // Set → Lista (recupera el acceso por índice):
  List<int> deVuelta = conjunto.toList();
  print('De vuelta a Lista: $deVuelta');

  // Truco para eliminar duplicados y volver a lista:
  List<int> sinDups = lista.toSet().toList();
  print('Lista sin duplicados: $sinDups');
}

// =============================================================================
// EXPERIMENTA:
//   1. Simula "etiquetas seleccionadas" en una app: agrega y quita etiquetas
//      de un Set y verifica que no haya duplicados.
//   2. Dado dos sets de amigos de dos personas, encuentra:
//      - Los amigos en común (intersección)
//      - Todos los amigos juntos (unión)
//      - Los amigos que solo tiene la primera persona (diferencia)
//   3. ¿Qué pasa si intentas acceder por índice a un Set: conjunto[0]?
//   4. Compara el rendimiento conceptual: si tienes 1 millón de IDs y
//      necesitas verificar si un ID existe, ¿usarías List o Set? ¿Por qué?
//   5. Crea un Set de permisosRequeridos y un Set de permisosDelUsuario.
//      Verifica si el usuario tiene TODOS los permisos requeridos usando
//      containsAll().
// =============================================================================
