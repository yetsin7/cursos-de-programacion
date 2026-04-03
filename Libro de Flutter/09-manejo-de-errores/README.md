# Módulo 09 — Manejo de Errores en Dart

## ¿Por qué importa el manejo de errores?

Toda aplicación real interactúa con el mundo exterior: lee archivos, hace peticiones HTTP, parsea datos del usuario, accede a bases de datos. Cualquiera de estas operaciones puede fallar. Sin manejo adecuado de errores, la app crasha; con manejo inadecuado, los errores se silencian y producen comportamientos inesperados.

## Exception vs Error en Dart

Esta distinción es importante y frecuentemente confundida:

| Tipo | Cuándo ocurre | ¿Debes atrapar? |
|---|---|---|
| `Exception` | Condición esperada, recuperable | Sí — son parte de la lógica |
| `Error` | Bug en el programa, no recuperable | No — indica un error del programador |

### Ejemplos de Exception
- `FormatException` — parsing de datos malformados
- `IOException` — error de entrada/salida
- `HttpException` — error de red

### Ejemplos de Error
- `AssertionError` — assert falló
- `RangeError` — índice fuera de rango
- `NullCheckError` — operador `!` sobre null
- `StackOverflowError` — recursión infinita

## try / catch / finally

```dart
try {
  // Código que puede lanzar una excepción
} on FormatException catch (e) {
  // Solo atrapa FormatException
} catch (e, stackTrace) {
  // Atrapa cualquier excepción
} finally {
  // SIEMPRE se ejecuta (limpiar recursos)
}
```

## El Result Pattern

Una alternativa moderna a las excepciones para errores esperados:

```dart
Result<Usuario, String> resultado = buscarUsuario(id);
resultado.cuando(
  onExito: (u) => mostrar(u),
  onError: (e) => mostrarError(e),
);
```

## Archivos de este módulo

| Archivo | Contenido |
|---|---|
| `01_try_catch.dart` | try/catch/finally, rethrow, cuándo usarlo |
| `02_excepciones_personalizadas.dart` | Jerarquías de excepciones y Result pattern |
| `03_ejercicios.dart` | Ejercicios con soluciones |

## Cómo ejecutar

```bash
dart run 01_try_catch.dart
dart run 02_excepciones_personalizadas.dart
dart run 03_ejercicios.dart
```
