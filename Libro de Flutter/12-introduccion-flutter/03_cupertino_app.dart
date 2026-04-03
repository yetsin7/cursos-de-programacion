// =============================================================================
// ARCHIVO: 03_cupertino_app.dart
// TEMA: CupertinoApp — estilo nativo iOS en Flutter
// =============================================================================
//
// Flutter incluye dos bibliotecas de widgets: Material (Google/Android) y
// Cupertino (Apple/iOS). CupertinoApp es la alternativa a MaterialApp cuando
// quieres que tu app se vea y se sienta 100% nativa en iOS: tipografía SF Pro,
// navegación con deslizamiento hacia atrás, colores del sistema iOS, etc.
//
// CÓMO USAR:
//   1. Crea un proyecto Flutter: flutter create mi_app
//   2. Reemplaza lib/main.dart con este archivo
//   3. Ejecuta: flutter run
//
// =============================================================================
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MiAppCupertino());
}

// ────────────────────────────────────────────────────────────────────────────
// RAÍZ CUPERTINO
// ────────────────────────────────────────────────────────────────────────────

/// Raíz de la app usando CupertinoApp en lugar de MaterialApp.
///
/// CupertinoApp configura la apariencia iOS: fuentes del sistema,
/// colores nativos y transiciones de página con deslizamiento lateral.
class MiAppCupertino extends StatelessWidget {
  const MiAppCupertino({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      // title aparece en el multitarea del sistema operativo.
      title: 'App Estilo iOS',

      debugShowCheckedModeBanner: false,

      // CupertinoThemeData es el equivalente a ThemeData pero para Cupertino.
      // primaryColor define el color de acento principal (botones, links).
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.systemBlue,
        // brightness: Brightness.dark → activa el modo oscuro iOS
      ),

      home: const PantallaPrincipal(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA PRINCIPAL CUPERTINO
// ────────────────────────────────────────────────────────────────────────────

/// Pantalla principal con estructura típica de app iOS.
///
/// CupertinoPageScaffold es el equivalente a Scaffold en Material.
/// Proporciona la barra de navegación superior y el cuerpo de la pantalla.
class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // CupertinoNavigationBar: la barra superior estilo iOS.
      // Muestra el título centrado con botones a izquierda y derecha.
      navigationBar: const CupertinoNavigationBar(
        // middle: el título central de la barra (equivale a title en AppBar).
        middle: Text('Estilo iOS'),

        // leading: widget a la izquierda (ej: botón "Atrás" personalizado).
        // Si no se define, Flutter lo maneja automáticamente en navegación.
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: null,
          child: Icon(CupertinoIcons.person_crop_circle),
        ),

        // trailing: widget a la derecha de la barra.
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: null,
          child: Icon(CupertinoIcons.add),
        ),
      ),

      // child: el contenido principal, debajo de la barra de navegación.
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _SeccionComparativa(),
            const SizedBox(height: 24),
            _EjemploComponentesCupertino(),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// COMPARATIVA MATERIAL vs CUPERTINO
// ────────────────────────────────────────────────────────────────────────────

/// Tabla comparativa entre widgets Material e iOS equivalentes.
class _SeccionComparativa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const filas = [
      ('MaterialApp', 'CupertinoApp'),
      ('Scaffold', 'CupertinoPageScaffold'),
      ('AppBar', 'CupertinoNavigationBar'),
      ('ElevatedButton', 'CupertinoButton'),
      ('TextField', 'CupertinoTextField'),
      ('AlertDialog', 'CupertinoAlertDialog'),
      ('Switch', 'CupertinoSwitch'),
      ('Slider', 'CupertinoSlider'),
      ('CircularProgressIndicator', 'CupertinoActivityIndicator'),
      ('BottomNavigationBar', 'CupertinoTabBar'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Material vs Cupertino',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...filas.map(
          (fila) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    fila.$1,
                    style: const TextStyle(color: CupertinoColors.systemBlue),
                  ),
                ),
                const Icon(CupertinoIcons.arrow_right, size: 14),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    fila.$2,
                    style: const TextStyle(color: CupertinoColors.systemOrange),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// DEMOSTRACIÓN DE COMPONENTES CUPERTINO
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra componentes Cupertino nativos: botón, indicador, campo de texto.
class _EjemploComponentesCupertino extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Componentes iOS nativos',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        // CupertinoButton: botón con estilo iOS.
        // filled: tiene fondo sólido (equivale a ElevatedButton).
        CupertinoButton.filled(
          onPressed: () {},
          child: const Text('Botón iOS'),
        ),
        const SizedBox(height: 12),

        // CupertinoTextField: campo de texto estilo iOS.
        const CupertinoTextField(
          placeholder: 'Escribe aquí...',
          padding: EdgeInsets.all(12),
        ),
        const SizedBox(height: 16),

        // CupertinoActivityIndicator: el "spinner" de iOS (rueda giratoria).
        const Row(
          children: [
            CupertinoActivityIndicator(),
            SizedBox(width: 8),
            Text('Cargando...'),
          ],
        ),
      ],
    );
  }
}

// =============================================================================
// ¿CUÁNDO USAR CUPERTINO vs MATERIAL?
//
// CUPERTINO cuando:
//   - Tu app es SOLO para iOS y quieres que se sienta nativa al 100%
//   - Estás construyendo una app complementaria de una app Apple (ej: wallet)
//   - Tus usuarios son principalmente usuarios de iPhone/iPad
//
// MATERIAL cuando:
//   - Tu app es multiplataforma (Android, iOS, web, desktop)
//   - Quieres un diseño consistente en todas las plataformas
//   - La mayoría de tus usuarios son de Android (o no importa la plataforma)
//
// CONSEJO: La mayoría de las apps Flutter profesionales usan Material
// con ajustes visuales para sentirse naturales en iOS. El 95% de las apps
// Flutter del mundo usan MaterialApp.
// =============================================================================

// =============================================================================
// EXPERIMENTA:
//   1. Reemplaza CupertinoPageScaffold por CupertinoTabScaffold para ver
//      la navegación por pestañas estilo iOS (como la app de Music de Apple).
//   2. Prueba CupertinoAlertDialog en lugar de AlertDialog y observa las
//      diferencias de estilo.
//   3. Agrega brightness: Brightness.dark al CupertinoThemeData para ver
//      el modo oscuro con la estética correcta de iOS.
// =============================================================================
