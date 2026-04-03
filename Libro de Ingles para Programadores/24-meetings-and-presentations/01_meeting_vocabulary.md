# Meeting Vocabulary - Vocabulario de reuniones

## Introduccion

Las reuniones son una parte inevitable del trabajo en desarrollo de software. Desde los standups diarios hasta los sprint plannings, necesitas dominar el vocabulario especifico para participar activamente y entender lo que sucede. Esta leccion cubre los terminos y frases esenciales.

---

## Tipos de reuniones en desarrollo

| Tipo | Descripcion | Frecuencia |
|------|-------------|------------|
| **Standup / Daily standup** | Reunion breve de estado (15 min) | Diaria |
| **Sprint planning** | Planificar el trabajo del sprint | Cada sprint |
| **Grooming / Refinement** | Detallar y estimar tareas futuras | Semanal |
| **Retro / Retrospective** | Reflexionar sobre lo que funciono y que no | Cada sprint |
| **One-on-one (1:1)** | Reunion privada con tu manager | Semanal/quincenal |
| **All-hands** | Reunion de toda la empresa | Mensual/trimestral |
| **Town hall** | Similar a all-hands, con sesion de preguntas | Trimestral |
| **Kickoff** | Reunion inicial de un proyecto | Una vez |
| **Wrap-up** | Reunion de cierre de un proyecto | Una vez |
| **Sync** | Reunion de sincronizacion entre equipos | Segun necesidad |
| **Breakout room** | Subgrupo que se separa para discutir un tema | Durante reuniones grandes |

---

## Vocabulario esencial de reuniones

| Termino | Significado | Ejemplo |
|---------|-------------|---------|
| **Agenda** | Lista de temas a tratar | *"Let's review the agenda."* |
| **Minutes** | Notas/acta de la reunion | *"I'll send the meeting minutes after."* |
| **Action items** | Tareas asignadas como resultado | *"Your action item is to update the docs."* |
| **Follow-up** | Seguimiento posterior | *"I'll follow up with the design team."* |
| **Timebox** | Limitar el tiempo de discusion | *"Let's timebox this to 10 minutes."* |
| **Blocker** | Algo que impide avanzar | *"My blocker is waiting for API access."* |
| **Takeaway** | Conclusion principal | *"The key takeaway is we need more testing."* |
| **Parking lot** | Temas pospuestos para despues | *"Let's put that in the parking lot."* |

---

## Frases comunes en reuniones

### Iniciar la reunion

| Frase | Contexto |
|-------|----------|
| *"Let's get started."* | Iniciar la reunion |
| *"Is everyone here?"* / *"Are we waiting for anyone?"* | Verificar asistencia |
| *"Let's dive in."* | Ir directo al tema |
| *"Who wants to go first?"* | En standups |
| *"Let me share my screen."* | Presentar algo visual |

### Durante la reunion

| Frase | Contexto |
|-------|----------|
| *"Any blockers?"* | Preguntar por impedimentos |
| *"Can you elaborate on that?"* | Pedir mas detalles |
| *"Let's table this for now."* | Posponer un tema |
| *"Let's take this offline."* | Discutirlo fuera de la reunion |
| *"Let's circle back to this."* | Volver a un tema despues |
| *"Let's not go down that rabbit hole."* | Evitar desviarse del tema |
| *"Can we stay on track?"* | Redirigir la discusion |
| *"Does that make sense?"* | Verificar comprension |

### Cerrar la reunion

| Frase | Contexto |
|-------|----------|
| *"Let's wrap up."* | Indicar que la reunion esta terminando |
| *"To summarize..."* | Resumir decisiones |
| *"What are the action items?"* | Asignar tareas |
| *"Who's taking the lead on this?"* | Asignar responsable |
| *"Same time next week?"* | Confirmar proxima reunion |
| *"Thanks everyone for your time."* | Agradecer y cerrar |

---

## El standup: estructura y frases

El standup diario sigue una estructura de 3 preguntas:

