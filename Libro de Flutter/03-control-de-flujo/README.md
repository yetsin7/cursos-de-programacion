# Módulo 03 — Control de Flujo en Dart

El control de flujo determina qué código se ejecuta y cuándo. Dart tiene todas las estructuras clásicas más algunas modernas de Dart 3.

---

## ¿Qué aprenderás?

| Archivo | Tema |
|---------|------|
| `01_if_else.dart` | if, else if, else, operador ternario, switch expression |
| `02_switch.dart` | switch clásico, switch expression (Dart 3), pattern matching |
| `03_bucle_for.dart` | for clásico, for-in, forEach, iterar colecciones |
| `04_bucle_while.dart` | while, do-while, cuándo usar cada uno |
| `05_break_continue.dart` | break, continue, labels para bucles anidados |
| `06_ejercicios.dart` | Ejercicios prácticos con soluciones |

---

## Novedad de Dart 3: Switch Expression

Dart 3 introdujo el **switch expression** — una forma más compacta y poderosa de hacer switch que devuelve un valor directamente:

```dart
// Switch clásico (Dart 2):
String resultado;
switch (dia) {
  case 1:
    resultado = 'Lunes';
    break;
  case 7:
    resultado = 'Domingo';
    break;
  default:
    resultado = 'Otro día';
}

// Switch expression (Dart 3) — más limpio:
String resultado = switch (dia) {
  1 => 'Lunes',
  7 => 'Domingo',
  _ => 'Otro día',
};
```

---

## Cómo ejecutar

```bash
dart run 01_if_else.dart
```
