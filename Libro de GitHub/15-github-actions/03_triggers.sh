#!/bin/bash

# =============================================================================
#  CAPÍTULO 15 — GITHUB ACTIONS
#  Archivo: 03_triggers.sh
#  Tema: Eventos que disparan workflows
# =============================================================================
#
#  La sección "on:" de un workflow define CUÁNDO se ejecuta.
#  GitHub soporta docenas de eventos. Aquí veremos los más importantes.
#
# =============================================================================

# =============================================================================
#  PUSH — se ejecuta cuando haces push
# =============================================================================

cat << 'YAML'
# Ejecutar en CUALQUIER push a cualquier rama
on: push

# Ejecutar solo en push a ramas específicas
on:
  push:
    branches: [ main, develop ]

# Ejecutar en push a ramas que coincidan con un patrón
on:
  push:
    branches:
      - 'release/**'      # release/1.0, release/2.0, etc.
      - 'feature/**'

# Ejecutar solo cuando se modifican ciertos archivos
on:
  push:
    paths:
      - 'src/**'           # Solo si cambian archivos en src/
      - '!src/**/*.md'     # Pero NO si solo cambian archivos .md

# Ejecutar en push de tags
on:
  push:
    tags:
      - 'v*'              # v1.0.0, v2.1.3, etc.
YAML

# =============================================================================
#  PULL_REQUEST — se ejecuta con Pull Requests
# =============================================================================

cat << 'YAML'
# Ejecutar cuando se crea o actualiza un PR hacia main
on:
  pull_request:
    branches: [ main ]

# Ejecutar en eventos específicos del PR
on:
  pull_request:
    types: [ opened, synchronize, reopened ]
    # opened:       cuando se crea el PR
    # synchronize:  cuando se pushean nuevos commits al PR
    # reopened:     cuando se reabre un PR cerrado

# Ejecutar solo si el PR modifica ciertos archivos
on:
  pull_request:
    paths:
      - 'src/**'
      - 'tests/**'
YAML

# =============================================================================
#  SCHEDULE — ejecutar en un horario (cron)
# =============================================================================

cat << 'YAML'
# Ejecutar todos los días a las 6:00 AM UTC
on:
  schedule:
    - cron: '0 6 * * *'

# Ejecutar cada lunes a las 9:00 AM UTC
on:
  schedule:
    - cron: '0 9 * * 1'

# Sintaxis cron: minuto hora día-mes mes día-semana
#   ┌───── minuto (0-59)
#   │ ┌───── hora (0-23)
#   │ │ ┌───── día del mes (1-31)
#   │ │ │ ┌───── mes (1-12)
#   │ │ │ │ ┌───── día de la semana (0-6, domingo=0)
#   * * * * *
YAML

# =============================================================================
#  WORKFLOW_DISPATCH — ejecución manual desde GitHub
# =============================================================================

cat << 'YAML'
# Permitir ejecución manual desde la pestaña Actions
on:
  workflow_dispatch:

# Con parámetros de entrada que el usuario define al ejecutar
on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Ambiente de despliegue'
        required: true
        default: 'staging'
        type: choice
        options:
          - staging
          - production
      debug:
        description: 'Activar modo debug'
        required: false
        type: boolean
        default: false
YAML

# =============================================================================
#  RELEASE — cuando se publica un release
# =============================================================================

cat << 'YAML'
# Ejecutar cuando se publica un release en GitHub
on:
  release:
    types: [ published ]
YAML

# =============================================================================
#  COMBINAR MÚLTIPLES EVENTOS
# =============================================================================

cat << 'YAML'
# Ejecutar en push, PR y manualmente
on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  workflow_dispatch:
YAML

# =============================================================================
#  OTROS EVENTOS ÚTILES
# =============================================================================
#
#  issues:          cuando se crea o modifica un issue
#  issue_comment:   cuando alguien comenta en un issue o PR
#  fork:            cuando alguien hace fork del repo
#  star:            cuando alguien le da star al repo
#  page_build:      cuando se construye GitHub Pages
#  workflow_call:    cuando otro workflow llama a este (workflows reutilizables)
#
#  Lista completa: https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows
# =============================================================================

echo ""
echo "=== Fin de 03_triggers.sh ==="
echo "Ya conoces los triggers. Siguiente: jobs y steps."
