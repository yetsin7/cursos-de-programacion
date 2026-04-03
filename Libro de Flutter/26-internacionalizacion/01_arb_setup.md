# Configuración de i18n con ARB en Flutter

Guía paso a paso para agregar soporte multiidioma a cualquier proyecto Flutter.

---

## Paso 1 — Agregar dependencias en `pubspec.yaml`

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:       # Incluido en el SDK de Flutter
    sdk: flutter
  intl: ^0.19.0                # Necesario para plurales y formatos

flutter:
  generate: true               # Habilita la generación automática de código
```

> `flutter_localizations` provee los delegates de Material, Cupertino y Widgets.  
> `intl` es necesario para plurales, géneros y formatos de fecha/número.

---

## Paso 2 — Crear la carpeta `lib/l10n/`

```
tu_proyecto/
└── lib/
    └── l10n/
        ├── app_es.arb    ← Español (idioma base recomendado)
        └── app_en.arb    ← Inglés
```

Los archivos ARB son JSON con una sintaxis especial para metadatos.

---

## Paso 3 — Crear el archivo `lib/l10n/app_es.arb`

```json
{
  "@@locale": "es",
  "appTitle": "Mi Aplicación",
  "@appTitle": {
    "description": "Título principal de la aplicación"
  },
  "bienvenido": "Bienvenido, {nombre}",
  "@bienvenido": {
    "description": "Saludo personalizado con nombre del usuario",
    "placeholders": {
      "nombre": {
        "type": "String",
        "example": "Carlos"
      }
    }
  },
  "elementos": "{cantidad, plural, =0{Sin elementos} =1{Un elemento} other{{cantidad} elementos}}",
  "@elementos": {
    "description": "Contador de elementos con plural",
    "placeholders": {
      "cantidad": {
        "type": "int"
      }
    }
  }
}
```

---

## Paso 4 — Crear el archivo `lib/l10n/app_en.arb`

```json
{
  "@@locale": "en",
  "appTitle": "My Application",
  "bienvenido": "Welcome, {nombre}",
  "elementos": "{cantidad, plural, =0{No items} =1{One item} other{{cantidad} items}}"
}
```

> Las claves deben ser IDÉNTICAS en ambos archivos.  
> Solo el archivo base (`app_es.arb`) necesita los metadatos `@clave`.

---

## Paso 5 — Crear `l10n.yaml` en la raíz del proyecto

```yaml
arb-dir: lib/l10n
template-arb-file: app_es.arb
output-localization-file: app_localizations.dart
```

Este archivo le dice a `flutter gen-l10n` dónde están los ARB y cómo llamar al archivo generado.

---

## Paso 6 — Configurar `MaterialApp` en `main.dart`

```dart
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

MaterialApp(
  // Delegates: le dicen a Flutter cómo traducir los widgets internos
  localizationsDelegates: const [
    AppLocalizations.delegate,              // Tus traducciones
    GlobalMaterialLocalizations.delegate,   // Material widgets
    GlobalWidgetsLocalizations.delegate,    // Widgets base
    GlobalCupertinoLocalizations.delegate,  // iOS widgets
  ],
  // Idiomas soportados por la app
  supportedLocales: const [
    Locale('es'), // Español
    Locale('en'), // Inglés
  ],
  // Resolución del idioma: si el sistema usa un idioma no soportado,
  // Flutter escoge el más cercano o el primero de la lista.
  localeResolutionCallback: (locale, supportedLocales) {
    for (final supported in supportedLocales) {
      if (supported.languageCode == locale?.languageCode) {
        return supported;
      }
    }
    return supportedLocales.first; // Fallback: español
  },
  home: const MiPantallaInicio(),
)
```

---

## Paso 7 — Ejecutar la generación de código

```bash
flutter gen-l10n
```

Esto genera los archivos en `.dart_tool/flutter_gen/gen_l10n/`.  
También se ejecuta automáticamente con `flutter run` y `flutter build`.

---

## Paso 8 — Usar las traducciones en los widgets

```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Acceso simple
Text(AppLocalizations.of(context)!.appTitle)

// Con parámetros
Text(AppLocalizations.of(context)!.bienvenido('Carlos'))

// Con plural
Text(AppLocalizations.of(context)!.elementos(3))
```

---

## Resumen rápido

| Paso | Acción |
|------|--------|
| 1 | Agregar `flutter_localizations` e `intl` en pubspec.yaml |
| 2 | Crear `lib/l10n/app_es.arb` y `lib/l10n/app_en.arb` |
| 3 | Crear `l10n.yaml` en la raíz |
| 4 | Configurar `MaterialApp` con delegates y supportedLocales |
| 5 | Ejecutar `flutter gen-l10n` |
| 6 | Usar `AppLocalizations.of(context)!.clave` en los widgets |

---

## Errores comunes

**Error: `AppLocalizations` no encontrado**  
→ Verifica que `generate: true` esté en `pubspec.yaml` bajo `flutter:`.

**Error: clave faltante en un idioma**  
→ Ambos ARB deben tener exactamente las mismas claves.

**Texto en español con caracteres corruptos (sesiÃ³n)**  
→ Guarda los archivos ARB con codificación **UTF-8 sin BOM**.

**La app no cambia de idioma**  
→ Verifica `supportedLocales` y que el dispositivo tenga ese idioma configurado.
