// =============================================================================
// ARCHIVO: 01_http_basico.dart
// TEMA: Peticiones HTTP básicas con el paquete http
// =============================================================================
// CÓMO USAR: copiar como lib/main.dart y ejecutar flutter run
// DEPENDENCIA: agregar en pubspec.yaml: http: ^1.2.1
// NOTA: requiere permiso de internet en AndroidManifest.xml:
//   <uses-permission android:name="android.permission.INTERNET"/>
// =============================================================================

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const AppHttpBasico());

// =============================================================================
// MODELO
// =============================================================================

/// Modelo de un post de la API JSONPlaceholder.
class Post {
  final int id;
  final int userId;
  final String titulo;
  final String cuerpo;

  const Post({
    required this.id,
    required this.userId,
    required this.titulo,
    required this.cuerpo,
  });

  /// Deserializa desde JSON de la API.
  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'] as int,
        userId: json['userId'] as int,
        titulo: json['title'] as String,
        cuerpo: json['body'] as String,
      );
}

// =============================================================================
// SERVICIO HTTP
// =============================================================================

/// Servicio que encapsula las peticiones HTTP a JSONPlaceholder.
class PostService {
  static const _baseUrl = 'https://jsonplaceholder.typicode.com';

  /// Obtiene la lista de posts. Lanza excepción si falla.
  Future<List<Post>> obtenerPosts() async {
    // http.get() realiza una petición GET y retorna un Response
    final response = await http.get(Uri.parse('$_baseUrl/posts'));

    // Verificar el código de estado HTTP
    if (response.statusCode == 200) {
      // jsonDecode convierte el JSON string a una lista de mapas
      final List<dynamic> datos = jsonDecode(response.body);
      return datos.map((json) => Post.fromJson(json)).toList();
    } else {
      throw HttpException(
          'Error ${response.statusCode}: ${response.reasonPhrase}');
    }
  }

  /// Obtiene un post por su id.
  Future<Post> obtenerPost(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/posts/$id'));
    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    }
    throw HttpException('Post $id no encontrado');
  }

  /// Crea un post nuevo (simulado — JSONPlaceholder no persiste los datos).
  Future<Post> crearPost({required String titulo, required String cuerpo}) async {
    // http.post() con headers y body en JSON
    final response = await http.post(
      Uri.parse('$_baseUrl/posts'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'title': titulo, 'body': cuerpo, 'userId': 1}),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    }
    throw HttpException('No se pudo crear el post');
  }

  /// Elimina un post por id (simulado).
  Future<void> eliminarPost(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/posts/$id'));
    if (response.statusCode != 200) {
      throw HttpException('No se pudo eliminar el post $id');
    }
  }
}

// =============================================================================
// APP
// =============================================================================

/// App raíz.
class AppHttpBasico extends StatelessWidget {
  const AppHttpBasico({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP Básico',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      home: const PantallaHttp(),
    );
  }
}

/// Pantalla que muestra posts usando FutureBuilder para manejar los estados
/// de carga, error y datos.
class PantallaHttp extends StatefulWidget {
  const PantallaHttp({super.key});

  @override
  State<PantallaHttp> createState() => _PantallaHttpState();
}

class _PantallaHttpState extends State<PantallaHttp> {
  final _service = PostService();
  // El Future se guarda como variable para evitar recrearlo en cada build
  late Future<List<Post>> _futurePostos;

  @override
  void initState() {
    super.initState();
    _futurePostos = _service.obtenerPosts();
  }

  /// Recarga los posts haciendo una nueva petición.
  void _recargar() {
    setState(() => _futurePostos = _service.obtenerPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP Básico'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _recargar,
          ),
        ],
      ),
      body: FutureBuilder<List<Post>>(
        future: _futurePostos,
        builder: (context, snapshot) {
          // Estado: esperando datos
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Cargando posts...'),
                ],
              ),
            );
          }

          // Estado: error en la petición
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 8),
                  Text('Error: ${snapshot.error}',
                      textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: _recargar, child: const Text('Reintentar')),
                ],
              ),
            );
          }

          // Estado: datos recibidos exitosamente
          final posts = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            // Mostrar solo los primeros 20 posts
            itemCount: posts.take(20).length,
            itemBuilder: (_, i) {
              final post = posts[i];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(child: Text('${post.id}')),
                  title: Text(
                    post.titulo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    post.cuerpo,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => _mostrarDetalle(post),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _mostrarDialogoCrear,
        icon: const Icon(Icons.add),
        label: const Text('Nuevo post'),
      ),
    );
  }

  /// Muestra el detalle de un post en un diálogo.
  void _mostrarDetalle(Post post) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(post.titulo),
        content: Text(post.cuerpo),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  /// Muestra el diálogo para crear un post (demostración de POST).
  void _mostrarDialogoCrear() {
    showDialog(
      context: context,
      builder: (_) => _DialogoCrearPost(service: _service),
    );
  }
}

/// Diálogo para crear un nuevo post con http.post().
class _DialogoCrearPost extends StatefulWidget {
  final PostService service;
  const _DialogoCrearPost({required this.service});

  @override
  State<_DialogoCrearPost> createState() => _DialogoCrearPostState();
}

class _DialogoCrearPostState extends State<_DialogoCrearPost> {
  final _tituloCtrl = TextEditingController();
  final _cuerpoCtrl = TextEditingController();
  bool _enviando = false;
  String? _resultado;

  @override
  void dispose() {
    _tituloCtrl.dispose();
    _cuerpoCtrl.dispose();
    super.dispose();
  }

  Future<void> _crear() async {
    setState(() => _enviando = true);
    try {
      final post = await widget.service.crearPost(
        titulo: _tituloCtrl.text,
        cuerpo: _cuerpoCtrl.text,
      );
      setState(() => _resultado = 'Post creado con id: ${post.id}');
    } catch (e) {
      setState(() => _resultado = 'Error: $e');
    } finally {
      setState(() => _enviando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Crear post (POST)'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: _tituloCtrl,
              decoration: const InputDecoration(labelText: 'Título')),
          TextField(controller: _cuerpoCtrl, maxLines: 3,
              decoration: const InputDecoration(labelText: 'Contenido')),
          if (_resultado != null) ...[
            const SizedBox(height: 8),
            Text(_resultado!, style: const TextStyle(color: Colors.green)),
          ],
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text('Cerrar')),
        ElevatedButton(
          onPressed: _enviando ? null : _crear,
          child: _enviando
              ? const SizedBox(
                  width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('Crear'),
        ),
      ],
    );
  }
}
