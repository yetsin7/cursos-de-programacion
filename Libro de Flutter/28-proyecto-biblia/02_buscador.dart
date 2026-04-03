// ============================================================
// MÓDULO 28 — Proyecto Biblia (Dart consola)
// Archivo: 02_buscador.dart
//
// DEPENDENCIA: sqlite3: ^2.x.x en pubspec.yaml
//              path: ^1.9.0 en pubspec.yaml
//
// Motor de búsqueda de texto para la Biblia RV60.
// Permite buscar palabras o frases en todo el texto bíblico
// con paginación, estadísticas y filtro por AT/NT.
//
// Ejecutar con:
//   dart run lib/02_buscador.dart
// ============================================================

import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:sqlite3/sqlite3.dart';

/// Expresión regular para limpiar marcas Strong del texto.
final RegExp _strongRegex = RegExp(r'<[^>]+>');

/// Número de resultados por página en la paginación.
const int _resultadosPorPagina = 10;

/// Límite máximo del Antiguo Testamento (libros 1–39).
const int _limiteAT = 39;

void main() async {
  // Calcular ruta absoluta a la BD
  final String scriptDir = path.dirname(Platform.script.toFilePath());
  final String dbPath =
      path.normalize(path.join(scriptDir, '..', 'datos', 'biblia_rv60.sqlite3'));

  if (!File(dbPath).existsSync()) {
    print('ERROR: Base de datos no encontrada en:\n  $dbPath');
    exit(1);
  }

  late final Database db;
  try {
    db = sqlite3.open(dbPath, mode: OpenMode.readOnly);
  } on SqliteException catch (e) {
    print('ERROR al abrir la BD: ${e.message}');
    exit(1);
  }

  try {
    await _menuBuscador(db);
  } finally {
    db.dispose();
  }
}

// ============================================================
// MENÚ DEL BUSCADOR
// ============================================================

/// Menú principal del buscador con cuatro modos de búsqueda.
Future<void> _menuBuscador(Database db) async {
  while (true) {
    print('\n╔═══════════════════════════════════╗');
    print('║  BIBLIA RV60 — Buscador de texto  ║');
    print('╠═══════════════════════════════════╣');
    print('║  1. Buscar en toda la Biblia       ║');
    print('║  2. Buscar solo en el AT           ║');
    print('║  3. Buscar solo en el NT           ║');
    print('║  4. Salir                          ║');
    print('╚═══════════════════════════════════╝');
    stdout.write('Opción: ');

    final opcion = stdin.readLineSync()?.trim() ?? '';
    if (opcion == '4') {
      print('\n¡Hasta luego!\n');
      return;
    }

    if (!['1', '2', '3'].contains(opcion)) {
      print('Opción no válida.');
      continue;
    }

    stdout.write('\nTérmino de búsqueda: ');
    final termino = stdin.readLineSync()?.trim() ?? '';
    if (termino.isEmpty) continue;

    // Determinar el filtro de testamento
    int? libroMin;
    int? libroMax;
    String etiquetaTestamento = 'toda la Biblia';
    if (opcion == '2') {
      libroMax = _limiteAT;
      etiquetaTestamento = 'el Antiguo Testamento';
    } else if (opcion == '3') {
      libroMin = _limiteAT + 1;
      etiquetaTestamento = 'el Nuevo Testamento';
    }

    await _ejecutarBusqueda(db, termino, etiquetaTestamento, libroMin, libroMax);
  }
}

// ============================================================
// LÓGICA DE BÚSQUEDA Y PAGINACIÓN
// ============================================================

