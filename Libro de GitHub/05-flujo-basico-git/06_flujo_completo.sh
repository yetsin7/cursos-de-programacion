#!/bin/bash
# =============================================================================
# ARCHIVO: 06_flujo_completo.sh
# TEMA: Ejemplo completo del flujo de trabajo en Git
# =============================================================================
#
# Este archivo simula un flujo de trabajo real: desde crear un proyecto desde
# cero hasta tener varios commits organizados. Sigue cada paso para
# interiorizar el ciclo modificar → preparar → confirmar.
#
# ⚠️ NOTA: Este script crea un repositorio temporal de práctica.
# No afecta tu proyecto real.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# 1. Preparar el entorno de práctica
# ─────────────────────────────────────────────────────────────────────────────

# Creamos un directorio temporal para practicar.
# mktemp -d crea una carpeta temporal única en el sistema.
PRACTICA_DIR=$(mktemp -d)
cd "$PRACTICA_DIR"
echo "📂 Directorio de práctica: $PRACTICA_DIR"

# Inicializamos un repositorio Git nuevo.
# git init crea la carpeta oculta .git con toda la estructura necesaria.
git init

# Configuramos nombre y email para este repositorio (solo de práctica).
git config user.name "Estudiante Git"
git config user.email "estudiante@ejemplo.com"

# ─────────────────────────────────────────────────────────────────────────────
# 2. Primer commit: crear la estructura del proyecto
# ─────────────────────────────────────────────────────────────────────────────

# Creamos los archivos iniciales del proyecto.
echo "# Mi Proyecto Web" > README.md
echo "node_modules/" > .gitignore
mkdir src
echo "console.log('Hola mundo');" > src/index.js

# Verificamos el estado: todos los archivos deberían estar en rojo (untracked).
echo ""
echo "=== Estado después de crear archivos ==="
git status

# Agregamos TODOS los archivos al staging area.
git add .

# Verificamos: ahora deberían estar en verde (staged).
echo ""
echo "=== Estado después de git add . ==="
git status

# Creamos nuestro primer commit.
git commit -m "feat: inicializa proyecto con estructura básica"

# Verificamos el historial.
echo ""
echo "=== Primer commit creado ==="
git log --oneline

# ─────────────────────────────────────────────────────────────────────────────
# 3. Segundo commit: agregar funcionalidad
# ─────────────────────────────────────────────────────────────────────────────

# Creamos un archivo nuevo con una función.
cat > src/saludar.js << 'EOF'
/**
 * Genera un saludo personalizado.
 * @param {string} nombre - Nombre de la persona.
 * @returns {string} Mensaje de saludo.
 */
function saludar(nombre) {
  return `¡Hola, ${nombre}! Bienvenido a nuestro proyecto.`;
}

module.exports = { saludar };
EOF

# Modificamos index.js para usar la nueva función.
cat > src/index.js << 'EOF'
const { saludar } = require('./saludar');

console.log(saludar('Mundo'));
console.log(saludar('Estudiante'));
EOF

# Verificamos qué cambió.
echo ""
echo "=== Estado: archivo nuevo + archivo modificado ==="
git status

# Revisamos las diferencias del archivo modificado.
echo ""
echo "=== Diff de index.js (modificado) ==="
git diff src/index.js

# Agregamos y hacemos commit.
git add .
git commit -m "feat: agrega función de saludo personalizado"

# ─────────────────────────────────────────────────────────────────────────────
# 4. Tercer commit: solo un archivo específico
# ─────────────────────────────────────────────────────────────────────────────

# Hacemos cambios en DOS archivos, pero solo haremos commit de UNO.
# Esto demuestra el poder del staging area.

# Actualizamos el README con más información.
cat >> README.md << 'EOF'

## Descripción
Un proyecto de ejemplo para aprender el flujo de trabajo de Git.

## Cómo ejecutar
```bash
node src/index.js
```
EOF

# También creamos un archivo de configuración.
echo '{ "version": "1.0.0", "name": "mi-proyecto" }' > package.json

# Verificamos: deberíamos ver 1 modificado (README) y 1 nuevo (package.json).
echo ""
echo "=== Dos cambios diferentes ==="
git status

# Solo agregamos el README (no el package.json).
git add README.md

# Verificamos: README en verde (staged), package.json en rojo (untracked).
echo ""
echo "=== Solo README está en staging ==="
git status

# Commit solo con el README.
git commit -m "docs: agrega descripción e instrucciones al README"

# Ahora package.json sigue sin rastrear. Lo agregamos en otro commit.
git add package.json
git commit -m "chore: agrega archivo package.json"

# ─────────────────────────────────────────────────────────────────────────────
# 5. Revisar todo el historial
# ─────────────────────────────────────────────────────────────────────────────

echo ""
echo "=== Historial completo del proyecto ==="
git log --oneline

echo ""
echo "=== Historial con estadísticas de archivos ==="
git log --stat --oneline

echo ""
echo "=== Diferencias entre el primer y último commit ==="
git diff HEAD~3 HEAD --stat

# ─────────────────────────────────────────────────────────────────────────────
# 6. Demostración de git diff --staged
# ─────────────────────────────────────────────────────────────────────────────

# Hagamos un cambio, agreguémoslo al staging, y veamos el diff staged.
echo "console.log('Versión 2.0');" >> src/index.js

echo ""
echo "=== Cambios en working directory (git diff) ==="
git diff

# Agregamos al staging.
git add src/index.js

echo ""
echo "=== Cambios en staging area (git diff --staged) ==="
git diff --staged

# Nota: git diff (sin --staged) ahora no muestra nada, porque el cambio
# ya fue movido al staging area. git diff --staged sí lo muestra.

# Hacemos el commit final.
git commit -m "feat: agrega mensaje de versión al inicio"

# ─────────────────────────────────────────────────────────────────────────────
# 7. Resultado final
# ─────────────────────────────────────────────────────────────────────────────

echo ""
echo "=========================================="
echo "  FLUJO COMPLETO TERMINADO"
echo "=========================================="
echo ""
echo "Historial final:"
git log --oneline --graph
echo ""
echo "Archivos en el proyecto:"
find . -not -path './.git/*' -not -path './.git' -type f | sort
echo ""
echo "Directorio de práctica: $PRACTICA_DIR"
echo "(Puedes eliminarlo cuando quieras con: rm -rf $PRACTICA_DIR)"

# =============================================================================
# LO QUE APRENDIMOS EN ESTE FLUJO:
# 1. git init         → Crear un repositorio nuevo
# 2. git status       → Verificar el estado constantemente
# 3. git add          → Preparar archivos selectivamente
# 4. git commit -m    → Guardar cambios con mensajes descriptivos
# 5. git diff         → Ver cambios antes de agregar
# 6. git diff --staged → Ver qué se va a incluir en el commit
# 7. git log          → Revisar el historial de commits
#
# El flujo se resume en: verificar → preparar → confirmar → verificar
# =============================================================================
