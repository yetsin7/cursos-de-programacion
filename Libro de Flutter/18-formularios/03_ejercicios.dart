// =============================================================================
// ARCHIVO: 03_ejercicios.dart
// TEMA: Ejercicios de formularios en Flutter
// =============================================================================
// CÓMO USAR: copiar como lib/main.dart y ejecutar flutter run
// =============================================================================

import 'package:flutter/material.dart';

void main() => runApp(const AppEjerciciosFormularios());

/// App con ejercicios prácticos de formularios.
class AppEjerciciosFormularios extends StatelessWidget {
  const AppEjerciciosFormularios({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicios: Formularios',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PantallaEjercicios(),
    );
  }
}

/// Lista de ejercicios disponibles para practicar formularios.
class PantallaEjercicios extends StatelessWidget {
  const PantallaEjercicios({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicios: Formularios'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _TarjetaEjercicio(
            numero: 1,
            titulo: 'Formulario de contacto',
            descripcion: 'Crea un formulario con: nombre, teléfono (solo dígitos) '
                'y mensaje (mínimo 20 caracteres).',
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const _EjercicioContacto())),
          ),
          _TarjetaEjercicio(
            numero: 2,
            titulo: 'Formulario de pago',
            descripcion: 'Crea un formulario con: número de tarjeta (16 dígitos), '
                'fecha de vencimiento (MM/AA) y CVV (3-4 dígitos).',
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const _EjercicioPago())),
          ),
          _TarjetaEjercicio(
            numero: 3,
            titulo: 'Formulario de dirección',
            descripcion: 'Crea un formulario de dirección de envío completo '
                'con DropdownButtonFormField para seleccionar el país.',
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const _EjercicioDireccion())),
          ),
        ],
      ),
    );
  }
}

/// Tarjeta visual para cada ejercicio.
class _TarjetaEjercicio extends StatelessWidget {
  final int numero;
  final String titulo;
  final String descripcion;
  final VoidCallback onTap;

  const _TarjetaEjercicio({
    required this.numero,
    required this.titulo,
    required this.descripcion,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: tema.colorScheme.primaryContainer,
          child: Text('$numero',
              style: TextStyle(
                  color: tema.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold)),
        ),
        title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(descripcion),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Ejercicio 1: Formulario de contacto
// ─────────────────────────────────────────────

/// Solución del ejercicio 1: formulario de contacto.
class _EjercicioContacto extends StatefulWidget {
  const _EjercicioContacto();

  @override
  State<_EjercicioContacto> createState() => _EjercicioContactoState();
}

class _EjercicioContactoState extends State<_EjercicioContacto> {
  final _key = GlobalKey<FormState>();

  void _enviar() {
    if (_key.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mensaje enviado'), backgroundColor: Colors.green),
      );
      _key.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 1: Contacto')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Nombre', border: OutlineInputBorder()),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Teléfono', border: OutlineInputBorder()),
                keyboardType: TextInputType.phone,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Campo requerido';
                  if (!RegExp(r'^\d+$').hasMatch(v.trim())) return 'Solo dígitos';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Mensaje', border: OutlineInputBorder()),
                maxLines: 4,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Campo requerido';
                  if (v.trim().length < 20) return 'Mínimo 20 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: _enviar, child: const Text('Enviar')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Ejercicio 2: Formulario de pago
// ─────────────────────────────────────────────

/// Solución del ejercicio 2: formulario de datos de pago.
class _EjercicioPago extends StatefulWidget {
  const _EjercicioPago();

  @override
  State<_EjercicioPago> createState() => _EjercicioPagoState();
}

class _EjercicioPagoState extends State<_EjercicioPago> {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 2: Pago')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Número de tarjeta', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Campo requerido';
                  if (!RegExp(r'^\d{16}$').hasMatch(v.replaceAll(' ', ''))) {
                    return 'Debe tener 16 dígitos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'MM/AA', border: OutlineInputBorder()),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Requerido';
                        if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(v)) return 'Formato MM/AA';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'CVV', border: OutlineInputBorder()),
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Requerido';
                        if (!RegExp(r'^\d{3,4}$').hasMatch(v)) return '3 o 4 dígitos';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Pago procesado'),
                          backgroundColor: Colors.green));
                    }
                  },
                  child: const Text('Pagar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Ejercicio 3: Formulario de dirección
// ─────────────────────────────────────────────

/// Solución del ejercicio 3: formulario de dirección con dropdown.
class _EjercicioDireccion extends StatefulWidget {
  const _EjercicioDireccion();

  @override
  State<_EjercicioDireccion> createState() => _EjercicioDireccionState();
}

class _EjercicioDireccionState extends State<_EjercicioDireccion> {
  final _key = GlobalKey<FormState>();
  String? _paisSeleccionado;
  final _paises = ['México', 'España', 'Colombia', 'Argentina', 'Chile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 3: Dirección')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Calle y número', border: OutlineInputBorder()),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Ciudad', border: OutlineInputBorder()),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                    labelText: 'País', border: OutlineInputBorder()),
                value: _paisSeleccionado,
                items: _paises
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (v) => setState(() => _paisSeleccionado = v),
                validator: (v) => v == null ? 'Selecciona un país' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Dirección guardada'),
                          backgroundColor: Colors.green));
                    }
                  },
                  child: const Text('Guardar dirección'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
