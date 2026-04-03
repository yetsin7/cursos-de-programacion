# Módulo 19 — Temas y Estilos en Flutter

El sistema de temas de Flutter permite crear una identidad visual consistente para toda la aplicación con un único punto de configuración.

## Contenido

### 01_themedata.dart
Configuración básica de `ThemeData` con Material 3.
- `ColorScheme.fromSeed()` para generar paletas completas
- Personalizar componentes: `AppBar`, `ElevatedButton`, `Card`
- `Theme.of(context)` y sub-temas con `Theme` widget

### 02_modo_oscuro.dart
Soporte de modo claro y oscuro.
- `theme` y `darkTheme` en `MaterialApp`
- `ThemeMode` controlado por el usuario
- `ColorScheme` que se adapta automáticamente

### 03_tipografia.dart
Sistema tipográfico de Material 3.
- `TextTheme` completo
- Integración con `google_fonts`
- Accesibilidad y `textScaler`

### 04_colores_y_gradientes.dart
Sistema de colores y gradientes.
- `Colors.*`, hex, ARGB, RGBO
- `LinearGradient` y `RadialGradient`
- Roles del `ColorScheme`

## Conceptos clave

| Concepto | Descripción |
|---|---|
| `ThemeData` | Configuración visual global de la app |
| `ColorScheme.fromSeed()` | Genera una paleta completa desde un color semilla |
| `ThemeMode` | Controla si se usa tema claro, oscuro o del sistema |
| `TextTheme` | Define los estilos de texto del sistema tipográfico |
