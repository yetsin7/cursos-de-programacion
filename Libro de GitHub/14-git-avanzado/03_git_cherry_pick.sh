#!/bin/bash

# =============================================================================
#  CAPÍTULO 14 — GIT AVANZADO
#  Archivo: 03_git_cherry_pick.sh
#  Tema: Copiar commits específicos de una rama a otra
# =============================================================================
#
#  git cherry-pick toma un commit específico de cualquier rama y lo aplica
#  en tu rama actual. Es como copiar y pegar un commit individual.
#
#  Útil cuando necesitas UN cambio específico de otra rama sin fusionar
#  toda la rama completa.
#
# =============================================================================

# =============================================================================
#  ¿CUÁNDO USAR CHERRY-PICK?
# =============================================================================
#
#  1. Un bug fue corregido en "develop" y necesitas el fix en "main" YA
#  2. Un compañero hizo un commit útil en su rama que necesitas en la tuya
#  3. Accidentalmente hiciste un commit en la rama equivocada
#  4. Necesitas portar un cambio entre ramas de release diferentes
#
# =============================================================================

# =============================================================================
#  CHERRY-PICK BÁSICO
# =============================================================================

# --- Paso 1: Identificar el hash del commit que quieres ---
git log --oneline feature
# Salida ejemplo:
#   abc1234 Corrige bug de autenticación    ← queremos este
#   def5678 Agrega nueva pantalla
#   ghi9012 Refactoriza servicios

# --- Paso 2: Cambiar a la rama donde quieres aplicar el commit ---
git checkout main

# --- Paso 3: Cherry-pick del commit ---
git cherry-pick abc1234

# Esto crea un NUEVO commit en main con el mismo contenido que abc1234
# pero con un hash diferente (porque el padre es diferente).

# =============================================================================
#  CHERRY-PICK DE MÚLTIPLES COMMITS
# =============================================================================

# --- Varios commits individuales ---
git cherry-pick abc1234 def5678 ghi9012

# --- Un rango de commits (exclusivo el primero, inclusivo el último) ---
git cherry-pick abc1234..ghi9012
# Aplica def5678 y ghi9012 (NO incluye abc1234)

# --- Un rango inclusivo (con ^) ---
git cherry-pick abc1234^..ghi9012
# Aplica abc1234, def5678 y ghi9012

# =============================================================================
#  CHERRY-PICK SIN COMMIT AUTOMÁTICO
# =============================================================================

# A veces quieres aplicar los cambios pero NO hacer commit todavía
# (por ejemplo, para combinar varios cherry-picks en un solo commit)
git cherry-pick --no-commit abc1234

# Los cambios quedan en staging. Puedes editarlos y hacer commit después:
git commit -m "Aplica corrección de autenticación desde feature"

# =============================================================================
#  RESOLVER CONFLICTOS EN CHERRY-PICK
# =============================================================================

# Si el cherry-pick genera conflictos:
git cherry-pick abc1234
# CONFLICT (content): Merge conflict in archivo.txt

# 1. Resuelve los conflictos manualmente
# 2. Agrega los archivos resueltos
git add archivo.txt

# 3. Continúa el cherry-pick
git cherry-pick --continue

# --- O aborta si decides no continuar ---
git cherry-pick --abort

# =============================================================================
#  EJEMPLO PRÁCTICO: HOTFIX DESDE DEVELOP A MAIN
# =============================================================================
#
#  Situación: hay un bug crítico. Ya fue corregido en develop con el
#  commit "fix-auth-123", pero main necesita ese fix AHORA sin esperar
#  a que develop sea mergeado.
#
#  git checkout main
#  git cherry-pick fix-auth-123
#  git push origin main
#
#  Listo. Main tiene el fix sin necesidad de mergear toda la rama develop.
# =============================================================================

# =============================================================================
#  PRECAUCIONES CON CHERRY-PICK
# =============================================================================
#
#  1. Cherry-pick crea commits DUPLICADOS (mismo contenido, diferente hash)
#     Cuando eventualmente hagas merge de la rama original, Git puede
#     detectar que los cambios ya existen, pero a veces causa conflictos.
#
#  2. No abuses del cherry-pick — si necesitas muchos commits de otra rama,
#     probablemente es mejor hacer merge o rebase.
#
#  3. Los cherry-picks NO mantienen la referencia al commit original.
#     Si necesitas trazabilidad, agrega el hash original en el mensaje:
#     git cherry-pick -x abc1234
#     Esto agrega "(cherry picked from commit abc1234)" al mensaje.
#
# =============================================================================

# --- Cherry-pick con referencia al commit original ---
git cherry-pick -x abc1234

echo ""
echo "=== Fin de 03_git_cherry_pick.sh ==="
echo "Ya sabes copiar commits individuales. Siguiente: git reset."
