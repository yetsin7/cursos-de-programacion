// =============================================================================
// ARCHIVO: 03_sqflite_crud.dart
// TEMA: CRUD completo con sqflite — singleton, búsqueda, edición
// =============================================================================
// CÓMO USAR: copiar como lib/main.dart y ejecutar flutter run
// DEPENDENCIA: agregar en pubspec.yaml:
//   sqflite: ^2.3.3+1
//   path: ^1.9.0
// =============================================================================

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() => runApp(const AppSqfliteCrud());

// =============================================================================
// MODELO
// =============================================================================

/// Modelo de nota con soporte completo de serialización.
class Nota {
  final int? id;
  final String titulo;
  final String contenido;
  final DateTime fechaModificacion;

  const Nota({
    this.id,
    required this.titulo,
    required this.contenido,
    required this.fechaModificacion,
  });

  /// Serializa la nota para SQLite.
  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        'titulo': titulo,
        'contenido': contenido,
        'fecha_modificacion': fechaModificacion.toIso8601String(),
      };

  /// Deserializa una nota desde SQLite.
  factory Nota.fromMap(Map<String, dynamic> m) => Nota(
        id: m['id'] as int,
        titulo: m['titulo'] as String,
        contenido: m['contenido'] as String,
        fechaModificacion: DateTime.parse(m['fecha_modificacion'] as String),
      );

  /// Retorna una copia de la nota con campos actualizados.
  Nota copyWith({String? titulo, String? contenido}) => Nota(
        id: id,
        titulo: titulo ?? this.titulo,
        contenido: contenido ?? this.contenido,
        fechaModificacion: DateTime.now(),
      );
}

// =============================================================================
// DATABASE HELPER — patrón Singleton
// =============================================================================

/// Helper de base de datos implementado como Singleton.
/// El Singleton garantiza que solo existe una conexión a la base de datos.
class DatabaseHelper {
  // Instancia única (Singleton)
  static final DatabaseHelper _instancia = DatabaseHelper._interno();

  // Constructor de fábrica que siempre retorna la misma instancia
  factory DatabaseHelper() => _instancia;

  // Constructor privado para el Singleton
  DatabaseHelper._interno();

  static const _nombre = 'notas_crud.db';
  static const _tabla = 'notas';
  static const _version = 1;

  Database? _db;

  /// Acceso perezoso (lazy) a la base de datos.
  Future<Database> get db async {
    _db ??= await _inicializar();
    return _db!;
  }

  /// Crea la base de datos y sus tablas.
  Future<Database> _inicializar() async {
    final ruta = p.join(await getDatabasesPath(), _nombre);
    return openDatabase(
      ruta,
      version: _version,
      onCreate: (db, _) => db.execute('''
        CREATE TABLE $_tabla (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          titulo TEXT NOT NULL,
          contenido TEXT NOT NULL,
          fecha_modificacion TEXT NOT NULL
        )
      '''),
    );
  }

  // ─── CRUD Operations ────────────────────────────────────────────────────────

  /// Crea una nueva nota. Retorna el id generado.
  Future<int> crear(Nota nota) async {
    final database = await db;
    return database.insert(_tabla, nota.toMap());
  }

  /// Obtiene todas las notas, opcionalmente filtradas por búsqueda.
  /// Usa WHERE LIKE para búsqueda insensible a mayúsculas.
  Future<List<Nota>> leerTodas({String? busqueda}) async {
    final database = await db;

    if (busqueda != null && busqueda.isNotEmpty) {
      // LIKE con % busca el texto en cualquier posición del campo
      final mapas = await database.query(
        _tabla,
        where: 'titulo LIKE ? OR contenido LIKE ?',
        whereArgs: ['%$busqueda%', '%$busqueda%'],
        orderBy: 'fecha_modificacion DESC',
      );
      return mapas.map(Nota.fromMap).toList();
    }

    final mapas = await database.query(_tabla, orderBy: 'fecha_modificacion DESC');
    return mapas.map(Nota.fromMap).toList();
  }

  /// Actualiza una nota existente. Retorna filas afectadas.
  Future<int> actualizar(Nota nota) async {
    final database = await db;
    return database.update(
      _tabla,
      nota.toMap(),
      where: 'id = ?',
      whereArgs: [nota.id],
    );
  }

  /// Elimina una nota por id. Retorna filas eliminadas.
  Future<int> eliminar(int id) async {
    final database = await db;
    return database.delete(_tabla, where: 'id = ?', whereArgs: [id]);
  }
}

// =============================================================================
// APP
// =============================================================================

