# Módulo 14 — Widgets Interactivos

## Widgets que responden al usuario

Los widgets interactivos son aquellos que detectan la interacción del usuario y ejecutan acciones o modifican la UI como respuesta. En Flutter, la interacción puede ser:

- **Toque simple** (tap): botones, celdas de lista, tarjetas
- **Toque largo** (long press): menús contextuales, selección múltiple
- **Arrastre** (drag/swipe): deslizar para eliminar, ordenar listas
- **Entrada de texto**: campos de formulario, búsqueda, contraseñas
- **Selección de valores**: checkboxes, switches, sliders, radio buttons

---

## La importancia del estado

Todos los widgets interactivos comparten una carácterística: **necesitan estado** para funcionar. Cuando el usuario selecciona un checkbox, el widget debe recordar si está marcado o no. Cuando el usuario escribe en un TextField, el widget debe recordar el texto.

En este módulo, todos los ejemplos usan `StatefulWidget` con `setState()` para manejar los cambios de estado. El Módulo 15 profundiza en el estado.

---

## Patrón de manejo de estado en widgets interactivos

Todos los widgets interactivos de Flutter siguen el mismo patrón:

```dart
// 1. Variable de estado en el State<T>
bool _estaSeleccionado = false;

// 2. El widget recibe la variable actual y un callback para cambiarla
Checkbox(
  value: _estaSeleccionado,
  onChanged: (nuevoValor) {
    setState(() {
      _estaSeleccionado = nuevoValor!;
    });
  },
)
```

---

## Archivos de este módulo

| Archivo | Tema |
|---|---|
| `01_botones.dart` | Botones, GestureDetector, gestos personalizados |
| `02_textfield.dart` | TextField, TextEditingController, FocusNode |
| `03_checkbox_switch_radio.dart` | Checkbox, Switch, Radio y sus variantes de lista |
| `04_slider_progress.dart` | Slider, RangeSlider, ProgressIndicator, RefreshIndicator |
| `05_ejercicios.dart` | Ejercicios de práctica |
