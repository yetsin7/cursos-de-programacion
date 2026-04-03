# Git Commands Vocabulary

## Vocabulario de Comandos de Git

Git tiene su propio vocabulario que debes dominar para trabajar en cualquier equipo
de desarrollo. Aprenderemos cada comando con su pronunciacion, significado y
como usarlo en una oracion.

---

## Comandos Basicos

| Comando | Pronunciacion | Significado | Ejemplo de uso |
|---------|--------------|-------------|----------------|
| **git init** | "git i-NIT" | Inicializar un repositorio nuevo | `git init` |
| **git clone** | "git CLOUN" | Copiar un repositorio remoto | `git clone https://github.com/user/repo.git` |
| **git add** | "git ad" | Agregar archivos al staging area | `git add .` |
| **git commit** | "git co-MIT" | Guardar los cambios con un mensaje | `git commit -m "feat: add login"` |
| **git status** | "git STA-tus" | Ver el estado actual de los archivos | `git status` |
| **git log** | "git log" | Ver el historial de commits | `git log --oneline` |
| **git diff** | "git dif" | Ver las diferencias entre archivos | `git diff` |

### Ejemplos en Oraciones

- "**Clone** the repository to your local machine."
  (Clona el repositorio a tu maquina local.)
- "**Add** the modified files to the staging area."
  (Agrega los archivos modificados al area de staging.)
- "**Commit** your changes with a descriptive message."
  (Haz commit de tus cambios con un mensaje descriptivo.)
- "Run **git status** to see which files have changed."
  (Ejecuta git status para ver que archivos han cambiado.)

---

## Comandos de Sincronizacion

| Comando | Pronunciacion | Significado |
|---------|--------------|-------------|
| **git push** | "git push" | Enviar commits locales al remoto |
| **git pull** | "git pul" | Traer y fusionar cambios del remoto |
| **git fetch** | "git fetch" | Traer cambios del remoto sin fusionar |

### Diferencia entre Pull y Fetch

- **fetch**: Descarga los cambios pero no los aplica. "Fetch the latest changes."
- **pull**: Descarga Y aplica los cambios. "Pull the latest changes from main."

```bash
git fetch origin          # Trae los cambios sin aplicar
git pull origin main      # Trae y fusiona los cambios de main
git push origin feature   # Envia los commits a la rama feature
```

### Ejemplos en Oraciones

- "**Push** your branch to the remote." (Sube tu rama al remoto.)
- "**Pull** the latest changes before starting work." (Trae los ultimos cambios antes de empezar a trabajar.)
- "**Fetch** first to see if there are any updates." (Haz fetch primero para ver si hay actualizaciones.)

---

## Comandos de Ramas

| Comando | Pronunciacion | Significado |
|---------|--------------|-------------|
| **git branch** | "git branch" | Crear, listar o eliminar ramas |
| **git checkout** | "git CHEK-aut" | Cambiar de rama o restaurar archivos |
| **git switch** | "git suich" | Cambiar de rama (moderno) |
| **git merge** | "git merch" | Fusionar una rama con otra |
| **git rebase** | "git ri-BEIS" | Reaplicar commits sobre otra base |

```bash
git branch feature/login     # Crear rama
git checkout feature/login   # Cambiar a la rama
git switch main              # Cambiar a main (moderno)
git merge feature/login      # Fusionar la rama en la actual
git rebase main              # Rebasar sobre main
```

### Ejemplos en Oraciones

- "Create a new **branch** for the feature." (Crea una nueva rama para la funcionalidad.)
- "**Checkout** the develop branch." (Cambiate a la rama develop.)
- "**Merge** the feature branch into main." (Fusiona la rama de feature en main.)
- "**Rebase** your branch onto main to keep a clean history." (Rebasa tu rama sobre main para mantener un historial limpio.)

---

## Comandos de Almacenamiento Temporal

| Comando | Pronunciacion | Significado |
|---------|--------------|-------------|
| **git stash** | "git stash" | Guardar cambios temporalmente |
| **git stash pop** | "git stash pop" | Restaurar los cambios guardados |

```bash
git stash               # Guarda cambios temporalmente
git stash pop            # Restaura los cambios
git stash list           # Lista los stashes guardados
```

- "**Stash** your changes before switching branches." (Guarda tus cambios antes de cambiar de rama.)
- "**Pop** the stash to get your changes back." (Restaura el stash para recuperar tus cambios.)

---

## Comandos de Reversion

| Comando | Pronunciacion | Significado |
|---------|--------------|-------------|
| **git reset** | "git ri-SET" | Deshacer commits o unstage archivos |
| **git revert** | "git ri-VERT" | Crear un commit que deshace otro |
| **git cherry-pick** | "git CHE-ri pik" | Copiar un commit especifico a otra rama |

### Diferencia entre Reset y Revert

- **reset**: Elimina commits del historial. "Reset to the previous commit."
- **revert**: Crea un nuevo commit que deshace. "Revert the last commit."

```bash
git reset --soft HEAD~1     # Deshace el ultimo commit, mantiene cambios
git revert abc123           # Crea commit que deshace abc123
git cherry-pick def456      # Copia el commit def456 a la rama actual
```

---

## Otros Comandos Importantes

| Comando | Pronunciacion | Significado |
|---------|--------------|-------------|
| **git tag** | "git tag" | Marcar un punto especifico (version) |
| **git remote** | "git ri-MOUT" | Gestionar repositorios remotos |

### Conceptos Clave

| Termino | Pronunciacion | Significado |
|---------|--------------|-------------|
| **origin** | /ˈɒrɪdʒɪn/ "O-ri-yin" | El repositorio remoto por defecto |
| **upstream** | /ˈʌpstriːm/ "AP-striim" | El repositorio original (en forks) |
| **HEAD** | /hɛd/ "jed" | El commit actual donde estas |
| **staging area** | "STEI-ying E-ria" | Area donde preparas archivos para commit |
| **working directory** | "WER-king di-REK-to-ri" | Tu carpeta de trabajo local |

---

## Frases Comunes con Git

| Ingles | Espaniol |
|--------|----------|
| "Push your changes to the remote." | "Sube tus cambios al remoto." |
| "Pull the latest from main." | "Trae lo ultimo de main." |
| "I need to resolve a merge conflict." | "Necesito resolver un conflicto de merge." |
| "Let me stash my changes first." | "Dejame guardar mis cambios primero." |
| "Cherry-pick that commit into hotfix." | "Haz cherry-pick de ese commit en hotfix." |
| "Tag this commit as v2.0." | "Marca este commit como v2.0." |
| "Reset to the previous commit." | "Resetea al commit anterior." |
| "The branch is up to date with origin." | "La rama esta al dia con origin." |

---

## Resumen

Los comandos de Git se agrupan en:

- **Basicos**: init, clone, add, commit, status, log, diff
- **Sincronizacion**: push, pull, fetch
- **Ramas**: branch, checkout, switch, merge, rebase
- **Temporal**: stash, stash pop
- **Reversion**: reset, revert, cherry-pick
- **Otros**: tag, remote
- **Conceptos**: origin, upstream, HEAD, staging area
