# Behavioral Questions - Preguntas de comportamiento

## Introduccion

Las preguntas de comportamiento (behavioral questions) evaluan como actuas en situaciones reales de trabajo. Las empresas creen que tu comportamiento pasado predice tu comportamiento futuro. El metodo **STAR** es la estructura estandar para responder estas preguntas de forma clara y convincente.

---

## El metodo STAR

| Letra | Significado | Que decir | Tiempo |
|-------|-------------|-----------|--------|
| **S** | Situation | Describe el contexto y la situacion | 15% |
| **T** | Task | Explica tu responsabilidad o tarea especifica | 10% |
| **A** | Action | Detalla las acciones que TU tomaste | 50% |
| **R** | Result | Comparte el resultado concreto y medible | 25% |

### Frases clave para cada parte

```
SITUATION:
"At my previous company..."
"While working on [project]..."
"During a sprint, we encountered..."
"Our team was facing..."

TASK:
"I was responsible for..."
"My role was to..."
"I was tasked with..."
"I needed to..."

ACTION:
"I decided to..."
"First, I analyzed... Then, I..."
"I proposed that we..."
"I took the initiative to..."
"I collaborated with the team to..."

RESULT:
"As a result, we..."
"This led to a [X]% improvement in..."
"The outcome was..."
"We successfully delivered..."
"I learned that..."
```

---

## Pregunta 1: "Tell me about a time you faced a technical challenge"

### Ejemplo de respuesta STAR

```
SITUATION:
"At my previous company, we had a critical production issue 
where our API response times jumped from 200ms to over 5 
seconds during peak hours. This was affecting thousands of 
users and our biggest client was threatening to leave."

TASK:
"As the senior backend developer, I was tasked with 
diagnosing and fixing the performance issue within 48 hours."

ACTION:
"First, I set up detailed monitoring with Datadog to identify 
the bottleneck. I discovered that a recent database migration 
had removed an important index. I also found that we were 
making N+1 queries in our most-used endpoint. I added the 
missing index, refactored the queries to use eager loading, 
and implemented a caching layer with Redis for frequently 
accessed data."

RESULT:
"Response times dropped from 5 seconds back to 150ms — 
actually better than before. We retained the client, and 
the caching strategy I implemented became a standard 
practice across all our services. I also wrote documentation 
so the team could apply the same patterns going forward."
```

---

## Pregunta 2: "Describe a project you're proud of"

### Ejemplo de respuesta STAR

```
SITUATION:
"At my company, the customer support team was spending 
four hours daily manually categorizing support tickets 
from emails and our web form."

TASK:
"I proposed building an internal tool to automate ticket 
classification. I took ownership of the project from 
design to deployment."

ACTION:
"I built a Flutter app for the support team with a clean 
dashboard. On the backend, I created a classification 
service using Python that analyzed ticket content and 
auto-assigned categories and priority levels. I worked 
closely with the support team to iterate on the accuracy, 
running two weeks of parallel testing before going live."

RESULT:
"The tool reduced manual classification time by 80%, 
saving the support team about 3 hours per day. Ticket 
response time improved by 40% because high-priority issues 
were routed faster. I'm proud of it because it had a 
direct impact on both the team's productivity and 
customer satisfaction."
```

---

## Pregunta 3: "How do you handle disagreements in a team?"

### Ejemplo de respuesta STAR

```
SITUATION:
"During a sprint planning meeting, my tech lead wanted to 
rewrite our authentication system from scratch using a new 
framework. I believed refactoring the existing system would 
be faster and less risky."

TASK:
"I needed to express my disagreement respectfully while 
ensuring we made the best technical decision for the team."

ACTION:
"I asked for time to present both options objectively. I 
created a comparison document with estimated timelines, risks, 
and benefits for each approach. I acknowledged the advantages 
of the rewrite — cleaner architecture and better testing — 
while presenting data showing that refactoring would take 
two weeks versus eight for a full rewrite. I also proposed a 
compromise: refactor now, and plan the full rewrite for the 
next quarter when we had more bandwidth."

RESULT:
"The team agreed to the incremental approach. We delivered the 
refactored auth system in 10 days, and the tech lead later 
said it was the right call. We built mutual respect, and I 
learned that backing opinions with data leads to better 
team decisions. We eventually did plan the full rewrite, 
but with better requirements."
```

