# Lesson 01: Contributing to Open Source Projects

## Introduccion

Contribuir a proyectos open source es una de las mejores formas de mejorar como programador y construir tu reputacion profesional. Toda la comunicacion ocurre en ingles, asi que dominar las frases y convenciones correctas es fundamental.

---

## Leyendo CONTRIBUTING.md

Antes de contribuir a cualquier proyecto, **siempre** lee el archivo CONTRIBUTING.md. Este documento te dice exactamente como el proyecto espera recibir contribuciones.

### Secciones tipicas de CONTRIBUTING.md

| Seccion | Que te dice |
|---------|-------------|
| **Code of Conduct** | Reglas de comportamiento en la comunidad |
| **How to Contribute** | Pasos para contribuir |
| **Development Setup** | Como configurar el entorno de desarrollo |
| **Coding Standards** | Estilo de codigo que debes seguir |
| **Commit Message Format** | Formato para mensajes de commit |
| **Pull Request Process** | Como enviar un pull request |
| **Issue Templates** | Plantillas para reportar bugs o pedir features |
| **Branch Naming** | Convencion para nombrar ramas |
| **Testing Requirements** | Que tests debes incluir |
| **License** | Bajo que licencia contribuyes |

### Ejemplo de CONTRIBUTING.md

```markdown
# Contributing to ProjectX

Thank you for your interest in contributing to ProjectX! 

## Getting Started

1. Fork the repository
2. Clone your fork locally
3. Create a new branch for your feature
4. Make your changes
5. Write or update tests as needed
6. Submit a pull request

## Development Setup

npm install
npm run dev

## Coding Standards

- Use ESLint with our provided configuration
- Write tests for all new features
- Keep functions under 30 lines
- Use meaningful variable names

## Commit Messages

We follow Conventional Commits:
- feat: new feature
- fix: bug fix
- docs: documentation only
- test: adding tests
```

---

## El flujo de contribucion (Contribution Workflow)

### Paso 1: Fork y Clone

```bash
# Fork en GitHub (boton "Fork" en la interfaz)

# Clone tu fork
git clone https://github.com/YOUR_USERNAME/project.git
cd project

# Agrega el repositorio original como "upstream"
git remote add upstream https://github.com/ORIGINAL_OWNER/project.git
```

### Paso 2: Crear una rama (Branch)

```bash
# Actualiza tu rama principal
git fetch upstream
git checkout main
git merge upstream/main

# Crea una rama para tu contribucion
git checkout -b feat/add-dark-mode
```

### Paso 3: Hacer cambios y commit

```bash
git add .
git commit -m "feat: add dark mode toggle to settings page"
```

### Paso 4: Push y Pull Request

```bash
git push origin feat/add-dark-mode
# Luego ve a GitHub y crea el Pull Request
```

---

## Frases para comunicarte en proyectos open source

### Expresar interes en contribuir

| Frase en ingles | Cuando usarla |
|-----------------|---------------|
| "I'd like to contribute to this project." | Primer contacto con el proyecto |
| "Is this issue still open?" | Verificar si alguien ya esta trabajando en algo |
| "I'd like to take this on." | Quieres asignarte un issue |
| "Can I work on this?" | Pedir permiso para trabajar en un issue |
| "I'm a first-time contributor." | Indicar que eres nuevo en el proyecto |
| "I've read the contributing guide." | Mostrar que hiciste tu tarea |
| "Here's my proposed approach." | Presentar tu plan antes de codear |
| "Would this approach be acceptable?" | Pedir feedback sobre tu solucion |

### Describir tu contribucion

| Frase en ingles | Cuando usarla |
|-----------------|---------------|
| "This PR adds support for..." | Describir que agrega tu PR |
| "This fixes the issue where..." | Explicar que bug corrige |
| "I've added tests to cover..." | Mencionar los tests que incluiste |
| "This is a draft PR for early feedback." | PR incompleto para recibir feedback |
| "Ready for review." | Tu PR esta listo para revision |
| "I've addressed all the review comments." | Respondiste a todos los comentarios |
| "Let me know if you'd like any changes." | Ofrecer disposicion a hacer cambios |
| "Happy to make adjustments." | Lo mismo, tono mas amigable |

