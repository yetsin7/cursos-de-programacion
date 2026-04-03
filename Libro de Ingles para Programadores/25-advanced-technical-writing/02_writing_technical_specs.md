# Writing Technical Specs - Escribir especificaciones tecnicas

## Introduccion

Una especificacion tecnica (tech spec) es un documento que describe **como** se va a construir algo. A diferencia de un RFC (que propone un cambio), un tech spec detalla el diseno, la API, el modelo de datos y el plan de implementacion. Es el plano del proyecto antes de escribir codigo.

---

## Estructura de un tech spec

| Seccion | Proposito |
|---------|-----------|
| **Title and metadata** | Nombre, autor, fecha, estado, revisores |
| **Overview** | Resumen ejecutivo en 3-5 oraciones |
| **Goals** | Que se quiere lograr |
| **Non-goals** | Que NO esta en el alcance |
| **Design** | Diseno tecnico detallado |
| **API surface** | Endpoints, metodos, request/response |
| **Data model** | Esquema de base de datos, entidades |
| **Testing strategy** | Como se va a probar |
| **Rollout plan** | Como se va a desplegar |

---

## Seccion por seccion con frases clave

### Overview

La primera seccion que todos leen. Debe ser concisa y completa.

| Frase | Uso |
|-------|-----|
| *"This document describes..."* | Abrir el documento |
| *"The purpose of this spec is to..."* | Establecer el proposito |
| *"This feature will allow users to..."* | Describir el valor |

```markdown
## Overview

This document describes the design for a real-time 
notification system that will allow users to receive 
instant updates about order status changes, messages, 
and system alerts. The system will support push 
notifications (mobile), email, and in-app notifications.

This spec covers the backend architecture, API design, 
and data model. Frontend implementation details will be 
covered in a separate spec.
```

### Goals

| Frase | Uso |
|-------|-----|
| *"The primary goal is to..."* | Objetivo principal |
| *"This project aims to..."* | Describir la meta |
| *"Success criteria include..."* | Metricas de exito |

```markdown
## Goals

- Deliver notifications to users within 5 seconds of 
  the triggering event
- Support three channels: push, email, and in-app
- Allow users to configure notification preferences 
  per channel and per event type
- Handle at least 10,000 notifications per minute
- Achieve 99.9% delivery reliability
```

### Non-goals

Esta seccion es tan importante como los goals. Define los limites del proyecto.

| Frase | Uso |
|-------|-----|
| *"Out of scope for this design:"* | Introducir non-goals |
| *"The following are explicitly not included:"* | Listar exclusiones |
| *"This will be addressed in a future iteration."* | Posponer a futuro |

```markdown
## Non-goals

Out of scope for this design:

- SMS notifications (will be addressed in Phase 2)
- Notification analytics and reporting dashboard
- A/B testing of notification content
- Internationalization of notification templates 
  (will use English only for the initial release)
- Real-time notification preferences sync across devices
```

### Design

El corazon del documento. Describe la arquitectura y el flujo.

| Frase | Uso |
|-------|-----|
| *"The proposed solution..."* | Introducir el diseno |
| *"The system consists of the following components:"* | Listar componentes |
| *"The data flows as follows:"* | Describir el flujo |
| *"This component is responsible for..."* | Describir responsabilidades |

```markdown
## Design

### Architecture Overview

The notification system consists of four main components:

1. **Notification Service** — Receives notification 
   requests, applies user preferences, and routes to 
   the appropriate channel
2. **Message Queue (RabbitMQ)** — Decouples notification 
   creation from delivery for reliability
3. **Channel Workers** — Dedicated workers for each 
   delivery channel (push, email, in-app)
4. **Preference Store** — Manages user notification 
   preferences (stored in PostgreSQL)

### Flow

1. A service triggers a notification by publishing an 
   event to the message queue
2. The Notification Service consumes the event, looks up 
   user preferences, and determines which channels to use
3. For each channel, a message is enqueued to the 
   channel-specific queue
4. Channel Workers process messages and handle delivery
5. Delivery status is recorded for retry and auditing
```

