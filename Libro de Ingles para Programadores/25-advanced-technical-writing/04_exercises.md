# Exercises - Ejercicios del Capitulo 25

## Ejercicio 1: Identifica la seccion

Indica a que seccion de un RFC, tech spec o postmortem pertenece cada fragmento.

**1.** *"We considered using MongoDB but rejected it because we need ACID transactions for payment processing."*

Seccion: _______________________________________________

**2.** *"At 14:30 UTC, monitoring alerts fired. At 14:35, the on-call engineer began investigation."*

Seccion: _______________________________________________

**3.** *"SMS notifications are out of scope for this design and will be addressed in Phase 2."*

Seccion: _______________________________________________

**4.** *"The root cause was a missing database index that caused full table scans under production load."*

Seccion: _______________________________________________

**5.** *"This endpoint accepts a JSON body with user_id (required) and channel (optional)."*

Seccion: _______________________________________________

**6.** *"Should we support social login from day one, or add it in a future iteration?"*

Seccion: _______________________________________________

---

## Ejercicio 2: Escribe un ADR

Escribe un ADR completo en ingles para esta decision:

**Contexto:** Tu equipo decidio usar Flutter en lugar de React Native para una nueva app movil. Las razones principales son: mejor rendimiento, experiencia del equipo con Dart, y un solo codebase para iOS y Android con UI consistente.

```markdown
# ADR-___: _______________________________________________

**Status:** _______________
**Date:** _______________

## Context

_______________________________________________
_______________________________________________
_______________________________________________

## Decision

_______________________________________________
_______________________________________________
_______________________________________________

## Consequences

**Positive:**
_______________________________________________

**Negative:**
_______________________________________________
```

---

## Ejercicio 3: Completa las frases

Selecciona la frase correcta para cada contexto.

**1.** Para introducir un problema en un RFC:

- a) "The issue was mitigated by..."
- b) "The current approach has these limitations..."
- c) "We will use PostgreSQL because..."
- d) "At 14:30, we detected..."

**2.** Para describir que NO esta incluido en un tech spec:

- a) "The root cause was..."
- b) "The proposed solution..."
- c) "Out of scope for this design:"
- d) "We considered but rejected..."

**3.** Para describir como se resolvio un incidente:

- a) "This document describes..."
- b) "The trade-offs are..."
- c) "The issue was mitigated by rolling back the deployment."
- d) "Success criteria include..."

**4.** Para proponer una solucion en un RFC:

- a) "At 15:00, we identified..."
- b) "We propose migrating to OAuth 2.0."
- c) "The outage lasted 2 hours."
- d) "Out of scope for this design:"

**5.** Para documentar una decision en un ADR:

- a) "We will use Redis as our caching layer because..."
- b) "The issue was mitigated by..."
- c) "This endpoint accepts..."
- d) "At 14:30, monitoring alerts fired."

---

## Ejercicio 4: Escribe un timeline de incidente

Un servicio de autenticacion se cayo. Escribe un timeline profesional en ingles usando estos hechos (en desorden):

- El ingeniero de guardia respondio a las 10:07
- Se detecto la caida a las 10:05 por las alertas de monitoreo
- A las 10:45 se confirmo la recuperacion total
- A las 10:20 se identifico que el certificado SSL habia expirado
- A las 10:30 se renovo el certificado y se reinicio el servicio
- A las 10:35 el servicio empezo a responder normalmente

```
## Timeline (all times UTC)

| Time | Event |
|------|-------|
| _____ | _____________________________________________ |
| _____ | _____________________________________________ |
| _____ | _____________________________________________ |
| _____ | _____________________________________________ |
| _____ | _____________________________________________ |
| _____ | _____________________________________________ |
```

---

## Ejercicio 5: Convierte culpa en aprendizaje

Reescribe cada frase para que sea "blameless" (sin culpar a individuos).

**1.** *"Carlos forgot to add the database index."*

Tu version: _______________________________________________

**2.** *"The QA team didn't test this properly."*

Tu version: _______________________________________________

**3.** *"Maria deployed without checking the tests."*

Tu version: _______________________________________________

**4.** *"Nobody noticed the certificate was expiring."*

Tu version: _______________________________________________

---

## Ejercicio 6: Escribe action items

Para cada problema, escribe un action item concreto con dueno, prioridad y fecha.

**1.** El staging no tenia datos representativos de produccion.

| Action | Owner | Priority | Due date |
|--------|-------|----------|----------|
| _______ | _______ | _______ | _______ |

**2.** No habia alertas para queries lentas.

| Action | Owner | Priority | Due date |
|--------|-------|----------|----------|
| _______ | _______ | _______ | _______ |

**3.** No existia un runbook para este tipo de incidente.

| Action | Owner | Priority | Due date |
|--------|-------|----------|----------|
| _______ | _______ | _______ | _______ |

---

## Ejercicio 7: Traduce al ingles profesional

Traduce estas frases al ingles tecnico profesional.

**1.** "El sistema actual tiene estas limitaciones."
_______________________________________________

**2.** "Proponemos migrar a una arquitectura de microservicios."
_______________________________________________

**3.** "La causa raiz fue un certificado SSL expirado."
_______________________________________________

**4.** "El problema fue mitigado reiniciando el servicio."
_______________________________________________

**5.** "Este documento describe el diseno del sistema de notificaciones."
_______________________________________________

**6.** "Para prevenir recurrencia, agregaremos alertas automaticas."
_______________________________________________

---

## Ejercicio 8: Escribe un summary de postmortem

Escribe el summary (3-5 oraciones) de un postmortem para este incidente:

**Hechos:** El 1 de abril a las 3 PM, la API de busqueda dejo de responder. Duro 45 minutos. Afecto a 5,000 usuarios. La causa fue que Elasticsearch se quedo sin espacio en disco. Se resolvio limpiando logs viejos y expandiendo el almacenamiento.

```markdown
## Summary

_______________________________________________
_______________________________________________
_______________________________________________
_______________________________________________
_______________________________________________
```

---

## Respuestas

### Ejercicio 1
1. Alternatives considered (RFC)
2. Timeline (Postmortem)
3. Non-goals (Tech spec)
4. Root cause (Postmortem)
5. API surface (Tech spec)
6. Open questions (RFC)

### Ejercicio 3
1. b) "The current approach has these limitations..."
2. c) "Out of scope for this design:"
3. c) "The issue was mitigated by rolling back the deployment."
4. b) "We propose migrating to OAuth 2.0."
5. a) "We will use Redis as our caching layer because..."

### Ejercicio 4

| Time | Event |
|------|-------|
| 10:05 | Monitoring alerts detected authentication service outage |
| 10:07 | On-call engineer acknowledged the alert and began investigation |
| 10:20 | Identified root cause: SSL certificate had expired |
| 10:30 | Renewed SSL certificate and restarted the service |
| 10:35 | Service began responding normally |
| 10:45 | Full recovery confirmed; incident closed |

### Ejercicio 5 (respuestas sugeridas)
1. "The deployment lacked the required database index."
2. "The test suite did not cover this scenario."
3. "The deployment pipeline did not include a test verification gate."
4. "There was no automated alert for certificate expiration."

### Ejercicio 7
1. "The current system has these limitations."
2. "We propose migrating to a microservices architecture."
3. "The root cause was an expired SSL certificate."
4. "The issue was mitigated by restarting the service."
5. "This document describes the design for the notification system."
6. "To prevent recurrence, we will add automated alerts."
