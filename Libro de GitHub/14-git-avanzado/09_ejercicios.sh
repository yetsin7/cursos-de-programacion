#!/bin/bash

# =============================================================================
#  CAPÍTULO 14 — GIT AVANZADO
#  Archivo: 09_ejercicios.sh
#  Tema: Ejercicios de práctica para comandos avanzados de Git
# =============================================================================

# =============================================================================
#  EJERCICIO 1: STASH
# =============================================================================
#  Objetivo: Guardar cambios temporalmente y recuperarlos.
#
#  1. Crea un repositorio nuevo y haz un commit inicial
#  2. Edita un archivo (sin hacer commit)
#  3. Guarda los cambios con: git stash push -m "cambios temporales"
#  4. Verifica que el archivo volvió al estado original: git status
#  5. Crea otra rama y haz un commit
#  6. Vuelve a la rama original
#  7. Recupera tus cambios con: git stash pop
#  8. Verifica que tus cambios están de vuelta
# =============================================================================

# =============================================================================
#  EJERCICIO 2: REBASE INTERACTIVO — SQUASH
# =============================================================================
#  Objetivo: Combinar varios commits en uno solo.
#
#  1. Crea un repositorio con 5 commits pequeños:
#     "agrega archivo1" "fix typo" "otro fix" "agrega archivo2" "fix final"
#  2. Usa rebase interactivo para los últimos 4 commits:
#     git rebase -i HEAD~4
#  3. Cambia "fix typo", "otro fix" y "fix final" a "squash" o "fixup"
#  4. Verifica que quedaron solo 2 commits: git log --oneline
# =============================================================================

# =============================================================================
#  EJERCICIO 3: CHERRY-PICK
# =============================================================================
#  Objetivo: Copiar un commit de una rama a otra.
#
#  1. Crea dos ramas: "feature-a" y "feature-b"
#  2. En "feature-a", haz 3 commits
#  3. Anota el hash del segundo commit
#  4. Cambia a "feature-b"
#  5. Cherry-pick el segundo commit: git cherry-pick <hash>
#  6. Verifica que el commit aparece en "feature-b": git log --oneline
# =============================================================================

# =============================================================================
#  EJERCICIO 4: RESET — ENTENDER LOS TRES MODOS
# =============================================================================
#  Objetivo: Experimentar con --soft, --mixed y --hard.
#
#  Preparación: crea un repo con 3 commits.
#
#  A) Reset --soft:
#     git reset --soft HEAD~1
#     Verifica: git status → los cambios están en staging
#     Recupera: git commit -m "commit restaurado"
#
#  B) Reset --mixed:
#     git reset HEAD~1
#     Verifica: git status → los cambios están en working dir (no staging)
#     Recupera: git add . && git commit -m "commit restaurado"
#
#  C) Reset --hard:
#     git reset --hard HEAD~1
#     Verifica: git status → limpio, los cambios desaparecieron
#     Recupera: git reflog → encuentra el hash → git reset --hard <hash>
# =============================================================================

# =============================================================================
#  EJERCICIO 5: REVERT
# =============================================================================
#  Objetivo: Revertir un commit de forma segura.
#
#  1. Crea un repo con 4 commits
#  2. Revierte el segundo commit: git revert <hash>
#  3. Verifica que: git log muestra 5 commits (4 originales + 1 revert)
#  4. El contenido del archivo refleja que el segundo commit fue anulado
# =============================================================================

# =============================================================================
#  EJERCICIO 6: TAGS
# =============================================================================
#  Objetivo: Crear y manejar tags.
#
#  1. Crea un repositorio con varios commits
#  2. Crea un tag anotado: git tag -a v1.0.0 -m "Versión 1.0"
#  3. Haz más commits
#  4. Crea otro tag: git tag -a v1.1.0 -m "Versión 1.1"
#  5. Lista los tags: git tag
#  6. Ver detalles: git show v1.0.0
#  7. Checkout al tag: git checkout v1.0.0
#  8. Vuelve a main: git checkout main
# =============================================================================

# =============================================================================
#  EJERCICIO 7: BISECT
# =============================================================================
#  Objetivo: Encontrar un "bug" con búsqueda binaria.
#
#  1. Crea un repo con 10 commits. En el commit 6, introduce un "bug"
#     (por ejemplo, cambia "funciona=true" a "funciona=false")
#  2. Inicia bisect: git bisect start
#  3. Marca HEAD como malo: git bisect bad
#  4. Marca el commit 1 como bueno: git bisect good <hash-commit-1>
#  5. En cada paso, revisa si funciona=true o false
#  6. Marca como good o bad según corresponda
#  7. Bisect debe encontrar el commit 6 como el culpable
#  8. Termina: git bisect reset
# =============================================================================

# =============================================================================
#  EJERCICIO 8: REFLOG — RECUPERAR TRABAJO PERDIDO
# =============================================================================
#  Objetivo: Usar reflog para recuperar commits después de un reset --hard.
#
#  1. Crea un repo con 5 commits
#  2. Haz: git reset --hard HEAD~3 (elimina los últimos 3 commits)
#  3. Verifica: git log --oneline (solo muestra 2 commits)
#  4. Ahora recupera con reflog:
#     git reflog (encuentra el hash de los commits perdidos)
#     git reset --hard <hash> (restaura los 5 commits)
#  5. Verifica: git log --oneline (los 5 commits están de vuelta)
# =============================================================================

echo ""
echo "=== Fin de 09_ejercicios.sh ==="
echo "Practica cada ejercicio. Estos comandos avanzados te harán un profesional."
