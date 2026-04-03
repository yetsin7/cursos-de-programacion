# Módulo 20 — Gestión de Estado Avanzada

La gestión de estado es uno de los temas más importantes en Flutter. Existen múltiples soluciones con diferentes niveles de complejidad.

## Comparativa de soluciones

| Solución | Complejidad | Escala | Cuándo usar |
|---|---|---|---|
| `setState` | Baja | Widget individual | Estado local simple |
| `InheritedWidget` | Media | Árbol de widgets | Base de Provider |
| `Provider` | Baja-Media | Apps medianas | Primera opción para la mayoría |
| `Riverpod` | Media | Apps medianas-grandes | Mejor que Provider |
| `BLoC` | Alta | Apps grandes | Equipos grandes, lógica compleja |

## Contenido

### 01_provider_intro.dart
Primeros pasos con el paquete `provider`.
- `ChangeNotifier`, `ChangeNotifierProvider`
- `context.watch<T>()`, `context.read<T>()`
- `Consumer<T>`

### 02_provider_avanzado.dart
Provider avanzado: múltiples providers, asíncrono y optimizaciones.
- `MultiProvider`, `ProxyProvider`
- `FutureProvider`, `StreamProvider`
- `Selector<T,S>` para optimizar reconstrucciones

### 03_riverpod_intro.dart
Introducción a Riverpod: la evolución de Provider.
- `ProviderScope`, `ConsumerWidget`
- `Provider`, `StateProvider`
- `ref.watch()` vs `ref.read()`

### 04_riverpod_avanzado.dart
Riverpod avanzado con providers asíncronos.
- `NotifierProvider`, `AsyncNotifierProvider`
- `FutureProvider` con `.when()`
- `provider.family`, `ref.invalidate()`

### 05_bloc_intro.dart
BLoC con Cubit: arquitectura reactiva para apps grandes.
- `Cubit`, `BlocProvider`
- `BlocBuilder`, `BlocListener`
