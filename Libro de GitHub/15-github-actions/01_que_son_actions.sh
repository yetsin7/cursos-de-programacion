#!/bin/bash

# =============================================================================
#  CAPÍTULO 15 — GITHUB ACTIONS
#  Archivo: 01_que_son_actions.sh
#  Tema: Concepto de CI/CD y qué son GitHub Actions
# =============================================================================
#
#  GitHub Actions es un servicio de automatización integrado directamente
#  en GitHub. Permite ejecutar código, tests, builds y despliegues de
#  forma automática cuando ocurren eventos en tu repositorio.
#
# =============================================================================

# =============================================================================
#  ¿QUÉ ES CI/CD?
# =============================================================================
#
#  CI — INTEGRACIÓN CONTINUA (Continuous Integration)
#  ──────────────────────────────────────────────────
#  Práctica donde los desarrolladores integran su código frecuentemente
#  (varias veces al día) y cada integración es verificada por un build
#  automático y tests para detectar errores rápidamente.
#
#  Flujo típico:
#    1. Desarrollador hace push de su código
#    2. El servidor de CI detecta el cambio
#    3. Ejecuta los tests automáticamente
#    4. Si algo falla → notifica al desarrollador
#    5. Si todo pasa → el código está listo para revisión
#
#  CD — DESPLIEGUE CONTINUO (Continuous Deployment)
#  ──────────────────────────────────────────────────
#  Extensión de CI donde el código que pasa todos los tests se despliega
#  automáticamente a producción sin intervención manual.
#
#  Variante: ENTREGA CONTINUA (Continuous Delivery)
#  El código está listo para desplegar, pero requiere aprobación manual.
#
# =============================================================================

# =============================================================================
#  ¿QUÉ ES GITHUB ACTIONS?
# =============================================================================
#
#  Es la plataforma de CI/CD de GitHub. Sus características principales:
#
#  1. INTEGRADO EN GITHUB
#     - No necesitas servicios externos (como Jenkins, Travis CI, CircleCI)
#     - Se configura con archivos YAML en tu repositorio
#     - Los resultados aparecen directamente en los Pull Requests
#
#  2. GRATUITO PARA REPOS PÚBLICOS
#     - Repos públicos: minutos ilimitados
#     - Repos privados: 2000 minutos/mes en el plan gratuito
#
#  3. MULTIPLATAFORMA
#     - Ejecuta en Linux, macOS y Windows
#     - Puedes probar tu código en múltiples sistemas operativos
#
#  4. MARKETPLACE DE ACCIONES
#     - Miles de acciones reutilizables creadas por la comunidad
#     - No necesitas reinventar la rueda
#
# =============================================================================

# =============================================================================
#  ESTRUCTURA DE ARCHIVOS
# =============================================================================
#
#  Los workflows se definen como archivos YAML en tu repositorio:
#
#    tu-repositorio/
#    ├── .github/
#    │   └── workflows/
#    │       ├── ci.yml         ← workflow de integración continua
#    │       ├── deploy.yml     ← workflow de despliegue
#    │       └── test.yml       ← workflow de tests
#    ├── src/
#    ├── tests/
#    └── package.json
#
#  El directorio .github/workflows/ es donde GitHub busca los workflows.
#  Cualquier archivo .yml o .yaml en esa carpeta será detectado.
#
# =============================================================================

# --- Crear la estructura de directorios para workflows ---
mkdir -p .github/workflows

# =============================================================================
#  CONCEPTOS FUNDAMENTALES
# =============================================================================
#
#  WORKFLOW: un proceso automatizado completo (un archivo YAML)
#  EVENT:   el disparador (push, PR, schedule, manual)
#  JOB:     un conjunto de pasos que corren en la misma máquina virtual
#  STEP:    una tarea individual (un comando o una acción)
#  ACTION:  un paso reutilizable (de la comunidad o tuyo)
#  RUNNER:  la máquina virtual donde se ejecuta el job
#
#  Jerarquía:
#    Workflow
#    └── Job 1 (corre en Runner A)
#    │   ├── Step 1: checkout código
#    │   ├── Step 2: instalar dependencias
#    │   └── Step 3: ejecutar tests
#    └── Job 2 (corre en Runner B, puede ser paralelo)
#        ├── Step 1: checkout código
#        └── Step 2: build y deploy
#
# =============================================================================

# =============================================================================
#  ¿DÓNDE VER LOS RESULTADOS?
# =============================================================================
#
#  1. En la pestaña "Actions" de tu repositorio en GitHub
#  2. En los Pull Requests (aparece un check verde ✅ o rojo ❌)
#  3. En los commits (icono de estado junto al hash)
#  4. Por email si configuras notificaciones
#
# =============================================================================

echo ""
echo "=== Fin de 01_que_son_actions.sh ==="
echo "Ya conoces los conceptos. Siguiente: crear tu primer workflow."
