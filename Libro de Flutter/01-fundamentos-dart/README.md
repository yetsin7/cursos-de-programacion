# Módulo 01 — Fundamentos de Dart

Antes de escribir una sola línea de Flutter, necesitas entender **Dart**: el lenguaje de programación en el que Flutter está construido.

---

## ¿Qué es Dart?

**Dart** es un lenguaje de programación creado por Google en 2011. Fue diseñado para ser:

- **Rápido:** Compila a código nativo (ARM, x86) para móviles y escritorio, y a JavaScript para la web.
- **Seguro:** Tiene null safety incorporado desde Dart 2.12, lo que elimina errores de null en tiempo de ejecución.
- **Familiar:** Sintaxis parecida a Java, C# y JavaScript. Si ya conoces alguno de estos, te sentirás cómodo rápidamente.
- **Moderno:** Dart 3 introdujo Records, Patterns y mejoras significativas al lenguaje.

---

## ¿Por qué aprender Dart antes de Flutter?

Flutter es un framework para construir interfaces de usuario. Pero toda la lógica, los datos, las funciones y la estructura de tu app se escriben en Dart.

Si intentas aprender Flutter sin entender Dart, vas a:
- Copiar código sin entender qué hace
- No saber cómo depurar errores
- Quedarte bloqueado en cuanto el tutorial se termina

**Dedica tiempo a Dart primero. Vale la pena.**

---

## Cómo ejecutar los archivos de este módulo

Los archivos `.dart` de este módulo son **Dart puro** — no necesitas un proyecto Flutter.

Ejecuta cualquier archivo desde la terminal así:

```bash
dart run 01_hola_mundo.dart
```

Asegúrate de estar en la carpeta del módulo antes de ejecutar:

```bash
cd "C:\Users\Yetsin\Documents\Programacion\Aprendiendo Flutter\Libro de Flutter\01-fundamentos-dart"
dart run 01_hola_mundo.dart
```

---

## Qué aprenderás en este módulo

| Archivo | Tema |
|---------|------|
| `01_hola_mundo.dart` | Tu primer programa, print(), interpolación de strings |
| `02_variables.dart` | var, tipos explícitos, dynamic |
| `03_tipos_de_datos.dart` | int, double, String, bool, List, Map, null |
| `04_comentarios.dart` | Comentarios de línea, bloque y documentación |
| `05_constantes.dart` | const vs final, cuándo usar cada uno |
| `06_ejercicios.dart` | Ejercicios prácticos con soluciones |

---

## Dart vs Python — comparativa rápida

| Característica | Python | Dart |
|----------------|--------|------|
| Tipado | Dinámico (opcional estático) | Estático con inferencia |
| Null safety | No nativo | Sí, nativo desde Dart 2.12 |
| Compilación | Interpretado | JIT (desarrollo) + AOT (producción) |
| Punto de entrada | Cualquier línea | `void main()` obligatorio |
| Interpolación | `f"Hola {nombre}"` | `"Hola $nombre"` |
| Imprimir | `print("...")` | `print("...")` |
| Lista | `[1, 2, 3]` | `[1, 2, 3]` |
| Diccionario | `{"a": 1}` | `{"a": 1}` (Map) |

---

¡Comienza por `01_hola_mundo.dart` y sigue en orden!
