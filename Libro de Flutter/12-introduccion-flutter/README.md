# Módulo 12 — Introducción a Flutter

## ¿Qué es Flutter?

Flutter es el framework de código abierto de Google para construir aplicaciones nativas compiladas para **móvil (iOS y Android), web y escritorio (Windows, macOS, Linux)** a partir de un único código base escrito en Dart.

A diferencia de otros frameworks híbridos, Flutter **no usa WebViews ni componentes nativos del sistema operativo**. En cambio, tiene su propio motor de renderizado (Skia/Impeller) que dibuja cada píxel directamente en el canvas, lo que le permite alcanzar 60/120 fps con una interfaz completamente personalizable.

---

## Dart como lenguaje base

Flutter usa **Dart**, también desarrollado por Google. Carácterísticas clave:

- Sintaxis similar a Java/JavaScript: fácil de aprender
- Tipado estático con inferencia de tipos
- Compilación AOT (ahead-of-time) para producción → rendimiento nativo
- Compilación JIT (just-in-time) en desarrollo → Hot Reload ultrarrápido
- Soporte para `async/await`, streams, generics, null safety

---

## Arquitectura de Flutter

```
┌─────────────────────────────────┐
│         Tu aplicación           │  ← Widgets que tú escribes
├─────────────────────────────────┤
│       Framework de Flutter      │  ← Widgets, animaciones, gestos
├─────────────────────────────────┤
│         Flutter Engine          │  ← Motor C++ (Skia/Impeller, Dart VM)
├─────────────────────────────────┤
│      Platform Embedder          │  ← Código nativo por plataforma
├─────────────────────────────────┤
│  Android / iOS / Web / Desktop  │
└─────────────────────────────────┘
```

### Los tres árboles de Flutter

1. **Widget Tree** — Tu código. Descripción declarativa de la UI. Inmutable.
2. **Element Tree** — Instancias vivas de los widgets. Flutter los gestiona automáticamente.
3. **Render Tree** — Objetos que calculan tamaño, posición y dibujan en pantalla.

---

## Instalación del SDK

```bash
# 1. Descarga Flutter SDK desde https://flutter.dev/docs/get-started/install
# 2. Extrae el archivo en una carpeta sin espacios, ej: C:\flutter
# 3. Agrega C:\flutter\bin al PATH del sistema
# 4. Verifica la instalación:
flutter doctor
```

`flutter doctor` muestra qué dependencias faltan (Android Studio, Xcode, etc.)

---

## Crear un proyecto nuevo

```bash
flutter create nombre_app
# Con organización personalizada (recomendado):
flutter create --org com.miempresa nombre_app
# Solo para Android e iOS:
flutter create --platforms android,ios nombre_app
```

---

## Estructura de un proyecto Flutter

```
nombre_app/
├── android/          → Proyecto Android nativo (raramente se toca)
├── ios/              → Proyecto Xcode (solo en macOS)
├── lib/              → ★ Todo tu código Dart va aquí
│   └── main.dart     → Punto de entrada de la app
├── test/             → Pruebas automatizadas
├── web/              → Archivos para compilar a web
├── windows/          → Archivos para compilar a Windows
├── pubspec.yaml      → Manifiesto del proyecto: dependencias, assets, fuentes
├── pubspec.lock      → Versiones exactas instaladas (no editar manualmente)
└── analysis_options.yaml → Configuración del linter de Dart
```

### `pubspec.yaml` — el archivo más importante

```yaml
name: nombre_app
description: Mi primera app Flutter
version: 1.0.0+1       # versión_humana+número_de_build

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

flutter:
  uses-material-design: true
  assets:            # Imágenes, fuentes, etc.
    - assets/images/
  fonts:
    - family: MiFuente
      fonts:
        - asset: assets/fonts/MiFuente-Regular.ttf
```

---

## Comandos fundamentales

| Comando | Descripción |
|---|---|
| `flutter run` | Compila y ejecuta la app en un dispositivo conectado |
| `flutter run -d chrome` | Ejecuta en el navegador Chrome |
| `flutter run --release` | Ejecuta en modo release (más lento de compilar, más rápido de correr) |
| `flutter build apk` | Genera APK para Android |
| `flutter build appbundle` | Genera AAB para Google Play |
| `flutter build ios` | Genera build para iOS (requiere macOS) |
| `flutter pub get` | Descarga las dependencias del pubspec.yaml |
| `flutter pub add nombre_paquete` | Agrega un paquete al proyecto |
| `flutter clean` | Limpia archivos compilados (útil cuando hay errores extraños) |
| `flutter analyze` | Analiza el código con el linter de Dart |
| `flutter test` | Ejecuta las pruebas automatizadas |
| `flutter upgrade` | Actualiza Flutter al canal actual |
| `flutter doctor` | Verifica el entorno de desarrollo |

---

## Archivos de este módulo

| Archivo | Tema |
|---|---|
| `01_material_app.dart` | MaterialApp: la raíz de toda app Flutter |
| `02_scaffold.dart` | Scaffold y todos sus componentes |
| `03_cupertino_app.dart` | Estilo iOS con CupertinoApp |
| `04_hot_reload.md` | Hot Reload vs Hot Restart |
