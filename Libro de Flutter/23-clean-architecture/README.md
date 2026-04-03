# Módulo 23 — Clean Architecture en Flutter

Clean Architecture es el estándar profesional para construir apps Flutter escalables y mantenibles.

## Las 3 capas

```
┌─────────────────────────────────────┐
│         PRESENTATION LAYER          │
│   Widgets, Providers, BLoCs, UI     │
├─────────────────────────────────────┤
│           DOMAIN LAYER              │
│  Entidades, Use Cases, Repos (abs.) │
├─────────────────────────────────────┤
│            DATA LAYER               │
│  Modelos, DataSources, Repos (impl) │
└─────────────────────────────────────┘
```

**Regla de dependencias:** Las capas internas (Domain) no conocen las externas (Data, Presentation).

## Contenido

### 01_domain_layer.dart
Capa de dominio: el corazón de la app.
- Entidades puras sin dependencias externas
- Use Cases con método `execute()`
- Repositorios abstractos
- Clase `Failure` para errores

### 02_data_layer.dart
Capa de datos: implementaciones concretas.
- Modelos que extienden entidades
- DataSources abstractos e implementaciones
- Repositorios concretos
- Mapeo de modelos a entidades

### 03_presentation_layer.dart
Capa de presentación: UI separada de lógica.
- Notifiers que llaman Use Cases
- Estados: initial, loading, loaded, error

### 04_dependency_injection.dart
Inyección de dependencias con `get_it`.
- Service locator pattern
- Inicialización al arrancar la app
- Beneficios para testing
