# =============================================================================
# ARCHIVO: 02_fork_y_contribuir.sh
# TEMA: Fork y contribución — El flujo completo paso a paso
# =============================================================================
#
# Contribuir a un proyecto open source sigue un flujo muy específico.
# No puedes simplemente hacer push al repositorio de otra persona.
# Necesitas hacer un "fork" (copia) a tu cuenta, trabajar ahí, y luego
# proponer tus cambios mediante un Pull Request.
#
# En este archivo veremos cada paso del proceso completo.
#
# IMPORTANTE: No ejecutes este archivo completo. Lee cada sección y ejecuta
# los comandos uno por uno en tu terminal.
# =============================================================================


# --- PASO 1: ¿Qué es un Fork? ---
#
# Un fork es una COPIA COMPLETA de un repositorio ajeno que se crea en tu
# propia cuenta de GitHub. Es tu copia personal donde puedes hacer lo que
# quieras sin afectar el proyecto original.
#
# Repositorio original (upstream):  github.com/autor/proyecto
# Tu fork:                          github.com/TU-USUARIO/proyecto
#
# El fork mantiene una conexión con el original, lo que te permite:
#   - Proponer cambios al proyecto original (Pull Requests)
#   - Mantener tu copia actualizada con los cambios del original


# --- PASO 2: Hacer un Fork en GitHub ---
#
# Para hacer un fork:
# 1. Ve al repositorio que quieres contribuir en GitHub
# 2. Haz clic en el botón "Fork" (esquina superior derecha)
# 3. Selecciona tu cuenta como destino
# 4. GitHub creará la copia en tu cuenta
#
# También puedes hacerlo desde la línea de comandos con GitHub CLI:
gh repo fork AUTOR/PROYECTO

# Esto crea el fork Y lo clona en tu computadora automáticamente.
# Si solo quieres crear el fork sin clonar:
gh repo fork AUTOR/PROYECTO --clone=false


# --- PASO 3: Clonar tu Fork a tu computadora ---
# Una vez que tienes el fork en tu cuenta, clónalo localmente.

# Opción 1: Clonar con HTTPS
git clone https://github.com/TU-USUARIO/proyecto.git

# Opción 2: Clonar con SSH (recomendado si ya configuraste SSH)
git clone git@github.com:TU-USUARIO/proyecto.git

# Entrar a la carpeta del proyecto
cd proyecto


# --- PASO 4: Configurar el repositorio original como "upstream" ---
#
# Esto es FUNDAMENTAL. Necesitas decirle a Git dónde está el repositorio
# original para poder mantener tu fork actualizado.

# Agregar el repositorio original como "upstream"
git remote add upstream https://github.com/AUTOR/proyecto.git

# Verificar que tienes ambos remotos configurados
git remote -v
# Deberías ver algo como:
# origin    https://github.com/TU-USUARIO/proyecto.git (fetch)
# origin    https://github.com/TU-USUARIO/proyecto.git (push)
# upstream  https://github.com/AUTOR/proyecto.git (fetch)
# upstream  https://github.com/AUTOR/proyecto.git (push)
#
# origin   = tu fork (donde tienes permisos de escritura)
# upstream = el proyecto original (solo lectura para ti)


# --- PASO 5: Crear una rama para tu cambio ---
#
# NUNCA trabajes directamente en la rama main de tu fork.
# Siempre crea una rama específica para cada contribución.
#
# ¿Por qué?
#   - Mantiene tu main limpio y sincronizado con upstream
#   - Permite tener múltiples contribuciones en paralelo
#   - Facilita la revisión del Pull Request
#   - Si tu PR es rechazado, no afecta tu main

# Primero, asegúrate de estar en main y actualizado
git checkout main
git pull upstream main

# Crear y moverte a una nueva rama con un nombre descriptivo
git checkout -b fix/corregir-typo-readme

# Buenos nombres de rama:
#   fix/corregir-typo-readme
#   feature/agregar-modo-oscuro
#   docs/mejorar-instalacion
#   refactor/optimizar-busqueda


# --- PASO 6: Hacer los cambios ---
#
# Ahora haz los cambios que quieres proponer.
# Lee el archivo CONTRIBUTING.md del proyecto para saber:
#   - Qué estilo de código seguir
#   - Cómo ejecutar las pruebas
#   - Qué convenciones de commits usar

# Ejemplo: editar un archivo
# (usa tu editor favorito: VS Code, nano, vim, etc.)

# Ver qué archivos cambiaste
git status

# Ver los cambios exactos línea por línea
git diff


# --- PASO 7: Hacer commit de los cambios ---
#
# Haz commits claros y descriptivos. Muchos proyectos usan
# Conventional Commits (veremos esto en el capítulo 18).

# Agregar los archivos modificados al staging area
git add archivo-modificado.md

# Hacer el commit con un mensaje descriptivo
git commit -m "fix: corregir typo en la sección de instalación del README"

# Si el proyecto pide commits firmados (signed commits):
git commit -S -m "fix: corregir typo en la sección de instalación del README"


# --- PASO 8: Subir tu rama a tu fork ---
# Sube la rama a tu fork en GitHub (origin, NO upstream)

git push origin fix/corregir-typo-readme


# --- PASO 9: Abrir un Pull Request ---
#
# Ahora ve a GitHub y abre un Pull Request desde tu rama hacia el
# repositorio original.
#
# Opción 1: Desde la web
#   - Ve a tu fork en GitHub
#   - GitHub mostrará un banner sugiriendo crear un PR
#   - Haz clic en "Compare & pull request"
#   - Llena el formulario con título y descripción
#
# Opción 2: Desde GitHub CLI
gh pr create --title "fix: corregir typo en README" \
  --body "## Descripción
Corregí un error tipográfico en la sección de instalación del README.

## Cambios realizados
- Línea 42: 'instalar' estaba escrito como 'intalar'

## Tipo de cambio
- [x] Corrección de documentación"

# Al crear el PR, incluye:
#   - Título claro y conciso
#   - Descripción de QUÉ cambiaste y POR QUÉ
#   - Referencia a issues relacionados (ej: "Fixes #123")
#   - Capturas de pantalla si hay cambios visuales


# --- PASO 10: Responder al feedback ---
#
# Los mantenedores revisarán tu PR y pueden pedir cambios.
# Esto es NORMAL y es parte del proceso. No te desanimes.
#
# Si te piden cambios:

# 1. Haz los cambios solicitados en tu rama local
git checkout fix/corregir-typo-readme

# 2. Edita los archivos necesarios

# 3. Haz un nuevo commit
git add .
git commit -m "fix: aplicar cambios solicitados en revisión"

# 4. Sube los cambios — el PR se actualiza automáticamente
git push origin fix/corregir-typo-readme


# =============================================================================
# RESUMEN DEL FLUJO COMPLETO:
# 1. Fork del repositorio → copia en tu cuenta
# 2. Clone de tu fork → copia en tu computadora
# 3. Agregar upstream → conexión con el original
# 4. Crear rama → espacio aislado para tu cambio
# 5. Hacer cambios y commits → tu contribución
# 6. Push a tu fork → subir tu rama
# 7. Abrir Pull Request → proponer tus cambios
# 8. Responder al feedback → iterar hasta que sea aceptado
# =============================================================================
