# Módulo 07 — Null Safety en Dart

## El "Billion Dollar Mistake"

En 1965, Tony Hoare inventó el concepto de referencia nula. Décadas después lo llamó "mi error de mil millones de dólares" porque provocó innumerables crashes, errores de seguridad y pérdidas económicas en la industria del software: el infame `NullPointerException` (NPE) en Java, el `nil` en Objective-C, el `undefined is not a function` en JavaScript.

El problema central: los lenguajes clásicos permiten que **cualquier variable de cualquier tipo pueda ser null**, y esto no se detecta hasta el momento de la ejecución.

## La solución de Dart: Sound Null Safety

Desde **Dart 2.12** (2021), Dart implementa **null safety en tiempo de compilación**. El principio es simple pero poderoso:

> **Un tipo no puede contener null a menos que lo declares explícitamente.**

```dart
String nombre = 'Ana';   // NUNCA puede ser null
String? apodo = null;    // Puede ser null (tipo nullable: String?)
```

Si intentas asignar `null` a un tipo no-nullable, el **compilador** lo detecta — no el runtime.

## ¿Por qué esto importa en Flutter?

En Flutter construyes UIs a partir de datos. Si un dato puede ser null, debes manejarlo. Con null safety, el compilador te **obliga** a hacerlo antes de que la app llegue a producción. Esto elimina toda una categoría de crashes en apps reales.

## Tipos nullable vs non-nullable

| Tipo | ¿Acepta null? | Ejemplo |
|------|--------------|---------|
| `String` | No | `'Hola'` |
| `String?` | Sí | `null` o `'Hola'` |
| `int` | No | `42` |
| `int?` | Sí | `null` o `42` |

## Operadores clave

| Operador | Nombre | Uso |
|---|---|---|
| `?.` | Acceso seguro | `objeto?.propiedad` |
| `??` | Coalescencia null | `valor ?? 'default'` |
| `??=` | Asignación null-aware | `x ??= 0` |
| `!` | Aserción non-null | `valor!` (riesgo) |
| `late` | Inicialización diferida | `late String nombre` |

## Archivos de este módulo

| Archivo | Contenido |
|---|---|
| `01_que_es_null_safety.dart` | El problema y la solución conceptual |
| `02_tipos_nullable.dart` | Declaración y uso de tipos nullables |
| `03_operadores_null.dart` | Todos los operadores null-aware |
| `04_late.dart` | La keyword `late` y sus casos de uso |
| `05_ejercicios.dart` | Ejercicios con soluciones |

## Cómo ejecutar

```bash
dart run 01_que_es_null_safety.dart
dart run 02_tipos_nullable.dart
dart run 03_operadores_null.dart
dart run 04_late.dart
dart run 05_ejercicios.dart
```
