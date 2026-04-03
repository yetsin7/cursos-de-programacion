# Lesson 02: Issue Reporting

## Introduccion

Reportar issues (problemas) en GitHub es una habilidad que todo programador necesita. Un buen reporte de bug ahorra tiempo a todos: al maintainer, a otros desarrolladores y a ti mismo. En esta leccion aprenderas el vocabulario, la estructura y el tono profesional para escribir issues efectivos en ingles.

---

## Tipos de issues

| Tipo | Label en GitHub | Descripcion |
|------|----------------|-------------|
| **Bug report** | `bug` | Algo no funciona como deberia |
| **Feature request** | `enhancement` | Solicitud de nueva funcionalidad |
| **Question** | `question` | Duda sobre el uso del proyecto |
| **Documentation** | `documentation` | Mejora o correccion de docs |
| **Performance** | `performance` | Problema de rendimiento |
| **Security** | `security` | Vulnerabilidad de seguridad |

---

## Labels comunes en GitHub

| Label | Significado | Cuando se usa |
|-------|-------------|---------------|
| `bug` | Bug confirmado | El problema fue verificado |
| `enhancement` | Mejora | Solicitud de nueva funcionalidad |
| `good first issue` | Buen primer issue | Ideal para nuevos contribuidores |
| `help wanted` | Se necesita ayuda | El equipo necesita contribuidores |
| `wontfix` | No se arreglara | Decision de no implementar/arreglar |
| `duplicate` | Duplicado | Ya existe otro issue igual |
| `invalid` | Invalido | No es un issue real del proyecto |
| `priority: high` | Prioridad alta | Necesita atencion urgente |
| `priority: low` | Prioridad baja | Puede esperar |
| `blocked` | Bloqueado | Depende de otro issue o PR |
| `stale` | Inactivo | Sin actividad por mucho tiempo |
| `needs-triage` | Necesita triaje | Aun no ha sido revisado |
| `confirmed` | Confirmado | El problema fue reproducido |
| `in-progress` | En progreso | Alguien esta trabajando en esto |

---

## Estructura de un Bug Report

### Plantilla estandar

```markdown
## Bug Report

### Description
A clear and concise description of the bug.

### Steps to Reproduce
1. Go to the settings page
2. Click on "Change password"
3. Enter a new password with special characters
4. Click "Save"

### Expected Behavior
The password should be updated successfully and a confirmation
message should appear.

### Actual Behavior
The page shows a 500 Internal Server Error and the password
is not updated.

### Environment
- OS: Windows 11
- Browser: Chrome 120.0
- Node.js: v20.10.0
- Package version: 3.2.1

### Screenshots
[If applicable, add screenshots]

### Additional Context
This only happens when the password contains the character "&".
Passwords without special characters work fine.
```

### Vocabulario clave del bug report

| Seccion | Significado | Consejo |
|---------|-------------|---------|
| **Steps to Reproduce** | Pasos para reproducir | Se lo mas especifico posible |
| **Expected Behavior** | Comportamiento esperado | Que deberia pasar |
| **Actual Behavior** | Comportamiento actual | Que esta pasando en realidad |
| **Environment** | Entorno | OS, navegador, versiones |
| **Screenshots** | Capturas de pantalla | Evidencia visual |
| **Additional Context** | Contexto adicional | Cualquier informacion extra util |
| **Minimal Reproduction** | Reproduccion minima | El caso mas simple que muestra el bug |
| **Logs** | Registros | Mensajes de la consola o del servidor |

---

## Estructura de un Feature Request

```markdown
## Feature Request

### Is your feature request related to a problem?
I'm always frustrated when I have to manually restart the dev
server after changing the configuration file.

### Describe the solution you'd like
I'd like the dev server to automatically detect changes in the
config file and restart without manual intervention.

### Describe alternatives you've considered
I've tried using `nodemon` to watch the config file, but it
restarts the entire process which is slow.

### Additional context
Vite and Next.js both support this feature. It would bring us
in line with other modern dev tools.
```

### Frases utiles para feature requests

| Frase | Cuando usarla |
|-------|---------------|
| "It would be great if..." | Sugerir amablemente una funcionalidad |
| "Have you considered adding...?" | Preguntar si lo han considerado |
| "This would help with..." | Explicar el beneficio |
| "I'd be happy to work on this." | Ofrecer implementarlo tu mismo |
| "Is this something you'd accept a PR for?" | Preguntar si aceptarian un PR |
| "This is a common request in..." | Validar con otros usuarios |
| "Similar tools like X support this." | Comparar con la competencia |

---

## Tono profesional en issues

### Bien (profesional y constructivo)

