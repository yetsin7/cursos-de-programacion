// =============================================================================
// ARCHIVO: 02_named_routes.dart
// TEMA: Rutas nombradas (Named Routes) en Flutter
// =============================================================================
//
// Las named routes definen las pantallas de la app como strings en MaterialApp.
// Se navega con Navigator.pushNamed('/nombre'). Son más organizadas que el
// push directo pero tienen limitaciones para pasar argumentos complejos.
// Para apps más grandes, se recomienda go_router (ver archivo siguiente).
//
// CÓMO USAR:
//   1. Crea un proyecto Flutter: flutter create mi_app
//   2. Reemplaza lib/main.dart con este archivo
//   3. Ejecuta: flutter run
//
// =============================================================================
import 'package:flutter/material.dart';

void main() => runApp(const MiApp());

// ────────────────────────────────────────────────────────────────────────────
// CONSTANTES DE RUTAS
// ────────────────────────────────────────────────────────────────────────────

/// Constantes de rutas para evitar strings mágicos dispersos en el código.
/// Centralizar los nombres de ruta facilita el mantenimiento.
abstract class Rutas {
  static const String inicio = '/';
  static const String detalle = '/detalle';
  static const String perfil = '/perfil';
  static const String ajustes = '/ajustes';
}

// ────────────────────────────────────────────────────────────────────────────
// RAÍZ DE LA APP CON RUTAS DEFINIDAS
// ────────────────────────────────────────────────────────────────────────────

/// MaterialApp con todas las rutas nombradas definidas en un solo lugar.
class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Routes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),

      // initialRoute: la ruta que se muestra al iniciar la app.
      // Por defecto es '/' pero es buena práctica ser explícito.
      initialRoute: Rutas.inicio,

      // routes: mapa de String → WidgetBuilder.
      // Cada entry asocia un path con la pantalla correspondiente.
      routes: {
        Rutas.inicio: (context) => const PantallaInicio(),
        Rutas.perfil: (context) => const PantallaPerfil(),
        Rutas.ajustes: (context) => const PantallaAjustes(),
        // Rutas.detalle no está aquí porque necesita argumentos → onGenerateRoute
      },

      // onGenerateRoute: se llama para rutas que no están en el mapa routes.
      // Ideal para rutas con argumentos o rutas dinámicas.
      onGenerateRoute: (settings) {
        if (settings.name == Rutas.detalle) {
          // settings.arguments contiene los datos pasados con pushNamed.
          final args = settings.arguments as Map<String, dynamic>?;
          return MaterialPageRoute(
            builder: (context) => PantallaDetalle(
              titulo: args?['titulo'] ?? 'Sin título',
              descripcion: args?['descripcion'] ?? '',
            ),
          );
        }
        // Retornar null hace que Flutter use onUnknownRoute.
        return null;
      },

      // onUnknownRoute: pantalla de error para rutas no encontradas.
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const PantallaNaoEncontrada(),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA INICIO
// ────────────────────────────────────────────────────────────────────────────

