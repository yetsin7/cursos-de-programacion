# Módulo 01 — Fundamentos de Dart

Antes de construir interfaces en Flutter, necesitas entender Dart. Si Dart te
resulta claro, Flutter deja de sentirse como una colección extraña de widgets y
empieza a verse como software organizado.

---

## ¿Que es Dart?

Dart es el lenguaje en el que se escribe Flutter. Fue creado por Google y está
pensado para ser rápido, seguro, moderno y agradable de leer.

Con Dart puedes:

- escribir lógica de negocio;
- modelar datos;
- usar funciones, colecciones y clases;
- compilar para desarrollo y para produccion.

---

## ¿Por que aprender Dart antes de Flutter?

Flutter dibuja interfaces, pero la lógica que decide que mostrar, como reaccionar
al usuario y como organizar datos vive en Dart.

Si aprendes Flutter sin bases de Dart, es fácil caer en esto:

- copiar código sin comprender;
- no saber leer errores;
- no entender estados, variables o funciones;
- atascarte cuando cambie un ejemplo.

---

## ¿Que pasa dentro del sistema cuando ejecutas Dart?

Cuando corres un archivo `.dart`:

1. el runtime de Dart carga el programa;
2. entra por `main()`;
3. crea variables y objetos en memoria;
4. ejecuta instrucciones en orden;
5. muestra resultados en consola.

Cuando uses Flutter, esta misma base se ampliara para incluir renderizado de
widgets, eventos de usuario y reconstrucciones de interfaz.

---

## Cómo ejecutar los archivos de este módulo

Los archivos `.dart` de este módulo son Dart puro. No necesitas crear un
proyecto Flutter para estudiarlos.

```bash
dart run 01_hola_mundo.dart
```

---

## Qué aprenderás en este módulo

| Archivo | Tema |
|---------|------|
| `01_hola_mundo.dart` | Primer programa, salida en consola e interpolacion |
| `02_variables.dart` | `var`, tipos explicitos y `dynamic` |
| `03_tipos_de_datos.dart` | `int`, `double`, `String`, `bool`, `List`, `Map`, `null` |
| `04_comentarios.dart` | Comentarios de linea, bloque y documentación |
| `05_constantes.dart` | `const` vs `final` |
| `06_ejercicios.dart` | Practica guiada |

---

## Errores comúnes del principiante

- querer aprender widgets sin dominar variables y funciones;
- pensar que Dart y Flutter son exactamente lo mismo;
- ignorar el papel de `main()`;
- no experimentar con tipos y valores;
- saltarse ejercicios por creer que son demasiado fáciles.

---

## Dart vs Python — comparativa rápida

| Carácterística | Python | Dart |
|----------------|--------|------|
| Tipado | Dinámico (opcional estático) | Estático con inferencia |
| Null safety | No nativo | Sí, nativo |
| Compilación | Interpretado | JIT + AOT |
| Punto de entrada | Flexible | `void main()` |
| Interpolación | `f"Hola {nombre}"` | `"Hola $nombre"` |

---

## Practica guiada

1. Ejecuta cada archivo.
2. Cambia valores y vuelve a ejecutar.
3. Intenta predecir la salida antes de correrlo.
4. Explica con tus palabras qué hace `main()`.

Comienza por `01_hola_mundo.dart` y sigue en orden.
