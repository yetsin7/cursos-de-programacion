#!/bin/bash
# =============================================================================
# ARCHIVO: 07_ejercicios.sh
# TEMA: Ejercicios de práctica — Flujo básico de Git
# =============================================================================
#
# Estos ejercicios están diseñados para que practiques el ciclo fundamental
# de Git: modificar, preparar, confirmar. Intenta resolverlos por tu cuenta
# antes de ver las soluciones.
#
# PREPARACIÓN: Crea un directorio temporal para practicar:
#   mkdir /tmp/practica-git && cd /tmp/practica-git && git init
#   git config user.name "Estudiante" && git config user.email "est@test.com"
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 1: Tu primer commit
# ─────────────────────────────────────────────────────────────────────────────
# Instrucciones:
# 1. Crea un archivo llamado "hola.txt" con el contenido "Hola Git"
# 2. Verifica el estado del repositorio
# 3. Agrega el archivo al staging area
# 4. Verifica que está en staging (debe verse en verde)
# 5. Crea un commit con el mensaje "feat: agrega archivo de bienvenida"
# 6. Verifica el historial con git log --oneline

# SOLUCIÓN:
# echo "Hola Git" > hola.txt
# git status
# git add hola.txt
# git status
# git commit -m "feat: agrega archivo de bienvenida"
# git log --oneline

# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 2: Staging selectivo
# ─────────────────────────────────────────────────────────────────────────────
# Instrucciones:
# 1. Crea tres archivos: app.js, styles.css, notas.txt
# 2. Verifica el estado (deberías ver 3 archivos sin rastrear)
# 3. Agrega SOLO app.js y styles.css al staging (NO notas.txt)
# 4. Verifica que solo 2 archivos están en staging
# 5. Haz commit con mensaje "feat: agrega aplicación y estilos"
# 6. Verifica que notas.txt sigue sin rastrear

# SOLUCIÓN:
# echo "console.log('app');" > app.js
# echo "body { margin: 0; }" > styles.css
# echo "Mis notas personales" > notas.txt
# git status
# git add app.js styles.css
# git status
# git commit -m "feat: agrega aplicación y estilos"
# git status    # notas.txt sigue en rojo

# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 3: Unstaging (quitar del staging)
# ─────────────────────────────────────────────────────────────────────────────
# Instrucciones:
# 1. Crea dos archivos: publico.txt y secreto.txt
# 2. Agrega ambos al staging con git add .
# 3. ¡Ups! No querías agregar secreto.txt. Quítalo del staging.
# 4. Verifica que solo publico.txt está en staging
# 5. Haz commit solo con publico.txt

# SOLUCIÓN:
# echo "Información pública" > publico.txt
# echo "Mi contraseña: 12345" > secreto.txt
# git add .
# git status                           # Ambos en verde
# git restore --staged secreto.txt     # Quitar del staging
# git status                           # Solo publico.txt en verde
# git commit -m "docs: agrega archivo público"

# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 4: Usar git diff
# ─────────────────────────────────────────────────────────────────────────────
# Instrucciones:
# 1. Modifica el archivo hola.txt (del ejercicio 1): agrega "¡Bienvenido!"
# 2. Usa git diff para ver exactamente qué cambió
# 3. Agrega al staging
# 4. Usa git diff --staged para verificar lo que se va a incluir en el commit
# 5. Haz commit

# SOLUCIÓN:
# echo "¡Bienvenido!" >> hola.txt
# git diff                    # Ves la línea agregada en verde
# git add hola.txt
# git diff                    # Ya no muestra nada (el cambio está en staging)
# git diff --staged           # Ahora sí ves el cambio aquí
# git commit -m "feat: agrega mensaje de bienvenida a hola.txt"

# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 5: Explorar el historial
# ─────────────────────────────────────────────────────────────────────────────
# Instrucciones (después de completar los ejercicios anteriores):
# 1. Muestra todos los commits en formato de una línea
# 2. Muestra los commits con los archivos que cambiaron
# 3. Muestra solo los últimos 2 commits
# 4. Busca commits que contengan "bienvenida" en el mensaje
# 5. Muestra los detalles completos del primer commit

# SOLUCIÓN:
# git log --oneline
# git log --stat --oneline
# git log -2 --oneline
# git log --grep="bienvenida" --oneline
# git show HEAD~3    # Ajusta el número según cuántos commits tengas

# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 6: Commit con amend
# ─────────────────────────────────────────────────────────────────────────────
# Instrucciones:
# 1. Crea un archivo config.json y haz commit con mensaje "agrega config"
# 2. ¡Ups! Olvidaste crear .gitignore. Créalo.
# 3. Agrega .gitignore al último commit SIN crear un commit nuevo
# 4. Cambia el mensaje a "chore: agrega configuración y gitignore"
# 5. Verifica con git log que solo hay UN commit (no dos)

# SOLUCIÓN:
# echo '{"debug": false}' > config.json
# git add config.json
# git commit -m "agrega config"
# echo "node_modules/" > .gitignore
# git add .gitignore
# git commit --amend -m "chore: agrega configuración y gitignore"
# git log --oneline -3    # Solo un commit con el mensaje corregido

# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 7: Flujo completo simulando trabajo real
# ─────────────────────────────────────────────────────────────────────────────
# Instrucciones:
# 1. Crea la estructura de un mini proyecto:
#    - README.md con título y descripción
#    - src/main.js con un console.log
#    - src/utils.js con una función helper
# 2. Haz commit inicial: "feat: inicializa proyecto"
# 3. Modifica main.js para importar utils.js
# 4. Revisa los cambios con git diff
# 5. Haz commit: "feat: conecta main con utilidades"
# 6. Agrega un archivo tests/test.js
# 7. Haz commit: "test: agrega archivo de pruebas"
# 8. Revisa el historial completo con --graph --oneline

# SOLUCIÓN:
# echo "# Mini Proyecto" > README.md
# mkdir src tests
# echo "console.log('main');" > src/main.js
# echo "module.exports = { sum: (a,b) => a+b };" > src/utils.js
# git add .
# git commit -m "feat: inicializa proyecto"
#
# echo "const utils = require('./utils'); console.log(utils.sum(2,3));" > src/main.js
# git diff
# git add src/main.js
# git commit -m "feat: conecta main con utilidades"
#
# echo "const { sum } = require('../src/utils'); console.assert(sum(2,3)===5);" > tests/test.js
# git add tests/test.js
# git commit -m "test: agrega archivo de pruebas"
#
# git log --graph --oneline

# =============================================================================
# CONSEJOS FINALES:
# - Ejecuta git status después de CADA operación hasta que sea automático
# - Siempre revisa git diff --staged antes de hacer commit
# - Escribe mensajes de commit descriptivos desde el principio
# - Haz commits pequeños y frecuentes (un cambio lógico = un commit)
# - Si algo sale mal, respira: Git casi nunca pierde datos
# =============================================================================
