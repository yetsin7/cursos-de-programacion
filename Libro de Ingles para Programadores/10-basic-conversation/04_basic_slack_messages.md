# Basic Slack Messages

## Mensajes de Slack/Teams y abreviaciones tech

En el trabajo remoto, la comunicación por chat es tan importante como hablar en reuniones. Aquí aprenderás a escribir mensajes claros en Slack, Teams o Discord, y a entender las abreviaciones más comunes en el mundo tech.

---

## 1. Iniciar un mensaje

### Pedir algo rápido

```text
Hey, quick question:
  Does the staging API support file uploads?

Hey, quick one:
  What's the URL for the admin panel?

Hi, small ask:
  Could you add me to the #backend channel?
```

### Informar algo

```text
FYI: The staging server will be down for maintenance tonight.

Heads up: I'm going to push a breaking change to the API.

Just a heads up — the deploy is scheduled for 5 PM.

Quick update: The migration is almost done. ETA 30 minutes.
```

### Compartir algo

```text
Sharing this for visibility: [link]

For context: here's the related issue [link]

In case anyone needs it: the new API docs are here [link]
```

---

## 2. Responder a mensajes

### Aprobar / Estar de acuerdo

```text
LGTM (Looks Good To Me) - Se ve bien
Sounds good.
Works for me.
+1
Agreed.
Makes sense.
No objections from my side.
Ship it! (aprobación entusiasta para deploy)
```

### Confirmar que vas a hacer algo

```text
On it.
I'll take care of it.
Will do.
Got it.
I'll handle this.
Noted, I'll fix it today.
```

### Pedir más información

```text
Can you elaborate?
Could you share more details?
What do you mean by [X]?
Can you give me an example?
Is there a ticket for this?
```

---

## 3. Abreviaciones y acrónimos comunes

### Abreviaciones de uso diario

| Abreviación | Significado en inglés | Significado en español |
|-------------|----------------------|----------------------|
| **LGTM** | Looks Good To Me | Se ve bien para mí |
| **PTAL** | Please Take A Look | Por favor echa un vistazo |
| **WIP** | Work In Progress | Trabajo en progreso |
| **FYI** | For Your Information | Para tu información |
| **TL;DR** | Too Long; Didn't Read | Muy largo; no leí (resumen) |
| **AFAIK** | As Far As I Know | Hasta donde sé |
| **IMO** | In My Opinion | En mi opinión |
| **IMHO** | In My Humble Opinion | En mi humilde opinión |
| **BTW** | By The Way | Por cierto |
| **NVM** | Never Mind | Olvídalo |
| **AFK** | Away From Keyboard | Lejos del teclado |
| **BRB** | Be Right Back | Ya vuelvo |
| **OOO** | Out Of Office | Fuera de la oficina |
| **PTO** | Paid Time Off | Día libre pagado |
| **ETA** | Estimated Time of Arrival | Tiempo estimado de llegada |
| **EOD** | End Of Day | Fin del día |
| **EOM** | End Of Message | Fin del mensaje (todo está en el asunto) |
| **ACK** | Acknowledgment | Acuse de recibo (entendido) |
| **NACK** | Negative Acknowledgment | No aprobado / rechazado |
| **DM** | Direct Message | Mensaje directo |
| **CC** | Carbon Copy | Con copia (incluir a alguien) |

### Abreviaciones técnicas

| Abreviación | Significado | Contexto |
|-------------|-------------|----------|
| **PR** | Pull Request | "My PR is ready for review." |
| **MR** | Merge Request | GitLab usa MR en vez de PR |
| **CR** | Code Review | "Could you do a CR on this?" |
| **CI/CD** | Continuous Integration / Continuous Deployment | "The CI/CD pipeline is broken." |
| **QA** | Quality Assurance | "Has QA approved this?" |
| **UAT** | User Acceptance Testing | "It's in UAT now." |
| **MVP** | Minimum Viable Product | "Let's ship the MVP first." |
| **POC** | Proof of Concept | "I built a quick POC." |
| **RFC** | Request For Comments | "I wrote an RFC for the new architecture." |
| **SLA** | Service Level Agreement | "Our SLA guarantees 99.9% uptime." |
| **RTFM** | Read The F***ing Manual | Grosero. No lo uses, pero entiéndelo. |

