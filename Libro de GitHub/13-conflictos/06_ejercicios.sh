#!/bin/bash

# =============================================================================
#  CAPÍTULO 13 — CONFLICTOS EN GIT
#  Archivo: 06_ejercicios.sh
#  Tema: Escenarios de práctica para resolver conflictos
# =============================================================================
#
#  Estos ejercicios crean situaciones reales de conflicto para que practiques.
#  Cada ejercicio incluye la preparación automática y las instrucciones de
#  lo que debes resolver.
#
# =============================================================================

# =============================================================================
#  EJERCICIO 1: CONFLICTO BÁSICO DE UNA LÍNEA
# =============================================================================
#  Objetivo: Resolver un conflicto simple donde una línea fue editada
#  en dos ramas diferentes.
# =============================================================================

echo "=== EJERCICIO 1: Conflicto básico ==="

# Preparación automática
mkdir -p /tmp/ejercicio-conflicto-1
cd /tmp/ejercicio-conflicto-1
git init

echo "nombre=Juan" > config.txt
git add config.txt && git commit -m "Commit inicial"

git checkout -b rama-a
sed -i 's/nombre=Juan/nombre=Carlos/' config.txt
git add config.txt && git commit -m "rama-a: cambia nombre a Carlos"

git checkout main
sed -i 's/nombre=Juan/nombre=María/' config.txt
git add config.txt && git commit -m "main: cambia nombre a María"

git merge rama-a

echo ""
echo "INSTRUCCIONES:"
echo "1. Abre config.txt y observa los marcadores de conflicto"
echo "2. Decide qué nombre conservar (o escribe uno nuevo)"
echo "3. Elimina los marcadores de conflicto"
echo "4. Haz: git add config.txt && git commit"
echo ""

# =============================================================================
#  EJERCICIO 2: CONFLICTOS MÚLTIPLES EN UN ARCHIVO
# =============================================================================
#  Objetivo: Resolver varios conflictos dentro del mismo archivo.
# =============================================================================

echo "=== EJERCICIO 2: Conflictos múltiples ==="

mkdir -p /tmp/ejercicio-conflicto-2
cd /tmp/ejercicio-conflicto-2
git init

cat > estilos.css << 'EOF'
body { color: black; }
h1 { font-size: 24px; }
p { margin: 10px; }
a { color: blue; }
EOF
git add estilos.css && git commit -m "Commit inicial"

git checkout -b tema-oscuro
cat > estilos.css << 'EOF'
body { color: white; background: #333; }
h1 { font-size: 24px; }
p { margin: 10px; }
a { color: cyan; }
EOF
git add estilos.css && git commit -m "tema-oscuro: colores oscuros"

git checkout main
cat > estilos.css << 'EOF'
body { color: darkgray; }
h1 { font-size: 24px; }
p { margin: 10px; }
a { color: green; }
EOF
git add estilos.css && git commit -m "main: nuevos colores"

git merge tema-oscuro

echo ""
echo "INSTRUCCIONES:"
echo "1. Abre estilos.css — verás DOS bloques de conflicto"
echo "2. Resuelve ambos conflictos (puedes combinar estilos)"
echo "3. Elimina TODOS los marcadores"
echo "4. Haz: git add estilos.css && git commit"
echo ""

# =============================================================================
#  EJERCICIO 3: CONFLICTO DE ELIMINAR vs MODIFICAR
# =============================================================================
#  Objetivo: Decidir si conservar o eliminar un archivo cuando hay conflicto
#  entre eliminación y modificación.
# =============================================================================

echo "=== EJERCICIO 3: Eliminar vs modificar ==="

mkdir -p /tmp/ejercicio-conflicto-3
cd /tmp/ejercicio-conflicto-3
git init

echo "Archivo temporal de prueba" > temporal.txt
git add temporal.txt && git commit -m "Agrega temporal.txt"

git checkout -b limpieza
git rm temporal.txt
git commit -m "limpieza: elimina archivo temporal"

git checkout main
echo "Archivo temporal IMPORTANTE actualizado" > temporal.txt
git add temporal.txt && git commit -m "main: actualiza temporal.txt"

git merge limpieza

echo ""
echo "INSTRUCCIONES:"
echo "1. Ejecuta 'git status' y observa el conflicto"
echo "2. Decide: ¿conservar el archivo o eliminarlo?"
echo "3. Para conservar: git add temporal.txt && git commit"
echo "4. Para eliminar: git rm temporal.txt && git commit"
echo ""

# =============================================================================
#  EJERCICIO 4: RESOLVER CON --ours Y --theirs
# =============================================================================
#  Objetivo: Practicar la resolución rápida usando --ours y --theirs.
# =============================================================================

echo "=== EJERCICIO 4: Usar --ours y --theirs ==="

mkdir -p /tmp/ejercicio-conflicto-4
cd /tmp/ejercicio-conflicto-4
git init

echo "versión 1.0" > version.txt
git add version.txt && git commit -m "v1.0"

git checkout -b release
echo "versión 2.0-release" > version.txt
git add version.txt && git commit -m "release: v2.0"

git checkout main
echo "versión 2.0-main" > version.txt
git add version.txt && git commit -m "main: v2.0"

git merge release

echo ""
echo "INSTRUCCIONES:"
echo "1. Resuelve usando --ours: git checkout --ours version.txt"
echo "2. O resuelve usando --theirs: git checkout --theirs version.txt"
echo "3. Después: git add version.txt && git commit"
echo "4. Verifica el contenido: cat version.txt"
echo ""

# =============================================================================
#  EJERCICIO 5: ABORTAR UN MERGE
# =============================================================================
#  Objetivo: Practicar cancelar un merge con conflictos.
# =============================================================================

echo "=== EJERCICIO 5: Abortar un merge ==="
echo ""
echo "Usando cualquier ejercicio anterior con conflictos activos:"
echo "1. No resuelvas los conflictos"
echo "2. Ejecuta: git merge --abort"
echo "3. Verifica con 'git status' que todo volvió a la normalidad"
echo "4. Verifica con 'git log --oneline' que no hay merge commit"
echo ""

echo "=== Fin de 06_ejercicios.sh ==="
echo "¡Practica cada ejercicio hasta sentirte cómodo resolviendo conflictos!"
