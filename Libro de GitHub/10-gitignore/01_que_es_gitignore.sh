#!/bin/bash
# =============================================================================
# ARCHIVO: 01_que_es_gitignore.sh
# TEMA: ¿Qué es .gitignore? — Concepto y propósito
# =============================================================================
#
# Cuando trabajas en un proyecto, Git rastrea TODOS los archivos por defecto.
# Pero no todos los archivos deben estar en el repositorio. El archivo
# .gitignore le dice a Git cuáles ignorar.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# ¿QUÉ ES .GITIGNORE?
# ─────────────────────────────────────────────────────────────────────────────

# .gitignore es un archivo de texto plano que se coloca en la raíz del
# repositorio (o en subdirectorios). Cada línea contiene un patrón que
# indica qué archivos o carpetas Git debe ignorar.

# Los archivos ignorados:
# - NO aparecen en "git status"
# - NO se agregan con "git add ."
# - NO se incluyen en commits
# - NO se suben al repositorio remoto

echo "========================================="
echo "  ¿QUÉ ES .GITIGNORE?"
echo "========================================="
echo ""
echo "  Un archivo de texto que le dice a Git qué archivos ignorar."
echo "  Los archivos ignorados no se rastrean, no se commitean"
echo "  y no se suben al repositorio remoto."
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# ¿POR QUÉ NECESITAS .GITIGNORE?
# ─────────────────────────────────────────────────────────────────────────────

# Hay archivos que NUNCA deben estar en un repositorio.
# Las razones principales son:

echo "========================================="
echo "  ¿POR QUÉ IGNORAR ARCHIVOS?"
echo "========================================="
echo ""
echo "  1. SEGURIDAD — Archivos con contraseñas y API keys"
echo "     .env, credentials.json, keystores, tokens"
echo ""
echo "  2. TAMAÑO — Archivos que se regeneran automáticamente"
echo "     node_modules/, build/, dist/, .dart_tool/"
echo ""
echo "  3. SISTEMA — Archivos basura del sistema operativo"
echo "     .DS_Store (Mac), Thumbs.db (Windows), *.swp (Vim)"
echo ""
echo "  4. IDE — Configuración personal de tu editor"
echo "     .idea/ (JetBrains), .vscode/ (parcial), *.iml"
echo ""
echo "  5. CONFLICTOS — Archivos que causan merge conflicts"
echo "     Logs, caches, archivos temporales"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# CREAR UN ARCHIVO .GITIGNORE
# ─────────────────────────────────────────────────────────────────────────────

# Crear un .gitignore es tan simple como crear un archivo de texto.
# El nombre DEBE ser exactamente ".gitignore" (con el punto al inicio).

# Método 1: Desde la terminal
touch .gitignore

# Método 2: Al crear un repositorio en GitHub, puedes seleccionar
# una plantilla de .gitignore para tu lenguaje/framework.

# Método 3: Usando echo para agregar patrones
echo "node_modules/" >> .gitignore
echo ".env" >> .gitignore
echo "build/" >> .gitignore

# Ver el contenido del .gitignore
cat .gitignore

echo ""
echo "========================================="
echo "  CREAR .GITIGNORE"
echo "========================================="
echo ""
echo "  touch .gitignore                  # Crear archivo vacío"
echo "  echo 'node_modules/' >> .gitignore  # Agregar patrón"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# ¿DÓNDE VA EL .GITIGNORE?
# ─────────────────────────────────────────────────────────────────────────────

# El .gitignore normalmente va en la raíz del repositorio.
# Pero puedes tener .gitignore en subdirectorios también.
# Los patrones de un .gitignore solo aplican al directorio donde está
# y sus subdirectorios.

cat << 'EJEMPLO'
mi-proyecto/
├── .gitignore          ← Principal (aplica a todo el repo)
├── src/
│   └── .gitignore      ← Solo aplica dentro de src/
├── tests/
│   └── .gitignore      ← Solo aplica dentro de tests/
└── docs/
EJEMPLO

# En la práctica, la mayoría de los proyectos solo necesitan UN .gitignore
# en la raíz del repositorio.

# ─────────────────────────────────────────────────────────────────────────────
# EJEMPLO BÁSICO DE .GITIGNORE
# ─────────────────────────────────────────────────────────────────────────────

# Aquí hay un .gitignore mínimo que funciona para la mayoría de proyectos:

cat << 'GITIGNORE'
# ===========================
# Dependencias
# ===========================
node_modules/
vendor/
.dart_tool/
__pycache__/

# ===========================
# Archivos de build
# ===========================
build/
dist/
*.o
*.class

# ===========================
# Variables de entorno y secretos
# ===========================
.env
.env.local
.env.production
*.key
*.pem

# ===========================
# Sistema operativo
# ===========================
.DS_Store
Thumbs.db
Desktop.ini

# ===========================
# IDE y editores
# ===========================
.idea/
*.iml
.vscode/settings.json
*.swp
*.swo
*~

# ===========================
# Logs
# ===========================
*.log
npm-debug.log*
yarn-debug.log*
GITIGNORE

echo ""
echo "========================================="
echo "  EJEMPLO BÁSICO"
echo "========================================="
echo ""
echo "  # Dependencias"
echo "  node_modules/"
echo ""
echo "  # Build"
echo "  build/"
echo ""
echo "  # Secretos"
echo "  .env"
echo ""
echo "  # Sistema"
echo "  .DS_Store"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# VERIFICAR QUÉ ARCHIVOS ESTÁN IGNORADOS
# ─────────────────────────────────────────────────────────────────────────────

# Puedes verificar si un archivo está siendo ignorado con este comando:
git check-ignore -v nombre-del-archivo

# Ejemplo: verificar si node_modules está ignorado
git check-ignore -v node_modules/

# Para ver TODOS los archivos ignorados del repositorio:
git status --ignored

# Para listar todos los archivos ignorados:
git ls-files --others --ignored --exclude-standard

echo ""
echo "========================================="
echo "  VERIFICAR ARCHIVOS IGNORADOS"
echo "========================================="
echo ""
echo "  git check-ignore -v archivo     # ¿Está ignorado? ¿Por qué regla?"
echo "  git status --ignored            # Ver todos los archivos ignorados"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# DATO IMPORTANTE: .GITIGNORE SOLO IGNORA ARCHIVOS NO RASTREADOS
# ─────────────────────────────────────────────────────────────────────────────

# Si un archivo YA fue agregado al repositorio (ya tiene commits),
# agregarlo al .gitignore NO lo elimina del repositorio.
# El .gitignore solo previene que archivos NUEVOS sean rastreados.
#
# Para dejar de rastrear un archivo que ya está en el repo,
# necesitas usar: git rm --cached archivo
# (Esto se explica en detalle en 05_dejar_de_rastrear.sh)

echo "========================================="
echo "  DATO CLAVE"
echo "========================================="
echo ""
echo "  .gitignore solo ignora archivos que NO están rastreados."
echo "  Si ya hiciste commit de un archivo, agregarlo al .gitignore"
echo "  NO lo elimina. Necesitas 'git rm --cached' para eso."
echo ""
