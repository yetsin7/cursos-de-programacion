// =============================================================================
// ARCHIVO: 03_go_router.dart
// TEMA: go_router — navegación moderna y declarativa
// =============================================================================
//
// go_router es el paquete oficial recomendado por el equipo de Flutter para
// navegación. Soporta deep linking, URLs en web, parámetros de ruta,
// rutas anidadas y redirección. Es declarativo: defines las rutas en un
// solo lugar y el router las gestiona automáticamente.
//
// REQUISITO: agregar al pubspec.yaml:
//   dependencies:
//     go_router: ^14.0.0
//
// CÓMO USAR:
//   1. Crea un proyecto Flutter: flutter create mi_app
//   2. Agrega go_router al pubspec.yaml (ver arriba)
//   3. Ejecuta: flutter pub get
//   4. Reemplaza lib/main.dart con este archivo
//   5. Ejecuta: flutter run
//
// =============================================================================
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(const MiApp());

// ────────────────────────────────────────────────────────────────────────────
// CONFIGURACIÓN DEL ROUTER
// ────────────────────────────────────────────────────────────────────────────

/// Configuración centralizada del router de la app.
///
/// Se define fuera del widget para evitar que se recree en cada rebuild.
/// En apps reales, esto va en su propia clase o archivo.
final _router = GoRouter(
  // initialLocation: la ruta que se muestra al iniciar.
  initialLocation: '/',

  // routes: lista de GoRoute que definen todas las rutas de la app.
  routes: [
    // Ruta raíz.
    GoRoute(
      path: '/',
      builder: (context, state) => const PantallaInicio(),
    ),

    // Ruta de detalle con parámetro :id en el path.
    // Accedido como state.pathParameters['id']
    GoRoute(
      path: '/producto/:id',
      builder: (context, state) {
        // Extraer el parámetro de la ruta.
        final id = state.pathParameters['id'] ?? '0';
        return PantallaProducto(id: id);
      },
    ),

    // Ruta de perfil con sub-ruta (ruta anidada plana con ShellRoute).
    GoRoute(
      path: '/perfil',
      builder: (context, state) => const PantallaPerfil(),
      // routes: sub-rutas de /perfil
      routes: [
        GoRoute(
          path: 'editar', // resulta en /perfil/editar
          builder: (context, state) => const PantallaEditarPerfil(),
        ),
      ],
    ),

    // Ruta con query parameters: /busqueda?q=flutter
    GoRoute(
      path: '/busqueda',
      builder: (context, state) {
        // Los query params se acceden con state.uri.queryParameters
        final query = state.uri.queryParameters['q'] ?? '';
        return PantallaBusqueda(query: query);
      },
    ),
  ],

  // errorBuilder: pantalla que se muestra cuando la ruta no existe.
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Ruta no encontrada: ${state.uri}'),
    ),
  ),
);

// ────────────────────────────────────────────────────────────────────────────
// RAÍZ DE LA APP
// ────────────────────────────────────────────────────────────────────────────

/// MaterialApp.router usa el GoRouter en lugar del Navigator clásico.
class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'go_router Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // routerConfig: conecta el GoRouter con MaterialApp.
      routerConfig: _router,
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA INICIO
// ────────────────────────────────────────────────────────────────────────────

