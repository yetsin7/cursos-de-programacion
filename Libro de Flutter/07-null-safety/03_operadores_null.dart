// =============================================================================
// ARCHIVO: 03_operadores_null.dart
// TEMA: Operadores null-aware y cascades en Dart
// =============================================================================
//
// Dart ofrece un conjunto completo de operadores null-aware que permiten
// escribir código conciso y seguro cuando se trabaja con valores opcionales.
// Este archivo cubre todos ellos: ?., ??, ??=, ?.. y los cascades regulares.
//
// CÓMO EJECUTAR:
//   dart run 03_operadores_null.dart
//
// =============================================================================

// ────────────────────────────────────────────────────────────────────────────
// Clase auxiliar para demostrar cascades y operadores null-aware
// ────────────────────────────────────────────────────────────────────────────

/// Modelo de una lista de compras con operaciones mutables.
/// Usada para demostrar cascades (..) y null-aware cascades (?...).
class ListaCompras {
  // Nombre de la lista
  String nombre;
  // Elementos en la lista
  final List<String> items = [];
  // Indica si la lista está activa
  bool activa = true;

  /// Crea una lista con el [nombre] dado.
  ListaCompras(this.nombre);

  /// Agrega un [item] a la lista.
  void agregar(String item) => items.add(item);

  /// Marca la lista como completada.
  void completar() => activa = false;

  /// Devuelve una representación legible de la lista.
  @override
  String toString() => '$nombre: $items (activa: $activa)';
}

// ────────────────────────────────────────────────────────────────────────────
// 1. Operador ?. — Acceso null-aware
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra el operador ?. para acceso seguro a miembros.
void demoAccesoNullAware() {
  print('── ?. (null-aware member access) ──');

  String? texto = 'hola mundo';
  String? nulo = null;

  // ?. evalúa el lado izquierdo; si es null devuelve null sin lanzar excepción
  print(texto?.toUpperCase()); // HOLA MUNDO
  print(nulo?.toUpperCase());  // null

  // Encadenamiento: si cualquier parte es null, toda la expresión es null
  List<String>? lista = ['a', 'b', 'c'];
  List<String>? listaNula = null;

  print(lista?.first);     // a
  print(listaNula?.first); // null (sin RangeError)

  // ?. en llamadas a métodos
  print(lista?.contains('b'));     // true
  print(listaNula?.contains('b')); // null
}

// ────────────────────────────────────────────────────────────────────────────
// 2. Operador ?? — If-null (coalescencia null)
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra el operador ?? como mecanismo de valor por defecto.
void demoIfNull() {
  print('\n── ?? (if-null operator) ──');

  String? nombreUsuario = null;
  int? timeout = null;
  List<String>? etiquetas = null;

  // Si el lado izquierdo es null, usa el lado derecho
  String nombre = nombreUsuario ?? 'Invitado';
  int tiempoEspera = timeout ?? 30;
  List<String> tags = etiquetas ?? [];

  print('Nombre: $nombre');           // Invitado
  print('Timeout: $tiempoEspera s');  // 30
  print('Etiquetas: $tags');          // []

  // Encadenamiento de ??
  String? primerFallback = null;
  String? segundoFallback = null;
  String tercer = 'valor definitivo';

  print(primerFallback ?? segundoFallback ?? tercer);
  // valor definitivo

  // Combinado con ?. — patrón muy común en Flutter
  ListaCompras? lista = null;
  String info = lista?.nombre ?? 'Sin lista';
  print('Lista: $info'); // Sin lista
}

