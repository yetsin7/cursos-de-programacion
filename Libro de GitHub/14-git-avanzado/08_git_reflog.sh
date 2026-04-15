#!/bin/bash

# =============================================================================
#  CAPÍTULO 14 — GIT AVANZADO
#  Archivo: 08_git_reflog.sh
#  Tema: Recuperación con reflog — tu red de seguridad en Git
# =============================================================================
#
#  git reflog es un registro de TODOS los movimientos de HEAD en tu
#  repositorio local. Incluso cuando haces reset --hard o eliminas ramas,
#  reflog recuerda dónde estuviste. Es tu última línea de defensa para
#  recuperar trabajo "perdido".
#
# =============================================================================

# =============================================================================
#  ¿QUÉ ES REFLOG?
# =============================================================================
#
#  Cada vez que HEAD se mueve (commit, checkout, reset, rebase, merge),
#  Git guarda una entrada en el reflog. Es como un historial de navegación
#  de tu repositorio.
#
#  IMPORTANTE:
#  - Reflog es LOCAL — no se comparte con el remoto
#  - Las entradas expiran después de 90 días (por defecto)
#  - Solo existe en tu máquina, no se pushea
#
# =============================================================================

# =============================================================================
#  VER EL REFLOG
# =============================================================================

# --- Ver el reflog completo ---
git reflog
# Salida ejemplo:
#   abc1234 HEAD@{0}: commit: Agrega nueva funcionalidad
#   def5678 HEAD@{1}: checkout: moving from feature to main
#   ghi9012 HEAD@{2}: commit: Corrige bug de login
#   jkl3456 HEAD@{3}: reset: moving to HEAD~2
#   mno7890 HEAD@{4}: commit: Actualiza estilos
#   pqr1234 HEAD@{5}: commit: Agrega componente de perfil

# --- Ver reflog con fechas ---
git reflog --date=relative
# Muestra hace cuánto tiempo fue cada acción

# --- Ver reflog de una rama específica ---
git reflog show feature

# =============================================================================
#  RECUPERAR UN COMMIT PERDIDO DESPUÉS DE RESET --HARD
# =============================================================================
#
#  Escenario: hiciste git reset --hard HEAD~3 y eliminaste 3 commits.
#  ¡Pero esos commits tenían trabajo importante!
# =============================================================================

# Paso 1: Ver el reflog para encontrar el commit perdido
git reflog
# Busca la entrada ANTES del reset. Ejemplo:
#   abc1234 HEAD@{0}: reset: moving to HEAD~3    ← el reset que hiciste
#   xyz9999 HEAD@{1}: commit: Trabajo importante  ← ¡aquí está tu trabajo!

# Paso 2: Restaurar el commit perdido
git reset --hard xyz9999
# ¡Tus 3 commits están de vuelta!

# O si prefieres crear una rama nueva con ese trabajo:
git checkout -b recuperacion xyz9999

# =============================================================================
#  RECUPERAR UNA RAMA ELIMINADA
# =============================================================================
#
#  Escenario: eliminaste una rama por accidente con git branch -D feature
# =============================================================================

# Paso 1: Buscar en el reflog el último commit de esa rama
git reflog
# Busca entradas relacionadas con la rama eliminada

# Paso 2: Recrear la rama apuntando al commit encontrado
git checkout -b feature abc1234

# =============================================================================
#  RECUPERAR DESPUÉS DE UN REBASE MAL HECHO
# =============================================================================
#
#  Escenario: hiciste un rebase interactivo y el resultado es un desastre.
# =============================================================================

# Paso 1: Ver el reflog y encontrar el estado antes del rebase
git reflog
# Busca la entrada "rebase (start)" — el estado justo antes es el bueno

# Paso 2: Volver al estado anterior
git reset --hard HEAD@{5}
# (usa el número correcto que encontraste en el reflog)

# =============================================================================
#  REFERENCIAS DEL REFLOG
# =============================================================================

# HEAD@{0} → estado actual
# HEAD@{1} → estado anterior
# HEAD@{N} → N estados atrás

# También puedes usar fechas:
git reflog --date=iso
git diff HEAD@{2024-01-15}

# =============================================================================
#  CONFIGURAR LA EXPIRACIÓN DEL REFLOG
# =============================================================================

# Por defecto, las entradas expiran en 90 días.
# Puedes cambiarlo:
git config --global gc.reflogExpire 180
# Ahora las entradas duran 180 días

# Las entradas "unreachable" (commits sin rama) expiran en 30 días:
git config --global gc.reflogExpireUnreachable 60

# =============================================================================
#  RESUMEN: REFLOG ES TU RED DE SEGURIDAD
# =============================================================================
#
#  Casi NADA es irreversible en Git si tienes el reflog:
#
#  ✅ reset --hard accidental    → git reflog + git reset --hard <hash>
#  ✅ branch -D accidental       → git reflog + git checkout -b <rama> <hash>
#  ✅ rebase que salió mal        → git reflog + git reset --hard <hash>
#  ✅ merge que no querías        → git reflog + git reset --hard <hash>
#
#  Lo único que NO puedes recuperar:
#  ❌ Cambios que NUNCA fueron commiteados (ni siquiera stashed)
#  ❌ Entradas de reflog que ya expiraron
#
#  Moraleja: haz commits frecuentes, aunque sean temporales.
# =============================================================================

echo ""
echo "=== Fin de 08_git_reflog.sh ==="
echo "Reflog es tu mejor amigo en emergencias. Siguiente: ejercicios."
