#!/bin/bash

# =============================================================================
#  CAPÍTULO 14 — GIT AVANZADO
#  Archivo: 01_git_stash.sh
#  Tema: Guardar cambios temporalmente con git stash
# =============================================================================
#
#  git stash es como un cajón temporal donde guardas tus cambios sin hacer
#  commit. Es perfecto cuando necesitas cambiar de rama urgentemente pero
#  no quieres perder lo que estabas haciendo ni hacer un commit a medias.
#
# =============================================================================

# =============================================================================
#  ¿CUÁNDO USAR GIT STASH?
# =============================================================================
#
#  Escenario típico:
#  1. Estás trabajando en una nueva funcionalidad en la rama "feature"
#  2. Tu jefe te dice: "hay un bug urgente en producción"
#  3. Necesitas cambiar a "main" AHORA, pero tienes cambios sin commitear
#  4. No quieres hacer commit de código incompleto
#  5. Solución: git stash → guarda todo → cambias de rama → arreglas el bug
#     → vuelves → git stash pop → sigues donde lo dejaste
#
# =============================================================================

# =============================================================================
#  COMANDOS BÁSICOS DE STASH
# =============================================================================

# --- Guardar cambios en el stash ---
# Guarda TODOS los cambios tracked (modificados y en staging) en el stash
git stash

# --- Guardar con un mensaje descriptivo (RECOMENDADO) ---
# Así sabes qué guardaste cuando tengas varios stashes
git stash push -m "trabajo en progreso: formulario de login"

# --- Guardar incluyendo archivos nuevos (untracked) ---
# Por defecto, stash NO guarda archivos nuevos que no han sido tracked
git stash push -u -m "incluye archivos nuevos del componente"

# --- Guardar incluyendo archivos ignorados por .gitignore ---
git stash push -a -m "incluye todo, hasta archivos ignorados"

# =============================================================================
#  VER STASHES GUARDADOS
# =============================================================================

# --- Listar todos los stashes ---
git stash list
# Salida ejemplo:
#   stash@{0}: On feature: trabajo en progreso: formulario de login
#   stash@{1}: On main: fix temporal de estilos
#   stash@{2}: WIP on feature: abc1234 último commit

# --- Ver qué cambios contiene un stash específico ---
git stash show stash@{0}

# --- Ver los cambios con detalle (como un diff) ---
git stash show -p stash@{0}

# =============================================================================
#  RECUPERAR CAMBIOS DEL STASH
# =============================================================================

# --- pop: recupera Y elimina el stash más reciente ---
# Es el más usado. Aplica los cambios y borra el stash de la lista
git stash pop

# --- apply: recupera PERO mantiene el stash en la lista ---
# Útil si quieres aplicar los mismos cambios en varias ramas
git stash apply

# --- Recuperar un stash específico (no el más reciente) ---
git stash pop stash@{2}
git stash apply stash@{1}

# =============================================================================
#  ELIMINAR STASHES
# =============================================================================

# --- Eliminar un stash específico sin aplicarlo ---
git stash drop stash@{0}

# --- Eliminar TODOS los stashes ---
# CUIDADO: esto es irreversible
git stash clear

# =============================================================================
#  CREAR UNA RAMA DESDE UN STASH
# =============================================================================
#
#  Si los cambios guardados en el stash son más complejos de lo esperado,
#  puedes crear una rama directamente desde el stash:
# =============================================================================

git stash branch nueva-rama stash@{0}
# Esto:
# 1. Crea la rama "nueva-rama" desde el commit donde hiciste el stash
# 2. Aplica los cambios del stash
# 3. Elimina el stash
# Muy útil cuando el stash tiene conflictos al aplicarse en la rama actual.

# =============================================================================
#  STASH PARCIAL: GUARDAR SOLO ALGUNOS ARCHIVOS
# =============================================================================

# Guardar solo archivos específicos
git stash push -m "solo estilos" -- styles.css header.css

# Guardar cambios de un directorio específico
git stash push -m "solo componentes" -- src/components/

# =============================================================================
#  EJEMPLO COMPLETO: FLUJO DE TRABAJO CON STASH
# =============================================================================

# 1. Estás trabajando en feature
git checkout feature
# ... editas archivos ...

# 2. Llega una urgencia → guardas tu trabajo
git stash push -m "WIP: formulario de contacto"

# 3. Cambias a main y arreglas el bug
git checkout main
git checkout -b hotfix-bug-123
# ... arreglas el bug ...
git add . && git commit -m "Corrige bug #123"
git checkout main && git merge hotfix-bug-123

# 4. Vuelves a tu trabajo
git checkout feature
git stash pop
# ¡Todos tus cambios están de vuelta!

echo ""
echo "=== Fin de 01_git_stash.sh ==="
echo "Ya dominas git stash. Siguiente: git rebase."
