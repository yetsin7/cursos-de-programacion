#!/bin/bash
# =============================================================================
# ARCHIVO: 06_ejercicios.sh
# TEMA: Ejercicios prácticos sobre .gitignore
# =============================================================================
#
# Estos ejercicios te ayudarán a dominar .gitignore en situaciones reales.
# Crea un repositorio de prueba para cada ejercicio.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 1: CREAR UN .GITIGNORE BÁSICO
# ─────────────────────────────────────────────────────────────────────────────

# 1. Crea un nuevo repositorio de prueba
# 2. Crea los siguientes archivos y carpetas:
#    - app.js
#    - .env
#    - node_modules/paquete/index.js
#    - build/app.min.js
#    - debug.log
#    - .DS_Store
# 3. Crea un .gitignore que ignore: .env, node_modules/, build/, *.log, .DS_Store
# 4. Ejecuta "git status" y verifica que solo app.js y .gitignore aparecen
# 5. Haz commit

mkdir -p ejercicio-gitignore && cd ejercicio-gitignore
git init
touch app.js .env debug.log .DS_Store
mkdir -p node_modules/paquete && touch node_modules/paquete/index.js
mkdir -p build && touch build/app.min.js

# Crea el .gitignore
cat > .gitignore << 'EOF'
.env
node_modules/
build/
*.log
.DS_Store
EOF

# Verifica que solo aparecen app.js y .gitignore
git status

echo ""
echo "========================================="
echo "  EJERCICIO 1: .GITIGNORE BÁSICO"
echo "========================================="
echo ""
echo "  ¿git status solo muestra app.js y .gitignore?"
echo "  Si sí, ¡el .gitignore funciona correctamente!"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 2: PATRONES AVANZADOS
# ─────────────────────────────────────────────────────────────────────────────

# Crea un .gitignore que cumpla TODAS estas reglas:
# 1. Ignora todos los archivos .tmp
# 2. Ignora todos los archivos .log EXCEPTO important.log
# 3. Ignora la carpeta temp/ en cualquier nivel del proyecto
# 4. Ignora archivos .bak solo en la raíz del proyecto
# 5. Ignora todo dentro de docs/ excepto docs/README.md

echo "========================================="
echo "  EJERCICIO 2: PATRONES AVANZADOS"
echo "========================================="
echo ""
echo "  Escribe un .gitignore con:"
echo "  *.tmp"
echo "  *.log  +  !important.log"
echo "  **/temp/"
echo "  /*.bak"
echo "  docs/*  +  !docs/README.md"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 3: DEJAR DE RASTREAR UN ARCHIVO
# ─────────────────────────────────────────────────────────────────────────────

# 1. Crea un nuevo repositorio
# 2. Crea un archivo "secreto.txt" con contenido "mi-password-123"
# 3. Haz commit de secreto.txt (simula el error)
# 4. Ahora agrega secreto.txt al .gitignore
# 5. Verifica que secreto.txt SIGUE apareciendo en git status
# 6. Usa git rm --cached para dejar de rastrearlo
# 7. Haz commit y verifica que ya no aparece

echo "========================================="
echo "  EJERCICIO 3: DEJAR DE RASTREAR"
echo "========================================="
echo ""
echo "  Pasos:"
echo "  1. Crear repo y commitear secreto.txt"
echo "  2. Agregar al .gitignore (no funciona solo)"
echo "  3. git rm --cached secreto.txt"
echo "  4. Commitear y verificar"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 4: GITIGNORE GLOBAL
# ─────────────────────────────────────────────────────────────────────────────

# 1. Crea (o actualiza) tu gitignore global en ~/.gitignore_global
# 2. Configúralo con git config --global core.excludesFile
# 3. Agrega patrones para tu sistema operativo (Windows o Mac)
# 4. Agrega patrones para tu editor de código
# 5. Crea un nuevo repositorio de prueba
# 6. Crea un archivo .DS_Store o Thumbs.db
# 7. Verifica que git status lo ignora sin tener .gitignore en el proyecto

echo "========================================="
echo "  EJERCICIO 4: GITIGNORE GLOBAL"
echo "========================================="
echo ""
echo "  Configura tu gitignore global y verifica que"
echo "  archivos del sistema se ignoran automáticamente"
echo "  en cualquier repositorio nuevo."
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 5: REAPLICAR .GITIGNORE
# ─────────────────────────────────────────────────────────────────────────────

# 1. Crea un repositorio con estos archivos commiteados:
#    app.js, config.json, .env, node_modules/lib.js, debug.log
# 2. Ahora crea un .gitignore que debería ignorar .env, node_modules/, *.log
# 3. Verifica que .env y debug.log SIGUEN apareciendo (porque ya están rastreados)
# 4. Usa la técnica de "reaplicar .gitignore":
#    git rm -r --cached .
#    git add .
#    git commit -m "Reaplicar .gitignore"
# 5. Verifica que solo app.js, config.json y .gitignore están rastreados

echo "========================================="
echo "  EJERCICIO 5: REAPLICAR .GITIGNORE"
echo "========================================="
echo ""
echo "  Practica la técnica de reaplicar el .gitignore"
echo "  completo para limpiar archivos que no deberían"
echo "  estar rastreados."
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 6: GITIGNORE PARA TU PROYECTO REAL
# ─────────────────────────────────────────────────────────────────────────────

# 1. Elige un proyecto personal (Flutter, Nuxt, Node, Python, etc.)
# 2. Revisa si tiene un .gitignore adecuado
# 3. Compara con la plantilla oficial de GitHub para ese lenguaje:
#    https://github.com/github/gitignore
# 4. Agrega los patrones que falten
# 5. Si hay archivos que no deberían estar rastreados, usa git rm --cached
# 6. Haz commit de los cambios

echo "========================================="
echo "  EJERCICIO 6: TU PROYECTO REAL"
echo "========================================="
echo ""
echo "  Revisa y mejora el .gitignore de un proyecto"
echo "  real tuyo. Compara con las plantillas oficiales."
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# VERIFICACIÓN FINAL
# ─────────────────────────────────────────────────────────────────────────────

echo "========================================="
echo "  VERIFICACIÓN"
echo "========================================="
echo ""
echo "  Después de cada ejercicio, verifica:"
echo "  [ ] git status muestra solo los archivos esperados"
echo "  [ ] git check-ignore -v confirma que los patrones funcionan"
echo "  [ ] Los archivos ignorados no están en el repo remoto"
echo "  [ ] Tu .gitignore tiene comentarios explicativos"
echo ""
