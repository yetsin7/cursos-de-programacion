#!/bin/bash

# =============================================================================
#  CAPÍTULO 13 — CONFLICTOS EN GIT
#  Archivo: 05_prevenir_conflictos.sh
#  Tema: Buenas prácticas para minimizar conflictos
# =============================================================================
#
#  Los conflictos son normales en trabajo en equipo, pero muchos se pueden
#  evitar con buenas prácticas. Aquí verás las estrategias más efectivas
#  para reducir la cantidad y complejidad de los conflictos.
#
# =============================================================================

# =============================================================================
#  PRÁCTICA 1: MANTENER TU RAMA ACTUALIZADA
# =============================================================================
#
#  La causa principal de conflictos grandes es trabajar mucho tiempo sin
#  sincronizar con la rama principal. Mientras más tiempo pasa, más divergen
#  las ramas y más conflictos habrá.
# =============================================================================

# --- Actualizar tu rama feature con los últimos cambios de main ---

# Opción A: merge (más simple, crea un commit de merge)
git checkout feature
git merge main

# Opción B: rebase (historial más limpio, pero requiere más cuidado)
git checkout feature
git rebase main

# Hazlo al menos una vez al día si trabajas en equipo.

# =============================================================================
#  PRÁCTICA 2: RAMAS CORTAS Y ENFOCADAS
# =============================================================================
#
#  Regla de oro: una rama debe vivir máximo 1-3 días.
#
#  ❌ Malo:  rama "gran-refactor" que dura 3 semanas
#  ✅ Bueno: rama "agrega-validacion-email" que dura 1 día
#
#  Ramas cortas = menos divergencia = menos conflictos.
# =============================================================================

# =============================================================================
#  PRÁCTICA 3: COMMITS PEQUEÑOS Y FRECUENTES
# =============================================================================
#
#  Commits grandes que tocan 20 archivos generan más conflictos que
#  commits pequeños que tocan 2-3 archivos.
#
#  ❌ Malo:  un commit gigante "actualiza todo el frontend"
#  ✅ Bueno: varios commits enfocados:
#            "agrega componente de login"
#            "agrega validación al formulario"
#            "agrega estilos al componente de login"
# =============================================================================

# =============================================================================
#  PRÁCTICA 4: COMUNICACIÓN CON EL EQUIPO
# =============================================================================
#
#  Si sabes que vas a modificar un archivo crítico (como un archivo de
#  configuración o un componente que todos usan), avisa a tu equipo.
#
#  Herramientas útiles:
#  - Slack/Discord: "voy a refactorizar el archivo de rutas"
#  - GitHub Issues: asigna tareas para evitar trabajo duplicado
#  - Pull Requests: revisa antes de fusionar para detectar conflictos
# =============================================================================

# =============================================================================
#  PRÁCTICA 5: ARQUITECTURA QUE MINIMIZA CONFLICTOS
# =============================================================================
#
#  La forma en que organizas tu código afecta la frecuencia de conflictos:
#
#  ❌ Un archivo gigante de 1000 líneas que todos editan
#  ✅ Varios archivos pequeños con responsabilidades claras
#
#  ❌ Todo en un mismo archivo de configuración
#  ✅ Configuración modular dividida por secciones
#
#  ❌ Estilos globales en un solo archivo CSS
#  ✅ Estilos por componente (CSS Modules, Tailwind, scoped)
# =============================================================================

# =============================================================================
#  PRÁCTICA 6: USAR .gitattributes PARA ARCHIVOS ESPECIALES
# =============================================================================

# Algunos archivos generados (como lock files) siempre causan conflictos.
# Puedes decirle a Git cómo manejarlos automáticamente:

# Ejemplo de .gitattributes:
cat << 'EOF'
# En caso de conflicto, siempre usar nuestra versión de los lock files
package-lock.json merge=ours
yarn.lock merge=ours
pubspec.lock merge=ours
EOF

# Configurar la estrategia "ours" para merge:
git config --global merge.ours.driver true

# =============================================================================
#  PRÁCTICA 7: PULL ANTES DE PUSH
# =============================================================================

# SIEMPRE haz pull antes de push para detectar conflictos temprano
git pull origin main
# Si hay conflictos, resuélvelos ahora (cuando son pequeños y frescos)
git push origin feature

# =============================================================================
#  RESUMEN DE BUENAS PRÁCTICAS
# =============================================================================
#
#  1. Actualiza tu rama con main frecuentemente (mínimo diario)
#  2. Usa ramas cortas (1-3 días máximo)
#  3. Haz commits pequeños y enfocados
#  4. Comunica con tu equipo qué archivos estás tocando
#  5. Organiza el código en archivos pequeños con responsabilidades claras
#  6. Usa .gitattributes para archivos generados
#  7. Haz pull antes de push
#  8. Revisa Pull Requests rápidamente para evitar ramas obsoletas
# =============================================================================

echo ""
echo "=== Fin de 05_prevenir_conflictos.sh ==="
echo "Prevenir es mejor que resolver. Siguiente: ejercicios de práctica."
