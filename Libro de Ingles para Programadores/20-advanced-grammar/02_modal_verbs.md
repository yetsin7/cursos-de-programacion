# Verbos Modales en Contexto de Programación

## Introducción

Los verbos modales en inglés expresan **posibilidad, capacidad, obligación,
consejo y cortesía**. Son fundamentales en el mundo de la programación para
comunicarte en code reviews, reuniones, documentación y discusiones técnicas.

---

## can / could: Capacidad y posibilidad

### can — Capacidad actual, posibilidad general

| Ejemplo | Uso |
|---------|-----|
| The API **can** handle 1000 requests per second. | Capacidad técnica |
| You **can** configure the port in the .env file. | Posibilidad / permiso |
| TypeScript **can** catch type errors at compile time. | Capacidad |
| This library **can** parse XML and JSON. | Capacidad |

### could — Posibilidad condicional, sugerencia educada

| Ejemplo | Uso |
|---------|-----|
| This **could** cause a memory leak. | Posibilidad (riesgo) |
| We **could** use Redis for caching. | Sugerencia |
| **Could** you review my PR? | Petición educada |
| This **could** be refactored into a utility. | Posibilidad |
| The bug **could** be in the middleware. | Posibilidad incierta |

### Diferencia clave

```
can  → habilidad/posibilidad real y directa
could → posibilidad menos segura, o forma más educada

"The function can return null."     (es un hecho)
"The function could return null."   (es posible, no seguro)
```

---

## may / might: Posibilidad con incertidumbre

### may — Posibilidad moderada, permiso formal

| Ejemplo | Uso |
|---------|-----|
| This change **may** affect performance. | Posibilidad |
| The migration **may** take several minutes. | Posibilidad |
| You **may** need to restart the server. | Posibilidad |
| Users **may** experience delays during deployment. | Advertencia |

### might — Posibilidad baja

| Ejemplo | Uso |
|---------|-----|
| We **might** need to scale the database. | Posibilidad baja |
| This **might** break backward compatibility. | Posibilidad baja |
| I **might** have introduced a bug in that commit. | Incertidumbre |
| They **might** deprecate this API next year. | Especulación |

### Escala de certeza

```
will        → 95-100% seguro   "This will fix the bug."
should      → 80-90% probable  "This should fix the bug."
may         → 50-70% posible   "This may fix the bug."
might/could → 30-50% posible   "This might fix the bug."
```

---

## should / ought to: Consejo y recomendación

### should — Recomendación, buena práctica

| Ejemplo | Uso |
|---------|-----|
| You **should** use TypeScript for large projects. | Recomendación |
| We **should** add input validation. | Buena práctica |
| Tests **should** cover edge cases. | Expectativa |
| You **should** handle this error explicitly. | Consejo fuerte |
| The response **should** include a status code. | Expectativa |
| You **shouldn't** store passwords in plain text. | Advertencia |

### should en testing

En tests, **should** se usa para describir el comportamiento esperado:

```javascript
describe('UserService', () => {
  it('should return a user by ID', () => { /* ... */ });
  it('should throw an error if user not found', () => { /* ... */ });
  it('should hash the password before saving', () => { /* ... */ });
  it('should not allow duplicate emails', () => { /* ... */ });
});
```

---

## would: Hipotéticos y cortesía

### Situaciones hipotéticas

| Ejemplo | Uso |
|---------|-----|
| I **would** use PostgreSQL for this. | Preferencia hipotética |
| That **would** require a database migration. | Consecuencia hipotética |
| This **would** simplify the architecture. | Resultado hipotético |
| I **wouldn't** recommend this approach. | Opinión negativa cortés |

### Cortesía y peticiones

| Ejemplo | Uso |
|---------|-----|
| **Would** you mind reviewing my PR? | Petición muy educada |
| **Would** it be possible to extend the deadline? | Petición formal |
| I **would** appreciate your feedback. | Agradecimiento anticipado |
| **Would** you like me to refactor this? | Ofrecimiento |

### would vs will

```
"I will refactor this."     → Estoy seguro de que lo haré
"I would refactor this."    → Lo haría (si las condiciones fueran diferentes)
```

---

## must / have to: Obligación y necesidad

### must — Obligación fuerte, certeza

| Ejemplo | Uso |
|---------|-----|
| You **must** handle this error. | Obligación (crítico) |
| The API **must** validate all input. | Requisito |
| Passwords **must** be at least 8 characters. | Regla |
| You **must** not expose API keys in the frontend. | Prohibición |
| This **must** be the source of the bug. | Certeza lógica |

### have to — Obligación externa

| Ejemplo | Uso |
|---------|-----|
| We **have to** deploy before Friday. | Obligación por deadline |
| You **have to** install Docker first. | Requisito previo |
| I **have to** fix this before the release. | Necesidad |
| We **don't have to** support IE11 anymore. | No es necesario |

### must vs have to vs should

```
must     → obligatorio, no negociable    "You must use HTTPS."
have to  → necesario por circunstancias  "We have to finish today."
should   → recomendado, pero opcional    "You should add tests."
```

---

## shall: Propuestas y documentos formales

En el uso moderno, **shall** es poco común en conversación, pero aparece en:

### Propuestas (muy formal/educado)

```
Shall we start the meeting?
Shall I create a new branch for this?
Shall we discuss this in the next sprint planning?
```

### Documentación formal y specs (RFC-style)

```
The server SHALL respond with a 200 status code.
The client SHALL NOT send more than 100 requests per minute.
The implementation SHALL support UTF-8 encoding.
```

> En RFCs y especificaciones técnicas, **SHALL** indica requisito obligatorio,
> similar a **MUST** (ver RFC 2119).

---

## Tabla resumen

| Modal | Certeza | Uso principal | Ejemplo tech |
|-------|---------|--------------|-------------|
| **will** | 95%+ | Futuro seguro | "This will work." |
| **must** | 95%+ | Obligación | "You must handle errors." |
| **should** | 80% | Recomendación | "You should add tests." |
| **can** | — | Capacidad | "It can parse JSON." |
| **may** | 50-70% | Posibilidad | "This may cause issues." |
| **could** | 30-50% | Posibilidad/sugerencia | "We could try Redis." |
| **might** | 30-50% | Posibilidad baja | "This might break." |
| **would** | — | Hipotético/cortesía | "Would you review this?" |

---

## Modales en documentación

```markdown
# Niveles de obligación en docs

MUST / SHALL    → Requisito obligatorio
SHOULD          → Recomendación fuerte
MAY             → Opcional
MUST NOT        → Prohibido
SHOULD NOT      → No recomendado
```

### Ejemplo real

```markdown
## Authentication

All API requests **must** include a valid Bearer token
in the Authorization header.

Tokens **should** be refreshed before they expire.

Clients **may** include an `X-Request-ID` header for
request tracing.

API keys **must not** be included in client-side code.
```

> **Consejo:** En code reviews, usa **should** y **could** para sugerencias.
> Reserva **must** para problemas de seguridad o bugs críticos.
> La cortesía construye mejores relaciones de equipo.
