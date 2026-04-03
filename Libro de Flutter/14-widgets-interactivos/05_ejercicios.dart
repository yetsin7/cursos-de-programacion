// =============================================================================
// ARCHIVO: 05_ejercicios.dart
// TEMA: Ejercicios de práctica — Widgets interactivos
// =============================================================================
//
// Tres ejercicios para practicar widgets interactivos: formulario de login,
// panel de configuración y reproductor de música simulado.
//
// CÓMO USAR:
//   1. Crea un proyecto Flutter: flutter create mi_app
//   2. Reemplaza lib/main.dart con este archivo
//   3. Intenta resolver cada ejercicio ANTES de ver la solución
//   4. Ejecuta: flutter run
//
// =============================================================================
import 'package:flutter/material.dart';

void main() => runApp(const MiApp());

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicios Interactivos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const PantallaEjercicios(),
    );
  }
}

class PantallaEjercicios extends StatelessWidget {
  const PantallaEjercicios({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicios — Módulo 14'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(tabs: [
              Tab(text: 'Login'),
              Tab(text: 'Config'),
              Tab(text: 'Música'),
            ]),
            const Expanded(
              child: TabBarView(children: [
                _EjercicioLogin(),
                _EjercicioConfiguracion(),
                _EjercicioReproductor(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 1 — FORMULARIO DE LOGIN
// ────────────────────────────────────────────────────────────────────────────

/// EJERCICIO 1: Formulario de inicio de sesión.
///
/// OBJETIVO: Email + contraseña (con toggle de visibilidad) + checkbox
/// "Recordarme" + botón "Iniciar sesión" que valida que los campos no
/// estén vacíos.
class _EjercicioLogin extends StatefulWidget {
  const _EjercicioLogin();

  @override
  State<_EjercicioLogin> createState() => _EjercicioLoginState();
}

class _EjercicioLoginState extends State<_EjercicioLogin> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _verPass = false;
  bool _recordarme = false;
  String _mensaje = '';

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _iniciarSesion() {
    if (_email.text.isEmpty || _password.text.isEmpty) {
      setState(() => _mensaje = 'Por favor, completa todos los campos.');
      return;
    }
    setState(() => _mensaje = '✅ Inicio de sesión exitoso (simulado)');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          const Icon(Icons.lock_outline, size: 64, color: Colors.blue),
          const SizedBox(height: 16),
          const Text(
            'Iniciar sesión',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Correo electrónico',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _password,
            obscureText: !_verPass,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _iniciarSesion(),
            decoration: InputDecoration(
              labelText: 'Contraseña',
              prefixIcon: const Icon(Icons.lock_outline),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(_verPass ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setState(() => _verPass = !_verPass),
              ),
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            title: const Text('Recordarme'),
            value: _recordarme,
            onChanged: (v) => setState(() => _recordarme = v!),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _iniciarSesion,
            child: const Text('Iniciar sesión'),
          ),
          if (_mensaje.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(_mensaje, textAlign: TextAlign.center,
                style: TextStyle(
                  color: _mensaje.startsWith('✅') ? Colors.green : Colors.red,
                )),
          ],
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 2 — PANEL DE CONFIGURACIÓN
// ────────────────────────────────────────────────────────────────────────────

/// EJERCICIO 2: Panel de ajustes con switches y un slider de tamaño de texto.
class _EjercicioConfiguracion extends StatefulWidget {
  const _EjercicioConfiguracion();

  @override
  State<_EjercicioConfiguracion> createState() =>
      _EjercicioConfiguracionState();
}

class _EjercicioConfiguracionState extends State<_EjercicioConfiguracion> {
  bool _notif = true;
  bool _sonido = true;
  bool _wifi = false;
  double _tamTexto = 16;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SwitchListTile(
          title: const Text('Notificaciones'),
          secondary: const Icon(Icons.notifications_outlined),
          value: _notif,
          onChanged: (v) => setState(() => _notif = v),
        ),
        SwitchListTile(
          title: const Text('Sonido'),
          secondary: const Icon(Icons.volume_up_outlined),
          value: _sonido,
          onChanged: (v) => setState(() => _sonido = v),
        ),
        SwitchListTile(
          title: const Text('Guardar con WiFi'),
          secondary: const Icon(Icons.wifi),
          value: _wifi,
          onChanged: (v) => setState(() => _wifi = v),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tamaño de texto: ${_tamTexto.round()}pt',
                  style: const TextStyle(fontWeight: FontWeight.w500)),
              Slider(
                value: _tamTexto,
                min: 12,
                max: 24,
                divisions: 6,
                label: '${_tamTexto.round()}pt',
                onChanged: (v) => setState(() => _tamTexto = v),
              ),
              Center(
                child: Text(
                  'Texto de ejemplo',
                  style: TextStyle(fontSize: _tamTexto),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// EJERCICIO 3 — REPRODUCTOR DE MÚSICA SIMULADO
// ────────────────────────────────────────────────────────────────────────────

/// EJERCICIO 3: Reproductor de música simulado con Slider de progreso,
/// botones de control y switches para shuffle y repeat.
class _EjercicioReproductor extends StatefulWidget {
  const _EjercicioReproductor();

  @override
  State<_EjercicioReproductor> createState() => _EjercicioReproductorState();
}

class _EjercicioReproductorState extends State<_EjercicioReproductor> {
  bool _reproduciendo = false;
  double _progreso = 0.35;
  bool _shuffle = false;
  bool _repeat = false;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Portada simulada.
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.primary, color.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.music_note, size: 80, color: Colors.white),
          ),
          const SizedBox(height: 24),
          const Text('Sinfonía en Flutter',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Text('Flutter Orchestra',
              style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),
          // Barra de progreso.
          Slider(
            value: _progreso,
            onChanged: (v) => setState(() => _progreso = v),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${(_progreso * 3).toStringAsFixed(1)}m'),
                const Text('3.0m'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Controles.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(_shuffle ? Icons.shuffle_on_outlined : Icons.shuffle,
                    color: _shuffle ? color.primary : null),
                onPressed: () => setState(() => _shuffle = !_shuffle),
              ),
              IconButton(
                icon: const Icon(Icons.skip_previous, size: 36),
                onPressed: () => setState(() => _progreso = 0),
              ),
              FilledButton(
                onPressed: () =>
                    setState(() => _reproduciendo = !_reproduciendo),
                style: FilledButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                ),
                child: Icon(_reproduciendo ? Icons.pause : Icons.play_arrow,
                    size: 32),
              ),
              IconButton(
                icon: const Icon(Icons.skip_next, size: 36),
                onPressed: () => setState(() => _progreso = 0),
              ),
              IconButton(
                icon: Icon(_repeat ? Icons.repeat_one : Icons.repeat,
                    color: _repeat ? color.primary : null),
                onPressed: () => setState(() => _repeat = !_repeat),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. En el ejercicio del reproductor, usa un Timer.periodic para que el
//      slider de progreso avance automáticamente mientras _reproduciendo = true.
//   2. En el formulario de login, agrega validación de formato de email
//      con una expresión regular.
//   3. En el panel de configuración, agrega un RadioListTile para seleccionar
//      el tema: 'claro', 'oscuro' o 'sistema'.
// =============================================================================