/// Ejecuta la búsqueda y muestra los resultados con paginación.
///
/// [termino]            → palabra o frase a buscar
/// [etiquetaTestamento] → texto para el encabezado ("AT", "NT", "toda la Biblia")
/// [libroMin]           → número de libro mínimo (null = sin límite inferior)
/// [libroMax]           → número de libro máximo (null = sin límite superior)
Future<void> _ejecutarBusqueda(
  Database db,
  String termino,
  String etiquetaTestamento, [
  int? libroMin,
  int? libroMax,
]) async {
  // Construir la cláusula WHERE dinámicamente
  final condiciones = <String>['v.text LIKE ?'];
  final parametros = <Object?>['%$termino%'];

  if (libroMin != null) {
    condiciones.add('v.book_number >= ?');
    parametros.add(libroMin);
  }
  if (libroMax != null) {
    condiciones.add('v.book_number <= ?');
    parametros.add(libroMax);
  }

  final where = condiciones.join(' AND ');

  // Obtener el total de resultados para estadísticas
  final totalResultado = db.select(
    'SELECT COUNT(*) AS n FROM verses v WHERE $where',
    parametros,
  );
  final totalVersiculos = totalResultado.first['n'] as int;

  if (totalVersiculos == 0) {
    print('\nNo se encontró "$termino" en $etiquetaTestamento.');
    return;
  }

  // Contar en cuántos libros distintos aparece el término
  final librosResultado = db.select(
    'SELECT COUNT(DISTINCT v.book_number) AS n FROM verses v WHERE $where',
    parametros,
  );
  final totalLibros = librosResultado.first['n'] as int;

  // Mostrar encabezado de estadísticas
  print('\n═══════════════════════════════════════════════');
  print('Búsqueda: "$termino" en $etiquetaTestamento');
  print('Resultados: $totalVersiculos versículos en $totalLibros libros');
  print('═══════════════════════════════════════════════');

  // Paginar resultados
  int offset = 0;
  while (offset < totalVersiculos) {
    final pagina = _obtenerPagina(db, where, parametros, offset);
    _mostrarPagina(pagina, offset + 1, termino);

    offset += _resultadosPorPagina;
    if (offset >= totalVersiculos) break;

    final restantes = totalVersiculos - offset;
    print('\n[Mostrando ${min(offset, totalVersiculos)} de $totalVersiculos]');
    stdout.write('¿Ver más resultados? ($restantes restantes) [s/N]: ');
    final respuesta = stdin.readLineSync()?.trim().toLowerCase() ?? '';
    if (respuesta != 's') break;
  }

  // Mostrar resumen por libros
  _mostrarResumenPorLibros(db, where, parametros);
}

/// Obtiene una página de resultados con los datos completos de referencia.
List<Row> _obtenerPagina(
  Database db,
  String where,
  List<Object?> parametros,
  int offset,
) {
  return db.select(
    'SELECT b.long_name, v.chapter, v.verse, v.text '
    'FROM verses v '
    'JOIN books b ON v.book_number = b.book_number '
    'WHERE $where '
    'ORDER BY v.book_number, v.chapter, v.verse '
    'LIMIT ? OFFSET ?',
    [...parametros, _resultadosPorPagina, offset],
  );
}

/// Muestra una página de resultados con el término resaltado por contexto.
/// [inicio] → número del primer versículo en esta página (para numeración).
void _mostrarPagina(List<Row> pagina, int inicio, String termino) {
  for (int i = 0; i < pagina.length; i++) {
    final fila = pagina[i];
    final num = (inicio + i).toString().padLeft(4);
    final referencia =
        '${fila['long_name']} ${fila['chapter']}:${fila['verse']}';
    final texto = _limpiarMarcas(fila['text'].toString());
    print('\n$num. $referencia');
    print('     $texto');
  }
}

/// Muestra los 5 libros con más apariciones del término buscado.
void _mostrarResumenPorLibros(
  Database db,
  String where,
  List<Object?> parametros,
) {
  final resultado = db.select(
    'SELECT b.long_name, COUNT(*) AS ocurrencias '
    'FROM verses v '
    'JOIN books b ON v.book_number = b.book_number '
    'WHERE $where '
    'GROUP BY v.book_number '
    'ORDER BY ocurrencias DESC '
    'LIMIT 5',
    parametros,
  );

  print('\n─── Top 5 libros con más ocurrencias ───');
  for (int i = 0; i < resultado.length; i++) {
    final fila = resultado[i];
    final pos = (i + 1).toString().padLeft(2);
    final nombre = fila['long_name'].toString().padRight(20);
    print('  $pos. $nombre ${fila['ocurrencias']} veces');
  }
}

// ============================================================
// UTILIDADES
// ============================================================

/// Elimina marcas Strong y etiquetas del texto del versículo.
String _limpiarMarcas(String texto) =>
    texto.replaceAll(_strongRegex, '').trim();

/// Devuelve el mínimo entre dos enteros.
int min(int a, int b) => a < b ? a : b;
