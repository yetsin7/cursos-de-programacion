// =============================================================================
// ARCHIVO: 02_scaffold.dart
// TEMA: Scaffold y todos sus componentes
// =============================================================================
//
// Scaffold es el andamiaje visual de una pantalla Material. Implementa la
// estructura estándar de una pantalla: barra superior, cuerpo, menú lateral,
// barra inferior y botón flotante. Casi todas las pantallas de tu app
// tendrán un Scaffold como widget raíz.
//
// CÓMO USAR:
//   1. Crea un proyecto Flutter: flutter create mi_app
//   2. Reemplaza lib/main.dart con este archivo
//   3. Ejecuta: flutter run
//
// =============================================================================
import 'package:flutter/material.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scaffold Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const PantallaScaffold(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA CON TODOS LOS COMPONENTES DEL SCAFFOLD
// ────────────────────────────────────────────────────────────────────────────

/// Pantalla que demuestra todos los componentes disponibles en Scaffold.
class PantallaScaffold extends StatefulWidget {
  const PantallaScaffold({super.key});

  @override
  State<PantallaScaffold> createState() => _PantallaScaffoldState();
}

class _PantallaScaffoldState extends State<PantallaScaffold> {
  // Índice del ítem seleccionado en la barra de navegación inferior.
  int _tabSeleccionado = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ── AppBar ──────────────────────────────────────────────────────────
      // Barra superior de la pantalla. Siempre visible mientras el usuario
      // no haga scroll (salvo que uses SliverAppBar).
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        // leading: widget a la izquierda del título.
        // Por defecto, Flutter coloca aquí el botón de "atrás" o el
        // ícono del Drawer automáticamente si hay uno definido.
        leading: const Icon(Icons.flutter_dash),

        // title: el texto o widget central de la barra.
        title: const Text('Scaffold Demo'),

        // actions: lista de widgets a la derecha del título.
        // Ideal para íconos de búsqueda, notificaciones, perfil, etc.
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Buscar',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            tooltip: 'Más opciones',
            onPressed: () {},
          ),
        ],
      ),

      // ── Drawer ──────────────────────────────────────────────────────────
      // Menú lateral que se desliza desde la izquierda.
      // Se abre tocando el ícono de menú (≡) o deslizando desde el borde.
      // Úsalo cuando tienes muchas secciones de navegación (5 o más).
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // DrawerHeader: cabecera visual del drawer, generalmente con
            // la foto y nombre del usuario.
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Text(
                'Menú principal',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () => Navigator.pop(context), // cierra el drawer
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),

      // ── Body ────────────────────────────────────────────────────────────
      // El contenido principal de la pantalla. Ocupa todo el espacio
      // disponible entre el AppBar y el BottomNavigationBar.
      body: _CuerpoTab(tabActivo: _tabSeleccionado),

      // ── FloatingActionButton ─────────────────────────────────────────────
      // Botón circular flotante para la acción principal de la pantalla.
      // Material Design recomienda no tener más de uno por pantalla.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('¡FAB presionado!')),
          );
        },
        tooltip: 'Acción principal',
        child: const Icon(Icons.add),
      ),

      // floatingActionButtonLocation define la posición del FAB.
      // endFloat (por defecto), centerFloat, endDocked, centerDocked.
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      // ── BottomNavigationBar ───────────────────────────────────────────────
      // Barra de navegación en la parte inferior.
      // Ideal para 2–5 secciones principales de la app.
      // Para más secciones, considera un Drawer.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabSeleccionado,
        onTap: (index) => setState(() => _tabSeleccionado = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explorar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// CONTENIDO SEGÚN TAB ACTIVO
// ────────────────────────────────────────────────────────────────────────────

/// Muestra contenido diferente según el tab seleccionado en la barra inferior.
class _CuerpoTab extends StatelessWidget {
  final int tabActivo;
  const _CuerpoTab({required this.tabActivo});

  @override
  Widget build(BuildContext context) {
    const tabs = ['Inicio', 'Explorar', 'Perfil'];
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            [Icons.home, Icons.explore, Icons.person][tabActivo],
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Sección: ${tabs[tabActivo]}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text('Abre el drawer con el ícono ≡ de la AppBar'),
        ],
      ),
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Cambia floatingActionButtonLocation a FloatingActionButtonLocation
//      .centerDocked y añade shape: CircleBorder() al BottomNavigationBar
//      para lograr el efecto de FAB "encajado" en la barra inferior.
//   2. Agrega endDrawer: al Scaffold para tener un drawer en el lado derecho.
//   3. Reemplaza BottomNavigationBar por NavigationBar (Material 3) para ver
//      el diseño más moderno con indicador visual animado.
//   4. Prueba resizeToAvoidBottomInset: false para que el teclado no empuje
//      el contenido hacia arriba.
// =============================================================================
