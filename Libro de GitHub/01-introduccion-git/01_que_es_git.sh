# =============================================================================
# ARCHIVO: 01_que_es_git.sh
# TEMA: ¿Que es Git? — Tu primer contacto
# =============================================================================
#
# Git es un sistema de control de versiones. Dicho facil: es una herramienta
# que guarda el historial de tus archivos para que puedas saber que cambio,
# cuando cambio, quien lo cambio y por que.
#
# La idea importante de esta leccion es entender que Git trabaja primero en tu
# computadora. GitHub aparece despues como servicio remoto para compartir,
# respaldar y colaborar.
#
# IMPORTANTE:
# - No ejecutes este archivo completo de golpe.
# - Lee cada linea.
# - Ejecuta cada comando por separado.
# - Observa la respuesta de la terminal.
# =============================================================================


# --- PASO 1: Verificar que Git está instalado ---
# Este comando pregunta al programa Git que version esta instalada.
# Si responde con un numero, Git ya esta disponible en tu sistema.
# Si no responde, debes instalarlo antes de seguir.
git --version


# --- PASO 2: Pedir ayuda a Git ---
# Git trae ayuda incorporada. Esto importa porque un buen desarrollador no
# memoriza todo: sabe buscar la documentacion correcta en el momento correcto.

# Esto muestra la ayuda general de Git con todos los comandos disponibles
git help

# Esto muestra ayuda específica sobre un comando (por ejemplo, "commit")
# Se abrirá una página de documentación detallada
git help commit


# --- PASO 3: Ver la lista de comandos disponibles ---
# Este comando muestra TODOS los comandos que Git conoce
# No te preocupes si son muchos — iremos aprendiendo los más importantes
git help -a


# --- PASO 4: Entender qué problema resuelve Git ---
# Sin Git, muchas personas terminaban con carpetas como:
# proyecto_final, proyecto_final_ahora_si, proyecto_final_bueno.
# Eso genera caos, perdida de tiempo y riesgo de sobrescribir trabajo.
#
# Con Git:
#   - Cada cambio queda registrado automáticamente
#   - Puedes volver a cualquier versión anterior en segundos
#   - Múltiples personas pueden trabajar al mismo tiempo sin conflictos
#   - Todo queda documentado: quién cambió qué, cuándo y por qué


# --- PASO 5: Probar un comando real ---
# Vamos a crear una carpeta de prueba y convertirla en un repositorio.
# Aun no necesitas dominar todos los conceptos. Lo importante es observar el
# efecto de cada comando.

# Crear una carpeta de prueba en tu escritorio o donde prefieras
mkdir mi-primer-repo

# Entrar a la carpeta
cd mi-primer-repo

# Inicializar Git en esta carpeta (convertirla en un repositorio)
# Este comando crea una carpeta oculta llamada .git.
# Esa carpeta contiene la base de datos local del repositorio: historial,
# referencias, configuracion y objetos internos.
git init

# Ver el estado actual del repositorio
# Como está vacío, Git nos dirá que no hay nada que rastrear todavía
git status


# --- PASO 6: Limpiar ---
# Si quieres borrar la carpeta de prueba, sal de ella primero.
cd ..

# En sistemas tipo Linux o macOS puedes usar:
# rm -rf mi-primer-repo

# En PowerShell (Windows) puedes usar:
# Remove-Item -Recurse -Force mi-primer-repo


# =============================================================================
# RESUMEN:
# - Git guarda historial local de cambios en tus archivos
# - Git no es lo mismo que GitHub
# - .git es la base de datos interna del repositorio
# - "git init" convierte una carpeta normal en repositorio
# - "git status" te dice que ve Git en este momento
# - La terminal no solo ejecuta: tambien te explica lo que esta pasando
#
# En el siguiente archivo aprenderás la terminología básica de Git.
# =============================================================================
