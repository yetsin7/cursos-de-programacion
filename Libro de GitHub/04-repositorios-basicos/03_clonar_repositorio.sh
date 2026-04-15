# =============================================================================
# ARCHIVO: 03_clonar_repositorio.sh
# TEMA: Clonar repositorios — git clone
# =============================================================================
#
# Clonar es descargar una copia COMPLETA de un repositorio remoto a tu
# computadora. Incluye todos los archivos, todas las ramas y todo el
# historial de commits. Es la forma más común de empezar a trabajar
# con un proyecto que ya existe.
#
# IMPORTANTE: Ejecuta estos comandos uno por uno en tu terminal.
# =============================================================================


# ─────────────────────────────────────────────────────────────────────────────
# CLONAR POR HTTPS (método más fácil para principiantes)
# ─────────────────────────────────────────────────────────────────────────────
# HTTPS es el protocolo más sencillo. Necesitas tu usuario y token
# (o contraseña) cuando hagas push.
#
# La URL tiene este formato:
#   https://github.com/usuario/repositorio.git

# Ejemplo: Clonar un repositorio público real
# Este es el repositorio de ejemplo "Hello World" de GitHub
git clone https://github.com/octocat/Hello-World.git

# Esto crea una carpeta "Hello-World" con todo el contenido del repo
ls Hello-World/

# Entrar al repositorio clonado
cd Hello-World

# Ver el historial de commits — puedes ver TODO el historial del proyecto
git log --oneline

# Ver los remotos — "origin" apunta al repositorio original en GitHub
git remote -v

# Salir de la carpeta
cd ..


# ─────────────────────────────────────────────────────────────────────────────
# CLONAR POR SSH (método profesional — requiere SSH key configurada)
# ─────────────────────────────────────────────────────────────────────────────
# SSH es más seguro y no pide contraseña cada vez que haces push/pull.
# Requiere tener SSH keys configuradas (ver capítulo 03).
#
# La URL tiene este formato:
#   git@github.com:usuario/repositorio.git

# Ejemplo: Clonar el mismo repositorio por SSH
# git clone git@github.com:octocat/Hello-World.git

# La diferencia entre HTTPS y SSH:
#   HTTPS: https://github.com/usuario/repo.git → pide token al hacer push
#   SSH:   git@github.com:usuario/repo.git     → usa tu llave SSH automáticamente


# ─────────────────────────────────────────────────────────────────────────────
# CLONAR CON UN NOMBRE DE CARPETA DIFERENTE
# ─────────────────────────────────────────────────────────────────────────────
# Por defecto, git clone crea una carpeta con el nombre del repositorio.
# Puedes especificar un nombre diferente agregándolo al final del comando.

# Esto clona el repo pero la carpeta se llamará "mi-copia" en vez de "Hello-World"
git clone https://github.com/octocat/Hello-World.git mi-copia

# Verificar que se creó con el nombre personalizado
ls mi-copia/


# ─────────────────────────────────────────────────────────────────────────────
# CLONAR EN UNA RUTA ESPECÍFICA
# ─────────────────────────────────────────────────────────────────────────────
# Puedes clonar directamente en una ruta específica de tu computadora

# Ejemplo: clonar directamente en tu escritorio (ajusta la ruta según tu SO)
# git clone https://github.com/octocat/Hello-World.git ~/Desktop/mi-proyecto


# ─────────────────────────────────────────────────────────────────────────────
# CLONAR SOLO LA ÚLTIMA VERSIÓN (shallow clone)
# ─────────────────────────────────────────────────────────────────────────────
# Si un repositorio tiene miles de commits y es muy pesado, puedes clonar
# solo el estado más reciente sin todo el historial. Esto es más rápido.

# El flag --depth 1 solo descarga el último commit
git clone --depth 1 https://github.com/octocat/Hello-World.git clon-superficial

# Verificar: solo tiene 1 commit en el historial
cd clon-superficial
git log --oneline
cd ..


# ─────────────────────────────────────────────────────────────────────────────
# CLONAR UNA RAMA ESPECÍFICA
# ─────────────────────────────────────────────────────────────────────────────
# Si solo te interesa una rama específica del repositorio, puedes clonar
# solo esa rama.

# El flag -b (branch) especifica qué rama clonar
# git clone -b nombre-rama https://github.com/usuario/repo.git


# ─────────────────────────────────────────────────────────────────────────────
# ¿QUÉ PASA CUANDO CLONAS?
# ─────────────────────────────────────────────────────────────────────────────
# Cuando ejecutas "git clone", Git hace varias cosas automáticamente:
#
# 1. Crea una carpeta nueva con el nombre del repositorio
# 2. Descarga TODOS los archivos del proyecto
# 3. Descarga TODO el historial de commits
# 4. Descarga TODAS las ramas
# 5. Configura "origin" como remoto apuntando a la URL original
# 6. Te posiciona en la rama principal (generalmente "main")
#
# Después de clonar, puedes trabajar inmediatamente:
# editar archivos, hacer commits y subirlos con push.


# Limpiar las carpetas de prueba
rm -rf Hello-World
rm -rf mi-copia
rm -rf clon-superficial


# =============================================================================
# RESUMEN:
# - "git clone URL" descarga una copia completa de un repositorio
# - HTTPS es más fácil, SSH es más profesional
# - Puedes especificar un nombre de carpeta diferente al clonar
# - "--depth 1" hace un clon superficial (solo el último commit)
# - "-b rama" clona solo una rama específica
# - Después de clonar, "origin" apunta al repositorio original
#
# Siguiente archivo: 04_estructura_repositorio.sh
# =============================================================================