| Pregunta | Frases para responder |
|----------|----------------------|
| **What did you do yesterday?** | *"Yesterday I worked on..."* / *"I finished..."* / *"I completed..."* |
| **What will you do today?** | *"Today I'll be working on..."* / *"I'm going to focus on..."* / *"I plan to..."* |
| **Any blockers?** | *"No blockers."* / *"I'm blocked on..."* / *"I need [X] from [person/team]."* |

### Ejemplo de standup completo

```
You: "Yesterday I finished the database migration script 
and created a PR — it's ready for review. 

Today I'm going to start on the API endpoint for user 
notifications. I'll also pair with Sarah on the caching 
strategy.

No blockers on my end."
```

```
You: "Yesterday I was looking into the performance issue 
on the search endpoint. I narrowed it down to an N+1 
query problem.

Today I'll implement the fix and run benchmarks. 
Hoping to have a PR up by end of day.

One blocker: I need access to the production logs to 
verify the fix works at scale. @DevOps, could someone 
help me with that?"
```

---

## La retrospectiva: estructura y frases

Las retrospectivas usan diferentes formatos. El mas comun:

| Columna | Pregunta | Frases utiles |
|---------|----------|---------------|
| **What went well** | Que salio bien? | *"I think the deploy process went really smoothly."* |
| **What didn't go well** | Que no salio bien? | *"We had too many last-minute changes."* |
| **Action items** | Que vamos a mejorar? | *"We should add more automated tests."* |

```
// Ejemplo de participacion en retro:

"One thing that went well: the new CI pipeline saved us 
a lot of time. Deployments that used to take 30 minutes 
now take 5.

Something that didn't go well: we underestimated the 
complexity of the payment integration. We should break 
these tasks down more carefully in planning.

As an action item, I'd suggest we add a technical 
spike before committing to estimates on unfamiliar 
integrations."
```

---

## Modismos de reuniones

| Frase | Significado real |
|-------|-----------------|
| *"Let's table this"* | Posponerlo (NO discutirlo, como en espanol) |
| *"Let's take this offline"* | Hablarlo fuera de la reunion, entre los interesados |
| *"Let's circle back"* | Volver a este tema despues |
| *"Let's park this"* | Ponerlo en espera (parking lot) |
| *"Let's not boil the ocean"* | No intentar hacer todo a la vez |
| *"Let's align on this"* | Ponernos de acuerdo |
| *"Are we on the same page?"* | Estamos de acuerdo / entendemos lo mismo? |
| *"Let's get everyone on the same page"* | Asegurar que todos entiendan |

> **Cuidado:** "Let's table this" en ingles americano significa **posponer**. En ingles britanico puede significar **poner sobre la mesa para discutir**. En equipos internacionales, el significado americano (posponer) es el mas comun en tech.

---

## Conversacion simulada: Sprint planning

```
Scrum Master: "OK team, let's get started with sprint 
planning. The goal for this sprint is to launch the 
notification feature. Let's review the backlog."

Dev 1: "The notification API looks well-defined. I'd 
estimate it at 5 story points."

Dev 2: "I think it's more like 8 — we need to handle 
edge cases for different notification types."

Scrum Master: "Good point. Let's timebox this discussion 
to 5 minutes and then vote."

Dev 1: "Fair. Also, I want to bring up a concern about 
the push notification service. We don't have experience 
with FCM."

Scrum Master: "Let's park that and add a technical spike 
to the sprint. Who wants to take the lead on that?"

Dev 2: "I can look into it."

Scrum Master: "Great. Any other items? ... OK, let's 
wrap up. Action items: Dev 1 takes the notification API, 
Dev 2 does the FCM spike. Same time next week for 
refinement. Thanks everyone!"
```

---

## Consejo final

> Participa activamente en las reuniones, incluso si tu ingles no es perfecto. Usar las frases correctas muestra profesionalismo y confianza. Si no entiendes algo, no dudes en preguntar: *"Sorry, could you repeat that?"* o *"Could you clarify what you mean by...?"* es siempre mejor que quedarse en silencio y perderse algo importante.
