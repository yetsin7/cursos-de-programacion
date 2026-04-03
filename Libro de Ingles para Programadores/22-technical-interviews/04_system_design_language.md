# System Design Language - Lenguaje de diseno de sistemas

## Introduccion

Las entrevistas de system design evaluan tu capacidad de disenar sistemas a gran escala. A diferencia de las entrevistas de codigo, aqui no hay una unica respuesta correcta — lo que importa es tu proceso de pensamiento, las preguntas que haces y como comunicas las decisiones de diseno. Esta leccion te da el vocabulario y las frases esenciales.

---

## Paso 1: Clarificar requisitos

Siempre empieza preguntando. Nunca asumas los requisitos.

| Frase | Proposito |
|-------|-----------|
| *"Let's start with the requirements."* | Abrir la discusion |
| *"What are the functional requirements?"* | Que debe hacer el sistema |
| *"What are the non-functional requirements?"* | Rendimiento, disponibilidad, etc. |
| *"How many users are we expecting?"* | Escala del sistema |
| *"We need to handle X requests per second."* | Establecer throughput |
| *"What's the expected read-to-write ratio?"* | Patron de trafico |
| *"Is strong consistency required, or is eventual consistency acceptable?"* | Modelo de consistencia |

```
// Ejemplo de dialogo:
Tu: "Let's start with the requirements. Are we designing 
this for a specific scale, or should I assume a general case?"

Entrevistador: "Design it for 10 million daily active users."

Tu: "OK. Assuming 10 million DAU, with an average of 20 
requests per user per day, we need to handle about 200 million 
requests per day, which is roughly 2,300 requests per second 
on average, with peaks of maybe 5x that."
```

---

## Paso 2: Diseno de alto nivel

| Frase | Contexto |
|-------|----------|
| *"Let me start with a high-level architecture."* | Presentar el diseno general |
| *"I'd use a load balancer in front of..."* | Distribucion de trafico |
| *"The application servers would handle..."* | Logica de negocio |
| *"For the database, I'd choose... because..."* | Seleccion de base de datos |
| *"I'd add a caching layer using..."* | Mejora de rendimiento |
| *"We can cache this at the CDN level."* | Cache de contenido estatico |
| *"I'd use a message queue for..."* | Procesamiento asincrono |

### Ejemplo de diseno de alto nivel

```
Tu: "At a high level, I'd design this with the following 
components:

First, a load balancer — probably an AWS ALB — to distribute 
traffic across multiple application servers.

The application servers would be stateless, running behind 
an auto-scaling group. This lets us scale horizontally based 
on demand.

For the database, I'd choose PostgreSQL for the main data 
because we need ACID transactions for user accounts and 
payments. For the activity feed, I'd use a NoSQL solution 
like DynamoDB because the access pattern is simple key-value 
lookups at high volume.

I'd add Redis as a caching layer for frequently accessed 
data like user profiles and session data.

For static assets — images and videos — I'd use S3 with 
CloudFront as a CDN to serve content close to users."
```

---

## Paso 3: Profundizar en componentes

| Frase | Contexto |
|-------|----------|
| *"This scales horizontally by..."* | Explicar escalabilidad |
| *"The bottleneck would be..."* | Identificar puntos debiles |
| *"To handle this, we could..."* | Proponer soluciones |
| *"The trade-off is..."* | Comparar opciones |
| *"If we need to optimize further..."* | Mejoras adicionales |
| *"We'd partition/shard the data by..."* | Estrategia de sharding |

```
// Discutiendo escalabilidad:
"This scales horizontally by adding more application servers 
behind the load balancer. Since the servers are stateless, 
we can spin up new instances in seconds.

The bottleneck would be the database. To handle this, we 
could implement read replicas for read-heavy operations 
and shard the database by user ID for write scalability.

The trade-off with sharding is increased complexity — 
cross-shard queries become expensive. But given our access 
patterns are primarily single-user lookups, this is 
an acceptable trade-off."
```

