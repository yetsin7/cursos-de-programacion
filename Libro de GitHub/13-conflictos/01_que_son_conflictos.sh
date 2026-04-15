#!/bin/bash

# =============================================================================
#  CAPÍTULO 13 — CONFLICTOS EN GIT
#  Archivo: 01_que_son_conflictos.sh
#  Tema: Qué causa los conflictos de merge
# =============================================================================
#
#  Un conflicto ocurre cuando Git no puede fusionar automáticamente los cambios
#  de dos ramas porque ambas modificaron las mismas líneas del mismo archivo.
#  Git se detiene y te pide que decidas manualmente qué versión conservar.
#
# =============================================================================

# =============================================================================
#  ¿CUÁNDO OCURRE UN CONFLICTO?
# =============================================================================
#
#  Escenario típico:
#
#  1. Estás en la rama "main" y creas una rama "feature"
#  2. En "main", alguien modifica la línea 10 del archivo index.html
#  3. En "feature", tú también modificas la línea 10 del mismo archivo
#  4. Cuando intentas fusionar "feature" en "main" → ¡CONFLICTO!
#
#  Git no sabe cuál de las dos versiones de la línea 10 es la correcta,
#  así que te pide que lo resuelvas tú.
# =============================================================================

# =============================================================================
#  DEMOSTRACIÓN: CREAR UN CONFLICTO INTENCIONALMENTE
# =============================================================================
#  Vamos a crear un repositorio de prueba y provocar un conflicto paso a paso
#  para entender exactamente cómo y por qué ocurren.
# =============================================================================

# --- Paso 1: Crear un repositorio de prueba ---
# Creamos un directorio temporal para experimentar de forma segura
mkdir -p /tmp/practica-conflictos
cd /tmp/practica-conflictos
git init

# --- Paso 2: Crear un archivo base con contenido inicial ---
# Este será el archivo que ambas ramas van a modificar
cat > mensaje.txt << 'EOF'
Línea 1: Bienvenido al proyecto
Línea 2: Este archivo será editado en dos ramas
Línea 3: La línea que causará el conflicto
Línea 4: Esta línea no será tocada
Línea 5: Final del archivo
EOF

git add mensaje.txt
git commit -m "Commit inicial: agrega mensaje.txt"

# --- Paso 3: Crear una rama y hacer un cambio en la línea 3 ---
# En la rama "feature" cambiamos la línea 3
git checkout -b feature
sed -i 's/La línea que causará el conflicto/Cambio hecho desde la rama FEATURE/' mensaje.txt
git add mensaje.txt
git commit -m "feature: modifica línea 3"

# --- Paso 4: Volver a main y hacer un cambio DIFERENTE en la misma línea ---
# En "main" también cambiamos la línea 3 pero con texto diferente
git checkout main
sed -i 's/La línea que causará el conflicto/Cambio hecho desde la rama MAIN/' mensaje.txt
git add mensaje.txt
git commit -m "main: modifica línea 3"

# --- Paso 5: Intentar fusionar → ¡CONFLICTO! ---
# Ahora Git no puede decidir cuál versión de la línea 3 conservar
git merge feature
# Salida esperada:
#   Auto-merging mensaje.txt
#   CONFLICT (content): Merge conflict in mensaje.txt
#   Automatic merge failed; fix conflicts and then commit the result.

# =============================================================================
#  TIPOS DE CONFLICTOS
# =============================================================================
#
#  1. CONFLICTO DE CONTENIDO (el más común)
#     - Dos ramas editan las mismas líneas
#     - Git muestra marcadores <<<<<<< ======= >>>>>>>
#
#  2. CONFLICTO DE MODIFICAR vs ELIMINAR
#     - Una rama edita un archivo, la otra lo elimina
#     - Git pregunta: ¿conservar el archivo o eliminarlo?
#
#  3. CONFLICTO DE RENOMBRAR
#     - Ambas ramas renombran el mismo archivo con nombres diferentes
#     - Git no sabe qué nombre usar
#
#  4. CONFLICTO DE ÁRBOL (tree conflict)
#     - Una rama modifica un archivo dentro de un directorio
#     - La otra rama elimina ese directorio completo
# =============================================================================

# =============================================================================
#  VERIFICAR SI HAY CONFLICTOS PENDIENTES
# =============================================================================

# Ver el estado actual cuando hay un conflicto sin resolver
git status
# Salida esperada:
#   On branch main
#   You have unmerged paths.
#     (fix conflicts and run "git commit")
#
#   Unmerged paths:
#     (use "git add <file>..." to mark resolution)
#       both modified:   mensaje.txt

# =============================================================================
#  ¿QUÉ NO CAUSA CONFLICTOS?
# =============================================================================
#
#  - Dos ramas modifican LÍNEAS DIFERENTES del mismo archivo → merge automático
#  - Dos ramas modifican ARCHIVOS DIFERENTES → merge automático
#  - Una rama agrega líneas nuevas que no existían en la otra → merge automático
#
#  Los conflictos SOLO ocurren cuando Git no puede decidir automáticamente.
# =============================================================================

# --- Limpiar el repositorio de prueba ---
# cd /tmp && rm -rf practica-conflictos

echo ""
echo "=== Fin de 01_que_son_conflictos.sh ==="
echo "Ahora sabes qué causa los conflictos. Siguiente: cómo identificarlos."
