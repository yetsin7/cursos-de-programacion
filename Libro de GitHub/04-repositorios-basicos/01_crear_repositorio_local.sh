# =============================================================================
# ARCHIVO: 01_crear_repositorio_local.sh
# TEMA: Crear un repositorio local con git init
# =============================================================================
#
# Un repositorio local es una carpeta en tu computadora donde Git rastrea
# todos los cambios que haces. Para crear uno, usas el comando "git init".
#
# Este comando crea una carpeta oculta llamada ".git" dentro de tu proyecto.
# Esa carpeta es el "cerebro" de Git — ahí guarda todo el historial.
#
# IMPORTANTE: Ejecuta estos comandos uno por uno en tu terminal.
# =============================================================================


# ─────────────────────────────────────────────────────────────────────────────
# MÉTODO 1: Crear un repositorio desde una carpeta vacía
# ─────────────────────────────────────────────────────────────────────────────

# Paso 1: Crear una carpeta nueva para tu proyecto
# Puedes crearla donde quieras (escritorio, documentos, etc.)
mkdir mi-proyecto-web

# Paso 2: Entrar a la carpeta
cd mi-proyecto-web

# Paso 3: Inicializar Git en esta carpeta
# Este comando convierte la carpeta en un repositorio de Git
# Verás un mensaje: "Initialized empty Git repository in .../mi-proyecto-web/.git/"
git init

# Paso 4: Verificar que se creó correctamente
# Git muestra que estás en la rama "main" y no hay commits todavía
git status

# Paso 5: Ver la carpeta oculta .git que se creó
# En macOS/Linux, los archivos que empiezan con "." están ocultos
# Este comando los muestra
ls -la

# Deberías ver una carpeta llamada ".git" — esa es la magia de Git
# NUNCA borres ni modifiques manualmente la carpeta .git
# Si la borras, pierdes TODO el historial de tu proyecto


# ─────────────────────────────────────────────────────────────────────────────
# MÉTODO 2: Crear un repositorio en una carpeta que ya tiene archivos
# ─────────────────────────────────────────────────────────────────────────────

# Sal de la carpeta anterior
cd ..

# Crear una carpeta con archivos existentes (simulamos un proyecto existente)
mkdir proyecto-existente
cd proyecto-existente

# Crear algunos archivos como si ya tuvieras un proyecto
echo "<!DOCTYPE html><html><body><h1>Hola</h1></body></html>" > index.html
echo "body { margin: 0; }" > styles.css
echo "console.log('Hola mundo');" > app.js

# Verificar que los archivos existen
ls

# Inicializar Git — funciona igual que antes
# Git empezará a rastrear esta carpeta y todos sus archivos
git init

# Ver el estado — Git detecta los archivos existentes como "untracked"
# "Untracked" significa que Git los ve pero aún no los está rastreando
git status

# Para que Git empiece a rastrear estos archivos, los agregamos al staging area
git add .

# El punto (.) significa "todos los archivos del directorio actual"
# Ahora Git muestra los archivos como "Changes to be committed"
git status

# Hacemos el primer commit para guardar el estado inicial del proyecto
git commit -m "Commit inicial: estructura base del proyecto web"

# Verificar: ahora el repo tiene 1 commit y el working tree está limpio
git status
git log --oneline


# ─────────────────────────────────────────────────────────────────────────────
# ERRORES COMUNES AL CREAR REPOSITORIOS
# ─────────────────────────────────────────────────────────────────────────────

# ERROR 1: Hacer "git init" en la carpeta equivocada
# Si haces git init en tu carpeta de usuario (~/) o en tu escritorio,
# Git rastreará TODOS los archivos de esa carpeta (incluyendo miles de
# archivos del sistema). Esto es un desastre.
#
# SOLUCIÓN: Siempre crea una carpeta específica para tu proyecto y haz
# git init DENTRO de esa carpeta.

# ERROR 2: Hacer "git init" dentro de otro repositorio
# Si ya estás dentro de un repo y haces git init en una subcarpeta,
# crearás un repositorio anidado (nested). Esto causa problemas.
#
# SOLUCIÓN: Verifica que no estés dentro de un repo antes de crear uno nuevo
# Usa este comando para verificar — si da error, no estás en un repo:
git rev-parse --show-toplevel

# ERROR 3: Borrar la carpeta .git accidentalmente
# Si borras .git, pierdes TODO el historial. Los archivos siguen ahí,
# pero Git ya no los reconoce como repositorio.
#
# SOLUCIÓN: Nunca toques la carpeta .git. Si usas el explorador de archivos,
# asegúrate de tener visible la opción de "mostrar archivos ocultos".


# Limpiar las carpetas de prueba
cd ..
rm -rf mi-proyecto-web
rm -rf proyecto-existente


# =============================================================================
# RESUMEN:
# - "git init" crea un repositorio nuevo en la carpeta actual
# - Funciona en carpetas vacías o con archivos existentes
# - Crea una carpeta oculta ".git" — NUNCA la borres
# - Siempre verifica con "git status" que se creó correctamente
# - No hagas git init en carpetas grandes como ~/ o el escritorio
#
# Siguiente archivo: 02_crear_repositorio_github.sh
# =============================================================================
