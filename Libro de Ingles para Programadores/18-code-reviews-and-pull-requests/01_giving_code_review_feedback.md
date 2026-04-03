# Dando Feedback en Code Reviews

## Introducción

El code review es una de las actividades más importantes en el desarrollo
de software. Saber dar feedback en inglés de forma **constructiva, clara
y respetuosa** es fundamental para trabajar en equipos internacionales.

---

## Niveles de feedback

No todos los comentarios tienen la misma importancia. Es convención usar
prefijos para indicar la severidad.

| Prefijo | Significado | ¿Bloquea el merge? |
|---------|-------------|---------------------|
| **Blocker:** | Problema crítico que debe corregirse | Sí |
| **Major:** | Problema importante | Sí |
| **Minor:** | Mejora sugerida, no crítica | No |
| **Nit:** (nitpick) | Detalle muy pequeño (formato, estilo) | No |
| **Question:** | Pregunta para entender mejor | No |
| **Suggestion:** | Propuesta alternativa | No |
| **Thought:** | Reflexión, no requiere acción | No |
| **FYI:** | Información para el autor | No |
| **Praise:** | Elogio, reconocimiento | No |

### Ejemplos

```
Blocker: This SQL query is vulnerable to injection.
We need to use parameterized queries.

Major: This function doesn't handle the case where
the user is null, which will cause a runtime error.

Minor: Consider extracting this logic into a separate
utility function for reusability.

Nit: Missing semicolon on line 42.

Question: What's the reason for using a Map here
instead of a plain object?
```

---

## Frases para sugerir cambios (tono amable)

En inglés profesional, las sugerencias se hacen de forma **indirecta y
respetuosa**, no como órdenes directas.

### Sugerencias suaves

| Frase | Traducción |
|-------|------------|
| Could we consider...? | ¿Podríamos considerar...? |
| What do you think about...? | ¿Qué opinas de...? |
| I'd suggest... | Yo sugeriría... |
| Have you considered...? | ¿Has considerado...? |
| It might be worth... | Podría valer la pena... |
| One option would be to... | Una opción sería... |
| Would it make sense to...? | ¿Tendría sentido...? |
| How about...? | ¿Qué tal si...? |

### Ejemplos en contexto

```
"Could we consider using a Map instead of an object here?
It would give us better performance for frequent lookups."

"What do you think about extracting this into a custom hook?
It's used in three different components."

"I'd suggest adding a try-catch block here. If the API call
fails, the app will crash without error handling."

"Have you considered using Optional chaining (user?.name)
instead of the manual null check?"

"It might be worth adding an index to this column.
The query scans the full table without it."
```

---

## Frases para señalar problemas

### Problemas potenciales

| Frase | Traducción |
|-------|------------|
| This could potentially cause... | Esto podría causar... |
| This might lead to... | Esto podría llevar a... |
| I'm a bit concerned about... | Me preocupa un poco... |
| This looks like it could be... | Esto parece que podría ser... |
| There's a risk of... | Hay riesgo de... |
| This doesn't account for... | Esto no contempla... |

### Problemas claros

| Frase | Traducción |
|-------|------------|
| This will cause... | Esto causará... |
| This breaks when... | Esto falla cuando... |
| This is missing... | Falta... |
| This doesn't handle... | Esto no maneja... |
| There's a bug here: | Hay un bug aquí: |

### Ejemplos

```
"This could potentially cause a memory leak if the event
listener is never removed."

"I'm a bit concerned about the performance here. This runs
a database query inside a loop."

"This doesn't handle the case where the array is empty.
It will throw a TypeError."

"There's a bug here: the comparison should be === instead
of == to avoid type coercion issues."
```

---

## Frases para elogiar buen código

El feedback positivo es tan importante como el constructivo.

| Frase | Traducción |
|-------|------------|
| Nice approach! | ¡Buen enfoque! |
| Clean solution! | ¡Solución limpia! |
| Great catch! | ¡Buena captura! |
| Well thought out! | ¡Bien pensado! |
| Love this pattern! | ¡Me encanta este patrón! |
| This is elegant. | Esto es elegante. |
| Good use of... | Buen uso de... |
| TIL (Today I Learned)... | Hoy aprendí... |
| Smart! | ¡Inteligente! |
| This reads really well. | Esto se lee muy bien. |

### Ejemplos

```
"Nice approach! Using a discriminated union here makes
the type checking much more robust."

"Clean solution! I like how you separated the validation
logic from the controller."

"Great catch! I didn't notice the potential race condition."

"TIL about this Array method. Thanks for using it here!"

"Good use of the Builder pattern. It makes the test setup
much more readable."
```

---

## Pidiendo cambios específicos

### Con código sugerido

```
"Instead of:
  if (user !== null && user !== undefined)

Consider:
  if (user != null)

This handles both null and undefined in one check."
```

### Con explicación

```
"I'd recommend using `Promise.all` here instead of
awaiting each call sequentially. This will make the
three API calls run in parallel, reducing the total
response time from ~3s to ~1s."
```

---

## Frases para pedir contexto

| Frase | Traducción |
|-------|------------|
| Could you explain why...? | ¿Podrías explicar por qué...? |
| I'm curious about... | Tengo curiosidad sobre... |
| What's the reasoning behind...? | ¿Cuál es el razonamiento detrás de...? |
| Is there a specific reason for...? | ¿Hay una razón específica para...? |
| Can you walk me through this? | ¿Puedes guiarme por esto? |
| I'm not sure I follow this part. | No estoy seguro de entender esta parte. |

### Ejemplos

```
"Could you explain why we're using a setTimeout here?
Is this a workaround for a specific issue?"

"What's the reasoning behind using a class instead of
a function component? Is there a lifecycle method we need?"

"I'm not sure I follow this regex. Could you add a
comment explaining what it matches?"
```

---

## Tono: Lo que hay que evitar

| Evitar (agresivo/condescendiente) | Preferir (profesional) |
|----------------------------------|----------------------|
| "This is wrong." | "I think there might be an issue here." |
| "Why did you do this?" | "What's the reasoning behind this approach?" |
| "This doesn't make sense." | "I'm not sure I follow this part." |
| "Just use X." | "Have you considered using X?" |
| "Obviously you should..." | "It might be worth considering..." |
| "This is bad practice." | "The recommended practice here would be..." |

> **Regla de oro:** Comenta sobre el **código**, no sobre la **persona**.
> Di "This function could be simplified" en lugar de "You wrote this poorly".

---

## Resumen: Estructura de un buen comentario de review

```
1. [Prefijo de severidad]
2. [Descripción del problema o sugerencia]
3. [Explicación del por qué]
4. [Alternativa sugerida (opcional)]
```

Ejemplo completo:

```
Minor: Consider using `useMemo` for this computed value.

Since `filteredUsers` depends on `users` and `searchQuery`,
recalculating it on every render could be expensive with
large datasets.

Suggestion:
  const filteredUsers = useMemo(
    () => users.filter(u => u.name.includes(searchQuery)),
    [users, searchQuery]
  );
```
