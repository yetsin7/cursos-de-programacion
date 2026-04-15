# =============================================================================
# ARCHIVO: 03_como_funciona_git.sh
# TEMA: Las 3 áreas de Git — Cómo funciona internamente
# =============================================================================
#
# Para entender Git de verdad, necesitas conocer sus 3 áreas principales.
# Todo archivo en un repositorio de Git se encuentra en una de estas 3 áreas.
# Si entiendes esto, entenderás por qué los comandos hacen lo que hacen.
#
# Las 3 áreas son:
#   1. Working Directory (directorio de trabajo)
#   2. Staging Area (área de preparación)
#   3. Repository (repositorio / historial de commits)
# =============================================================================


# ─────────────────────────────────────────────────────────────────────────────
# ÁREA 1: WORKING DIRECTORY (Directorio de trabajo)
# ─────────────────────────────────────────────────────────────────────────────
# Es la carpeta real en tu computadora donde están tus archivos.
# Cuando abres tu proyecto en VS Code, estás viendo el Working Directory.
#
# Aquí es donde:
#   - Creas archivos nuevos
#   - Editas archivos existentes
#   - Borras archivos
#
# Los cambios en el Working Directory NO están guardados en Git todavía.
# Git los ve como "cambios sin rastrear" o "cambios no preparados".


# ─────────────────────────────────────────────────────────────────────────────
# ÁREA 2: STAGING AREA (Área de preparación)
# ─────────────────────────────────────────────────────────────────────────────
# También conocida como "index". Es un área intermedia donde colocas
# los cambios que QUIERES incluir en tu próximo commit.
#
# ¿Por qué existe? Porque a veces cambias 10 archivos pero solo quieres
# guardar 3 en tu próximo commit. El Staging Area te permite elegir
# exactamente qué cambios incluir.
#
# Piensa en ello como una mesa donde pones las cosas que vas a empacar.
# Solo lo que está en la mesa se empacará (commit).


# ─────────────────────────────────────────────────────────────────────────────
# ÁREA 3: REPOSITORY (Repositorio / Historial)
# ─────────────────────────────────────────────────────────────────────────────
# Es donde Git guarda permanentemente las "fotos" (commits) de tu proyecto.
# Vive dentro de la carpeta oculta ".git" en tu proyecto.
#
# Cada commit en el Repository es permanente y tiene un identificador único.
# Puedes volver a cualquier commit anterior en cualquier momento.


# ─────────────────────────────────────────────────────────────────────────────
# EL FLUJO COMPLETO: De archivo modificado a commit guardado
# ─────────────────────────────────────────────────────────────────────────────
#
# El flujo de trabajo con Git siempre sigue este patrón:
#
#   [Working Directory]  →  [Staging Area]  →  [Repository]
#        (editas)           (preparas)          (guardas)
#        tu código          con "git add"       con "git commit"
#
# Vamos a verlo en acción:

# Paso 0: Crear un repositorio de prueba
mkdir prueba-areas
cd prueba-areas
git init

# Paso 1: Crear un archivo (Working Directory)
# Este archivo existe en tu carpeta pero Git aún no lo rastrea
echo "Hola mundo" > archivo.txt

# Verificar: Git muestra el archivo como "untracked" (sin rastrear)
# Esto significa que está en el Working Directory pero Git no lo conoce
git status

# Paso 2: Mover el archivo al Staging Area con "git add"
# Ahora Git sabe que quieres incluir este archivo en tu próximo commit
git add archivo.txt

# Verificar: Git muestra el archivo como "Changes to be committed"
# Esto significa que está en el Staging Area, listo para ser guardado
git status

# Paso 3: Guardar el "snapshot" con "git commit"
# El archivo pasa del Staging Area al Repository (historial permanente)
# El flag -m permite escribir un mensaje que describe el cambio
git commit -m "Agregar archivo.txt con saludo inicial"

# Verificar: Git muestra "nothing to commit, working tree clean"
# Esto significa que los 3 áreas están sincronizadas — todo está guardado
git status

# Paso 4: Ver el historial de commits
# Aquí puedes ver tu commit guardado con su hash, autor, fecha y mensaje
git log


# ─────────────────────────────────────────────────────────────────────────────
# DIAGRAMA VISUAL DEL FLUJO
# ─────────────────────────────────────────────────────────────────────────────
#
#   ┌─────────────────┐    git add    ┌──────────────┐   git commit   ┌────────────┐
#   │    WORKING       │ ──────────→  │   STAGING     │ ────────────→ │ REPOSITORY  │
#   │   DIRECTORY      │              │    AREA       │               │  (.git)     │
#   │                  │              │               │               │             │
#   │  Editas archivos │              │ Preparas los  │               │ Se guarda   │
#   │  libremente      │              │ que quieres   │               │ permanente  │
#   │                  │              │ incluir       │               │             │
#   └─────────────────┘              └──────────────┘               └────────────┘
#
#   También puedes ir hacia atrás:
#   - "git restore --staged archivo" → saca un archivo del Staging Area
#   - "git checkout <hash>" → vuelve a un commit anterior


# ─────────────────────────────────────────────────────────────────────────────
# EJEMPLO PRÁCTICO: Staging selectivo
# ─────────────────────────────────────────────────────────────────────────────
# Vamos a demostrar por qué el Staging Area es útil

# Crear dos archivos nuevos
echo "Contenido de index" > index.html
echo "Contenido de estilos" > styles.css

# Git muestra ambos archivos como "untracked"
git status

# Pero solo queremos guardar index.html en este commit
# Así que solo agregamos ese archivo al Staging Area
git add index.html

# Verificar: index.html está en Staging, styles.css sigue sin rastrear
git status

# Hacer commit solo con index.html
git commit -m "Agregar página principal index.html"

# styles.css sigue en el Working Directory, esperando ser agregado después
git status

# Ahora agregamos y guardamos styles.css en un commit separado
git add styles.css
git commit -m "Agregar hoja de estilos styles.css"

# Ver el historial: ahora hay 3 commits, cada uno con cambios específicos
git log --oneline


# Limpieza
cd ..
rm -rf prueba-areas


# =============================================================================
# RESUMEN:
#
# Las 3 áreas de Git:
#   1. Working Directory → donde editas tus archivos (tu carpeta real)
#   2. Staging Area → donde preparas los cambios para el próximo commit
#   3. Repository → donde Git guarda los commits permanentemente
#
# Los comandos clave del flujo:
#   - "git add" → mueve cambios del Working Directory al Staging Area
#   - "git commit" → mueve cambios del Staging Area al Repository
#   - "git status" → te dice en qué área está cada archivo
#   - "git log" → muestra el historial de commits del Repository
#
# Este flujo de 3 áreas es el CORAZÓN de Git. Todo lo demás
# que aprenderás se construye sobre este concepto.
# =============================================================================