/// App raíz.
class AppSqfliteCrud extends StatelessWidget {
  const AppSqfliteCrud({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD sqflite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey)),
      home: const PantallaCrud(),
    );
  }
}

/// Pantalla CRUD con lista, búsqueda y acciones.
class PantallaCrud extends StatefulWidget {
  const PantallaCrud({super.key});

  @override
  State<PantallaCrud> createState() => _PantallaCrudState();
}

class _PantallaCrudState extends State<PantallaCrud> {
  final _helper = DatabaseHelper();
  final _busquedaCtrl = TextEditingController();
  List<Nota> _notas = [];
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  @override
  void dispose() {
    _busquedaCtrl.dispose();
    super.dispose();
  }

  /// Carga notas de la base de datos, aplicando el filtro de búsqueda si existe.
  Future<void> _cargar({String? busqueda}) async {
    setState(() => _cargando = true);
    _notas = await _helper.leerTodas(busqueda: busqueda);
    if (mounted) setState(() => _cargando = false);
  }

  /// Abre el formulario para crear o editar una nota.
  Future<void> _abrirFormulario({Nota? nota}) async {
    final resultado = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _FormularioNota(helper: _helper, nota: nota),
    );
    if (resultado == true) await _cargar(busqueda: _busquedaCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CRUD sqflite'), centerTitle: true),
      body: Column(
        children: [
          // Barra de búsqueda con búsqueda en tiempo real
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _busquedaCtrl,
              decoration: InputDecoration(
                hintText: 'Buscar notas...',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                isDense: true,
                suffixIcon: _busquedaCtrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _busquedaCtrl.clear();
                          _cargar();
                        },
                      )
                    : null,
              ),
              onChanged: (valor) => _cargar(busqueda: valor),
            ),
          ),

          Expanded(
            child: _cargando
                ? const Center(child: CircularProgressIndicator())
                : _notas.isEmpty
                    ? Center(
                        child: Text(
                          _busquedaCtrl.text.isNotEmpty
                              ? 'Sin resultados para "${_busquedaCtrl.text}"'
                              : 'Aún no tienes notas',
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: _notas.length,
                        itemBuilder: (_, i) {
                          final nota = _notas[i];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              title: Text(nota.titulo,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(nota.contenido,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                              onTap: () => _abrirFormulario(nota: nota),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    color: Colors.red),
                                onPressed: () async {
                                  await _helper.eliminar(nota.id!);
                                  await _cargar(
                                      busqueda: _busquedaCtrl.text);
                                },
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _abrirFormulario(),
        icon: const Icon(Icons.add),
        label: const Text('Nueva nota'),
      ),
    );
  }
}

/// Bottom sheet con formulario para crear o editar una nota.
class _FormularioNota extends StatefulWidget {
  final DatabaseHelper helper;
  final Nota? nota;

  const _FormularioNota({required this.helper, this.nota});

  @override
  State<_FormularioNota> createState() => _FormularioNotaState();
}

class _FormularioNotaState extends State<_FormularioNota> {
  late final TextEditingController _tituloCtrl;
  late final TextEditingController _contenidoCtrl;

  @override
  void initState() {
    super.initState();
    _tituloCtrl = TextEditingController(text: widget.nota?.titulo ?? '');
    _contenidoCtrl = TextEditingController(text: widget.nota?.contenido ?? '');
  }

  @override
  void dispose() {
    _tituloCtrl.dispose();
    _contenidoCtrl.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (_tituloCtrl.text.trim().isEmpty) return;

    if (widget.nota == null) {
      // Crear nueva nota
      await widget.helper.crear(Nota(
        titulo: _tituloCtrl.text.trim(),
        contenido: _contenidoCtrl.text.trim(),
        fechaModificacion: DateTime.now(),
      ));
    } else {
      // Actualizar nota existente
      await widget.helper.actualizar(
        widget.nota!.copyWith(
          titulo: _tituloCtrl.text.trim(),
          contenido: _contenidoCtrl.text.trim(),
        ),
      );
    }

    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16, right: 16, top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.nota == null ? 'Nueva nota' : 'Editar nota',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _tituloCtrl,
            decoration: const InputDecoration(
                labelText: 'Título', border: OutlineInputBorder()),
            autofocus: true,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _contenidoCtrl,
            maxLines: 4,
            decoration: const InputDecoration(
                labelText: 'Contenido', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _guardar,
              child: Text(widget.nota == null ? 'Crear' : 'Actualizar'),
            ),
          ),
        ],
      ),
    );
  }
}
