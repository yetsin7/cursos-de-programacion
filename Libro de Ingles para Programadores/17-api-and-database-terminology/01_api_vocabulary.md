# Vocabulario de APIs

## Introducción

Las APIs (Application Programming Interfaces) son la columna vertebral del desarrollo
moderno. Conocer su terminología en inglés es imprescindible para leer documentación,
participar en discusiones técnicas y trabajar en equipos internacionales.

---

## Términos fundamentales

| Término | Pronunciación | Significado |
|---------|--------------|-------------|
| **Endpoint** | /ˈendpɔɪnt/ | URL específica donde se accede a un recurso de la API |
| **Request** | /rɪˈkwest/ | Solicitud que el cliente envía al servidor |
| **Response** | /rɪˈspɒns/ | Respuesta que el servidor devuelve al cliente |
| **Payload** | /ˈpeɪloʊd/ | Datos enviados en el cuerpo de una request o response |
| **Header** | /ˈhedər/ | Metadatos enviados con la request o response |
| **Body** | /ˈbɒdi/ | Contenido principal de la request o response |
| **Query parameter** | /ˈkwɪri pəˈræmɪtər/ | Parámetro enviado en la URL después del `?` |
| **Path parameter** | /pæθ pəˈræmɪtər/ | Parámetro incluido en la ruta de la URL |

### Ejemplos en contexto

```
GET /api/users/42?include=posts&limit=10
     ──────────── ─────────────────────
     path param    query parameters
     (42)          (include, limit)
```

```javascript
// Request con header y body
fetch('/api/users', {
  method: 'POST',               // Método HTTP
  headers: {                     // Headers (metadatos)
    'Content-Type': 'application/json',
    'Authorization': 'Bearer abc123'
  },
  body: JSON.stringify({         // Body (payload)
    name: 'John',
    email: 'john@example.com'
  })
});
```

---

## Códigos de estado HTTP (Status Codes)

Los status codes se agrupan por categoría. Es esencial conocerlos en inglés.

### Éxito (2xx)

| Código | Nombre | Significado | Uso común |
|--------|--------|-------------|-----------|
| 200 | OK | Solicitud exitosa | GET exitoso |
| 201 | Created | Recurso creado | POST exitoso |
| 204 | No Content | Éxito sin contenido | DELETE exitoso |

### Error del cliente (4xx)

| Código | Nombre | Significado | Uso común |
|--------|--------|-------------|-----------|
| 400 | Bad Request | Solicitud mal formada | Datos inválidos |
| 401 | Unauthorized | No autenticado | Falta token |
| 403 | Forbidden | No autorizado | Sin permisos |
| 404 | Not Found | Recurso no encontrado | URL incorrecta |
| 409 | Conflict | Conflicto con estado actual | Duplicado |
| 422 | Unprocessable Entity | Datos válidos pero no procesables | Validación fallida |
| 429 | Too Many Requests | Límite de rate excedido | Rate limiting |

### Error del servidor (5xx)

| Código | Nombre | Significado | Uso común |
|--------|--------|-------------|-----------|
| 500 | Internal Server Error | Error interno del servidor | Bug en el servidor |
| 502 | Bad Gateway | Respuesta inválida de servidor upstream | Proxy error |
| 503 | Service Unavailable | Servicio no disponible | Mantenimiento |
| 504 | Gateway Timeout | Timeout del servidor upstream | Servidor lento |

### Cómo hablar de status codes

```
"The API returns a 200 OK with the user data."
"If the token is invalid, you'll get a 401 Unauthorized."
"A 404 means the resource was not found."
"We're getting 500s in production." (coloquial para errores 500)
```

---

## Autenticación y autorización

| Término | Significado | Ejemplo |
|---------|-------------|---------|
| **Authentication** (AuthN) | Verificar quién eres | Login con email/password |
| **Authorization** (AuthZ) | Verificar qué puedes hacer | Permisos de admin |
| **Token** | Cadena que representa tu identidad | JWT, OAuth token |
| **API key** | Clave para identificar la aplicación | `x-api-key: abc123` |
| **Bearer token** | Token enviado en el header Authorization | `Authorization: Bearer xyz` |
| **OAuth** | Protocolo de autorización delegada | "Login with Google" |
| **JWT** (JSON Web Token) | Token autocontenido con claims | Header.Payload.Signature |
| **Session** | Estado del usuario en el servidor | Cookie de sesión |

### Ejemplo de uso

```
"The endpoint requires authentication via a Bearer token."
"You need to pass your API key in the x-api-key header."
"Authentication verifies identity; authorization verifies permissions."
```

---

## Conceptos avanzados de API

| Término | Significado |
|---------|-------------|
| **Rate limiting** | Limitar el número de requests por período de tiempo |
| **Pagination** | Dividir resultados grandes en páginas |
| **Webhook** | URL que recibe notificaciones automáticas cuando ocurre un evento |
| **CRUD** | Create, Read, Update, Delete — las 4 operaciones básicas |
| **Idempotent** | Una operación que produce el mismo resultado sin importar cuántas veces se ejecute |
| **Versioning** | Manejar diferentes versiones de la API (`/v1/`, `/v2/`) |
| **Throttling** | Reducir la velocidad de requests (similar a rate limiting) |
| **Caching** | Almacenar respuestas para evitar requests repetidas |

### Rate limiting en contexto

```
"The API has a rate limit of 100 requests per minute."
"If you exceed the rate limit, you'll receive a 429 status code."
"Use caching to reduce the number of API calls."
```

### Pagination en contexto

```
"The endpoint supports pagination with `page` and `limit` parameters."
"GET /api/users?page=2&limit=20 returns the second page of 20 users."
"The response includes a `total` field and `nextPage` URL."
```

---

## Tipos de API

| Tipo | Descripción |
|------|-------------|
| **REST** (Representational State Transfer) | Arquitectura basada en recursos y métodos HTTP |
| **GraphQL** | Lenguaje de consulta donde el cliente define qué datos necesita |
| **gRPC** | Framework de Google para comunicación de alta velocidad con Protocol Buffers |
| **WebSocket** | Conexión bidireccional persistente para datos en tiempo real |
| **SOAP** | Protocolo basado en XML (legacy, menos común hoy) |

### Cómo hablar de tipos de API

```
"We use a REST API for the public-facing endpoints."
"The mobile app consumes a GraphQL API."
"Inter-service communication uses gRPC for performance."
"The chat feature uses WebSockets for real-time messaging."
```

---

## Métodos HTTP y CRUD

| Método HTTP | Operación CRUD | Descripción |
|-------------|---------------|-------------|
| GET | Read | Obtener recursos |
| POST | Create | Crear un recurso |
| PUT | Update (completo) | Reemplazar un recurso |
| PATCH | Update (parcial) | Modificar parte de un recurso |
| DELETE | Delete | Eliminar un recurso |

```
"Send a GET request to retrieve the user list."
"Use POST to create a new record."
"PATCH updates only the specified fields."
"PUT replaces the entire resource."
```

---

## Resumen de frases comunes con APIs

```
"Hit the endpoint"       → Hacer una request a un endpoint
"Consume an API"         → Usar/integrar una API
"Call the API"           → Hacer una request a la API
"The API exposes..."     → La API ofrece/expone...
"Parse the response"     → Analizar/procesar la respuesta
"Handle the error"       → Manejar el error
"Authenticate against"   → Autenticarse contra (un servicio)
"Pass the token"         → Enviar/pasar el token
"Paginate the results"   → Paginar los resultados
```
