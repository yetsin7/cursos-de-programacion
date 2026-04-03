# Writing Incident Reports - Escribir informes de incidentes

## Introduccion

Cuando algo falla en produccion, despues de resolver el problema, el equipo escribe un **postmortem** (informe post-incidente). Este documento analiza que paso, por que, y como evitar que vuelva a ocurrir. Escribir postmortems claros y sin culpar a individuos es una habilidad esencial en ingenieria de software.

---

## Principios de un buen postmortem

| Principio | Descripcion |
|-----------|-------------|
| **Blameless** | No culpar a personas — enfocarse en sistemas y procesos |
| **Honest** | Describir lo que realmente paso, sin minimizar |
| **Actionable** | Incluir acciones concretas para prevenir recurrencia |
| **Timely** | Escribirlo dentro de 48-72 horas del incidente |

---

## Estructura de un postmortem

| Seccion | Contenido |
|---------|-----------|
| **Title** | Descripcion breve del incidente |
| **Summary** | Que paso en 3-5 oraciones |
| **Impact** | Quien fue afectado, por cuanto tiempo, con que severidad |
| **Timeline** | Secuencia cronologica de eventos |
| **Root cause** | La causa fundamental del problema |
| **Resolution** | Como se resolvio |
| **Lessons learned** | Que aprendimos (que funciono, que no) |
| **Action items** | Tareas concretas para prevenir recurrencia |

---

## Ejemplo completo de postmortem

```markdown
# Incident Report: Payment Processing Outage

**Date:** 2026-03-20
**Duration:** 2 hours 15 minutes (14:30 - 16:45 UTC)
**Severity:** P1 (Critical)
**Author:** Juan Garcia
**Status:** Complete

## Summary

On March 20, 2026, the payment processing service 
experienced a complete outage lasting 2 hours and 15 
minutes. Users were unable to complete purchases during 
this period. The root cause was a database connection 
pool exhaustion triggered by a misconfigured query in 
a new feature deployment.

## Impact

- **Users affected:** Approximately 12,000 users 
  attempted purchases during the outage
- **Revenue impact:** Estimated $45,000 in lost 
  transactions (based on average conversion rate)
- **Failed transactions:** 8,347 payment attempts 
  returned 500 errors
- **Support tickets:** 234 tickets filed
- **SLA impact:** Monthly uptime dropped to 99.7% 
  (target: 99.9%)

## Timeline

All times in UTC.

| Time | Event |
|------|-------|
| 14:15 | Deployment of v3.2.1 with new discount feature |
| 14:30 | Monitoring alerts fire: payment error rate > 5% |
| 14:32 | On-call engineer acknowledges the alert |
| 14:35 | Initial investigation begins; API returns 500 errors |
| 14:45 | Database team notified; connection pool at 100% |
| 14:50 | Attempted to increase connection pool size — no effect |
| 15:00 | Identified slow query in the discount calculation |
| 15:10 | Decision to roll back deployment to v3.2.0 |
| 15:25 | Rollback complete, but connections still exhausted |
| 15:30 | Restarted database connection pools manually |
| 15:45 | Payment success rate recovering (60%) |
| 16:15 | Payment success rate at 95% |
| 16:45 | Full recovery confirmed; incident closed |

## Root Cause

The root cause was a missing database index on the 
`discounts` table. The new discount calculation feature 
introduced a query that performed a full table scan on 
every payment request:

    SELECT * FROM discounts 
    WHERE product_id = ? AND valid_until > NOW()

Without an index on `(product_id, valid_until)`, this 
query took 3-5 seconds per execution. Under production 
load (approximately 50 requests/second), this quickly 
exhausted the database connection pool (max: 100 
connections), causing all subsequent queries — including 
unrelated payment processing — to fail.

The issue was not caught in staging because the staging 
database had only 100 rows in the discounts table, while 
production had 2.3 million rows.

## Resolution

The issue was mitigated by rolling back the deployment 
to the previous version (v3.2.0) and manually restarting 
the database connection pools.

The permanent fix includes:
1. Adding the missing index on `discounts(product_id, 
   valid_until)`
2. Adding a query timeout of 1 second for all 
   payment-path queries
3. Redeploying the feature after verification

## Lessons Learned

### What went well
- Monitoring detected the issue within 15 minutes
- On-call engineer responded within 2 minutes
- Team communicated clearly in the incident channel
- Rollback procedure worked as expected

### What didn't go well
- The deployment lacked a database migration for the 
  required index
- Staging environment didn't represent production data 
  volume
- It took 40 minutes to identify the root cause
- We didn't have query-level monitoring to quickly 
  identify slow queries

### Where we got lucky
- The incident happened during business hours when the 
  full team was available
- No data corruption occurred despite the connection 
  pool exhaustion

## Action Items

| Action | Owner | Priority | Due date |
|--------|-------|----------|----------|
| Add missing index on discounts table | @juan | P0 | 2026-03-21 |
| Add query timeout (1s) for payment path | @juan | P0 | 2026-03-22 |
| Implement query-level monitoring | @devops | P1 | 2026-04-01 |
| Seed staging DB with production-scale data | @maria | P1 | 2026-04-05 |
| Add mandatory DB migration review for deploys | @tech-lead | P1 | 2026-04-01 |
| Create runbook for connection pool exhaustion | @devops | P2 | 2026-04-15 |
| Add load testing gate to CI pipeline | @maria | P2 | 2026-04-15 |
```

