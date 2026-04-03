# Writing RFCs and ADRs - Escribir RFCs y ADRs

## Introduccion

Los **RFCs** (Request for Comments) y **ADRs** (Architecture Decision Records) son documentos fundamentales en equipos de ingenieria maduros. Un RFC propone un cambio tecnico significativo para recibir feedback del equipo. Un ADR registra una decision arquitectonica importante y su razonamiento. Dominar la escritura de estos documentos en ingles demuestra liderazgo tecnico.

---

## RFC (Request for Comments)

### Que es un RFC?

Un RFC es un documento que propone un cambio tecnico significativo. Se comparte con el equipo para recibir comentarios antes de implementar. Es un proceso democratico de toma de decisiones tecnicas.

### Estructura de un RFC

| Seccion | Contenido |
|---------|-----------|
| **Title** | Nombre descriptivo de la propuesta |
| **Status** | Draft / In Review / Accepted / Rejected / Superseded |
| **Author(s)** | Quien lo escribe |
| **Date** | Fecha de creacion |
| **Summary** | Resumen en 2-3 oraciones |
| **Problem statement** | Que problema resuelve |
| **Proposal** | La solucion propuesta en detalle |
| **Alternatives considered** | Otras opciones evaluadas |
| **Drawbacks** | Desventajas de la propuesta |
| **Open questions** | Dudas pendientes |

### Ejemplo de RFC

```markdown
# RFC: Migrate Authentication to OAuth 2.0

**Status:** In Review
**Author:** Juan Garcia
**Date:** 2026-03-15

## Summary

We propose migrating our custom authentication system to 
OAuth 2.0 with OpenID Connect to improve security, enable 
SSO, and reduce maintenance burden.

## Problem Statement

The current authentication system has several limitations:
- No support for Single Sign-On (SSO)
- Session management is custom-built and error-prone
- We handle password storage directly, increasing our 
  security liability
- Integration with third-party services requires custom 
  auth adapters for each one

These issues result in approximately 200 support tickets 
per month and have been identified as a security risk in 
our last audit.

## Proposal

We propose adopting OAuth 2.0 with the following approach:

1. **Identity Provider:** Use Auth0 as our identity provider
2. **Token format:** JWT with RS256 signing
3. **Session management:** Replace server-side sessions 
   with short-lived access tokens and refresh tokens
4. **Migration:** Gradual rollout over 3 sprints with 
   backward compatibility during transition

The migration path would be:
- Sprint 1: Set up Auth0, implement new auth flow in staging
- Sprint 2: Dual-auth mode — both old and new systems active
- Sprint 3: Complete migration, decommission old system

## Alternatives Considered

**Alternative 1: Build custom OAuth implementation**
- Pros: Full control, no vendor lock-in
- Cons: Significant development effort (estimated 3 months),
  ongoing maintenance, security responsibility remains on us

**Alternative 2: Use Firebase Authentication**
- Pros: Easy setup, good mobile SDK support
- Cons: Vendor lock-in with Google, limited customization,
  pricing concerns at scale

**Alternative 3: Keep current system, add patches**
- Pros: No migration effort
- Cons: Doesn't solve fundamental issues, security risk 
  remains, increasing maintenance cost

## Drawbacks

- Dependency on a third-party service (Auth0)
- Monthly cost of approximately $500 at current user volume
- Migration requires downtime planning for user sessions
- Team needs to learn OAuth 2.0 flows

## Open Questions

1. Should we support social login (Google, GitHub) from 
   day one, or add it later?
2. What's our fallback plan if Auth0 has an outage?
3. Do we need to migrate historical session data?
```

---

## Frases clave para RFCs

### Describir el problema

| Frase | Uso |
|-------|-----|
| *"The current approach has these limitations..."* | Listar problemas |
| *"This has resulted in..."* | Describir consecuencias |
| *"We've observed that..."* | Presentar evidencia |
| *"This is causing [X] issues per [period]."* | Cuantificar el impacto |

### Proponer la solucion

| Frase | Uso |
|-------|-----|
| *"We propose..."* | Introducir la propuesta |
| *"The proposed solution would..."* | Describir la solucion |
| *"This approach has the advantage of..."* | Destacar beneficios |
| *"The migration path would involve..."* | Describir el plan |

