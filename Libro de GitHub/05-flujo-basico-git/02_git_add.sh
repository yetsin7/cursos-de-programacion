#!/bin/bash
# =============================================================================
# ARCHIVO: 02_git_add.sh
# TEMA: Preparar archivos para commit con git add (staging)
# =============================================================================
#
# git add es el puente entre tu directorio de trabajo y el staging area.
# Selecciona qué cambios quieres incluir en tu próximo commit.
# Dominar git add te da control preciso sobre tu historial de commits.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# 1. Agregar un archivo específico
# ─────────────────────────────────────────────────────────────────────────────

# La forma más básica: agregar un archivo por su nombre.
# Solo ese archivo pasa al staging area; los demás no se tocan.
git add archivo.txt

# Puedes verificar que se agregó correctamente con:
git status
# El archivo aparecerá en verde bajo "Changes to be committed"

# ─────────────────────────────────────────────────────────────────────────────
# 2. Agregar múltiples archivos específicos
# ─────────────────────────────────────────────────────────────────────────────

# Puedes listar varios archivos separados por espacio en un solo comando.
# Útil cuando quieres agregar archivos selectivamente.
git add archivo1.txt archivo2.txt archivo3.txt

# También puedes agregar archivos de diferentes carpetas:
git add src/index.js docs/README.md tests/test_login.js

# ─────────────────────────────────────────────────────────────────────────────
# 3. Agregar por patrón (wildcards / comodines)
# ─────────────────────────────────────────────────────────────────────────────

# Puedes usar patrones glob para agregar archivos que coincidan.

# Agregar todos los archivos .js del directorio actual:
git add *.js

# Agregar todos los archivos .py en cualquier subcarpeta:
git add "**/*.py"

# Agregar todos los archivos dentro de una carpeta específica:
git add src/

# ─────────────────────────────────────────────────────────────────────────────
# 4. Agregar TODOS los cambios
# ─────────────────────────────────────────────────────────────────────────────

# git add . (punto) agrega TODOS los archivos nuevos, modificados y eliminados
# desde el directorio actual hacia abajo.
git add .

# git add -A (--all) agrega ABSOLUTAMENTE TODO el repositorio, sin importar
# desde qué directorio ejecutes el comando.
git add -A
git add --all    # Equivalente a -A

# ⚠️ CUIDADO con git add . y git add -A:
# Pueden agregar archivos que no quieres (secretos, archivos grandes, basura).
# Siempre verifica con git status antes de hacer commit.
# Mejor aún: configura tu .gitignore antes de usar estos comandos.

# ─────────────────────────────────────────────────────────────────────────────
# 5. Agregar solo archivos modificados (no nuevos)
# ─────────────────────────────────────────────────────────────────────────────

# git add -u (--update) agrega solo archivos que Git ya conoce y que fueron
# modificados o eliminados. NO agrega archivos nuevos (untracked).
git add -u
git add --update    # Equivalente a -u

# Esto es útil cuando creaste archivos temporales que no quieres rastrear,
# pero sí quieres agregar todos los cambios a archivos existentes.

# ─────────────────────────────────────────────────────────────────────────────
# 6. Agregar partes específicas de un archivo (patch mode)
# ─────────────────────────────────────────────────────────────────────────────

# git add -p (--patch) te permite agregar solo PARTES de un archivo.
# Git te muestra cada "hunk" (bloque de cambios) y te pregunta qué hacer.
git add -p archivo.txt

# Las opciones interactivas son:
#   y → Sí, agregar este bloque al staging
#   n → No, omitir este bloque
#   s → Dividir el bloque en partes más pequeñas
#   q → Salir sin agregar más bloques
#   ? → Ver ayuda con todas las opciones
#
# Esto es INCREÍBLEMENTE útil cuando un archivo tiene cambios de dos tareas
# diferentes y quieres hacer commits separados para cada una.

# ─────────────────────────────────────────────────────────────────────────────
# 7. Quitar archivos del staging area (unstage)
# ─────────────────────────────────────────────────────────────────────────────

# Si agregaste un archivo por error al staging, puedes sacarlo sin perder
# los cambios en el archivo. Solo lo quitas del "área de preparación".

# Forma moderna (Git 2.23+): git restore --staged
git restore --staged archivo.txt

# Forma clásica: git reset HEAD
git reset HEAD archivo.txt

# Ambos comandos hacen lo mismo: sacan el archivo del staging area,
# pero los cambios siguen en tu directorio de trabajo. No pierdes nada.

# Para sacar TODOS los archivos del staging:
git restore --staged .
git reset HEAD .

# ─────────────────────────────────────────────────────────────────────────────
# 8. Diferencia entre git add . vs git add -A vs git add -u
# ─────────────────────────────────────────────────────────────────────────────

# ┌─────────────┬──────────────┬──────────────┬──────────────┐
# │ Comando     │ Nuevos       │ Modificados  │ Eliminados   │
# ├─────────────┼──────────────┼──────────────┼──────────────┤
# │ git add .   │ ✅ (dir act) │ ✅ (dir act) │ ✅ (dir act) │
# │ git add -A  │ ✅ (todo)    │ ✅ (todo)    │ ✅ (todo)    │
# │ git add -u  │ ❌           │ ✅ (todo)    │ ✅ (todo)    │
# └─────────────┴──────────────┴──────────────┴──────────────┘
#
# git add .  → Todo desde el directorio actual hacia abajo
# git add -A → Todo en TODO el repositorio
# git add -u → Solo archivos ya rastreados (no agrega nuevos)

# =============================================================================
# RESUMEN:
# - git add archivo.txt     → Agregar un archivo específico
# - git add *.js            → Agregar por patrón
# - git add .               → Agregar todo desde el directorio actual
# - git add -A              → Agregar absolutamente todo
# - git add -u              → Agregar solo modificados/eliminados (no nuevos)
# - git add -p              → Agregar partes específicas de un archivo
# - git restore --staged .  → Quitar del staging sin perder cambios
# =============================================================================