### Preguntar y pedir ayuda

| Frase en ingles | Cuando usarla |
|-----------------|---------------|
| "Could you point me to the right file?" | No encuentras donde hacer el cambio |
| "I'm not sure about the best approach here." | Necesitas orientacion |
| "Is there a preferred way to handle this?" | Preguntar por convenciones |
| "I ran into an issue while setting up." | Problemas con el entorno |
| "The tests are failing on my end. Any ideas?" | Tests que no pasan |
| "Am I on the right track?" | Verificar que vas bien |

---

## Code of Conduct (Codigo de Conducta)

La mayoria de proyectos open source tienen un Codigo de Conducta. Estas son las reglas basicas de comportamiento.

### Frases comunes en Codes of Conduct

| Frase | Significado |
|-------|-------------|
| "Be respectful and inclusive" | Se respetuoso e inclusivo |
| "Harassment of any kind will not be tolerated" | El acoso no sera tolerado |
| "Constructive feedback is welcome" | Feedback constructivo es bienvenido |
| "Assume good intentions" | Asume buenas intenciones |
| "Be patient with newcomers" | Ten paciencia con los nuevos |
| "Focus on the code, not the person" | Enfocate en el codigo, no en la persona |
| "Report violations to..." | Reporta violaciones a... |

### Comportamiento profesional en ingles

**Bien:**
```
"I think there might be a more efficient approach here. 
What if we used a hash map instead of an array?"
```

**Mal:**
```
"This code is terrible. Why would anyone do it this way?"
```

**Bien:**
```
"Thanks for the suggestion! I see your point about 
performance. Let me refactor this."
```

**Mal:**
```
"That's wrong. My approach is better."
```

---

## Plantillas de Pull Request

### PR Template basico

```markdown
## Description
Brief description of what this PR does.

## Related Issue
Closes #123

## Type of Change
- [ ] Bug fix (non-breaking change that fixes an issue)
- [ ] New feature (non-breaking change that adds functionality)
- [ ] Breaking change (fix or feature that would cause existing
      functionality to not work as expected)
- [ ] Documentation update

## How Has This Been Tested?
Describe the tests you ran.

## Checklist
- [ ] My code follows the project's style guidelines
- [ ] I have performed a self-review of my code
- [ ] I have commented my code where necessary
- [ ] I have added tests that prove my fix/feature works
- [ ] New and existing tests pass locally
- [ ] I have updated the documentation accordingly
```

### Ejemplo de PR bien escrito

```markdown
## Description
Add dark mode toggle to the settings page. Users can now switch
between light and dark themes. The preference is persisted in
localStorage.

## Related Issue
Closes #456

## Type of Change
- [ ] Bug fix
- [x] New feature
- [ ] Breaking change
- [ ] Documentation update

## How Has This Been Tested?
- Unit tests for the theme toggle component
- Integration test for localStorage persistence
- Manual testing on Chrome, Firefox, and Safari

## Screenshots
[Before] [After]
```

---

## Vocabulario esencial de open source

| Termino | Significado |
|---------|-------------|
| **Maintainer** | Persona que mantiene el proyecto |
| **Contributor** | Persona que contribuye al proyecto |
| **Upstream** | El repositorio original |
| **Fork** | Copia de un repositorio en tu cuenta |
| **Pull Request (PR)** | Solicitud para fusionar tus cambios |
| **Merge** | Fusionar cambios en la rama principal |
| **Squash** | Combinar multiples commits en uno |
| **Rebase** | Reorganizar commits sobre otra rama |
| **CI/CD** | Integracion y despliegue continuo |
| **Linter** | Herramienta que verifica estilo de codigo |
| **Good first issue** | Issue facil para nuevos contribuidores |
| **Help wanted** | El proyecto necesita ayuda con esto |
| **WIP** | Work in Progress (trabajo en progreso) |

---

## Resumen

- Siempre lee CONTRIBUTING.md antes de contribuir a un proyecto
- Usa frases profesionales y respetuosas en toda comunicacion
- Sigue el flujo: fork, clone, branch, commit, push, PR
- Describe tus contribuciones claramente en el PR
- Respeta el Code of Conduct del proyecto
- Se paciente: los maintainers son voluntarios con tiempo limitado
