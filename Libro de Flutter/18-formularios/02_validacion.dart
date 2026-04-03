// =============================================================================
// ARCHIVO: 02_validacion.dart
// TEMA: Validaciones avanzadas, FocusNode y AutovalidateMode
// =============================================================================
// CÓMO USAR: copiar como lib/main.dart y ejecutar flutter run
// =============================================================================

import 'package:flutter/material.dart';

void main() => runApp(const AppValidacion());

/// App que demuestra validaciones avanzadas en formularios.
class AppValidacion extends StatelessWidget {
  const AppValidacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Validaciones Avanzadas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const PantallaValidacion(),
    );
  }
}

/// Pantalla con validaciones avanzadas: email, contraseñas y FocusNode.
class PantallaValidacion extends StatefulWidget {
  const PantallaValidacion({super.key});

  @override
  State<PantallaValidacion> createState() => _PantallaValidacionState();
}

class _PantallaValidacionState extends State<PantallaValidacion> {
  final _formKey = GlobalKey<FormState>();

  // FocusNodes para mover el foco entre campos con el teclado
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusConfirm = FocusNode();

  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  // Estado para mostrar/ocultar las contraseñas
  bool _verPassword = false;
  bool _verConfirm = false;

  // Modo de validación: valida al interactuar con cada campo
  final _autovalidateMode = AutovalidateMode.onUserInteraction;

  @override
  void dispose() {
    _focusEmail.dispose();
    _focusPassword.dispose();
    _focusConfirm.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  /// Valida que el texto sea un email con formato correcto.
  String? _validarEmail(String? valor) {
    if (valor == null || valor.trim().isEmpty) return 'El correo es obligatorio';
    final regex = RegExp(r'^[\w\.\+\-]+@[\w\-]+\.[a-zA-Z]{2,}$');
    if (!regex.hasMatch(valor.trim())) return 'Formato de correo inválido';
    return null;
  }

  /// Valida la contraseña: longitud mínima y al menos un número.
  String? _validarPassword(String? valor) {
    if (valor == null || valor.isEmpty) return 'La contraseña es obligatoria';
    if (valor.length < 8) return 'Mínimo 8 caracteres';
    if (!valor.contains(RegExp(r'[0-9]'))) return 'Debe incluir al menos un número';
    return null;
  }

  /// Valida que la confirmación coincida con la contraseña original.
  String? _validarConfirmar(String? valor) {
    if (valor == null || valor.isEmpty) return 'Confirma tu contraseña';
    if (valor != _passwordCtrl.text) return 'Las contraseñas no coinciden';
    return null;
  }

  void _enviar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Formulario válido — datos guardados'),
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Validaciones Avanzadas'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Información sobre AutovalidateMode
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('AutovalidateMode activo:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('• onUserInteraction: valida al tocar el campo'),
                      Text('• always: valida constantemente'),
                      Text('• disabled: solo al llamar validate()'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Campo email con FocusNode — al presionar "siguiente" en el teclado,
              // el foco pasa al campo de contraseña
              TextFormField(
                controller: _emailCtrl,
                focusNode: _focusEmail,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_focusPassword),
                validator: _validarEmail,
              ),
              const SizedBox(height: 16),

              // Campo contraseña con ojo para mostrar/ocultar
              TextFormField(
                controller: _passwordCtrl,
                focusNode: _focusPassword,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_verPassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _verPassword = !_verPassword),
                    tooltip: _verPassword ? 'Ocultar' : 'Mostrar',
                  ),
                  helperText: 'Mínimo 8 caracteres, incluir números',
                ),
                obscureText: !_verPassword,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_focusConfirm),
                validator: _validarPassword,
              ),
              const SizedBox(height: 16),

              // Campo confirmar contraseña
              TextFormField(
                controller: _confirmCtrl,
                focusNode: _focusConfirm,
                decoration: InputDecoration(
                  labelText: 'Confirmar contraseña',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_verConfirm ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _verConfirm = !_verConfirm),
                  ),
                ),
                obscureText: !_verConfirm,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _enviar(),
                validator: _validarConfirmar,
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: _enviar,
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16)),
                child: const Text('Crear cuenta', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
