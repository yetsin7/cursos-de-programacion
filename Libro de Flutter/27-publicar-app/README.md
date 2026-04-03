# Módulo 27 — Publicar una app Flutter en producción

Este módulo cubre todo el proceso para llevar tu app de desarrollo a producción: configuración del release, firma con keystore, publicación en Google Play y optimizaciones de rendimiento.

---

## Flujo completo de publicación

```
Desarrollo  →  Preparar release  →  Firmar APK/AAB  →  Google Play  →  Usuarios
```

---

## Archivos del módulo

### `01_preparar_release.md`
Cómo configurar la app para producción:
- Nombre e ícono de la app
- Versión semántica: `versionName+versionCode`
- Deshabilitar logs
- R8 (minificación y ofuscación)
- Inspeccionar el tamaño

### `02_firma_android.md`
Cómo firmar la app para Android:
- Generar keystore con `keytool`
- Dónde guardar el keystore (seguro)
- Configurar `build.gradle` para release
- Comandos de build

### `03_play_store.md`
Cómo subir la app a Google Play:
- Crear cuenta de desarrollador
- Assets necesarios
- Completar la ficha de la app
- Primera publicación vs actualizaciones

### `04_optimizaciones.md`
Buenas prácticas de rendimiento para apps en producción:
- Ofuscación con `--obfuscate`
- `const` constructors
- Evitar rebuilds innecesarios
- Análisis y testing antes de publicar

---

## Diferencias clave: debug vs release

| | Debug | Release |
|---|---|---|
| Velocidad | Lenta (JIT) | Rápida (AOT) |
| Tamaño | Grande | Pequeño |
| Logs | Visibles | Desactivados |
| Firma | Automática (debug) | Keystore propio |
| Ofuscación | No | Sí (R8) |

---

## Comandos esenciales

```bash
# APK universal (para pruebas y distribución directa)
flutter build apk --release

# AAB (obligatorio para Google Play desde agosto 2021)
flutter build appbundle --release

# Con ofuscación
flutter build appbundle --release --obfuscate --split-debug-info=build/debug-info

# Instalar APK en dispositivo conectado
flutter install --release
```

---

## Siguiente módulo

**Módulo 28 — Proyecto Biblia (Dart consola):** acceder a una base de datos SQLite real con Dart puro, sin Flutter.
