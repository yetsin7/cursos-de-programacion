# =============================================================================
# ARCHIVO: 03_como_funciona_git.sh
# TEMA: Las 3 areas de Git
# =============================================================================
#
# Este archivo explica el corazon real de Git.
# Si entiendes estas 3 areas, casi todos los comandos dejan de parecer magia.
#
# Las areas son:
#   1. Working Directory
#   2. Staging Area
#   3. Repository
# =============================================================================


# ─────────────────────────────────────────────────────────────────────────────
# ÁREA 1: WORKING DIRECTORY (Directorio de trabajo)
# ─────────────────────────────────────────────────────────────────────────────
# Es la carpeta real de tu proyecto.
# Cuando abres archivos en VS Code, normalmente estas trabajando aqui.
#
# Aquí es donde:
#   - Creas archivos nuevos
#   - Editas archivos existentes
#   - Borras archivos
#
# Lo que cambias aqui aun no forma parte del historial permanente.


# ─────────────────────────────────────────────────────────────────────────────
# ÁREA 2: STAGING AREA (Área de preparación)
# ─────────────────────────────────────────────────────────────────────────────
# Tambien se llama index.
# Es una zona intermedia para decidir que cambios iran al proximo commit.
#
# ¿Por qué existe? Porque a veces cambias 10 archivos pero solo quieres
# guardar 3 en tu próximo commit. El Staging Area te permite elegir
# exactamente qué cambios incluir.
#
# Piensalo como una mesa de preparacion.
# Solo lo que esta sobre esa mesa entra al commit.


# ─────────────────────────────────────────────────────────────────────────────
# ÁREA 3: REPOSITORY (Repositorio / Historial)
# ─────────────────────────────────────────────────────────────────────────────
# Aqui Git guarda los commits de forma persistente.
# Vive dentro de la carpeta oculta ".git".
#
# Cada commit tiene un identificador unico y representa un punto del historial.


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
# Vamos a verlo en accion:

# Paso 0: Crear un repositorio de prueba
mkdir prueba-areas
cd prueba-areas
git init

# Paso 1: Crear un archivo (Working Directory)
# El archivo existe en disco, pero todavia no forma parte del control de Git.
echo "Hola mundo" > archivo.txt

# Verificar: Git muestra el archivo como "untracked" (sin rastrear)
# Git lo detecta, pero aun no esta preparado para commit.
git status

# Paso 2: Mover el archivo al Staging Area con "git add"
# Con git add, Git marca este cambio como preparado.
git add archivo.txt

# Verificar: Git muestra el archivo como "Changes to be committed"
# Ahora el cambio ya esta seleccionado para el proximo commit.
git status

# Paso 3: Guardar el "snapshot" con "git commit"
# git commit guarda un nuevo punto del historial.
# El mensaje debe explicar con claridad que cambio se hizo.
git commit -m "Agregar archivo.txt con saludo inicial"

# Verificar: Git muestra "nothing to commit, working tree clean"
# Si todo esta limpio, working tree y historial estan alineados.
git status

# Paso 4: Ver el historial de commits
# git log muestra el historial completo.
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
#   Tambien puedes retroceder o mover cambios entre areas:
#   - "git restore --staged archivo" saca un archivo del staging
#   - "git checkout <hash>" o "git switch" sirve para moverte en el historial


# ─────────────────────────────────────────────────────────────────────────────
# EJEMPLO PRÁCTICO: Staging selectivo
# ─────────────────────────────────────────────────────────────────────────────
# Ahora vamos a demostrar por que el staging area existe.

# Crear dos archivos nuevos
echo "Contenido de index" > index.html
echo "Contenido de estilos" > styles.css

# Git muestra ambos como nuevos archivos sin seguimiento.
git status

# Solo queremos guardar uno de ellos ahora.
git add index.html

# Un archivo puede estar listo para commit y otro no.
git status

# Hacer commit solo con index.html
git commit -m "Agregar página principal index.html"

# styles.css sigue fuera del commit anterior.
git status

# Ahora agregamos y guardamos styles.css en un commit separado
git add styles.css
git commit -m "Agregar hoja de estilos styles.css"

# El historial muestra commits pequenos y mas faciles de entender.
git log --oneline


# Limpieza
cd ..

# En Linux o macOS:
# rm -rf prueba-areas

# En PowerShell:
# Remove-Item -Recurse -Force prueba-areas


# =============================================================================
# RESUMEN:
#
# Las 3 areas de Git:
#   1. Working Directory → donde editas
#   2. Staging Area → donde eliges que guardar
#   3. Repository → donde el historial queda registrado
#
# Los comandos clave del flujo:
#   - "git add" → mueve cambios al staging
#   - "git commit" → guarda el staging en el historial
#   - "git status" → te dice donde esta cada archivo
#   - "git log" → muestra los commits
#
# Si entiendes este flujo, Git deja de sentirse confuso.
# =============================================================================
