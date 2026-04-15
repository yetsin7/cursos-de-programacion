#!/bin/bash

# =============================================================================
#  CAPÍTULO 14 — GIT AVANZADO
#  Archivo: 04_git_reset.sh
#  Tema: git reset — deshacer commits (soft, mixed, hard)
# =============================================================================
#
#  git reset mueve el puntero HEAD hacia atrás, deshaciendo commits.
#  Tiene tres modos que afectan de forma diferente tus archivos.
#
#  IMPORTANTE: reset reescribe el historial. Solo úsalo en commits
#  que NO has pusheado al remoto. Para commits compartidos, usa revert.
#
# =============================================================================

# =============================================================================
#  LAS TRES ÁREAS DE GIT (recordatorio)
# =============================================================================
#
#  Working Directory → Staging Area → Repository
#  (tus archivos)      (git add)      (git commit)
#
#  Los tres modos de reset difieren en cuántas áreas "deshacen":
#
#  --soft:  solo deshace el commit. Staging y archivos intactos.
#  --mixed: deshace el commit Y el staging. Archivos intactos. (DEFAULT)
#  --hard:  deshace TODO. Commit, staging y archivos. PELIGROSO.
#
# =============================================================================

# =============================================================================
#  GIT RESET --SOFT
# =============================================================================
#
#  Deshace el commit pero mantiene los cambios en staging (listos para commit).
#  Es como "deshacer commit pero mantener todo preparado".
#
#  Ideal para: corregir el mensaje de un commit o combinar varios commits.
# =============================================================================

# Deshacer el último commit, mantener cambios en staging
git reset --soft HEAD~1

# Deshacer los últimos 3 commits
git reset --soft HEAD~3

# Ahora puedes hacer un nuevo commit con los mismos cambios:
git commit -m "Nuevo mensaje mejorado"

# =============================================================================
#  GIT RESET --MIXED (el modo por defecto)
# =============================================================================
#
#  Deshace el commit Y quita los archivos del staging, pero los cambios
#  siguen en tu directorio de trabajo. Tendrás que hacer git add de nuevo.
#
#  Ideal para: reorganizar qué archivos incluir en cada commit.
# =============================================================================

# Deshacer el último commit, quitar del staging pero mantener archivos
git reset HEAD~1
# (--mixed es el default, no necesitas escribirlo)

# También equivalente a:
git reset --mixed HEAD~1

# Ahora puedes elegir qué archivos agregar a cada commit:
git add archivo1.txt
git commit -m "Primer commit reorganizado"
git add archivo2.txt
git commit -m "Segundo commit reorganizado"

# =============================================================================
#  GIT RESET --HARD
# =============================================================================
#
#  ⚠️  PELIGROSO: deshace el commit, el staging Y elimina los cambios
#  de tus archivos. Todo se pierde como si nunca hubiera existido.
#
#  Ideal para: descartar trabajo que definitivamente no quieres.
# =============================================================================

# Deshacer el último commit Y eliminar todos los cambios
git reset --hard HEAD~1

# Volver a un commit específico, descartando todo lo posterior
git reset --hard abc1234

# Volver al estado exacto del remoto (descarta todos los cambios locales)
git reset --hard origin/main

# =============================================================================
#  TABLA COMPARATIVA
# =============================================================================
#
#  Modo     │ Commits │ Staging │ Archivos │ Uso típico
#  ─────────┼─────────┼─────────┼──────────┼─────────────────────────
#  --soft   │ Deshace │ Intacto │ Intactos │ Rehacer el último commit
#  --mixed  │ Deshace │ Deshace │ Intactos │ Reorganizar commits
#  --hard   │ Deshace │ Deshace │ ELIMINA  │ Descartar todo
#
# =============================================================================

# =============================================================================
#  RESET DE ARCHIVOS INDIVIDUALES (quitar del staging)
# =============================================================================

# Quitar un archivo del staging sin perder cambios
git reset HEAD archivo.txt
# Equivalente moderno:
git restore --staged archivo.txt

# =============================================================================
#  RESET A UN COMMIT ESPECÍFICO
# =============================================================================

# Usando el hash del commit
git reset --soft abc1234

# Usando referencias relativas
git reset --soft HEAD~1     # un commit atrás
git reset --soft HEAD~5     # cinco commits atrás
git reset --soft HEAD^      # el padre del commit actual (equivale a HEAD~1)

# =============================================================================
#  ¿QUÉ PASA SI ME EQUIVOQUÉ CON RESET --HARD?
# =============================================================================
#
#  ¡No todo está perdido! Git guarda un registro de todo en el REFLOG.
#  Puedes recuperar commits "eliminados" con:
#
#    git reflog
#    git reset --hard <hash-del-commit-perdido>
#
#  Ver archivo 08_git_reflog.sh para más detalles.
# =============================================================================

echo ""
echo "=== Fin de 04_git_reset.sh ==="
echo "Entiende bien los tres modos antes de usarlos. Siguiente: git revert."