/// Pantalla inicial que demuestra todas las formas de navegación con named routes.
class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Named Routes'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── pushNamed ──────────────────────────────────────────────────
            const _Subtitulo('Navigator.pushNamed'),
            ElevatedButton(
              onPressed: () {
                // pushNamed: agrega la ruta a la pila (se puede volver atrás).
                Navigator.pushNamed(context, Rutas.perfil);
              },
              child: const Text('Ir a Perfil (pushNamed)'),
            ),
            const SizedBox(height: 8),

            // Pasar argumentos con el parámetro arguments.
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Rutas.detalle,
                  // arguments puede ser cualquier objeto: Map, clase, String, etc.
                  arguments: {
                    'titulo': 'Flutter 3.x',
                    'descripcion':
                        'Novedades de Flutter en la versión 3.x: Impeller, Material 3...',
                  },
                );
              },
              child: const Text('Ir a Detalle con argumentos'),
            ),
            const SizedBox(height: 16),

            // ── pushReplacementNamed ───────────────────────────────────────
            const _Subtitulo('pushReplacementNamed'),
            const Text(
              'Reemplaza la ruta actual. No se puede volver atrás.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 4),
            OutlinedButton(
              onPressed: () {
                // pushReplacementNamed: útil para reemplazar splash por inicio
                // o para cambiar entre secciones principales sin historial.
                Navigator.pushReplacementNamed(context, Rutas.ajustes);
              },
              child: const Text('Ir a Ajustes (sin volver)'),
            ),
            const SizedBox(height: 16),

            // ── pushNamedAndRemoveUntil ────────────────────────────────────
            const _Subtitulo('pushNamedAndRemoveUntil'),
            const Text(
              'Limpia toda la pila y navega. Útil en logout.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 4),
            OutlinedButton(
              onPressed: () {
                // ModalRoute.withName('/') como predicate elimina todo hasta '/'.
                // (ModalRoute.withName('') elimina TODO el historial)
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Rutas.inicio,
                  (route) => false, // false = eliminar todas las rutas anteriores
                );
              },
              child: const Text('Reiniciar a Inicio (limpiar pila)'),
            ),
            const SizedBox(height: 24),

            // ── Ventajas y limitaciones ────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '⚠️ Limitaciones de Named Routes:\n'
                '• Argumentos no están tipados (son Object?)\n'
                '• No soportan deep linking en web por defecto\n'
                '• Difícil manejar rutas anidadas complejas\n'
                '→ Para apps medianas/grandes, usa go_router',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLAS DESTINO
// ────────────────────────────────────────────────────────────────────────────

/// Pantalla de perfil de usuario.
class PantallaPerfil extends StatelessWidget {
  const PantallaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return _PantallaSimple(
      titulo: 'Perfil',
      icono: Icons.person,
      color: Colors.blue,
      descripcion: 'Ruta: ${Rutas.perfil}\nNavegado con pushNamed.',
    );
  }
}

/// Pantalla de ajustes.
class PantallaAjustes extends StatelessWidget {
  const PantallaAjustes({super.key});

  @override
  Widget build(BuildContext context) {
    return _PantallaSimple(
      titulo: 'Ajustes',
      icono: Icons.settings,
      color: Colors.grey,
      descripcion:
          'Ruta: ${Rutas.ajustes}\nNavegado con pushReplacementNamed.\nNo puedes volver a Inicio desde aquí.',
      mostrarBotonInicio: true,
    );
  }
}

/// Pantalla de detalle que recibe argumentos.
class PantallaDetalle extends StatelessWidget {
  final String titulo;
  final String descripcion;

  const PantallaDetalle({
    super.key,
    required this.titulo,
    required this.descripcion,
  });

  @override
  Widget build(BuildContext context) {
    return _PantallaSimple(
      titulo: titulo,
      icono: Icons.article,
      color: Colors.green,
      descripcion: descripcion,
    );
  }
}

/// Pantalla 404 para rutas no encontradas.
class PantallaNaoEncontrada extends StatelessWidget {
  const PantallaNaoEncontrada({super.key});

  @override
  Widget build(BuildContext context) {
    return _PantallaSimple(
      titulo: '404 — No encontrado',
      icono: Icons.error_outline,
      color: Colors.red,
      descripcion: 'Esta ruta no existe.',
      mostrarBotonInicio: true,
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// WIDGETS AUXILIARES
// ────────────────────────────────────────────────────────────────────────────

/// Pantalla genérica reutilizable para las pantallas de destino.
class _PantallaSimple extends StatelessWidget {
  final String titulo;
  final IconData icono;
  final Color color;
  final String descripcion;
  final bool mostrarBotonInicio;

  const _PantallaSimple({
    required this.titulo,
    required this.icono,
    required this.color,
    required this.descripcion,
    this.mostrarBotonInicio = false,
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
              Text(descripcion, textAlign: TextAlign.center),
              if (mostrarBotonInicio) ...[
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    Rutas.inicio,
                    (route) => false,
                  ),
                  child: const Text('Ir al Inicio'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Subtítulo de sección con estilo consistente.
class _Subtitulo extends StatelessWidget {
  final String texto;
  const _Subtitulo(this.texto);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(texto,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Agrega una ruta '/busqueda/:query' y maneja el parámetro dinámico
//      dentro de onGenerateRoute con una expresión regular.
//   2. Usa WillPopScope (o PopScope en Flutter 3.12+) para interceptar
//      el botón de atrás y mostrar un diálogo de confirmación.
//   3. Intenta navegar a '/ruta-inexistente' para ver la pantalla onUnknownRoute.
// =============================================================================