---

## Frases clave para cada seccion

### Summary

| Frase | Uso |
|-------|-----|
| *"On [date], [system] experienced..."* | Describir el incidente |
| *"The outage lasted [duration]."* | Duracion |
| *"Users were unable to..."* | Impacto en usuarios |
| *"The root cause was..."* | Causa resumida |

### Timeline

| Frase | Uso |
|-------|-----|
| *"At [time], we detected..."* | Deteccion |
| *"At [time], the on-call engineer..."* | Respuesta |
| *"At [time], we identified..."* | Diagnostico |
| *"At [time], the issue was mitigated by..."* | Resolucion |
| *"At [time], full recovery was confirmed."* | Cierre |

### Root cause

| Frase | Uso |
|-------|-----|
| *"The root cause was..."* | Identificar la causa |
| *"This was triggered by..."* | Evento desencadenante |
| *"The issue was not caught in testing because..."* | Brecha en testing |
| *"Under production load, this caused..."* | Escala del impacto |

### Resolution

| Frase | Uso |
|-------|-----|
| *"The issue was mitigated by..."* | Solucion temporal |
| *"The permanent fix includes..."* | Solucion definitiva |
| *"To prevent recurrence, we will..."* | Prevencion |
| *"The service was fully restored at [time]."* | Confirmacion |

---

## Vocabulario de gestion de incidentes

| Termino | Significado | Ejemplo |
|---------|-------------|---------|
| **Outage** | Caida del servicio | *"A 2-hour outage affected payments."* |
| **Severity / Priority** | Nivel de criticidad (P0-P4) | *"This was classified as P1."* |
| **On-call** | Ingeniero de guardia | *"The on-call engineer responded."* |
| **Runbook** | Guia de procedimientos | *"Follow the runbook for DB failover."* |
| **Mitigation** | Accion para reducir el impacto | *"Mitigation: roll back the deploy."* |
| **Root cause** | Causa fundamental | *"Root cause: missing index."* |
| **Blast radius** | Alcance del impacto | *"The blast radius was limited to EU region."* |
| **Mean Time to Detect (MTTD)** | Tiempo promedio en detectar | *"MTTD was 15 minutes."* |
| **Mean Time to Resolve (MTTR)** | Tiempo promedio en resolver | *"MTTR was 2 hours."* |
| **Regression** | Un problema que vuelve a aparecer | *"This is a regression from the March fix."* |

---

## Errores comunes en postmortems

| Error | Mejor practica |
|-------|---------------|
| Culpar a una persona | Enfocarse en el sistema: *"The deploy lacked..."* no *"John forgot..."* |
| Causa raiz superficial | Preguntar "por que" 5 veces (5 Whys) |
| Action items vagos | Ser especifico: dueno, fecha, prioridad |
| No incluir timeline | Siempre documentar la secuencia de eventos |
| No documentar que funciono bien | Refuerza buenas practicas |
| Escribirlo semanas despues | Dentro de 48-72 horas, cuando la memoria es fresca |

---

## Consejo final

> Los mejores equipos de ingenieria ven los incidentes como oportunidades de aprendizaje, no como fracasos. Un postmortem bien escrito no solo previene recurrencias — construye una cultura de transparencia y mejora continua. La regla de oro: escribe el postmortem que te gustaria leer si te uniras al equipo manana.