---

## Vocabulario de system design

### Infraestructura

| Termino | Significado | Ejemplo |
|---------|-------------|---------|
| **Load balancer** | Balanceador de carga | *"A load balancer distributes requests."* |
| **Auto-scaling** | Escalamiento automatico | *"Auto-scaling adds servers during peaks."* |
| **CDN** | Red de distribucion de contenido | *"Serve static assets from a CDN."* |
| **Reverse proxy** | Proxy inverso | *"Nginx as a reverse proxy."* |
| **Service mesh** | Malla de servicios | *"A service mesh handles inter-service communication."* |

### Base de datos

| Termino | Significado | Ejemplo |
|---------|-------------|---------|
| **Sharding** | Particionamiento horizontal | *"Shard by user ID."* |
| **Replication** | Replicacion | *"Use read replicas for scalability."* |
| **ACID** | Atomicidad, Consistencia, Aislamiento, Durabilidad | *"We need ACID compliance for payments."* |
| **Eventual consistency** | Consistencia eventual | *"Eventual consistency is fine for likes."* |
| **Schema migration** | Migracion de esquema | *"Plan the schema migration carefully."* |

### Rendimiento

| Termino | Significado | Ejemplo |
|---------|-------------|---------|
| **Throughput** | Rendimiento/capacidad | *"Handle 10K requests per second."* |
| **Latency** | Latencia | *"Keep latency under 100ms."* |
| **Availability** | Disponibilidad | *"Target 99.9% availability."* |
| **Single point of failure** | Punto unico de fallo | *"Avoid any single point of failure."* |
| **Rate limiting** | Limitacion de velocidad | *"Implement rate limiting per user."* |

---

## Frases para discusion de trade-offs

```
"If we prioritize consistency, we sacrifice availability 
during network partitions — that's the CAP theorem."

"Using a microservices architecture gives us independent 
scalability, but adds operational complexity."

"A SQL database gives us strong consistency and complex 
queries, but scaling writes is harder compared to NoSQL."

"Caching improves read latency significantly, but we need 
a cache invalidation strategy to avoid stale data."

"Synchronous processing is simpler but creates coupling. 
An event-driven approach with a message queue gives us 
better decoupling and fault tolerance."
```

---

## Conversacion simulada: Disena un URL shortener

```
Entrevistador: "Design a URL shortening service like bit.ly."

Tu: "Let's start with the requirements. 

Functional: users can create short URLs, and when someone 
visits the short URL, they get redirected to the original. 
Do we need analytics — like click counts?

Non-functional: the redirect needs to be fast — under 50ms. 
We need high availability since broken links are unacceptable."

Entrevistador: "Yes, include basic analytics. Assume 100 
million URLs created per month."

Tu: "That's about 40 URLs per second for writes, and 
assuming a 100:1 read-to-write ratio, about 4,000 redirects 
per second.

For the high-level design, I'd use a load balancer in front 
of stateless application servers. For the database, I'd 
choose a NoSQL store like DynamoDB because our access pattern 
is simple key-value: short code to long URL.

I'd add a Redis cache in front of the database for hot URLs 
— the top 20% of URLs probably account for 80% of traffic.

For generating short codes, I'd use a base62 encoding of 
an auto-incrementing ID. With 6 characters, we get 62^6 — 
about 56 billion possible URLs, which is more than enough.

The bottleneck would be the ID generation service. To handle 
this, I'd use a distributed ID generator with pre-allocated 
ranges, so each server gets a block of IDs to avoid contention.

We can cache the most popular redirects at the CDN level 
for even lower latency."
```

---

## Consejo final

> En system design, no hay respuesta perfecta. Lo que importa es: (1) hacer buenas preguntas, (2) estimar numeros razonables, (3) proponer una arquitectura clara, (4) identificar trade-offs, y (5) comunicar todo esto con fluidez en ingles. Practica disenando sistemas populares: Twitter feed, chat system, file storage, notification service.
