// =============================================================================
// ARCHIVO: 02_sqflite_intro.dart
// TEMA: Base de datos SQL local con sqflite — introducción
// =============================================================================
// CÓMO USAR: copiar como lib/main.dart y ejecutar flutter run
// DEPENDENCIA: agregar en pubspec.yaml:
//   sqflite: ^2.3.3+1
//   path: ^1.9.0
// =============================================================================

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() => runApp(const AppSqfliteIntro());

// =============================================================================
// CAPA DE DATOS — acceso a la base de datos
// =============================================================================

/// Modelo de una nota simple.
class Nota {
  final int? id;
  final String titulo;
  final String contenido;
  final DateTime fechaCreacion;

  const Nota({
    this.id,
    required this.titulo,
    required this.contenido,
    required this.fechaCreacion,
  });

  /// Convierte la nota a un mapa para insertar en SQLite.
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'titulo': titulo,
      'contenido': contenido,
      // SQLite no tiene tipo DateTime — se guarda como texto ISO 8601
      'fecha_creacion': fechaCreacion.toIso8601String(),
    };
  }

  /// Crea una nota desde un mapa de SQLite.
  factory Nota.fromMap(Map<String, dynamic> mapa) {
    return Nota(
      id: mapa['id'] as int,
      titulo: mapa['titulo'] as String,
      contenido: mapa['contenido'] as String,
      fechaCreacion: DateTime.parse(mapa['fecha_creacion'] as String),
    );
  }
}

/// Servicio de acceso a la base de datos de notas.
class NotaDatabase {
  static const _nombreArchivo = 'notas.db';
  static const _nombreTabla = 'notas';
  static const _version = 1;

  Database? _db;

  /// Abre o crea la base de datos.
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _abrirDB();
    return _db!;
  }

  /// Inicializa la base de datos y crea las tablas si no existen.
  Future<Database> _abrirDB() async {
    // getDatabasesPath() retorna la ruta del directorio de bases de datos
    final directorio = await getDatabasesPath();
    final ruta = p.join(directorio, _nombreArchivo);

    return openDatabase(
      ruta,
      version: _version,
      // onCreate se ejecuta solo la primera vez que se crea la base de datos
      onCreate: (db, version) async {
        // INTEGER PRIMARY KEY es autoincrement en SQLite
        await db.execute('''
          CREATE TABLE $_nombreTabla (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT NOT NULL,
            contenido TEXT NOT NULL,
            fecha_creacion TEXT NOT NULL
          )
        ''');
      },
    );
  }

  /// Inserta una nota y retorna el id asignado.
  Future<int> insertar(Nota nota) async {
    final db = await database;
    // insert() retorna el rowid de la fila insertada
    return db.insert(_nombreTabla, nota.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Retorna todas las notas ordenadas por fecha.
  Future<List<Nota>> obtenerTodas() async {
    final db = await database;
    // query() es el método de alto nivel para SELECT
    final mapas = await db.query(_nombreTabla, orderBy: 'fecha_creacion DESC');
    return mapas.map(Nota.fromMap).toList();
  }

  /// Actualiza una nota existente.
  Future<void> actualizar(Nota nota) async {
    final db = await database;
    // update() retorna el número de filas afectadas
    await db.update(
      _nombreTabla,
      nota.toMap(),
      // WHERE con parámetros seguros (evita inyección SQL)
      where: 'id = ?',
      whereArgs: [nota.id],
    );
  }

  /// Elimina una nota por su id.
  Future<void> eliminar(int id) async {
    final db = await database;
    await db.delete(_nombreTabla, where: 'id = ?', whereArgs: [id]);
  }

  /// Ejemplo de rawQuery — SQL directo para consultas complejas.
  Future<int> contarNotas() async {
    final db = await database;
    final resultado = await db.rawQuery('SELECT COUNT(*) as total FROM $_nombreTabla');
    return Sqflite.firstIntValue(resultado) ?? 0;
  }
}

// =============================================================================
// APP Y PANTALLA
// =============================================================================

/// App raíz.
class AppSqfliteIntro extends StatelessWidget {
  const AppSqfliteIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sqflite Intro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown)),
      home: const PantallaNotas(),
    );
  }
}

/// Pantalla de notas con operaciones CRUD básicas.
class PantallaNotas extends StatefulWidget {
  const PantallaNotas({super.key});

  @override
  State<PantallaNotas> createState() => _PantallaNotasState();
}

class _PantallaNotasState extends State<PantallaNotas> {
  final _db = NotaDatabase();
  List<Nota> _notas = [];
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarNotas();
  }

  /// Carga todas las notas desde la base de datos.
  Future<void> _cargarNotas() async {
    setState(() => _cargando = true);
    _notas = await _db.obtenerTodas();
    if (mounted) setState(() => _cargando = false);
  }

  /// Abre el diálogo para agregar una nueva nota.
  void _mostrarDialogoAgregar() {
    final tituloCtrl = TextEditingController();
    final contenidoCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nueva nota'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: tituloCtrl,
                decoration: const InputDecoration(labelText: 'Título')),
            const SizedBox(height: 8),
            TextField(controller: contenidoCtrl, maxLines: 3,
                decoration: const InputDecoration(labelText: 'Contenido')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () async {
              if (tituloCtrl.text.isNotEmpty) {
                await _db.insertar(Nota(
                  titulo: tituloCtrl.text,
                  contenido: contenidoCtrl.text,
                  fechaCreacion: DateTime.now(),
                ));
                if (ctx.mounted) Navigator.pop(ctx);
                await _cargarNotas();
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notas (sqflite)'),
        centerTitle: true,
      ),
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : _notas.isEmpty
              ? const Center(child: Text('No hay notas. Agrega una.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _notas.length,
                  itemBuilder: (_, i) {
                    final nota = _notas[i];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(nota.titulo,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(nota.contenido,
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () async {
                            await _db.eliminar(nota.id!);
                            await _cargarNotas();
                          },
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarDialogoAgregar,
        child: const Icon(Icons.add),
      ),
    );
  }
}