### Discutir alternativas y trade-offs

| Frase | Uso |
|-------|-----|
| *"We considered [X] but rejected it because..."* | Descartar alternativa |
| *"The trade-offs are..."* | Presentar compromisos |
| *"The main drawback is..."* | Reconocer desventajas |
| *"This risk can be mitigated by..."* | Proponer mitigacion |

---

## ADR (Architecture Decision Record)

### Que es un ADR?

Un ADR es un registro corto de una decision arquitectonica importante. A diferencia de un RFC (que busca consenso), un ADR **documenta una decision ya tomada** y el razonamiento detras de ella. Sirve como referencia historica.

### Estructura de un ADR

| Seccion | Contenido |
|---------|-----------|
| **Title** | ADR-[numero]: Descripcion breve |
| **Status** | Accepted / Deprecated / Superseded by ADR-[X] |
| **Context** | Situacion y fuerzas que motivan la decision |
| **Decision** | La decision tomada |
| **Consequences** | Resultados esperados, positivos y negativos |

### Ejemplo de ADR

```markdown
# ADR-012: Use PostgreSQL as Primary Database

**Status:** Accepted
**Date:** 2026-02-20

## Context

We are building a new e-commerce platform that requires:
- ACID transactions for order processing and payments
- Complex queries for reporting and analytics
- Full-text search for product catalog
- Support for JSON data for flexible product attributes

Our team has experience with both PostgreSQL and MongoDB. 
The expected data volume is moderate (under 10M rows in 
the largest table for the first two years).

## Decision

We will use PostgreSQL as our primary database for the 
following reasons:

1. ACID compliance is critical for financial transactions
2. PostgreSQL's JSONB support handles our need for flexible 
   schemas without sacrificing relational integrity
3. Built-in full-text search eliminates the need for a 
   separate search service in the short term
4. Our team has stronger experience with SQL databases
5. Strong ecosystem of tools (pgAdmin, migrations, ORMs)

## Consequences

**Positive:**
- Reliable transaction handling for payments
- Single database simplifies operations and reduces costs
- Team can be productive immediately

**Negative:**
- Horizontal scaling is more complex than with NoSQL
- If full-text search requirements grow significantly, 
  we may need to add Elasticsearch later
- Schema migrations require more planning than schema-less 
  databases

**Neutral:**
- We accept the operational overhead of managing a 
  relational database
- We will revisit this decision if we exceed 100M rows 
  or need multi-region replication
```

---

## Frases clave para ADRs

### Contexto

| Frase | Uso |
|-------|-----|
| *"We need to decide..."* | Introducir la decision |
| *"The system requires..."* | Describir requisitos |
| *"Given the constraints of..."* | Enmarcar limitaciones |
| *"Our team has experience with..."* | Factor humano |

### Decision

| Frase | Uso |
|-------|-----|
| *"We will use [X] because..."* | Declarar la decision |
| *"We decided against [Y] because..."* | Justificar rechazos |
| *"This decision was driven by..."* | Explicar la motivacion |

### Consecuencias

| Frase | Uso |
|-------|-----|
| *"As a result, we expect..."* | Resultados esperados |
| *"The trade-off we accept is..."* | Compromisos aceptados |
| *"We will revisit this decision if..."* | Condiciones de reevaluacion |

---

## RFC vs ADR: Cuando usar cada uno?

| Aspecto | RFC | ADR |
|---------|-----|-----|
| **Cuando** | Antes de decidir | Despues de decidir |
| **Proposito** | Buscar feedback y consenso | Documentar decision y razonamiento |
| **Longitud** | Largo y detallado | Corto y conciso |
| **Audiencia** | Todo el equipo / organizacion | Referencia futura |
| **Resultado** | Aprobacion o rechazo | Registro historico |

---

## Consejo final

> Escribir RFCs y ADRs no es solo documentacion — es pensamiento estructurado. El acto de escribir un RFC te obliga a considerar alternativas, trade-offs y riesgos que no habrias pensado de otra forma. Es una habilidad que distingue a los desarrolladores senior.
