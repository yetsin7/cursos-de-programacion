# Pull Request Language

## Vocabulario para Pull Requests y Code Reviews

Los Pull Requests (PRs) son el mecanismo principal para revisar y aprobar codigo
en equipos profesionales. Saber escribir y revisar PRs en ingles es una habilidad
esencial para cualquier desarrollador.

---

## Anatomia de un Pull Request

| Seccion | Significado |
|---------|-------------|
| **Title** | Titulo breve del cambio |
| **Description / Body** | Explicacion detallada |
| **Reviewers** | Personas que revisaran el codigo |
| **Assignees** | Personas responsables del PR |
| **Labels** | Etiquetas (bug, feature, etc.) |
| **Linked issues** | Issues relacionados |
| **Checks / CI** | Tests automaticos y validaciones |

---

## Escribir Titulos de PR

Los titulos deben ser breves y descriptivos, similares a los commit messages.

| Mal | Bien |
|-----|------|
| "Fix" | "Fix null pointer in user authentication" |
| "Update" | "Add dark mode toggle to settings page" |
| "Changes" | "Refactor payment service for better error handling" |
| "WIP stuff" | "feat: implement product search with filters" |

### Patrones comunes

```
feat: add user profile page
fix: resolve cart calculation bug for discounts
refactor: extract shared components from dashboard
docs: update API reference with new endpoints
chore: upgrade Flutter to 3.22
```

---

## Escribir Descripciones de PR

### Estructura recomendada

```markdown
## Summary
Brief description of what this PR does and why.

## Changes
- Added user profile page with avatar upload
- Created ProfileService for API calls
- Added unit tests for profile validation

## Screenshots
(If UI changes)

## How to Test
1. Check out this branch
2. Navigate to Settings > Profile
3. Upload an avatar image
4. Verify the image displays correctly

## Related Issues
Closes #234
```

### Frases utiles para descripciones

| Ingles | Uso |
|--------|-----|
| "This PR adds / implements / fixes..." | Describir el cambio principal |
| "Closes #123" / "Fixes #456" | Vincular a un issue |
| "This is a follow-up to #789." | Referencia a PR anterior |
| "No breaking changes." | Indicar que no rompe nada |
| "This requires a database migration." | Nota importante |
| "Ready for review." | Listo para revision |
| "Draft — still a work in progress." | PR en progreso |

---

## Vocabulario de Code Review

### Aprobacion y Comentarios

| Acronimo / Frase | Significado | Cuando usarlo |
|-------------------|-------------|---------------|
| **LGTM** | "Looks Good To Me" | Apruebas el codigo |
| **SGTM** | "Sounds Good To Me" | Estas de acuerdo con la propuesta |
| **Approved** | "Aprobado" | Aprobacion formal del PR |
| **Needs changes** | "Necesita cambios" | El codigo necesita modificaciones |
| **Nit** / **Nitpick** | Detalle menor, no bloquea | Sugerencia de estilo o formato |
| **Blocker** | Problema que impide aprobacion | Algo que debe corregirse |

---

### Frases Comunes en Reviews

#### Sugerencias (Suggestions)

| Frase | Significado |
|-------|-------------|
| "Could you refactor this into a separate function?" | "Podrias refactorizar esto en una funcion separada?" |
| "Consider using a `Map` instead of a `List` here." | "Considera usar un Map en vez de un List aqui." |
| "What do you think about extracting this into a utility?" | "Que opinas de extraer esto a un utilitario?" |
| "I'd suggest using a constant for this value." | "Sugiero usar una constante para este valor." |
| "This could be simplified using a ternary operator." | "Esto se podria simplificar con un operador ternario." |

#### Problemas (Issues)

| Frase | Significado |
|-------|-------------|
| "This might cause a regression in the login flow." | "Esto podria causar una regresion en el flujo de login." |
| "This will break if the list is empty." | "Esto se rompera si la lista esta vacia." |
| "There's a potential memory leak here." | "Hay un potencial memory leak aqui." |
| "This doesn't handle the null case." | "Esto no maneja el caso null." |
| "I think there's a race condition here." | "Creo que hay una race condition aqui." |

#### Pedir Tests

| Frase | Significado |
|-------|-------------|
| "Let's add a test for this edge case." | "Agreguemos un test para este caso limite." |
| "Can you add unit tests for the new service?" | "Puedes agregar tests unitarios para el nuevo servicio?" |
| "This change needs test coverage." | "Este cambio necesita cobertura de tests." |
| "The existing tests should be updated." | "Los tests existentes deberian actualizarse." |

#### Preguntas

| Frase | Significado |
|-------|-------------|
| "Why did you choose this approach?" | "Por que elegiste este enfoque?" |
| "Is this intentional?" | "Es esto intencional?" |
| "What happens if the user is not authenticated?" | "Que pasa si el usuario no esta autenticado?" |
| "Have you considered using X instead?" | "Has considerado usar X en su lugar?" |

#### Elogios

| Frase | Significado |
|-------|-------------|
| "Nice refactor!" | "Buen refactor!" |
| "Clean implementation." | "Implementacion limpia." |
| "Great test coverage." | "Excelente cobertura de tests." |
| "This is a nice improvement." | "Esta es una buena mejora." |

---

## Responder a Reviews

| Situacion | Frase |
|-----------|-------|
| Aceptar sugerencia | "Good point — I'll update this." |
| Explicar decision | "I chose this approach because..." |
| Pedir clarificacion | "Could you elaborate on what you mean?" |
| Indicar que hiciste el cambio | "Done." / "Fixed." / "Updated." |
| Estar en desacuerdo | "I see your point, but I think X is better because..." |
| Agradecer | "Thanks for the thorough review!" |

---

## Estados de un Pull Request

| Estado | Significado |
|--------|-------------|
| **Open** | PR abierto, esperando revision |
| **Draft** | PR en progreso, no listo para revision |
| **Approved** | Aprobado por los revisores |
| **Changes requested** | Se pidieron cambios |
| **Merged** | Fusionado en la rama destino |
| **Closed** | Cerrado sin fusionar |

### Frases sobre estados

- "The PR is **open** and **ready for review**." (El PR esta abierto y listo para revision.)
- "I marked it as a **draft** — it's not ready yet." (Lo marque como draft, aun no esta listo.)
- "The PR has been **approved** by two reviewers." (El PR fue aprobado por dos revisores.)
- "**Changes requested** — please address the comments." (Se pidieron cambios, por favor atiende los comentarios.)
- "The PR was **merged** into main." (El PR fue fusionado en main.)

---

## Frases para el Dia a Dia

| Ingles | Espaniol |
|--------|----------|
| "Can you review my PR?" | "Puedes revisar mi PR?" |
| "I left some comments on your PR." | "Deje algunos comentarios en tu PR." |
| "Approved with minor suggestions." | "Aprobado con sugerencias menores." |
| "Please rebase before I merge." | "Por favor rebasa antes de que fusione." |
| "I'll address your comments and push an update." | "Voy a atender tus comentarios y subir una actualizacion." |
| "The CI is failing — can you check?" | "El CI esta fallando, puedes verificar?" |
| "Let's squash the commits before merging." | "Hagamos squash de los commits antes de fusionar." |

---

## Resumen

- **Titulos de PR**: breves, descriptivos, en formato conventional commits
- **Descripciones**: summary, changes, how to test, related issues
- **Reviews**: LGTM, nit, blocker, needs changes, approved
- **Frases de review**: sugerencias, problemas, preguntas, elogios
- **Respuestas**: profesionales, concisas, agradecidas
