#!/bin/bash

# =============================================================================
#  CAPÍTULO 14 — GIT AVANZADO
#  Archivo: 02_git_rebase.sh
#  Tema: Rebase — reescribir el historial para mantenerlo limpio
# =============================================================================
#
#  git rebase mueve (o "replanta") tus commits sobre otro punto del historial.
#  El resultado es un historial lineal y limpio, sin los commits de merge
#  que genera git merge.
#
# =============================================================================

# =============================================================================
#  REBASE vs MERGE: ¿CUÁL USAR?
# =============================================================================
#
#  MERGE (git merge feature):
#  ─────────────────────────
#    main:     A ─── B ─── C ─────── M (merge commit)
#    feature:       └─ D ─── E ──┘
#
#  - Crea un "merge commit" (M) que une ambas ramas
#  - Preserva el historial exacto de cómo ocurrieron las cosas
#  - El historial puede verse desordenado con muchas ramas
#
#  REBASE (git rebase main):
#  ─────────────────────────
#    Antes:  main: A ─── B ─── C
#            feature:    └─ D ─── E
#
#    Después: main: A ─── B ─── C ─── D' ─── E'
#
#  - Mueve tus commits (D, E) al final de main
#  - Crea NUEVOS commits (D', E') con el mismo contenido pero diferente hash
#  - El historial queda lineal y limpio
#  - NO crea merge commits
#
#  REGLA DE ORO:
#  - Usa rebase para ramas LOCALES que no has compartido
#  - Usa merge para ramas COMPARTIDAS o públicas
#  - NUNCA hagas rebase de commits que ya están en el remoto compartido
#
# =============================================================================

# =============================================================================
#  REBASE BÁSICO
# =============================================================================

# --- Actualizar tu rama feature con los últimos cambios de main ---
git checkout feature
git rebase main

# Esto toma todos tus commits de "feature" y los replanta sobre
# el último commit de "main". El resultado es como si hubieras
# creado la rama feature desde el main más actualizado.

# --- Si hay conflictos durante el rebase ---
# Git se detendrá en cada commit que tenga conflicto.
# Resuelves el conflicto y continúas:

# 1. Resuelve el conflicto en el archivo
# 2. Agrega el archivo resuelto
git add archivo-resuelto.txt

# 3. Continúa el rebase
git rebase --continue

# --- Abortar un rebase si algo sale mal ---
git rebase --abort
# Te devuelve al estado exacto antes de iniciar el rebase

# --- Saltar un commit problemático durante el rebase ---
git rebase --skip

# =============================================================================
#  REBASE INTERACTIVO
# =============================================================================
#
#  El rebase interactivo te permite reescribir el historial de commits:
#  renombrar mensajes, combinar commits, eliminar commits, reordenarlos.
#
#  Es la herramienta más poderosa para limpiar tu historial antes de
#  hacer un Pull Request.
# =============================================================================

# --- Rebase interactivo de los últimos N commits ---
# Ejemplo: editar los últimos 3 commits
git rebase -i HEAD~3

# Git abrirá un editor con algo como:
#
#   pick abc1234 Agrega componente de login
#   pick def5678 Corrige typo en login
#   pick ghi9012 Agrega estilos al login
#
# Puedes cambiar "pick" por:
#
#   pick   → conservar el commit tal cual
#   reword → cambiar el mensaje del commit
#   edit   → pausar para editar el commit
#   squash → combinar con el commit anterior (mantiene ambos mensajes)
#   fixup  → combinar con el anterior (descarta este mensaje)
#   drop   → eliminar el commit completamente

# =============================================================================
#  EJEMPLO: COMBINAR COMMITS CON SQUASH
# =============================================================================
#
#  Antes (3 commits desordenados):
#    abc1234 Agrega componente de login
#    def5678 fix typo
#    ghi9012 otro fix
#
#  En el editor del rebase interactivo, cambias a:
#    pick abc1234 Agrega componente de login
#    squash def5678 fix typo
#    squash ghi9012 otro fix
#
#  Resultado (1 commit limpio):
#    xyz9999 Agrega componente de login
#
# =============================================================================

# =============================================================================
#  REBASE ONTO: MOVER UNA RAMA A OTRA BASE
# =============================================================================

# Si creaste una rama desde "feature" pero debería partir de "main":
git rebase --onto main feature mi-rama
# Esto mueve los commits de "mi-rama" (que estaban sobre "feature")
# para que ahora estén sobre "main"

# =============================================================================
#  CUÁNDO NO USAR REBASE
# =============================================================================
#
#  ❌ NUNCA hagas rebase de commits que ya pusheaste y otros descargaron
#     Esto reescribe el historial y causa problemas a todo el equipo
#
#  ❌ NUNCA hagas rebase de la rama main/master
#
#  ❌ Evita rebase si no estás cómodo resolviendo conflictos
#     (merge es más seguro para principiantes)
#
#  ✅ SÍ usa rebase para limpiar TU rama local antes de hacer PR
#  ✅ SÍ usa rebase para actualizar tu rama con los cambios de main
# =============================================================================

echo ""
echo "=== Fin de 02_git_rebase.sh ==="
echo "Ya entiendes rebase. Siguiente: cherry-pick."
