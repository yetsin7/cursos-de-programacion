# Módulo 25 — Animaciones en Flutter

Las animaciones transforman una app funcional en una app memorable. Flutter tiene dos grandes categorías de animaciones: **implícitas** y **explícitas**.

---

## ¿Qué tipo de animación necesitas?

| Situación | Tipo recomendado |
|---|---|
| Cambio de propiedad (tamaño, color, posición) | Animación implícita |
| Control total (pausar, repetir, sincronizar) | Animación explícita |
| Transición entre pantallas con widget compartido | Hero |
| Animación vectorial compleja (After Effects) | Lottie / Rive |

---

## Archivos del módulo

### `01_animaciones_implicitas.dart`
Las animaciones más fáciles de Flutter. Cuando una propiedad cambia, Flutter anima automáticamente la transición.

- `AnimatedContainer` — tamaño, color, borde, radio
- `AnimatedOpacity` — aparición y desvanecimiento
- `AnimatedPadding` — cambio de padding con curva
- `AnimatedAlign` — movimiento de alineación
- `AnimatedSwitcher` — transición entre widgets distintos
- `TweenAnimationBuilder` — animaciones implícitas personalizadas

### `02_animaciones_explicitas.dart`
Control total sobre la animación con `AnimationController`. Necesitas estas cuando quieres pausar, sincronizar o controlar el estado exacto.

- `AnimationController` — motor de la animación
- `Tween` y `CurvedAnimation` — rango y curva de movimiento
- `AnimatedBuilder` — reconstruye solo el widget animado
- Curvas disponibles: `easeIn`, `elasticOut`, `bounceIn`, `linear`
- Ciclo de vida: `forward()`, `reverse()`, `repeat()`, `dispose()`

### `03_hero_transition.dart`
Transiciones "mágicas" entre pantallas. El widget vuela de una ruta a otra.

- Widget `Hero` con `tag` único
- Funciona automáticamente con `Navigator.push`
- Personalizable con `flightShuttleBuilder`

### `04_lottie_y_rive.dart`
Animaciones ricas y vectoriales creadas por diseñadores.

- `lottie` package — reproduce archivos JSON de Adobe After Effects
- Control con `AnimationController`
- Comparativa Lottie vs Rive

---

## Conceptos clave

```
Animación implícita:  cambias el valor → Flutter anima solo
Animación explícita:  tú controlas el AnimationController
Hero:                 el widget "viaja" entre pantallas
Lottie/Rive:          archivos de diseñador, no código Flutter
```

---

## Dependencias necesarias

```yaml
# En pubspec.yaml para el archivo 04
dependencies:
  lottie: ^3.0.0
```

---

## Siguiente módulo

**Módulo 26 — Internacionalización (i18n):** soportar español e inglés en la misma app.
