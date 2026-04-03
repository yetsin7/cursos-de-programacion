// =============================================================================
// ARCHIVO: 01_text_y_estilo.dart
// TEMA: Text, TextStyle y estilos tipográficos en Flutter
// =============================================================================
//
// El widget Text y sus variantes permiten mostrar texto con estilos ricos.
// TextStyle controla la apariencia visual: fuente, tamaño, color, peso, etc.
// Text.rich permite combinar múltiples estilos en un mismo bloque de texto.
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
      title: 'Text y Estilos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const PantallaTextos(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA PRINCIPAL
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra todas las formas de mostrar y estilizar texto en Flutter.
class PantallaTextos extends StatelessWidget {
  const PantallaTextos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text y Estilos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SeccionTextBasico(),
            SizedBox(height: 24),
            _SeccionTextStyle(),
            SizedBox(height: 24),
            _SeccionTextRich(),
            SizedBox(height: 24),
            _SeccionDefaultTextStyle(),
            SizedBox(height: 24),
            _SeccionSelectableText(),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 1 — TEXT BÁSICO
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra el widget Text con sus propiedades más comunes.
class _SeccionTextBasico extends StatelessWidget {
  const _SeccionTextBasico();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('1. Widget Text básico',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // Text más simple posible: solo el string.
        const Text('Texto sin estilo'),

        // textAlign: cómo alinear el texto dentro de su espacio disponible.
        const Text(
          'Texto centrado con textAlign',
          textAlign: TextAlign.center,
        ),

        // maxLines + overflow: controla cuántas líneas se muestran
        // y qué pasa con el texto que no cabe (ellipsis = "...").
        const Text(
          'Este texto es muy largo y se cortará con puntos suspensivos '
          'si no cabe en una sola línea de la pantalla del dispositivo.',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        // softWrap: false impide que el texto salte de línea automáticamente.
        // Con overflow: TextOverflow.fade, el final se desvanece.
        const Text(
          'Texto sin salto de línea — desaparece al borde',
          softWrap: false,
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 2 — TEXTSTYLE
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra TextStyle con todas sus propiedades de apariencia.
class _SeccionTextStyle extends StatelessWidget {
  const _SeccionTextStyle();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('2. TextStyle',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // fontSize: tamaño en unidades lógicas (dp), no en píxeles.
        const Text('Tamaño 24', style: TextStyle(fontSize: 24)),
        const Text('Tamaño 14', style: TextStyle(fontSize: 14)),

        // fontWeight: grosor de la fuente.
        const Text('Negrita (w700)',
            style: TextStyle(fontWeight: FontWeight.w700)),
        const Text('Delgada (w300)',
            style: TextStyle(fontWeight: FontWeight.w300)),

        // color: color del texto. Admite Colors.* o Color(0xFFRRGGBB).
        const Text('Texto en color teal',
            style: TextStyle(color: Colors.teal, fontSize: 16)),

        // letterSpacing: espacio entre letras (tracking).
        const Text('L E T R A S   E S P A C I A D A S',
            style: TextStyle(letterSpacing: 4)),

        // height: interlineado como multiplicador del fontSize.
        // height: 2.0 = el doble del tamaño de la fuente entre líneas.
        const Text(
          'Línea 1\nLínea 2 con height 2.0\nLínea 3',
          style: TextStyle(height: 2.0),
        ),

        // decoration: subrayado, tachado, etc.
        const Text('Texto subrayado',
            style: TextStyle(decoration: TextDecoration.underline)),
        const Text('Texto tachado',
            style: TextStyle(decoration: TextDecoration.lineThrough)),

        // fontStyle: itálica.
        const Text('Texto en cursiva',
            style: TextStyle(fontStyle: FontStyle.italic)),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 3 — TEXT.RICH Y TEXTSPAN
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra Text.rich con TextSpan para mezclar estilos en un mismo texto.
class _SeccionTextRich extends StatelessWidget {
  const _SeccionTextRich();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('3. Text.rich con TextSpan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // Text.rich permite combinar múltiples TextSpan con estilos distintos
        // en un solo bloque de texto que fluye como uno solo.
        Text.rich(
          TextSpan(
            // El estilo del TextSpan raíz se hereda por todos los hijos.
            style: const TextStyle(fontSize: 16),
            children: [
              const TextSpan(text: 'Precio: '),
              TextSpan(
                text: '\$29.99',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                  fontSize: 20,
                ),
              ),
              const TextSpan(text: ' ('),
              const TextSpan(
                text: '40% off',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              ),
              const TextSpan(text: ')'),
            ],
          ),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 4 — DEFAULTTEXTSTYLE
// ────────────────────────────────────────────────────────────────────────────

/// DefaultTextStyle aplica un estilo base a todos los Text que contiene.
class _SeccionDefaultTextStyle extends StatelessWidget {
  const _SeccionDefaultTextStyle();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('4. DefaultTextStyle (herencia de estilos)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // DefaultTextStyle hereda el estilo a todos los Text hijos.
        // merge: true combina el estilo definido con el heredado del árbol.
        DefaultTextStyle.merge(
          style: const TextStyle(
            color: Colors.deepPurple,
            fontStyle: FontStyle.italic,
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Este texto hereda color morado e itálica'),
              Text('Este también hereda el estilo del DefaultTextStyle'),
              Text(
                'Este sobreescribe solo el color',
                style: TextStyle(color: Colors.orange),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 5 — SELECTABLETEXT
// ────────────────────────────────────────────────────────────────────────────

/// SelectableText permite al usuario seleccionar y copiar el texto.
class _SeccionSelectableText extends StatelessWidget {
  const _SeccionSelectableText();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('5. SelectableText',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const SelectableText(
          'Este texto se puede seleccionar y copiar. '
          'Ideal para mostrar código, IDs, emails o cualquier dato '
          'que el usuario pueda necesitar copiar.',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Agrega fontFamily: 'Roboto' o 'Montserrat' al TextStyle y descarga
//      la fuente de Google Fonts (paquete google_fonts en pub.dev).
//   2. Prueba textScaleFactor en Text para hacer el texto más grande sin
//      cambiar el fontSize base.
//   3. Usa Theme.of(context).textTheme.* para aplicar estilos tipográficos
//      del sistema de diseño: headlineLarge, titleMedium, bodySmall, etc.
// =============================================================================
