# Lesson 03: Maintaining Open Source Projects

## Introduccion

Cuando mantienes un proyecto open source, tu comunicacion en ingles debe ser clara, profesional y empatica. Responderas a issues, revisaras PRs y tomaras decisiones que afectan a toda la comunidad. Esta leccion te ensenara las frases y patrones para hacerlo correctamente.

---

## Respondiendo a issues

### Agradeciendo el reporte

Siempre empieza agradeciendo. Los usuarios invierten tiempo en reportar problemas.

| Frase | Situacion |
|-------|-----------|
| "Thanks for reporting this!" | Reporte de bug |
| "Thank you for the detailed report." | Reporte bien escrito |
| "Thanks for bringing this to our attention." | Problema importante |
| "Appreciate you taking the time to file this." | Cualquier issue |
| "Thanks for the feature suggestion!" | Feature request |
| "Great catch! Thanks for spotting this." | Bug obvio que nadie vio |

### Pidiendo mas informacion

| Frase | Que necesitas |
|-------|---------------|
| "Could you provide more details about your environment?" | Informacion del sistema |
| "Can you share the full error message/stack trace?" | Logs completos |
| "Is this reproducible? If so, what are the steps?" | Pasos para reproducir |
| "Could you provide a minimal reproduction?" | Ejemplo minimo |
| "What version of the library are you using?" | Version especifica |
| "Does this happen consistently or intermittently?" | Frecuencia del bug |
| "Have you tried with the latest version?" | Verificar version actual |
| "Could you share your configuration file?" | Configuracion |

### Reconociendo problemas conocidos

| Frase | Situacion |
|-------|-----------|
| "This is a known issue." | Bug ya reportado |
| "We're aware of this problem and working on a fix." | En progreso |
| "This is tracked in #234." | Ya existe un issue |
| "This is a duplicate of #567. Closing in favor of that issue." | Duplicado |
| "This was introduced in v2.3 and we're investigating." | Regresion identificada |
| "This is expected behavior." | No es un bug |

### Explicando decisiones

| Frase | Situacion |
|-------|-----------|
| "We've decided not to implement this because..." | Rechazar feature request |
| "This doesn't align with the project's goals." | Fuera del scope |
| "The complexity outweighs the benefit in this case." | Muy complejo para el valor que aporta |
| "We'd prefer to keep the API surface small." | Mantener la API simple |
| "This would introduce a breaking change that we want to avoid." | Evitar breaking changes |
| "We're open to this, but it's not a priority right now." | Aceptado pero no urgente |
| "This is out of scope for this project, but X might help." | Redirigir a otro proyecto |

---

## Anunciando fixes y releases

| Frase | Situacion |
|-------|-----------|
| "This has been fixed in v2.1." | Bug corregido |
| "A fix has been merged and will be in the next release." | Fix en la proxima version |
| "This is now available in v3.0.0-beta.1." | Disponible en beta |
| "The fix has been backported to v2.x." | Fix portado a version anterior |
| "Please update to the latest version to get this fix." | Pedir actualizacion |
| "Closing as resolved. Please reopen if the issue persists." | Cerrar issue |

---

## Triaging issues (Clasificando issues)

El triaje es el proceso de revisar, clasificar y priorizar issues nuevos.

### Proceso de triaje

| Paso | Accion en ingles | Descripcion |
|------|-----------------|-------------|
| 1 | **Read and understand** | Lee el issue completo |
| 2 | **Check for duplicates** | Busca si ya existe |
| 3 | **Verify the report** | Intenta reproducir el bug |
| 4 | **Label appropriately** | Agrega labels correctos |
| 5 | **Assign priority** | Asigna prioridad |
| 6 | **Assign to milestone** | Asigna a un milestone si aplica |
| 7 | **Respond** | Responde al reporter |

### Frases para el triaje

```markdown
<!-- Necesitas mas info -->
@user Thanks for the report! Could you provide a bit more 
context? Specifically:
- What version are you using?
- What OS/browser?
- Can you share the steps to reproduce?

Labeling as `needs-info` for now.

<!-- Confirmando el bug -->
I've been able to reproduce this. Labeling as `confirmed` 
and adding to the v2.2 milestone.

<!-- Cerrando como duplicado -->
This is a duplicate of #123. The discussion and progress 
are tracked there. Closing this one — please follow #123 
for updates.

<!-- Cerrando como wontfix -->
Thanks for the suggestion. After discussion, we've decided 
not to pursue this direction because it would significantly 
increase the bundle size for a feature that benefits a small 
subset of users. Closing as `wontfix`.

Feel free to reopen if you have additional arguments we 
haven't considered.
```

---

## Milestones y Roadmap

