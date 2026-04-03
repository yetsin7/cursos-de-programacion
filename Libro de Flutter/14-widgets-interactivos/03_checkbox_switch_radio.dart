// =============================================================================
// ARCHIVO: 03_checkbox_switch_radio.dart
// TEMA: Checkbox, Switch y Radio en Flutter
// =============================================================================
//
// Checkbox permite selección múltiple (marcado/desmarcado). Switch es un
// toggle on/off. Radio permite selección única dentro de un grupo. Todos
// requieren estado (StatefulWidget + setState) para funcionar correctamente.
// Las variantes *ListTile integran el control con una fila de texto.
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
      title: 'Checkbox, Switch y Radio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const PantallaSeleccion(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA PRINCIPAL
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra Checkbox, Switch y Radio con su manejo de estado correcto.
class PantallaSeleccion extends StatefulWidget {
  const PantallaSeleccion({super.key});

  @override
  State<PantallaSeleccion> createState() => _PantallaSeleccionState();
}

class _PantallaSeleccionState extends State<PantallaSeleccion> {
  // ── Estado de Checkboxes ─────────────────────────────────────────────────
  bool _terminos = false;
  bool _newsletter = true;
  bool? _checkboxTrifasico; // null = estado indeterminado (tristate)

  // Lista para selección múltiple con checkboxes.
  final Map<String, bool> _intereses = {
    'Flutter': true,
    'Dart': false,
    'Firebase': true,
    'Supabase': false,
  };

  // ── Estado de Switches ───────────────────────────────────────────────────
  bool _notificaciones = true;
  bool _modoOscuro = false;
  bool _ubicacion = false;

  // ── Estado de Radio ──────────────────────────────────────────────────────
  String _planSeleccionado = 'basico';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkbox, Switch y Radio'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSeccionCheckbox(),
          const Divider(height: 32),
          _buildSeccionSwitch(),
          const Divider(height: 32),
          _buildSeccionRadio(),
        ],
      ),
    );
  }

  // ── Sección Checkbox ─────────────────────────────────────────────────────

  /// Checkbox básico y CheckboxListTile para selección múltiple.
  Widget _buildSeccionCheckbox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Checkbox',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // Checkbox básico: siempre necesita value y onChanged.
        Row(
          children: [
            Checkbox(
              value: _terminos,
              // onChanged recibe el nuevo valor booleano.
              onChanged: (valor) => setState(() => _terminos = valor!),
            ),
            GestureDetector(
              onTap: () => setState(() => _terminos = !_terminos),
              child: const Text('Acepto los términos y condiciones'),
            ),
          ],
        ),

        // Checkbox triestado: puede ser true, false o null (indeterminado).
        // Útil para "seleccionar todos" en una lista de items.
        Row(
          children: [
            Checkbox(
              tristate: true, // permite el estado null (indeterminado)
              value: _checkboxTrifasico,
              onChanged: (valor) => setState(() => _checkboxTrifasico = valor),
            ),
            const Text('Tristate (null = indeterminado)'),
          ],
        ),

        const SizedBox(height: 8),
        const Text('Selecciona tus intereses:',
            style: TextStyle(fontWeight: FontWeight.w500)),

        // CheckboxListTile: checkbox integrado en una fila con título y subtítulo.
        // Mucho más fácil que construir Row + Checkbox + Text manualmente.
        ..._intereses.keys.map(
          (tecnologia) => CheckboxListTile(
            title: Text(tecnologia),
            // value: estado actual del checkbox.
            value: _intereses[tecnologia],
            // onChanged: actualiza el mapa de intereses.
            onChanged: (valor) =>
                setState(() => _intereses[tecnologia] = valor!),
            // controlAffinity: coloca el control a la izquierda o derecha.
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ),
      ],
    );
  }

  // ── Sección Switch ───────────────────────────────────────────────────────

  /// Switch básico y SwitchListTile para ajustes de configuración.
  Widget _buildSeccionSwitch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Switch',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // Switch básico: igual que Checkbox pero visual de toggle.
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Newsletter'),
            Switch(
              value: _newsletter,
              onChanged: (valor) => setState(() => _newsletter = valor),
            ),
          ],
        ),

        const SizedBox(height: 8),
        const Text('Configuración:',
            style: TextStyle(fontWeight: FontWeight.w500)),

        // SwitchListTile: switch con título y subtítulo integrados.
        SwitchListTile(
          title: const Text('Notificaciones push'),
          subtitle: const Text('Recibe alertas en tiempo real'),
          // secondary: ícono a la izquierda de la fila.
          secondary: const Icon(Icons.notifications_outlined),
          value: _notificaciones,
          onChanged: (valor) => setState(() => _notificaciones = valor),
        ),
        SwitchListTile(
          title: const Text('Modo oscuro'),
          secondary: const Icon(Icons.dark_mode_outlined),
          value: _modoOscuro,
          onChanged: (valor) => setState(() => _modoOscuro = valor),
        ),
        SwitchListTile(
          title: const Text('Compartir ubicación'),
          secondary: const Icon(Icons.location_on_outlined),
          value: _ubicacion,
          onChanged: (valor) => setState(() => _ubicacion = valor),
        ),
      ],
    );
  }

  // ── Sección Radio ────────────────────────────────────────────────────────

  /// Radio y RadioListTile para selección única dentro de un grupo.
  Widget _buildSeccionRadio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Radio',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Selecciona un plan:',
            style: TextStyle(fontWeight: FontWeight.w500)),

        // RadioListTile<T>: T es el tipo del valor (aquí String).
        // groupValue: el valor ACTUALMENTE seleccionado en el grupo.
        // value: el valor PROPIO de este radio button.
        // Cuando value == groupValue, el radio se muestra seleccionado.
        RadioListTile<String>(
          title: const Text('Plan Básico'),
          subtitle: const Text('Gratis — funciones esenciales'),
          secondary: const Icon(Icons.star_border),
          value: 'basico',
          groupValue: _planSeleccionado,
          onChanged: (valor) => setState(() => _planSeleccionado = valor!),
        ),
        RadioListTile<String>(
          title: const Text('Plan Pro'),
          subtitle: const Text('\$9.99/mes — todas las funciones'),
          secondary: const Icon(Icons.star_half),
          value: 'pro',
          groupValue: _planSeleccionado,
          onChanged: (valor) => setState(() => _planSeleccionado = valor!),
        ),
        RadioListTile<String>(
          title: const Text('Plan Enterprise'),
          subtitle: const Text('\$29.99/mes — ilimitado'),
          secondary: const Icon(Icons.star),
          value: 'enterprise',
          groupValue: _planSeleccionado,
          onChanged: (valor) => setState(() => _planSeleccionado = valor!),
        ),
        const SizedBox(height: 8),
        Text(
          'Plan seleccionado: $_planSeleccionado',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Agrega un CheckboxListTile de "Seleccionar todo" cuyo valor sea
//      true si todos están marcados, null si algunos, false si ninguno.
//      Al marcarlo, debería marcar/desmarcar todos los demás.
//   2. Cambia el color del Switch con activeColor y thumbColor usando
//      MaterialStateProperty para colores diferentes por estado.
//   3. Usa Radio<int> (en lugar de Radio<String>) con valores 1, 2, 3
//      para hacer una selección de valoración con estrellas.
// =============================================================================
