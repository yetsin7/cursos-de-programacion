# Módulo 22 — HTTP y APIs REST

Consumir APIs REST es una necesidad en la gran mayoría de apps modernas. Flutter ofrece el paquete `http` para necesidades básicas y `Dio` para casos avanzados.

## Contenido

### 01_http_basico.dart
Primeros pasos con peticiones HTTP.
- `http.get()`, `http.post()`, `http.put()`, `http.delete()`
- Parsear respuestas JSON
- `FutureBuilder` para estados de carga

### 02_json_parsing.dart
Manejo profesional de JSON.
- Modelos con `fromJson()` / `toJson()`
- Listas de objetos
- Por qué evitar `dynamic`

### 03_dio_avanzado.dart
Dio: cliente HTTP avanzado.
- `BaseOptions` con `baseUrl`, headers, timeouts
- `Interceptors` para logging y auth
- `CancelToken`, `FormData`
- Manejo de `DioException`

### 04_ejercicios.dart
Ejercicios prácticos integrando HTTP y modelos.

## APIs públicas para practicar

| API | URL | Descripción |
|---|---|---|
| JSONPlaceholder | `https://jsonplaceholder.typicode.com` | Posts, usuarios, comentarios falsos |
| Open Meteo | `https://api.open-meteo.com` | Clima sin clave API |
| PokeAPI | `https://pokeapi.co` | Datos de Pokémon |
