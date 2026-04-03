// =============================================================================
// ARCHIVO: 01_listview.dart
// TEMA: ListView y sus variantes en Flutter
// =============================================================================
//
// ListView es el widget de lista más usado en Flutter. Su variante .builder
// es eficiente para listas largas gracias al lazy loading. .separated permite
// agregar separadores entre items. ListTile es el widget de fila estándar
// para ítems de lista con ícono, título, subtítulo y acción.
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
      title: 'ListView Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const PantallaListView(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// MODELO DE DATOS DE PRUEBA
// ────────────────────────────────────────────────────────────────────────────

/// Modelo de contacto para la demostración de ListTile.
class Contacto {
  final String nombre;
  final String telefono;
  final String inicial;
  final Color color;

  const Contacto({
    required this.nombre,
    required this.telefono,
    required this.inicial,
    required this.color,
  });
}

/// Lista de 50 contactos generados para demostrar ListView.builder con lazy loading.
List<Contacto> generarContactos() {
  final nombres = [
    'Ana García', 'Carlos López', 'María Martínez', 'José Rodríguez',
    'Laura Sánchez', 'Pedro González', 'Isabel Fernández', 'Miguel Díaz',
    'Carmen Ruiz', 'Francisco Jiménez',
  ];
  final colores = [
    Colors.blue, Colors.red, Colors.green, Colors.orange, Colors.purple,
    Colors.teal, Colors.pink, Colors.indigo, Colors.brown, Colors.cyan,
  ];
  return List.generate(50, (i) {
    final base = nombres[i % nombres.length];
    final nombre = i < nombres.length ? base : '$base ${i ~/ nombres.length}';
    return Contacto(
      nombre: nombre,
      telefono: '+34 6${(i * 13 + 55) % 100} ${(i * 7 + 21) % 100} ${i % 10}${i % 10} ${i % 10}${i % 10}',
      inicial: nombre[0],
      color: colores[i % colores.length],
    );
  });
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA PRINCIPAL CON TABS
// ────────────────────────────────────────────────────────────────────────────

/// Muestra las diferentes variantes de ListView en tabs separados.
class PantallaListView extends StatelessWidget {
  const PantallaListView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ListView'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: const TabBar(tabs: [
            Tab(text: 'builder'),
            Tab(text: 'separated'),
            Tab(text: 'básico'),
          ]),
        ),
        body: TabBarView(children: [
          _TabBuilder(),
          _TabSeparated(),
          const _TabBasico(),
        ]),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// TAB 1 — LISTVIEW.BUILDER
// ────────────────────────────────────────────────────────────────────────────

/// ListView.builder: crea items bajo demanda (lazy). Ideal para listas largas.
class _TabBuilder extends StatelessWidget {
  _TabBuilder();

  // Lista de 50 contactos.
  final _contactos = generarContactos();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'ListView.builder — ${_contactos.length} contactos (lazy loading)',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        Expanded(
          child: ListView.builder(
            // itemCount: cantidad total de items. OBLIGATORIO para que
            // Flutter sepa cuándo parar de generar.
            itemCount: _contactos.length,

            // itemBuilder: función que crea el widget para el índice dado.
            // Flutter la llama SOLO para los items visibles en pantalla.
            itemBuilder: (context, index) {
              final contacto = _contactos[index];
              return ListTile(
                // leading: widget a la izquierda (ícono, avatar, imagen).
                leading: CircleAvatar(
                  backgroundColor: contacto.color,
                  child: Text(
                    contacto.inicial,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                // title: texto principal del item.
                title: Text(contacto.nombre),
                // subtitle: texto secundario, más pequeño y gris.
                subtitle: Text(contacto.telefono),
                // trailing: widget a la derecha (ícono, texto, switch).
                trailing: IconButton(
                  icon: const Icon(Icons.call_outlined),
                  onPressed: () {},
                ),
                // onTap: callback al tocar el item.
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Contacto: ${contacto.nombre}')),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// TAB 2 — LISTVIEW.SEPARATED
// ────────────────────────────────────────────────────────────────────────────

/// ListView.separated: agrega un separador entre cada par de items.
class _TabSeparated extends StatelessWidget {
  _TabSeparated();

  final _contactos = generarContactos().take(15).toList();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _contactos.length,

      // separatorBuilder: widget entre cada par de items.
      // index es el índice del item ANTES del separador.
      separatorBuilder: (context, index) {
        // Separador más prominente cada 5 items (separador de sección).
        if ((index + 1) % 5 == 0) {
          return Container(
            height: 8,
            color: Colors.grey.shade100,
          );
        }
        // Separador estándar: Divider con indent para alinearse con el texto.
        return const Divider(height: 1, indent: 72);
      },

      itemBuilder: (context, index) {
        final c = _contactos[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: c.color,
            child: Text(c.inicial,
                style: const TextStyle(color: Colors.white)),
          ),
          title: Text(c.nombre),
          subtitle: Text(c.telefono),
          trailing: const Icon(Icons.chevron_right),
        );
      },
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// TAB 3 — LISTVIEW BÁSICO (children)
// ────────────────────────────────────────────────────────────────────────────

/// ListView con children directos: solo para listas CORTAS y fijas.
///
/// Crea todos los widgets de inmediato. Apropiado para máximo ~20-30 items.
/// Para listas largas, SIEMPRE usa ListView.builder.
class _TabBasico extends StatelessWidget {
  const _TabBasico();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            'ListView básico — solo para listas cortas',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        // ListTile con todas sus propiedades documentadas.
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('ListTile completo'),
          subtitle: const Text('Con leading, title, subtitle y trailing'),
          trailing: Switch(value: true, onChanged: (_) {}),
          onTap: () {},
        ),
        const Divider(),
        // Card con ListTile: da profundidad visual a cada item.
        Card(
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: const Text('ListTile dentro de Card'),
            subtitle: const Text('Más prominente visualmente'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.settings, color: Colors.grey),
            title: const Text('Configuración'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.help_outline, color: Colors.blue),
            title: const Text('Ayuda'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ),
        // ExpansionTile: item que se puede expandir para mostrar más contenido.
        const ExpansionTile(
          leading: Icon(Icons.info_outline),
          title: Text('Toca para expandir'),
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text('Contenido oculto que aparece al expandir el tile.'),
            ),
          ],
        ),
      ],
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Agrega un SearchBar en la parte superior del tab "builder" y filtra
//      la lista de contactos en tiempo real usando setState y .where().
//   2. Prueba ListView.builder con addAutomaticKeepAlives: false y observa
//      que los items se destruyen al salir de pantalla (útil para listas
//      muy largas donde la memoria es crítica).
//   3. Agrega Dismissible al ListTile para permitir deslizar para eliminar
//      un contacto de la lista.
// =============================================================================
