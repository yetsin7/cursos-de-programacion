# Módulo 18 — Formularios en Flutter

Los formularios son fundamentales en cualquier aplicación que necesite recopilar datos del usuario.

## Contenido

### 01_form_basico.dart
Introducción al widget `Form` con validación básica.
- `Form` con `GlobalKey<FormState>`
- `TextFormField` con `validator`
- `validate()`, `save()`, `reset()`
- `SnackBar` al enviar exitosamente

### 02_validacion.dart
Validaciones avanzadas y UX de formularios.
- Validadores: requerido, email, longitud mínima, confirmar contraseña
- Mostrar/ocultar contraseña
- `AutovalidateMode`
- `FocusNode` para navegar entre campos

### 03_ejercicios.dart
Ejercicios prácticos para reforzar los conceptos de formularios.

## Conceptos clave

| Concepto | Descripción |
|---|---|
| `GlobalKey<FormState>` | Llave para controlar el estado del formulario |
| `TextFormField` | Campo de texto con soporte de validación integrado |
| `validator` | Función que retorna un mensaje de error o `null` si es válido |
| `AutovalidateMode` | Cuándo se ejecutan los validadores automáticamente |
| `FocusNode` | Controla el foco del teclado entre campos |
