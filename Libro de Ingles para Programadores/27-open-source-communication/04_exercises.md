# Exercises: Open Source Communication

## Ejercicio 1: Escribir un Bug Report

Imagina que encontraste un bug: cuando intentas subir una imagen mayor a 5MB en una libreria de procesamiento de imagenes, la aplicacion se congela sin mostrar un mensaje de error.

Escribe un bug report completo en ingles usando esta estructura:

```markdown
## Bug Report

### Description
___

### Steps to Reproduce
1. ___
2. ___
3. ___

### Expected Behavior
___

### Actual Behavior
___

### Environment
- OS: ___
- Node.js: ___
- Package version: ___

### Additional Context
___
```

---

## Ejercicio 2: Escribir un Feature Request

Quieres que una libreria de CLI agregue soporte para autocompletado con Tab. Escribe un feature request profesional en ingles.

```markdown
## Feature Request

### Is your feature request related to a problem?
___

### Describe the solution you'd like
___

### Describe alternatives you've considered
___

### Additional context
___
```

---

## Ejercicio 3: Responder como maintainer

Escribe respuestas profesionales en ingles para cada situacion:

1. **Un usuario reporta un bug con muy poca informacion:**
   "My app crashes when I click a button."

   Tu respuesta: ___

2. **Un usuario pide una feature que no piensas implementar:**
   "Please add jQuery support."

   Tu respuesta: ___

3. **Un usuario reporta un bug que ya fue arreglado en la ultima version:**

   Tu respuesta: ___

4. **Un contribuidor envia su primer PR con algunos problemas menores:**

   Tu respuesta: ___

5. **Un issue lleva 30 dias sin actividad del reporter:**

   Tu respuesta: ___

---

## Ejercicio 4: Labels

Asigna el label correcto a cada issue:

| Issue | Label |
|-------|-------|
| "The login page returns a 500 error" | ___ |
| "It would be nice to have a dark mode option" | ___ |
| "This is the same problem as #45" | ___ |
| "Add a typo fix in the README (2 lines)" | ___ |
| "How do I configure the cache timeout?" | ___ |
| "The team has decided not to support IE11" | ___ |
| "We need help implementing WebSocket support" | ___ |
| "SQL injection vulnerability in search endpoint" | ___ |

---

## Ejercicio 5: PR Description

Acabas de implementar un sistema de cache para una API. Escribe la descripcion del Pull Request en ingles:

```markdown
## Description
___

## Related Issue
___

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## How Has This Been Tested?
___

## Checklist
- [ ] My code follows the project's style guidelines
- [ ] I have added tests
- [ ] New and existing tests pass
- [ ] I have updated the documentation
```

---

## Ejercicio 6: Comunicacion profesional

Reescribe estos mensajes para que sean profesionales y constructivos:

1. **Original:** "This bug is ridiculous. How has nobody fixed this yet?"
   **Profesional:** ___

2. **Original:** "Your code review comments are wrong."
   **Profesional:** ___

3. **Original:** "Why is this project so slow? It takes forever to build."
   **Profesional:** ___

4. **Original:** "I need this feature NOW. When will it be ready?"
   **Profesional:** ___

5. **Original:** "This PR is a mess. Start over."
   **Profesional:** ___

---

## Ejercicio 7: Titulos de issues

Mejora estos titulos de issues:

| Titulo original | Titulo mejorado |
|----------------|-----------------|
| "Bug" | ___ |
| "Help" | ___ |
| "Not working" | ___ |
| "Error" | ___ |
| "Feature" | ___ |
| "Slow" | ___ |
| "Crash" | ___ |
| "Please fix" | ___ |

---

## Ejercicio 8: Triaje de issues

Eres el maintainer de un proyecto. Tienes estos 6 issues nuevos. Ordenalos por prioridad y explica por que:

1. "SQL injection vulnerability in the user search endpoint"
2. "Add support for dark mode in the dashboard"
3. "Typo in README: 'recieve' should be 'receive'"
4. "Application crashes when uploading files larger than 100MB"
5. "Feature request: export data to CSV"
6. "Login fails for users with non-ASCII characters in password"

| Prioridad | Issue # | Justificacion |
|-----------|---------|---------------|
| 1 (mas alta) | ___ | ___ |
| 2 | ___ | ___ |
| 3 | ___ | ___ |
| 4 | ___ | ___ |
| 5 | ___ | ___ |
| 6 (mas baja) | ___ | ___ |

---

## Respuestas

<details>
<summary>Click para ver las respuestas</summary>

**Ejercicio 4 - Labels:**
1. `bug`
2. `enhancement`
3. `duplicate`
4. `good first issue`
5. `question`
6. `wontfix`
7. `help wanted`
8. `security`, `priority: high`

**Ejercicio 6 - Comunicacion profesional:**
1. "I've encountered this bug and it's significantly impacting my workflow. Is there an ETA for a fix, or can I help work on it?"
2. "I appreciate the review feedback. I have a different perspective on points 2 and 3 — could we discuss the trade-offs?"
3. "I've noticed the build times are quite long in my setup. Are there any recommended optimizations or configuration changes?"
4. "This feature would be very helpful for my use case. Is it on the roadmap? I'd be happy to contribute if that would help."
5. "Thanks for the PR! There are several areas that need attention. I've left detailed comments inline — please take a look and let me know if you have questions."

**Ejercicio 8 - Triaje:**
1. Issue 1 (SQL injection) - Vulnerabilidad de seguridad critica
2. Issue 6 (Login non-ASCII) - Bug que impide uso basico para algunos usuarios
3. Issue 4 (Crash large files) - Bug con crash de la aplicacion
4. Issue 5 (Export CSV) - Feature request util
5. Issue 2 (Dark mode) - Enhancement estetico, no critico
6. Issue 3 (Typo README) - Cambio minimo, baja prioridad

</details>
