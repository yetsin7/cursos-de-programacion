import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// Singleton que gestiona la conexión a la base de datos SQLite de la Biblia.
///
/// Se usa el patrón Singleton para garantizar que solo exista una instancia
/// de la base de datos abierta durante toda la vida de la app. Esto evita
/// conflictos de acceso concurrente y mejora el rendimiento.
///
/// La primera vez que se abre la app, el archivo SQLite se copia desde los
/// assets del proyecto al directorio de documentos del dispositivo, ya que
/// sqflite no puede leer directamente desde los assets de Flutter.
class DatabaseHelper {
  // ─── Singleton ────────────────────────────────────────────────────────────

  /// Instancia única de DatabaseHelper
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  /// Constructor privado para impedir instancias externas
  DatabaseHelper._internal();

  /// Punto de acceso global a la instancia
  factory DatabaseHelper() => _instance;

  // ─── Estado interno ───────────────────────────────────────────────────────

  /// Objeto Database de sqflite; null hasta la primera inicialización
  static Database? _database;

  /// Nombre del archivo SQLite en assets y en el dispositivo
  static const String _dbName = 'biblia_rv60.sqlite3';

  /// Ruta del asset tal como está declarada en pubspec.yaml
  static const String _assetPath = 'assets/biblia_rv60.sqlite3';

  // ─── Getter principal ─────────────────────────────────────────────────────

  /// Devuelve la instancia de Database, inicializándola si es necesario.
  ///
  /// Es seguro llamar a este getter múltiples veces: siempre devuelve
  /// la misma conexión reutilizada.
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  // ─── Inicialización ───────────────────────────────────────────────────────

  /// Inicializa la base de datos copiando el asset al dispositivo si es necesario.
  ///
  /// Retorna: instancia [Database] lista para usar.
  Future<Database> _initDatabase() async {
    // Obtiene el directorio de documentos del dispositivo
    final Directory docsDir = await getApplicationDocumentsDirectory();
    final String dbPath = join(docsDir.path, _dbName);

    // Si la BD no existe en el dispositivo, la copia desde los assets
    if (!File(dbPath).existsSync()) {
      await _copyDatabaseFromAssets(dbPath);
    }

    // Abre la base de datos en modo solo lectura (la Biblia no se modifica)
    return openDatabase(
      dbPath,
      readOnly: true,
      version: 1,
    );
  }

  /// Copia el archivo SQLite desde los assets de Flutter al sistema de archivos.
  ///
  /// [destinationPath]: ruta completa donde se guardará el archivo en el dispositivo.
  ///
  /// Este proceso es necesario porque sqflite no puede leer archivos directamente
  /// desde los assets de Flutter — requieren estar en el sistema de archivos real.
  Future<void> _copyDatabaseFromAssets(String destinationPath) async {
    // Carga el archivo binario desde los assets
    final ByteData data = await rootBundle.load(_assetPath);
    final List<int> bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );

    // Escribe los bytes en el directorio de documentos
    await File(destinationPath).writeAsBytes(bytes, flush: true);
  }

  // ─── Consultas de utilidad ────────────────────────────────────────────────

  /// Ejecuta una consulta SELECT y devuelve los resultados.
  ///
  /// [sql]: sentencia SQL con posibles marcadores de posición '?'.
  /// [args]: valores para los marcadores de posición.
  ///
  /// Retorna: lista de mapas con los resultados.
  Future<List<Map<String, dynamic>>> rawQuery(
    String sql, [
    List<dynamic>? args,
  ]) async {
    final db = await database;
    return db.rawQuery(sql, args);
  }
}