// ────────────────────────────────────────────────────────────────────────────
// 3. Operador ??= — Asignación null-aware
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra el operador ??= para asignar solo si la variable es null.
void demoAsignacionNullAware() {
  print('\n── ??= (null-aware assignment) ──');

  String? cache = null;

  // ??= asigna el valor SOLO si la variable actualmente ES null
  // Equivale a: cache = cache ?? 'valor calculado';
  cache ??= 'valor calculado';
  print('Cache: $cache'); // valor calculado

  // Segunda vez: ya tiene valor, NO se reasigna
  cache ??= 'otro valor';
  print('Cache: $cache'); // valor calculado (sin cambio)

  // Uso práctico: inicialización perezosa (lazy initialization)
  Map<String, List<int>> agrupados = {};

  void agregarAGrupo(String clave, int valor) {
    // Si la clave no existe, crear la lista; si existe, reusar
    agrupados[clave] ??= [];
    agrupados[clave]!.add(valor);
  }

  agregarAGrupo('pares', 2);
  agregarAGrupo('pares', 4);
  agregarAGrupo('impares', 1);
  agregarAGrupo('pares', 6);
  print('Agrupados: $agrupados');
  // {pares: [2, 4, 6], impares: [1]}
}

// ────────────────────────────────────────────────────────────────────────────
// 4. Cascades .. — Llamadas encadenadas sobre el MISMO objeto
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra los cascades (..) para encadenar operaciones sobre un objeto.
///
/// Un cascade (..) retorna el objeto RECEPTOR, no el resultado de la operación.
/// Esto permite encadenar múltiples llamadas sin variables intermedias.
void demoCascades() {
  print('\n── .. (cascade operator) ──');

  // Sin cascades: verbose y con variable intermedia
  ListaCompras lista1 = ListaCompras('Supermercado');
  lista1.agregar('leche');
  lista1.agregar('pan');
  lista1.agregar('huevos');
  print('Sin cascade: $lista1');

  // Con cascades: elegante, devuelve el mismo objeto
  ListaCompras lista2 = ListaCompras('Farmacia')
    ..agregar('aspirinas')
    ..agregar('vitamina C')
    ..agregar('vendas');
  print('Con cascade: $lista2');

  // También funciona con setters y métodos mixtos
  ListaCompras lista3 = ListaCompras('Temporal')
    ..nombre = 'Lista Semanal'   // Setter de propiedad
    ..agregar('arroz')
    ..agregar('frijoles')
    ..completar();               // Método void
  print('Con cascade mixto: $lista3');
}

// ────────────────────────────────────────────────────────────────────────────
// 5. Operador ?.. — Null-aware cascade
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra el null-aware cascade (?...) para cascades sobre objetos opcionales.
///
/// Si el objeto es null, todo el bloque de cascades se omite sin crash.
void demoNullAwareCascade() {
  print('\n── ?.. (null-aware cascade) ──');

  ListaCompras? listaActiva = ListaCompras('Activa');
  ListaCompras? listaNula = null;

  // Con lista activa: ejecuta todos los cascades normalmente
  listaActiva
    ?..agregar('tomates')
    ..agregar('cebollas')    // Los .. siguientes son seguros si el primero pasó
    ..agregar('ajo');
  print('Lista activa: $listaActiva');

  // Con lista null: todo el bloque se omite, sin NullPointerException
  listaNula
    ?..agregar('esto')
    ..agregar('no se ejecuta');
  print('Lista nula: $listaNula'); // null (sin crash)

  // Útil en Flutter para setState y controllers opcionales
  // animationController?..reset()..forward();
}

void main() {
  demoAccesoNullAware();
  demoIfNull();
  demoAsignacionNullAware();
  demoCascades();
  demoNullAwareCascade();

  print('\n── Resumen de operadores ──');
  print('?.   → acceso seguro: null si el receptor es null');
  print('??   → valor por defecto si es null');
  print('??=  → asignar solo si es null');
  print('..   → cascade: encadenar sin variable intermedia');
  print('?..  → cascade null-aware: omitir si el objeto es null');
}

// EXPERIMENTA:
//   - Crea una clase StringBuffer opcional y usa ?.. para agregar líneas
//   - Prueba ??= para implementar un singleton simple
//   - Encadena ?. con ?? para leer de un Map<String, String?> con fallback
//   - Usa .. en un List<int> para agregar y ordenar en una sola expresión
