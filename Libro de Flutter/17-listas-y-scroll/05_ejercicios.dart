// =============================================================================
// ARCHIVO: 05_ejercicios.dart
// TEMA: Ejercicios de práctica — Listas y Scroll
// =============================================================================
//
// Tres ejercicios para practicar listas: galería de imágenes con GridView,
// lista con búsqueda en tiempo real y lista con elementos deslizables (dismiss).
//
// CÓMO USAR:
//   1. Crea un proyecto Flutter: flutter create mi_app
//   2. Reemplaza lib/main.dart con este archivo
//   3. Ejecuta: flutter run
//
// =============================================================================
import 'package:flutter/material.dart';

void main() => runApp(const MiApp());

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicios Listas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: const PantallaMenu(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// MENÚ PRINCIPAL
// ────────────────────────────────────────────────────────────────────────────

/// Menú de selección de ejercicios.
class PantallaMenu extends StatelessWidget {
  const PantallaMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicios — Módulo 17'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Opcion(
            titulo: 'Galería con GridView',
            descripcion: 'Cuadrícula de imágenes con colores',
            icono: Icons.grid_view,
            destino: const _EjercicioGaleria(),
          ),
          const SizedBox(height: 12),
          _Opcion(
            titulo: 'Lista con búsqueda',
            descripcion: 'Filtrar una lista en tiempo real',
            icono: Icons.search,
            destino: const _EjercicioBusqueda(),
          ),
          const SizedBox(height: 12),
          _Opcion(
            titulo: 'Lista con Dismissible',
            descripcion: 'Deslizar para eliminar o archivar',
            icono: Icons.swipe,
            destino: const _EjercicioDismissible(),
          ),
        ],
      ),
    );
  }
}

class _Opcion extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final IconData icono;
  final Widget destino;

  const _Opcion({
    required this.titulo,
    required this.descripcion,
    required this.icono,
    required this.destino,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icono, color: Theme.of(context).colorScheme.primary),
        title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(descripcion),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => destino),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 1 — GALERÍA CON GRIDVIEW
// ────────────────────────────────────────────────────────────────────────────

/// Galería de colores con GridView.builder.
///
/// OBJETIVO: Cuadrícula de 3 columnas con tarjetas de color.
/// Al tocar una tarjeta muestra un SnackBar con el nombre del color.
class _EjercicioGaleria extends StatelessWidget {
  const _EjercicioGaleria();

