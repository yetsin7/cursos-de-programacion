#!/bin/bash
# =============================================================================
# ARCHIVO: 05_git_diff.sh
# TEMA: Ver diferencias entre versiones con git diff
# =============================================================================
#
# git diff te muestra exactamente qué líneas cambiaron en tus archivos.
# Es como tener un microscopio para tus cambios: ves cada línea agregada,
# eliminada o modificada. Esencial para revisar tu trabajo antes de hacer
# commit y para entender qué cambió entre versiones.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# 1. git diff básico (cambios NO preparados)
# ─────────────────────────────────────────────────────────────────────────────

# Sin argumentos, git diff muestra las diferencias entre tu directorio de
# trabajo y el staging area. Es decir: cambios que hiciste pero AÚN NO
# agregaste con git add.
git diff

# La salida se ve así:
#   diff --git a/archivo.txt b/archivo.txt
#   index 1234567..abcdefg 100644
#   --- a/archivo.txt          ← Versión anterior (staging/último commit)
#   +++ b/archivo.txt          ← Versión actual (directorio de trabajo)
#   @@ -1,5 +1,7 @@            ← Ubicación del cambio (líneas)
#    Línea sin cambios          ← Sin prefijo = línea que no cambió
#   -Línea eliminada            ← Prefijo - = línea que se quitó (rojo)
#   +Línea agregada             ← Prefijo + = línea que se añadió (verde)
#   +Otra línea nueva

# ─────────────────────────────────────────────────────────────────────────────
# 2. git diff --staged (cambios PREPARADOS para commit)
# ─────────────────────────────────────────────────────────────────────────────

# Muestra las diferencias entre el staging area y el último commit.
# Es decir: lo que se incluirá en tu próximo commit.
git diff --staged

# --cached es un sinónimo de --staged (hacen exactamente lo mismo):
git diff --cached

# ⭐ CONSEJO IMPORTANTE:
# Siempre ejecuta git diff --staged ANTES de hacer commit.
# Así verificas que solo estás incluyendo los cambios correctos.

# ─────────────────────────────────────────────────────────────────────────────
# 3. git diff de un archivo específico
# ─────────────────────────────────────────────────────────────────────────────

# Puedes ver los cambios de un solo archivo pasando su nombre.
git diff archivo.txt
git diff --staged archivo.txt

# También puedes comparar múltiples archivos específicos:
git diff src/login.js src/register.js

# ─────────────────────────────────────────────────────────────────────────────
# 4. Comparar entre dos commits
# ─────────────────────────────────────────────────────────────────────────────

# Para ver qué cambió ENTRE dos commits, pasa ambos hashes.
# El formato es: git diff <commit_viejo> <commit_nuevo>
git diff a1b2c3d e4f5g6h

# Puedes usar hashes abreviados (los primeros 7 caracteres):
git diff a1b2c3d e4f5g6h

# Usando referencias relativas con HEAD:
git diff HEAD~3 HEAD          # Cambios de los últimos 3 commits
git diff HEAD~1 HEAD          # Cambios del último commit (igual que git show)

# ─────────────────────────────────────────────────────────────────────────────
# 5. Comparar entre ramas
# ─────────────────────────────────────────────────────────────────────────────

# Ver las diferencias entre dos ramas:
git diff main feature/login

# Ver qué cambió en una rama desde que se separó de main:
# (el triple punto ... es importante: muestra solo lo que cambió en la segunda)
git diff main...feature/login

# ─────────────────────────────────────────────────────────────────────────────
# 6. Ver solo nombres de archivos cambiados
# ─────────────────────────────────────────────────────────────────────────────

# A veces no necesitas ver las líneas, solo qué archivos cambiaron.

# --name-only: solo nombres de archivos
git diff --name-only
git diff --name-only --staged

# --name-status: nombres + tipo de cambio (M=modified, A=added, D=deleted)
git diff --name-status
git diff --name-status HEAD~3 HEAD

# --stat: resumen con barras +/- visuales
git diff --stat
git diff --stat HEAD~5 HEAD

# ─────────────────────────────────────────────────────────────────────────────
# 7. Opciones útiles para la salida
# ─────────────────────────────────────────────────────────────────────────────

# --color-words: en vez de mostrar líneas completas como +/-, resalta solo
# las PALABRAS que cambiaron dentro de cada línea. Muy útil para cambios pequeños.
git diff --color-words

# --word-diff: similar, pero con marcadores explícitos [-eliminado-]{+agregado+}
git diff --word-diff

# -U3: muestra 3 líneas de contexto alrededor de cada cambio (valor por defecto).
# Puedes cambiarlo para ver más o menos contexto:
git diff -U5                   # 5 líneas de contexto
git diff -U0                   # Sin contexto (solo las líneas que cambiaron)

# ─────────────────────────────────────────────────────────────────────────────
# 8. Comparar un archivo con una versión anterior
# ─────────────────────────────────────────────────────────────────────────────

# Ver cómo era un archivo hace N commits:
git diff HEAD~3 -- archivo.txt

# Comparar la versión actual con la de otra rama:
git diff main -- src/app.js

# El -- separa las opciones de los nombres de archivos.
# Es buena práctica usarlo siempre que pases nombres de archivos.

# ─────────────────────────────────────────────────────────────────────────────
# 9. Herramientas de diff externas
# ─────────────────────────────────────────────────────────────────────────────

# Si prefieres una interfaz gráfica para ver diferencias, puedes configurar
# una herramienta externa como VS Code:
#
#   git config --global diff.tool vscode
#   git config --global difftool.vscode.cmd 'code --wait --diff $LOCAL $REMOTE'
#
# Luego usas git difftool en vez de git diff:
#   git difftool
#   git difftool --staged

# =============================================================================
# RESUMEN:
# - git diff                       → Cambios no preparados (working dir vs staging)
# - git diff --staged              → Cambios preparados (staging vs último commit)
# - git diff commit1 commit2       → Diferencias entre dos commits
# - git diff rama1 rama2           → Diferencias entre dos ramas
# - git diff --name-only           → Solo nombres de archivos cambiados
# - git diff --stat                → Resumen visual con barras +/-
# - git diff --color-words         → Resaltar solo palabras cambiadas
# - git diff HEAD~N -- archivo.txt → Comparar archivo con versión anterior
# =============================================================================
