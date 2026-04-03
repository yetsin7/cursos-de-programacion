// =============================================================================
// ARCHIVO: 04_bottom_navigation.dart
// TEMA: Navegación por pestañas — BottomNavigationBar y NavigationBar
// =============================================================================
//
// BottomNavigationBar es el widget clásico de navegación por tabs en la parte
// inferior. NavigationBar es su reemplazo de Material 3 con diseño actualizado.
// IndexedStack preserva el estado de cada tab al cambiar entre ellos.
// También se muestra TabBar con TabBarView como alternativa horizontal.
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
      title: 'Navegación por Tabs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const PantallaPrincipal(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA PRINCIPAL CON NAVIGATIONBAR (MATERIAL 3)
// ────────────────────────────────────────────────────────────────────────────

/// Pantalla principal usando NavigationBar (Material 3) con IndexedStack.
///
/// IndexedStack es CLAVE para navegación por tabs: mantiene TODOS los
/// widgets montados pero solo muestra el activo. Esto preserva el scroll
/// y el estado de cada tab al cambiar entre ellos.
class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _tabActivo = 0;

  // Las pantallas se crean UNA SOLA VEZ y se preservan.
  // Con IndexedStack se mantienen montadas aunque no sean visibles.
  static const List<Widget> _pantallas = [
    _TabInicio(),
    _TabExplorar(),
    _TabNotificaciones(),
    _TabPerfil(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack: muestra solo el child en el índice [index].
      // Los demás permanecen montados en memoria pero invisibles.
      // Ventaja: el scroll y el estado de cada tab se preservan.
      // Desventaja: consume más memoria que reconstruir bajo demanda.
      body: IndexedStack(
        index: _tabActivo,
        children: _pantallas,
      ),

      // NavigationBar: la versión Material 3 del BottomNavigationBar.
      // Tiene indicador visual animado y diseño más moderno.
      bottomNavigationBar: NavigationBar(
        // selectedIndex: el tab actualmente activo.
        selectedIndex: _tabActivo,
        // onDestinationSelected: callback cuando el usuario toca un tab.
        onDestinationSelected: (index) =>
            setState(() => _tabActivo = index),
        // destinations: la lista de tabs con ícono y etiqueta.
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home), // ícono cuando está activo
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Explorar',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
            label: 'Alertas',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// CONTENIDO DE CADA TAB
// ────────────────────────────────────────────────────────────────────────────

/// Tab de inicio con lista de artículos.
class _TabInicio extends StatelessWidget {
  const _TabInicio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 8,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text('Artículo ${index + 1}'),
            subtitle: const Text('Toca un tab, vuelve y el scroll se preserva'),
          ),
        ),
      ),
    );
  }
}

/// Tab de explorar con cuadrícula.
class _TabExplorar extends StatelessWidget {
  const _TabExplorar();

  static const _categorias = [
    ('Flutter', Icons.flutter_dash, Colors.blue),
    ('Dart', Icons.code, Colors.green),
    ('Firebase', Icons.local_fire_department, Colors.orange),
    ('Diseño', Icons.design_services, Colors.purple),
    ('Backend', Icons.storage, Colors.red),
    ('Testing', Icons.bug_report, Colors.teal),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explorar'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.5,
        ),
        itemCount: _categorias.length,
        itemBuilder: (context, index) {
          final cat = _categorias[index];
          return Card(
            color: cat.$3.withValues(alpha: 0.1),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(cat.$2, size: 32, color: cat.$3),
                  const SizedBox(height: 4),
                  Text(cat.$1,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: cat.$3)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Tab de notificaciones.
class _TabNotificaciones extends StatelessWidget {
  const _TabNotificaciones();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_none, size: 64, color: Colors.grey),
            SizedBox(height: 8),
            Text('Sin notificaciones', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

/// Tab de perfil.
class _TabPerfil extends StatelessWidget {
  const _TabPerfil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 48,
              backgroundImage: NetworkImage(
                'https://picsum.photos/seed/user/100/100',
              ),
            ),
            const SizedBox(height: 12),
            const Text('Usuario Flutter',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('usuario@flutter.dev',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            // Muestra la comparativa de cuándo usar cada tipo de navegación.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('¿Bottom Nav vs Drawer vs TabBar?',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      _reglaTipo('BottomNav / NavigationBar',
                          '2–5 secciones principales'),
                      _reglaTipo('Drawer',
                          '5+ secciones o espacio limitado en pantalla'),
                      _reglaTipo('TabBar',
                          'Sub-secciones dentro de una pantalla'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _reglaTipo(String tipo, String cuando) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.arrow_right, size: 16),
          const SizedBox(width: 4),
          Expanded(child: Text('$tipo: $cuando', style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Reemplaza NavigationBar por BottomNavigationBar clásico y observa las
//      diferencias visuales. Agrega type: BottomNavigationBarType.fixed para
//      que siempre muestren la etiqueta (no solo el activo).
//   2. Reemplaza IndexedStack por un simple _pantallas[_tabActivo] y observa
//      que el scroll se pierde al cambiar de tab — esa es la diferencia.
//   3. Usa DefaultTabController + TabBar + TabBarView para implementar tabs
//      en la parte superior de una pantalla (patrón común en categorías).
// =============================================================================
