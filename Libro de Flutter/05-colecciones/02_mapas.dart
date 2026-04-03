// =============================================================================
// ARCHIVO: 02_mapas.dart
// TEMA: Map<K,V> en Dart — pares clave-valor
// =============================================================================
//
// Map es el equivalente al "dict" de Python. Almacena pares clave-valor donde
// las claves son únicas. En Flutter los Maps son fundamentales para manejar
// JSON de APIs, configuraciones, parámetros de rutas y datos estructurados.
//
// CÓMO EJECUTAR:
//   dart run 02_mapas.dart
//
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // CREAR MAPAS
  // ─────────────────────────────────────────────────────────────────────────

  print('--- Crear mapas ---');

  // Mapa con contenido inicial (tipo inferido):
  var capitales = {
    'Nicaragua': 'Managua',
    'México': 'Ciudad de México',
    'España': 'Madrid',
  };
  print('capitales: $capitales');
  print('tipo: ${capitales.runtimeType}'); // _Map<String, String>

  // Mapa con tipo explícito:
  Map<String, int> edades = {'Ana': 28, 'Luis': 34, 'María': 22};
  print('edades: $edades');

  // Mapa vacío:
  Map<String, double> precios = {};
  print('vacío: $precios');

  // Crear mapa a partir de listas usando Map.fromIterables():
  var claves = ['uno', 'dos', 'tres'];
  var valores = [1, 2, 3];
  var mapa = Map.fromIterables(claves, valores);
  print('desde listas: $mapa');

  // ─────────────────────────────────────────────────────────────────────────
  // ACCESO A VALORES
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Acceso ---');

  // Acceso con [] — devuelve null si la clave no existe (NO lanza error):
  print('Capital de Nicaragua: ${capitales["Nicaragua"]}');
  print('Capital de "???": ${capitales["País inexistente"]}');  // null

  // Acceso seguro con valor por defecto usando ??:
  String capital = capitales['Argentina'] ?? 'Desconocida';
  print('Capital de Argentina: $capital');

  // Verificar si una clave existe ANTES de acceder:
  if (capitales.containsKey('España')) {
    print('España está en el mapa: ${capitales["España"]}');
  }

  // ─────────────────────────────────────────────────────────────────────────
  // AGREGAR, MODIFICAR Y ELIMINAR
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Modificar ---');

  var config = <String, dynamic>{
    'idioma': 'es',
    'tema': 'claro',
  };

  config['idioma'] = 'en';          // Modificar existente
  config['fuente'] = 'Roboto';      // Agregar nueva clave
  config['tamaño'] = 16;
  print('config actualizado: $config');

  config.remove('tamaño');          // Eliminar por clave
  print('después de remove: $config');

  // addAll: agregar todas las entradas de otro mapa
  // Si hay claves duplicadas, las del nuevo mapa REEMPLAZAN a las originales
  config.addAll({'region': 'NI', 'tema': 'oscuro'});
  print('después de addAll: $config');

  // ─────────────────────────────────────────────────────────────────────────
  // ITERAR SOBRE UN MAPA
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Iterar ---');

  Map<String, int> puntuaciones = {
    'Jugador A': 1500,
    'Jugador B': 890,
    'Jugador C': 2100,
  };

  // Iterar sobre entradas (MapEntry tiene .key y .value):
  for (var entrada in puntuaciones.entries) {
    print('${entrada.key}: ${entrada.value} puntos');
  }

  // forEach con dos parámetros (más limpio):
  puntuaciones.forEach((jugador, pts) => print('  $jugador → $pts'));

  // Solo claves o solo valores:
  print('Claves: ${puntuaciones.keys.toList()}');
  print('Valores: ${puntuaciones.values.toList()}');

  // ─────────────────────────────────────────────────────────────────────────
  // TRANSFORMAR MAPAS
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Transformar ---');

  // map() en un Map transforma cada MapEntry:
  var puntuacionesDobles = puntuaciones.map(
    (jugador, pts) => MapEntry(jugador, pts * 2),
  );
  print('Puntos dobles: $puntuacionesDobles');

  // Filtrar entradas (no hay .where() directo, se usa entries.where()):
  var altosPuntos = Map.fromEntries(
    puntuaciones.entries.where((e) => e.value >= 1000),
  );
  print('Solo ≥ 1000: $altosPuntos');

  // ─────────────────────────────────────────────────────────────────────────
  // MAPAS ANIDADOS — JSON-like
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Mapas anidados ---');

  // Los mapas pueden contener otros mapas — patrón común con JSON:
  Map<String, dynamic> usuario = {
    'nombre': 'Carlos',
    'edad': 30,
    'direccion': {
      'ciudad': 'Managua',
      'pais': 'Nicaragua',
      'codigo': '14000',
    },
    'roles': ['usuario', 'editor'],
  };

  // Acceso anidado:
  String ciudad = (usuario['direccion'] as Map)['ciudad'];
  print('Ciudad: $ciudad');

  List<String> roles = List<String>.from(usuario['roles']);
  print('Roles: $roles');

  // Verificar antes de acceder a niveles profundos:
  var dir = usuario['direccion'];
  if (dir is Map) {
    print('País: ${dir["pais"]}');
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Crea un Map de frecuencias: dado ['a','b','a','c','b','a'],
//      construye {'a': 3, 'b': 2, 'c': 1} con un bucle y ??=.
//   2. Invierte un mapa: dado {1: 'uno', 2: 'dos'}, crea {'uno': 1, 'dos': 2}.
//   3. Ordena un mapa por valor (descendente) usando entries + sort.
//   4. Simula un "caché" con Map: guarda resultados de funciones y
//      busca en el mapa antes de calcular.
//   5. Convierte un Map<String, int> a JSON-like String manualmente:
//      {"a": 1, "b": 2} usando entries y map().join().
// =============================================================================