---

## 4. Reacciones con emojis (cultura Slack)

En Slack, los emojis se usan como respuestas rápidas sin necesidad de escribir.

| Emoji | Significado común |
|-------|------------------|
| :thumbsup: / :+1: | De acuerdo / Entendido |
| :eyes: | Lo estoy revisando / Viendo |
| :white_check_mark: | Hecho / Completado |
| :rocket: | Deploy exitoso / Listo para lanzar |
| :fire: | Algo urgente / Algo impresionante |
| :pray: / :folded_hands: | Gracias / Por favor |
| :thinking: | Estoy pensando / No estoy seguro |
| :wave: | Hola / Adiós |
| :tada: | Celebración (release, hito cumplido) |
| :bug: | Reporte de bug |
| :hourglass: | Esperando / En proceso |

---

## 5. Plantillas de mensajes comunes

### Pedir code review

```text
Hey team, PR ready for review:
[link]

TL;DR: Adds pagination to the product listing API.
No breaking changes.

PTAL when you get a chance. Thanks!
```

### Reportar un bug

```text
:bug: Found a bug in the checkout flow:

Steps to reproduce:
1. Add item to cart
2. Click checkout
3. Enter invalid email
4. The app crashes instead of showing a validation error

Environment: staging
Browser: Chrome 120
```

### Anunciar un deploy

```text
:rocket: Deploying v2.4.1 to production now.

Changes:
- Fix: login redirect issue (#234)
- Feature: dark mode toggle (#256)
- Chore: update dependencies

ETA: ~10 minutes. I'll confirm when it's done.
```

### Anunciar que estarás fuera

```text
Heads up: I'll be OOO next Monday and Tuesday (PTO).
If anything urgent comes up, please ping @carlos.
I'll catch up on Slack when I'm back on Wednesday.
```

### Pedir ayuda en un canal

```text
Hey #backend — quick question:

Has anyone dealt with connection pooling issues in PostgreSQL?
I'm seeing intermittent timeout errors and I'm not sure
if it's the pool config or the database.

Any pointers would be appreciated. Thanks!
```

---

## 6. Tono y etiqueta en mensajes de chat

### Buenas prácticas

| Hacer | No hacer |
|-------|----------|
| Ir directo al punto | Escribir solo "Hi" y esperar respuesta |
| Dar contexto suficiente | Enviar mensajes vagos sin detalles |
| Usar threads para discusiones | Llenar el canal principal con una conversación larga |
| Respetar las zonas horarias | Esperar respuesta inmediata de alguien en otra zona |
| Usar mentions (@name) con criterio | Hacer @channel/@here innecesariamente |

### El anti-patrón de "Hello"

**No hagas esto:**
```text
12:01 PM - You: Hi
12:01 PM - You: (esperando que la otra persona responda)
12:15 PM - Them: Hey, what's up?
12:15 PM - You: Can you review my PR?
```

**Haz esto:**
```text
12:01 PM - You: Hey! Could you review my PR when you get a chance?
            Here's the link: [link]. No rush. Thanks!
```

> Esto se llama **"nohello"** y es una norma cultural importante en equipos remotos. Incluye tu pregunta en el primer mensaje.

---

## 7. Frases de transición útiles

```text
Following up on our conversation earlier...
Just circling back on this.
Any update on this?
Bumping this — anyone had a chance to look?
Closing the loop: the issue is now fixed.
Update: the deploy was successful.
Resolved: the bug was a caching issue.
```

---

## Resumen de abreviaciones esenciales

| Abreviación | Úsala cuando... |
|-------------|-----------------|
| LGTM | Apruebas un PR o una idea |
| PTAL | Quieres que alguien revise algo |
| WIP | Tu trabajo aún no está terminado |
| FYI | Compartes información sin pedir acción |
| TL;DR | Das un resumen de algo largo |
| AFAIK | No estás 100% seguro pero compartes lo que sabes |
| IMO | Das tu opinión personal |
| ETA | Preguntas o das un estimado de tiempo |
| OOO | Avisas que no estarás disponible |
