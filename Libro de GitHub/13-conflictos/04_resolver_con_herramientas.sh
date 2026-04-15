#!/bin/bash

# =============================================================================
#  CAPÍTULO 13 — CONFLICTOS EN GIT
#  Archivo: 04_resolver_con_herramientas.sh
#  Tema: Resolver conflictos con VS Code y otras herramientas gráficas
# =============================================================================
#
#  Editar marcadores de conflicto manualmente funciona, pero las herramientas
#  gráficas hacen el proceso mucho más rápido y visual. VS Code tiene un
#  excelente editor de merge integrado.
#
# =============================================================================

# =============================================================================
#  VS CODE: EDITOR DE MERGE INTEGRADO
# =============================================================================
#
#  Cuando abres un archivo con conflictos en VS Code, verás:
#
#  1. Las secciones en conflicto resaltadas con colores:
#     - VERDE: tu versión actual (HEAD / Current Change)
#     - AZUL: la versión entrante (Incoming Change)
#
#  2. Botones de acción sobre cada conflicto:
#     - "Accept Current Change"    → conserva tu versión
#     - "Accept Incoming Change"   → conserva la versión entrante
#     - "Accept Both Changes"      → pone ambas versiones una tras otra
#     - "Compare Changes"          → abre vista lado a lado
#
#  3. Editor de merge de 3 paneles (VS Code 1.69+):
#     - Panel izquierdo: tu versión (Current)
#     - Panel derecho: versión entrante (Incoming)
#     - Panel inferior: resultado final que puedes editar
#
# =============================================================================

# --- Abrir VS Code directamente en un archivo con conflictos ---
# Cuando haya un conflicto, simplemente abre el archivo:
code mensaje.txt

# --- Abrir el editor de merge de 3 paneles ---
# En VS Code, haz clic en "Resolve in Merge Editor" en la barra superior
# del archivo con conflictos. Esto abre la vista de 3 paneles.

# =============================================================================
#  GIT MERGETOOL: HERRAMIENTA DE MERGE CONFIGURABLE
# =============================================================================

# Git tiene un comando especial que abre una herramienta gráfica para
# resolver conflictos. Primero debes configurar cuál herramienta usar.

# --- Configurar VS Code como mergetool ---
git config --global merge.tool vscode
git config --global mergetool.vscode.cmd 'code --wait --merge $REMOTE $LOCAL $BASE $MERGED'

# --- Usar mergetool para resolver conflictos ---
# Después de un merge con conflictos, ejecuta:
git mergetool

# Esto abrirá cada archivo con conflictos en VS Code automáticamente.
# Resuelve cada uno, guarda y cierra. Git preguntará si fue resuelto.

# --- Limpiar archivos .orig que deja mergetool ---
# mergetool crea archivos de respaldo (.orig). Para eliminarlos:
git config --global mergetool.keepBackup false

# O elimínalos manualmente después de resolver:
find . -name "*.orig" -delete

# =============================================================================
#  OTRAS HERRAMIENTAS POPULARES
# =============================================================================
#
#  1. MELD (Linux/Mac/Windows)
#     - Herramienta gráfica de diff y merge muy intuitiva
#     - git config --global merge.tool meld
#
#  2. KDIFF3
#     - Vista de 3 paneles con resolución automática parcial
#     - git config --global merge.tool kdiff3
#
#  3. BEYOND COMPARE (de pago)
#     - Muy potente para comparar archivos y directorios
#     - git config --global merge.tool bc
#
#  4. INTELLIJ / WEBSTORM
#     - Editor de merge integrado excelente
#     - Se activa automáticamente al detectar conflictos en el IDE
#
# =============================================================================

# =============================================================================
#  GITHUB: RESOLVER CONFLICTOS DESDE LA WEB
# =============================================================================
#
#  GitHub permite resolver conflictos simples directamente desde la interfaz
#  web cuando un Pull Request tiene conflictos:
#
#  1. Ve al Pull Request con conflictos
#  2. Haz clic en "Resolve conflicts"
#  3. Edita los archivos directamente en el editor web
#  4. Elimina los marcadores de conflicto
#  5. Haz clic en "Mark as resolved"
#  6. Haz clic en "Commit merge"
#
#  LIMITACIÓN: Solo funciona para conflictos simples. Si son complicados,
#  GitHub te pedirá que los resuelvas localmente.
#
# =============================================================================

# =============================================================================
#  VER MERGETOOL CONFIGURADO ACTUALMENTE
# =============================================================================

# Ver qué herramienta está configurada
git config --global merge.tool

# Ver el comando asociado
git config --global mergetool.vscode.cmd

echo ""
echo "=== Fin de 04_resolver_con_herramientas.sh ==="
echo "Ahora conoces herramientas gráficas. Siguiente: cómo prevenir conflictos."
