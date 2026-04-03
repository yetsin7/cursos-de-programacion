// ============================================================
// MÓDULO 28 — Proyecto Biblia (Dart consola)
// Archivo: 03_estadisticas.dart
//
// DEPENDENCIA: sqlite3: ^2.x.x en pubspec.yaml
//              path: ^1.9.0 en pubspec.yaml
//
// Genera estadísticas textuales sobre la Biblia RV60:
//   - Versículos por libro (tabla ordenada)
//   - Libro con más y menos versículos
//   - Comparativa AT vs NT
//   - Las 20 palabras más frecuentes (sin stopwords)
//   - Distribución de una palabra por libros
//
// Ejecutar con:
//   dart run lib/03_estadisticas.dart
// ============================================================

import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:sqlite3/sqlite3.dart';

/// Expresión regular para limpiar marcas Strong.
final RegExp _strongRegex = RegExp(r'<[^>]+>');

/// Palabras muy frecuentes que no aportan significado semántico.
/// Se excluyen del análisis de frecuencia de palabras.
const Set<String> _stopwords = {
  'de', 'la', 'el', 'en', 'y', 'a', 'que', 'los', 'del', 'se',
  'las', 'por', 'un', 'una', 'con', 'no', 'al', 'su', 'lo', 'le',
  'me', 'te', 'si', 'más', 'o', 'es', 'era', 'fue', 'ser', 'sus',
  'para', 'como', 'ni', 'pero', 'son', 'yo', 'mi', 'tu',
};

/// Número máximo del último libro del AT.
const int _limiteAT = 39;

void main() {
  // Calcular ruta absoluta a la BD
  final String scriptDir = path.dirname(Platform.script.toFilePath());
  final String dbPath =
      path.normalize(path.join(scriptDir, '..', 'datos', 'biblia_rv60.sqlite3'));

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
    _menuEstadisticas(db);
  } finally {
    db.dispose();
  }
}

// ============================================================
// MENÚ
// ============================================================

/// Menú de estadísticas con cinco opciones de análisis.
void _menuEstadisticas(Database db) {
  while (true) {
    print('\n╔════════════════════════════════════╗');
    print('║  BIBLIA RV60 — Estadísticas        ║');
    print('╠════════════════════════════════════╣');
    print('║  1. Versículos por libro           ║');
    print('║  2. Libro con más/menos versículos ║');
    print('║  3. Comparativa AT vs NT           ║');
    print('║  4. Las 20 palabras más frecuentes ║');
    print('║  5. Distribución de una palabra    ║');
    print('║  6. Salir                          ║');
    print('╚════════════════════════════════════╝');
    stdout.write('Opción: ');

    final opcion = stdin.readLineSync()?.trim() ?? '';
    switch (opcion) {
      case '1':
        _verSiculosPorLibro(db);
      case '2':
        _libroExtremo(db);
      case '3':
        _comparativaAtNt(db);
      case '4':
        _palabrasFrecuentes(db);
      case '5':
        _distribucionPalabra(db);
      case '6':
        print('\n¡Hasta luego!\n');
        return;
      default:
        print('Opción no válida.');
    }
  }
}

// ============================================================
// ESTADÍSTICA 1 — Versículos por libro
// ============================================================

/// Muestra una tabla con la cantidad de versículos y capítulos por libro.
void _verSiculosPorLibro(Database db) {
  final resultado = db.select(
    'SELECT b.book_number, b.short_name, b.long_name, '
    '       COUNT(*) AS versiculos, '
    '       COUNT(DISTINCT v.chapter) AS capitulos '
    'FROM books b '
    'JOIN verses v ON b.book_number = v.book_number '
    'GROUP BY b.book_number '
    'ORDER BY b.book_number ASC',
  );

  print('\n N°  Abrev  Nombre                 Caps  Versículos');
  print(' ──  ─────  ─────────────────────  ────  ──────────');
  for (final f in resultado) {
    final num   = f['book_number'].toString().padLeft(3);
    final abrev = f['short_name'].toString().padRight(5);
    final nom   = f['long_name'].toString().padRight(22).substring(0, 22);
    final caps  = f['capitulos'].toString().padLeft(4);
    final vers  = f['versiculos'].toString().padLeft(10);
    print(' $num  $abrev  $nom  $caps  $vers');
  }
}

// ============================================================
// ESTADÍSTICA 2 — Libro extremo
// ============================================================

/// Muestra el libro con más versículos y el libro con menos versículos.
void _libroExtremo(Database db) {
  final sql = '''
    SELECT b.long_name, COUNT(*) AS total
    FROM verses v
    JOIN books b ON v.book_number = b.book_number
    GROUP BY v.book_number
    ORDER BY total %s
    LIMIT 1
  ''';

  final mayor = db.select(sql.replaceFirst('%s', 'DESC')).first;
  final menor = db.select(sql.replaceFirst('%s', 'ASC')).first;

  print('\n─── Libros extremos ───────────────────────────────');
  print('MÁS:   ${mayor['long_name']} (${mayor['total']} versículos)');
  print('MENOS: ${menor['long_name']} (${menor['total']} versículos)');
}

// ============================================================
// ESTADÍSTICA 3 — Comparativa AT vs NT
// ============================================================

