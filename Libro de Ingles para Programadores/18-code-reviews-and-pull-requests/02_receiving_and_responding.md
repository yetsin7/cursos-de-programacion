# Recibiendo y Respondiendo Feedback en Code Reviews

## Introducción

Saber recibir feedback es tan importante como saber darlo. En esta lección
aprenderás las frases en inglés para responder a comentarios de code review
de forma profesional: aceptando sugerencias, explicando tus decisiones y
manejando desacuerdos con respeto.

---

## Aceptando feedback

Estas frases muestran que valoras el feedback y estás dispuesto a mejorar.

| Frase | Traducción |
|-------|------------|
| Thanks for the feedback! | ¡Gracias por el feedback! |
| Good point, I'll update this. | Buen punto, voy a actualizarlo. |
| Great catch! Fixed. | ¡Buena captura! Corregido. |
| You're right, I missed that. | Tienes razón, se me pasó eso. |
| I agree, let me refactor this. | De acuerdo, déjame refactorizar esto. |
| Makes sense. Updated. | Tiene sentido. Actualizado. |
| Done! Thanks for catching that. | ¡Listo! Gracias por notarlo. |
| Good call. I've applied your suggestion. | Buena observación. Apliqué tu sugerencia. |
| Absolutely, that's much cleaner. | Absolutamente, eso es mucho más limpio. |

### Ejemplos en contexto

```
Reviewer: "Nit: This variable name could be more descriptive.
Maybe `activeUserCount` instead of `count`?"

Author: "Good point! Renamed to `activeUserCount`. Thanks!"
```

```
Reviewer: "This doesn't handle the case where the API returns
a 404. The app will crash."

Author: "Great catch! I added error handling for 404 and 500
responses. See the updated code."
```

```
Reviewer: "Consider using early return here to reduce nesting."

Author: "Makes sense. Refactored to use early returns. Much
more readable now. Thanks!"
```

---

## Pidiendo clarificación

Cuando no entiendes completamente el feedback, es profesional pedir más detalles.

| Frase | Traducción |
|-------|------------|
| Could you elaborate on...? | ¿Podrías elaborar sobre...? |
| Can you give me an example? | ¿Podrías darme un ejemplo? |
| I'm not sure I understand. Could you clarify? | No estoy seguro de entender. ¿Podrías clarificar? |
| Do you mean...? | ¿Te refieres a...? |
| What would you suggest instead? | ¿Qué sugerirías en su lugar? |
| Could you point me to a reference? | ¿Podrías indicarme una referencia? |
| Just to make sure I understand correctly... | Solo para asegurarme de que entiendo bien... |

### Ejemplos en contexto

```
Reviewer: "This could benefit from a more functional approach."

Author: "Could you elaborate on what you mean? Are you
suggesting using .map/.filter instead of the for loop,
or something else?"
```

```
Reviewer: "I'd consider using the Strategy pattern here."

Author: "That's interesting. Could you give me a quick
example of how you'd apply it in this context? I want
to make sure I implement it correctly."
```

---

## Explicando tus decisiones

A veces tu enfoque es correcto pero necesita explicación. Estas frases
te ayudan a justificar sin sonar defensivo.

| Frase | Traducción |
|-------|------------|
| I chose this approach because... | Elegí este enfoque porque... |
| The reason for this is... | La razón de esto es... |
| I went with X because... | Opté por X porque... |
| This was intentional because... | Esto fue intencional porque... |
| I considered that, but... | Lo consideré, pero... |
| There's a tradeoff here: ... | Hay un compromiso aquí: ... |
| The constraint here is... | La restricción aquí es... |
| I opted for simplicity over... | Opté por simplicidad sobre... |

### Ejemplos en contexto

```
Reviewer: "Why not use a Map here instead of an object?"

Author: "I chose an object because the keys are always
strings (user IDs from the API). A Map would add overhead
without benefit in this case. Also, JSON.stringify works
directly with objects but not with Maps, and we need
to cache this in localStorage."
```

```
Reviewer: "This seems like it could be a one-liner
with reduce."

Author: "I considered that, but I went with the for loop
for readability. The reduce version would be harder to
debug and understand for the team. I opted for clarity
over conciseness here."
```

---

## Manejando desacuerdos profesionalmente

