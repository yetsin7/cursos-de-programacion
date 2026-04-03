# Módulo 02 — Operadores en Dart

Los operadores son los símbolos que le dicen a Dart qué operación realizar con los valores. Dart tiene un conjunto rico de operadores, incluyendo algunos únicos que no existen en otros lenguajes.

---

## ¿Qué aprenderás?

| Archivo | Tema |
|---------|------|
| `01_aritmeticos.dart` | +, -, *, /, ~/, %, y la librería dart:math |
| `02_comparacion.dart` | ==, !=, <, >, <=, >=, identical() |
| `03_logicos.dart` | &&, ||, !, evaluación en cortocircuito |
| `04_asignacion.dart` | =, +=, -=, ??=, ++, -- |
| `05_ejercicios.dart` | Ejercicios prácticos con soluciones |

---

## Operadores especiales de Dart

Dart tiene varios operadores que no encontrarás en Python o JavaScript:

| Operador | Significado | Ejemplo |
|----------|-------------|---------|
| `~/` | División entera | `7 ~/ 2 == 3` |
| `??` | Si es null, usa este valor | `nombre ?? 'Anónimo'` |
| `??=` | Asignar solo si es null | `x ??= 10` |
| `?.` | Acceso seguro a nulos | `usuario?.nombre` |
| `!` | Afirmar que no es null | `usuario!.nombre` |
| `...` | Spread en colecciones | `[...lista1, ...lista2]` |
| `is` | Verificar tipo | `valor is String` |
| `as` | Castear tipo | `valor as String` |

---

## Cómo ejecutar

```bash
dart run 01_aritmeticos.dart
```
