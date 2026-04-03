# Ejercicios: APIs y Bases de Datos

---

## Ejercicio 1: Identifica el término correcto

Selecciona el término que corresponde a cada definición:

1. URL específica donde se accede a un recurso de la API: ___
2. Datos enviados en el cuerpo de una request: ___
3. Limitar el número de requests por período de tiempo: ___
4. Identificador único de cada fila en una tabla: ___
5. Script que modifica la estructura de la base de datos: ___
6. Grupo de operaciones que se ejecutan como una unidad: ___
7. Código que indica que el recurso no fue encontrado: ___
8. Librería que mapea tablas a objetos del código: ___
9. URL que recibe notificaciones cuando ocurre un evento: ___
10. Unidad de datos en una base NoSQL como MongoDB: ___

**Opciones:** endpoint, payload, rate limiting, primary key, migration, transaction, 404 Not Found, ORM, webhook, document

### Respuestas

1. **endpoint**
2. **payload**
3. **rate limiting**
4. **primary key**
5. **migration**
6. **transaction**
7. **404 Not Found**
8. **ORM**
9. **webhook**
10. **document**

---

## Ejercicio 2: Status codes

¿Qué status code retornarías en cada situación?

1. El usuario envió datos inválidos en el body.
2. El recurso fue creado exitosamente.
3. El usuario no envió token de autenticación.
4. El usuario tiene token pero no tiene permisos de admin.
5. La request fue exitosa y retorna datos.
6. El servidor tuvo un error inesperado.
7. El endpoint no existe.
8. El usuario excedió el límite de requests.

### Respuestas

1. **400 Bad Request** — datos inválidos
2. **201 Created** — recurso creado
3. **401 Unauthorized** — sin autenticación
4. **403 Forbidden** — sin autorización
5. **200 OK** — éxito con datos
6. **500 Internal Server Error** — error del servidor
7. **404 Not Found** — recurso no encontrado
8. **429 Too Many Requests** — rate limit excedido

---

## Ejercicio 3: Completa las oraciones

Usa el vocabulario de bases de datos para completar:

1. "A ___ stores data in rows and columns."
2. "The `user_id` column is a ___ that references the `users` table."
3. "Use an ___ JOIN to get only matching records from both tables."
4. "If the transaction fails, ___ all the changes."
5. "The ___ property of ACID means all operations complete or none do."
6. "MongoDB is a ___ database that stores data as JSON-like ___."
7. "___ the database with sample data for testing."
8. "Add an ___ to the `email` column to speed up searches."

### Respuestas

1. "A **table** stores data in rows and columns."
2. "The `user_id` column is a **foreign key** that references the `users` table."
3. "Use an **INNER** JOIN to get only matching records from both tables."
4. "If the transaction fails, **rollback** all the changes."
5. "The **Atomicity** property of ACID means all operations complete or none do."
6. "MongoDB is a **document** database that stores data as JSON-like **documents**."
7. "**Seed** the database with sample data for testing."
8. "Add an **index** to the `email` column to speed up searches."

---

## Ejercicio 4: Describe el flujo de datos

Describe en inglés (3-5 oraciones) el flujo de datos para cada escenario:

### A) Un usuario se registra en una app

**Respuesta sugerida:**

```
The user fills out the registration form and clicks "Sign Up".
The frontend sends a POST request to the /api/auth/register
endpoint with the user's name, email, and password in the body.
The server validates the input, hashes the password, and inserts
a new record into the users table. The server returns a 201
Created response with the user data and a JWT token. The frontend
stores the token and redirects the user to the dashboard.
```

### B) Una app muestra una lista de productos

**Respuesta sugerida:**

```
The frontend sends a GET request to /api/products with query
parameters for pagination (page=1&limit=20). The server receives
the request and the controller calls the product service. The
service queries the database using a SELECT statement with LIMIT
and OFFSET. The server returns a 200 OK response with the array
of products and pagination metadata (total count, current page,
total pages). The frontend renders the product cards on screen.
```

### C) Se procesa un pago

**Respuesta sugerida:**

```
The user clicks "Pay Now" and the frontend sends a POST request
to /api/payments with the order ID and payment method. The
payment service creates a transaction and calls the Stripe API
to charge the card. If Stripe returns a success response, the
service commits the transaction, updates the order status to
"paid", and returns a 200 OK. If the charge fails, the service
rolls back the transaction and returns a 402 Payment Required.
```

---

## Ejercicio 5: Traduce al inglés técnico

Traduce estas descripciones al inglés:

1. "El cliente envía una solicitud GET al endpoint /api/users."
2. "El servidor valida el token y retorna una respuesta 200."
3. "El middleware verifica la autenticación antes de reenviar la request al controlador."
4. "La base de datos tiene una relación uno-a-muchos entre usuarios y posts."
5. "Usamos Redis como caché para reducir las consultas a la base de datos."

### Respuestas

1. "The client sends a GET request to the /api/users endpoint."
2. "The server validates the token and returns a 200 response."
3. "The middleware checks authentication before forwarding the request to the controller."
4. "The database has a one-to-many relationship between users and posts."
5. "We use Redis as a cache to reduce database queries."

---

## Ejercicio 6: Relaciona los tipos de JOIN

Conecta cada tipo de JOIN con su resultado:

| JOIN | Resultado |
|------|-----------|
| 1. INNER JOIN | a. Todas las filas de ambas tablas |
| 2. LEFT JOIN | b. Solo filas que coinciden en ambas |
| 3. RIGHT JOIN | c. Todas de la izquierda + coincidencias de la derecha |
| 4. FULL JOIN | d. Todas de la derecha + coincidencias de la izquierda |

### Respuestas

1 → b, 2 → c, 3 → d, 4 → a

---

## Ejercicio 7: Escribe una descripción de arquitectura

Describe en inglés una arquitectura simple con estos componentes:
- Frontend en React
- API en Node.js/Express
- Base de datos PostgreSQL
- Redis para caché
- Cloudinary para imágenes

### Respuesta sugerida

```
The frontend is a React SPA that communicates with the backend
through a REST API. The API is built with Node.js and Express,
and it connects to a PostgreSQL database through Prisma ORM.

Redis sits between the API and the database as a caching layer.
Frequently accessed data (like product listings) is cached in
Redis to reduce database load. Cache entries expire after 5
minutes.

Image uploads are handled by Cloudinary. When a user uploads
an image, the API sends it to Cloudinary's API, which stores
and optimizes the image. The API saves the Cloudinary URL in
the database.

All requests go through middleware for CORS, rate limiting,
and JWT authentication before reaching the controllers.
```