Los desacuerdos son normales y saludables. La clave es mantener el
respeto y enfocarse en argumentos técnicos.

### Frases para discrepar respetuosamente

| Frase | Traducción |
|-------|------------|
| I see your point, but I think... because... | Entiendo tu punto, pero creo que... porque... |
| That's a valid concern. However... | Es una preocupación válida. Sin embargo... |
| I respectfully disagree because... | Respetuosamente discrepo porque... |
| I understand the suggestion, but in this case... | Entiendo la sugerencia, pero en este caso... |
| You raise a good point. Let me think about it. | Planteas un buen punto. Déjame pensarlo. |
| I'd like to keep it as is because... | Me gustaría mantenerlo así porque... |
| Let's discuss this offline/in a call. | Discutámoslo offline/en una llamada. |
| What if we compromise by...? | ¿Qué tal si hacemos un compromiso con...? |

### Ejemplos en contexto

```
Reviewer: "I'd strongly suggest using Redux here instead
of React Context."

Author: "I see your point about Redux being more scalable.
However, the state in this feature is local to this module
and only 3 components consume it. Context keeps things
simpler here without the Redux boilerplate. If the state
grows beyond this module, I agree we should migrate to Redux."
```

```
Reviewer: "This should use inheritance instead of composition."

Author: "That's a valid concern. However, I respectfully
disagree because composition gives us more flexibility here.
The components share behavior but not identity — they're not
'is-a' relationships. The React docs also recommend composition
over inheritance. Here's the reference: [link]"
```

```
Reviewer: "I think we need 100% test coverage for this module."

Author: "You raise a good point about test coverage. I'd like
to focus on testing the critical paths (validation, error handling)
rather than aiming for 100%. What if we compromise by covering
all public methods and edge cases, which gets us to about 85%?"
```

---

## Respondiendo a nits y sugerencias menores

Para comentarios pequeños, respuestas breves son perfectas.

| Comentario del reviewer | Respuesta apropiada |
|------------------------|---------------------|
| "Nit: typo on line 15" | "Fixed, thanks!" |
| "Nit: extra blank line" | "Removed. Good eye!" |
| "Minor: could use const here" | "Updated to const. 👍" |
| "Suggestion: rename to X" | "Renamed. Much clearer, thanks!" |
| "FYI: there's a built-in for this" | "Oh nice, I didn't know about that. Updated!" |

---

## Indicando que aplicaste los cambios

Después de hacer correcciones, informa al reviewer.

| Frase | Uso |
|-------|-----|
| "Done." / "Fixed." | Cambio simple aplicado |
| "Updated in the latest commit." | Cambio en un nuevo commit |
| "Addressed in [commit hash]." | Referencia específica al commit |
| "Applied your suggestion. PTAL." | PTAL = Please Take Another Look |
| "All comments addressed. Ready for re-review." | Todos los cambios hechos |
| "Resolved. Let me know if this looks good." | Cambio hecho, esperando aprobación |

### Ejemplo de respuesta completa

```
Thanks for the thorough review! I've addressed all comments:

- Renamed variables for clarity (commit abc123)
- Added error handling for the API call
- Extracted the validation logic into a utility function
- Fixed the typo in the comment

PTAL when you get a chance. Let me know if there's
anything else to update.
```

---

## Abreviaciones comunes en code reviews

| Abreviación | Significado | Traducción |
|-------------|-------------|------------|
| LGTM | Looks Good To Me | Se ve bien para mí |
| PTAL | Please Take Another Look | Por favor revisa de nuevo |
| SGTM | Sounds Good To Me | Me suena bien |
| WIP | Work In Progress | Trabajo en progreso |
| NIT | Nitpick (detalle menor) | Detalle pequeño |
| TL;DR | Too Long; Didn't Read | Muy largo; resumen: |
| IMO / IMHO | In My (Humble) Opinion | En mi (humilde) opinión |
| AFAIK | As Far As I Know | Hasta donde yo sé |
| FYI | For Your Information | Para tu información |
| ACK | Acknowledged | Entendido |

> **Consejo:** Cuando recibas feedback, asume siempre buena intención.
> Las palabras escritas pueden parecer más duras de lo que el autor
> pretendía. En caso de duda, pregunta para clarificar.
