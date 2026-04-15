# =============================================================================
# ARCHIVO: 01_que_es_git.sh
# TEMA: ¿Qué es Git? — Tu primer contacto
# =============================================================================
#
# Git es un sistema de control de versiones.
# Eso significa que Git registra TODOS los cambios que haces en tus archivos,
# quién los hizo, cuándo y por qué.
#
# En este archivo vamos a verificar que Git está instalado y explorar
# algunos comandos básicos para entender cómo funciona.
#
# IMPORTANTE: No ejecutes este archivo completo. Lee cada línea y ejecuta
# los comandos uno por uno en tu terminal.
# =============================================================================


# --- PASO 1: Verificar que Git está instalado ---
# Este comando muestra la versión de Git instalada en tu sistema.
# Si ves un número de versión (ej: git version 2.43.0), todo está bien.
# Si ves un error, necesitas instalar Git primero (ver capítulo 02).
git --version


# --- PASO 2: Pedir ayuda a Git ---
# Git tiene documentación incorporada. Si alguna vez olvidas cómo usar
# un comando, puedes pedirle ayuda directamente.

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
# Sin Git, los programadores tenían que:
#   - Hacer copias manuales de carpetas (proyecto_v1, proyecto_v2, etc.)
#   - Enviarse archivos por email para colaborar
#   - Rezar para no sobrescribir el trabajo de alguien más
#
# Con Git:
#   - Cada cambio queda registrado automáticamente
#   - Puedes volver a cualquier versión anterior en segundos
#   - Múltiples personas pueden trabajar al mismo tiempo sin conflictos
#   - Todo queda documentado: quién cambió qué, cuándo y por qué


# --- PASO 5: Probar un comando real ---
# Vamos a crear una carpeta de prueba y usarla como nuestro primer repositorio.
# No te preocupes por entender todo ahora — esto es solo una demostración.

# Crear una carpeta de prueba en tu escritorio o donde prefieras
mkdir mi-primer-repo

# Entrar a la carpeta
cd mi-primer-repo

# Inicializar Git en esta carpeta (convertirla en un repositorio)
# Este comando crea una carpeta oculta llamada .git que es donde Git
# guarda toda la información del historial
git init

# Ver el estado actual del repositorio
# Como está vacío, Git nos dirá que no hay nada que rastrear todavía
git status


# --- PASO 6: Limpiar ---
# Si quieres borrar la carpeta de prueba, sal de ella primero y bórrala
cd ..
rm -rf mi-primer-repo


# =============================================================================
# RESUMEN:
# - Git es un sistema de control de versiones que registra cambios en archivos
# - Se instala en tu computadora y funciona desde la terminal
# - "git --version" verifica que está instalado
# - "git help" te muestra documentación sobre cualquier comando
# - "git init" convierte una carpeta normal en un repositorio de Git
# - "git status" te muestra el estado actual del repositorio
#
# En el siguiente archivo aprenderás la terminología básica de Git.
# =============================================================================
