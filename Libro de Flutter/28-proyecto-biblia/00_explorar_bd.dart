// ============================================================
// MÓDULO 28 — Proyecto Biblia (Dart consola)
// Archivo: 00_explorar_bd.dart
//
// DEPENDENCIA: sqlite3: ^2.x.x en pubspec.yaml
//              path: ^1.9.0 en pubspec.yaml
//
// Propósito: explorar la estructura de la base de datos
// biblia_rv60.sqlite3 y verificar que está correctamente
// formada antes de operar sobre ella.
//
// Ejecutar con:
//   dart run lib/00_explorar_bd.dart
// ============================================================

import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:sqlite3/sqlite3.dart';

void main() async {
  // Calcular la ruta absoluta a la BD de forma portátil.
  // Platform.script devuelve la URI del script en ejecución.
  final String scriptDir =
      path.dirname(Platform.script.toFilePath());
  final String dbPath =
      path.join(scriptDir, '..', '..', 'datos', 'biblia_rv60.sqlite3');
  final String rutaAbsoluta = path.normalize(dbPath);

  print('=' * 55);
  print('  EXPLORADOR — Biblia Reina-Valera 1960');
  print('=' * 55);
  print('Ruta de la BD: $rutaAbsoluta\n');

  // Verificar que el archivo existe antes de intentar abrirlo.
  if (!File(rutaAbsoluta).existsSync()) {
    print('ERROR: No se encontró el archivo de base de datos.');
    print('Verifica que biblia_rv60.sqlite3 esté en:');
    print('  ${path.dirname(rutaAbsoluta)}');
    exit(1);
  }

  // Abrir la conexión. sqlite3.open() lanza SqliteException si hay error.
  late final Database db;
  try {
    db = sqlite3.open(rutaAbsoluta, mode: OpenMode.readOnly);
    print('Conexión exitosa a la base de datos.\n');
  } on SqliteException catch (e) {
    print('ERROR al abrir la BD: ${e.message}');
    exit(1);
  }

  try {
    _mostrarTablas(db);
    _mostrarConteos(db);
    _mostrarPrimerosCincoLibros(db);
    _mostrarUltimosCincoLibros(db);
    _mostrarInfoVersion(db);
    _mostrarEjemploVersiculo(db);
  } finally {
    // Siempre cerrar la conexión, incluso si hay error.
    db.dispose();
    print('\nConexión cerrada.');
  }
}

/// Muestra las tablas disponibles en la base de datos.
void _mostrarTablas(Database db) {
  print('── TABLAS EN LA BASE DE DATOS ──────────────────────');
  final resultado = db.select(
    "SELECT name, type FROM sqlite_master "
    "WHERE type IN ('table', 'view') ORDER BY name",
  );
  for (final fila in resultado) {
    print('  ${fila['type'].toString().toUpperCase().padRight(6)} → ${fila['name']}');
  }
  print('');
}

/// Muestra el conteo total de libros y versículos.
void _mostrarConteos(Database db) {
  print('── CONTEOS GENERALES ───────────────────────────────');

  final libros = db.select('SELECT COUNT(*) AS total FROM books');
  final versiculos = db.select('SELECT COUNT(*) AS total FROM verses');
  final capitulos = db.select(
    'SELECT COUNT(DISTINCT book_number || "-" || chapter) AS total FROM verses',
  );

  print('  Libros:     ${libros.first['total']}');
  print('  Capítulos:  ${capitulos.first['total']}');
  print('  Versículos: ${versiculos.first['total']}');
  print('');
}

/// Muestra los primeros 5 libros del Antiguo Testamento.
void _mostrarPrimerosCincoLibros(Database db) {
  print('── PRIMEROS 5 LIBROS (AT) ──────────────────────────');
  final resultado = db.select(
    'SELECT book_number, short_name, long_name FROM books '
    'ORDER BY book_number ASC LIMIT 5',
  );
  _imprimirTablaLibros(resultado);
  print('');
}

/// Muestra los últimos 5 libros del Nuevo Testamento.
void _mostrarUltimosCincoLibros(Database db) {
  print('── ÚLTIMOS 5 LIBROS (NT) ───────────────────────────');
  final resultado = db.select(
    'SELECT book_number, short_name, long_name FROM books '
    'ORDER BY book_number DESC LIMIT 5',
  );
  // Invertir para mostrar en orden ascendente
  final listaInvertida = resultado.reversed.toList();
  _imprimirTablaLibros(listaInvertida);
  print('');
}

/// Formatea e imprime una lista de filas de libros en tabla.
void _imprimirTablaLibros(List<Row> filas) {
  print('  N°   Abrev   Nombre');
  print('  ───  ──────  ──────────────────────');
  for (final fila in filas) {
    final num = fila['book_number'].toString().padLeft(3);
    final abrev = fila['short_name'].toString().padRight(6);
    final nombre = fila['long_name'].toString();
    print('  $num  $abrev  $nombre');
  }
}

/// Muestra las primeras 3 filas de la tabla info con metadatos de la versión.
void _mostrarInfoVersion(Database db) {
  print('── INFORMACIÓN DE LA VERSIÓN (tabla info) ──────────');
  final resultado = db.select('SELECT name, value FROM info LIMIT 3');
  for (final fila in resultado) {
    final nombre = fila['name'].toString().padRight(16);
    print('  $nombre → ${fila['value']}');
  }
  print('');
}

/// Muestra Juan 3:16 como ejemplo de versículo con marcas Strong.
void _mostrarEjemploVersiculo(Database db) {
  print('── EJEMPLO DE VERSÍCULO CON MARCAS STRONG ──────────');

  // Juan = libro 43 en la numeración estándar de esta BD
  final resultado = db.select(
    'SELECT v.text, b.long_name '
    'FROM verses v JOIN books b ON v.book_number = b.book_number '
    'WHERE v.book_number = 43 AND v.chapter = 3 AND v.verse = 16',
  );

  if (resultado.isEmpty) {
    print('  No se encontró el versículo.');
    return;
  }

  final textoOriginal = resultado.first['text'].toString();
  final textoLimpio = textoOriginal.replaceAll(RegExp(r'<[^>]+>'), '');
  final libro = resultado.first['long_name'].toString();

  print('  Referencia: $libro 3:16');
  print('  Con marcas: $textoOriginal');
  print('  Limpio:     $textoLimpio');
}
