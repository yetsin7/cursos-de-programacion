#!/bin/bash

# =============================================================================
#  CAPÍTULO 13 — CONFLICTOS EN GIT
#  Archivo: 03_resolver_conflictos.sh
#  Tema: Resolución manual de conflictos paso a paso
# =============================================================================
#
#  Resolver un conflicto significa: abrir el archivo, decidir qué código
#  conservar, eliminar los marcadores de conflicto, y confirmar la resolución
#  con un commit.
#
# =============================================================================

# =============================================================================
#  PASO A PASO: RESOLVER UN CONFLICTO MANUALMENTE
# =============================================================================

# --- Paso 1: Identificar los archivos con conflictos ---
git status
# Busca la sección "Unmerged paths" — esos son los archivos con conflictos

# --- Paso 2: Abrir el archivo y entender el conflicto ---
# Abre el archivo en tu editor. Verás algo como:
#
#  <<<<<<< HEAD
#  const titulo = "Mi Aplicación";
#  =======
#  const titulo = "Mi App Genial";
#  >>>>>>> feature
#

# --- Paso 3: Decidir qué conservar ---
# Tienes 4 opciones:

# OPCIÓN A: Conservar solo TU versión (HEAD)
# Elimina los marcadores y la versión entrante, dejando:
#   const titulo = "Mi Aplicación";

# OPCIÓN B: Conservar solo la versión ENTRANTE
# Elimina los marcadores y tu versión, dejando:
#   const titulo = "Mi App Genial";

# OPCIÓN C: Combinar ambas versiones
# Elimina los marcadores y escribe algo que combine ambas:
#   const titulo = "Mi App Genial - Mi Aplicación";

# OPCIÓN D: Reescribir completamente
# Elimina todo y escribe algo nuevo:
#   const titulo = "Nombre Definitivo";

# --- Paso 4: Eliminar TODOS los marcadores de conflicto ---
# Asegúrate de eliminar las tres líneas de marcadores:
#   <<<<<<< HEAD        ← eliminar
#   =======             ← eliminar
#   >>>>>>> feature     ← eliminar

# --- Paso 5: Verificar que no quedan marcadores ---
grep -rn "<<<<<<< \|=======$\|>>>>>>> " .

# --- Paso 6: Marcar el archivo como resuelto ---
# Una vez editado y limpio, agrega el archivo al staging
git add mensaje.txt

# --- Paso 7: Completar el merge con un commit ---
git commit
# Git abrirá el editor con un mensaje de merge por defecto.
# Puedes aceptarlo tal cual o personalizarlo.

# También puedes hacerlo en una línea:
git commit -m "Resuelve conflicto en mensaje.txt: conserva versión de main"

# =============================================================================
#  ATAJOS: ACEPTAR UNA VERSIÓN COMPLETA SIN EDITAR
# =============================================================================

# Si sabes que quieres conservar TU versión completa del archivo:
git checkout --ours mensaje.txt
git add mensaje.txt

# Si sabes que quieres conservar la versión ENTRANTE completa:
git checkout --theirs mensaje.txt
git add mensaje.txt

# CUIDADO: --ours y --theirs reemplazan el archivo COMPLETO,
# no solo las líneas en conflicto. Úsalo solo cuando estés seguro.

# =============================================================================
#  ABORTAR UN MERGE SI NO QUIERES RESOLVER AHORA
# =============================================================================

# Si el conflicto es muy complicado y quieres volver al estado anterior:
git merge --abort

# Esto cancela el merge completamente y te devuelve al estado previo.
# Útil cuando necesitas tiempo para pensar o consultar con tu equipo.

# =============================================================================
#  RESOLVER CONFLICTO DE ELIMINAR vs MODIFICAR
# =============================================================================
#
#  Cuando una rama elimina un archivo y la otra lo modifica:
#
#  Para CONSERVAR el archivo (aceptar la modificación):
#    git add archivo.txt
#    git commit
#
#  Para ELIMINAR el archivo (aceptar la eliminación):
#    git rm archivo.txt
#    git commit
#
# =============================================================================

# =============================================================================
#  VERIFICACIÓN FINAL
# =============================================================================

# Después de resolver y hacer commit, verifica:
git status          # No debe haber "Unmerged paths"
git log --oneline   # Debe aparecer el merge commit

echo ""
echo "=== Fin de 03_resolver_conflictos.sh ==="
echo "Ya sabes resolver conflictos manualmente. Siguiente: herramientas gráficas."
