// =============================================================================
// ARCHIVO: 01_shared_preferences.dart
// TEMA: Persistencia de datos simples con shared_preferences
// =============================================================================
// CÓMO USAR: copiar como lib/main.dart y ejecutar flutter run
// DEPENDENCIA: agregar en pubspec.yaml: shared_preferences: ^2.3.2
// =============================================================================

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const AppSharedPrefs());

/// App que demuestra el uso de shared_preferences para persistir datos locales.
class AppSharedPrefs extends StatelessWidget {
  const AppSharedPrefs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Preferences',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber)),
      home: const PantallaSharedPrefs(),
    );
  }
}

/// Claves constantes para evitar typos al leer/escribir preferencias.
/// Se recomienda definirlas como constantes en un lugar centralizado.
class _Claves {
  static const String nombreUsuario = 'nombre_usuario';
  static const String onboardingCompletado = 'onboarding_completado';
  static const String contadorAperturas = 'contador_aperturas';
  static const String temaOscuro = 'tema_oscuro';
  static const String idioma = 'idioma';

  // Constructor privado — clase solo con constantes, no se instancia
  _Claves._();
}

/// Pantalla principal de demostración.
class PantallaSharedPrefs extends StatefulWidget {
  const PantallaSharedPrefs({super.key});

  @override
  State<PantallaSharedPrefs> createState() => _PantallaSharedPrefsState();
}

class _PantallaSharedPrefsState extends State<PantallaSharedPrefs> {
  // Instancia de SharedPreferences — se obtiene de forma asíncrona
  SharedPreferences? _prefs;

  // Valores leídos de las preferencias
  String _nombre = '';
  bool _onboardingCompletado = false;
  int _aperturas = 0;
  bool _temaOscuro = false;
  String _idioma = 'es';

  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarPreferencias();
  }

  /// Carga todas las preferencias guardadas al iniciar la pantalla.
  Future<void> _cargarPreferencias() async {
    // SharedPreferences.getInstance() es asíncrono — retorna el singleton
    _prefs = await SharedPreferences.getInstance();

    // Leer cada valor con su tipo y valor por defecto
    setState(() {
      _nombre = _prefs!.getString(_Claves.nombreUsuario) ?? '';
      _onboardingCompletado =
          _prefs!.getBool(_Claves.onboardingCompletado) ?? false;
      _aperturas = (_prefs!.getInt(_Claves.contadorAperturas) ?? 0) + 1;
      _temaOscuro = _prefs!.getBool(_Claves.temaOscuro) ?? false;
      _idioma = _prefs!.getString(_Claves.idioma) ?? 'es';
      _cargando = false;
    });

    // Guardar el nuevo contador de aperturas
    await _prefs!.setInt(_Claves.contadorAperturas, _aperturas);
  }

  /// Guarda el nombre del usuario.
  Future<void> _guardarNombre(String nombre) async {
    await _prefs!.setString(_Claves.nombreUsuario, nombre);
    setState(() => _nombre = nombre);
  }

  /// Marca el onboarding como completado.
  Future<void> _completarOnboarding() async {
    await _prefs!.setBool(_Claves.onboardingCompletado, true);
    setState(() => _onboardingCompletado = true);
  }

  /// Cambia el tema y persiste la preferencia.
  Future<void> _toggleTema(bool valor) async {
    await _prefs!.setBool(_Claves.temaOscuro, valor);
    setState(() => _temaOscuro = valor);
  }

  /// Cambia el idioma y persiste la preferencia.
  Future<void> _cambiarIdioma(String idioma) async {
    await _prefs!.setString(_Claves.idioma, idioma);
    setState(() => _idioma = idioma);
  }

  /// Elimina TODAS las preferencias guardadas (útil para cerrar sesión o resetear).
  Future<void> _limpiarTodo() async {
    await _prefs!.clear();
    await _cargarPreferencias();
  }

  @override
  Widget build(BuildContext context) {
    if (_cargando) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Shared Preferences'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Advertencia de seguridad
          Card(
            color: Colors.orange.shade50,
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(Icons.warning_amber, color: Colors.orange),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Shared Preferences NO está encriptado.\n'
                      'Nunca guardes contraseñas ni tokens sensibles aquí.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Contador de aperturas — se incrementa cada vez que inicia la app
          _FilaDato(
            icono: Icons.open_in_app,
            etiqueta: 'Aperturas de la app',
            valor: '$_aperturas veces',
          ),

          // Nombre de usuario guardado
          _FilaDato(
            icono: Icons.person_outline,
            etiqueta: 'Nombre guardado',
            valor: _nombre.isEmpty ? '(sin guardar)' : _nombre,
            accion: ElevatedButton(
              onPressed: () => _mostrarDialogoNombre(),
              child: const Text('Cambiar'),
            ),
          ),

          // Onboarding completado
          _FilaDato(
            icono: Icons.ondemand_video,
            etiqueta: 'Onboarding completado',
            valor: _onboardingCompletado ? 'Sí' : 'No',
            accion: _onboardingCompletado
                ? null
                : ElevatedButton(
                    onPressed: _completarOnboarding,
                    child: const Text('Completar'),
                  ),
          ),

          // Tema oscuro
          Card(
            child: SwitchListTile(
              secondary: const Icon(Icons.dark_mode_outlined),
              title: const Text('Tema oscuro'),
              subtitle: const Text('setBool / getBool'),
              value: _temaOscuro,
              onChanged: _toggleTema,
            ),
          ),

          // Idioma
          Card(
            child: ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Idioma'),
              subtitle: const Text('setString / getString'),
              trailing: DropdownButton<String>(
                value: _idioma,
                items: const [
                  DropdownMenuItem(value: 'es', child: Text('Español')),
                  DropdownMenuItem(value: 'en', child: Text('English')),
                ],
                onChanged: (v) => v != null ? _cambiarIdioma(v) : null,
              ),
            ),
          ),

          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: _limpiarTodo,
            icon: const Icon(Icons.delete_forever_outlined),
            label: const Text('Limpiar todas las preferencias'),
            style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    );
  }

  /// Muestra un diálogo para ingresar un nuevo nombre.
  void _mostrarDialogoNombre() {
    final ctrl = TextEditingController(text: _nombre);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Tu nombre'),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(labelText: 'Nombre'),
          autofocus: true,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              _guardarNombre(ctrl.text.trim());
              Navigator.pop(ctx);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}

/// Fila reutilizable para mostrar un dato persistido.
class _FilaDato extends StatelessWidget {
  final IconData icono;
  final String etiqueta;
  final String valor;
  final Widget? accion;

  const _FilaDato({
    required this.icono,
    required this.etiqueta,
    required this.valor,
    this.accion,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icono),
        title: Text(etiqueta),
        subtitle: Text(valor,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500)),
        trailing: accion,
      ),
    );
  }
}
