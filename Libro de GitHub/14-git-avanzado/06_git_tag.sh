#!/bin/bash

# =============================================================================
#  CAPÍTULO 14 — GIT AVANZADO
#  Archivo: 06_git_tag.sh
#  Tema: Tags — marcar versiones importantes del proyecto
# =============================================================================
#
#  Un tag es una etiqueta que se pone en un commit específico para marcarlo
#  como importante. Se usa principalmente para marcar versiones de release:
#  v1.0.0, v2.1.3, etc.
#
#  A diferencia de las ramas, los tags NO se mueven — siempre apuntan
#  al mismo commit.
#
# =============================================================================

# =============================================================================
#  TIPOS DE TAGS
# =============================================================================
#
#  1. LIGHTWEIGHT (ligero): solo un nombre que apunta a un commit
#     - Como un marcador simple
#     - No guarda información adicional
#
#  2. ANNOTATED (anotado): un objeto completo en Git
#     - Guarda: nombre, mensaje, autor, fecha
#     - RECOMENDADO para releases porque tiene más información
#     - Se puede firmar con GPG para verificar autenticidad
#
# =============================================================================

# =============================================================================
#  CREAR TAGS
# =============================================================================

# --- Tag ligero (lightweight) ---
git tag v1.0.0

# --- Tag anotado (annotated) — RECOMENDADO ---
git tag -a v1.0.0 -m "Primera versión estable del proyecto"

# --- Tag en un commit específico (no en el actual) ---
git tag -a v0.9.0 -m "Versión beta" abc1234

# =============================================================================
#  LISTAR Y VER TAGS
# =============================================================================

# --- Listar todos los tags ---
git tag

# --- Listar tags con un patrón ---
git tag -l "v1.*"       # Solo tags que empiezan con v1.
git tag -l "v2.1.*"     # Solo tags de la serie v2.1

# --- Ver información detallada de un tag anotado ---
git show v1.0.0
# Muestra: autor, fecha, mensaje y el diff del commit

# =============================================================================
#  COMPARTIR TAGS CON EL REMOTO
# =============================================================================

# Por defecto, git push NO envía tags. Debes hacerlo explícitamente:

# --- Pushear un tag específico ---
git push origin v1.0.0

# --- Pushear TODOS los tags ---
git push origin --tags

# --- Pushear solo tags anotados (no los ligeros) ---
git push origin --follow-tags

# =============================================================================
#  ELIMINAR TAGS
# =============================================================================

# --- Eliminar un tag local ---
git tag -d v1.0.0

# --- Eliminar un tag del remoto ---
git push origin --delete v1.0.0
# O equivalente:
git push origin :refs/tags/v1.0.0

# =============================================================================
#  VERSIONADO SEMÁNTICO (SemVer)
# =============================================================================
#
#  El estándar más usado para nombrar versiones es Semantic Versioning:
#
#    vMAJOR.MINOR.PATCH
#    v1.2.3
#
#  MAJOR (1): cambios que rompen compatibilidad con versiones anteriores
#  MINOR (2): nueva funcionalidad que es compatible hacia atrás
#  PATCH (3): correcciones de bugs compatibles hacia atrás
#
#  Ejemplos:
#    v1.0.0 → primera versión estable
#    v1.1.0 → nueva funcionalidad agregada
#    v1.1.1 → corrección de un bug
#    v2.0.0 → cambio que rompe compatibilidad
#
#  Pre-releases:
#    v1.0.0-alpha.1
#    v1.0.0-beta.2
#    v1.0.0-rc.1 (release candidate)
#
# =============================================================================

# =============================================================================
#  CHECKOUT A UN TAG (ver código de una versión)
# =============================================================================

# Ver el código tal como estaba en v1.0.0
git checkout v1.0.0
# Esto te pone en "detached HEAD" — puedes ver pero no hacer commits.

# Para crear una rama desde un tag:
git checkout -b hotfix-v1 v1.0.0

# Volver a tu rama normal:
git checkout main

# =============================================================================
#  GITHUB RELEASES
# =============================================================================
#
#  En GitHub, los tags se convierten automáticamente en "Releases".
#  Puedes ir a la sección Releases de tu repositorio para:
#  - Ver todas las versiones
#  - Agregar notas de release (changelog)
#  - Adjuntar archivos binarios (APK, ejecutables, etc.)
#  - Marcar como pre-release o latest
#
# =============================================================================

echo ""
echo "=== Fin de 06_git_tag.sh ==="
echo "Tags son esenciales para releases. Siguiente: git bisect."
