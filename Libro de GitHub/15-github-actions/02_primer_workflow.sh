#!/bin/bash

# =============================================================================
#  CAPÍTULO 15 — GITHUB ACTIONS
#  Archivo: 02_primer_workflow.sh
#  Tema: Crear tu primer workflow YAML
# =============================================================================
#
#  Vamos a crear un workflow sencillo que se ejecuta cuando haces push.
#  El workflow saluda y muestra información del entorno.
#
# =============================================================================

# =============================================================================
#  CREAR EL ARCHIVO DEL WORKFLOW
# =============================================================================

# Paso 1: Crear la estructura de directorios
mkdir -p .github/workflows

# Paso 2: Crear el archivo YAML del workflow
# El siguiente comando crea un workflow básico completo:

cat > .github/workflows/hola-mundo.yml << 'EOF'
# =============================================================================
#  WORKFLOW: Hola Mundo
#  Este es un workflow básico que se ejecuta en cada push a main.
#  Demuestra la estructura fundamental de un workflow de GitHub Actions.
# =============================================================================

name: Hola Mundo CI

# Evento que dispara el workflow
on:
  push:
    branches: [ main ]

# Los jobs que se van a ejecutar
jobs:
  # Nombre del job
  saludo:
    # Sistema operativo donde corre
    runs-on: ubuntu-latest

    # Pasos del job
    steps:
      # Paso 1: Descargar el código del repositorio
      - name: Checkout del código
        uses: actions/checkout@v4

      # Paso 2: Mostrar un saludo
      - name: Saludo
        run: echo "¡Hola! GitHub Actions está funcionando correctamente."

      # Paso 3: Mostrar información del entorno
      - name: Información del sistema
        run: |
          echo "Sistema operativo: $(uname -s)"
          echo "Rama: ${{ github.ref }}"
          echo "Repositorio: ${{ github.repository }}"
          echo "Commit: ${{ github.sha }}"
          echo "Actor: ${{ github.actor }}"

      # Paso 4: Listar los archivos del repositorio
      - name: Listar archivos
        run: ls -la
EOF

# =============================================================================
#  EXPLICACIÓN LÍNEA POR LÍNEA
# =============================================================================
#
#  name: Hola Mundo CI
#  → Nombre descriptivo del workflow. Aparece en la pestaña Actions de GitHub.
#
#  on:
#    push:
#      branches: [ main ]
#  → El evento que dispara el workflow. En este caso, cualquier push a main.
#
#  jobs:
#  → Sección donde defines los trabajos. Puedes tener múltiples jobs.
#
#    saludo:
#    → Nombre del job. Puedes llamarlo como quieras.
#
#      runs-on: ubuntu-latest
#      → El runner (máquina virtual) donde se ejecuta. Opciones:
#        - ubuntu-latest (Linux — el más usado y más rápido)
#        - windows-latest (Windows)
#        - macos-latest (macOS — más lento y costoso)
#
#      steps:
#      → Lista de pasos que se ejecutan en orden secuencial.
#
#        - uses: actions/checkout@v4
#        → Usa una acción de la comunidad. checkout descarga tu código
#          en el runner para que los siguientes pasos puedan acceder a él.
#
#        - name: Saludo
#          run: echo "..."
#        → Ejecuta un comando de terminal. "name" es descriptivo.
#
#        - run: |
#            comando1
#            comando2
#        → El pipe (|) permite escribir múltiples líneas de comandos.
#
#        - ${{ github.ref }}
#        → Contexto de GitHub. Variables que te dan información sobre
#          el evento que disparó el workflow.
#
# =============================================================================

# =============================================================================
#  CÓMO ACTIVAR EL WORKFLOW
# =============================================================================

# Paso 3: Hacer commit y push del workflow
git add .github/workflows/hola-mundo.yml
git commit -m "Agrega workflow de Hola Mundo"
git push origin main

# Después del push:
# 1. Ve a tu repositorio en GitHub
# 2. Haz clic en la pestaña "Actions"
# 3. Verás tu workflow ejecutándose (o ya completado)
# 4. Haz clic en él para ver los logs de cada paso

# =============================================================================
#  WORKFLOW MÁS ÚTIL: EJECUTAR TESTS
# =============================================================================

cat > .github/workflows/tests.yml << 'EOF'
name: Tests

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Configurar Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'

      - name: Instalar dependencias
        run: npm install

      - name: Ejecutar tests
        run: npm test
EOF

echo ""
echo "=== Fin de 02_primer_workflow.sh ==="
echo "Tu primer workflow está listo. Siguiente: eventos y triggers."
