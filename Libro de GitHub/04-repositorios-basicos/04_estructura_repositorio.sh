# =============================================================================
# ARCHIVO: 04_estructura_repositorio.sh
# TEMA: Estructura interna de un repositorio — La carpeta .git
# =============================================================================
#
# Cuando haces "git init" o "git clone", Git crea una carpeta oculta
# llamada ".git" dentro de tu proyecto. Esta carpeta es el CORAZÓN de Git.
# Todo el historial, configuración y datos internos viven ahí.
#
# En este archivo exploraremos qué contiene .git y qué hace cada parte.
# No necesitas memorizar todo esto, pero entenderlo te hará mejor developer.
# =============================================================================


# ─────────────────────────────────────────────────────────────────────────────
# PREPARACIÓN: Crear un repositorio de prueba con contenido
# ─────────────────────────────────────────────────────────────────────────────

# Crear un repositorio de prueba
mkdir explorar-git
cd explorar-git
git init

# Crear algunos archivos y hacer commits para tener contenido
echo "# Mi Proyecto" > README.md
git add README.md
git commit -m "Agregar README"

echo "console.log('hola');" > app.js
git add app.js
git commit -m "Agregar archivo principal app.js"


# ─────────────────────────────────────────────────────────────────────────────
# EXPLORAR LA CARPETA .git
# ─────────────────────────────────────────────────────────────────────────────

# Ver el contenido de la carpeta .git
# Aquí vive TODO lo que Git necesita para funcionar
ls -la .git/

# Deberías ver algo como:
#   HEAD            → Apunta a la rama actual en la que estás
#   config          → Configuración local de este repositorio
#   description     → Descripción del repo (usado por GitWeb, raramente)
#   hooks/          → Scripts que se ejecutan automáticamente (pre-commit, etc.)
#   info/           → Información adicional (como archivos a ignorar)
#   objects/        → TODOS los datos: archivos, commits, árboles
#   refs/           → Referencias a commits (ramas y tags)
#   index           → El staging area (área de preparación)
#   logs/           → Historial de cambios en las referencias


# ─────────────────────────────────────────────────────────────────────────────
# HEAD — ¿En qué rama estás?
# ─────────────────────────────────────────────────────────────────────────────

# HEAD es un archivo que dice en qué rama estás trabajando actualmente
# Normalmente contiene una referencia a la rama actual
cat .git/HEAD

# Deberías ver algo como: ref: refs/heads/main
# Esto significa que estás en la rama "main"


# ─────────────────────────────────────────────────────────────────────────────
# config — Configuración local del repositorio
# ─────────────────────────────────────────────────────────────────────────────

# Este archivo contiene la configuración específica de ESTE repositorio
# (no la global). Incluye los remotos configurados, opciones locales, etc.
cat .git/config

# Si agregas un remoto, aparecerá aquí:
# [remote "origin"]
#     url = https://github.com/usuario/repo.git
#     fetch = +refs/heads/*:refs/remotes/origin/*


# ─────────────────────────────────────────────────────────────────────────────
# objects/ — Donde Git guarda TODOS los datos
# ─────────────────────────────────────────────────────────────────────────────

# La carpeta objects contiene todos los datos del repositorio:
# archivos (blobs), directorios (trees), commits y tags.
# Todo está comprimido y referenciado por su hash SHA-1.
ls .git/objects/

# Cada subcarpeta tiene nombre de 2 caracteres hexadecimales
# Dentro de cada una hay archivos con nombres de 38 caracteres hex
# Juntos forman el hash SHA-1 de 40 caracteres que identifica cada objeto

# Puedes ver los objetos que Git ha almacenado:
git cat-file --batch-all-objects --batch-check


# ─────────────────────────────────────────────────────────────────────────────
# refs/ — Referencias (ramas y tags)
# ─────────────────────────────────────────────────────────────────────────────

# Las referencias son "punteros" a commits específicos
# Las ramas son simplemente archivos que contienen el hash de un commit

# Ver las ramas locales
ls .git/refs/heads/

# Ver a qué commit apunta la rama main
cat .git/refs/heads/main

# Ese hash largo es el identificador del último commit en la rama main
# Puedes verificarlo con:
git log --oneline -1


# ─────────────────────────────────────────────────────────────────────────────
# hooks/ — Scripts automáticos
# ─────────────────────────────────────────────────────────────────────────────

# Los hooks son scripts que Git ejecuta automáticamente en ciertos momentos
# Por ejemplo: antes de un commit, después de un push, etc.
ls .git/hooks/

# Por defecto, Git incluye ejemplos (archivos .sample) que están desactivados
# Para activar un hook, renombra el archivo quitando ".sample"
# Ejemplo: pre-commit.sample → pre-commit
#
# Los hooks más comunes:
#   pre-commit   → se ejecuta ANTES de cada commit (útil para linting)
#   commit-msg   → se ejecuta al escribir un mensaje de commit
#   pre-push     → se ejecuta ANTES de cada push
#   post-merge   → se ejecuta DESPUÉS de un merge


# ─────────────────────────────────────────────────────────────────────────────
# EL WORKING DIRECTORY (todo lo que NO es .git)
# ─────────────────────────────────────────────────────────────────────────────

# Todo lo que está FUERA de .git es tu "working directory" (directorio de trabajo)
# Es donde viven tus archivos reales: código, imágenes, documentos, etc.

# Ver tus archivos de trabajo
ls

# Deberías ver: README.md, app.js
# Estos son los archivos con los que trabajas directamente

# Git compara constantemente el working directory con lo que tiene guardado
# en .git para saber qué cambió
git status


# ─────────────────────────────────────────────────────────────────────────────
# REGLA DE ORO: NUNCA modifiques .git manualmente
# ─────────────────────────────────────────────────────────────────────────────
# La carpeta .git es territorio de Git. Modificarla manualmente puede:
#   - Corromper tu repositorio
#   - Perder todo el historial de commits
#   - Hacer que Git deje de funcionar en ese proyecto
#
# Siempre usa comandos de Git para interactuar con el repositorio.
# Los únicos archivos que es "seguro" editar manualmente son:
#   - .git/config (aunque es mejor usar "git config")
#   - .git/hooks/* (para crear hooks personalizados)


# Limpiar
cd ..
rm -rf explorar-git


# =============================================================================
# RESUMEN:
# - La carpeta .git contiene TODO lo que Git necesita
# - HEAD indica en qué rama estás
# - objects/ guarda todos los datos (archivos, commits, etc.)
# - refs/ contiene las ramas y tags (punteros a commits)
# - hooks/ tiene scripts que se ejecutan automáticamente
# - NUNCA borres ni modifiques .git manualmente
# - Tu working directory son tus archivos reales fuera de .git
#
# Siguiente archivo: 05_ejercicios.sh
# =============================================================================