| Termino | Significado |
|---------|-------------|
| **Milestone** | Conjunto de issues agrupados para una version |
| **Roadmap** | Plan a largo plazo del proyecto |
| **Backlog** | Lista de tareas pendientes |
| **Sprint** | Periodo de trabajo enfocado |
| **Release** | Publicacion de una version |
| **Hotfix** | Correccion urgente fuera del ciclo normal |

### Frases sobre planificacion

| Frase | Significado |
|-------|-------------|
| "This is planned for the v3.0 milestone." | Planificado para v3.0 |
| "Moving this to the backlog." | Agregado a la lista de pendientes |
| "This is on our roadmap for Q2." | En el plan para el segundo trimestre |
| "We'll revisit this after the v2.0 release." | Lo revisaremos despues de v2.0 |
| "This is a stretch goal for this sprint." | Objetivo ambicioso del sprint |

---

## Revisando Pull Requests como maintainer

### Aprobando PRs

| Frase | Situacion |
|-------|-----------|
| "LGTM! (Looks Good To Me)" | Aprobacion rapida |
| "Great work! This is ready to merge." | Aprobacion entusiasta |
| "Thanks for the contribution! Merging now." | Agradecimiento al merge |
| "Clean implementation. Well done!" | Elogiar la calidad |
| "Nice catch on the edge case handling." | Elogiar un detalle especifico |

### Pidiendo cambios

| Frase | Situacion |
|-------|-----------|
| "Could you add tests for this change?" | Faltan tests |
| "This needs a minor refactor — see my inline comments." | Necesita ajustes |
| "Please update the documentation to reflect this change." | Falta actualizar docs |
| "Could you squash these commits into one?" | Muchos commits |
| "There's a small issue with the error handling here." | Problema especifico |
| "I'd suggest a different approach here. What do you think about...?" | Sugerir alternativa |

### Rechazando PRs

| Frase | Situacion |
|-------|-----------|
| "Thanks for the effort, but this doesn't align with..." | No encaja con el proyecto |
| "We've decided to go in a different direction." | Enfoque diferente |
| "This PR has been open for a while without updates. Closing for now." | PR abandonado |
| "Feel free to reopen once the requested changes are made." | Cerrar con opcion de reabrir |

---

## Comunicacion en Discussions y Community

### GitHub Discussions

| Categoria | Uso |
|-----------|-----|
| **Announcements** | Anuncios del equipo del proyecto |
| **General** | Conversacion general |
| **Ideas** | Propuestas de nuevas funcionalidades |
| **Q&A** | Preguntas y respuestas |
| **Show and Tell** | Compartir proyectos hechos con la libreria |

### Frases para Discussions

| Frase | Uso |
|-------|-----|
| "We're excited to announce..." | Anunciar algo nuevo |
| "We'd love to hear your feedback on..." | Pedir feedback |
| "What are your thoughts on...?" | Iniciar discusion |
| "Thanks for sharing! This is a great use case." | Responder a Show and Tell |
| "This question is better suited for Stack Overflow." | Redirigir preguntas |

---

## Release Notes como maintainer

### Ejemplo de release notes

```markdown
# v2.1.0 Release Notes

We're happy to announce v2.1.0! This release includes several 
community-requested features and important bug fixes.

## What's New
- **Streaming API** (#234): Real-time data streaming is now 
  supported. Thanks @contributor1!
- **Dark Mode** (#256): Added dark mode to the admin panel.

## Bug Fixes
- Fixed #189: Memory leak in WebSocket handler
- Fixed #201: Incorrect timezone in exported reports

## Breaking Changes
None in this release.

## Upgrade Guide
Simply update your dependency:
npm install mypackage@2.1.0

## Contributors
A huge thanks to everyone who contributed to this release:
@contributor1, @contributor2, @contributor3
```

---

## Vocabulario esencial para maintainers

| Termino | Significado |
|---------|-------------|
| **Triage** | Clasificar y priorizar issues |
| **Ship** | Publicar, lanzar una version |
| **Land** | Fusionar un PR ("land a PR") |
| **Cherry-pick** | Seleccionar un commit especifico |
| **Backport** | Portar un fix a una version anterior |
| **Release train** | Ciclo regular de releases |
| **Feature freeze** | Periodo donde no se agregan features |
| **Code freeze** | Periodo donde no se modifica el codigo |
| **Rollback** | Revertir un cambio en produccion |
| **Dogfooding** | Usar tu propio producto internamente |

---

## Resumen

- Siempre agradece los reportes y las contribuciones
- Pide informacion adicional de forma especifica y amable
- Se transparente sobre las decisiones del proyecto
- Usa labels y milestones para organizar el trabajo
- Revisa PRs con feedback constructivo y especifico
- Escribe release notes claras que ayuden a los usuarios a actualizar
