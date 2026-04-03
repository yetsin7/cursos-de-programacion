// =============================================================================
// ARCHIVO: 05_ejercicios.dart
// TEMA: Ejercicios de práctica — Navegación en Flutter
// =============================================================================
//
// Tres ejercicios para practicar la navegación: wizard de pasos,
// navegación con historial y pantalla de detalle con datos.
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
      title: 'Ejercicios Navegación',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const PantallaMenu(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// MENÚ DE EJERCICIOS
// ────────────────────────────────────────────────────────────────────────────

/// Menú principal con botones para abrir cada ejercicio.
class PantallaMenu extends StatelessWidget {
  const PantallaMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicios — Módulo 16'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _BotonEjercicio(
              numero: '1',
              titulo: 'Wizard de pasos',
              descripcion: 'Formulario multi-pantalla con paso a paso',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EjercicioWizard()),
              ),
            ),
            const SizedBox(height: 12),
            _BotonEjercicio(
              numero: '2',
              titulo: 'Lista → Detalle',
              descripcion: 'Navegar de una lista a un detalle y volver',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EjercicioListaDetalle()),
              ),
            ),
            const SizedBox(height: 12),
            _BotonEjercicio(
              numero: '3',
              titulo: 'TabBar con contenido',
              descripcion: 'Tabs superiores con contenido diferente',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EjercicioTabBar()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BotonEjercicio extends StatelessWidget {
  final String numero;
  final String titulo;
  final String descripcion;
  final VoidCallback onTap;

  const _BotonEjercicio({
    required this.numero,
    required this.titulo,
    required this.descripcion,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.primaryContainer.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.primary.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.primary,
              child: Text(numero,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titulo,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(descripcion,
                      style: const TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 1 — WIZARD DE PASOS
// ────────────────────────────────────────────────────────────────────────────

/// Wizard de registro de 3 pasos. Cada pantalla pasa datos a la siguiente.
class EjercicioWizard extends StatelessWidget {
  const EjercicioWizard({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PasoUno();
  }
}

class _PasoUno extends StatefulWidget {
  const _PasoUno();

  @override
  State<_PasoUno> createState() => _PasoUnoState();
}

class _PasoUnoState extends State<_PasoUno> {
  final _nombre = TextEditingController();

  @override
  void dispose() { _nombre.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paso 1 de 3 — Nombre')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LinearProgressIndicator(value: 0.33),
            const SizedBox(height: 24),
            const Text('¿Cómo te llamas?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _nombre,
              decoration: const InputDecoration(
                labelText: 'Nombre completo',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () {
                if (_nombre.text.isEmpty) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => _PasoDos(nombre: _nombre.text),
                  ),
                );
              },
              child: const Text('Siguiente →'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PasoDos extends StatefulWidget {
  final String nombre;
  const _PasoDos({required this.nombre});

  @override
  State<_PasoDos> createState() => _PasosDosState();
}

class _PasosDosState extends State<_PasoDos> {
  String _ocupacion = 'Desarrollador';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paso 2 de 3 — Ocupación')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LinearProgressIndicator(value: 0.66),
            const SizedBox(height: 24),
            Text('Hola, ${widget.nombre}. ¿A qué te dedicas?',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...['Desarrollador', 'Diseñador', 'Estudiante', 'Otro'].map(
              (op) => RadioListTile<String>(
                title: Text(op),
                value: op,
                groupValue: _ocupacion,
                onChanged: (v) => setState(() => _ocupacion = v!),
              ),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => _PasoTres(
                      nombre: widget.nombre,
                      ocupacion: _ocupacion,
                    ),
                  ),
                );
              },
              child: const Text('Siguiente →'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PasoTres extends StatelessWidget {
  final String nombre;
  final String ocupacion;
  const _PasoTres({required this.nombre, required this.ocupacion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paso 3 de 3 — Confirmación')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LinearProgressIndicator(value: 1.0),
            const SizedBox(height: 24),
            const Icon(Icons.check_circle, size: 64, color: Colors.green),
            const SizedBox(height: 16),
            const Text('¡Todo listo!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text('Nombre: $nombre\nOcupación: $ocupacion',
                textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            FilledButton(
              onPressed: () =>
                  Navigator.popUntil(context, (r) => r.isFirst),
              child: const Text('Finalizar y volver al inicio'),
            ),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 2 — LISTA → DETALLE
// ────────────────────────────────────────────────────────────────────────────

/// Lista de películas con navegación a su detalle.
class EjercicioListaDetalle extends StatelessWidget {
  const EjercicioListaDetalle({super.key});

  static const _peliculas = [
    ('El Origen', 2010, '★★★★★'),
    ('Interestelar', 2014, '★★★★★'),
    ('El Caballero Oscuro', 2008, '★★★★★'),
    ('Oppenheimer', 2023, '★★★★☆'),
    ('Dunkerque', 2017, '★★★★☆'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Películas')),
      body: ListView.builder(
        itemCount: _peliculas.length,
        itemBuilder: (context, i) => ListTile(
          leading: const Icon(Icons.movie),
          title: Text(_peliculas[i].$1),
          subtitle: Text('${_peliculas[i].$2} · ${_peliculas[i].$3}'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => _DetallePelicula(
                titulo: _peliculas[i].$1,
                anio: _peliculas[i].$2,
                calificacion: _peliculas[i].$3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DetallePelicula extends StatelessWidget {
  final String titulo;
  final int anio;
  final String calificacion;
  const _DetallePelicula(
      {required this.titulo, required this.anio, required this.calificacion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.movie, size: 72, color: Colors.indigo),
            const SizedBox(height: 12),
            Text(titulo,
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Año: $anio'),
            Text(calificacion, style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 3 — TABBAR
// ────────────────────────────────────────────────────────────────────────────

/// TabBar con tres pestañas superiores: Populares, Recientes, Guardados.
class EjercicioTabBar extends StatelessWidget {
  const EjercicioTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Artículos'),
          bottom: const TabBar(tabs: [
            Tab(text: 'Populares'),
            Tab(text: 'Recientes'),
            Tab(text: 'Guardados'),
          ]),
        ),
        body: TabBarView(children: [
          _ListaArticulos(titulo: 'Populares', cantidad: 5),
          _ListaArticulos(titulo: 'Recientes', cantidad: 3),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bookmark_border, size: 48, color: Colors.grey),
                Text('Sin artículos guardados'),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class _ListaArticulos extends StatelessWidget {
  final String titulo;
  final int cantidad;
  const _ListaArticulos({required this.titulo, required this.cantidad});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cantidad,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, i) => Card(
        child: ListTile(
          leading: const Icon(Icons.article),
          title: Text('$titulo — Artículo ${i + 1}'),
          subtitle: const Text('Toca para leer más'),
          onTap: () {},
        ),
      ),
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. En el wizard, agrega un botón "Cancelar" que vuelva al inicio usando
//      Navigator.popUntil(context, ModalRoute.withName('/')) o (r) => r.isFirst.
//   2. En Lista→Detalle, agrega un Hero widget en la imagen para crear una
//      transición de elemento compartido entre la lista y el detalle.
//   3. En TabBar, agrega un badge con el número de artículos en cada tab
//      usando Tab(child: Badge(label: Text('5'), child: Text('Populares'))).
// =============================================================================
