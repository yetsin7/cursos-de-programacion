# =============================================================================
# ARCHIVO: 05_ejercicios.sh
# TEMA: Ejercicios prácticos — Repositorios básicos
# =============================================================================
#
# Estos ejercicios te ayudarán a practicar todo lo que aprendiste en este
# capítulo. Intenta resolverlos TÚ MISMO antes de ver las soluciones.
#
# Cada ejercicio tiene:
#   - Descripción del reto
#   - Pistas si te atascas
#   - Solución (más abajo, intenta no verla antes)
# =============================================================================


# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 1: Crear tu primer repositorio desde cero
# ─────────────────────────────────────────────────────────────────────────────
# Objetivo:
#   1. Crea una carpeta llamada "ejercicio-01"
#   2. Inicializa Git dentro de ella
#   3. Crea un archivo llamado "hola.txt" con el texto "Hola Git!"
#   4. Agrega el archivo al staging area
#   5. Haz un commit con el mensaje "Mi primer commit"
#   6. Verifica el historial con git log
#
# Pistas:
#   - mkdir, cd, git init, echo, git add, git commit, git log


# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 2: Repositorio con múltiples archivos y commits
# ─────────────────────────────────────────────────────────────────────────────
# Objetivo:
#   1. Crea una carpeta llamada "ejercicio-02"
#   2. Inicializa Git
#   3. Crea un archivo "index.html" y haz commit: "Agregar index.html"
#   4. Crea un archivo "styles.css" y haz commit: "Agregar styles.css"
#   5. Crea un archivo "app.js" y haz commit: "Agregar app.js"
#   6. Ve el historial — deberías ver 3 commits en orden
#
# Pistas:
#   - Haz git add y git commit POR SEPARADO para cada archivo
#   - Usa "git log --oneline" para ver el historial compacto


# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 3: Clonar un repositorio real de GitHub
# ─────────────────────────────────────────────────────────────────────────────
# Objetivo:
#   1. Clona este repositorio público: https://github.com/octocat/Spoon-Knife.git
#   2. Entra a la carpeta clonada
#   3. Ve el historial de commits
#   4. Ve qué remotos tiene configurados
#   5. Ve en qué rama estás
#
# Pistas:
#   - git clone, cd, git log --oneline, git remote -v, git branch


# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 4: Explorar la carpeta .git
# ─────────────────────────────────────────────────────────────────────────────
# Objetivo:
#   1. Crea un repositorio nuevo llamado "ejercicio-04"
#   2. Haz un commit con cualquier archivo
#   3. Muestra el contenido de .git/HEAD
#   4. Muestra el contenido de .git/config
#   5. Lista los archivos en .git/refs/heads/
#   6. Muestra a qué commit apunta tu rama main
#
# Pistas:
#   - cat .git/HEAD, cat .git/config, ls .git/refs/heads/


# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 5: Staging selectivo
# ─────────────────────────────────────────────────────────────────────────────
# Objetivo:
#   1. Crea un repositorio nuevo llamado "ejercicio-05"
#   2. Crea 3 archivos: "a.txt", "b.txt", "c.txt"
#   3. Agrega SOLO "a.txt" y "b.txt" al staging area
#   4. Haz commit: "Agregar archivos a y b"
#   5. Verifica con git status que "c.txt" sigue sin rastrear
#   6. Ahora agrega "c.txt" y haz un segundo commit
#
# Pistas:
#   - git add a.txt b.txt (puedes agregar varios archivos a la vez)
#   - git status te muestra qué está staged y qué no


# =============================================================================
# SOLUCIONES (intenta resolver los ejercicios antes de ver esto)
# =============================================================================


# --- SOLUCIÓN EJERCICIO 1 ---
mkdir ejercicio-01
cd ejercicio-01
git init
echo "Hola Git!" > hola.txt
git add hola.txt
git commit -m "Mi primer commit"
git log
cd ..
rm -rf ejercicio-01


# --- SOLUCIÓN EJERCICIO 2 ---
mkdir ejercicio-02
cd ejercicio-02
git init
echo "<html></html>" > index.html
git add index.html
git commit -m "Agregar index.html"
echo "body {}" > styles.css
git add styles.css
git commit -m "Agregar styles.css"
echo "console.log('hola');" > app.js
git add app.js
git commit -m "Agregar app.js"
git log --oneline
cd ..
rm -rf ejercicio-02


# --- SOLUCIÓN EJERCICIO 3 ---
git clone https://github.com/octocat/Spoon-Knife.git
cd Spoon-Knife
git log --oneline
git remote -v
git branch
cd ..
rm -rf Spoon-Knife


# --- SOLUCIÓN EJERCICIO 4 ---
mkdir ejercicio-04
cd ejercicio-04
git init
echo "prueba" > test.txt
git add test.txt
git commit -m "Commit de prueba"
cat .git/HEAD
cat .git/config
ls .git/refs/heads/
cat .git/refs/heads/main
cd ..
rm -rf ejercicio-04


# --- SOLUCIÓN EJERCICIO 5 ---
mkdir ejercicio-05
cd ejercicio-05
git init
echo "archivo a" > a.txt
echo "archivo b" > b.txt
echo "archivo c" > c.txt
git add a.txt b.txt
git commit -m "Agregar archivos a y b"
git status
git add c.txt
git commit -m "Agregar archivo c"
git log --oneline
cd ..
rm -rf ejercicio-05


# =============================================================================
# ¡FELICIDADES!
# Si completaste todos los ejercicios, ya dominas los conceptos básicos
# de repositorios. Sabes:
#   ✅ Crear repositorios locales con git init
#   ✅ Clonar repositorios remotos con git clone
#   ✅ Usar el flujo: git add → git commit
#   ✅ Ver el historial con git log
#   ✅ Entender la estructura de .git
#   ✅ Hacer staging selectivo de archivos
#
# Siguiente capítulo: 05-flujo-basico-git/
# =============================================================================
