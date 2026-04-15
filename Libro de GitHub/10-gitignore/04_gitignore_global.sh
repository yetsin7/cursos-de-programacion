#!/bin/bash
# =============================================================================
# ARCHIVO: 04_gitignore_global.sh
# TEMA: Configuración de .gitignore global
# =============================================================================
#
# Además del .gitignore por proyecto, Git permite configurar un .gitignore
# GLOBAL que aplica a TODOS los repositorios en tu máquina. Es perfecto
# para ignorar archivos del sistema operativo y del IDE que nunca quieres
# en ningún repositorio.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# ¿QUÉ ES EL GITIGNORE GLOBAL?
# ─────────────────────────────────────────────────────────────────────────────

# El gitignore global es un archivo de ignorar que aplica a TODOS
# los repositorios Git de tu computadora, sin necesidad de agregarlo
# a cada proyecto individual.

# Es ideal para:
# - Archivos del sistema operativo (.DS_Store, Thumbs.db)
# - Archivos del editor/IDE (.idea/, *.swp)
# - Archivos personales que nadie más necesita

# NO es ideal para:
# - Archivos específicos del proyecto (node_modules/, build/)
# - Secretos del proyecto (.env)
# Estos deben ir en el .gitignore del proyecto para que TODOS
# los colaboradores los ignoren, no solo tú.

echo "========================================="
echo "  GITIGNORE GLOBAL vs. LOCAL"
echo "========================================="
echo ""
echo "  GLOBAL: archivos de tu OS/IDE (aplica a todos tus repos)"
echo "  LOCAL:  archivos del proyecto (aplica a todos los colaboradores)"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# CREAR Y CONFIGURAR EL GITIGNORE GLOBAL
# ─────────────────────────────────────────────────────────────────────────────

# Paso 1: Crear el archivo (ubicación recomendada: home del usuario)
touch ~/.gitignore_global

# Paso 2: Decirle a Git que use ese archivo como gitignore global
git config --global core.excludesFile ~/.gitignore_global

# Verificar la configuración
git config --global core.excludesFile
# Debería mostrar: /home/tu-usuario/.gitignore_global (Linux/Mac)
# o C:/Users/tu-usuario/.gitignore_global (Windows)

echo ""
echo "========================================="
echo "  CREAR GITIGNORE GLOBAL"
echo "========================================="
echo ""
echo "  1. touch ~/.gitignore_global"
echo "  2. git config --global core.excludesFile ~/.gitignore_global"
echo "  3. Agregar patrones al archivo"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# CONTENIDO RECOMENDADO PARA EL GITIGNORE GLOBAL
# ─────────────────────────────────────────────────────────────────────────────

# Este es un gitignore global que cubre los casos más comunes:

cat << 'GITIGNORE'
# =============================================================================
# GITIGNORE GLOBAL — Aplica a todos los repositorios de esta máquina
# =============================================================================

# ===========================
# macOS
# ===========================
.DS_Store
.AppleDouble
.LSOverride
._*
.Spotlight-V100
.Trashes

# ===========================
# Windows
# ===========================
Thumbs.db
Thumbs.db:encryptable
ehthumbs.db
ehthumbs_vista.db
Desktop.ini
$RECYCLE.BIN/
*.lnk

# ===========================
# Linux
# ===========================
*~
.fuse_hidden*
.Trash-*
.nfs*
.directory

# ===========================
# JetBrains (IntelliJ, Android Studio, WebStorm, etc.)
# ===========================
.idea/
*.iml
*.iws
*.ipr
out/
cmake-build-*/

# ===========================
# Visual Studio Code
# ===========================
.vscode/settings.json
.vscode/launch.json
.vscode/*.code-workspace

# ===========================
# Vim / Neovim
# ===========================
*.swp
*.swo
*~
.netrwhist
tags

# ===========================
# Sublime Text
# ===========================
*.sublime-workspace
*.sublime-project
GITIGNORE

echo "========================================="
echo "  CONTENIDO RECOMENDADO"
echo "========================================="
echo ""
echo "  - Archivos de macOS (.DS_Store)"
echo "  - Archivos de Windows (Thumbs.db)"
echo "  - Archivos de Linux (*~)"
echo "  - Archivos de JetBrains (.idea/)"
echo "  - Archivos de VS Code (settings.json personal)"
echo "  - Archivos de Vim (*.swp)"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# VERIFICAR QUE FUNCIONA
# ─────────────────────────────────────────────────────────────────────────────

# Después de configurar el gitignore global, puedes verificar que funciona:

# Ver la configuración actual
git config --global core.excludesFile

# Verificar si un archivo está ignorado globalmente
git check-ignore -v .DS_Store
# Debería mostrar algo como:
# /home/user/.gitignore_global:6:.DS_Store    .DS_Store

echo ""
echo "========================================="
echo "  VERIFICAR"
echo "========================================="
echo ""
echo "  git config --global core.excludesFile"
echo "  git check-ignore -v .DS_Store"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# PRIORIDAD DE LOS GITIGNORE
# ─────────────────────────────────────────────────────────────────────────────

# Git evalúa los archivos de ignorar en este orden (de menor a mayor prioridad):
# 1. Patrones del gitignore global (~/.gitignore_global)
# 2. Patrones del .gitignore del repositorio
# 3. Patrones de .gitignore en subdirectorios
# 4. Patrones en .git/info/exclude (local, no se comparte)

# Si hay conflicto, el de mayor prioridad (más específico) gana.
# Ejemplo: si el global ignora *.log pero el .gitignore del proyecto
# tiene !important.log, el archivo important.log NO se ignora.

echo "========================================="
echo "  PRIORIDAD (menor a mayor)"
echo "========================================="
echo ""
echo "  1. ~/.gitignore_global     (global)"
echo "  2. .gitignore              (raíz del repo)"
echo "  3. subdirectorio/.gitignore (subdirectorio)"
echo "  4. .git/info/exclude       (local personal)"
echo ""
