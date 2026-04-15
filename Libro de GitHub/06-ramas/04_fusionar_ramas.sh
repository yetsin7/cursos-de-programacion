#!/bin/bash
# =============================================================================
# ARCHIVO: 04_fusionar_ramas.sh
# TEMA: Fusionar ramas con git merge
# =============================================================================
#
# Fusionar (merge) es el proceso de combinar el trabajo de una rama con otra.
# Es el paso final del flujo de ramas: desarrollas en una rama y cuando está
# listo, lo fusionas de vuelta a main (o a la rama que corresponda).
#
# Git tiene dos estrategias principales de merge: fast-forward y 3-way merge.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# 1. Concepto básico de merge
# ─────────────────────────────────────────────────────────────────────────────

# Para fusionar, siempre debes:
# 1. Estar en la rama que RECIBE los cambios (la rama destino)
# 2. Ejecutar git merge con el nombre de la rama que quieres integrar

# Ejemplo: fusionar feature/login en main
git switch main                   # Paso 1: ir a la rama destino
git merge feature/login           # Paso 2: fusionar la rama fuente

# Esto trae todos los commits de feature/login a main.

# ─────────────────────────────────────────────────────────────────────────────
# 2. Fast-forward merge (avance rápido)
# ─────────────────────────────────────────────────────────────────────────────

# El fast-forward ocurre cuando main NO tiene commits nuevos desde que
# se creó la rama. Es decir, la rama está "adelante" de main en línea recta.
#
# ANTES del merge:
#
#   A ── B ── C  (main)
#               \
#                D ── E  (feature/login)
#
# main está en C, feature/login está en E. No hay divergencia.
# Git simplemente AVANZA el puntero main hasta E.
#
# DESPUÉS del merge (fast-forward):
#
#   A ── B ── C ── D ── E  (main, feature/login)
#
# No se crea ningún commit nuevo. Es la fusión más simple y limpia.

git switch main
git merge feature/login
# Salida: "Fast-forward"

# Si quieres FORZAR un commit de merge aunque sea fast-forward posible
# (para dejar registro de que existió una rama):
git merge --no-ff feature/login

# Esto crea un commit de merge explícito:
#
#   A ── B ── C ───────── M  (main)
#               \       /
#                D ── E     (feature/login)
#
# M es el "merge commit" que registra la fusión.

# ─────────────────────────────────────────────────────────────────────────────
# 3. Three-way merge (fusión de tres vías)
# ─────────────────────────────────────────────────────────────────────────────

# El 3-way merge ocurre cuando AMBAS ramas tienen commits nuevos.
# Git no puede simplemente avanzar el puntero; necesita combinar el trabajo.
#
# ANTES del merge:
#
#          D ── E       (feature/login)
#         /
#   A ── B ── C ── F    (main)
#
# main avanzó a F después de que feature/login se separó en B.
# Git necesita crear un COMMIT DE MERGE que combine ambos trabajos.
#
# DESPUÉS del merge:
#
#          D ── E
#         /       \
#   A ── B ── C ── F ── M  (main)
#
# M es el merge commit. Tiene DOS padres: F (de main) y E (de feature/login).

git switch main
git merge feature/login
# Git abrirá el editor para que escribas el mensaje del merge commit.
# Por defecto sugiere: "Merge branch 'feature/login'"

# Para usar el mensaje por defecto sin abrir el editor:
git merge feature/login --no-edit

# ─────────────────────────────────────────────────────────────────────────────
# 4. Merge con conflictos
# ─────────────────────────────────────────────────────────────────────────────

# Si ambas ramas modificaron las MISMAS líneas del mismo archivo, Git no
# puede decidir cuál versión conservar. Esto genera un CONFLICTO.
#
# Git te lo indicará:
#   Auto-merging archivo.txt
#   CONFLICT (content): Merge conflict in archivo.txt
#   Automatic merge failed; fix conflicts and then commit the result.

# El archivo con conflicto se ve así:
#   <<<<<<< HEAD
#   Código de tu rama actual (main)
#   =======
#   Código de la rama que estás fusionando (feature/login)
#   >>>>>>> feature/login

# Para resolver:
# 1. Abre el archivo y elige qué código conservar (o combina ambos)
# 2. Elimina los marcadores <<<<<<<, =======, >>>>>>>
# 3. Guarda el archivo
# 4. Agrega el archivo resuelto al staging
# 5. Completa el merge con un commit

git add archivo_resuelto.txt
git commit -m "merge: resuelve conflicto en archivo.txt"

# Para CANCELAR un merge con conflictos (volver al estado anterior):
git merge --abort

# Los conflictos se cubren en detalle en el Capítulo 13.

# ─────────────────────────────────────────────────────────────────────────────
# 5. Ver si una rama ya fue fusionada
# ─────────────────────────────────────────────────────────────────────────────

# Listar ramas que YA fueron fusionadas en la rama actual:
git branch --merged

# Listar ramas que AÚN NO han sido fusionadas:
git branch --no-merged

# Esto es útil para saber qué ramas puedes eliminar con seguridad.

# ─────────────────────────────────────────────────────────────────────────────
# 6. Ejemplo práctico completo
# ─────────────────────────────────────────────────────────────────────────────

# Simulemos un flujo completo de merge:

# 1. Crear rama para nueva funcionalidad
# git switch -c feature/saludo

# 2. Hacer cambios y commits en la rama
# echo "function saludar() { return 'Hola'; }" > saludo.js
# git add saludo.js
# git commit -m "feat: agrega función de saludo"

# 3. Volver a main
# git switch main

# 4. Fusionar la rama
# git merge feature/saludo

# 5. Verificar que los cambios están en main
# git log --oneline -5
# cat saludo.js

# 6. Eliminar la rama (ya no la necesitamos)
# git branch -d feature/saludo

# =============================================================================
# RESUMEN:
# - git merge <rama>          → Fusionar rama en la rama actual
# - Fast-forward: avance rápido cuando no hay divergencia
# - 3-way merge: crea un merge commit cuando ambas ramas tienen cambios
# - --no-ff: forzar merge commit aunque sea fast-forward posible
# - --abort: cancelar un merge con conflictos
# - git branch --merged       → Ver ramas ya fusionadas
# - Siempre estar en la rama DESTINO antes de ejecutar merge
# =============================================================================
