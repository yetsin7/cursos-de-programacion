// =============================================================================
// ARCHIVO: 03_dio_avanzado.dart
// TEMA: Cliente HTTP avanzado con Dio — interceptores, cancelación, errores
// =============================================================================
// CÓMO USAR: copiar como lib/main.dart y ejecutar flutter run
// DEPENDENCIA: agregar en pubspec.yaml: dio: ^5.4.3+1
// =============================================================================

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() => runApp(const AppDioAvanzado());

// =============================================================================
// CONFIGURACIÓN DE DIO
// =============================================================================

/// Crea y configura la instancia de Dio con opciones base e interceptores.
/// Se crea una sola vez y se reutiliza en toda la app (Singleton o Provider).
Dio _crearDio() {
  final dio = Dio(
    // BaseOptions configura las opciones por defecto de todas las peticiones
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      // Tiempo máximo para establecer la conexión
      connectTimeout: const Duration(seconds: 10),
      // Tiempo máximo para recibir la respuesta
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Agregar interceptor de logging para desarrollo
  dio.interceptors.add(_LogInterceptor());

  // Agregar interceptor de autenticación
  dio.interceptors.add(_AuthInterceptor(token: 'mi-token-secreto'));

  return dio;
}

// =============================================================================
// INTERCEPTORES — se ejecutan antes/después de cada petición
// =============================================================================

/// Interceptor de logging que registra cada petición y respuesta.
/// En producción se reemplazaría por un logger real o se desactivaría.
class _LogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST → ${options.method} ${options.path}');
    // handler.next() continúa con la petición
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('RESPONSE ← ${response.statusCode} ${response.requestOptions.path}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('ERROR ✗ ${err.type}: ${err.message}');
    // handler.next() propaga el error al caller
    handler.next(err);
  }
}

/// Interceptor de autenticación que agrega el token a cada petición.
/// En una app real, el token vendría de un servicio de sesión.
class _AuthInterceptor extends Interceptor {
  final String token;
  _AuthInterceptor({required this.token});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Agregar el header de autorización automáticamente
    options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Manejar 401 globalmente — redirigir a login
    if (err.response?.statusCode == 401) {
      debugPrint('Token expirado — redirigir a login');
      // En una app real: navegar a la pantalla de login
    }
    handler.next(err);
  }
}

// =============================================================================
// SERVICIO
// =============================================================================

/// Servicio de posts usando Dio con cancelación de peticiones.
class PostServiceDio {
  final Dio _dio = _crearDio();

  // Token para poder cancelar peticiones en vuelo
  CancelToken? _cancelToken;

  /// Obtiene los posts, cancelando la petición anterior si existía.
  Future<List<Map<String, dynamic>>> obtenerPosts() async {
    // Cancelar petición anterior si todavía está en vuelo
    _cancelToken?.cancel('Nueva petición iniciada');
    _cancelToken = CancelToken();

    try {
      final response = await _dio.get<List<dynamic>>(
        '/posts',
        cancelToken: _cancelToken,
        // queryParameters agrega parámetros a la URL: /posts?_limit=15
        queryParameters: {'_limit': 15},
      );

      return (response.data as List)
          .map((item) => item as Map<String, dynamic>)
          .toList();
    } on DioException catch (e) {
      // Manejar la cancelación de forma silenciosa
      if (CancelToken.isCancel(e)) {
        return [];
      }
      // Relanzar otros errores con mensaje descriptivo
      throw _manejarError(e);
    }
  }

  /// Convierte DioException en un mensaje de error legible para el usuario.
  Exception _manejarError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Tiempo de conexión agotado. Verifica tu internet.');
      case DioExceptionType.receiveTimeout:
        return Exception('El servidor tardó demasiado en responder.');
      case DioExceptionType.badResponse:
        final status = e.response?.statusCode;
        if (status == 404) return Exception('Recurso no encontrado (404)');
        if (status == 500) return Exception('Error del servidor (500)');
        return Exception('Error HTTP $status');
      case DioExceptionType.connectionError:
        return Exception('Sin conexión a internet.');
      default:
        return Exception('Error desconocido: ${e.message}');
    }
  }

  /// Cancela cualquier petición en vuelo.
  void cancelar() => _cancelToken?.cancel('Cancelado por el usuario');
}

// =============================================================================
// APP
// =============================================================================

/// App raíz.
class AppDioAvanzado extends StatelessWidget {
  const AppDioAvanzado({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dio Avanzado',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const PantallaDio(),
    );
  }
}

/// Pantalla que demuestra Dio con interceptores y manejo de errores.
class PantallaDio extends StatefulWidget {
  const PantallaDio({super.key});

  @override
  State<PantallaDio> createState() => _PantallaDioState();
}

class _PantallaDioState extends State<PantallaDio> {
  final _service = PostServiceDio();
  List<Map<String, dynamic>> _posts = [];
  bool _cargando = false;
  String? _error;
  final List<String> _logs = [];

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  Future<void> _cargar() async {
    setState(() {
      _cargando = true;
      _error = null;
      _logs.add('[${DateTime.now().second}s] Iniciando petición GET /posts...');
    });

    try {
      final posts = await _service.obtenerPosts();
      if (!mounted) return;
      setState(() {
        _posts = posts;
        _logs.add('[${DateTime.now().second}s] ${posts.length} posts recibidos');
        _cargando = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _logs.add('[${DateTime.now().second}s] ERROR: $e');
        _cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dio Avanzado'),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _cargar),
        ],
      ),
      body: Column(
        children: [
          // Panel de logs del interceptor
          ExpansionTile(
            title: const Text('Logs del interceptor'),
            initiallyExpanded: true,
            children: [
              Container(
                height: 80,
                color: Colors.black87,
                padding: const EdgeInsets.all(8),
                child: ListView.builder(
                  itemCount: _logs.length,
                  itemBuilder: (_, i) => Text(
                    _logs[i],
                    style: const TextStyle(
                        color: Colors.greenAccent,
                        fontFamily: 'monospace',
                        fontSize: 11),
                  ),
                ),
              ),
            ],
          ),

          // Lista de posts
          Expanded(
            child: _cargando
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.error_outline,
                                color: Colors.red, size: 48),
                            const SizedBox(height: 8),
                            Text(_error!),
                            const SizedBox(height: 16),
                            ElevatedButton(
                                onPressed: _cargar,
                                child: const Text('Reintentar')),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: _posts.length,
                        itemBuilder: (_, i) {
                          final post = _posts[i];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 6),
                            child: ListTile(
                              dense: true,
                              leading: CircleAvatar(
                                radius: 16,
                                child: Text('${post['id']}',
                                    style: const TextStyle(fontSize: 11)),
                              ),
                              title: Text(
                                post['title'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _service.cancelar();
          setState(() => _logs.add('[${DateTime.now().second}s] Petición cancelada'));
        },
        icon: const Icon(Icons.cancel_outlined),
        label: const Text('Cancelar'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
    );
  }
}
