# Describiendo Flujos de Datos en Inglés

## Introducción

Saber describir cómo fluyen los datos a través de un sistema es una habilidad
esencial para presentaciones, documentación de arquitectura, code reviews y
entrevistas técnicas. En este módulo aprenderás las frases y patrones en
inglés para hacerlo con claridad.

---

## Verbos clave para describir flujos de datos

| Verbo | Significado | Ejemplo |
|-------|-------------|---------|
| **send** | enviar | The client sends a request |
| **receive** | recibir | The server receives the payload |
| **return** | retornar/devolver | The function returns a JSON object |
| **forward** | reenviar | The proxy forwards the request |
| **redirect** | redirigir | The server redirects to /login |
| **validate** | validar | The middleware validates the token |
| **authenticate** | autenticar | The service authenticates the user |
| **authorize** | autorizar | The guard authorizes the action |
| **transform** | transformar | The mapper transforms the DTO |
| **persist** | persistir/guardar | The repository persists the entity |
| **fetch** | obtener | The controller fetches user data |
| **cache** | almacenar en caché | The service caches the response |
| **emit** | emitir | The socket emits an event |
| **consume** | consumir | The worker consumes messages from the queue |
| **process** | procesar | The handler processes the payment |
| **trigger** | disparar | The webhook triggers a notification |
| **propagate** | propagar | The error propagates up the call stack |
| **resolve** | resolver | The DNS resolves the domain name |
| **serialize** | serializar | The app serializes the object to JSON |
| **deserialize** | deserializar | The parser deserializes the JSON string |

---

## Patrón: Request → Response

El flujo más básico en cualquier API.

### Descripción paso a paso

```
1. The client sends a POST request to the /users endpoint.
2. The server receives the request and extracts the body.
3. The middleware validates the authentication token.
4. The controller calls the user service with the payload.
5. The service validates the data and creates a new user.
6. The repository persists the user in the database.
7. The server returns a 201 Created response with the new user data.
```

### Frases de conexión

| Frase | Significado |
|-------|-------------|
| First, ... | Primero, ... |
| Then, ... | Luego, ... |
| Next, ... | Después, ... |
| After that, ... | Después de eso, ... |
| Finally, ... | Finalmente, ... |
| Once the X is done, ... | Una vez que X se completa, ... |
| Before forwarding, ... | Antes de reenviar, ... |
| Upon receiving, ... | Al recibir, ... |
| If successful, ... | Si es exitoso, ... |
| In case of failure, ... | En caso de fallo, ... |

---

## Patrón: Middleware y capas

Describir cómo una request pasa por múltiples capas.

```
The request first hits the load balancer, which distributes
it to an available server. The server's middleware pipeline
processes the request in order:

1. The CORS middleware checks the request origin.
2. The rate limiter verifies the client hasn't exceeded
   the request limit.
3. The auth middleware extracts and validates the JWT token.
4. The request reaches the controller, which delegates
   the business logic to the service layer.
5. The service interacts with the repository to query
   the database.
6. The response flows back through the middleware stack
   and is returned to the client.
```

### Vocabulario de capas

| Término | Descripción |
|---------|-------------|
| **Middleware** | Función que intercepta requests entre el cliente y el controller |
| **Controller** | Capa que recibe requests y devuelve responses |
| **Service** | Capa que contiene la lógica de negocio |
| **Repository** | Capa que interactúa directamente con la base de datos |
| **DTO** (Data Transfer Object) | Objeto para transferir datos entre capas |
| **Entity** | Representación de un registro de la base de datos |
| **Mapper** | Función que transforma entre DTOs y entidades |

---

## Patrón: Autenticación

```
1. The user submits their credentials (email and password)
   to the /auth/login endpoint.
2. The server verifies the credentials against the database.
3. If valid, the server generates a JWT token and returns it
   in the response.
4. The client stores the token in local storage (or a cookie).
5. For subsequent requests, the client includes the token in
   the Authorization header as a Bearer token.
6. The auth middleware extracts the token, decodes it, and
   verifies its signature.
7. If the token is valid and not expired, the request proceeds
   to the controller. Otherwise, the server returns a 401.
```

---

## Patrón: Webhooks y eventos

```
When a payment is completed in Stripe:

1. Stripe sends a POST request to our /webhooks/stripe endpoint.
2. The server verifies the webhook signature to ensure
   authenticity.
3. The handler extracts the event type from the payload.
4. Based on the event type (e.g., payment_intent.succeeded),
   the handler triggers the appropriate action.
5. The order service updates the order status to "paid".
6. The notification service sends a confirmation email
   to the customer.
7. The server returns a 200 OK to acknowledge receipt.
```

---

## Patrón: Cola de mensajes (Message Queue)

```
1. The API receives an image upload request.
2. The controller saves the image metadata to the database
   and publishes a message to the processing queue.
3. The server returns a 202 Accepted response immediately
   (the processing happens asynchronously).
4. A worker picks up the message from the queue.
5. The worker resizes the image, generates thumbnails,
   and uploads them to cloud storage.
6. Once complete, the worker updates the image status
   in the database to "processed".
```

---

## Describiendo arquitecturas

### Monolito

```
"The application is a monolith. All modules — authentication,
orders, payments, and notifications — run as a single process.
The app connects to a PostgreSQL database and serves both
the API and the admin dashboard."
```

### Microservicios

```
"The system is composed of several microservices. The API
Gateway receives all incoming requests and routes them to
the appropriate service. The User Service handles authentication,
the Order Service manages orders, and the Payment Service
processes payments. Services communicate through a message
broker (RabbitMQ) for asynchronous operations and gRPC
for synchronous calls."
```

### Serverless

```
"The backend runs on serverless functions. Each API endpoint
maps to a Lambda function. DynamoDB stores the data, and
S3 handles file storage. CloudFront serves as the CDN
for static assets."
```

---

## Frases útiles para diagramas y presentaciones

| Frase | Uso |
|-------|-----|
| "Data flows from A to B" | Los datos fluyen de A a B |
| "The request goes through..." | La request pasa a través de... |
| "The response is returned to..." | La respuesta se retorna a... |
| "This component is responsible for..." | Este componente es responsable de... |
| "These two services communicate via..." | Estos dos servicios se comunican mediante... |
| "The data is stored in..." | Los datos se almacenan en... |
| "On failure, the system..." | En caso de fallo, el sistema... |
| "The client polls for updates" | El cliente consulta periódicamente por actualizaciones |
| "The server pushes updates via WebSocket" | El servidor envía actualizaciones vía WebSocket |
| "The cache sits between the app and the database" | El caché se ubica entre la app y la base de datos |

---

## Ejemplo completo: Flujo de un e-commerce

```
When a customer places an order:

1. The frontend sends a POST request to /api/orders with
   the cart items and shipping details.
2. The API Gateway authenticates the request using the
   JWT token in the Authorization header.
3. The Order Service validates the items against the
   Product Service to verify prices and availability.
4. The Payment Service charges the customer's credit card
   through the Stripe API.
5. If the payment succeeds, the Order Service creates
   the order record in the database with status "confirmed".
6. The Notification Service sends an order confirmation
   email to the customer.
7. The Inventory Service updates stock quantities.
8. The frontend receives a 201 response with the order
   details and redirects to the confirmation page.

If the payment fails at step 4, the Order Service sets
the status to "payment_failed" and returns a 402 Payment
Required response. The frontend displays an error message
asking the customer to try again.
```

> **Consejo:** Practica describiendo los flujos de datos de tus propios
> proyectos en inglés. Es un ejercicio excelente para entrevistas técnicas.
