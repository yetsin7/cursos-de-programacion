# Presenting Technical Topics - Presentar temas tecnicos

## Introduccion

Presentar temas tecnicos en ingles — ya sea una demo, un tech talk, una propuesta de arquitectura o un informe de postmortem — es una habilidad que puede impulsar tu carrera. Esta leccion te ensena a estructurar presentaciones tecnicas y las frases clave para cada seccion.

---

## Estructura de una presentacion tecnica

| Seccion | Duracion aprox. | Proposito |
|---------|----------------|-----------|
| **Introduction** | 10% | Captar atencion, presentar el tema |
| **Problem/Context** | 20% | Explicar el problema o la necesidad |
| **Solution/Approach** | 40% | Presentar tu solucion con detalles |
| **Demo** (si aplica) | 20% | Mostrar la solucion en accion |
| **Q&A** | 10% | Responder preguntas |

---

## Frases para cada seccion

### Introduccion

| Frase | Uso |
|-------|-----|
| *"Today I'd like to present..."* | Abrir la presentacion |
| *"I'm here to talk about..."* | Alternativa directa |
| *"By the end of this talk, you'll understand..."* | Establecer expectativas |
| *"Let me give you some context first."* | Antes de entrar en detalles |
| *"This presentation covers three main topics..."* | Dar un overview |

```
// Ejemplo de introduccion:
"Hi everyone. Today I'd like to present our approach to 
migrating the authentication service to OAuth 2.0. 

By the end of this talk, you'll understand why we're making 
this change, how the new system works, and what the 
migration timeline looks like.

Let me give you some context first."
```

### Problema / Contexto

| Frase | Uso |
|-------|-----|
| *"The current system has these limitations..."* | Describir problemas |
| *"We've been experiencing..."* | Describir sintomas |
| *"The challenge we're facing is..."* | Enmarcar el desafio |
| *"This has resulted in..."* | Describir consecuencias |
| *"Here's why this matters..."* | Justificar la importancia |

```
// Ejemplo:
"The current authentication system has several limitations. 
First, it doesn't support single sign-on, which means users 
need separate credentials for each service. 

Second, we've been experiencing session management issues 
that result in about 200 support tickets per month. 

This has resulted in increased churn and a poor user experience."
```

### Solucion / Enfoque

| Frase | Uso |
|-------|-----|
| *"Our proposed solution is..."* | Presentar la solucion |
| *"Here's how it works..."* | Explicar el mecanismo |
| *"As you can see in this diagram..."* | Referir a un visual |
| *"The key advantage of this approach is..."* | Destacar beneficios |
| *"We considered [alternative], but..."* | Mostrar que evaluaste opciones |
| *"Let me walk you through the architecture."* | Guiar por un diagrama |

```
// Ejemplo:
"Our proposed solution is to migrate to OAuth 2.0 with 
OpenID Connect. Let me walk you through the architecture.

As you can see in this diagram, the auth flow starts with 
the client redirecting to our identity provider. The key 
advantage of this approach is that we get SSO support out 
of the box.

We considered building a custom token service, but OAuth 2.0 
is an industry standard with proven security patterns."
```

### Datos y metricas

| Frase | Uso |
|-------|-----|
| *"According to our benchmarks..."* | Presentar datos de rendimiento |
| *"The data shows that..."* | Respaldar con evidencia |
| *"We saw a [X]% improvement in..."* | Cuantificar mejoras |
| *"Let me show you the numbers."* | Transicion a datos |
| *"As this chart illustrates..."* | Referir a una grafica |

### Demo

| Frase | Uso |
|-------|-----|
| *"Let me show you a quick demo."* | Iniciar demo |
| *"Here I'm going to..."* | Narrar lo que haces |
| *"Notice how..."* | Dirigir la atencion |
| *"As you can see..."* | Senalar resultados |
| *"Let me switch to the terminal/browser."* | Transicion de pantalla |

```
// Ejemplo de narracion de demo:
"Let me show you a quick demo. I'm going to log in with 
a test account. Notice how the redirect happens seamlessly 
to the identity provider. 

Now I enter the credentials... and as you can see, I'm 
redirected back to the application with a valid session. 
The whole flow takes under 2 seconds."
```

### Resumen y cierre

| Frase | Uso |
|-------|-----|
| *"To summarize..."* | Empezar el resumen |
| *"The key takeaway is..."* | Resaltar lo mas importante |
| *"In conclusion..."* | Cerrar formalmente |
| *"Next steps would be..."* | Indicar que sigue |
| *"Are there any questions?"* | Abrir Q&A |
| *"Thank you for your time."* | Cerrar la presentacion |

```
// Ejemplo de cierre:
"To summarize: we're proposing a migration to OAuth 2.0 
to solve our SSO and session management issues. The key 
takeaway is that this will reduce support tickets by an 
estimated 60% and improve the user experience significantly.

Next steps: I'll share the RFC by Friday, and we'll discuss 
it in next week's architecture review.

Are there any questions?"
```

---

## Manejando preguntas (Q&A)

| Situacion | Frase |
|-----------|-------|
| Entiendes la pregunta | *"Great question. So..."* |
| Necesitas tiempo | *"That's a good point. Let me think about that..."* |
| No sabes la respuesta | *"Honestly, I'm not sure about that. Let me get back to you."* |
| La pregunta es fuera de alcance | *"That's a bit outside the scope of this talk, but I'm happy to discuss it afterwards."* |
| Quieres confirmar que entendiste | *"Just to make sure I understand your question..."* |
| Quieres redirigir | *"I think [colleague] might have better insight on that."* |

---

## Transiciones suaves

| De | A | Frase de transicion |
|----|---|---------------------|
| Intro | Problema | *"So, what's the problem we're trying to solve?"* |
| Problema | Solucion | *"Now, let me show you what we came up with."* |
| Solucion | Demo | *"Let me bring this to life with a demo."* |
| Demo | Resumen | *"So, to bring it all together..."* |
| Resumen | Q&A | *"That's the overview. I'd love to hear your thoughts."* |

---

## Errores comunes al presentar

| Error | Solucion |
|-------|----------|
| Leer las diapositivas palabra por palabra | Usa bullet points y habla naturalmente |
| Demasiado texto en diapositivas | Maximo 6 lineas por slide |
| No hacer contacto visual (virtual: no mirar la camara) | Mira a la camara, no a tu pantalla |
| Hablar demasiado rapido por nervios | Respira, haz pausas deliberadas |
| Disculparse por tu ingles | No te disculpes — presenta con confianza |
| No practicar la demo | Siempre prueba la demo antes |
| Ignorar el tiempo | Practica con cronometro |

---

## Consejo final

> La mejor forma de mejorar presentando en ingles es presentar en ingles. Empieza con presentaciones cortas en tu equipo (5 min de una herramienta, un pattern que aprendiste, una mejora que hiciste). Grabate, escuchate, mejora. La confianza viene con la practica, no con la perfeccion.
