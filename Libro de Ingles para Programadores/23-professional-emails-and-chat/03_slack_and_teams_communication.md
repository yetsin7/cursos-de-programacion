# Slack and Teams Communication - Comunicacion en Slack y Teams

## Introduccion

Slack, Microsoft Teams y herramientas similares son el centro de comunicacion de los equipos de desarrollo modernos. A diferencia del email, la comunicacion aqui es mas rapida, informal y asincrona. Dominar la etiqueta y el vocabulario de estas plataformas es crucial para trabajar en equipos remotos internacionales.

---

## Prefijos comunes para mensajes

| Prefijo | Significado | Cuando usarlo |
|---------|-------------|---------------|
| **Heads up:** | Aviso/alerta | Informar algo que afecta al equipo |
| **Quick question:** | Pregunta breve | Cuando necesitas algo rapido |
| **FYI:** | For Your Information | Informativo, no requiere accion |
| **PSA:** | Public Service Announcement | Anuncio importante para todos |
| **Reminder:** | Recordatorio | Recordar algo pendiente |
| **Update:** | Actualizacion | Compartir progreso |
| **Blocker:** | Bloqueo | Algo que te impide avanzar |

### Ejemplos en contexto

```
Heads up: I'm deploying v2.3 to staging in 10 minutes. 
There might be brief downtime.

Quick question: Does anyone know the Redis password for 
the staging environment?

FYI: The design team updated the mockups for the settings 
page. Link in the thread.

PSA: We're upgrading to Node 20 next week. Please test 
your services locally before Monday.

Reminder: Code freeze is tomorrow at 5 PM. Make sure all 
PRs are merged by then.

Update: The database migration is complete. All services 
are running normally.

Blocker: I can't proceed with the API integration — I need 
access credentials from the partner team.
```

---

## Etiqueta de canales (Channel etiquette)

### Usar hilos (threads)

```
// MAL: Responder en el canal principal
#backend
Alice: "Has anyone seen this error in the logs?"
Bob: "Yes, I saw it yesterday."
Carol: "Me too. I think it's related to the cache."
Dave: "BTW, the standup is in 5 min."
// Todo mezclado, dificil de seguir

// BIEN: Usar threads
#backend
Alice: "Has anyone seen this error in the logs?"
  [Thread]
  Bob: "Yes, I saw it yesterday."
  Carol: "Me too. I think it's related to the cache."
  Alice: "Found it — it was a stale connection. Fixed in PR #567."
```

### Menciones (@mentions)

| Mencion | Cuando usarla |
|---------|---------------|
| **@person** | Necesitas la atencion de alguien especifico |
| **@here** | Necesitas atencion de quienes estan activos ahora |
| **@channel** | Importante para todos, incluso los que no estan activos |
| **Sin @** | Informativo, sin urgencia, quien quiera lo lee |

```
// @channel — solo para cosas urgentes o que afectan a todos
"@channel Production is down. All hands on deck."

// @here — para quienes estan disponibles ahora
"@here Quick sync in 5 min about the deploy. Optional."

// @person — para alguien especifico
"@mike Could you review PR #234 when you get a chance?"

// Sin @ — informativo general
"Just pushed the fix for the timeout issue. PR is up."
```

---

## Reacciones con emoji y sus significados

| Emoji | Significado comun | Equivalente verbal |
|-------|------------------|-------------------|
| :thumbsup: | Entendido / De acuerdo / Hare eso | *"Got it"* / *"Will do"* |
| :eyes: | Lo estoy revisando | *"Looking at it"* |
| :white_check_mark: | Hecho / Completado | *"Done"* |
| :raised_hands: | Excelente / Felicidades | *"Great job!"* |
| :thinking: | Necesito pensarlo / No estoy seguro | *"Hmm, let me think..."* |
| :heavy_plus_sign: | De acuerdo / Apoyo eso | *"I agree"* / *"+1"* |
| :pray: | Gracias / Por favor | *"Thank you"* / *"Please"* |
| :rocket: | Desplegado / Lanzado | *"Shipped!"* |
| :rotating_light: | Alerta / Urgente | *"Urgent issue"* |
| :tada: | Celebracion | *"Congrats!"* |

