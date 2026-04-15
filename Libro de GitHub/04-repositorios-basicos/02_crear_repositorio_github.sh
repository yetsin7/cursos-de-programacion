# =============================================================================
# ARCHIVO: 02_crear_repositorio_github.sh
# TEMA: Crear un repositorio en GitHub desde el navegador
# =============================================================================
#
# Además de crear repositorios locales, puedes crear repositorios
# directamente en GitHub (en la nube). Esto es útil cuando quieres:
#   - Tener tu código respaldado en internet
#   - Compartir tu proyecto con otros
#   - Colaborar con un equipo
#
# Este proceso se hace desde el navegador. Las instrucciones están
# como comentarios.
# =============================================================================


# ─────────────────────────────────────────────────────────────────────────────
# PASO 1: Ir a la página de crear repositorio
# ─────────────────────────────────────────────────────────────────────────────
# Abre tu navegador y ve a:
#   https://github.com/new
#
# O desde GitHub.com: haz clic en el botón "+" (esquina superior derecha)
# y selecciona "New repository"


# ─────────────────────────────────────────────────────────────────────────────
# PASO 2: Configurar el repositorio
# ─────────────────────────────────────────────────────────────────────────────
#
# REPOSITORY NAME (nombre del repositorio):
#   - Escribe un nombre descriptivo en minúsculas
#   - Usa guiones (-) para separar palabras, no espacios ni guiones bajos
#   - Ejemplos buenos: "mi-primer-proyecto", "lista-de-tareas", "portafolio-web"
#   - Ejemplos malos: "Mi Proyecto", "proyecto_1", "asdf"
#
# DESCRIPTION (descripción):
#   - Opcional pero RECOMENDADO
#   - Describe brevemente qué es el proyecto
#   - Ejemplo: "Aplicación web de lista de tareas con HTML, CSS y JavaScript"
#
# VISIBILITY (visibilidad):
#   PUBLIC — cualquier persona puede ver tu código
#     → Úsalo para: proyectos open source, portafolio, aprendizaje
#
#   PRIVATE — solo tú (y colaboradores invitados) pueden verlo
#     → Úsalo para: proyectos personales, trabajo confidencial
#
# INITIALIZE THIS REPOSITORY WITH:
#
#   "Add a README file" — RECOMENDADO
#     Crea un archivo README.md con el nombre y descripción del proyecto.
#     Este archivo es la "portada" de tu repositorio en GitHub.
#
#   "Add .gitignore" — RECOMENDADO
#     Selecciona una plantilla según tu lenguaje (Python, Node, etc.).
#     El .gitignore le dice a Git qué archivos NO debe rastrear
#     (como contraseñas, archivos temporales, node_modules, etc.)
#
#   "Choose a license" — OPCIONAL
#     Si tu proyecto es público y quieres que otros lo usen,
#     elige una licencia (MIT es la más común y permisiva).


# ─────────────────────────────────────────────────────────────────────────────
# PASO 3: Crear el repositorio
# ─────────────────────────────────────────────────────────────────────────────
# Haz clic en el botón verde "Create repository"
#
# GitHub te llevará a la página de tu nuevo repositorio.
# La URL será algo como: https://github.com/tu-username/nombre-del-repo


# ─────────────────────────────────────────────────────────────────────────────
# PASO 4: Clonar el repositorio a tu computadora
# ─────────────────────────────────────────────────────────────────────────────
# Ahora que el repo existe en GitHub, necesitas descargarlo a tu computadora
# para trabajar en él.

# Opción A: Clonar por HTTPS (más fácil para empezar)
# Haz clic en el botón verde "Code" → copia la URL HTTPS
# git clone https://github.com/tu-username/nombre-del-repo.git

# Opción B: Clonar por SSH (si ya configuraste SSH keys)
# Haz clic en el botón verde "Code" → pestaña SSH → copia la URL
# git clone git@github.com:tu-username/nombre-del-repo.git


# ─────────────────────────────────────────────────────────────────────────────
# PASO 5: Conectar un repositorio local existente con GitHub
# ─────────────────────────────────────────────────────────────────────────────
# Si ya tienes un repositorio local (creado con git init) y quieres
# subirlo a GitHub, sigue estos pasos:

# 1. Crea un repositorio VACÍO en GitHub (sin README, sin .gitignore, sin licencia)
# 2. Copia la URL del repositorio
# 3. Desde tu terminal, dentro de tu repositorio local:

# Agregar GitHub como repositorio remoto (reemplaza la URL con la tuya)
# git remote add origin https://github.com/tu-username/nombre-del-repo.git

# Verificar que el remoto se agregó correctamente
# git remote -v

# Subir tu código a GitHub por primera vez
# El flag -u (upstream) vincula tu rama local con la remota
# git push -u origin main

# Después del primer push con -u, solo necesitas escribir "git push"


# ─────────────────────────────────────────────────────────────────────────────
# RESUMEN DE LOS DOS FLUJOS
# ─────────────────────────────────────────────────────────────────────────────
#
# FLUJO A — Empezar desde GitHub:
#   1. Crear repo en GitHub (con README)
#   2. git clone URL → descargar a tu computadora
#   3. Trabajar → git add → git commit → git push
#
# FLUJO B — Empezar desde tu computadora:
#   1. mkdir proyecto → cd proyecto → git init
#   2. Trabajar → git add → git commit
#   3. Crear repo VACÍO en GitHub
#   4. git remote add origin URL
#   5. git push -u origin main
#
# Ambos flujos son válidos. El Flujo A es más fácil para principiantes.


# =============================================================================
# RESUMEN:
# - Crear un repo en GitHub se hace desde https://github.com/new
# - Elige un nombre descriptivo en minúsculas con guiones
# - Marca "Add a README file" y elige un .gitignore apropiado
# - Clona el repo a tu computadora para empezar a trabajar
# - También puedes conectar un repo local existente con "git remote add"
#
# Siguiente archivo: 03_clonar_repositorio.sh
# =============================================================================
