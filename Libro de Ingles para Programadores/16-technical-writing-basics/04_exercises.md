# Ejercicios: Fundamentos de Escritura Técnica

---

## Ejercicio 1: Convierte de voz pasiva a voz activa

Reescribe cada oración en voz activa:

1. "The configuration is loaded by the application at startup."
2. "The tests are executed by the CI pipeline."
3. "The error was discovered by the QA team during testing."
4. "A new instance is created by the factory method."
5. "The request body is parsed by the middleware."
6. "The dependencies are installed by running npm install."
7. "The route is defined in the router file."
8. "The old API was replaced by a new REST endpoint."

### Respuestas

1. "The application loads the configuration at startup."
2. "The CI pipeline executes the tests."
3. "The QA team discovered the error during testing."
4. "The factory method creates a new instance."
5. "The middleware parses the request body."
6. "Run npm install to install the dependencies."
7. "Define the route in the router file." (o "The router file defines the route.")
8. "A new REST endpoint replaced the old API."

---

## Ejercicio 2: Elimina el relleno

Reescribe cada oración eliminando palabras innecesarias:

1. "Basically, you just need to actually run the command to install it."
2. "In order to utilize the API, you really need to sort of configure authentication."
3. "It should be noted that this function is actually quite slow due to the fact that it uses recursion."
4. "At this point in time, the feature is kind of not really ready for production."
5. "You're going to want to basically make sure that you have the right version."

### Respuestas

1. "Run the command to install it." (o "Run `npm install`.")
2. "To use the API, configure authentication."
3. "This function is slow because it uses recursion."
4. "This feature is not ready for production."
5. "Make sure you have the correct version."

---

## Ejercicio 3: Sé específico

Reescribe cada oración vaga con información específica (inventa detalles realistas):

1. "This function does some stuff with the data."
2. "The app might have some issues with performance."
3. "You need to set up some things before running the project."
4. "This handles the user stuff."
5. "There are several ways to fix this."

### Respuestas posibles

1. "This function validates email format and removes duplicate entries."
2. "The app's response time exceeds 3 seconds when processing arrays larger than 50,000 items."
3. "Install Node.js 18+ and PostgreSQL 15 before running the project."
4. "This module handles user registration, login, and password recovery."
5. "You can fix this by: (a) adding an index to the `users` table, (b) implementing pagination, or (c) caching the query results."

---

## Ejercicio 4: Usa las frases técnicas correctas

Completa cada oración con la frase técnica apropiada:

1. "_______ the server listens on port 3000."
2. "_______ you have Docker installed before proceeding."
3. "The `findOne()` method _______ `findById()`."
4. "_______, the API returns JSON format."
5. "_______, the framework generates routes from the file system."
6. "_______, see the [Configuration Guide](/docs/config)."
7. "_______ this endpoint requires authentication."
8. "_______ 2.0, this feature supports TypeScript."

**Opciones:** By default / Make sure / is deprecated in favor of / Under the hood / For more information / Note that / As of version / Out of the box

### Respuestas

1. "**By default**, the server listens on port 3000."
2. "**Make sure** you have Docker installed before proceeding."
3. "The `findOne()` method **is deprecated in favor of** `findById()`."
4. "**Out of the box**, the API returns JSON format."
5. "**Under the hood**, the framework generates routes from the file system."
6. "**For more information**, see the [Configuration Guide](/docs/config)."
7. "**Note that** this endpoint requires authentication."
8. "**As of version** 2.0, this feature supports TypeScript."

---

## Ejercicio 5: Reescribe esta documentación

Reescribe el siguiente párrafo aplicando todos los principios del capítulo:

```
Basically, in order to get started with using this library,
you're going to need to actually install it first by kind of
running the install command. It should be noted that the library
sort of requires Python 3.9 or something like that. After that,
you can basically import it and just use the main function to
do stuff with your data. If you run into issues, there's some
documentation somewhere that might help.
```

### Respuesta sugerida

```markdown
## Getting Started

**Prerequisites:** Python 3.9+

### Installation

Install the library with pip:

```bash
pip install dataprocessor
```

### Usage

```python
from dataprocessor import transform

result = transform(your_data)
```

For troubleshooting, see the [Documentation](/docs).
```

---

## Ejercicio 6: Escribe documentación desde cero

Escribe una breve sección de README en inglés para una función con estas
características:

- Nombre: `calculateShipping`
- Recibe: peso del paquete (kg), código de país
- Retorna: costo de envío en USD
- Por defecto usa envío estándar (5-7 días)
- Opcionalmente puede usar envío express (1-2 días)
- Deprecó el parámetro `region` en favor de `countryCode`
- Requiere una API key válida

### Respuesta sugerida

```markdown
### `calculateShipping(weight, countryCode, options?)`

Calculates the shipping cost in USD based on package weight
and destination.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| weight | number | Yes | Package weight in kg |
| countryCode | string | Yes | ISO 3166-1 country code |
| options.express | boolean | No | Use express shipping (1-2 days) |

**Returns:** `number` — Shipping cost in USD.

By default, this uses standard shipping (5-7 business days).
Optionally, you can enable express shipping for faster delivery.

> **Note that** the `region` parameter is deprecated in favor
> of `countryCode`. It will be removed in v3.0.

> **Important:** This requires a valid API key. Make sure to
> set `SHIPPING_API_KEY` in your environment variables.
```

---

## Ejercicio 7: Identifica los problemas

Lee esta documentación e identifica al menos 5 problemas de escritura:

```
So basically this endpoint is utilized to facilitate the
retrieval of user data. A GET request should be sent by the
client to the /users endpoint. The response is returned in
JSON format by the server. It should be noted that you kind
of need authentication. In the event that an error occurs,
an error response is returned. For additional information
regarding configuration, the docs can be consulted.
```

### Respuestas

1. **Relleno:** "So basically", "kind of"
2. **Voz pasiva innecesaria:** "A GET request should be sent by the client", "The response is returned by the server", "an error response is returned", "the docs can be consulted"
3. **Palabras complejas:** "utilized", "facilitate", "retrieval", "In the event that", "regarding"
4. **Vaguedad:** "you kind of need authentication" (qué tipo?), "an error response" (qué código?)
5. **Frase innecesaria:** "It should be noted that"

**Versión corregida:**

```markdown
### GET /users

Returns user data in JSON format.

**Authentication:** Requires a Bearer token in the `Authorization` header.

**Success response:** `200 OK` with an array of user objects.

**Error responses:**
- `401 Unauthorized` — Missing or invalid token.
- `500 Internal Server Error` — Server failure.

For more information, see the [Configuration Guide](/docs/config).
```