  static const _colores = [
    ('Rojo', Color(0xFFE53935)),
    ('Rosa', Color(0xFFD81B60)),
    ('Púrpura', Color(0xFF8E24AA)),
    ('Índigo', Color(0xFF3949AB)),
    ('Azul', Color(0xFF1E88E5)),
    ('Cian', Color(0xFF00ACC1)),
    ('Verde', Color(0xFF43A047)),
    ('Lima', Color(0xFF7CB342)),
    ('Amarillo', Color(0xFFFDD835)),
    ('Naranja', Color(0xFFFB8C00)),
    ('Profundo Naranja', Color(0xFFF4511E)),
    ('Marrón', Color(0xFF6D4C41)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Galería de Colores')),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: _colores.length,
        itemBuilder: (context, index) {
          final color = _colores[index];
          return InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Color: ${color.$1}'),
                  backgroundColor: color.$2,
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: color.$2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  color.$1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 2 — LISTA CON BÚSQUEDA EN TIEMPO REAL
// ────────────────────────────────────────────────────────────────────────────

/// Lista de países con filtrado en tiempo real.
///
/// OBJETIVO: TextField en la parte superior que filtra la lista
/// mientras el usuario escribe.
class _EjercicioBusqueda extends StatefulWidget {
  const _EjercicioBusqueda();

  @override
  State<_EjercicioBusqueda> createState() => _EjercicioBusquedaState();
}

class _EjercicioBusquedaState extends State<_EjercicioBusqueda> {
  final _controller = TextEditingController();
  String _busqueda = '';

  static const _paises = [
    'Argentina', 'Bolivia', 'Chile', 'Colombia', 'Costa Rica',
    'Cuba', 'Ecuador', 'El Salvador', 'España', 'Guatemala',
    'Honduras', 'México', 'Nicaragua', 'Panamá', 'Paraguay',
    'Perú', 'Puerto Rico', 'República Dominicana', 'Uruguay', 'Venezuela',
  ];

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  List<String> get _paisesFilrados => _busqueda.isEmpty
      ? _paises
      : _paises
          .where((p) => p.toLowerCase().contains(_busqueda.toLowerCase()))
          .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Búsqueda en lista')),
      body: Column(
        children: [
          // Campo de búsqueda.
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _controller,
              onChanged: (v) => setState(() => _busqueda = v),
              decoration: InputDecoration(
                hintText: 'Buscar país...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _busqueda.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          setState(() => _busqueda = '');
                        },
                      )
                    : null,
                border: const OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
          // Contador de resultados.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Text(
                  '${_paisesFilrados.length} resultado(s)',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          // Lista filtrada.
          Expanded(
            child: _paisesFilrados.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 48, color: Colors.grey),
                        Text('Sin resultados',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _paisesFilrados.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: const Icon(Icons.flag_outlined),
                      title: Text(_paisesFilrados[index]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 3 — LISTA CON DISMISSIBLE
// ────────────────────────────────────────────────────────────────────────────

/// Lista de mensajes con Dismissible: deslizar a la derecha archiva,
/// deslizar a la izquierda elimina.
///
/// OBJETIVO: Dismissible envolviendo cada ListTile para detectar
/// deslizamientos y ejecutar acciones (eliminar, archivar).
class _EjercicioDismissible extends StatefulWidget {
  const _EjercicioDismissible();

  @override
  State<_EjercicioDismissible> createState() =>
      _EjercicioDismissibleState();
}

class _EjercicioDismissibleState extends State<_EjercicioDismissible> {
  List<Map<String, dynamic>> _mensajes = List.generate(
    8,
    (i) => {
      'id': i,
      'remitente': ['Ana G.', 'Carlos L.', 'María M.', 'Pedro R.'][i % 4],
      'texto': 'Mensaje #${i + 1}: Hola, ¿cómo estás?',
      'leido': i % 3 == 0,
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mensajes (${_mensajes.length})'),
      ),
      body: _mensajes.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 64, color: Colors.grey),
                  Text('Sin mensajes', style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _mensajes.length,
              itemBuilder: (context, index) {
                final msg = _mensajes[index];
                return Dismissible(
                  // key: OBLIGATORIO para Dismissible. Identifica cada item.
                  key: ValueKey(msg['id']),

                  // onDismissed: se llama cuando el usuario completa el gesto.
                  // direction indica si fue hacia la izquierda o derecha.
                  onDismissed: (direction) {
                    final texto = msg['texto'] as String;
                    setState(() => _mensajes.removeAt(index));
                    final accion = direction == DismissDirection.endToStart
                        ? 'eliminado'
                        : 'archivado';
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Mensaje $accion'),
                        action: SnackBarAction(
                          label: 'Deshacer',
                          onPressed: () {
                            setState(() => _mensajes.insert(index, msg));
                          },
                        ),
                      ),
                    );
                  },

                  // background: fondo visible al deslizar a la DERECHA (archivar).
                  background: Container(
                    color: Colors.green,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 24),
                    child: const Row(
                      children: [
                        Icon(Icons.archive, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Archivar', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),

                  // secondaryBackground: fondo visible al deslizar a la IZQUIERDA (eliminar).
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 24),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Eliminar', style: TextStyle(color: Colors.white)),
                        SizedBox(width: 8),
                        Icon(Icons.delete, color: Colors.white),
                      ],
                    ),
                  ),

                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text((msg['remitente'] as String)[0]),
                    ),
                    title: Text(msg['remitente'] as String,
                        style: TextStyle(
                          fontWeight: msg['leido'] == true
                              ? FontWeight.normal
                              : FontWeight.bold,
                        )),
                    subtitle: Text(msg['texto'] as String,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    trailing: msg['leido'] == false
                        ? const Icon(Icons.circle, size: 10, color: Colors.blue)
                        : null,
                  ),
                );
              },
            ),
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. En la galería, agrega un Slider para cambiar el número de columnas
//      entre 2 y 4 dinámicamente.
//   2. En la búsqueda, agrega un DropdownButton para filtrar por letra inicial.
//   3. En Dismissible, usa confirmDismiss: para mostrar un AlertDialog de
//      confirmación antes de eliminar — si el usuario cancela, no se elimina.
// =============================================================================
