#!/bin/bash
# =============================================================================
# ARCHIVO: 07_ejercicios.sh
# TEMA: Ejercicios de práctica — Ramas en Git
# =============================================================================
#
# Practica la creación, navegación, fusión y eliminación de ramas.
# Cada ejercicio construye sobre los anteriores.
#
# PREPARACIÓN:
#   mkdir /tmp/practica-ramas && cd /tmp/practica-ramas && git init
#   git config user.name "Estudiante" && git config user.email "est@test.com"
#   echo "# Proyecto" > README.md && git add . && git commit -m "commit inicial"
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 1: Crear y cambiar de rama
# ─────────────────────────────────────────────────────────────────────────────
# Instrucciones:
# 1. Crea una rama llamada "feature/saludo" y cámbiate a ella
# 2. Verifica que estás en la nueva rama
# 3. Crea un archivo "saludo.txt" con "Hola mundo"
# 4. Haz commit: "feat: agrega archivo de saludo"
# 5. Vuelve a main y verifica que saludo.txt NO existe

# SOLUCIÓN:
# git switch -c feature/saludo
# git branch --show-current          # feature/saludo
# echo "Hola mundo" > saludo.txt
# git add saludo.txt
# git commit -m "feat: agrega archivo de saludo"
# git switch main
# ls saludo.txt                      # No existe en main

# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 2: Fast-forward merge
# ─────────────────────────────────────────────────────────────────────────────
# Instrucciones:
# 1. Estando en main, fusiona feature/saludo
# 2. Observa que dice "Fast-forward" en la salida
# 3. Verifica que saludo.txt ahora SÍ existe en main
# 4. Revisa el historial con git log --oneline

# SOLUCIÓN:
# git merge feature/saludo
# ls saludo.txt                      # Ahora sí existe
# git log --oneline

# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 3: Three-way merge
# ─────────────────────────────────────────────────────────────────────────────
# Instrucciones:
# 1. Crea una rama "feature/despedida" y cámbiate a ella
# 2. Crea "despedida.txt" con "Adiós mundo" y haz commit
# 3. Vuelve a main
# 4. Modifica README.md (agrega "## Descripción") y haz commit en main
# 5. Ahora fusiona feature/despedida (será un 3-way merge)
# 6. Revisa el historial con git log --graph --oneline

# SOLUCIÓN:
# git switch -c feature/despedida
# echo "Adiós mundo" > despedida.txt
# git add despedida.txt
# git commit -m "feat: agrega archivo de despedida"
# git switch main
# echo "## Descripción" >> README.md
# git add README.md
# git commit -m "docs: agrega sección de descripción"
# git merge feature/despedida --no-edit
# git log --graph --oneline

# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 4: Eliminar ramas fusionadas
# ─────────────────────────────────────────────────────────────────────────────
# Instrucciones:
# 1. Lista las ramas fusionadas en main
# 2. Elimina feature/saludo y feature/despedida
# 3. Verifica que solo queda main

# SOLUCIÓN:
# git branch --merged
# git branch -d feature/saludo feature/despedida
# git branch                         # Solo main

# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 5: Trabajar en dos ramas simultáneamente
# ─────────────────────────────────────────────────────────────────────────────
# Instrucciones:
# 1. Crea rama "feature/login" → agrega login.js → commit
# 2. Vuelve a main
# 3. Crea rama "feature/registro" → agrega registro.js → commit
# 4. Vuelve a main
# 5. Fusiona primero feature/login, luego feature/registro
# 6. Verifica que main tiene AMBOS archivos
# 7. Revisa el historial con git log --graph --oneline --all

# SOLUCIÓN:
# git switch -c feature/login
# echo "// Login" > login.js
# git add login.js
# git commit -m "feat: agrega módulo de login"
# git switch main
# git switch -c feature/registro
# echo "// Registro" > registro.js
# git add registro.js
# git commit -m "feat: agrega módulo de registro"
# git switch main
# git merge feature/login --no-edit
# git merge feature/registro --no-edit
# ls *.js                            # login.js y registro.js
# git log --graph --oneline --all

# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 6: Explorar y filtrar ramas
# ─────────────────────────────────────────────────────────────────────────────
# Instrucciones:
# 1. Crea 4 ramas: feature/a, feature/b, fix/c, fix/d (sin cambiar a ellas)
# 2. Lista todas las ramas
# 3. Lista solo las que empiezan con "feature/"
# 4. Lista solo las que empiezan con "fix/"
# 5. Muestra la información verbose (-v) de todas
# 6. Elimina las 4 ramas

# SOLUCIÓN:
# git branch feature/a
# git branch feature/b
# git branch fix/c
# git branch fix/d
# git branch
# git branch --list "feature/*"
# git branch --list "fix/*"
# git branch -v
# git branch -d feature/a feature/b fix/c fix/d

# ─────────────────────────────────────────────────────────────────────────────
# EJERCICIO 7: Merge con --no-ff
# ─────────────────────────────────────────────────────────────────────────────
# Instrucciones:
# 1. Crea rama "feature/perfil" → agrega perfil.js → commit
# 2. Vuelve a main
# 3. Fusiona con --no-ff (forzar merge commit)
# 4. Observa que se crea un commit de merge en el historial
# 5. Compara el graph con y sin --no-ff (nota la "burbuja")

# SOLUCIÓN:
# git switch -c feature/perfil
# echo "// Perfil" > perfil.js
# git add perfil.js
# git commit -m "feat: agrega módulo de perfil"
# git switch main
# git merge --no-ff feature/perfil -m "merge: integra módulo de perfil"
# git log --graph --oneline -5

# =============================================================================
# CONSEJOS FINALES:
# - Crea ramas para TODO: funcionalidades, correcciones, experimentos
# - Fusiona frecuentemente para evitar conflictos grandes
# - Elimina ramas fusionadas para mantener el repositorio limpio
# - Usa git log --graph para visualizar la estructura de ramas
# - Nombra tus ramas de forma descriptiva con prefijos (feature/, fix/, etc.)
# =============================================================================
