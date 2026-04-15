#!/bin/bash
# =============================================================================
# ARCHIVO: 03_cambiar_de_rama.sh
# TEMA: Moverse entre ramas (checkout, switch, HEAD)
# =============================================================================
#
# Cambiar de rama es como teletransportarte a una realidad paralela de tu
# proyecto. Cuando cambias de rama, Git actualiza todos los archivos de tu
# directorio de trabajo para que coincidan con el estado de esa rama.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# 1. git switch — La forma moderna (Git 2.23+)
# ─────────────────────────────────────────────────────────────────────────────

# git switch es el comando recomendado para cambiar entre ramas.
# Fue creado para reemplazar parte de git checkout (que hacía demasiadas cosas).
git switch main

# Cambiar a una rama existente:
git switch feature/login

# Git actualizará TODOS los archivos de tu directorio de trabajo
# para que coincidan con el último commit de feature/login.
# Es instantáneo (Git solo mueve punteros y actualiza archivos).

# ─────────────────────────────────────────────────────────────────────────────
# 2. git checkout — La forma clásica
# ─────────────────────────────────────────────────────────────────────────────

# git checkout también cambia de rama. Funciona igual que switch para este caso.
git checkout main
git checkout feature/login

# La diferencia es que checkout TAMBIÉN puede:
# - Restaurar archivos (git checkout -- archivo.txt)
# - Ir a un commit específico (git checkout a1b2c3d)
#
# Por eso se creó git switch: para separar responsabilidades.
# switch = cambiar ramas. restore = restaurar archivos.

# ─────────────────────────────────────────────────────────────────────────────
# 3. ¿Qué pasa cuando cambias de rama?
# ─────────────────────────────────────────────────────────────────────────────

# Cuando ejecutas git switch feature/login, Git hace lo siguiente:
#
# 1. Mueve HEAD para que apunte a feature/login
# 2. Actualiza el staging area con el contenido del commit de esa rama
# 3. Actualiza tu directorio de trabajo con esos archivos
#
# Es decir: tus archivos CAMBIAN en el disco duro.
# No te asustes: Git no pierde nada. Todo está guardado en el historial.
#
# Ejemplo:
#   En main: tienes index.js con 50 líneas
#   En feature/login: tienes index.js con 80 líneas + login.js nuevo
#   Al hacer switch a feature/login: index.js crece a 80 líneas y login.js aparece
#   Al volver a main: index.js vuelve a 50 líneas y login.js desaparece

# ─────────────────────────────────────────────────────────────────────────────
# 4. Cambiar de rama con cambios sin guardar
# ─────────────────────────────────────────────────────────────────────────────

# Si tienes cambios sin commit y quieres cambiar de rama, Git puede:
#
# CASO 1: Los cambios no entran en conflicto con la otra rama.
#   Git te deja cambiar y lleva tus cambios consigo.
#   (Los cambios no comprometidos "viajan" contigo a la nueva rama.)
#
# CASO 2: Los cambios SÍ entran en conflicto con la otra rama.
#   Git se NIEGA a cambiar y te da un error:
#   "Your local changes to the following files would be overwritten"
#
#   Opciones para resolver esto:

# Opción A: Hacer commit de los cambios antes de cambiar.
git add .
git commit -m "wip: guarda trabajo en progreso"
git switch main

# Opción B: Guardar temporalmente los cambios con stash.
# git stash guarda tus cambios en una pila temporal y limpia el directorio.
git stash                    # Guarda los cambios y limpia
git switch main              # Ahora puedes cambiar sin problema
# ... haces lo que necesitas en main ...
git switch feature/login     # Vuelves a tu rama
git stash pop                # Recupera tus cambios guardados

# Opción C: Descartar los cambios (¡CUIDADO! Pierdes el trabajo).
git checkout -- .            # Descarta TODOS los cambios no guardados
git switch main

# ─────────────────────────────────────────────────────────────────────────────
# 5. Detached HEAD: ir a un commit sin rama
# ─────────────────────────────────────────────────────────────────────────────

# Normalmente HEAD apunta a una rama. Pero puedes hacer que apunte
# directamente a un commit (sin rama). Esto se llama "detached HEAD".
git checkout a1b2c3d

# Git te advertirá:
#   You are in 'detached HEAD' state. You can look around, make experimental
#   changes and commit them, and you can discard any commits you make in this
#   state without impacting any branches...

# En detached HEAD puedes:
# ✅ Ver archivos como estaban en ese commit
# ✅ Hacer commits experimentales
# ⚠️ Pero esos commits no pertenecen a ninguna rama
# ⚠️ Si cambias de rama sin guardarlos, podrías perderlos

# Para volver a una rama (salir de detached HEAD):
git switch main
git switch -           # Volver a la rama anterior (atajo)

# Si hiciste commits en detached HEAD y quieres conservarlos:
git switch -c rama-nueva     # Crea una rama que apunte a esos commits

# ─────────────────────────────────────────────────────────────────────────────
# 6. Atajos útiles
# ─────────────────────────────────────────────────────────────────────────────

# Cambiar a la rama anterior (como alt+tab para ramas):
git switch -
git checkout -

# Ejemplo de uso:
git switch feature/login     # Vas a feature/login
git switch main              # Vas a main
git switch -                 # Vuelves a feature/login
git switch -                 # Vuelves a main

# Ver en qué rama estás:
git branch --show-current    # Solo muestra el nombre de la rama actual

# =============================================================================
# RESUMEN:
# - git switch <rama>        → Cambiar de rama (moderno, recomendado)
# - git checkout <rama>      → Cambiar de rama (clásico)
# - git switch -             → Volver a la rama anterior
# - Al cambiar, los archivos se actualizan automáticamente
# - Si tienes cambios sin commit, usa stash o commit antes de cambiar
# - Detached HEAD = HEAD apunta a un commit sin rama (usar con cuidado)
# =============================================================================
