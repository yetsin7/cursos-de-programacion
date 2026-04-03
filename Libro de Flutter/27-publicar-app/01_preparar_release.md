# Preparar el release de una app Flutter

Antes de firmar y publicar, la app debe estar correctamente configurada para producción.

---

## 1. Nombre e ícono de la app

### Cambiar el nombre de la app

**Android** — en `android/app/src/main/AndroidManifest.xml`:
```xml
<application
    android:label="Mi App"
    ...>
```

**iOS** — en `ios/Runner/Info.plist`:
```xml
<key>CFBundleDisplayName</key>
<string>Mi App</string>
```

### Cambiar el ícono

Usa el paquete `flutter_launcher_icons` para generar todos los tamaños automáticamente:

```yaml
# pubspec.yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.0

flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icon/app_icon.png"  # 1024x1024 px, sin transparencia
  adaptive_icon_background: "#FFFFFF"     # Solo Android 8+
  adaptive_icon_foreground: "assets/icon/app_icon_foreground.png"
```

```bash
dart run flutter_launcher_icons
```

---

## 2. Versión de la app

En `pubspec.yaml`:
```yaml
version: 1.0.0+1
#        │   │
#        │   └── versionCode (número entero, incrementar en cada release)
#        └────── versionName (visible para el usuario: MAYOR.MENOR.PARCHE)
```

**Reglas para `versionCode`:**
- Debe ser mayor al anterior en cada actualización
- Google Play rechaza subidas con el mismo versionCode
- Convención común: `10203` para v1.2.3

```bash
# También se puede especificar en el comando de build
flutter build appbundle --build-name=1.0.0 --build-number=1
```

---

## 3. Deshabilitar logs en producción

Los logs (`print`, `debugPrint`) son visibles en debug. Para producción:

```dart
// Opción 1: Verificar el modo antes de imprimir
import 'package:flutter/foundation.dart';

if (kDebugMode) {
  print('Solo se ve en desarrollo');
}

// Opción 2: Reemplazar todos los print con debugPrint
// debugPrint es automáticamente ignorado en release

// Opción 3: Wrapper personalizado
void log(String mensaje) {
  if (kDebugMode) print('[LOG] $mensaje');
}
```

---

## 4. R8 — Minificación y ofuscación (Android)

R8 reemplaza a ProGuard desde Android Gradle Plugin 3.4+. Está habilitado por defecto en release builds.

### ¿Qué hace R8?
- **Minifica:** elimina código no utilizado (tree shaking)
- **Ofusca:** renombra clases y métodos a nombres cortos (a, b, c...)
- **Optimiza:** simplifica el bytecode

### Verificar que está habilitado

En `android/app/build.gradle`:
```groovy
buildTypes {
    release {
        minifyEnabled true        // Activa R8
        shrinkResources true      // Elimina recursos no usados
        proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'),
                     'proguard-rules.pro'
    }
}
```

### Reglas de excepción (proguard-rules.pro)

Si usas reflexión o clases que NO deben ser ofuscadas:
```
# Mantener modelos de datos usados con JSON
-keep class com.miapp.models.** { *; }

# Mantener interfaces de callbacks
-keep interface com.miapp.callbacks.** { *; }
```

---

## 5. Inspeccionar el tamaño del APK

```bash
# Analizar el tamaño del APK
flutter build apk --analyze-size

# Ver qué está ocupando espacio
flutter build appbundle --analyze-size
```

Esto genera un resumen como:
```
app-release.apk (total compressed)
  dart-code: 4.2 MB
  flutter-framework: 6.8 MB
  native-libs: 2.1 MB
  assets: 1.5 MB
  ...
```

### Reducir el tamaño

```bash
# Generar APKs separados por arquitectura (ABI)
flutter build apk --split-per-abi

# Genera:
# app-armeabi-v7a-release.apk  (~12 MB)
# app-arm64-v8a-release.apk    (~14 MB)
# app-x86_64-release.apk       (~15 MB)
```

> Para Google Play, siempre usa **AAB** (`flutter build appbundle`).
> Google genera automáticamente el APK correcto para cada dispositivo.

---

## 6. Configuración de Dart en producción

```dart
// Verificar el modo de ejecución
import 'package:flutter/foundation.dart';

kDebugMode   // true solo en debug
kReleaseMode // true solo en release
kProfileMode // true solo en profile (para DevTools)

// Ejemplo de uso:
Widget build(BuildContext context) {
  return Column(
    children: [
      if (kDebugMode) const BannerDesarrollo(), // Solo visible en debug
      const ContenidoPrincipal(),
    ],
  );
}
```
