#!/bin/bash
# =============================================================================
# ARCHIVO: 02_git_remote.sh
# TEMA: Administrar conexiones remotas con git remote
# =============================================================================
#
# git remote te permite ver, agregar, renombrar y eliminar las conexiones
# a repositorios remotos. Es como una agenda de contactos de tu repositorio:
# puedes tener múltiples remotos configurados.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# 1. Ver remotos configurados
# ─────────────────────────────────────────────────────────────────────────────

# Lista los nombres de todos los remotos configurados:
git remote

# Salida típica: origin

# Con -v (verbose) muestra nombres + URLs:
git remote -v

# Salida:
#   origin  https://github.com/usuario/proyecto.git (fetch)
#   origin  https://github.com/usuario/proyecto.git (push)

# Ver información detallada de un remoto específico:
git remote show origin

# Salida incluye:
# - URL del remoto
# - Ramas remotas
# - Ramas locales configuradas para push/pull
# - Ramas remotas rastreadas
# - Estado de sincronización

# ─────────────────────────────────────────────────────────────────────────────
# 2. Agregar un remoto
# ─────────────────────────────────────────────────────────────────────────────

# Sintaxis: git remote add <nombre> <url>

# Agregar el remoto principal (origin):
git remote add origin https://github.com/usuario/mi-proyecto.git

# Agregar el repositorio original de un fork (upstream):
git remote add upstream https://github.com/autor-original/proyecto.git

# Puedes agregar cualquier nombre. Algunos usos:
git remote add backup https://github.com/usuario/proyecto-backup.git
git remote add staging git@servidor-staging.com:proyecto.git

# Con SSH en vez de HTTPS:
git remote add origin git@github.com:usuario/mi-proyecto.git

# ─────────────────────────────────────────────────────────────────────────────
# 3. Renombrar un remoto
# ─────────────────────────────────────────────────────────────────────────────

# Si quieres cambiar el nombre de un remoto:
git remote rename origin github

# Ahora en vez de "origin" se llama "github".
# Todas las ramas de rastreo también se renombran:
#   origin/main → github/main

# Para volver al nombre original:
git remote rename github origin

# ─────────────────────────────────────────────────────────────────────────────
# 4. Cambiar la URL de un remoto
# ─────────────────────────────────────────────────────────────────────────────

# Si la URL del remoto cambió o quieres cambiar de HTTPS a SSH:
git remote set-url origin git@github.com:usuario/proyecto.git

# Verificar el cambio:
git remote -v

# Esto es útil cuando:
# - Cambiaste el nombre del repositorio en GitHub
# - Quieres migrar de HTTPS a SSH (o viceversa)
# - Moviste el repositorio a otra organización

# ─────────────────────────────────────────────────────────────────────────────
# 5. Eliminar un remoto
# ─────────────────────────────────────────────────────────────────────────────

# Si ya no necesitas un remoto:
git remote remove upstream

# También puedes usar la versión corta:
git remote rm upstream

# Esto elimina:
# - La conexión al remoto
# - Todas las ramas de rastreo de ese remoto (upstream/main, etc.)
# - La configuración de tracking asociada

# ─────────────────────────────────────────────────────────────────────────────
# 6. Múltiples remotos: caso práctico
# ─────────────────────────────────────────────────────────────────────────────

# Es muy común tener múltiples remotos cuando trabajas con forks.
# Ejemplo: contribuir a un proyecto open source.

# Paso 1: Fork el proyecto en GitHub (desde la interfaz web)
# Paso 2: Clonar TU fork
git clone https://github.com/tu-usuario/proyecto.git
cd proyecto

# Paso 3: Agregar el repo original como upstream
git remote add upstream https://github.com/autor-original/proyecto.git

# Verificar ambos remotos:
git remote -v
# origin    https://github.com/tu-usuario/proyecto.git (fetch)
# origin    https://github.com/tu-usuario/proyecto.git (push)
# upstream  https://github.com/autor-original/proyecto.git (fetch)
# upstream  https://github.com/autor-original/proyecto.git (push)

# Ahora puedes:
# - Subir cambios a TU fork:        git push origin main
# - Descargar actualizaciones del original: git fetch upstream

# ─────────────────────────────────────────────────────────────────────────────
# 7. Limpiar referencias remotas obsoletas
# ─────────────────────────────────────────────────────────────────────────────

# Cuando alguien elimina una rama del remoto, tu copia local de esa referencia
# sigue existiendo. Para limpiar referencias que ya no existen en el remoto:
git remote prune origin

# También puedes hacerlo durante el fetch:
git fetch --prune

# Para configurar que siempre haga prune automáticamente:
# git config --global fetch.prune true

# =============================================================================
# RESUMEN:
# - git remote -v                       → Ver remotos con URLs
# - git remote add <nombre> <url>       → Agregar remoto
# - git remote rename <viejo> <nuevo>   → Renombrar remoto
# - git remote set-url <nombre> <url>   → Cambiar URL
# - git remote remove <nombre>          → Eliminar remoto
# - git remote show <nombre>            → Info detallada
# - git remote prune <nombre>           → Limpiar referencias obsoletas
# =============================================================================
