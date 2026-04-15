#!/bin/bash
# =============================================================================
# ARCHIVO: 05_dejar_de_rastrear.sh
# TEMA: git rm --cached — Dejar de rastrear archivos que ya están en el repo
# =============================================================================
#
# Uno de los errores más comunes: subir un archivo que no debería estar
# en el repositorio (como .env o node_modules/) y luego agregarlo al
# .gitignore esperando que desaparezca. PERO NO FUNCIONA ASÍ.
#
# .gitignore solo previene que archivos NUEVOS sean rastreados.
# Para dejar de rastrear archivos que ya tienen commits, necesitas
# git rm --cached.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# EL PROBLEMA
# ─────────────────────────────────────────────────────────────────────────────

# Situación típica:
# 1. Haces commit de .env con tus contraseñas (¡oops!)
# 2. Agregas .env al .gitignore
# 3. Haces commit del .gitignore
# 4. Pero .env SIGUE apareciendo en git status y en el repositorio remoto

# ¿Por qué? Porque Git ya está rastreando .env.
# El .gitignore solo ignora archivos que Git NO conoce (untracked).
# Una vez que Git rastrea un archivo, el .gitignore no lo afecta.

echo "========================================="
echo "  EL PROBLEMA"
echo "========================================="
echo ""
echo "  Si ya hiciste commit de un archivo, agregarlo al"
echo "  .gitignore NO lo elimina del rastreo de Git."
echo "  Necesitas 'git rm --cached' para desrastrearlo."
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# git rm --cached: LA SOLUCIÓN
# ─────────────────────────────────────────────────────────────────────────────

# git rm --cached ELIMINA el archivo del índice de Git (staging area)
# pero lo MANTIENE en tu disco duro. Es decir:
# - Git deja de rastrear el archivo
# - El archivo NO se borra de tu computadora
# - En el siguiente commit, Git registra que el archivo fue eliminado del repo
# - A partir de ahí, el .gitignore sí lo ignora

# SINTAXIS:
# git rm --cached <archivo>          → Un archivo específico
# git rm --cached -r <carpeta>       → Una carpeta completa (recursivo)

# ─────────────────────────────────────────────────────────────────────────────
# EJEMPLO 1: DEJAR DE RASTREAR UN ARCHIVO
# ─────────────────────────────────────────────────────────────────────────────

# Paso 1: Verificar que el archivo está siendo rastreado
git ls-files | grep ".env"
# Si aparece .env, Git lo está rastreando

# Paso 2: Agregar .env al .gitignore (si no lo has hecho)
echo ".env" >> .gitignore

# Paso 3: Eliminar .env del rastreo de Git (SIN borrarlo del disco)
git rm --cached .env

# Paso 4: Hacer commit del cambio
git add .gitignore
git commit -m "Dejar de rastrear .env y agregarlo al .gitignore"

# Paso 5: Verificar
git status
# .env ya no debería aparecer

echo ""
echo "========================================="
echo "  EJEMPLO: DEJAR DE RASTREAR .env"
echo "========================================="
echo ""
echo "  1. echo '.env' >> .gitignore"
echo "  2. git rm --cached .env"
echo "  3. git add .gitignore"
echo "  4. git commit -m 'Dejar de rastrear .env'"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# EJEMPLO 2: DEJAR DE RASTREAR UNA CARPETA COMPLETA
# ─────────────────────────────────────────────────────────────────────────────

# Si subiste node_modules/ o build/ al repositorio por error:

# Paso 1: Agregar al .gitignore
echo "node_modules/" >> .gitignore

# Paso 2: Eliminar recursivamente del rastreo (la bandera -r es obligatoria para carpetas)
git rm --cached -r node_modules/

# Paso 3: Commit
git add .gitignore
git commit -m "Eliminar node_modules del rastreo"

# Paso 4: Push (para que el cambio se refleje en el remoto)
git push origin main

echo ""
echo "========================================="
echo "  EJEMPLO: DEJAR DE RASTREAR CARPETA"
echo "========================================="
echo ""
echo "  git rm --cached -r node_modules/"
echo "  git rm --cached -r build/"
echo "  git rm --cached -r .dart_tool/"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# DIFERENCIA ENTRE git rm Y git rm --cached
# ─────────────────────────────────────────────────────────────────────────────

echo "========================================="
echo "  git rm vs git rm --cached"
echo "========================================="
echo ""
echo "  git rm archivo          → Elimina del repo Y del disco"
echo "                            (borra el archivo completamente)"
echo ""
echo "  git rm --cached archivo → Elimina SOLO del repo"
echo "                            (el archivo queda en tu disco)"
echo ""
echo "  SIEMPRE usa --cached si quieres conservar el archivo local."
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# CASO ESPECIAL: LIMPIAR TODO Y REPLICAR EL .GITIGNORE
# ─────────────────────────────────────────────────────────────────────────────

# Si tu .gitignore tiene muchas reglas nuevas y quieres que Git
# "olvide" todos los archivos rastreados y vuelva a evaluar el .gitignore:

# ⚠️ CUIDADO: Este comando remueve TODOS los archivos del índice de Git
# y luego los vuelve a agregar respetando el .gitignore.

# Paso 1: Eliminar todo del índice de Git (sin borrar archivos)
git rm -r --cached .

# Paso 2: Volver a agregar todo (ahora Git respeta el .gitignore actualizado)
git add .

# Paso 3: Commit
git commit -m "Reaplica .gitignore — elimina archivos que no deberían rastrearse"

echo ""
echo "========================================="
echo "  REAPLICAR .GITIGNORE COMPLETO"
echo "========================================="
echo ""
echo "  git rm -r --cached ."
echo "  git add ."
echo "  git commit -m 'Reaplicar .gitignore'"
echo ""
echo "  ⚠️ Úsalo con cuidado — remueve todo y reagrega."
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# ADVERTENCIA: ARCHIVOS CON SECRETOS
# ─────────────────────────────────────────────────────────────────────────────

# Si subiste un archivo con contraseñas, API keys o secretos:
# 1. git rm --cached elimina el archivo de la versión ACTUAL
# 2. PERO el archivo sigue en el HISTORIAL de Git
# 3. Cualquiera puede verlo en commits anteriores
#
# Para eliminar completamente un archivo del historial, necesitas
# herramientas como:
# - git filter-branch (antiguo, lento)
# - BFG Repo-Cleaner (rápido, recomendado): https://rufflewind.com/2017-08-19/faq-bfg
# - git filter-repo (moderno, recomendado): https://github.com/newren/git-filter-repo
#
# Y después de limpiar el historial, CAMBIA TUS CONTRASEÑAS Y API KEYS.
# Si un secreto fue público aunque sea por un momento, considéralo comprometido.

echo "========================================="
echo "  ⚠️ ADVERTENCIA: SECRETOS EN EL HISTORIAL"
echo "========================================="
echo ""
echo "  git rm --cached NO borra el archivo del historial."
echo "  Los secretos siguen visibles en commits anteriores."
echo ""
echo "  Para limpieza completa del historial:"
echo "  - BFG Repo-Cleaner"
echo "  - git filter-repo"
echo ""
echo "  Y SIEMPRE cambia las contraseñas/keys comprometidas."
echo ""