```
// Flujo tipico:
Dev: "PR #456 is ready for review."
Reviewer: [reacciona con :eyes:]         // Lo estoy viendo
Reviewer: [reacciona con :thumbsup:]     // Aprobado
Dev: "Merged and deployed."
Team: [reacciona con :rocket: y :tada:]  // Celebracion
```

---

## Comunicacion asincrona (Async communication)

En equipos distribuidos con diferentes zonas horarias, la comunicacion asincrona es fundamental.

### Principios

| Principio | Ejemplo |
|-----------|---------|
| **Da contexto completo** | No digas solo "ayuda", explica que, por que y que intentaste |
| **No esperes respuesta inmediata** | Respeta las zonas horarias |
| **Indica urgencia claramente** | Diferencia entre "when you get a chance" y "urgent" |
| **Resume decisiones en texto** | Despues de una call, escribe las conclusiones |

### Malas vs buenas preguntas

```
// MAL: Falta contexto
"Hey, this doesn't work."
"Can I ask you something?"
"Are you free?"

// BIEN: Contexto completo
"Hey @sarah, I'm getting a 403 error when calling the 
/api/users endpoint with the new auth token. I've checked 
that the token has the right scopes and isn't expired. 
Error details in thread. Is there a config I'm missing?"

// MAL: Requiere respuesta sincrona innecesaria
"Hey, are you there? I have a question."
[espera respuesta]
"OK so basically..."

// BIEN: Envia todo junto
"Hey @sarah, quick question when you get a chance: 
Is there a rate limit on the search API? I'm seeing 
429 errors after about 100 requests/min."
```

---

## Cuando usar DM vs canal

| Usar DM (mensaje directo) | Usar canal publico |
|---------------------------|-------------------|
| Temas personales o sensibles | Preguntas tecnicas que otros podrian responder |
| Feedback privado | Anuncios que afectan al equipo |
| Coordinacion 1-a-1 rapida | Decisiones que el equipo debe conocer |
| Temas de HR o salario | Discusiones de diseno o arquitectura |

```
// DM apropiado:
"Hey, just wanted to check in — I noticed you've been 
working late this week. Everything OK?"

// Canal apropiado:
"Has anyone implemented rate limiting with Redis? 
Looking for recommendations on approach."
// (Otros pueden beneficiarse de la respuesta)
```

---

## Frases utiles para chat diario

### Compartir progreso

```
"Just pushed a fix for the login bug. PR #234 is up."
"Finished the API refactoring. Ready for review."
"Making good progress on the migration. Should be done by EOD."
"Wrapping up the tests now. Will deploy to staging after lunch."
```

### Pedir ayuda

```
"Has anyone run into this error before? [screenshot]"
"Could someone point me to the docs for the auth service?"
"I'm stuck on [specific issue]. Any ideas?"
"Pair programming session, anyone? I could use a second pair of eyes."
```

### Comunicar problemas

```
"Heads up: CI is broken on main. Looking into it."
"The staging environment is down. I've pinged DevOps."
"I won't make the deadline for [task]. I'll need until [date]."
"Found a security issue in [component]. DM me for details."
```

---

## Abreviaciones comunes en chat

| Abreviacion | Significado |
|-------------|-------------|
| **EOD** | End of Day |
| **ETA** | Estimated Time of Arrival (cuando estara listo) |
| **OOO** | Out of Office |
| **WFH** | Working From Home |
| **AFAIK** | As Far As I Know |
| **IIRC** | If I Remember Correctly |
| **NP** | No Problem |
| **TBD** | To Be Determined |
| **ASAP** | As Soon As Possible |
| **CC** | Keeping someone in the loop |

---

## Consejo final

> En Slack y Teams, menos es mas. Usa hilos para mantener la conversacion organizada, reacciona con emojis en lugar de escribir "OK" o "thanks" (reduce el ruido), y siempre da contexto suficiente para que tu mensaje se entienda sin una respuesta de ida y vuelta.
