# Módulo 04 — Funciones en Dart

Las funciones son bloques reutilizables de código. Dart tiene un sistema de funciones muy flexible: soporta parámetros nombrados (como kwargs de Python), parámetros opcionales, arrow functions, closures y funciones de primera clase.

---

## ¿Qué aprenderás?

| Archivo | Tema |
|---------|------|
| `01_funciones_basicas.dart` | Declarar y llamar funciones, void, retorno |
| `02_parametros.dart` | Posicionales, nombrados (required), opcionales, valores por defecto |
| `03_retorno.dart` | return, Records (Dart 3), funciones que retornan funciones |
| `04_arrow_functions.dart` | Sintaxis =>, cuándo usarla |
| `05_funciones_anonimas.dart` | Lambdas, closures, callbacks, typedef |
| `06_ejercicios.dart` | Ejercicios prácticos con soluciones |

---

## Parámetros nombrados — La killer feature de Dart

En Dart puedes llamar funciones con parámetros nombrados, lo que hace el código mucho más legible:

```dart
// Sin parámetros nombrados — confuso:
crearUsuario('Ana', 28, true, false);

// Con parámetros nombrados — claro:
crearUsuario(nombre: 'Ana', edad: 28, esAdmin: true, estaActivo: false);
```

Esto es especialmente importante en Flutter, donde los widgets tienen docenas de parámetros opcionales.

---

## Cómo ejecutar

```bash
dart run 01_funciones_basicas.dart
```
