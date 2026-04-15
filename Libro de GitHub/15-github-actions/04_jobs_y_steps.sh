#!/bin/bash

# =============================================================================
#  CAPÍTULO 15 — GITHUB ACTIONS
#  Archivo: 04_jobs_y_steps.sh
#  Tema: Jobs, steps, runs-on, uses, run
# =============================================================================
#
#  Los jobs son la unidad principal de ejecución en un workflow.
#  Cada job corre en un runner independiente (máquina virtual limpia).
#  Dentro de cada job hay steps que se ejecutan en orden.
#
# =============================================================================

# =============================================================================
#  ANATOMÍA DE UN JOB
# =============================================================================

cat << 'YAML'
jobs:
  # Nombre del job (identificador, sin espacios)
  build:
    # Nombre descriptivo que aparece en la interfaz de GitHub
    name: Compilar proyecto

    # Sistema operativo del runner
    runs-on: ubuntu-latest
    # Opciones: ubuntu-latest, ubuntu-22.04, windows-latest, macos-latest

    # Pasos del job
    steps:
      # Step con "uses" → usa una acción existente
      - name: Descargar código
        uses: actions/checkout@v4

      # Step con "run" → ejecuta un comando de terminal
      - name: Instalar dependencias
        run: npm install

      # Step con múltiples comandos
      - name: Build y test
        run: |
          npm run build
          npm test
YAML

# =============================================================================
#  MÚLTIPLES JOBS (PARALELOS POR DEFECTO)
# =============================================================================

cat << 'YAML'
jobs:
  # Job 1: Tests
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm install
      - run: npm test

  # Job 2: Linting (corre EN PARALELO con test)
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm install
      - run: npm run lint

  # Job 3: Build (corre DESPUÉS de test y lint)
  build:
    needs: [test, lint]    # Espera a que terminen test y lint
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm run build
YAML

# =============================================================================
#  DEPENDENCIAS ENTRE JOBS (needs)
# =============================================================================
#
#  Por defecto, los jobs corren EN PARALELO.
#  Para que un job espere a otro, usa "needs":
#
#  needs: test              → espera a que "test" termine
#  needs: [test, lint]      → espera a que AMBOS terminen
#
#  Si un job del que dependes falla, los jobs dependientes se cancelan.
# =============================================================================

# =============================================================================
#  "uses" — USAR ACCIONES DE LA COMUNIDAD
# =============================================================================

cat << 'YAML'
steps:
  # Checkout: descarga el código del repositorio
  - uses: actions/checkout@v4

  # Setup Node.js: instala una versión específica de Node
  - uses: actions/setup-node@v4
    with:
      node-version: '20'

  # Setup Java: necesario para Flutter y Android
  - uses: actions/setup-java@v4
    with:
      distribution: 'temurin'
      java-version: '17'

  # Setup Flutter
  - uses: subosito/flutter-action@v2
    with:
      flutter-version: '3.24.0'
YAML

# =============================================================================
#  "run" — EJECUTAR COMANDOS
# =============================================================================

cat << 'YAML'
steps:
  # Comando simple
  - run: echo "Hola mundo"

  # Múltiples comandos (con pipe |)
  - run: |
      echo "Paso 1: instalar"
      npm install
      echo "Paso 2: compilar"
      npm run build

  # Cambiar directorio de trabajo
  - run: npm install
    working-directory: ./frontend

  # Usar un shell diferente (por defecto es bash en Linux)
  - run: echo "Corriendo en PowerShell"
    shell: pwsh
YAML

# =============================================================================
#  CONDICIONALES EN STEPS Y JOBS
# =============================================================================

cat << 'YAML'
steps:
  # Ejecutar solo si los tests pasaron
  - name: Deploy
    if: success()
    run: npm run deploy

  # Ejecutar solo si algo falló
  - name: Notificar error
    if: failure()
    run: echo "Algo falló"

  # Ejecutar SIEMPRE (incluso si un paso anterior falló)
  - name: Limpiar
    if: always()
    run: rm -rf temp/

  # Ejecutar solo en la rama main
  - name: Deploy a producción
    if: github.ref == 'refs/heads/main'
    run: npm run deploy

  # Ejecutar solo en pull requests
  - name: Comentar en PR
    if: github.event_name == 'pull_request'
    run: echo "Esto es un PR"
YAML

# =============================================================================
#  OUTPUTS — PASAR DATOS ENTRE STEPS
# =============================================================================

cat << 'YAML'
steps:
  - name: Obtener versión
    id: version
    run: echo "version=$(cat package.json | jq -r .version)" >> $GITHUB_OUTPUT

  - name: Usar la versión
    run: echo "La versión es ${{ steps.version.outputs.version }}"
YAML

echo ""
echo "=== Fin de 04_jobs_y_steps.sh ==="
echo "Dominas jobs y steps. Siguiente: variables y secretos."
