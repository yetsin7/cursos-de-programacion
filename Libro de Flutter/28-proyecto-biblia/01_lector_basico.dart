// ============================================================
// MÓDULO 28 — Proyecto Biblia (Dart consola)
// Archivo: 01_lector_basico.dart
//
// DEPENDENCIA: sqlite3: ^2.x.x en pubspec.yaml
//              path: ^1.9.0 en pubspec.yaml
//
// Lector interactivo de la Biblia RV60 en consola.
// Permite leer versículos por referencia, capítulos completos
// y versículos aleatorios mediante un menú de consola.
//
// Ejecutar con:
//   dart run lib/01_lector_basico.dart
// ============================================================

import 'dart:io';
import 'dart:math';
import 'package:path/path.dart' as path;
import 'package:sqlite3/sqlite3.dart';

/// Expresión regular para eliminar marcas Strong del texto.
/// Captura cualquier etiqueta HTML-like: <S>123</S>, <pb/>, etc.
final RegExp _strongRegex = RegExp(r'<[^>]+>');

/// Generador de números aleatorios para el versículo del día.
final Random _random = Random();

void main() async {
  // Calcular ruta a la BD relativa al script
  final String scriptDir = path.dirname(Platform.script.toFilePath());
  final String dbPath =
      path.normalize(path.join(scriptDir, '..', '..', 'datos', 'biblia_rv60.sqlite3'));

  if (!File(dbPath).existsSync()) {
    print('ERROR: No se encontró la base de datos en:\n  $dbPath');
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
    await _menuPrincipal(db);
  } finally {
    db.dispose();
  }
}

/// Muestra el menú interactivo y procesa la opción del usuario.
/// El bucle continúa hasta que el usuario elige la opción 4 (Salir).
Future<void> _menuPrincipal(Database db) async {
  while (true) {
    print('\n╔══════════════════════════════════╗');
    print('║  BIBLIA RV60 — Lector de consola ║');
    print('╠══════════════════════════════════╣');
    print('║  1. Leer versículo  (ej: Jn 3:16)║');
    print('║  2. Leer capítulo completo        ║');
    print('║  3. Versículo aleatorio           ║');
    print('║  4. Salir                         ║');
    print('╚══════════════════════════════════╝');
    stdout.write('Opción: ');

    final entrada = stdin.readLineSync()?.trim() ?? '';

    switch (entrada) {
      case '1':
        await _opcionLeerVersiculo(db);
      case '2':
        await _opcionLeerCapitulo(db);
      case '3':
        _opcionVerSiculoAleatorio(db);
      case '4':
        print('\n¡Hasta luego!\n');
        return;
      default:
        print('Opción no válida. Intenta de nuevo.');
    }
  }
}

/// Pide al usuario una referencia (ej: "Juan 3:16") y la muestra.
Future<void> _opcionLeerVersiculo(Database db) async {
  stdout.write('\nNombre del libro (o abreviatura): ');
  final nombreLibro = stdin.readLineSync()?.trim() ?? '';
  if (nombreLibro.isEmpty) return;

  stdout.write('Capítulo: ');
  final capStr = stdin.readLineSync()?.trim() ?? '';
  stdout.write('Versículo: ');
  final verStr = stdin.readLineSync()?.trim() ?? '';

  final capitulo = int.tryParse(capStr);
  final versiculo = int.tryParse(verStr);

  if (capitulo == null || versiculo == null) {
    print('Error: capítulo y versículo deben ser números.');
    return;
  }

  final libro = _buscarLibro(db, nombreLibro);
  if (libro == null) {
    print('No se encontró el libro "$nombreLibro".');
    _sugerirLibros(db, nombreLibro);
    return;
  }

  final texto = _obtenerVersiculo(db, libro['book_number'] as int, capitulo, versiculo);
  if (texto == null) {
    print('No se encontró ${libro['long_name']} $capitulo:$versiculo');
    return;
  }

  print('\n─────────────────────────────────────');
  print('${libro['long_name']} $capitulo:$versiculo');
  print('─────────────────────────────────────');
  print(limpiarMarcas(texto));
}