/// Pantalla principal que demuestra todas las formas de navegar con go_router.
class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('go_router Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _Seccion('context.go() — navegar y reemplazar'),
          // context.go: navega a la ruta y REEMPLAZA el historial actual.
          // Similar a pushReplacement. El botón atrás NO lleva al origen.
          ElevatedButton(
            onPressed: () => context.go('/perfil'),
            child: const Text('Ir a Perfil (go — sin historial)'),
          ),
          const SizedBox(height: 16),

          const _Seccion('context.push() — navegar y apilar'),
          // context.push: agrega la ruta a la pila. El botón atrás funciona.
          ElevatedButton(
            onPressed: () => context.push('/perfil'),
            child: const Text('Ir a Perfil (push — con historial)'),
          ),
          const SizedBox(height: 8),

          // Navegar con parámetro de ruta.
          ElevatedButton(
            onPressed: () => context.push('/producto/42'),
            child: const Text('Producto ID: 42 (parámetro en path)'),
          ),
          const SizedBox(height: 8),

          // Navegar con query parameters.
          ElevatedButton(
            onPressed: () => context.push('/busqueda?q=flutter'),
            child: const Text('Buscar "flutter" (query param)'),
          ),
          const SizedBox(height: 16),

          const _Seccion('context.pushReplacement()'),
          OutlinedButton(
            onPressed: () => context.pushReplacement('/perfil'),
            child: const Text('Reemplazar con Perfil'),
          ),
          const SizedBox(height: 16),

          // Nota informativa.
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('go_router también ofrece:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(
                  '• context.goNamed("nombre") — por nombre de ruta\n'
                  '• context.pop() — volver atrás\n'
                  '• context.canPop() — verificar si hay historial\n'
                  '• GoRouterState para leer estado de ruta\n'
                  '• redirect: para autenticación y guards\n'
                  '• ShellRoute para layouts con navegación anidada',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLAS DESTINO
// ────────────────────────────────────────────────────────────────────────────

/// Pantalla de producto que muestra el parámetro :id de la ruta.
class PantallaProducto extends StatelessWidget {
  final String id;
  const PantallaProducto({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return _PantallaInfo(
      titulo: 'Producto #$id',
      icono: Icons.inventory_2,
      color: Colors.deepPurple,
      info: 'Parámetro de ruta: id = $id\nURL: /producto/$id',
    );
  }
}

/// Pantalla de perfil de usuario.
class PantallaPerfil extends StatelessWidget {
  const PantallaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return _PantallaInfo(
      titulo: 'Perfil',
      icono: Icons.person,
      color: Colors.blue,
      info: 'URL: /perfil',
      accionExtra: FilledButton(
        onPressed: () => context.push('/perfil/editar'),
        child: const Text('Editar perfil (sub-ruta)'),
      ),
    );
  }
}

/// Pantalla de edición de perfil (sub-ruta de /perfil).
class PantallaEditarPerfil extends StatelessWidget {
  const PantallaEditarPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return _PantallaInfo(
      titulo: 'Editar Perfil',
      icono: Icons.edit,
      color: Colors.teal,
      info: 'URL: /perfil/editar\nSub-ruta de /perfil',
    );
  }
}

/// Pantalla de búsqueda con query parameter.
class PantallaBusqueda extends StatelessWidget {
  final String query;
  const PantallaBusqueda({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return _PantallaInfo(
      titulo: 'Búsqueda',
      icono: Icons.search,
      color: Colors.green,
      info: 'Query parameter: q = "$query"\nURL: /busqueda?q=$query',
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// WIDGETS AUXILIARES
// ────────────────────────────────────────────────────────────────────────────

/// Pantalla genérica para las pantallas de destino.
class _PantallaInfo extends StatelessWidget {
  final String titulo;
  final IconData icono;
  final Color color;
  final String info;
  final Widget? accionExtra;

  const _PantallaInfo({
    required this.titulo,
    required this.icono,
    required this.color,
    required this.info,
    this.accionExtra,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        backgroundColor: color.withValues(alpha: 0.2),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icono, size: 72, color: color),
              const SizedBox(height: 16),
              Text(titulo,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(info,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
              if (accionExtra != null) ...[
                const SizedBox(height: 24),
                accionExtra!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget de subtítulo de sección.
class _Seccion extends StatelessWidget {
  final String texto;
  const _Seccion(this.texto);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(texto,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Agrega redirect al GoRouter para redirigir '/' a '/login' si el
//      usuario no está autenticado (simula con una variable bool isLoggedIn).
//   2. Usa ShellRoute para crear un layout compartido con BottomNavigationBar
//      donde el contenido cambia pero la barra inferior persiste.
//   3. Agrega el parámetro name a cada GoRoute y usa context.goNamed()
//      para navegar por nombre en lugar de por path.
// =============================================================================
