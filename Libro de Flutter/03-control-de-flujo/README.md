# Módulo 03 — Control de Flujo en Dart

El control de flujo decide qué instrucciones se ejecutan, cuántas veces y en qué
momento. Sin este módulo, un programa solo sería una lista lineal de pasos.

---

## ¿Qué aprenderás?

| Archivo | Tema |
|---------|------|
| `01_if_else.dart` | `if`, `else if`, `else`, ternario y `switch expression` |
| `02_switch.dart` | `switch` clásico, `switch expression` y patrones |
| `03_bucle_for.dart` | `for`, `for-in`, `forEach` e iteración |
| `04_bucle_while.dart` | `while`, `do-while` |
| `05_break_continue.dart` | `break`, `continue`, labels |
| `06_ejercicios.dart` | Practica guiada |

---

## ¿Por qué importa este módulo?

Porque el software real decide constantemente:

- si una persona puede continuar;
- qué pantalla mostrar;
- si repetir una tarea;
- cuándo detener un proceso.

Todo eso depende de condicionales y bucles.

---

## ¿Qué pasa dentro del programa?

Cuando Dart evalúa una condición:

- calcula una expresión booleana;
- elige un camino del código;
- puede repetir un bloque o saltarlo;
- puede detener o continuar ciclos.

En Flutter esto afecta validaciones, estados, navegación y renderizado.

---

## Novedad de Dart 3: Switch Expression

`switch expression` permite resolver varios casos y devolver un valor de forma
compacta:

```dart
String resultado = switch (dia) {
  1 => 'Lunes',
  7 => 'Domingo',
  _ => 'Otro dia',
};
```

---

## Errores comunes

- escribir condiciones demasiado largas;
- abusar del ternario;
- usar `switch` donde un `if` es más claro;
- crear bucles sin pensar cómo terminan.

---

## Cómo ejecutar

```bash
dart run 01_if_else.dart
```
