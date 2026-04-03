// =============================================================================
// ARCHIVO: 04_ejercicios.dart
// TEMA: Ejercicios de HTTP y consumo de APIs
// =============================================================================
// CÓMO USAR: copiar como lib/main.dart y ejecutar flutter run
// DEPENDENCIA: agregar en pubspec.yaml: http: ^1.2.1
// =============================================================================

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const AppEjerciciosHttp());

/// App con ejercicios de HTTP y APIs.
class AppEjerciciosHttp extends StatelessWidget {
  const AppEjerciciosHttp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicios HTTP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal)),
      home: const PantallaEjerciciosHttp(),
    );
  }
}

/// Pantalla de lista de ejercicios.
class PantallaEjerciciosHttp extends StatelessWidget {
  const PantallaEjerciciosHttp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicios HTTP'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _TarjetaEjercicio(
            numero: 1,
            titulo: 'Lista de fotos',
            descripcion: 'Llama a /photos?albumId=1 y muestra las fotos en un GridView.',
            destino: const _EjercicioFotos(),
          ),
          _TarjetaEjercicio(
            numero: 2,
            titulo: 'Búsqueda de usuarios',
            descripcion:
                'Obtén /users y filtra por nombre localmente. Muestra los resultados.',
            destino: const _EjercicioBusquedaUsuarios(),
          ),
          _TarjetaEjercicio(
            numero: 3,
            titulo: 'Comentarios por post',
            descripcion:
                'Muestra una lista de posts. Al tocar uno, carga sus comentarios desde /comments?postId=X.',
            destino: const _EjercicioComentarios(),
          ),
        ],
      ),
    );
  }
}

/// Tarjeta de ejercicio con navegación.
class _TarjetaEjercicio extends StatelessWidget {
  final int numero;
  final String titulo;
  final String descripcion;
  final Widget destino;

  const _TarjetaEjercicio({
    required this.numero,
    required this.titulo,
    required this.descripcion,
    required this.destino,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text('$numero',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold)),
        ),
        title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(descripcion),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (_) => destino)),
      ),
    );
  }
}

// ─── Ejercicio 1: Lista de fotos en GridView ──────────────────────────────────

/// Solución: fotos de un álbum en GridView.
class _EjercicioFotos extends StatelessWidget {
  const _EjercicioFotos();

  Future<List<Map<String, dynamic>>> _cargar() async {
    final res = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/photos?albumId=1'));
    final List lista = jsonDecode(res.body);
    return lista.cast<Map<String, dynamic>>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 1: Fotos')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _cargar(),
        builder: (_, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          if (snap.hasError) return Center(child: Text('Error: ${snap.error}'));
          final fotos = snap.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: fotos.length,
            itemBuilder: (_, i) {
              final foto = fotos[i];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    // thumbnailUrl es una imagen de 150x150
                    Expanded(
                      child: Image.network(
                        foto['thumbnailUrl'] as String,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        foto['title'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ─── Ejercicio 2: Búsqueda local ──────────────────────────────────────────────

/// Solución: búsqueda local de usuarios.
class _EjercicioBusquedaUsuarios extends StatefulWidget {
  const _EjercicioBusquedaUsuarios();

  @override
  State<_EjercicioBusquedaUsuarios> createState() =>
      _EjercicioBusquedaUsuariosState();
}

class _EjercicioBusquedaUsuariosState
    extends State<_EjercicioBusquedaUsuarios> {
  List<Map<String, dynamic>> _todos = [];
  List<Map<String, dynamic>> _filtrados = [];
  final _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  Future<void> _cargar() async {
    final res = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    final List lista = jsonDecode(res.body);
    setState(() {
      _todos = lista.cast<Map<String, dynamic>>();
      _filtrados = _todos;
    });
  }

  void _filtrar(String query) {
    setState(() {
      _filtrados = _todos
          .where((u) =>
              (u['name'] as String).toLowerCase().contains(query.toLowerCase()) ||
              (u['email'] as String).toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 2: Búsqueda')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _ctrl,
              onChanged: _filtrar,
              decoration: const InputDecoration(
                hintText: 'Buscar por nombre o email',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filtrados.length,
              itemBuilder: (_, i) {
                final u = _filtrados[i];
                return ListTile(
                  leading: CircleAvatar(child: Text((u['name'] as String)[0])),
                  title: Text(u['name'] as String),
                  subtitle: Text(u['email'] as String),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Ejercicio 3: Comentarios por post ───────────────────────────────────────

/// Solución: posts con comentarios cargados al tap.
class _EjercicioComentarios extends StatelessWidget {
  const _EjercicioComentarios();

  Future<List<Map<String, dynamic>>> _cargarPosts() async {
    final res = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=10'));
    return (jsonDecode(res.body) as List).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> _cargarComentarios(int postId) async {
    final res = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/comments?postId=$postId'));
    return (jsonDecode(res.body) as List).cast<Map<String, dynamic>>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 3: Comentarios')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _cargarPosts(),
        builder: (_, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final posts = snap.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (_, i) {
              final post = posts[i];
              return ExpansionTile(
                title: Text(post['title'] as String,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                children: [
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: _cargarComentarios(post['id'] as int),
                    builder: (_, cs) {
                      if (!cs.hasData) {
                        return const Padding(
                          padding: EdgeInsets.all(8),
                          child: LinearProgressIndicator(),
                        );
                      }
                      return Column(
                        children: cs.data!
                            .map((c) => ListTile(
                                  dense: true,
                                  leading: const Icon(Icons.comment_outlined,
                                      size: 16),
                                  title: Text(c['name'] as String,
                                      style: const TextStyle(fontSize: 12)),
                                  subtitle: Text(c['body'] as String,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 11)),
                                ))
                            .toList(),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
