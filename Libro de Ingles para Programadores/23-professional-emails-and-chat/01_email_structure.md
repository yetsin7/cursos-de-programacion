# Email Structure - Estructura de emails profesionales

## Introduccion

El email sigue siendo el medio de comunicacion formal mas importante en el mundo profesional. Saber escribir emails claros, profesionales y con el tono adecuado en ingles es una habilidad esencial para cualquier desarrollador que trabaje con equipos internacionales.

---

## Anatomia de un email profesional

Todo email tiene 5 componentes:

| Componente | Proposito | Ejemplo |
|-----------|-----------|---------|
| **Subject line** | Resume el proposito del email | *"Request: Access to staging environment"* |
| **Greeting** | Saludo apropiado al destinatario | *"Hi Sarah,"* |
| **Body** | Contenido principal, claro y conciso | El mensaje en si |
| **Closing** | Cierre y llamada a la accion | *"Let me know if you have any questions."* |
| **Sign-off** | Despedida profesional | *"Best regards, Juan"* |

---

## Subject lines efectivos

El asunto debe ser especifico y permitir al lector entender el email sin abrirlo.

| Malo | Bueno | Por que |
|------|-------|---------|
| "Question" | "Question: Database migration timeline" | Especifica el tema |
| "Help" | "Request: Access to production logs" | Indica la accion necesaria |
| "Update" | "Update: Sprint 14 deployment — completed" | Da contexto y estado |
| "Meeting" | "Meeting: API redesign — Thursday 2 PM" | Incluye fecha y tema |
| "Bug" | "Bug report: Login fails on Safari 17" | Detalla el problema |

### Prefijos utiles para subject lines

| Prefijo | Uso | Ejemplo |
|---------|-----|---------|
| **Request:** | Pedir algo | *"Request: Review of PR #342"* |
| **FYI:** | Informativo, no requiere accion | *"FYI: New CI pipeline deployed"* |
| **Action required:** | El lector debe hacer algo | *"Action required: Update your SSH keys by Friday"* |
| **Follow-up:** | Continuacion de una conversacion | *"Follow-up: Database migration plan"* |
| **Urgent:** | Situacion critica (usar con moderacion) | *"Urgent: Production API returning 500 errors"* |

---

## Niveles de formalidad

### Formal (stakeholders, clientes, managers de otras areas)

```
Subject: Proposal: Migration to microservices architecture

Dear Mr. Thompson,

I hope this email finds you well. I am writing to share our 
proposal for migrating the payment processing system to a 
microservices architecture.

As discussed in our meeting on March 15th, the current 
monolithic system has reached its scalability limits. The 
attached document outlines our proposed approach, timeline, 
and resource requirements.

I would appreciate the opportunity to discuss this further 
at your earliest convenience. Please let me know if you 
have any questions or concerns.

Best regards,
Juan Garcia
Senior Software Engineer
```

### Semi-formal (manager directo, colegas de otros equipos)

```
Subject: Update: Authentication service refactoring

Hi Sarah,

Following up on our discussion yesterday — I've completed 
the initial analysis of the auth service refactoring.

Here's a quick summary:
- Current response time: 800ms average
- Estimated response time after refactoring: 200ms
- Timeline: approximately 2 sprints

I've created a technical document with more details. Would 
you have time this week for a 30-minute review?

Thanks,
Juan
```

### Informal (companeros cercanos del mismo equipo)

```
Subject: Quick question about the cache config

Hey Mike,

Quick question — do you remember which Redis version we're 
running on staging? I need to check if it supports streams.

Also, heads up: I pushed a fix for the timeout issue we 
discussed. PR is up when you get a chance.

Cheers,
Juan
```

---

## Saludos (Greetings)

