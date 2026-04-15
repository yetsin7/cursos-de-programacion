# =============================================================================
# ARCHIVO: 02_configuracion_inicial.sh
# TEMA: Configuración inicial de Git — Lo que DEBES hacer después de instalar
# =============================================================================
#
# Después de instalar Git, hay configuraciones OBLIGATORIAS que debes hacer
# antes de empezar a trabajar. Sin estas, Git no te dejará hacer commits.
#
# La configuración se guarda en un archivo llamado .gitconfig en tu
# carpeta de usuario (~/.gitconfig en macOS/Linux, C:\Users\TuNombre\.gitconfig
# en Windows).
# =============================================================================


# ─────────────────────────────────────────────────────────────────────────────
# CONFIGURACIÓN OBLIGATORIA: Nombre y correo electrónico
# ─────────────────────────────────────────────────────────────────────────────

# Tu nombre completo — aparecerá en cada commit que hagas
# Usa tu nombre real o el nombre con el que quieres ser conocido
git config --global user.name "Tu Nombre Completo"

# Tu correo electrónico — debe ser el MISMO que usarás en GitHub
# Esto es importante para que GitHub vincule tus commits con tu cuenta
git config --global user.email "tu.correo@ejemplo.com"

# ¿Qué significa --global?
# --global = aplica esta configuración a TODOS los repositorios de tu usuario
# --local = aplica solo al repositorio actual (sobreescribe la global)
# --system = aplica a todos los usuarios del sistema (requiere permisos admin)


# ─────────────────────────────────────────────────────────────────────────────
# CONFIGURACIÓN RECOMENDADA: Editor de texto por defecto
# ─────────────────────────────────────────────────────────────────────────────

# Git necesita un editor de texto para ciertas operaciones (como escribir
# mensajes de commit largos o resolver conflictos de merge).
# Por defecto usa Vim, que puede ser confuso para principiantes.

# Configurar VS Code como editor de Git (RECOMENDADO)
# El flag --wait hace que Git espere hasta que cierres el archivo en VS Code
git config --global core.editor "code --wait"

# Alternativas para otros editores:
# Nano (más simple que Vim):
# git config --global core.editor "nano"

# Sublime Text:
# git config --global core.editor "subl --wait"

# Notepad++ (Windows):
# git config --global core.editor "'C:/Program Files/Notepad++/notepad++.exe' -multiInst -notabbar -nosession -noPlugin"


# ─────────────────────────────────────────────────────────────────────────────
# CONFIGURACIÓN RECOMENDADA: Nombre de la rama principal
# ─────────────────────────────────────────────────────────────────────────────

# Cuando creas un repositorio nuevo con "git init", Git crea una rama principal.
# Históricamente se llamaba "master", pero la convención moderna es "main".
# Esta configuración hace que todos tus repos nuevos usen "main" por defecto.
git config --global init.defaultBranch main


# ─────────────────────────────────────────────────────────────────────────────
# VERIFICAR TU CONFIGURACIÓN
# ─────────────────────────────────────────────────────────────────────────────

# Ver TODA la configuración actual de Git
# Esto muestra todas las opciones configuradas y de dónde vienen
git config --list

# Ver solo tu nombre configurado
git config user.name

# Ver solo tu correo configurado
git config user.email

# Ver solo el editor configurado
git config core.editor

# Ver solo la rama por defecto
git config init.defaultBranch


# ─────────────────────────────────────────────────────────────────────────────
# ¿DÓNDE SE GUARDA ESTA CONFIGURACIÓN?
# ─────────────────────────────────────────────────────────────────────────────

# La configuración global se guarda en un archivo de texto plano:
# - macOS/Linux: ~/.gitconfig
# - Windows: C:\Users\TuNombre\.gitconfig

# Puedes ver el contenido del archivo directamente:
cat ~/.gitconfig

# O abrirlo con tu editor:
# code ~/.gitconfig

# También puedes editarlo directamente con Git:
# git config --global --edit


# =============================================================================
# RESUMEN:
# - git config --global user.name "Tu Nombre" → OBLIGATORIO
# - git config --global user.email "tu@email.com" → OBLIGATORIO
# - git config --global core.editor "code --wait" → RECOMENDADO
# - git config --global init.defaultBranch main → RECOMENDADO
# - git config --list → ver toda la configuración actual
#
# Sin nombre y correo, Git NO te dejará hacer commits.
# Configúralos antes de continuar.
#
# Siguiente archivo: 03_configuracion_avanzada.sh
# =============================================================================
