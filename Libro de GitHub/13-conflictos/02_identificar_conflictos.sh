#!/bin/bash

# =============================================================================
#  CAPÍTULO 13 — CONFLICTOS EN GIT
#  Archivo: 02_identificar_conflictos.sh
#  Tema: Leer y entender los marcadores de conflicto
# =============================================================================
#
#  Cuando Git encuentra un conflicto, inserta marcadores especiales dentro del
#  archivo afectado. Aprender a leer estos marcadores es fundamental para
#  resolver conflictos correctamente.
#
# =============================================================================

# =============================================================================
#  ANATOMÍA DE UN MARCADOR DE CONFLICTO
# =============================================================================
#
#  Cuando abres un archivo con conflicto, verás algo así:
#
#  <<<<<<< HEAD
#  Tu versión actual (la rama donde estás parado)
#  =======
#  La versión entrante (la rama que intentas fusionar)
#  >>>>>>> feature
#
#  DESGLOSE:
#
#  <<<<<<< HEAD
#  ─────────────────────────────────
#  Marca el INICIO del conflicto.
#  "HEAD" se refiere a la rama actual donde estás (generalmente main).
#  Todo lo que está entre <<<<<<< y ======= es TU código.
#
#  =======
#  ─────────────────────────────────
#  Separador entre las dos versiones en conflicto.
#  Arriba está tu versión, abajo está la versión entrante.
#
#  >>>>>>> feature
#  ─────────────────────────────────
#  Marca el FIN del conflicto.
#  "feature" es el nombre de la rama que intentaste fusionar.
#  Todo lo que está entre ======= y >>>>>>> es el código ENTRANTE.
#
# =============================================================================

# =============================================================================
#  EJEMPLO REAL DE CONFLICTO
# =============================================================================

# Supongamos que después de un merge fallido, mensaje.txt contiene:
cat << 'EJEMPLO'
Línea 1: Bienvenido al proyecto
Línea 2: Este archivo será editado en dos ramas
<<<<<<< HEAD
Cambio hecho desde la rama MAIN
=======
Cambio hecho desde la rama FEATURE
>>>>>>> feature
Línea 4: Esta línea no será tocada
Línea 5: Final del archivo
EJEMPLO

# =============================================================================
#  COMANDOS PARA IDENTIFICAR CONFLICTOS
# =============================================================================

# --- Ver qué archivos tienen conflictos ---
# git status te muestra los archivos con conflictos bajo "Unmerged paths"
git status

# --- Buscar marcadores de conflicto en archivos ---
# Puedes buscar los marcadores directamente con grep
grep -rn "<<<<<<< " .
grep -rn "=======" .
grep -rn ">>>>>>> " .

# --- Ver una lista limpia solo de archivos con conflictos ---
git diff --name-only --diff-filter=U

# --- Ver el conflicto con más contexto ---
# Muestra las diferencias incluyendo los marcadores de conflicto
git diff

# =============================================================================
#  CONFLICTO CON TRES SECCIONES (merge con diff3)
# =============================================================================
#
#  Por defecto Git muestra 2 secciones (la tuya y la entrante). Pero puedes
#  activar el estilo "diff3" que agrega una tercera sección: el ancestro común.
#  Esto es MUY útil porque te muestra cómo era el código ANTES de ambos cambios.
#
#  Para activarlo:
#    git config --global merge.conflictstyle diff3
#
#  El resultado se ve así:
#
#  <<<<<<< HEAD
#  Cambio hecho desde la rama MAIN
#  ||||||| ancestro-comun
#  La línea original antes de cualquier cambio
#  =======
#  Cambio hecho desde la rama FEATURE
#  >>>>>>> feature
#
#  Ahora puedes ver:
#  1. Qué tenías tú (HEAD)
#  2. Cómo era originalmente (ancestro común)
#  3. Qué tiene la otra rama (feature)
#
# =============================================================================

# Activar diff3 (recomendado, hazlo una vez y olvídalo)
git config --global merge.conflictstyle diff3

# =============================================================================
#  CONFLICTOS MÚLTIPLES EN UN MISMO ARCHIVO
# =============================================================================
#
#  Un archivo puede tener VARIOS bloques de conflicto. Cada bloque tiene
#  sus propios marcadores <<<<<<< ======= >>>>>>>. Debes resolver TODOS
#  los bloques antes de marcar el archivo como resuelto.
#
#  Ejemplo con dos conflictos:
#
#  <<<<<<< HEAD
#  const color = "azul";
#  =======
#  const color = "rojo";
#  >>>>>>> feature
#
#  // ... más código ...
#
#  <<<<<<< HEAD
#  const tamaño = "grande";
#  =======
#  const tamaño = "pequeño";
#  >>>>>>> feature
#
# =============================================================================

# =============================================================================
#  VERIFICAR QUE NO QUEDAN MARCADORES
# =============================================================================

# Después de resolver, SIEMPRE verifica que no dejaste marcadores por accidente
# Si este comando no devuelve resultados, todo está limpio
grep -rn "<<<<<<< \|=======$\|>>>>>>> " .

echo ""
echo "=== Fin de 02_identificar_conflictos.sh ==="
echo "Ya sabes leer los marcadores. Siguiente: cómo resolver conflictos."
