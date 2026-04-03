// =============================================================================
// ARCHIVO: 02_json_parsing.dart
// TEMA: Parseo profesional de JSON — modelos, fromJson, toJson
// =============================================================================
// CÓMO USAR: copiar como lib/main.dart y ejecutar flutter run
// DEPENDENCIA: agregar en pubspec.yaml: http: ^1.2.1
// =============================================================================

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const AppJsonParsing());

// =============================================================================
// MODELOS — buenas prácticas de parseo de JSON
// =============================================================================

/// Modelo de usuario de la API JSONPlaceholder.
/// Demuestra fromJson anidado con objeto Address.
class Usuario {
  final int id;
  final String nombre;
  final String nombreUsuario;
  final String email;
  final Direccion direccion;
  final String telefono;

  const Usuario({
    required this.id,
    required this.nombre,
    required this.nombreUsuario,
    required this.email,
    required this.direccion,
    required this.telefono,
  });

  /// Constructor de fábrica que crea un Usuario desde un Map JSON.
  /// Nunca usar 'dynamic' en producción — siempre castear explícitamente.
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as int,
      nombre: json['name'] as String,
      nombreUsuario: json['username'] as String,
      email: json['email'] as String,
      // Parseo de objeto anidado — el campo 'address' también es un Map
      direccion: Direccion.fromJson(json['address'] as Map<String, dynamic>),
      telefono: json['phone'] as String,
    );
  }

  /// Serializa el usuario a JSON para enviar a una API.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': nombre,
        'username': nombreUsuario,
        'email': email,
        'address': direccion.toJson(),
        'phone': telefono,
      };

  @override
  String toString() => 'Usuario(id: $id, nombre: $nombre)';
}

/// Modelo de dirección anidado dentro de Usuario.
class Direccion {
  final String calle;
  final String ciudad;
  final String codigoPostal;

  const Direccion({
    required this.calle,
    required this.ciudad,
    required this.codigoPostal,
  });

  factory Direccion.fromJson(Map<String, dynamic> json) => Direccion(
        calle: json['street'] as String,
        ciudad: json['city'] as String,
        codigoPostal: json['zipcode'] as String,
      );

  Map<String, dynamic> toJson() => {
        'street': calle,
        'city': ciudad,
        'zipcode': codigoPostal,
      };
}

/// Modelo de un álbum de fotos.
class Album {
  final int id;
  final int userId;
  final String titulo;

  const Album({required this.id, required this.userId, required this.titulo});

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        id: json['id'] as int,
        userId: json['userId'] as int,
        titulo: json['title'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'title': titulo,
      };
}

// =============================================================================
// SERVICIO
// =============================================================================

/// Servicio que obtiene usuarios y albums de JSONPlaceholder.
class ApiService {
  static const _base = 'https://jsonplaceholder.typicode.com';

  /// Obtiene la lista de usuarios parseando cada uno como Usuario.
  Future<List<Usuario>> obtenerUsuarios() async {
    final res = await http.get(Uri.parse('$_base/users'));
    if (res.statusCode != 200) throw Exception('Error ${res.statusCode}');

    // La respuesta es una lista JSON — castear a List<dynamic>
    final List<dynamic> lista = jsonDecode(res.body);

    // Mapear cada elemento a un Usuario tipado
    return lista
        .map((item) => Usuario.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Obtiene albums de un usuario específico.
  Future<List<Album>> obtenerAlbums(int userId) async {
    final res =
        await http.get(Uri.parse('$_base/albums?userId=$userId'));
    if (res.statusCode != 200) throw Exception('Error ${res.statusCode}');

    final List<dynamic> lista = jsonDecode(res.body);
    return lista
        .map((item) => Album.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}

// =============================================================================
// APP
// =============================================================================

/// App raíz.
class AppJsonParsing extends StatelessWidget {
  const AppJsonParsing({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON Parsing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple)),
      home: const PantallaUsuarios(),
    );
  }
}

/// Pantalla que lista usuarios con sus datos parseados.
class PantallaUsuarios extends StatelessWidget {
  const PantallaUsuarios({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JSON Parsing'), centerTitle: true),
      body: FutureBuilder<List<Usuario>>(
        future: ApiService().obtenerUsuarios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final usuarios = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: usuarios.length,
            itemBuilder: (_, i) => _TarjetaUsuario(usuario: usuarios[i]),
          );
        },
      ),
      // Botón para demostrar jsonEncode
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _mostrarEjemploEncode(context),
        icon: const Icon(Icons.code),
        label: const Text('toJson demo'),
      ),
    );
  }

  /// Demuestra cómo usar jsonEncode para serializar un objeto a JSON string.
  void _mostrarEjemploEncode(BuildContext context) {
    const usuario = Usuario(
      id: 99,
      nombre: 'Juan Ejemplo',
      nombreUsuario: 'juanejo',
      email: 'juan@ejemplo.com',
      direccion: Direccion(
          calle: 'Calle Falsa 123', ciudad: 'Springfield', codigoPostal: '12345'),
      telefono: '555-0199',
    );
    // jsonEncode convierte el objeto al JSON string
    final jsonString = const JsonEncoder.withIndent('  ').convert(usuario.toJson());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Objeto → JSON (toJson)'),
        content: SingleChildScrollView(
          child: Text(jsonString, style: const TextStyle(fontFamily: 'monospace')),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text('Cerrar')),
        ],
      ),
    );
  }
}

/// Tarjeta de usuario que muestra datos parseados del JSON.
class _TarjetaUsuario extends StatelessWidget {
  final Usuario usuario;
  const _TarjetaUsuario({required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        leading: CircleAvatar(
          child: Text(usuario.nombre[0].toUpperCase()),
        ),
        title: Text(usuario.nombre,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(usuario.email),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FilaInfo('Usuario', usuario.nombreUsuario),
                _FilaInfo('Teléfono', usuario.telefono),
                _FilaInfo('Ciudad', usuario.direccion.ciudad),
                _FilaInfo('Calle', usuario.direccion.calle),
                _FilaInfo('C.P.', usuario.direccion.codigoPostal),
                const Divider(),
                // Albums del usuario
                FutureBuilder<List<Album>>(
                  future: ApiService().obtenerAlbums(usuario.id),
                  builder: (_, snap) {
                    if (!snap.hasData) return const LinearProgressIndicator();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Albums (${snap.data!.length}):',
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        ...snap.data!.take(3).map(
                              (a) => Text('• ${a.titulo}',
                                  style: const TextStyle(fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Fila de un campo de información.
class _FilaInfo extends StatelessWidget {
  final String etiqueta;
  final String valor;
  const _FilaInfo(this.etiqueta, this.valor);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text('$etiqueta:',
                style: const TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.grey)),
          ),
          Expanded(child: Text(valor)),
        ],
      ),
    );
  }
}
