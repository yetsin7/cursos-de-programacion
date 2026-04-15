#!/bin/bash
# =============================================================================
# ARCHIVO: 03_plantillas_comunes.sh
# TEMA: Plantillas de .gitignore para Node, Python, Flutter, Java y más
# =============================================================================
#
# No necesitas escribir tu .gitignore desde cero. Existen plantillas
# probadas para cada lenguaje y framework. Aquí verás las más comunes
# y aprenderás dónde encontrarlas.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# DÓNDE ENCONTRAR PLANTILLAS
# ─────────────────────────────────────────────────────────────────────────────

# GitHub mantiene un repositorio oficial con plantillas de .gitignore
# para cientos de lenguajes y frameworks:
# https://github.com/github/gitignore

# Al crear un repositorio nuevo en GitHub, puedes seleccionar una
# plantilla directamente desde la interfaz web.

# También existe: https://www.toptal.com/developers/gitignore
# Un generador web donde seleccionas tus tecnologías y genera
# el .gitignore combinado.

echo "========================================="
echo "  DÓNDE ENCONTRAR PLANTILLAS"
echo "========================================="
echo ""
echo "  GitHub oficial: https://github.com/github/gitignore"
echo "  Generador web:  https://www.toptal.com/developers/gitignore"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# PLANTILLA: NODE.JS / JAVASCRIPT / TYPESCRIPT
# ─────────────────────────────────────────────────────────────────────────────

cat << 'GITIGNORE'
# ===========================
# Node.js / JavaScript / TypeScript
# ===========================

# Dependencias
node_modules/

# Build y output
dist/
build/
.output/
.nuxt/
.next/

# Variables de entorno
.env
.env.local
.env.*.local

# Logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*

# Cache
.cache/
.parcel-cache/
.eslintcache

# Testing
coverage/
.nyc_output/

# OS
.DS_Store
Thumbs.db

# IDE
.idea/
*.iml
.vscode/settings.json
GITIGNORE

echo ""
echo "========================================="
echo "  PLANTILLA: NODE.JS"
echo "========================================="
echo "  Clave: node_modules/, dist/, .env, *.log"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# PLANTILLA: PYTHON
# ─────────────────────────────────────────────────────────────────────────────

cat << 'GITIGNORE'
# ===========================
# Python
# ===========================

# Bytecode compilado
__pycache__/
*.py[cod]
*$py.class

# Entornos virtuales
venv/
.venv/
env/
ENV/

# Distribución / packaging
dist/
build/
*.egg-info/
*.egg

# Variables de entorno
.env
.env.local

# Testing
.pytest_cache/
.coverage
htmlcov/
.tox/

# Jupyter Notebooks
.ipynb_checkpoints/

# IDEs
.idea/
.vscode/settings.json
*.swp

# OS
.DS_Store
Thumbs.db
GITIGNORE

echo "========================================="
echo "  PLANTILLA: PYTHON"
echo "========================================="
echo "  Clave: __pycache__/, venv/, *.py[cod], .env"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# PLANTILLA: FLUTTER / DART
# ─────────────────────────────────────────────────────────────────────────────

cat << 'GITIGNORE'
# ===========================
# Flutter / Dart
# ===========================

# Dart
.dart_tool/
.packages
pubspec.lock    # Solo para paquetes (libraries), NO para apps

# Flutter
build/
.flutter-plugins
.flutter-plugins-dependencies

# IDE
.idea/
*.iml
.vscode/settings.json

# Android
**/android/.gradle/
**/android/captures/
**/android/gradlew
**/android/gradlew.bat
**/android/local.properties
**/android/**/GeneratedPluginRegistrant.java

# iOS
**/ios/Pods/
**/ios/.symlinks/
**/ios/Flutter/Flutter.framework
**/ios/Flutter/Flutter.podspec
**/ios/Flutter/Generated.xcconfig
**/ios/Flutter/app.flx
**/ios/Flutter/app.zip
**/ios/Flutter/flutter_assets/
**/ios/ServiceDefinitions.json
**/ios/Runner/GeneratedPluginRegistrant.*

# Excepciones: mantener estos archivos de configuración
!**/ios/Runner/
!**/android/app/

# Keystore (NUNCA subir keystores al repo)
*.jks
*.keystore

# Variables de entorno
.env
GITIGNORE

echo "========================================="
echo "  PLANTILLA: FLUTTER"
echo "========================================="
echo "  Clave: .dart_tool/, build/, *.jks, local.properties"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# PLANTILLA: JAVA
# ─────────────────────────────────────────────────────────────────────────────

cat << 'GITIGNORE'
# ===========================
# Java
# ===========================

# Compilados
*.class
*.jar
*.war
*.ear

# Build
build/
target/
out/

# Gradle
.gradle/
gradle/wrapper/gradle-wrapper.jar

# Maven
pom.xml.tag
pom.xml.releaseBackup
pom.xml.versionsBackup
pom.xml.next

# IDE
.idea/
*.iml
.classpath
.project
.settings/
.factorypath
bin/

# OS
.DS_Store
Thumbs.db
GITIGNORE

echo "========================================="
echo "  PLANTILLA: JAVA"
echo "========================================="
echo "  Clave: *.class, build/, target/, .gradle/"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# PLANTILLA: NUXT / VUE
# ─────────────────────────────────────────────────────────────────────────────

cat << 'GITIGNORE'
# ===========================
# Nuxt 4 / Vue
# ===========================

# Dependencias
node_modules/

# Nuxt build
.nuxt/
.output/
dist/

# Nitro
.nitro/

# Variables de entorno
.env
.env.local
.env.*.local

# Logs
*.log

# Testing
coverage/

# IDE
.idea/
.vscode/settings.json

# OS
.DS_Store
Thumbs.db
GITIGNORE

echo "========================================="
echo "  PLANTILLA: NUXT"
echo "========================================="
echo "  Clave: .nuxt/, .output/, node_modules/, .env"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# CÓMO USAR LAS PLANTILLAS
# ─────────────────────────────────────────────────────────────────────────────

echo "========================================="
echo "  CÓMO USAR LAS PLANTILLAS"
echo "========================================="
echo ""
echo "  Opción 1: Al crear repo en GitHub, selecciona plantilla"
echo "  Opción 2: Copia de https://github.com/github/gitignore"
echo "  Opción 3: Genera en https://www.toptal.com/developers/gitignore"
echo "  Opción 4: Copia las plantillas de este archivo"
echo ""
echo "  CONSEJO: Combina plantillas si usas múltiples tecnologías."
echo "  Ejemplo: Node.js + Nuxt + VS Code = combina las tres."
echo ""
