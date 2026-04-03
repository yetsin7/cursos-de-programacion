// =============================================================================
// ARCHIVO: 03_setstate.dart
// TEMA: setState en profundidad — patrones, antipatrones y Keys
// =============================================================================
//
// setState es la forma más básica de actualizar la UI en Flutter. Es poderoso
// pero tiene limitaciones y patrones incorrectos que deben evitarse.
// Keys le dicen a Flutter cómo preservar la identidad de los widgets en el
// árbol cuando la lista o el orden de los widgets cambia.
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
      title: 'setState en profundidad',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const PantallaSetState(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA PRINCIPAL
// ────────────────────────────────────────────────────────────────────────────

/// Pantalla con tabs para explorar setState en sus distintos escenarios.
class PantallaSetState extends StatelessWidget {
  const PantallaSetState({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('setState en profundidad'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: const TabBar(tabs: [
            Tab(text: 'Ejemplos'),
            Tab(text: 'Antipatrones'),
            Tab(text: 'Keys'),
          ]),
        ),
        body: const TabBarView(children: [
          _TabEjemplos(),
          _TabAntipatrones(),
          _TabKeys(),
        ]),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// TAB 1 — EJEMPLOS CORRECTOS DE SETSTATE
// ────────────────────────────────────────────────────────────────────────────

/// Muestra setState en múltiples escenarios: contador, lista, toggle.
class _TabEjemplos extends StatefulWidget {
  const _TabEjemplos();

  @override
  State<_TabEjemplos> createState() => _TabEjemplosState();
}

class _TabEjemplosState extends State<_TabEjemplos> {
  int _contador = 0;
  bool _expandido = false;
  final List<String> _lista = ['Flutter', 'Dart', 'Firebase'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contador simple.
          const Text('Contador:', style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            children: [
              Text('$_contador', style: const TextStyle(fontSize: 32)),
              const SizedBox(width: 16),
              FilledButton(
                onPressed: () => setState(() => _contador++),
                child: const Icon(Icons.add),
              ),
            ],
          ),
          const Divider(height: 24),

          // Toggle de expansión.
          const Text('Toggle:', style: TextStyle(fontWeight: FontWeight.bold)),
          SwitchListTile(
            title: Text(_expandido ? 'Expandido' : 'Colapsado'),
            value: _expandido,
            onChanged: (v) => setState(() => _expandido = v),
          ),
          if (_expandido)
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text('Contenido visible cuando _expandido = true'),
            ),
          const Divider(height: 24),

          // Lista dinámica.
          const Text('Lista dinámica:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          ..._lista.map(
            (item) => ListTile(
              title: Text(item),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                // setState actualiza la lista completa al eliminar un elemento.
                onPressed: () => setState(() => _lista.remove(item)),
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () => setState(
              () => _lista.add('Item ${_lista.length + 1}'),
            ),
            icon: const Icon(Icons.add),
            label: const Text('Agregar elemento'),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// TAB 2 — ANTIPATRONES DE SETSTATE
// ────────────────────────────────────────────────────────────────────────────

/// Documenta los errores más comunes al usar setState.
class _TabAntipatrones extends StatefulWidget {
  const _TabAntipatrones();

  @override
  State<_TabAntipatrones> createState() => _TabAntipatronesState();
}

class _TabAntipatronesState extends State<_TabAntipatrones> {
  bool _cargando = false;
  String _resultado = '';

  // ✅ CORRECTO: lógica fuera de setState, solo asignación dentro.
  Future<void> _cargarCorrecto() async {
    setState(() => _cargando = true);

    // La lógica pesada (llamada a API, cálculos) va FUERA de setState.
    await Future.delayed(const Duration(seconds: 1));
    final datos = 'Datos cargados correctamente ✅';

    // Solo la asignación del resultado va DENTRO de setState.
    if (mounted) setState(() {
      _resultado = datos;
      _cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAntipatron(
            titulo: '❌ NUNCA: lógica pesada dentro de setState',
            codigo: 'setState(() {\n'
                '  // ❌ MAL: llamadas a API, cálculos pesados\n'
                '  // cálculo complejo...\n'
                '  resultado = calcularTodo(); // bloquea el thread\n'
                '});',
            solucion: '✅ BIEN: setState solo para asignar variables.\n'
                'La lógica va fuera, en funciones separadas.',
          ),
          const SizedBox(height: 16),
          _buildAntipatron(
            titulo: '❌ NUNCA: setState en dispose()',
            codigo: '@override\nvoid dispose() {\n'
                '  setState(() { _valor = 0; }); // ❌ lanza excepción\n'
                '  super.dispose();\n'
                '}',
            solucion: '✅ BIEN: usa mounted antes de setState en async:\n'
                'if (mounted) setState(() { ... });',
          ),
          const SizedBox(height: 16),
          _buildAntipatron(
            titulo: '❌ NUNCA: setState innecesario (mismo valor)',
            codigo: '// Si el valor no cambia, no llames setState:\nonChanged: (v) {\n'
                '  if (_valor == v) return; // ✅ Evita rebuild inútil\n'
                '  setState(() => _valor = v);\n'
                '}',
            solucion: '✅ BIEN: verifica si el valor realmente cambia\n'
                'antes de llamar setState.',
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _cargando ? null : _cargarCorrecto,
            child: Text(_cargando ? 'Cargando...' : 'Demo patrón correcto'),
          ),
          if (_resultado.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(_resultado),
          ],
        ],
      ),
    );
  }

  /// Construye una tarjeta de antipatrón con código y solución.
  Widget _buildAntipatron({
    required String titulo,
    required String codigo,
    required String solucion,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey.shade900,
            child: Text(codigo,
                style: const TextStyle(
                    color: Colors.redAccent,
                    fontFamily: 'monospace',
                    fontSize: 11)),
          ),
          const SizedBox(height: 4),
          Text(solucion,
              style: const TextStyle(color: Colors.green, fontSize: 12)),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// TAB 3 — KEYS
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra el propósito de los Keys en Flutter.
///
/// Sin Keys, Flutter puede confundir el estado de widgets en una lista
/// cuando cambia el orden. Con Keys, el estado sigue al widget correcto.
class _TabKeys extends StatefulWidget {
  const _TabKeys();

  @override
  State<_TabKeys> createState() => _TabKeysState();
}

class _TabKeysState extends State<_TabKeys> {
  // Lista de items sin Keys.
  List<String> _itemsSinKey = ['Rojo', 'Verde', 'Azul'];
  List<String> _itemsConKey = ['Rojo', 'Verde', 'Azul'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Las Keys identifican widgets únicamente en el árbol.\n'
            'Son especialmente importantes en listas reordenables.',
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 12),

          // Lista sin Keys: al reorganizar, el estado puede confundirse.
          const Text('Sin Keys:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          ..._itemsSinKey.map(
            (item) => _ItemListaSinKey(nombre: item),
          ),
          ElevatedButton(
            onPressed: () => setState(
              () => _itemsSinKey = _itemsSinKey.reversed.toList(),
            ),
            child: const Text('Invertir lista'),
          ),

          const SizedBox(height: 16),

          // Lista con ValueKey: Flutter preserva el estado correcto.
          const Text('Con ValueKey:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          ..._itemsConKey.map(
            // ValueKey(item) identifica cada widget por su valor único.
            (item) => _ItemListaConKey(key: ValueKey(item), nombre: item),
          ),
          ElevatedButton(
            onPressed: () => setState(
              () => _itemsConKey = _itemsConKey.reversed.toList(),
            ),
            child: const Text('Invertir lista'),
          ),
          const SizedBox(height: 8),
          const Text(
            'Marca checkboxes, luego invierte las listas para ver la diferencia.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

/// Item de lista SIN Key — el estado (checkbox) puede seguir la posición, no el item.
class _ItemListaSinKey extends StatefulWidget {
  final String nombre;
  const _ItemListaSinKey({required this.nombre});

  @override
  State<_ItemListaSinKey> createState() => _ItemListaState();
}

/// Item de lista CON Key — el estado (checkbox) sigue al item correcto.
class _ItemListaConKey extends StatefulWidget {
  final String nombre;
  const _ItemListaConKey({super.key, required this.nombre});

  @override
  State<_ItemListaConKey> createState() => _ItemListaState();
}

/// Estado compartido para ambos tipos de items de lista.
class _ItemListaState extends State<StatefulWidget> {
  bool _marcado = false;

  @override
  Widget build(BuildContext context) {
    // Accedemos al nombre por el tipo correcto según la subclase.
    final nombre = widget is _ItemListaSinKey
        ? (widget as _ItemListaSinKey).nombre
        : (widget as _ItemListaConKey).nombre;

    return CheckboxListTile(
      title: Text(nombre),
      value: _marcado,
      onChanged: (v) => setState(() => _marcado = v!),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. En la tab de Keys, marca algunos checkboxes y luego invierte ambas listas.
//      Observa cómo sin Keys los checks se quedan en las posiciones y no en
//      los items, mientras que con ValueKey siguen a los items correctos.
//   2. Prueba GlobalKey para acceder al State de un widget desde fuera:
//      final key = GlobalKey<_ContadorState>(); → key.currentState?._contador
//   3. Usa UniqueKey() para forzar que Flutter trate un widget como
//      completamente nuevo (útil para reiniciar animaciones).
// =============================================================================
