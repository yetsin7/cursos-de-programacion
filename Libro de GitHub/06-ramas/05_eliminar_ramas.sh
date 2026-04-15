#!/bin/bash
# =============================================================================
# ARCHIVO: 05_eliminar_ramas.sh
# TEMA: Eliminar ramas en Git
# =============================================================================
#
# Una vez que una rama ha sido fusionada y ya no la necesitas, es buena
# práctica eliminarla para mantener tu repositorio limpio. Git no elimina
# ramas automáticamente: tú decides cuándo hacerlo.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# 1. Eliminar rama fusionada (seguro)
# ─────────────────────────────────────────────────────────────────────────────

# git branch -d (delete) elimina una rama SOLO si ya fue fusionada.
# Si la rama tiene commits que no están en ninguna otra rama, Git se niega
# a eliminarla para protegerte de perder trabajo.
git branch -d feature/login

# Salida exitosa:
#   Deleted branch feature/login (was a1b2c3d).

# Si la rama NO fue fusionada:
#   error: The branch 'feature/login' is not fully merged.
#   If you are sure you want to delete it, run 'git branch -D feature/login'.

# ─────────────────────────────────────────────────────────────────────────────
# 2. Eliminar rama sin fusionar (forzado)
# ─────────────────────────────────────────────────────────────────────────────

# git branch -D (D mayúscula) elimina la rama SIN verificar si fue fusionada.
# ⚠️ CUIDADO: Puedes perder commits que solo existían en esa rama.
git branch -D feature/experimento-fallido

# Usa -D cuando:
# - Probaste algo que no funcionó y quieres descartar toda la rama
# - Estás seguro de que no necesitas esos commits
# - Los commits ya están en otra rama o en un backup

# ─────────────────────────────────────────────────────────────────────────────
# 3. Eliminar múltiples ramas a la vez
# ─────────────────────────────────────────────────────────────────────────────

# Puedes pasar varios nombres de ramas al mismo comando:
git branch -d feature/login feature/registro fix/bug-123

# Para eliminar todas las ramas fusionadas excepto main:
# (Útil para hacer limpieza periódica)
git branch --merged | grep -v "main" | xargs git branch -d

# Desglose del comando anterior:
#   git branch --merged     → Lista ramas fusionadas
#   grep -v "main"          → Excluye main de la lista
#   xargs git branch -d     → Elimina cada rama de la lista

# ─────────────────────────────────────────────────────────────────────────────
# 4. Eliminar ramas remotas
# ─────────────────────────────────────────────────────────────────────────────

# Las ramas también existen en el repositorio remoto (GitHub).
# Eliminar una rama local NO la elimina del remoto.

# Para eliminar una rama del remoto:
git push origin --delete feature/login

# O usando la sintaxis corta con dos puntos:
git push origin :feature/login

# Después de eliminar la rama remota, otros colaboradores pueden limpiar
# sus referencias con:
git fetch --prune

# ─────────────────────────────────────────────────────────────────────────────
# 5. No puedes eliminar la rama actual
# ─────────────────────────────────────────────────────────────────────────────

# Git no te permite eliminar la rama en la que estás parado.
# Si intentas eliminar tu rama actual:
#   error: Cannot delete branch 'feature/login' checked out at '/path/to/repo'

# Solución: primero cámbiate a otra rama.
git switch main
git branch -d feature/login    # Ahora sí funciona

# ─────────────────────────────────────────────────────────────────────────────
# 6. Recuperar una rama eliminada por error
# ─────────────────────────────────────────────────────────────────────────────

# Si eliminaste una rama por error, los commits NO se borran inmediatamente.
# Git los conserva por un tiempo en el "reflog".

# Para ver el reflog y encontrar el último commit de la rama eliminada:
git reflog

# Busca una entrada como:
#   a1b2c3d HEAD@{5}: checkout: moving from feature/login to main
# El hash a1b2c3d es el último commit de la rama eliminada.

# Recrea la rama apuntando a ese commit:
git branch feature/login a1b2c3d

# ¡Rama recuperada! Los commits del reflog se conservan por 30 días por defecto.

# =============================================================================
# RESUMEN:
# - git branch -d <rama>                → Eliminar rama fusionada (seguro)
# - git branch -D <rama>                → Eliminar rama sin verificar (forzado)
# - git push origin --delete <rama>     → Eliminar rama del remoto
# - No puedes eliminar la rama actual (cámbiate primero)
# - Si te equivocas, usa git reflog para recuperar la rama
# - Haz limpieza periódica de ramas fusionadas para mantener orden
# =============================================================================