---

## Pregunta 4: "What's your biggest weakness?"

### Estrategia

No digas algo falso como *"I work too hard."* Se honesto pero muestra autoconciencia y mejora activa.

```
BUENO:
"Early in my career, I tended to over-engineer solutions — 
I'd spend too much time making code 'perfect' instead of 
shipping a working version first. I've since learned to 
embrace iterative development. Now I follow the principle 
of 'make it work, make it right, make it fast' — in that 
order. My tech lead actually noticed the improvement in 
my last performance review."

BUENO:
"I sometimes struggle with estimating how long tasks will 
take — I tend to be optimistic. To address this, I started 
tracking my actual time versus estimates. Now I add a 30% 
buffer to my initial estimates, and I communicate early if 
I think a deadline is at risk."

MALO:
"I'm a perfectionist." (Cliche, no es una respuesta real)
"I don't have any weaknesses." (Nadie lo cree)
"I'm bad at teamwork." (Alarma roja)
```

---

## Mas preguntas comunes con frases utiles

| Pregunta | Frases para responder |
|----------|----------------------|
| **"How do you prioritize tasks?"** | *"I use a combination of urgency and impact..."* / *"I start by identifying blockers..."* |
| **"Tell me about a time you failed"** | *"I learned that..."* / *"In hindsight, I would have..."* / *"The key takeaway was..."* |
| **"How do you stay up to date?"** | *"I follow [blogs/podcasts], contribute to open source..."* / *"I dedicate time each week to..."* |
| **"Describe working under pressure"** | *"I focus on what I can control..."* / *"I break the problem into manageable steps..."* |
| **"Why should we hire you?"** | *"I bring [specific skill] and a track record of [achievement]..."* / *"My experience in [X] directly maps to..."* |

---

## Vocabulario esencial para respuestas de comportamiento

| Ingles | Espanol | Uso |
|--------|---------|-----|
| **I took the initiative** | Tome la iniciativa | Muestra proactividad |
| **I collaborated with** | Colabore con | Muestra trabajo en equipo |
| **I proposed / suggested** | Propuse / Sugeri | Muestra liderazgo |
| **I identified the root cause** | Identifique la causa raiz | Muestra habilidad analitica |
| **I delivered on time** | Entregue a tiempo | Muestra responsabilidad |
| **I learned that** | Aprendi que | Muestra crecimiento |
| **In hindsight** | En retrospectiva | Muestra reflexion |
| **The key takeaway was** | La leccion principal fue | Muestra madurez |
| **I adapted my approach** | Adapte mi enfoque | Muestra flexibilidad |
| **I communicated proactively** | Comunique proactivamente | Muestra profesionalismo |

---

## Errores comunes

| Error | Mejor alternativa |
|-------|-------------------|
| Respuestas vagas sin detalles | Usa numeros y resultados concretos |
| Decir "nosotros" todo el tiempo | Usa "yo" para tus acciones especificas |
| No tener un resultado claro | Siempre termina con el resultado y lo aprendido |
| Respuestas de mas de 3 minutos | Practica para mantenerla en 2 minutos |
| Hablar mal de empleadores anteriores | Enfocate en lo que aprendiste |

---

## Consejo final

> Prepara 5-6 historias STAR de tu experiencia real que cubran: un reto tecnico, un conflicto de equipo, un proyecto exitoso, un fracaso con leccion, y trabajo bajo presion. Las mismas historias pueden adaptarse a diferentes preguntas cambiando el enfasis.
