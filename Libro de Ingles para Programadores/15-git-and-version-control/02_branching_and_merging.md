# Branching and Merging

## Como Hablar sobre Ramas y Fusiones en Ingles

Las ramas (branches) son fundamentales en Git. Saber hablar sobre ellas en ingles
es esencial para colaborar en equipos y entender flujos de trabajo como Git Flow
o trunk-based development.

---

## Vocabulario de Ramas

| Termino | Significado |
|---------|-------------|
| **branch** | Rama - una linea independiente de desarrollo |
| **main / master** | La rama principal del proyecto |
| **develop** | Rama de desarrollo (en Git Flow) |
| **feature branch** | Rama para una funcionalidad nueva |
| **hotfix branch** | Rama para una correccion urgente |
| **release branch** | Rama para preparar un lanzamiento |
| **topic branch** | Rama para un tema o tarea especifica |

---

## Crear y Gestionar Ramas

### Frases para crear ramas

| Ingles | Espaniol |
|--------|----------|
| "Create a new branch from main." | "Crea una nueva rama desde main." |
| "Branch off from develop." | "Crea una rama a partir de develop." |
| "I'll create a feature branch for the login." | "Voy a crear una rama de feature para el login." |
| "Checkout the new branch." | "Cambiate a la nueva rama." |
| "Switch to the feature branch." | "Cambiate a la rama de feature." |

### Convenciones de nombres de ramas

| Patron | Ejemplo | Uso |
|--------|---------|-----|
| `feature/` | `feature/user-authentication` | Nueva funcionalidad |
| `fix/` | `fix/cart-total-calculation` | Correccion de bug |
| `hotfix/` | `hotfix/payment-crash` | Correccion urgente |
| `release/` | `release/v2.1.0` | Preparacion de version |
| `chore/` | `chore/update-dependencies` | Mantenimiento |
| `docs/` | `docs/api-reference` | Documentacion |

### Como hablar sobre nombres de ramas

- "Name the branch `feature/add-dark-mode`."
  (Nombra la rama `feature/add-dark-mode`.)
- "Use kebab-case for branch names."
  (Usa kebab-case para los nombres de ramas.)
- "The branch name should describe the change."
  (El nombre de la rama debe describir el cambio.)

---

## Merge (Fusion)

### Tipos de merge

| Tipo | Descripcion | Comando |
|------|-------------|---------|
| **Fast-forward merge** | La rama se adelanta sin commit extra | `git merge feature` |
| **Three-way merge** | Se crea un commit de merge | `git merge --no-ff feature` |
| **Squash merge** | Combina todos los commits en uno | `git merge --squash feature` |

### Frases sobre merge

| Ingles | Espaniol |
|--------|----------|
| "Merge the feature branch into main." | "Fusiona la rama de feature en main." |
| "The PR was merged into develop." | "El PR fue fusionado en develop." |
| "Do a squash merge to keep the history clean." | "Haz un squash merge para mantener el historial limpio." |
| "I'll merge your branch after the review." | "Fusionare tu rama despues de la revision." |
| "This branch is ready to be merged." | "Esta rama esta lista para fusionarse." |

---

## Merge Conflicts (Conflictos de Fusion)

Cuando dos ramas modifican el mismo archivo, Git no puede fusionar automaticamente.

### Como se ven los conflictos

```
<<<<<<< HEAD
const theme = 'light';
=======
const theme = 'dark';
>>>>>>> feature/dark-mode
```

> "HEAD" es tu rama actual, y debajo de "=======" esta lo que viene de la otra rama.

### Frases sobre conflictos

| Ingles | Espaniol |
|--------|----------|
| "There's a merge conflict in `app.js`." | "Hay un conflicto de merge en `app.js`." |
| "I need to resolve the conflict manually." | "Necesito resolver el conflicto manualmente." |
| "The conflict is between the two branches." | "El conflicto es entre las dos ramas." |
| "Accept the incoming changes." | "Acepta los cambios entrantes." |
| "Keep the current changes." | "Mantiene los cambios actuales." |
| "Accept both changes." | "Acepta ambos cambios." |
| "I resolved the conflicts and pushed." | "Resolvi los conflictos y subi los cambios." |

---

## Rebase

Rebase reaplica tus commits sobre otra rama, creando un historial lineal.

### Frases sobre rebase

| Ingles | Espaniol |
|--------|----------|
| "Rebase your branch onto main." | "Rebasa tu rama sobre main." |
| "I'll rebase before creating the PR." | "Voy a rebasar antes de crear el PR." |
| "Rebase keeps the history linear." | "Rebase mantiene el historial lineal." |
| "There was a conflict during the rebase." | "Hubo un conflicto durante el rebase." |
| "Continue the rebase after resolving conflicts." | "Continua el rebase despues de resolver conflictos." |
| "Abort the rebase if something goes wrong." | "Aborta el rebase si algo sale mal." |

### Merge vs Rebase

| Aspecto | Merge | Rebase |
|---------|-------|--------|
| Historial | Preserva la historia completa | Crea historial lineal |
| Commit extra | Crea un merge commit | No crea commit extra |
| Seguridad | Mas seguro (no reescribe) | Reescribe el historial |
| Uso tipico | Cuando fusionas un PR | Antes de crear un PR |

---

## Cherry-pick

Copia un commit especifico de una rama a otra.

| Ingles | Espaniol |
|--------|----------|
| "Cherry-pick that commit into the hotfix branch." | "Haz cherry-pick de ese commit en la rama de hotfix." |
| "I'll cherry-pick the bug fix from develop." | "Voy a hacer cherry-pick del fix desde develop." |
| "Cherry-pick only the relevant commit." | "Haz cherry-pick solo del commit relevante." |

---

## Flujos de Trabajo (Workflows)

### Git Flow

```
main ─────────────────────────────
  \                    /
   develop ───────────
     \        /
      feature/login
```

- "Create a **feature branch** from **develop**."
- "When the feature is complete, **merge it back into develop**."
- "Create a **release branch** when ready to deploy."
- "**Merge the release** into both **main** and **develop**."

### Trunk-based Development

```
main ─────────────────────────────
  \   /  \   /  \   /
  feat1  feat2  feat3  (short-lived branches)
```

- "Keep branches **short-lived** — merge within a day or two."
- "Push small, frequent changes to **main**."

---

## Frases de Situaciones Comunes

| Situacion | Frase en ingles |
|-----------|----------------|
| Tu rama esta desactualizada | "My branch is behind main — I need to pull the latest changes." |
| Pedir que actualicen su rama | "Can you rebase your branch onto main?" |
| Rama lista para merge | "The branch is ready for review and merge." |
| Eliminar rama despues de merge | "Delete the branch after merging." |
| Comparar dos ramas | "What's the diff between develop and main?" |
| Rama con conflictos | "This branch has conflicts with main that need to be resolved." |

---

## Resumen

- **Ramas**: feature, hotfix, release, con nombres descriptivos en kebab-case
- **Merge**: fast-forward, three-way, squash; resuelve conflictos manualmente
- **Rebase**: historial lineal, usar antes de crear PRs
- **Cherry-pick**: copiar commits especificos entre ramas
- **Flujos**: Git Flow (ramas largas) vs trunk-based (ramas cortas)