### API Surface

| Frase | Uso |
|-------|-----|
| *"The API exposes the following endpoints:"* | Introducir la API |
| *"This endpoint accepts..."* | Describir input |
| *"Returns [status code] on success."* | Describir output |
| *"Required fields:"* / *"Optional fields:"* | Especificar campos |

```markdown
## API Surface

### POST /api/v1/notifications

Sends a notification to a user.

**Request body:**
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| user_id | string | Yes | Target user ID |
| type | string | Yes | Event type (e.g., "order_shipped") |
| title | string | Yes | Notification title |
| body | string | Yes | Notification body |
| data | object | No | Additional payload |
| channels | string[] | No | Override channels (default: user prefs) |

**Response:** 201 Created
| Field | Type | Description |
|-------|------|-------------|
| notification_id | string | Unique ID for tracking |
| status | string | "queued" |

### GET /api/v1/notifications?user_id={id}

Returns notification history for a user.

### PATCH /api/v1/users/{id}/preferences

Updates notification preferences for a user.
```

### Data Model

| Frase | Uso |
|-------|-----|
| *"The data model includes the following entities:"* | Introducir entidades |
| *"This table stores..."* | Describir proposito |
| *"Foreign key relationship to..."* | Describir relaciones |

```markdown
## Data Model

### notifications table
| Column | Type | Description |
|--------|------|-------------|
| id | UUID | Primary key |
| user_id | UUID | FK to users table |
| type | VARCHAR(50) | Event type |
| title | VARCHAR(255) | Display title |
| body | TEXT | Notification content |
| status | ENUM | queued, sent, delivered, failed |
| channel | VARCHAR(20) | push, email, in_app |
| created_at | TIMESTAMP | Creation time |
| delivered_at | TIMESTAMP | Delivery time (nullable) |

### notification_preferences table
| Column | Type | Description |
|--------|------|-------------|
| user_id | UUID | FK to users table |
| event_type | VARCHAR(50) | Event type |
| channel | VARCHAR(20) | Delivery channel |
| enabled | BOOLEAN | Whether this channel is active |
```

### Testing Strategy

| Frase | Uso |
|-------|-----|
| *"We will test this with..."* | Introducir estrategia |
| *"Unit tests will cover..."* | Pruebas unitarias |
| *"Integration tests will verify..."* | Pruebas de integracion |
| *"Load testing will ensure..."* | Pruebas de carga |

```markdown
## Testing Strategy

- **Unit tests:** Cover preference logic, channel routing, 
  and message formatting (target: 90% coverage)
- **Integration tests:** Verify end-to-end flow from API 
  request to channel worker delivery
- **Load tests:** Simulate 10K notifications/min to verify 
  performance targets using k6
- **Chaos testing:** Simulate queue failures and verify 
  retry mechanism works correctly
```

### Rollout Plan

| Frase | Uso |
|-------|-----|
| *"The rollout will proceed in phases:"* | Introducir fases |
| *"We will monitor [metrics] during rollout."* | Metricas de monitoreo |
| *"Rollback plan:"* | Plan de reversion |

```markdown
## Rollout Plan

1. **Phase 1 (Week 1-2):** Deploy to staging, internal 
   testing with the team
2. **Phase 2 (Week 3):** Enable for 5% of users (canary)
3. **Phase 3 (Week 4):** Expand to 50% if no issues
4. **Phase 4 (Week 5):** Full rollout to 100%

**Monitoring:** Track delivery latency (p50, p95, p99), 
failure rate, and queue depth.

**Rollback plan:** Feature flag to disable new notification 
system and fall back to the existing email-only system.

**Migration path:** Existing notification preferences will 
be migrated via a one-time script before Phase 2.
```

---

## Consejo final

> Un buen tech spec ahorra semanas de confusion y retrabajo. Dedica tiempo a escribirlo bien, pide feedback de tu equipo antes de empezar a codear, y actualizalo si el diseno cambia durante la implementacion. Es un documento vivo, no un artefacto estatico.
