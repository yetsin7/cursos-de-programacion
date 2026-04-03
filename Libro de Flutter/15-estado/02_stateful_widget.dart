// =============================================================================
// ARCHIVO: 02_stateful_widget.dart
// TEMA: StatefulWidget — widgets con estado mutable
// =============================================================================
//
// StatefulWidget se usa cuando un widget necesita recordar información que
// puede cambiar. Está compuesto por DOS clases: el Widget (inmutable, configura)
// y el State<T> (mutable, almacena el estado y construye la UI).
// El ciclo de vida del State incluye: initState, build, setState, dispose.
//
// CÓMO USAR:
//   1. Crea un proyecto Flutter: flutter create mi_app
//   2. Reemplaza lib/main.dart con este archivo
//   3. Ejecuta: flutter run
//
// =============================================================================
import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(const MiApp());

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StatefulWidget',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PantallaStateful(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA PRINCIPAL
// ────────────────────────────────────────────────────────────────────────────

/// Pantalla que muestra ejemplos de StatefulWidget.
class PantallaStateful extends StatelessWidget {
  const PantallaStateful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StatefulWidget'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _ContadorClasico(),
            SizedBox(height: 24),
            _DemostracionCicloVida(),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// EJEMPLO 1 — CONTADOR CLÁSICO
// ────────────────────────────────────────────────────────────────────────────

/// El contador clásico de Flutter: el ejemplo canónico de StatefulWidget.
///
/// Demuestra la separación entre la clase Widget (configuración) y la
/// clase State<T> (estado mutable + lógica de UI).
class _ContadorClasico extends StatefulWidget {
  const _ContadorClasico();

  // createState() es el único método de la clase Widget.
  // Crea el objeto State<T> asociado a este widget.
  @override
  State<_ContadorClasico> createState() => _ContadorClasicoState();
}

// La clase State<T> contiene:
// - Las variables de estado (mutan con el tiempo)
// - El método build() que describe la UI
// - Los métodos del ciclo de vida
class _ContadorClasicoState extends State<_ContadorClasico> {
  // Variable de estado: cuando cambia, la UI se reconstruye.
  int _contador = 0;

  // initState() se llama UNA SOLA VEZ cuando el widget se monta.
  // Es el lugar correcto para:
  // - Inicializar controladores
  // - Suscribirse a streams
  // - Hacer una carga inicial de datos
  @override
  void initState() {
    super.initState(); // SIEMPRE llamar super.initState() primero
    // Inicialización del estado inicial.
    _contador = 0;
  }

  // dispose() se llama cuando el widget se destruye (sale de la pantalla).
  // Es el lugar correcto para LIBERAR recursos:
  // - Cancelar timers
  // - Cerrar streams
  // - Disponer controladores (TextEditingController, AnimationController)
  @override
  void dispose() {
    // Aquí liberaríamos recursos si los hubiera.
    super.dispose(); // SIEMPRE llamar super.dispose() al final
  }

  /// Incrementa el contador de forma segura usando setState.
  void _incrementar() {
    // setState() hace dos cosas:
    // 1. Ejecuta la función que le pasamos (actualiza las variables)
    // 2. Marca este widget como "sucio" y schedula una reconstrucción
    setState(() {
      _contador++; // solo actualización de estado, NUNCA lógica pesada aquí
    });
  }

  /// Decrementa el contador sin ir por debajo de cero.
  void _decrementar() {
    if (_contador > 0) setState(() => _contador--);
  }

  /// Reinicia el contador a cero.
  void _reiniciar() {
    setState(() => _contador = 0);
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text('Contador clásico',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          // Muestra el valor actual del estado.
          Text(
            '$_contador',
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
              color: color.primary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FilledButton.tonal(
                onPressed: _decrementar,
                child: const Icon(Icons.remove),
              ),
              OutlinedButton(
                onPressed: _reiniciar,
                child: const Text('Reiniciar'),
              ),
              FilledButton(
                onPressed: _incrementar,
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// EJEMPLO 2 — CICLO DE VIDA VISIBLE
// ────────────────────────────────────────────────────────────────────────────

/// Widget que registra cada llamada del ciclo de vida para hacerlo visible.
///
/// Un temporizador actualiza la UI cada segundo para mostrar que build()
/// se llama periódicamente cuando el estado cambia.
class _DemostracionCicloVida extends StatefulWidget {
  const _DemostracionCicloVida();

  @override
  State<_DemostracionCicloVida> createState() =>
      _DemostracionCicloVidaState();
}

class _DemostracionCicloVidaState extends State<_DemostracionCicloVida> {
  // Registro de eventos del ciclo de vida.
  final List<String> _eventos = [];
  Timer? _timer;
  int _segundos = 0;

  @override
  void initState() {
    super.initState();
    _agregarEvento('initState() — widget montado');
    // Timer que actualiza el estado cada segundo para demostrar
    // que build() se llama cada vez que setState() se invoca.
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) { // mounted: true si el widget sigue en el árbol
        setState(() {
          _segundos++;
          if (_segundos <= 5) {
            _agregarEvento('setState() → build() #$_segundos');
          }
        });
      }
    });
  }

  @override
  void dispose() {
    // IMPORTANTE: cancelar el timer aquí.
    // Si no se cancela, el timer seguirá llamando setState después de
    // que el widget sea destruido → error de "use after dispose".
    _timer?.cancel();
    _agregarEvento('dispose() — widget destruido');
    super.dispose();
  }

  /// Agrega un evento al registro con timestamp.
  void _agregarEvento(String evento) {
    _eventos.insert(0, evento); // insertar al inicio para ver los más recientes
    if (_eventos.length > 8) _eventos.removeLast(); // máximo 8 eventos
  }

  @override
  Widget build(BuildContext context) {
    _agregarEvento('build() — reconstrucción ${DateTime.now().second}s');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Ciclo de vida del State<T>',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Segundos transcurridos: $_segundos'),
        const SizedBox(height: 8),
        // Registro de eventos del ciclo de vida.
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _eventos
                .map((e) => Text(
                      '> $e',
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontFamily: 'monospace',
                        fontSize: 11,
                      ),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'El timer se cancela en dispose() para evitar memory leaks.',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Agrega didUpdateWidget() al State<T> del contador para ver cuándo
//      se llama (cuando el widget padre se reconstruye con nuevos parámetros).
//   2. Extrae la lógica del contador a una clase separada CounterController
//      y úsala desde el State — primer paso hacia Clean Architecture.
//   3. Agrega un parámetro al _ContadorClasico (ej: valorInicial: int = 0)
//      y úsalo en initState() para inicializar _contador. Observa que
//      widget.valorInicial da acceso a los parámetros del Widget desde State.
// =============================================================================
