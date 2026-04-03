# Módulo 10 — Programación Asíncrona en Dart

## Dart es single-threaded — ¿y entonces?

Dart ejecuta tu código en un **único hilo** (el main isolate). Pero esto no significa que no pueda manejar múltiples tareas concurrentes. Lo hace a través del **event loop**: un bucle que procesa eventos (respuestas de red, timers, entradas del usuario) de forma no bloqueante.

```
┌─────────────────────────────────────┐
│           DART EVENT LOOP           │
│                                     │
│  [Microtask Queue]  ←  Futures      │
│  [Event Queue]      ←  I/O, timers  │
│                                     │
│  → Ejecuta un evento a la vez       │
│  → Sin bloqueos                     │
└─────────────────────────────────────┘
```

## Future — Una promesa de un valor

Un `Future<T>` representa un valor que **existirá en el futuro**. Es similar a una `Promise` en JavaScript o un `Task<T>` en C#.

```dart
Future<String> obtenerDatos() async {
  // Simula una petición de red de 2 segundos
  await Future.delayed(Duration(seconds: 2));
  return 'datos del servidor';
}
```

## async/await — Sintaxis limpia para Futures

`async/await` hace que el código asíncrono se lea como código síncrono:

```dart
// Sin async/await (difícil de leer)
obtenerDatos().then((datos) => print(datos)).catchError((e) => print(e));

// Con async/await (limpio y claro)
try {
  String datos = await obtenerDatos();
  print(datos);
} catch (e) {
  print(e);
}
```

## Stream — Un flujo de datos

Un `Stream<T>` emite múltiples valores a lo largo del tiempo. Como un `Observable` en RxJS o un canal de Kotlin.

```dart
Stream<int> contador() async* {
  for (int i = 0; i < 5; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 1));
  }
}
```

## Isolates — Verdadero paralelismo

Para trabajo **CPU-intensivo** que bloquearía el UI (procesamiento de imágenes, criptografía, parsing de JSON grande), Dart usa **Isolates**: hilos reales con memoria separada.

## Archivos de este módulo

| Archivo | Contenido |
|---|---|
| `01_future.dart` | Future básico, then/catchError, Future.wait |
| `02_async_await.dart` | async/await, manejo de errores, patrones |
| `03_stream.dart` | Stream, listen, await for, StreamController |
| `04_isolates.dart` | Isolates y Isolate.run() |
| `05_ejercicios.dart` | Ejercicios de programación asíncrona |

## Cómo ejecutar

```bash
dart run 01_future.dart
dart run 02_async_await.dart
dart run 03_stream.dart
dart run 04_isolates.dart
dart run 05_ejercicios.dart
```
