// =============================================================================
// ARCHIVO: 03_row_column.dart
// TEMA: Row, Column, Expanded y Flexible para layouts
// =============================================================================
//
// Row y Column son los widgets fundamentales de layout en Flutter.
// Row organiza sus hijos de forma horizontal; Column, de forma vertical.
// mainAxisAlignment controla la distribución a lo largo del eje principal.
// crossAxisAlignment controla la alineación en el eje perpendicular.
// Expanded y Flexible permiten que los hijos se adapten al espacio disponible.
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
      title: 'Row y Column',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const PantallaLayouts(),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// PANTALLA PRINCIPAL
// ────────────────────────────────────────────────────────────────────────────

/// Muestra Row, Column y distribución de espacio con distintas alineaciones.
class PantallaLayouts extends StatelessWidget {
  const PantallaLayouts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Row y Column'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SeccionMainAxisAlignment(),
            SizedBox(height: 24),
            _SeccionCrossAxisAlignment(),
            SizedBox(height: 24),
            _SeccionMainAxisSize(),
            SizedBox(height: 24),
            _SeccionExpandedFlexible(),
            SizedBox(height: 24),
            _SeccionAnidado(),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// WIDGET AUXILIAR: CAJA DE COLOR
// ────────────────────────────────────────────────────────────────────────────

/// Caja de color con etiqueta para visualizar el espacio ocupado en el layout.
class _Caja extends StatelessWidget {
  final Color color;
  final String etiqueta;
  final double ancho;
  final double alto;

  const _Caja({
    required this.color,
    required this.etiqueta,
    this.ancho = 60,
    this.alto = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ancho,
      height: alto,
      color: color,
      alignment: Alignment.center,
      child: Text(
        etiqueta,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 1 — MAINAXISALIGNMENT EN ROW
// ────────────────────────────────────────────────────────────────────────────

/// mainAxisAlignment controla cómo se distribuyen los hijos a lo largo
/// del eje principal (horizontal en Row, vertical en Column).
class _SeccionMainAxisAlignment extends StatelessWidget {
  const _SeccionMainAxisAlignment();

  @override
  Widget build(BuildContext context) {
    // Cada Row usa un mainAxisAlignment diferente para comparar visualmente.
    final alineaciones = [
      (MainAxisAlignment.start, 'start'),
      (MainAxisAlignment.center, 'center'),
      (MainAxisAlignment.end, 'end'),
      (MainAxisAlignment.spaceBetween, 'spaceBetween'),
      (MainAxisAlignment.spaceAround, 'spaceAround'),
      (MainAxisAlignment.spaceEvenly, 'spaceEvenly'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('1. mainAxisAlignment en Row',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...alineaciones.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.$2, style: const TextStyle(fontSize: 12)),
                Container(
                  color: Colors.green.shade50,
                  child: Row(
                    mainAxisAlignment: item.$1,
                    children: [
                      _Caja(color: Colors.green.shade300, etiqueta: 'A'),
                      _Caja(color: Colors.green.shade500, etiqueta: 'B'),
                      _Caja(color: Colors.green.shade700, etiqueta: 'C'),
                    ],
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
// SECCIÓN 2 — CROSSAXISALIGNMENT
// ────────────────────────────────────────────────────────────────────────────

/// crossAxisAlignment controla la alineación en el eje PERPENDICULAR al principal.
/// En Row: eje vertical. En Column: eje horizontal.
class _SeccionCrossAxisAlignment extends StatelessWidget {
  const _SeccionCrossAxisAlignment();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('2. crossAxisAlignment en Row',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        // Row con hijos de alturas diferentes para ver el efecto.
        Container(
          height: 80,
          color: Colors.green.shade50,
          child: Row(
            // stretch: estira todos los hijos hasta la altura del más alto.
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Caja(color: Colors.green.shade400, etiqueta: 'stretch', alto: 40),
              _Caja(color: Colors.green.shade600, etiqueta: 'stretch', alto: 60),
              _Caja(color: Colors.green.shade800, etiqueta: 'stretch', alto: 30),
            ],
          ),
        ),
        const SizedBox(height: 4),
        const Text('Prueba: start, center, end, stretch, baseline',
            style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 3 — MAINAXISSIZE
// ────────────────────────────────────────────────────────────────────────────

/// mainAxisSize controla si Row/Column ocupa todo el espacio o solo el necesario.
class _SeccionMainAxisSize extends StatelessWidget {
  const _SeccionMainAxisSize();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('3. mainAxisSize: max vs min',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        // max (por defecto): el Row ocupa todo el ancho disponible.
        ColoredBox(
          color: Colors.green.shade50,
          child: Row(
            mainAxisSize: MainAxisSize.max, // ocupa todo el ancho
            children: [
              _Caja(color: Colors.green.shade400, etiqueta: 'max'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // min: el Row solo ocupa lo que necesita su contenido.
        ColoredBox(
          color: Colors.green.shade50,
          child: Row(
            mainAxisSize: MainAxisSize.min, // solo lo necesario
            children: [
              _Caja(color: Colors.green.shade600, etiqueta: 'min'),
            ],
          ),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 4 — EXPANDED Y FLEXIBLE
// ────────────────────────────────────────────────────────────────────────────

/// Expanded obliga al hijo a ocupar TODO el espacio libre disponible.
/// Flexible le da al hijo la opción de usar hasta el espacio disponible,
/// pero puede ser más pequeño si su contenido es menor.
class _SeccionExpandedFlexible extends StatelessWidget {
  const _SeccionExpandedFlexible();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('4. Expanded y Flexible',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // Expanded: cada hijo ocupa 1 parte del espacio libre.
        // flex: 2 → ocupa el doble que flex: 1.
        Row(
          children: [
            Expanded(
              flex: 2, // ocupa 2/3 del ancho
              child: _Caja(color: Colors.green.shade400, etiqueta: 'flex:2'),
            ),
            Expanded(
              flex: 1, // ocupa 1/3 del ancho
              child: _Caja(color: Colors.green.shade700, etiqueta: 'flex:1'),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Flexible: el hijo puede ser más pequeño que el espacio asignado.
        Row(
          children: [
            Flexible(
              child: _Caja(
                color: Colors.green.shade300,
                etiqueta: 'Flexible',
                ancho: 40, // más angosto que el espacio disponible → OK
              ),
            ),
            const _Caja(color: Colors.green.shade600, etiqueta: 'Fijo'),
          ],
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SECCIÓN 5 — ANIDACIÓN ROW DENTRO DE COLUMN
// ────────────────────────────────────────────────────────────────────────────

/// Ejemplo realista: tarjeta con Row dentro de Column (patrón muy común).
class _SeccionAnidado extends StatelessWidget {
  const _SeccionAnidado();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('5. Anidación — tarjeta de producto',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.local_grocery_store,
                    color: Colors.green, size: 32),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Manzana Orgánica',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('Por kilogramo',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Text('\$3.50',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// EXPERIMENTA:
//   1. Cambia CrossAxisAlignment.stretch a CrossAxisAlignment.start/end/center
//      en la Sección 2 y observa cómo cambia la alineación vertical.
//   2. Agrega un Spacer() entre dos elementos de un Row para empujar
//      el segundo elemento al extremo opuesto (igual que spaceBetween
//      pero con un solo espacio flexible).
//   3. Prueba wrap: true usando Wrap en lugar de Row para que los hijos
//      pasen a la siguiente línea cuando no caben en una sola fila.
// =============================================================================
