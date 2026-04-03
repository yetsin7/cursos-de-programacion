# Módulo 26 — Internacionalización (i18n) en Flutter

La internacionalización permite que tu app hable el idioma del usuario. En Flutter, el sistema oficial usa archivos **ARB** (Application Resource Bundle) y generación automática de código.

---

## ¿Por qué i18n desde el inicio?

- Agregar i18n tarde significa refactorizar TODOS los widgets.
- Los textos hardcoded son deuda técnica inmediata.
- Google Play y App Store valoran las apps multiidioma.
- Los errores de encoding (ñ, á, é) aparecen si no se hace bien desde el principio.

---

## Arquitectura del sistema i18n en Flutter

```
lib/
├── l10n/
│   ├── app_es.arb     ← Español (idioma base)
│   └── app_en.arb     ← Inglés
├── main.dart          ← Configura MaterialApp con localizationsDelegates
└── ...

pubspec.yaml           ← flutter_localizations + generate: true
```

El comando `flutter gen-l10n` genera automáticamente:
```
.dart_tool/flutter_gen/gen_l10n/
├── app_localizations.dart
├── app_localizations_es.dart
└── app_localizations_en.dart
```

---

## Archivos del módulo

### `01_arb_setup.md`
Guía paso a paso para configurar i18n desde cero en un proyecto nuevo o existente.

### `02_uso_l10n.dart`
App completa que demuestra:
- Cómo consumir las traducciones en widgets
- Cómo detectar el idioma del sistema
- Cómo cambiar el idioma manualmente
- Plurales en ARB

### `03_ejemplo_app_es.arb`
Archivo ARB con 15 claves en español — listo para copiar en tu proyecto.

### `04_ejemplo_app_en.arb`
Las mismas 15 claves en inglés.

---

## Regla de oro

> Nunca escribas texto visible directamente en un widget.  
> Siempre usa `AppLocalizations.of(context)!.clave`.

---

## Siguiente módulo

**Módulo 27 — Publicar app:** keystore, firma, Google Play y optimizaciones para producción.
