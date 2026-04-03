# Daily Standup

## Cómo hablar en el daily standup en inglés

El daily standup (o daily scrum) es la reunión más frecuente en equipos de desarrollo. Dura entre 5 y 15 minutos y cada miembro del equipo responde tres preguntas. Dominar esta estructura te dará confianza diaria para hablar en inglés.

---

## 1. Las tres preguntas del standup

| Pregunta | Significado |
|----------|-------------|
| What did you work on yesterday? | ¿En qué trabajaste ayer? |
| What are you working on today? | ¿En qué vas a trabajar hoy? |
| Do you have any blockers? | ¿Tienes algún bloqueo? |

> Algunos equipos usan variantes:
> - "What did you accomplish yesterday?"
> - "What's your plan for today?"
> - "Is anything blocking you?"

---

## 2. Ayer — Reportar lo que hiciste (Pasado simple)

### Estructura

```text
Yesterday I [verbo en pasado] ...
```

### Ejemplos reales

```text
Yesterday I worked on the user authentication module.
Yesterday I fixed two bugs in the payment flow.
Yesterday I reviewed three pull requests.
Yesterday I spent most of the day debugging a memory leak.
Yesterday I finished the API integration for the search feature.
Yesterday I paired with Ana on the database migration.
Yesterday I updated the documentation for the REST API.
Yesterday I set up the CI pipeline for the new repo.
```

### Cuando hiciste varias cosas

```text
Yesterday I worked on two things:
  First, I fixed the login redirect issue.
  Then, I started implementing the notification feature.
```

### Cuando no terminaste algo

```text
Yesterday I continued working on the checkout flow.
  I made good progress but didn't finish the payment integration.
Yesterday I started the migration but ran into some issues
  with the data format.
```

---

## 3. Hoy — Decir tus planes (Futuro)

### Estructura

```text
Today I'm going to [verbo base] ...
Today I'll [verbo base] ...
```

### Ejemplos reales

```text
Today I'm going to work on the search feature.
Today I'll continue with the database migration.
Today I'm going to write unit tests for the auth module.
Today I'll pair with Carlos on the deployment pipeline.
Today I'm going to investigate the performance issue on mobile.
Today I'll finish the PR for the notification feature.
Today I'm going to attend the architecture review meeting.
Today I'm going to focus on code review.
```

### Cuando tienes varias tareas

```text
Today I have two main tasks:
  I'll finish the payment integration in the morning,
  and then I'm going to start on the email notifications.
```

---

## 4. Blockers — Reportar bloqueos

### Sin bloqueos

```text
No blockers.
I'm not blocked.
Nothing blocking me.
All good on my end.
No blockers so far.
```

### Con bloqueos

```text
I'm blocked by the API team — I need the new endpoint.
I'm blocked on the database migration.
  I need access to the production database.
I'm waiting for the PR review from the backend team.
I need help with the Docker configuration.
I can't proceed until the design team delivers the mockups.
I'm stuck on a weird caching issue. I might need help.
I have a dependency on the auth service that isn't ready yet.
```

### Pidiendo ayuda

```text
Could someone help me with the Kubernetes setup?
I could use some help debugging the WebSocket connection.
If anyone has experience with Redis, I'd love to chat.
Does anyone know how to configure CORS on the API gateway?
```

---

## 5. Standups completos de ejemplo

### Ejemplo 1: Desarrollador frontend

```text
"Hey, everyone. Yesterday I finished the responsive layout
for the dashboard and fixed the chart rendering bug on Safari.
Today I'm going to start working on the dark mode toggle.
No blockers."
```

### Ejemplo 2: Desarrollador backend

```text
"Hi. Yesterday I worked on the pagination endpoint for the
product listing API. I also reviewed Maria's PR for the auth module.
Today I'll continue with the search API — I need to add
filtering by category. I'm blocked on the Elasticsearch config.
Could someone from DevOps help me set it up?"
```

### Ejemplo 3: Desarrollador full-stack

```text
"Morning. Yesterday I spent most of the day debugging the
payment flow. Found the issue — it was a race condition in
the checkout process. I pushed the fix and it's in review.
Today I'm going to work on the email notification feature.
No blockers right now."
```

### Ejemplo 4: Cuando no hiciste mucho

```text
"Hey. Yesterday was mostly meetings — I had the sprint planning
and the architecture review. I did manage to start looking into
the caching issue but didn't make much progress.
Today I'll focus on the caching problem — that's my main priority.
No blockers."
```

---

## 6. Frases útiles para el standup

### Dar contexto adicional

```text
Just a heads up — I'll be out tomorrow.
Quick note — the staging server is down.
One thing to mention — I noticed the tests are flaky again.
I wanted to flag that the API latency has increased.
Also, I'll be in a workshop this afternoon.
```

### Pedir opiniones

```text
I have a question about the architecture — can we discuss after?
I'd like to get input on my approach before I go further.
Should I prioritize the bug fix or the new feature?
```

### Responder a otros

```text
I can help you with that.
I had the same issue last week — let me show you after.
I'll take a look at your PR today.
That's good to know, thanks for the heads up.
```

---

## 7. Consejos para hablar con confianza

### Mantén las respuestas cortas

Un standup no es para dar detalles profundos. Si algo necesita discusión, di:

```text
"I'd like to discuss [tema] after the standup."
"Can we take this offline?"
"Let's chat about this after the meeting."
```

### No te disculpes por no terminar algo

En lugar de: *"Sorry, I couldn't finish..."*

Di: **"I made progress on X but didn't get to finish. I'll continue today."**

### Usa frases de transición

```text
"That's all from me."
"That's it for me."
"I'm done."
"That's my update."
"Over to you, [nombre]." (para pasar el turno)
```

---

## Resumen — Plantilla para tu standup

```text
Yesterday:
  I [verbo pasado] on [tarea].
  I also [segunda tarea si aplica].

Today:
  I'm going to [plan principal].
  I'll also [segunda tarea si aplica].

Blockers:
  [No blockers. / I'm blocked by X / I need help with Y.]
```
