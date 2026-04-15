#!/bin/bash

# =============================================================================
#  CAPÍTULO 14 — GIT AVANZADO
#  Archivo: 07_git_bisect.sh
#  Tema: Encontrar el commit exacto que introdujo un bug
# =============================================================================
#
#  git bisect usa búsqueda binaria para encontrar el commit exacto que
#  introdujo un bug. En vez de revisar 100 commits uno por uno, bisect
#  encuentra el culpable en solo ~7 pasos (log2 de 100).
#
# =============================================================================

# =============================================================================
#  ¿CÓMO FUNCIONA BISECT?
# =============================================================================
#
#  1. Le dices a Git un commit donde el bug EXISTE (bad)
#  2. Le dices un commit donde el bug NO EXISTÍA (good)
#  3. Git salta al commit del medio y te pregunta: ¿el bug existe aquí?
#  4. Respondes "good" o "bad"
#  5. Git divide el rango a la mitad y repite
#  6. En pocos pasos, encuentra el commit exacto que introdujo el bug
#
#  Ejemplo con 100 commits:
#    Paso 1: revisa commit 50  → "bad"  → el bug está entre 1-50
#    Paso 2: revisa commit 25  → "good" → el bug está entre 25-50
#    Paso 3: revisa commit 37  → "bad"  → el bug está entre 25-37
#    Paso 4: revisa commit 31  → "good" → el bug está entre 31-37
#    Paso 5: revisa commit 34  → "bad"  → el bug está entre 31-34
#    Paso 6: revisa commit 32  → "good" → el bug está entre 32-34
#    Paso 7: revisa commit 33  → "¡ESTE ES EL CULPABLE!"
#
# =============================================================================

# =============================================================================
#  BISECT PASO A PASO
# =============================================================================

# --- Paso 1: Iniciar bisect ---
git bisect start

# --- Paso 2: Marcar el commit actual como "malo" (tiene el bug) ---
git bisect bad

# --- Paso 3: Marcar un commit donde todo funcionaba como "bueno" ---
# Usa un hash de commit, tag, o referencia donde sabes que no había bug
git bisect good v1.0.0
# O con hash:
git bisect good abc1234

# --- Paso 4: Git salta a un commit intermedio ---
# Ahora estás en un commit a la mitad. Prueba si el bug existe:
# - Compila el proyecto
# - Ejecuta los tests
# - Prueba manualmente

# --- Paso 5: Marcar según el resultado ---
# Si el bug EXISTE en este commit:
git bisect bad

# Si el bug NO EXISTE en este commit:
git bisect good

# --- Paso 6: Repetir hasta que Git encuentre el commit culpable ---
# Git te dirá algo como:
#   abc1234 is the first bad commit
#   commit abc1234
#   Author: desarrollador@email.com
#   Date: Mon Jan 15 10:30:00 2024
#
#       Agrega nueva validación al formulario

# --- Paso 7: Terminar bisect y volver a la normalidad ---
git bisect reset

# =============================================================================
#  BISECT AUTOMÁTICO CON UN SCRIPT
# =============================================================================
#
#  Si tienes un test que detecta el bug automáticamente, bisect puede
#  ejecutar todo sin tu intervención:
# =============================================================================

# El script debe retornar 0 si está "good" y 1 (o cualquier no-cero) si "bad"
git bisect start HEAD v1.0.0
git bisect run npm test
# O con un script personalizado:
git bisect run bash test-bug.sh

# Git ejecuta el script en cada paso y marca automáticamente good/bad.
# En segundos encuentras el commit culpable entre cientos de commits.

# =============================================================================
#  BISECT CON COMMITS QUE NO COMPILAN
# =============================================================================

# Si Git te lleva a un commit que no compila y no puedes probar:
git bisect skip
# Git intentará con un commit cercano en su lugar.

# =============================================================================
#  VER EL PROGRESO DE BISECT
# =============================================================================

# Ver el log de lo que has marcado
git bisect log

# Visualizar el progreso
git bisect visualize

# =============================================================================
#  EJEMPLO PRÁCTICO
# =============================================================================
#
#  Situación: el botón de "Comprar" dejó de funcionar. No sabes cuándo se
#  rompió. El último tag donde funcionaba es v2.3.0.
#
#  git bisect start
#  git bisect bad              # HEAD tiene el bug
#  git bisect good v2.3.0     # v2.3.0 funcionaba
#
#  [Git te lleva a un commit]  → pruebas el botón → funciona
#  git bisect good
#
#  [Git te lleva a otro]       → pruebas → NO funciona
#  git bisect bad
#
#  [Después de ~7 pasos]
#  → "commit xyz789 es el primer commit malo"
#  → Abres el diff de xyz789 y encuentras la línea que rompió el botón
#
#  git bisect reset
# =============================================================================

echo ""
echo "=== Fin de 07_git_bisect.sh ==="
echo "Bisect es un detective. Siguiente: git reflog."