/// Muestra todos los versículos de un capítulo con su numeración.
Future<void> _opcionLeerCapitulo(Database db) async {
  stdout.write('\nNombre del libro: ');
  final nombreLibro = stdin.readLineSync()?.trim() ?? '';
  if (nombreLibro.isEmpty) return;

  stdout.write('Capítulo: ');
  final capStr = stdin.readLineSync()?.trim() ?? '';
  final capitulo = int.tryParse(capStr ?? '');

  if (capitulo == null) {
    print('Error: el capítulo debe ser un número.');
    return;
  }

  final libro = _buscarLibro(db, nombreLibro);
  if (libro == null) {
    print('No se encontró el libro "$nombreLibro".');
    return;
  }

  final versiculos = _obtenerCapitulo(db, libro['book_number'] as int, capitulo);
  if (versiculos.isEmpty) {
    print('No se encontró ${libro['long_name']} capítulo $capitulo.');
    return;
  }

  print('\n══════════════════════════════════════');
  print('${libro['long_name'].toString().toUpperCase()} — CAPÍTULO $capitulo');
  print('══════════════════════════════════════');
  for (final v in versiculos) {
    final num = v['verse'].toString().padLeft(3);
    final texto = limpiarMarcas(v['text'].toString());
    print('$num  $texto');
  }
  print('──────────────────────────────────────');
  print('Total: ${versiculos.length} versículos');
}

/// Selecciona un versículo al azar de toda la Biblia y lo muestra.
void _opcionVerSiculoAleatorio(Database db) {
  // Obtener el total de versículos para generar un ROWID aleatorio
  final total = db.select('SELECT COUNT(*) AS n FROM verses').first['n'] as int;
  final offset = _random.nextInt(total);

  final resultado = db.select(
    'SELECT v.book_number, v.chapter, v.verse, v.text, b.long_name '
    'FROM verses v JOIN books b ON v.book_number = b.book_number '
    'LIMIT 1 OFFSET ?',
    [offset],
  );

  if (resultado.isEmpty) return;

  final fila = resultado.first;
  final texto = limpiarMarcas(fila['text'].toString());
  final referencia = '${fila['long_name']} ${fila['chapter']}:${fila['verse']}';

  print('\n╔══════════════════════════════════╗');
  print('║  VERSÍCULO ALEATORIO             ║');
  print('╚══════════════════════════════════╝');
  print(referencia);
  print('─────────────────────────────────────');
  print(texto);
}

/// Busca un libro por nombre completo o abreviatura (insensible a mayúsculas).
/// Retorna el primer libro que coincida, o null si no hay coincidencia.
Map<String, Object?>? _buscarLibro(Database db, String nombre) {
  final resultado = db.select(
    'SELECT book_number, short_name, long_name FROM books '
    'WHERE LOWER(long_name) LIKE LOWER(?) '
    '   OR LOWER(short_name) LIKE LOWER(?) '
    'LIMIT 1',
    ['%$nombre%', '%$nombre%'],
  );
  return resultado.isEmpty ? null : resultado.first;
}

/// Obtiene el texto de un versículo específico.
/// Retorna null si no existe esa referencia.
String? _obtenerVersiculo(Database db, int libro, int capitulo, int versiculo) {
  final resultado = db.select(
    'SELECT text FROM verses '
    'WHERE book_number = ? AND chapter = ? AND verse = ?',
    [libro, capitulo, versiculo],
  );
  return resultado.isEmpty ? null : resultado.first['text'] as String?;
}

/// Obtiene todos los versículos de un capítulo en orden.
List<Row> _obtenerCapitulo(Database db, int libro, int capitulo) {
  return db.select(
    'SELECT verse, text FROM verses '
    'WHERE book_number = ? AND chapter = ? '
    'ORDER BY verse ASC',
    [libro, capitulo],
  );
}

/// Sugiere libros que contengan el texto buscado en caso de no encontrar exacto.
void _sugerirLibros(Database db, String termino) {
  final sugerencias = db.select(
    'SELECT long_name FROM books WHERE LOWER(long_name) LIKE LOWER(?) LIMIT 5',
    ['%$termino%'],
  );
  if (sugerencias.isNotEmpty) {
    print('¿Quisiste decir?');
    for (final s in sugerencias) {
      print('  → ${s['long_name']}');
    }
  }
}

/// Elimina marcas Strong y etiquetas XML. Ej: "principio<S>7225</S>" → "principio"
String limpiarMarcas(String texto) => texto.replaceAll(_strongRegex, '').trim();
