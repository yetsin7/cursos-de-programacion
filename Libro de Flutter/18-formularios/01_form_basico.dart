// =============================================================================
// ARCHIVO: 01_form_basico.dart
// TEMA: Formularios básicos en Flutter con validación
// =============================================================================
// CÓMO USAR: copiar como lib/main.dart y ejecutar flutter run
// =============================================================================

import 'package:flutter/material.dart';

void main() => runApp(const AppFormBasico());

/// Punto de entrada de la aplicación de formulario básico.
class AppFormBasico extends StatelessWidget {
  const AppFormBasico({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario Básico',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const PantallaRegistro(),
    );
  }
}

/// Pantalla de registro con un formulario completo.
/// Demuestra el uso de Form, GlobalKey<FormState> y TextFormField.
class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key});

  @override
  State<PantallaRegistro> createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  // Clave global que permite acceder al estado del formulario desde fuera del widget
  final _formKey = GlobalKey<FormState>();

  // Controladores para acceder al texto ingresado
  final _nombreCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    // Liberar recursos de los controladores al destruir el widget
    _nombreCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  /// Valida el formulario y muestra un SnackBar si es correcto.
  /// Si hay errores, los muestra en cada campo correspondiente.
  void _enviarFormulario() {
    // validate() ejecuta todos los validators y retorna true si todos pasan
    if (_formKey.currentState!.validate()) {
      // save() llama al onSaved de cada TextFormField (opcional)
      _formKey.currentState!.save();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registro exitoso para ${_nombreCtrl.text}'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Limpiar el formulario después de enviar
      _formKey.currentState!.reset();
      _nombreCtrl.clear();
      _emailCtrl.clear();
      _passwordCtrl.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario Básico'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Crear cuenta',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Completa todos los campos para registrarte.'),
              const SizedBox(height: 32),

              // Campo: Nombre completo
              TextFormField(
                controller: _nombreCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  hintText: 'Ej: María García',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.words,
                // validator retorna null si es válido, o un mensaje de error
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  if (valor.trim().length < 3) {
                    return 'El nombre debe tener al menos 3 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo: Correo electrónico
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  hintText: 'correo@ejemplo.com',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'El correo es obligatorio';
                  }
                  // Expresión regular básica para validar email
                  final regExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!regExp.hasMatch(valor.trim())) {
                    return 'Ingresa un correo válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo: Contraseña
              TextFormField(
                controller: _passwordCtrl,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'La contraseña es obligatoria';
                  }
                  if (valor.length < 6) {
                    return 'Mínimo 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Botón para enviar el formulario
              ElevatedButton(
                onPressed: _enviarFormulario,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Registrarse', style: TextStyle(fontSize: 16)),
              ),

              const SizedBox(height: 12),

              // Botón para limpiar el formulario manualmente
              TextButton(
                onPressed: () {
                  _formKey.currentState!.reset();
                  _nombreCtrl.clear();
                  _emailCtrl.clear();
                  _passwordCtrl.clear();
                },
                child: const Text('Limpiar formulario'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
