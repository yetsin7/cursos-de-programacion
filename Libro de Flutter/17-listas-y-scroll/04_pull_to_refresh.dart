// =============================================================================
// ARCHIVO: 04_pull_to_refresh.dart
// TEMA: RefreshIndicator, ScrollController y paginación
// =============================================================================
//
// RefreshIndicator agrega el gesto de "tirar hacia abajo para actualizar"
// a cualquier widget con scroll. ScrollController permite detectar cuándo
// el usuario llegó al final de la lista para cargar más datos (paginación
// infinita). SingleChildScrollView es para contenido de longitud variable.
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
      title: 'Pull to Refresh',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const PantallaPaginacion(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// MODELO DE DATOS
// ────────────────────────────────────────────────────────────────────────────

/// Post de noticias simulado.
class Post {
  final int id;
  final String titulo;
  final String autor;
  final String fecha;

  const Post({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.fecha,
  });
}

/// Simula la carga de posts desde una API con delay.
Future<List<Post>> cargarPosts({required int pagina, int cantidad = 10}) async {
  // Simula la latencia de una API real.
  await Future.delayed(const Duration(milliseconds: 800));
  final inicio = (pagina - 1) * cantidad;
  return List.generate(cantidad, (i) {
    final id = inicio + i + 1;
    return Post(
      id: id,
      titulo: 'Artículo #$id: ${_titulos[id % _titulos.length]}',
      autor: _autores[id % _autores.length],
      fecha: '${id % 28 + 1}/03/2025',
    );
  });
}

const _titulos = [
  'Cómo aprender Flutter desde cero',
  'Mejores prácticas en Dart 3.x',
  'Clean Architecture en proyectos reales',
  'Gestión de estado con Riverpod',
  'Animaciones fluidas en Flutter',
];
const _autores = ['María G.', 'Carlos L.', 'Ana M.', 'Pedro R.', 'Laura S.'];

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA PRINCIPAL CON PAGINACIÓN INFINITA
// ────────────────────────────────────────────────────────────────────────────

/// Lista con pull-to-refresh y paginación infinita.
///
/// Al llegar al final de la lista se cargan automáticamente más items.
/// Al tirar hacia abajo desde el inicio se recarga la primera página.
class PantallaPaginacion extends StatefulWidget {
  const PantallaPaginacion({super.key});

  @override
  State<PantallaPaginacion> createState() => _PantallaPaginacionState();
}

class _PantallaPaginacionState extends State<PantallaPaginacion> {
  final List<Post> _posts = [];
  int _paginaActual = 1;
  bool _cargandoMas = false;
  bool _hayMasDatos = true; // false cuando la "API" ya no retorna más datos

  // ScrollController: permite escuchar la posición del scroll.
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Agregar listener para detectar cuando se llega al final.
    _scrollController.addListener(_onScroll);
    // Cargar la primera página al montar.
    _cargarPrimeraPagina();
  }

  @override
  void dispose() {
    // Siempre dispose del ScrollController al destruir el widget.
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  /// Se llama cada vez que el usuario hace scroll.
  /// Detecta cuando se acerca al final de la lista.
  void _onScroll() {
    // position.maxScrollExtent: la posición máxima de scroll posible.
    // position.pixels: la posición actual del scroll.
    // Cargamos más cuando quedan ~200px para llegar al final.
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _cargarMasPosts();
    }
  }

  /// Carga la primera página de posts.
  Future<void> _cargarPrimeraPagina() async {
    final posts = await cargarPosts(pagina: 1);
    if (mounted) {
      setState(() {
        _posts
          ..clear()
          ..addAll(posts);
        _paginaActual = 1;
        _hayMasDatos = true;
      });
    }
  }

  /// Carga la siguiente página de posts (paginación infinita).
  Future<void> _cargarMasPosts() async {
    // Evitar múltiples solicitudes simultáneas.
    if (_cargandoMas || !_hayMasDatos) return;

    setState(() => _cargandoMas = true);

    try {
      final siguientePagina = _paginaActual + 1;
      final nuevos = await cargarPosts(pagina: siguientePagina);

      if (mounted) {
        setState(() {
          _posts.addAll(nuevos);
          _paginaActual = siguientePagina;
          // Simula que no hay más datos después de la página 5.
          _hayMasDatos = siguientePagina < 5;
          _cargandoMas = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _cargandoMas = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed — Pull to Refresh'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Indicador de página actual.
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text('Página $_paginaActual',
                  style: const TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),

      // RefreshIndicator: envuelve el widget con scroll para agregar
      // el gesto de pull-to-refresh.
      body: _posts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              // onRefresh: función async que se llama al tirar hacia abajo.
              // Debe retornar Future<void> y completarse cuando termina.
              onRefresh: _cargarPrimeraPagina,

              // color y backgroundColor del indicador.
              color: Theme.of(context).colorScheme.primary,

              child: ListView.builder(
                controller: _scrollController,
                // +1 para el indicador de carga al final (o el mensaje de fin).
                itemCount: _posts.length + 1,
                itemBuilder: (context, index) {
                  // Último item: indicador de carga o mensaje de fin.
                  if (index == _posts.length) {
                    if (_cargandoMas) {
                      return const _IndicadorCargando();
                    }
                    if (!_hayMasDatos) {
                      return const _MensajeFin();
                    }
                    return const SizedBox.shrink();
                  }

                  return _TarjetaPost(post: _posts[index]);
                },
              ),
            ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// WIDGETS AUXILIARES
// ────────────────────────────────────────────────────────────────────────────

/// Tarjeta de post para el feed de noticias.
class _TarjetaPost extends StatelessWidget {
  final Post post;
  const _TarjetaPost({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  child: Text('#${post.id}',
                      style: const TextStyle(fontSize: 10)),
                ),
                const SizedBox(width: 8),
                Text(post.autor,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 12)),
                const Spacer(),
                Text(post.fecha,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            Text(post.titulo,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.thumb_up_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                const Text('Me gusta',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                const Spacer(),
                const Icon(Icons.comment_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                const Text('Comentar',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                const Spacer(),
                const Icon(Icons.share_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                const Text('Compartir',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Indicador de carga al final de la lista (mientras se carga la siguiente página).
class _IndicadorCargando extends StatelessWidget {
  const _IndicadorCargando();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: 12),
            Text('Cargando más artículos...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

/// Mensaje que indica que no hay más datos disponibles.
class _MensajeFin extends StatelessWidget {
  const _MensajeFin();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.grey, size: 32),
            SizedBox(height: 8),
            Text('Has visto todos los artículos',
                style: TextStyle(color: Colors.grey)),
            SizedBox(height: 4),
            Text('Tira hacia abajo para actualizar',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Agrega un botón de "Subir al inicio" (Scroll to top) que aparezca
//      cuando el usuario ha bajado más de 300px usando un listener en
//      el ScrollController.
//   2. Usa SingleChildScrollView + Column cuando tengas contenido mixto
//      (imágenes, textos, listas) que no cabe en pantalla. Recuerda que
//      SingleChildScrollView no tiene lazy loading.
//   3. Implementa "retry" al detectar un error en _cargarMasPosts() —
//      muestra un botón "Reintentar" en lugar del indicador de carga cuando
//      la solicitud falla.
// =============================================================================