/// Compara el AT y NT en libros, capítulos y versículos.
void _comparativaAtNt(Database db) {
  // Función local que obtiene estadísticas para un rango de libros
  Map<String, int> stats(int min, int max) => {
    'versiculos': db.select('SELECT COUNT(*) AS n FROM verses WHERE book_number BETWEEN ? AND ?', [min, max]).first['n'] as int,
    'capitulos':  db.select('SELECT COUNT(DISTINCT book_number||"-"||chapter) AS n FROM verses WHERE book_number BETWEEN ? AND ?', [min, max]).first['n'] as int,
    'libros':     db.select('SELECT COUNT(DISTINCT book_number) AS n FROM books WHERE book_number BETWEEN ? AND ?', [min, max]).first['n'] as int,
  };

  final at = stats(1, _limiteAT);
  final nt = stats(_limiteAT + 1, 66);
  final tot = stats(1, 66);

  void fila(String label, String campo) {
    print('║ ${label.padRight(12)}║${at[campo].toString().padLeft(8)} ║${nt[campo].toString().padLeft(8)} ║${tot[campo].toString().padLeft(8)} ║');
  }

  print('\n╔══════════════╦══════════╦══════════╦══════════╗');
  print('║              ║    AT    ║    NT    ║  TOTAL   ║');
  print('╠══════════════╬══════════╬══════════╬══════════╣');
  fila('Libros', 'libros');
  fila('Capítulos', 'capitulos');
  fila('Versículos', 'versiculos');
  print('╚══════════════╩══════════╩══════════╩══════════╝');

  final pct = (at['versiculos']! / tot['versiculos']! * 100).toStringAsFixed(1);
  print('\nEl AT representa el $pct% de todos los versículos.');
}

// ============================================================
// ESTADÍSTICA 4 — Palabras más frecuentes
// ============================================================

/// Extrae todos los versículos, tokeniza el texto y cuenta frecuencias.
/// Excluye stopwords y palabras de menos de 4 caracteres.
void _palabrasFrecuentes(Database db) {
  print('\nAnalizando frecuencia de palabras (puede tardar un momento)...');

  // Obtener todos los versículos de una sola consulta
  final versiculos = db.select('SELECT text FROM verses');

  final Map<String, int> frecuencias = {};
  final RegExp separador = RegExp(r'[^a-záéíóúüñA-ZÁÉÍÓÚÜÑ]+');

  for (final fila in versiculos) {
    final texto = _limpiarMarcas(fila['text'].toString()).toLowerCase();
    final palabras = texto.split(separador);
    for (final palabra in palabras) {
      if (palabra.length < 4) continue;
      if (_stopwords.contains(palabra)) continue;
      frecuencias[palabra] = (frecuencias[palabra] ?? 0) + 1;
    }
  }

  // Ordenar por frecuencia descendente y tomar el top 20
  final top20 = frecuencias.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  print('\n─── Top 20 palabras más frecuentes ────────────────');
  print(' Pos  Palabra                Ocurrencias');
  print(' ───  ─────────────────────  ───────────');
  for (int i = 0; i < 20 && i < top20.length; i++) {
    final pos  = (i + 1).toString().padLeft(4);
    final pal  = top20[i].key.padRight(22);
    final ocur = top20[i].value.toString().padLeft(11);
    print(' $pos  $pal  $ocur');
  }
}

// ============================================================
// ESTADÍSTICA 5 — Distribución de una palabra por libros
// ============================================================

/// Pide una palabra al usuario y muestra en qué libros aparece más.
void _distribucionPalabra(Database db) {
  stdout.write('\nPalabra a analizar: ');
  final palabra = stdin.readLineSync()?.trim() ?? '';
  if (palabra.isEmpty) return;

  final resultado = db.select(
    'SELECT b.long_name, COUNT(*) AS ocurrencias '
    'FROM verses v '
    'JOIN books b ON v.book_number = b.book_number '
    'WHERE LOWER(v.text) LIKE LOWER(?) '
    'GROUP BY v.book_number '
    'ORDER BY ocurrencias DESC '
    'LIMIT 10',
    ['%$palabra%'],
  );

  if (resultado.isEmpty) {
    print('No se encontró "$palabra" en ningún libro.');
    return;
  }

  final totalGlobal = db.select(
    'SELECT COUNT(*) AS n FROM verses WHERE LOWER(text) LIKE LOWER(?)',
    ['%$palabra%'],
  ).first['n'] as int;

  print('\n─── "$palabra": $totalGlobal versículos en total ───────────');
  print(' Pos  Libro                  Versículos');
  print(' ───  ─────────────────────  ──────────');
  for (int i = 0; i < resultado.length; i++) {
    final f    = resultado[i];
    final pos  = (i + 1).toString().padLeft(4);
    final nom  = f['long_name'].toString().padRight(22).substring(0, 22);
    final ocur = f['ocurrencias'].toString().padLeft(10);
    print(' $pos  $nom  $ocur');
  }
}

// ============================================================
// UTILIDADES
// ============================================================

/// Elimina marcas Strong y etiquetas del texto bíblico.
String _limpiarMarcas(String texto) =>
    texto.replaceAll(_strongRegex, '').trim();