```markdown
**Title:** Password reset fails when email contains a plus sign

I noticed that the password reset flow doesn't work for email 
addresses that contain a "+" character (e.g., user+tag@email.com).

**Steps to reproduce:**
1. Enter "user+test@gmail.com" in the reset password form
2. Click "Send reset link"
3. Error: "Invalid email address"

This seems to be a validation issue. The "+" is a valid character 
in email addresses per RFC 5321.

I'd be happy to submit a PR if you can point me to the relevant 
validation code.
```

### Mal (vago, demandante o agresivo)

```markdown
**Title:** IT'S BROKEN!!!

Nothing works. I tried everything and it keeps crashing.
Fix this ASAP. This is unacceptable for a project with
10k stars.
```

### Reglas de tono

| Hacer | No hacer |
|-------|----------|
| Se especifico y detallado | No seas vago ("it doesn't work") |
| Incluye pasos para reproducir | No asumas que es obvio |
| Agradece el trabajo del equipo | No demandes soluciones inmediatas |
| Ofrece ayuda si puedes | No critiques destructivamente |
| Usa un titulo descriptivo | No uses titulos como "BUG!!!" |
| Reporta hechos objetivos | No exageres el problema |

---

## Frases comunes al interactuar en issues

### Reportando

| Frase | Uso |
|-------|-----|
| "I'm experiencing an issue with..." | Describir el problema |
| "I can consistently reproduce this by..." | Indicar que es reproducible |
| "This started happening after updating to v..." | Indicar cuando empezo |
| "Here's a minimal reproduction:" | Compartir un caso minimo |
| "I've searched existing issues and didn't find a duplicate." | Mostrar que buscaste |
| "Please let me know if you need more information." | Ofrecer mas detalles |

### Respondiendo a preguntas

| Frase | Uso |
|-------|-----|
| "Here are the logs you requested:" | Proveer informacion pedida |
| "I've tested with the latest version and the issue persists." | Confirmar en version actual |
| "I can confirm this also happens on..." | Confirmar en otro entorno |
| "The workaround suggested in #123 works for me." | Confirmar un workaround |
| "I'm still experiencing this issue." | Indicar que sigue sin resolverse |

### Cerrando issues

| Frase | Uso |
|-------|-----|
| "This was resolved by updating to v3.1." | El update lo arreglo |
| "Closing as this was user error on my end." | Fue error tuyo |
| "This can be closed. The fix in #456 resolved it." | Un PR lo arreglo |
| "No longer relevant after the v4 migration." | Ya no aplica |

---

## Escribiendo buenos titulos de issues

### Formula para titulos efectivos

```
[Componente/Area] Accion que falla + Contexto
```

| Titulo malo | Titulo bueno |
|-------------|-------------|
| "Bug" | "Login fails with OAuth when using Firefox" |
| "Not working" | "CSV export generates empty file for large datasets" |
| "Help needed" | "How to configure custom middleware in v3?" |
| "Feature" | "Add dark mode support to the admin dashboard" |
| "Error" | "TypeError when calling `parse()` with null input" |
| "Slow" | "API response time exceeds 10s for paginated queries" |

---

## Providing a Minimal Reproduction

Una "minimal reproduction" es el ejemplo mas simple posible que demuestra el bug. Es lo mas valioso que puedes incluir en un bug report.

```markdown
### Minimal Reproduction

Repository: https://github.com/myuser/bug-repro-123

```bash
git clone https://github.com/myuser/bug-repro-123
cd bug-repro-123
npm install
npm run dev
# Navigate to http://localhost:3000/settings
# Click "Save" without making changes
# See error in console
```

Alternatively, here's a CodeSandbox:
https://codesandbox.io/s/bug-repro-abc123
```

---

## Vocabulario esencial

| Termino | Significado |
|---------|-------------|
| **Regression** | Bug que aparece despues de un cambio que antes funcionaba |
| **Edge case** | Caso limite, situacion poco comun |
| **Workaround** | Solucion temporal |
| **Root cause** | Causa raiz del problema |
| **Flaky** | Que a veces funciona y a veces no (intermitente) |
| **Blocker** | Problema que impide continuar |
| **Severity** | Gravedad del problema |
| **Triage** | Proceso de clasificar y priorizar issues |
| **Repro** | Abreviatura de "reproduction" |
| **Stack trace** | Traza de la pila de ejecucion |

---

## Resumen

- Los bug reports deben incluir: descripcion, pasos para reproducir, comportamiento esperado vs actual, y entorno
- Los feature requests deben explicar el problema, la solucion propuesta y alternativas consideradas
- Usa un tono profesional, constructivo y respetuoso
- Incluye una minimal reproduction siempre que sea posible
- Busca issues duplicados antes de crear uno nuevo
- Ofrece ayuda: los maintainers aprecian a quienes resuelven, no solo reportan
