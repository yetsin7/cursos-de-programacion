// =============================================================================
// ARCHIVO: 02_textfield.dart
// TEMA: TextField y TextEditingController en Flutter
// =============================================================================
//
// TextField es el widget de entrada de texto de Flutter. TextEditingController
// permite leer, modificar y escuchar cambios en el texto. FocusNode controla
// cuál campo tiene el foco (teclado activo). InputDecoration personaliza la
// apariencia visual del campo.
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
      title: 'TextField Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const PantallaTextField(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA PRINCIPAL
// ────────────────────────────────────────────────────────────────────────────

/// Formulario de registro que demuestra las funcionalidades de TextField.
class PantallaTextField extends StatefulWidget {
  const PantallaTextField({super.key});

  @override
  State<PantallaTextField> createState() => _PantallaTextFieldState();
}

class _PantallaTextFieldState extends State<PantallaTextField> {
  // TextEditingController: permite leer y modificar el texto del campo.
  // SIEMPRE debe ser descartado en dispose() para liberar memoria.
  final _controladorNombre = TextEditingController();
  final _controladorEmail = TextEditingController();
  final _controladorPassword = TextEditingController();
  final _controladorBio = TextEditingController();

  // FocusNode: controla el foco (teclado activo) de cada campo.
  final _focoNombre = FocusNode();
  final _focoEmail = FocusNode();
  final _focoPassword = FocusNode();

  // Estado de visibilidad de la contraseña.
  bool _verPassword = false;

  // Texto en tiempo real del campo nombre.
  String _nombreEnTiempoReal = '';

  @override
  void dispose() {
    // Liberar los controladores y FocusNodes al destruir el widget.
    // Si no se hace, Flutter lanza una advertencia de memory leak.
    _controladorNombre.dispose();
    _controladorEmail.dispose();
    _controladorPassword.dispose();
    _controladorBio.dispose();
    _focoNombre.dispose();
    _focoEmail.dispose();
    _focoPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextField y Formularios'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCampoNombre(),
            const SizedBox(height: 16),
            _buildCampoEmail(),
            const SizedBox(height: 16),
            _buildCampoPassword(),
            const SizedBox(height: 16),
            _buildCampoBio(),
            const SizedBox(height: 24),
            _buildBotonesAccion(),
          ],
        ),
      ),
    );
  }

  // ── Campo nombre ─────────────────────────────────────────────────────────

  /// Campo de nombre con onChanged para actualizar en tiempo real.
  Widget _buildCampoNombre() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controladorNombre,
          // focusNode: asocia un FocusNode para controlar el foco.
          focusNode: _focoNombre,
          // textCapitalization: capitaliza automáticamente el inicio de palabras.
          textCapitalization: TextCapitalization.words,
          // onChanged: se llama cada vez que el texto cambia.
          onChanged: (valor) => setState(() => _nombreEnTiempoReal = valor),
          // onSubmitted: se llama al presionar Enter o la tecla de acción.
          // Aquí movemos el foco al siguiente campo.
          onSubmitted: (_) => FocusScope.of(context).requestFocus(_focoEmail),
          // textInputAction: controla el ícono del botón de acción del teclado.
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Nombre completo',
            hintText: 'Ej: María García',
            // prefixIcon: ícono a la izquierda dentro del campo.
            prefixIcon: Icon(Icons.person_outline),
            border: OutlineInputBorder(),
          ),
        ),
        if (_nombreEnTiempoReal.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 12),
            child: Text(
              'Hola, $_nombreEnTiempoReal 👋',
              style: TextStyle(color: Colors.teal.shade700, fontSize: 12),
            ),
          ),
      ],
    );
  }

  // ── Campo email ──────────────────────────────────────────────────────────

  /// Campo de email con teclado especializado.
  Widget _buildCampoEmail() {
    return TextField(
      controller: _controladorEmail,
      focusNode: _focoEmail,
      // keyboardType: muestra el teclado adecuado para el tipo de dato.
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onSubmitted: (_) => FocusScope.of(context).requestFocus(_focoPassword),
      decoration: const InputDecoration(
        labelText: 'Correo electrónico',
        hintText: 'ejemplo@correo.com',
        prefixIcon: Icon(Icons.email_outlined),
        border: OutlineInputBorder(),
      ),
    );
  }

  // ── Campo password ───────────────────────────────────────────────────────

  /// Campo de contraseña con toggle de visibilidad.
  Widget _buildCampoPassword() {
    return TextField(
      controller: _controladorPassword,
      focusNode: _focoPassword,
      // obscureText: oculta el texto con puntos (modo contraseña).
      obscureText: !_verPassword,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        prefixIcon: const Icon(Icons.lock_outline),
        border: const OutlineInputBorder(),
        // suffixIcon: ícono a la derecha dentro del campo.
        suffixIcon: IconButton(
          icon: Icon(_verPassword ? Icons.visibility_off : Icons.visibility),
          onPressed: () => setState(() => _verPassword = !_verPassword),
          tooltip: _verPassword ? 'Ocultar contraseña' : 'Ver contraseña',
        ),
      ),
    );
  }

  // ── Campo bio (multilínea) ───────────────────────────────────────────────

  /// Campo de texto largo con múltiples líneas y límite de caracteres.
  Widget _buildCampoBio() {
    return TextField(
      controller: _controladorBio,
      // maxLines: nulo = expande verticalmente sin límite.
      // Un número específico fija la altura a esa cantidad de líneas.
      maxLines: 4,
      // minLines: altura mínima del campo.
      minLines: 3,
      // maxLength: muestra un contador y limita la entrada.
      maxLength: 200,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        labelText: 'Biografía',
        hintText: 'Cuéntanos sobre ti...',
        alignLabelWithHint: true, // alinea la etiqueta con la parte superior
        border: OutlineInputBorder(),
      ),
    );
  }

  // ── Botones de acción ────────────────────────────────────────────────────

  /// Botones para leer el contenido de los campos y limpiarlos.
  Widget _buildBotonesAccion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton(
          onPressed: () {
            // Leer el valor actual del TextEditingController.
            final nombre = _controladorNombre.text;
            final email = _controladorEmail.text;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$nombre — $email')),
            );
          },
          child: const Text('Registrarse'),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () {
            // .clear() vacía el campo y notifica a los listeners.
            _controladorNombre.clear();
            _controladorEmail.clear();
            _controladorPassword.clear();
            _controladorBio.clear();
            setState(() => _nombreEnTiempoReal = '');
          },
          child: const Text('Limpiar formulario'),
        ),
      ],
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Agrega un TextFormField dentro de un Form con GlobalKey<FormState>
//      para usar validación nativa (validator, formKey.currentState!.validate()).
//   2. Usa TextEditingController.addListener() en initState() para escuchar
//      cambios sin necesidad de onChanged en el TextField.
//   3. Prueba keyboardType: TextInputType.number junto con
//      inputFormatters: [FilteringTextInputFormatter.digitsOnly] para
//      aceptar solo números en el campo.
// =============================================================================
