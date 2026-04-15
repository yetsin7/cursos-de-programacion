#!/bin/bash
# =============================================================================
# ARCHIVO: 01_que_es_pull_request.sh
# TEMA: ¿Qué es un Pull Request? — Concepto y propósito
# =============================================================================
#
# Los Pull Requests (PRs) son la funcionalidad más importante de GitHub
# para la colaboración. Si entiendes los PRs, entiendes cómo trabajan
# los equipos de desarrollo modernos.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# ¿QUÉ ES UN PULL REQUEST?
# ─────────────────────────────────────────────────────────────────────────────

# Un Pull Request es una SOLICITUD para fusionar los cambios de una rama
# en otra. El nombre viene de "pedir" (request) que el repositorio
# "jale" (pull) tus cambios hacia la rama principal.

# En términos simples:
# "Hice cambios en mi rama. ¿Pueden revisar mi código e integrarlo?"

# Un PR NO es simplemente un merge. Es un espacio de:
# - Revisión de código (code review)
# - Discusión técnica
# - Verificación automática (CI/CD)
# - Documentación del cambio (por qué se hizo, qué resuelve)

echo "========================================="
echo "  ¿QUÉ ES UN PULL REQUEST?"
echo "========================================="
echo ""
echo "  Una solicitud para fusionar cambios de una rama en otra,"
echo "  con un proceso de revisión y discusión de por medio."
echo ""
echo "  PR = Código + Revisión + Discusión + Aprobación + Merge"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# ¿POR QUÉ EXISTEN LOS PULL REQUESTS?
# ─────────────────────────────────────────────────────────────────────────────

# Sin Pull Requests, el flujo de trabajo sería:
# 1. Cada persona hace push directo a main
# 2. Nadie revisa el código de nadie
# 3. Los bugs se descubren cuando ya están en producción
# 4. No hay registro de POR QUÉ se hicieron los cambios

# Con Pull Requests:
# 1. Cada persona trabaja en su propia rama
# 2. Los cambios se revisan antes de fusionarse
# 3. Se detectan bugs y problemas ANTES de que lleguen a main
# 4. Queda un registro completo de cada cambio y su motivación

echo "========================================="
echo "  ¿POR QUÉ SON IMPORTANTES?"
echo "========================================="
echo ""
echo "  - Calidad: El código se revisa antes de integrarse"
echo "  - Seguridad: Se detectan bugs antes de producción"
echo "  - Documentación: Cada cambio queda explicado"
echo "  - Colaboración: El equipo discute decisiones técnicas"
echo "  - Historial: Se puede rastrear por qué se hizo cada cambio"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# ANATOMÍA DE UN PULL REQUEST
# ─────────────────────────────────────────────────────────────────────────────

# Un Pull Request en GitHub tiene estos componentes:

echo "========================================="
echo "  ANATOMÍA DE UN PR"
echo "========================================="
echo ""
echo "  1. TÍTULO — Resumen corto del cambio"
echo "     Ejemplo: 'Agregar autenticación con Google'"
echo ""
echo "  2. DESCRIPCIÓN — Explicación detallada:"
echo "     - Qué se cambió y por qué"
echo "     - Cómo probarlo"
echo "     - Screenshots si hay cambios visuales"
echo "     - Issues relacionados (#123)"
echo ""
echo "  3. RAMAS — De dónde a dónde:"
echo "     feature/auth → main"
echo ""
echo "  4. COMMITS — Lista de commits incluidos"
echo ""
echo "  5. ARCHIVOS CAMBIADOS — Diff de todos los archivos"
echo ""
echo "  6. REVISIONES — Comentarios y aprobaciones"
echo ""
echo "  7. CHECKS — CI/CD, tests, linting automático"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# FLUJO TÍPICO DE UN PULL REQUEST
# ─────────────────────────────────────────────────────────────────────────────

cat << 'FLUJO'
  ┌─────────────────┐
  │ 1. Crear rama   │  git checkout -b feature/mi-cambio
  └────────┬────────┘
           ▼
  ┌─────────────────┐
  │ 2. Hacer cambios│  Editar archivos, agregar funcionalidades
  └────────┬────────┘
           ▼
  ┌─────────────────┐
  │ 3. Commits      │  git add . && git commit -m "mensaje"
  └────────┬────────┘
           ▼
  ┌─────────────────┐
  │ 4. Push         │  git push origin feature/mi-cambio
  └────────┬────────┘
           ▼
  ┌─────────────────┐
  │ 5. Crear PR     │  En GitHub: "New Pull Request"
  └────────┬────────┘
           ▼
  ┌─────────────────┐
  │ 6. Code Review  │  Compañeros revisan el código
  └────────┬────────┘
           ▼
  ┌─────────────────┐
  │ 7. Ajustes      │  Corregir según el feedback
  └────────┬────────┘
           ▼
  ┌─────────────────┐
  │ 8. Aprobación   │  Revisores aprueban el PR
  └────────┬────────┘
           ▼
  ┌─────────────────┐
  │ 9. Merge        │  Se fusiona en main
  └─────────────────┘
FLUJO

# ─────────────────────────────────────────────────────────────────────────────
# TIPOS DE PULL REQUESTS
# ─────────────────────────────────────────────────────────────────────────────

echo ""
echo "========================================="
echo "  TIPOS DE PULL REQUESTS"
echo "========================================="
echo ""
echo "  FEATURE PR — Nueva funcionalidad"
echo "    feature/login → main"
echo ""
echo "  BUGFIX PR — Corrección de un bug"
echo "    fix/login-error → main"
echo ""
echo "  HOTFIX PR — Corrección urgente en producción"
echo "    hotfix/security-patch → main"
echo ""
echo "  REFACTOR PR — Mejora de código sin cambiar funcionalidad"
echo "    refactor/clean-auth → main"
echo ""
echo "  DRAFT PR — PR en progreso, no listo para revisión"
echo "    Se marca como 'Draft' en GitHub"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# DRAFT PULL REQUESTS
# ─────────────────────────────────────────────────────────────────────────────

# Los Draft PRs son PRs marcados como "en progreso".
# Son útiles para:
# - Mostrar tu trabajo antes de que esté terminado
# - Pedir feedback temprano sobre la dirección del cambio
# - Indicar que el PR NO está listo para merge

# Los Draft PRs:
# - No se pueden mergear hasta que se marquen como "Ready for review"
# - Se distinguen visualmente con un badge verde "Draft"
# - Son una señal clara de "aún estoy trabajando en esto"

echo ""
echo "========================================="
echo "  DRAFT PULL REQUESTS"
echo "========================================="
echo ""
echo "  - PR en progreso, no listo para merge"
echo "  - Útil para pedir feedback temprano"
echo "  - Se cambia a 'Ready for review' cuando está listo"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# BUENAS PRÁCTICAS PARA PULL REQUESTS
# ─────────────────────────────────────────────────────────────────────────────

echo "========================================="
echo "  BUENAS PRÁCTICAS"
echo "========================================="
echo ""
echo "  1. PRs pequeños y enfocados (un cambio por PR)"
echo "  2. Título claro y descriptivo"
echo "  3. Descripción detallada del por qué"
echo "  4. Incluir screenshots si hay cambios visuales"
echo "  5. Vincular Issues relacionados (Fixes #123)"
echo "  6. No mezclar refactoring con nuevas funcionalidades"
echo "  7. Asegurar que los tests pasan antes de pedir review"
echo "  8. Responder al feedback de forma constructiva"
echo "  9. No dejar PRs abiertos por días sin atender"
echo "  10. Usar Draft PR si aún estás trabajando"
echo ""
