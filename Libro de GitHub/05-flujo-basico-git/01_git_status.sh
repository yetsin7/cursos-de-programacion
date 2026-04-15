#!/bin/bash
# =============================================================================
# ARCHIVO: 01_git_status.sh
# TEMA: Verificar el estado del repositorio con git status
# =============================================================================
#
# git status es el comando que más usarás en Git. Te dice exactamente en qué
# estado se encuentran tus archivos: cuáles están modificados, cuáles están
# listos para commit y cuáles Git ni siquiera conoce todavía.
#
# Aprende a leer su salida y nunca te perderás trabajando con Git.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# 1. Uso básico de git status
# ─────────────────────────────────────────────────────────────────────────────

# git status muestra el estado actual de tu directorio de trabajo y del
# staging area. Es como un "tablero de instrumentos" de tu repositorio.
git status

# La salida típica cuando no hay cambios dice:
#   On branch main
#   nothing to commit, working tree clean
#
# Esto significa: estás en la rama main, no hay nada que guardar, todo limpio.

# ─────────────────────────────────────────────────────────────────────────────
# 2. Entendiendo los estados de los archivos
# ─────────────────────────────────────────────────────────────────────────────

# Git clasifica tus archivos en 4 estados principales:
#
# UNTRACKED (sin rastrear):
#   - Archivos nuevos que Git nunca ha visto
#   - Aparecen en rojo bajo "Untracked files"
#   - Git los ignora hasta que los agregues con git add
#
# MODIFIED (modificado):
#   - Archivos que Git ya conoce pero que cambiaste desde el último commit
#   - Aparecen en rojo bajo "Changes not staged for commit"
#   - Los cambios NO se incluirán en el próximo commit hasta que hagas git add
#
# STAGED (preparado):
#   - Archivos listos para ser incluidos en el próximo commit
#   - Aparecen en verde bajo "Changes to be committed"
#   - Llegaron aquí porque usaste git add
#
# UNMODIFIED (sin modificar):
#   - Archivos que no han cambiado desde el último commit
#   - git status NO los muestra (solo muestra lo que cambió)

# ─────────────────────────────────────────────────────────────────────────────
# 3. Ejemplo práctico: observar los cambios de estado
# ─────────────────────────────────────────────────────────────────────────────

# Vamos a crear un archivo nuevo y ver cómo cambia el estado.
# (Descomenta las líneas para ejecutar)

# echo "Hola Git" > ejemplo_status.txt    # Creamos un archivo nuevo
# git status                               # Estado: UNTRACKED (rojo)

# git add ejemplo_status.txt               # Lo agregamos al staging area
# git status                               # Estado: STAGED (verde)

# echo "Línea extra" >> ejemplo_status.txt # Modificamos el archivo
# git status                               # Estado: STAGED (verde) + MODIFIED (rojo)
#
# ¡Atención! El mismo archivo aparece en verde Y en rojo. Esto pasa porque:
# - La versión que agregaste con git add está en staging (verde)
# - Los cambios nuevos que hiciste después NO están en staging (rojo)
# - Si haces commit ahora, solo se guardará la versión verde

# ─────────────────────────────────────────────────────────────────────────────
# 4. git status en formato corto
# ─────────────────────────────────────────────────────────────────────────────

# Si prefieres una salida más compacta, usa la bandera -s (short).
git status -s

# La salida usa códigos de dos letras:
#   ?? archivo.txt    → Archivo sin rastrear (untracked)
#   A  archivo.txt    → Archivo nuevo agregado al staging
#   M  archivo.txt    → Archivo modificado (en staging si está a la izquierda)
#    M archivo.txt    → Archivo modificado (NO en staging, a la derecha)
#   MM archivo.txt    → Modificado en staging Y con más cambios sin preparar
#   D  archivo.txt    → Archivo eliminado
#   R  viejo -> nuevo → Archivo renombrado
#
# La PRIMERA columna es el estado en staging.
# La SEGUNDA columna es el estado en el directorio de trabajo.

# ─────────────────────────────────────────────────────────────────────────────
# 5. git status con rama y tracking
# ─────────────────────────────────────────────────────────────────────────────

# git status también te dice en qué rama estás y si estás al día con el remoto.
git status -b

# Ejemplo de salida:
#   On branch main
#   Your branch is ahead of 'origin/main' by 2 commits.
#
# Esto significa que tienes 2 commits locales que aún no has subido (push).

# Otros mensajes que puedes ver:
#   Your branch is behind 'origin/main' by 3 commits.
#     → El remoto tiene 3 commits que tú no tienes (necesitas pull)
#
#   Your branch and 'origin/main' have diverged,
#   and have 2 and 3 different commits each.
#     → Tú tienes 2 commits nuevos y el remoto tiene 3 que tú no tienes

# ─────────────────────────────────────────────────────────────────────────────
# 6. Ignorar archivos con .gitignore
# ─────────────────────────────────────────────────────────────────────────────

# Si git status te muestra archivos que NO quieres rastrear (como node_modules,
# archivos .env, carpetas de build), puedes decirle a Git que los ignore
# creando un archivo .gitignore en la raíz del proyecto.
#
# Esto se cubre en detalle en el capítulo 10, pero aquí va un avance:
#
#   echo "node_modules/" >> .gitignore
#   echo ".env" >> .gitignore
#   git status    # Ya no aparecerán esos archivos

# =============================================================================
# RESUMEN:
# - git status          → Ver estado completo del repositorio
# - git status -s       → Ver estado en formato corto (compact)
# - git status -b       → Ver estado incluyendo info de la rama
# - Los archivos tienen 4 estados: untracked, modified, staged, unmodified
# - La salida corta usa 2 columnas: staging (izquierda) y working dir (derecha)
# =============================================================================
