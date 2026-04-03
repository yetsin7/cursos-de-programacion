# Módulo 24 — Testing en Flutter

Una app profesional tiene una suite de tests que garantiza que el código funciona correctamente y que los cambios no rompen funcionalidad existente.

## Tipos de tests

| Tipo | Velocidad | Cobertura | Cuándo usar |
|---|---|---|---|
| Unit Test | Muy rápido | Lógica de negocio | Siempre |
| Widget Test | Rápido | UI + interacción | Siempre |
| Golden Test | Rápido | Apariencia visual | Componentes de diseño |
| Integration Test | Lento | Flujos completos | Casos críticos |

## Contenido

### 01_unit_test.dart
Tests unitarios para lógica de negocio.
- `test()`, `group()`, `expect()`
- `setUp()`, `tearDown()`
- Mocking con `mockito`

### 02_widget_test.dart
Tests de widgets e interacción de usuario.
- `testWidgets()`, `WidgetTester`
- `find.text()`, `find.byType()`
- Simular toques y entradas de texto

### 03_golden_test.dart
Snapshot tests de la UI.
- `matchesGoldenFile()`
- Detectar cambios visuales no intencionados

### 04_integration_test.dart
Tests end-to-end de la aplicación completa.
- `integration_test` package
- Flujos de usuario completos
- Uso en CI/CD

## Pirámide de testing recomendada

```
        /\
       /  \
      / IT \    ← Pocos integration tests
     /──────\
    / Widget \  ← Cantidad moderada de widget tests
   /──────────\
  / Unit Tests \← Muchos unit tests (base sólida)
 /──────────────\
```
