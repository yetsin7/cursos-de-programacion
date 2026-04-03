# Módulo 13 — Widgets Básicos

## En Flutter, TODO es un Widget

Esta es la idea central de Flutter. A diferencia de otros frameworks donde hay diferencia entre "vistas", "componentes" y "layouts", en Flutter todo —desde el texto más pequeño hasta la pantalla completa— es un widget.

Un widget es simplemente una **descripción de parte de la interfaz**. No dibuja nada directamente: describe cómo debería verse. Flutter toma esa descripción y la convierte en píxeles en pantalla.

```dart
// Un texto es un widget:
Text('Hola mundo')

// Un espaciado es un widget:
SizedBox(height: 16)

// Un color de fondo es un widget:
ColoredBox(color: Colors.blue, child: ...)

// Incluso el tema completo de la app es un widget:
MaterialApp(...)
```

---

## El Árbol de Widgets

Los widgets se organizan en un **árbol jerárquico** (padre → hijo):

```
MaterialApp
  └── Scaffold
        ├── AppBar
        │     └── Text('Mi App')
        └── Column
              ├── Text('Hola')
              ├── SizedBox(height: 16)
              └── ElevatedButton
                    └── Text('Presionar')
```

Cada widget puede tener uno o varios hijos. Esta composición es cómo se construye toda la UI en Flutter.

---

## StatelessWidget vs StatefulWidget (adelanto)

- **StatelessWidget**: no tiene estado interno. Siempre se ve igual si recibe los mismos parámetros. Ejemplo: un `Text`, un `Icon`, una tarjeta con datos fijos.
- **StatefulWidget**: tiene estado interno que puede cambiar. Cuando el estado cambia, Flutter reconstruye el widget. Ejemplo: un contador, un formulario, un switch.

El Módulo 15 profundiza en el estado. Por ahora, en este módulo todos los ejemplos son `StatelessWidget`.

---

## Widgets de Layout vs Widgets de Presentación

### Widgets de Layout (organizan el espacio):
- `Row`, `Column` — horizontal y vertical
- `Stack` — superponer widgets
- `Expanded`, `Flexible` — distribuir espacio
- `Padding`, `Align`, `Center` — posicionamiento
- `SizedBox`, `Spacer` — espacios y tamaños fijos

### Widgets de Presentación (muestran contenido):
- `Text` — texto
- `Image` — imágenes
- `Icon` — íconos
- `Container` — caja con color, borde, sombra
- `Card` — tarjeta elevada

---

## Archivos de este módulo

| Archivo | Tema |
|---|---|
| `01_text_y_estilo.dart` | Text, TextStyle, Text.rich, SelectableText |
| `02_container.dart` | Container, BoxDecoration, SizedBox |
| `03_row_column.dart` | Row, Column, Expanded, Flexible |
| `04_stack.dart` | Stack, Positioned, overlays |
| `05_imagen.dart` | Image, CircleAvatar, FadeInImage |
| `06_iconos_y_botones.dart` | Icon, ElevatedButton, TextButton, IconButton |
| `07_ejercicios.dart` | Ejercicios de práctica |
