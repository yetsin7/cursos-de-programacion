# =============================================================================
# ARCHIVO: 01_instalar_git.sh
# TEMA: Verificar la instalación de Git
# =============================================================================
#
# Antes de configurar Git, necesitas asegurarte de que está instalado
# correctamente en tu sistema. Este archivo te guía paso a paso para
# verificar la instalación en Windows, macOS y Linux.
#
# IMPORTANTE: Ejecuta estos comandos uno por uno en tu terminal.
# =============================================================================


# ─────────────────────────────────────────────────────────────────────────────
# VERIFICACIÓN BÁSICA
# ─────────────────────────────────────────────────────────────────────────────

# Verificar que Git está instalado y ver su versión
# Si ves algo como "git version 2.43.0", Git está instalado correctamente
# Si ves un error como "git: command not found", necesitas instalarlo
git --version


# ─────────────────────────────────────────────────────────────────────────────
# VERIFICAR DÓNDE ESTÁ INSTALADO GIT
# ─────────────────────────────────────────────────────────────────────────────

# En macOS/Linux: muestra la ruta donde está el ejecutable de Git
which git

# En Windows (Git Bash): también funciona "which"
# En Windows (CMD/PowerShell): usa "where git" en su lugar
# where git


# ─────────────────────────────────────────────────────────────────────────────
# INSTALACIÓN EN WINDOWS
# ─────────────────────────────────────────────────────────────────────────────
#
# Si Git no está instalado en Windows, sigue estos pasos:
#
# 1. Abre tu navegador y ve a: https://git-scm.com/downloads
# 2. Haz clic en "Download for Windows"
# 3. Ejecuta el archivo .exe descargado
# 4. Sigue el asistente de instalación:
#    - Acepta la licencia
#    - Deja la ruta de instalación por defecto
#    - En "Select Components": deja las opciones por defecto
#    - En "Choosing the default editor": selecciona VS Code si lo usas
#    - En "Adjusting your PATH": selecciona "Git from the command line and also
#      from 3rd-party software" (es la opción recomendada)
#    - El resto de opciones déjalas por defecto
# 5. Haz clic en "Install" y espera
# 6. Al terminar, abre una terminal nueva y ejecuta: git --version


# ─────────────────────────────────────────────────────────────────────────────
# INSTALACIÓN EN macOS
# ─────────────────────────────────────────────────────────────────────────────
#
# Opción 1: Usando Homebrew (recomendado si ya tienes Homebrew)
# brew install git
#
# Opción 2: Xcode Command Line Tools
# xcode-select --install
# (Esto instala Git junto con otras herramientas de desarrollo)
#
# Opción 3: Descargar desde la web
# Ve a https://git-scm.com/downloads y descarga el instalador para macOS


# ─────────────────────────────────────────────────────────────────────────────
# INSTALACIÓN EN LINUX
# ─────────────────────────────────────────────────────────────────────────────

# Ubuntu / Debian:
# sudo apt update
# sudo apt install git

# Fedora:
# sudo dnf install git

# Arch Linux:
# sudo pacman -S git

# openSUSE:
# sudo zypper install git


# ─────────────────────────────────────────────────────────────────────────────
# VERIFICACIÓN FINAL
# ─────────────────────────────────────────────────────────────────────────────

# Después de instalar, cierra y vuelve a abrir tu terminal
# Luego ejecuta este comando para confirmar que todo funciona:
git --version

# Si ves la versión, estás listo para configurar Git en el siguiente archivo


# =============================================================================
# RESUMEN:
# - "git --version" verifica que Git está instalado
# - "which git" (o "where git" en Windows CMD) muestra dónde está instalado
# - Si no está instalado, descárgalo desde https://git-scm.com/downloads
# - Después de instalar, siempre cierra y reabre la terminal
#
# Siguiente archivo: 02_configuracion_inicial.sh
# =============================================================================
