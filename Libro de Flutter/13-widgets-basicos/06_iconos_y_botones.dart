// =============================================================================
// ARCHIVO: 06_iconos_y_botones.dart
// TEMA: Íconos y botones en Flutter
// =============================================================================
//
// Flutter incluye más de 1,000 íconos de Material Design listos para usar con
// la clase Icons. Los botones van desde ElevatedButton (prominente) hasta
// TextButton (discreto). También hay IconButton, FloatingActionButton y el
// nuevo FilledButton y SegmentedButton de Material 3.
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
      title: 'Íconos y Botones',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const PantallaBotons(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA PRINCIPAL
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra todos los tipos de íconos y botones disponibles en Flutter.
class PantallaBotons extends StatelessWidget {
  const PantallaBotons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Íconos y Botones'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Agregar'),
        tooltip: 'FloatingActionButton.extended',
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SeccionIconos(),
            SizedBox(height: 24),
            _SeccionBotonesBasicos(),
            SizedBox(height: 24),
            _SeccionBotonesConIcono(),
            SizedBox(height: 24),
            _SeccionBotonesDeshabilitados(),
            SizedBox(height: 24),
            _SeccionButtonStyle(),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 1 — ICONOS
// ────────────────────────────────────────────────────────────────────────────

/// Demostración del widget Icon con el catálogo de Material Icons.
class _SeccionIconos extends StatelessWidget {
  const _SeccionIconos();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('1. Íconos (Icons.*)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            // Icon básico con el ícono por defecto (tamaño 24, color del tema).
            const Icon(Icons.home),
            // Con tamaño personalizado.
            const Icon(Icons.favorite, size: 32, color: Colors.red),
            const Icon(Icons.star, size: 32, color: Colors.amber),
            const Icon(Icons.notifications, size: 32),
            const Icon(Icons.settings, size: 32),
            const Icon(Icons.search, size: 32),
            const Icon(Icons.person, size: 32),
            const Icon(Icons.shopping_cart, size: 32),
            // Variante outlined del ícono (contorno sin relleno).
            const Icon(Icons.home_outlined, size: 32),
            const Icon(Icons.favorite_border, size: 32),
            // IconButton: ícono que responde a toques con efecto ripple.
            IconButton(
              icon: const Icon(Icons.thumb_up),
              onPressed: () {},
              tooltip: 'Me gusta',
              // color personalizado para el ícono.
              color: Colors.deepOrange,
            ),
          ],
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 2 — BOTONES BÁSICOS
// ────────────────────────────────────────────────────────────────────────────

/// Los cuatro tipos principales de botones de Material 3.
class _SeccionBotonesBasicos extends StatelessWidget {
  const _SeccionBotonesBasicos();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('2. Tipos de botones',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // ElevatedButton: botón con sombra, para acciones primarias.
        ElevatedButton(
          onPressed: () {},
          child: const Text('ElevatedButton (acción primaria)'),
        ),
        const SizedBox(height: 8),

        // FilledButton: botón relleno con color primario (Material 3).
        // Más prominente que ElevatedButton para la acción más importante.
        FilledButton(
          onPressed: () {},
          child: const Text('FilledButton (Material 3)'),
        ),
        const SizedBox(height: 8),

        // OutlinedButton: botón con borde, para acciones secundarias.
        OutlinedButton(
          onPressed: () {},
          child: const Text('OutlinedButton (acción secundaria)'),
        ),
        const SizedBox(height: 8),

        // TextButton: sin borde ni sombra, para acciones terciarias o en diálogos.
        TextButton(
          onPressed: () {},
          child: const Text('TextButton (acción terciaria)'),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 3 — BOTONES CON ÍCONO
// ────────────────────────────────────────────────────────────────────────────

/// Variantes con ícono de los botones principales.
class _SeccionBotonesConIcono extends StatelessWidget {
  const _SeccionBotonesConIcono();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('3. Botones con ícono',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            // .icon() constructor agrega un ícono a la izquierda del texto.
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.save),
              label: const Text('Guardar'),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.share),
              label: const Text('Compartir'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.delete),
              label: const Text('Eliminar'),
            ),
          ],
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 4 — BOTONES DESHABILITADOS
// ────────────────────────────────────────────────────────────────────────────

/// onPressed: null deshabilita cualquier botón y aplica estilo gris automático.
class _SeccionBotonesDeshabilitados extends StatelessWidget {
  const _SeccionBotonesDeshabilitados();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('4. Botones deshabilitados (onPressed: null)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            // onPressed: null → deshabilitado. Flutter aplica estilos grises automáticamente.
            const ElevatedButton(onPressed: null, child: Text('Deshabilitado')),
            const FilledButton(onPressed: null, child: Text('Deshabilitado')),
            const OutlinedButton(onPressed: null, child: Text('Deshabilitado')),
            const TextButton(onPressed: null, child: Text('Deshabilitado')),
          ],
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 5 — BUTTONSTYLE PERSONALIZADO
// ────────────────────────────────────────────────────────────────────────────

/// ButtonStyle permite personalizar el aspecto de un botón completamente.
class _SeccionButtonStyle extends StatelessWidget {
  const _SeccionButtonStyle();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('5. ButtonStyle personalizado',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            // backgroundColor: color de fondo del botón.
            backgroundColor: Colors.deepOrange,
            // foregroundColor: color del texto e ícono.
            foregroundColor: Colors.white,
            // padding: espacio interno del botón.
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            // shape: forma del botón (aquí, borde sin redondeo).
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            // elevation: sombra del botón.
            elevation: 4,
            // textStyle: estilo del texto dentro del botón.
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text('Botón personalizado'),
        ),
        const SizedBox(height: 8),
        // onLongPress: se activa al mantener presionado.
        ElevatedButton(
          onPressed: () {},
          onLongPress: () {
            // onLongPress para acciones secundarias o confirmación.
          },
          child: const Text('Mantén presionado (onLongPress)'),
        ),
      ],
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Prueba SegmentedButton de Material 3 para crear un selector de opciones
//      mutuamente excluyentes (ej: Talla S / M / L / XL).
//   2. Usa GestureDetector envolviendo cualquier widget para detectar gestos:
//      onTap, onDoubleTap, onLongPress, onPanUpdate (arrastrar), etc.
//   3. Cambia el tamaño del FloatingActionButton a FloatingActionButton.small
//      o FloatingActionButton.large para ver las variantes de tamaño.
//   4. Agrega tooltip: 'Descripción' a cualquier IconButton para mostrar
//      una etiqueta emergente al hacer hover (esencial para accesibilidad).
// =============================================================================
