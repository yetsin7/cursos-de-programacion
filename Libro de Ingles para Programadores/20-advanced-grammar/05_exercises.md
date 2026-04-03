# Ejercicios: Gramática Avanzada

---

## Ejercicio 1: Identifica el tipo de condicional

Clasifica cada oración como Zero, First, Second o Third conditional:

1. "If the tests pass, we will deploy to production."
2. "If you push to main, the CI pipeline runs."
3. "If we had written tests, we would have caught this bug."
4. "If I had more time, I would refactor the entire module."
5. "If the API returns an error, the app shows a fallback."
6. "If we had chosen microservices, we wouldn't be stuck now."
7. "If you merge this, it will fix the issue."
8. "If I were you, I would add more error handling."

### Respuestas

1. **First** conditional (probable future)
2. **Zero** conditional (always happens)
3. **Third** conditional (past, impossible to change)
4. **Second** conditional (hypothetical present)
5. **Zero** conditional (always happens)
6. **Mixed** conditional (past condition → present consequence)
7. **First** conditional (probable future)
8. **Second** conditional (hypothetical / advice)

---

## Ejercicio 2: Completa con el condicional correcto

1. "If the server ___ (crash), we ___ (lose) all unsaved data." (zero)
2. "If we ___ (add) caching, the app ___ (be) much faster." (first)
3. "If I ___ (have) more experience, I ___ (apply) for the senior position." (second)
4. "If they ___ (test) the migration, the database ___ (not/corrupt)." (third)
5. "If you ___ (not/handle) the error, the app ___ (crash)." (zero)

### Respuestas

1. "If the server **crashes**, we **lose** all unsaved data."
2. "If we **add** caching, the app **will be** much faster."
3. "If I **had** more experience, I **would apply** for the senior position."
4. "If they **had tested** the migration, the database **wouldn't have been corrupted**."
5. "If you **don't handle** the error, the app **crashes**."

---

## Ejercicio 3: Elige el verbo modal correcto

Selecciona el modal más apropiado (can, could, should, would, must, might, may):

1. "You ___ use HTTPS in production. It's mandatory."
2. "We ___ consider using a message queue for this."
3. "This library ___ parse both XML and JSON."
4. "This ___ cause a memory leak if not handled properly."
5. "___ you mind reviewing my PR?"
6. "You ___ add input validation. It's a best practice."
7. "The API ___ be down. I'm getting timeout errors."
8. "If I were you, I ___ rewrite this in TypeScript."

### Respuestas

1. **must** (obligación — seguridad)
2. **could** / **should** (sugerencia)
3. **can** (capacidad)
4. **could** / **might** (posibilidad — riesgo)
5. **Would** (petición educada)
6. **should** (recomendación)
7. **might** / **may** (posibilidad)
8. **would** (hipotético)

---

## Ejercicio 4: Completa con el pronombre relativo correcto

Usa who, which, that, where, when o whose:

1. "The developer ___ wrote this module has left."
2. "The function ___ handles authentication is broken."
3. "The directory ___ the config files are stored."
4. "TypeScript, ___ was created by Microsoft, is very popular."
5. "The class ___ constructor takes three arguments."
6. "The sprint ___ we launched the new design."
7. "Developers ___ use linters write cleaner code."
8. "The bug, ___ was discovered yesterday, has been fixed."
9. "The server ___ our database runs is in Frankfurt."
10. "The module ___ tests are failing needs attention."

### Respuestas

1. **who** / **that** (persona)
2. **that** / **which** (cosa, definitoria)
3. **where** (lugar)
4. **which** (cosa, no definitoria — con comas)
5. **whose** (posesión)
6. **when** (tiempo)
7. **who** / **that** (personas)
8. **which** (cosa, no definitoria — con comas)
9. **where** (lugar)
10. **whose** (posesión)

---

## Ejercicio 5: Convierte a reported speech

Convierte cada oración de discurso directo a indirecto:

1. Maria: "The build is broken."
2. Carlos: "I will fix the bug tomorrow."
3. PM: "Can we deploy today?"
4. Tech Lead: "Rebase your branch before merging."
5. Ana: "I have finished the API integration."
6. Reviewer: "Why did you use a class instead of a function?"
7. CTO: "We are migrating to Kubernetes next quarter."
8. QA: "I found three critical bugs."

### Respuestas

1. Maria **said** the build **was** broken.
2. Carlos **said** he **would** fix the bug **the next day**.
3. The PM **asked if** they **could** deploy **that day**.
4. The Tech Lead **told** me **to** rebase my branch before merging.
5. Ana **said** she **had finished** the API integration.
6. The reviewer **asked why** I **had used** a class instead of a function.
7. The CTO **said** they **were migrating** to Kubernetes **the following quarter**.
8. QA **reported** they **had found** three critical bugs.

---

## Ejercicio 6: Escribe un resumen de standup en reported speech

Estas son las notas del standup de hoy. Escribe un resumen usando
reported speech:

**Maria:** "Yesterday I completed the payment integration. Today I'm
starting the email notifications. I'm blocked by the SMTP credentials."

**Carlos:** "I fixed two bugs yesterday. Today I'll write tests for the
auth module. No blockers."

**Ana:** "I'm still working on the database migration. It will take
one more day. I need help with the rollback strategy."

### Respuesta sugerida

```
Maria said she had completed the payment integration the
previous day. She mentioned she was starting the email
notifications and that she was blocked by the SMTP credentials.

Carlos said he had fixed two bugs the day before. He told
us he would write tests for the auth module that day. He
confirmed he had no blockers.

Ana said she was still working on the database migration
and that it would take one more day. She asked for help
with the rollback strategy.
```

---

## Ejercicio 7: Ejercicio mixto

Completa cada oración con la estructura gramatical correcta:

1. (2nd conditional) "If we ___ a dedicated QA team, we ___ fewer bugs in production."
2. (modal) "You ___ not commit directly to main. Always use a feature branch."
3. (relative clause) "The endpoint ___ requires authentication returns a 401 if no token is provided."
4. (reported speech) Direct: "I'll have the PR ready by noon." → Reported: She said she ___ the PR ready by noon.
5. (1st conditional) "If the database ___ down, the health check ___ a 503."
6. (modal) "This approach ___ work, but I'm not 100% sure."
7. (relative clause) "Redis, ___ is an in-memory store, is often used for caching."
8. (3rd conditional) "If we ___ the migration script, the data ___ corrupted."

### Respuestas

1. "If we **had** a dedicated QA team, we **would have** fewer bugs in production."
2. "You **must** not commit directly to main."
3. "The endpoint **that** requires authentication returns a 401."
4. She said she **would have** the PR ready by noon.
5. "If the database **goes** down, the health check **will return** a 503."
6. "This approach **might** work, but I'm not 100% sure."
7. "Redis, **which** is an in-memory store, is often used for caching."
8. "If we **had tested** the migration script, the data **wouldn't have been** corrupted."