| Nivel | Saludo | Cuando usarlo |
|-------|--------|---------------|
| Formal | *"Dear Mr./Ms. [Last Name],"* | Primera vez, clientes, ejecutivos |
| Formal | *"Dear [Full Name],"* | Cuando no sabes el genero |
| Semi-formal | *"Hi [First Name],"* | Colegas, manager directo |
| Semi-formal | *"Hello [First Name],"* | Ligeramente mas formal que "Hi" |
| Informal | *"Hey [First Name],"* | Companeros cercanos |
| Grupo | *"Hi team,"* / *"Hi everyone,"* | Emails a multiples personas |

---

## Aperturas (Opening lines)

| Frase | Contexto |
|-------|----------|
| *"I hope this email finds you well."* | Formal, primera vez o contacto infrecuente |
| *"Thank you for your quick response."* | Agradeciendo una respuesta previa |
| *"Following up on our meeting/conversation..."* | Continuando una discusion |
| *"As discussed in our meeting on [date]..."* | Referenciando una reunion |
| *"I'm writing to..."* | Directo, cuando el proposito es claro |
| *"I'm reaching out because..."* | Semi-formal, explica por que escribes |
| *"Just a quick note to..."* | Informal, mensaje breve |
| *"Hope you had a great weekend."* | Informal, inicio de semana |

---

## Cierres (Closing lines)

| Frase | Contexto |
|-------|----------|
| *"Please let me know if you have any questions."* | Invitacion a preguntar |
| *"I look forward to hearing from you."* | Esperas respuesta |
| *"Let me know if you need anything else."* | Ofreciendo ayuda adicional |
| *"I'd appreciate your feedback by [date]."* | Pidiendo respuesta con deadline |
| *"Thank you for your time and consideration."* | Formal, despues de una propuesta |
| *"Happy to discuss further if needed."* | Ofreciendo disponibilidad |
| *"No rush — whenever you get a chance."* | Informal, sin urgencia |

---

## Despedidas (Sign-offs)

| Nivel | Despedida |
|-------|-----------|
| Formal | *"Best regards,"* / *"Kind regards,"* / *"Sincerely,"* |
| Semi-formal | *"Thanks,"* / *"Best,"* / *"Thank you,"* |
| Informal | *"Cheers,"* / *"Thanks!"* / *"Talk soon,"* |

---

## Estructura del body: la regla del "piramide invertida"

Pon la informacion mas importante primero:

```
1. PROPOSITO: Por que escribes (1 oracion)
2. CONTEXTO: Informacion necesaria (2-3 oraciones)
3. ACCION: Que necesitas del lector (1 oracion)
4. DETALLES: Informacion adicional si es necesaria

// Ejemplo:
"I'd like to request access to the production database. [PROPOSITO]

Our team needs to investigate a performance issue that's 
affecting the checkout flow. The issue started after 
yesterday's deployment. [CONTEXTO]

Could you grant read-only access to my account (jgarcia) 
by end of day? [ACCION]

I've already checked with the security team and they 
approved the request — ticket SEC-456 for reference. [DETALLES]"
```

---

## Errores comunes de hispanohablantes

| Error | Correcto | Explicacion |
|-------|----------|-------------|
| *"I write to you for..."* | *"I'm writing to..."* | Usar presente continuo |
| *"Dear Sirs"* | *"Dear team,"* / *"Hello,"* | "Dear Sirs" es anticuado y excluyente |
| *"I hope you are good"* | *"I hope you're doing well"* | Frase hecha en ingles |
| *"Thanks for your attention"* | *"Thank you for your time"* | Mas natural en ingles |
| *"I wait your answer"* | *"I look forward to hearing from you"* | Frase estandar en ingles |
| *"Greetings"* (como despedida) | *"Best regards,"* | "Greetings" es solo para saludar |
| Parrafos de 10+ lineas | 3-4 lineas maximo por parrafo | Los emails se escanean, no se leen |

---

## Consejo final

> Antes de enviar un email, leelo desde la perspectiva del receptor. Preguntate: entiendo el proposito en los primeros 5 segundos? Se que accion se espera de mi? Si la respuesta es no, reescribe. Un buen email ahorra tiempo a todos.
