# Reported Speech (Estilo Indirecto) en Programación

## Introducción

El reported speech se usa para **reportar lo que alguien dijo** sin usar
sus palabras exactas. Es extremadamente común en reuniones, standups,
retrospectivas y comunicación por escrito en equipos de desarrollo.

---

## Regla principal: El tiempo verbal retrocede un paso

Cuando reportas lo que alguien dijo, el verbo generalmente retrocede
un tiempo verbal.

| Discurso directo | Reported speech | Cambio |
|-----------------|----------------|--------|
| "The build **is** broken." | She said the build **was** broken. | Present → Past |
| "I **am** working on it." | He said he **was** working on it. | Present continuous → Past continuous |
| "We **have** fixed the bug." | They said they **had** fixed the bug. | Present perfect → Past perfect |
| "I **will** deploy tomorrow." | She said she **would** deploy the next day. | Will → Would |
| "We **can** finish by Friday." | He said they **could** finish by Friday. | Can → Could |
| "I **must** refactor this." | She said she **had to** refactor that. | Must → Had to |

---

## Verbos para reportar

| Verbo | Uso | Ejemplo |
|-------|-----|---------|
| **said** | General, neutro | She **said** the API was down. |
| **told** (+ persona) | Dirigido a alguien | He **told** me to rebase. |
| **mentioned** | Casual, de paso | They **mentioned** the deadline had changed. |
| **asked** | Preguntas | The PM **asked** if we could finish by Friday. |
| **explained** | Explicaciones | She **explained** how the auth flow worked. |
| **suggested** | Sugerencias | He **suggested** using a different approach. |
| **confirmed** | Confirmaciones | She **confirmed** the deployment was successful. |
| **reported** | Información formal | The QA team **reported** three critical bugs. |
| **announced** | Anuncios | The CTO **announced** a new tech stack. |
| **warned** | Advertencias | He **warned** us about the breaking change. |
| **admitted** | Reconocer algo | She **admitted** the estimate was too optimistic. |
| **claimed** | Afirmar (puede implicar duda) | He **claimed** the code was ready for review. |
| **insisted** | Insistir | She **insisted** we needed more tests. |
| **agreed** | Estar de acuerdo | The team **agreed** to postpone the release. |
| **denied** | Negar | He **denied** introducing the bug. |
| **promised** | Prometer | She **promised** to fix it by Monday. |

---

## Reported speech en standups

Los daily standups son el lugar más común para usar reported speech.

### Standup directo (primera persona)

```
"Yesterday I finished the login page.
Today I'm going to work on the signup form.
I'm blocked by the missing API documentation."
```

### Reportando el standup de alguien

```
Maria said she had finished the login page yesterday.
She mentioned she was going to work on the signup form.
She also said she was blocked by the missing API documentation.
```

### Más ejemplos de standups

```
# Lo que dijo Carlos:
"I found a critical bug in the payment module."

# Reportando:
Carlos said he had found a critical bug in the payment module.
Carlos mentioned that there was a critical bug in the payment module.

# Lo que dijo Ana:
"I'll have the PR ready by end of day."

# Reportando:
Ana said she would have the PR ready by end of day.
Ana told us she would have the PR ready by end of day.
```

---

## Reported speech en reuniones

### Sprint planning

```
# Directo
PM: "We need to finish the checkout flow this sprint."
Dev: "I think that's too ambitious. We should split it."

# Reported
The PM said we needed to finish the checkout flow that sprint.
The developer told him it was too ambitious and suggested
splitting it into two sprints.
```

### Retrospectiva

```
# Directo
"The deployment process is too slow."
"We should automate the testing pipeline."
"The documentation was really helpful."

# Reported
Several team members said the deployment process was too slow.
Alex suggested automating the testing pipeline.
Maria mentioned that the documentation had been really helpful.
```

### Code review discussion

```
# Directo
Reviewer: "This function is too long. Can you split it?"
Author: "I'll break it into three smaller functions."

# Reported
The reviewer said the function was too long and asked
if I could split it.
I told them I would break it into three smaller functions.
```

---

## Reportando preguntas

Las preguntas se reportan con **asked** + **if/whether** (sí/no)
o **asked** + **palabra interrogativa**.

### Preguntas de sí/no

| Directo | Reported |
|---------|---------|
| "Is the build passing?" | He asked **if** the build was passing. |
| "Can we deploy today?" | She asked **if** we could deploy that day. |
| "Have you tested this?" | He asked **whether** I had tested it. |
| "Will this break anything?" | She asked **if** that would break anything. |

### Preguntas con palabra interrogativa

| Directo | Reported |
|---------|---------|
| "When will the API be ready?" | He asked **when** the API would be ready. |
| "Why did the test fail?" | She asked **why** the test had failed. |
| "Who is working on this?" | He asked **who** was working on that. |
| "How should I handle errors?" | She asked **how** she should handle errors. |
| "What caused the outage?" | The PM asked **what** had caused the outage. |

> **Nota:** En reported questions, el orden es sujeto + verbo
> (no se invierte como en preguntas directas).

---

## Reportando órdenes y peticiones

Se usa **told + persona + to + verbo** para órdenes y peticiones.

| Directo | Reported |
|---------|---------|
| "Rebase your branch." | He **told** me **to** rebase my branch. |
| "Don't push to main." | She **told** us **not to** push to main. |
| "Please review my PR." | He **asked** me **to** review his PR. |
| "Run the migrations first." | She **told** me **to** run the migrations first. |
| "Don't merge without approval." | The lead **told** us **not to** merge without approval. |

---

## Cambios de tiempo y lugar en reported speech

| Directo | Reported |
|---------|---------|
| today | that day |
| yesterday | the day before / the previous day |
| tomorrow | the next day / the following day |
| this week | that week |
| next sprint | the following sprint |
| here | there |
| this | that |
| now | then / at that time |
| ago | before / earlier |

### Ejemplo

```
# Directo (lunes)
"I'll finish this feature today and deploy tomorrow."

# Reported (miércoles)
On Monday, she said she would finish that feature that day
and deploy the next day.
```

---

## Cuándo NO cambiar el tiempo verbal

Si la información **sigue siendo verdadera**, puedes mantener
el tiempo original:

```
# Sigue siendo verdad
He said the API uses REST. (todavía usa REST)
She said JavaScript is single-threaded. (sigue siendo verdad)
He mentioned the office is on the third floor. (sigue ahí)

# También correcto con cambio
He said the API used REST.
She said JavaScript was single-threaded.
```

---

## Resumen rápido

```
said / told / mentioned   → para afirmaciones
asked if / whether        → para preguntas sí/no
asked + wh-word           → para preguntas abiertas
told + person + to        → para órdenes/peticiones
suggested / recommended   → para sugerencias
warned                    → para advertencias
confirmed                 → para confirmaciones
```

> **Consejo:** Después de cada reunión, intenta resumir mentalmente
> lo que se dijo usando reported speech. Es el mejor ejercicio para
> interiorizar esta estructura.
