# Capítulo 14 — Git Avanzado

## Técnicas avanzadas para flujos de trabajo profesionales

Una vez que dominas lo básico de Git (add, commit, push, pull, merge, branches),
es hora de aprender las herramientas avanzadas que te convierten en un desarrollador
más eficiente y te sacan de situaciones complicadas.

### ¿Qué aprenderás?

| Herramienta | Para qué sirve |
|-------------|-----------------|
| `git stash` | Guardar cambios temporalmente sin hacer commit |
| `git rebase` | Reescribir el historial para mantenerlo limpio |
| `git cherry-pick` | Copiar un commit específico de otra rama |
| `git reset` | Deshacer commits (soft, mixed, hard) |
| `git revert` | Revertir cambios de forma segura sin alterar el historial |
| `git tag` | Marcar versiones importantes (v1.0, v2.0) |
| `git bisect` | Encontrar el commit exacto que introdujo un bug |
| `git reflog` | Recuperar trabajo "perdido" — tu red de seguridad |

### Cuándo usar cada herramienta

```
¿Necesitas guardar cambios temporalmente?          → git stash
¿Quieres un historial lineal y limpio?             → git rebase
¿Necesitas un commit específico de otra rama?       → git cherry-pick
¿Quieres deshacer el último commit localmente?      → git reset
¿Quieres deshacer un commit que ya está en remoto?  → git revert
¿Quieres marcar un release?                         → git tag
¿Hay un bug y no sabes qué commit lo causó?         → git bisect
¿Perdiste un commit o una rama?                     → git reflog
```

---

## Archivos de este capítulo

| Archivo | Tema |
|---------|------|
| `01_git_stash.sh` | Guardar cambios temporalmente |
| `02_git_rebase.sh` | Rebase vs merge, rebase interactivo |
| `03_git_cherry_pick.sh` | Copiar commits específicos |
| `04_git_reset.sh` | Reset soft, mixed y hard |
| `05_git_revert.sh` | Revertir commits de forma segura |
| `06_git_tag.sh` | Tags y versionado |
| `07_git_bisect.sh` | Encontrar bugs con búsqueda binaria |
| `08_git_reflog.sh` | Recuperación con reflog |
| `09_ejercicios.sh` | Ejercicios de práctica |

---

## Cómo usar estos archivos

```bash
# Los archivos .sh contienen comandos de ejemplo con explicaciones detalladas.
bash 14-git-avanzado/01_git_stash.sh
```
