#!/bin/bash

# =============================================================================
#  CAPÍTULO 14 — GIT AVANZADO
#  Archivo: 05_git_revert.sh
#  Tema: Revertir commits de forma segura sin alterar el historial
# =============================================================================
#
#  git revert crea un NUEVO commit que deshace los cambios de un commit
#  anterior. A diferencia de reset, NO borra el historial — agrega un
#  nuevo commit que anula el anterior. Por eso es seguro usarlo en
#  commits que ya fueron pusheados al remoto.
#
# =============================================================================

# =============================================================================
#  REVERT vs RESET
# =============================================================================
#
#  RESET: borra commits del historial (peligroso en remoto)
#    Antes:  A ─ B ─ C ─ D
#    reset:  A ─ B ─ C          (D desaparece)
#
#  REVERT: crea un nuevo commit que deshace los cambios
#    Antes:  A ─ B ─ C ─ D
#    revert: A ─ B ─ C ─ D ─ D'  (D' anula los cambios de D)
#
#  Regla: usa RESET para commits locales, REVERT para commits compartidos.
# =============================================================================

# =============================================================================
#  REVERT BÁSICO
# =============================================================================

# --- Revertir el último commit ---
git revert HEAD

# Git abrirá el editor para que escribas un mensaje para el commit de revert.
# El mensaje por defecto es: "Revert "mensaje del commit original""
# Puedes aceptarlo o personalizarlo.

# --- Revertir sin abrir el editor (acepta el mensaje por defecto) ---
git revert HEAD --no-edit

# --- Revertir un commit específico por hash ---
git revert abc1234

# =============================================================================
#  REVERTIR MÚLTIPLES COMMITS
# =============================================================================

# --- Revertir varios commits individuales ---
# Cada uno genera su propio commit de revert
git revert abc1234 def5678 ghi9012

# --- Revertir un rango de commits ---
# Revierte desde def5678 hasta ghi9012 (NO incluye abc1234)
git revert abc1234..ghi9012

# --- Revertir sin hacer commit automático (para agrupar) ---
# Útil cuando quieres un solo commit de revert para múltiples commits
git revert --no-commit abc1234
git revert --no-commit def5678
git commit -m "Revierte cambios de autenticación (abc1234, def5678)"

# =============================================================================
#  REVERTIR UN MERGE COMMIT
# =============================================================================
#
#  Los merge commits tienen DOS padres. Necesitas decirle a Git cuál
#  padre considerar como "el bueno" con la opción -m.
#
#  -m 1 = conservar la rama donde se hizo el merge (generalmente main)
#  -m 2 = conservar la rama que fue mergeada (generalmente feature)
# =============================================================================

# Revertir un merge commit (conservando main como base)
git revert -m 1 abc1234

# =============================================================================
#  RESOLVER CONFLICTOS EN REVERT
# =============================================================================

# Si el revert causa conflictos:
# 1. Resuelve los conflictos en los archivos
# 2. Agrega los archivos resueltos
git add archivo.txt

# 3. Continúa el revert
git revert --continue

# --- O aborta si decides no continuar ---
git revert --abort

# =============================================================================
#  EJEMPLO PRÁCTICO: REVERTIR UN DEPLOY ROTO
# =============================================================================
#
#  Situación: el último commit rompió producción.
#
#  1. Identificar el commit problemático:
#     git log --oneline -5
#
#  2. Revertirlo inmediatamente:
#     git revert HEAD --no-edit
#
#  3. Pushear el fix:
#     git push origin main
#
#  4. Producción vuelve a funcionar.
#     Ahora puedes investigar el problema con calma.
#
# =============================================================================

echo ""
echo "=== Fin de 05_git_revert.sh ==="
echo "Revert es tu mejor amigo en producción. Siguiente: git tag."
