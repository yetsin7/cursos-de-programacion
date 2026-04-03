// =============================================================================
// ARCHIVO: 05_imagen.dart
// TEMA: Imágenes en Flutter — Image, CircleAvatar y FadeInImage
// =============================================================================
//
// Flutter soporta imágenes desde múltiples fuentes: assets locales, URLs de
// internet, memoria y más. BoxFit controla cómo la imagen se ajusta al espacio.
// CircleAvatar es ideal para fotos de perfil. FadeInImage muestra un
// placeholder mientras se carga la imagen real desde la red.
//
// NOTA SOBRE ASSETS: Para usar Image.asset(), debes declarar las imágenes
// en pubspec.yaml bajo la sección flutter > assets.
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
      title: 'Imágenes en Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: const PantallaImagenes(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA PRINCIPAL
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra las distintas formas de mostrar imágenes en Flutter.
class PantallaImagenes extends StatelessWidget {
  const PantallaImagenes({super.key});

  // URL pública de prueba para Image.network.
  static const String _urlEjemplo =
      'https://picsum.photos/seed/flutter/400/200';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imágenes en Flutter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SeccionImageAsset(),
            SizedBox(height: 24),
            _SeccionImageNetwork(),
            SizedBox(height: 24),
            _SeccionBoxFit(),
            SizedBox(height: 24),
            _SeccionCircleAvatar(),
            SizedBox(height: 24),
            _SeccionFadeInImage(),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 1 — IMAGE.ASSET
// ────────────────────────────────────────────────────────────────────────────

/// Image.asset carga imágenes desde los archivos locales del proyecto.
class _SeccionImageAsset extends StatelessWidget {
  const _SeccionImageAsset();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('1. Image.asset (imágenes locales)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        // CONFIGURACIÓN REQUERIDA en pubspec.yaml:
        // flutter:
        //   assets:
        //     - assets/images/         ← directorio completo
        //     - assets/images/logo.png ← archivo específico
        //
        // Luego se usa así:
        // Image.asset('assets/images/logo.png')
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.cyan.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.cyan.shade200),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Código de ejemplo:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(
                "Image.asset(\n"
                "  'assets/images/logo.png',\n"
                "  width: 200,\n"
                "  height: 100,\n"
                "  fit: BoxFit.cover,\n"
                ")",
                style: TextStyle(fontFamily: 'monospace', fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 2 — IMAGE.NETWORK
// ────────────────────────────────────────────────────────────────────────────

/// Image.network carga una imagen desde una URL de internet.
class _SeccionImageNetwork extends StatelessWidget {
  const _SeccionImageNetwork();

  // URL de placeholder público (Picsum Photos genera imágenes aleatorias).
  static const _url = 'https://picsum.photos/seed/dart/400/160';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('2. Image.network',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            _url,
            width: double.infinity,
            height: 160,
            fit: BoxFit.cover,

            // loadingBuilder: se muestra mientras la imagen se descarga.
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child; // ya cargó
              return Container(
                height: 160,
                color: Colors.cyan.shade50,
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },

            // errorBuilder: se muestra si la imagen falla al cargar.
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 160,
                color: Colors.grey.shade200,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.broken_image, size: 48, color: Colors.grey),
                      Text('Error al cargar la imagen'),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 3 — BOXFIT
// ────────────────────────────────────────────────────────────────────────────

/// BoxFit controla cómo la imagen se ajusta dentro del espacio asignado.
class _SeccionBoxFit extends StatelessWidget {
  const _SeccionBoxFit();

  static const _url = 'https://picsum.photos/seed/boxfit/200/200';

  @override
  Widget build(BuildContext context) {
    final fits = [
      (BoxFit.cover, 'cover — rellena todo, recorta'),
      (BoxFit.contain, 'contain — cabe completa'),
      (BoxFit.fill, 'fill — estira sin mantener proporción'),
      (BoxFit.fitWidth, 'fitWidth — ancho completo'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('3. BoxFit',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: fits
              .take(4)
              .map(
                (item) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            _url,
                            width: double.infinity,
                            height: 70,
                            fit: item.$1,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.$2.split(' — ').first,
                          style: const TextStyle(fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 4 — CIRCLEAVATAR
// ────────────────────────────────────────────────────────────────────────────

/// CircleAvatar es la forma estándar de mostrar fotos de perfil circulares.
class _SeccionCircleAvatar extends StatelessWidget {
  const _SeccionCircleAvatar();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('4. CircleAvatar',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            // Con initiales (cuando no hay foto).
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.cyan,
              child: Text('AB', style: TextStyle(color: Colors.white)),
            ),
            // Con imagen de red como backgroundImage.
            const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                'https://picsum.photos/seed/person/100/100',
              ),
            ),
            // Tamaño pequeño (ej: para lista de usuarios).
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.cyan.shade700,
              child: const Icon(Icons.person, color: Colors.white, size: 18),
            ),
          ],
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 5 — FADEINIMAGE
// ────────────────────────────────────────────────────────────────────────────

/// FadeInImage muestra un placeholder mientras carga y hace fade-in al mostrar la imagen real.
class _SeccionFadeInImage extends StatelessWidget {
  const _SeccionFadeInImage();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('5. FadeInImage',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text(
          'FadeInImage.memoryNetwork usa un placeholder en memoria (bytes) '
          'mientras carga la imagen de la red con una animación de desvanecimiento.',
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          // FadeInImage.assetNetwork usa una imagen local como placeholder.
          // Como no tenemos asset, usemos Image.network con loadingBuilder
          // que logra el mismo efecto.
          child: Image.network(
            'https://picsum.photos/seed/fadein/400/150',
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) return child;
              // fadeInDuration simula el fade-in de FadeInImage.
              return AnimatedOpacity(
                opacity: frame == null ? 0 : 1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: child,
              );
            },
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Agrega una carpeta assets/images/ en tu proyecto, pon una imagen PNG
//      dentro, declárala en pubspec.yaml y usa Image.asset() para mostrarla.
//   2. Prueba BoxFit.none para ver la imagen en su tamaño original sin ajuste.
//   3. Usa DecorationImage dentro de BoxDecoration para poner una imagen
//      como fondo de un Container.
//   4. Instala el paquete 'cached_network_image' (pub.dev) para caché
//      automático de imágenes descargadas — mucho más eficiente que
//      Image.network en apps de producción.
// =============================================================================
