// =============================================================================
// ARCHIVO: 02_mapas.dart
// TEMA: Map<K,V> en Dart
// EJECUCION: dart run 02_mapas.dart
// =============================================================================
//
// Un Map relaciona una clave con un valor.
// Es ideal cuando no buscas datos por posicion, sino por nombre o identificador.
// En Flutter aparece mucho con JSON, configuraciones y parametros.
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // CREAR MAPAS
  // ─────────────────────────────────────────────────────────────────────────

  print('--- Crear mapas ---');

  // Dart puede inferir el tipo desde el contenido inicial.
  var capitales = {
    'Nicaragua': 'Managua',
    'México': 'Ciudad de México',
    'España': 'Madrid',
  };
  print('capitales: $capitales');
  print('tipo: ${capitales.runtimeType}'); // _Map<String, String>

  // Tambien puedes declarar el tipo explicitamente.
  Map<String, int> edades = {'Ana': 28, 'Luis': 34, 'María': 22};
  print('edades: $edades');

  // Un mapa vacio conviene tiparlo para mantener claridad.
  Map<String, double> precios = {};
  print('vacío: $precios');

  // Map.fromIterables combina dos listas relacionadas.
  var claves = ['uno', 'dos', 'tres'];
  var valores = [1, 2, 3];
  var mapa = Map.fromIterables(claves, valores);
  print('desde listas: $mapa');

  // ─────────────────────────────────────────────────────────────────────────
  // ACCESO A VALORES
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Acceso ---');

  // Acceder con [] devuelve null si la clave no existe.
  print('Capital de Nicaragua: ${capitales["Nicaragua"]}');
  print('Capital de "???": ${capitales["País inexistente"]}');  // null

  // ?? ayuda a dar un valor por defecto.
  String capital = capitales['Argentina'] ?? 'Desconocida';
  print('Capital de Argentina: $capital');

  // containsKey permite validar antes de leer.
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

  // addAll mezcla entradas de otro mapa.
  // Si hay claves repetidas, el nuevo valor reemplaza al anterior.
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

  // entries permite recorrer clave y valor juntos.
  for (var entrada in puntuaciones.entries) {
    print('${entrada.key}: ${entrada.value} puntos');
  }

  // forEach es otra forma clara de recorrer un mapa.
  puntuaciones.forEach((jugador, pts) => print('  $jugador → $pts'));

  // keys y values permiten acceder a cada lado por separado.
  print('Claves: ${puntuaciones.keys.toList()}');
  print('Valores: ${puntuaciones.values.toList()}');

  // ─────────────────────────────────────────────────────────────────────────
  // TRANSFORMAR MAPAS
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Transformar ---');

  // map transforma las entradas y devuelve otro mapa.
  var puntuacionesDobles = puntuaciones.map(
    (jugador, pts) => MapEntry(jugador, pts * 2),
  );
  print('Puntos dobles: $puntuacionesDobles');

  // Para filtrar se trabaja sobre entries.
  var altosPuntos = Map.fromEntries(
    puntuaciones.entries.where((e) => e.value >= 1000),
  );
  print('Solo ≥ 1000: $altosPuntos');

  // ─────────────────────────────────────────────────────────────────────────
  // MAPAS ANIDADOS
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Mapas anidados ---');

  // Un patron comun es anidar mapas y listas como si fueran JSON.
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

  // El acceso anidado exige cuidado con los tipos.
  String ciudad = (usuario['direccion'] as Map)['ciudad'];
  print('Ciudad: $ciudad');

  List<String> roles = List<String>.from(usuario['roles']);
  print('Roles: $roles');

  // Verificar antes de entrar mas profundo evita errores.
  var dir = usuario['direccion'];
  if (dir is Map) {
    print('País: ${dir["pais"]}');
  }
}

// =============================================================================
// QUE DEBERIAS ENTENDER AL TERMINAR
// - Map relaciona claves unicas con valores.
// - Es mejor que List cuando buscas por nombre o identificador.
// - containsKey, entries y addAll son herramientas muy utiles.
// - Los mapas anidados aparecen mucho al trabajar con JSON.
//
// PRACTICA GUIADA
// 1. Crea un mapa de frecuencias.
// 2. Invierte un mapa simple.
// 3. Filtra entradas por valor.
// 4. Explica cuando conviene usar Map en vez de List.
// =============================================================================
