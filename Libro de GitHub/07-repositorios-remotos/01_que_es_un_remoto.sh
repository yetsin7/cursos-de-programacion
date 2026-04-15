#!/bin/bash
# =============================================================================
# ARCHIVO: 01_que_es_un_remoto.sh
# TEMA: ¿Qué es un repositorio remoto?
# =============================================================================
#
# Un repositorio remoto es una versión de tu proyecto alojada en Internet
# o en una red. Es la forma en que Git permite la colaboración: múltiples
# personas pueden tener copias locales del mismo proyecto y sincronizarse
# a través del remoto.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# 1. Local vs Remoto
# ─────────────────────────────────────────────────────────────────────────────

# REPOSITORIO LOCAL:
# - Vive en tu computadora (en la carpeta .git)
# - Solo tú tienes acceso directo
# - Puedes trabajar sin conexión a Internet
# - Contiene todo el historial completo del proyecto

# REPOSITORIO REMOTO:
# - Vive en un servidor (GitHub, GitLab, Bitbucket, etc.)
# - Múltiples personas pueden acceder
# - Requiere conexión a Internet para sincronizar
# - También contiene el historial completo

# La relación es así:
#
#   Tu PC (local)  ←→  GitHub (remoto)  ←→  PC de Juan (local)
#                                        ←→  PC de María (local)
#
# Todos trabajan en sus copias locales y sincronizan a través del remoto.

# ─────────────────────────────────────────────────────────────────────────────
# 2. El concepto de "origin"
# ─────────────────────────────────────────────────────────────────────────────

# "origin" es simplemente un NOMBRE que Git le da al repositorio remoto
# principal. Es una convención, no una palabra mágica.
#
# Cuando clonas un repositorio:
#   git clone https://github.com/usuario/proyecto.git
#
# Git automáticamente:
# 1. Descarga todo el repositorio
# 2. Crea una conexión remota llamada "origin" que apunta a esa URL
# 3. Crea una rama local "main" que sigue a "origin/main"

# Puedes ver los remotos configurados con:
git remote -v

# Salida típica:
#   origin  https://github.com/usuario/proyecto.git (fetch)
#   origin  https://github.com/usuario/proyecto.git (push)
#
# (fetch) = URL para descargar
# (push)  = URL para subir

# ─────────────────────────────────────────────────────────────────────────────
# 3. El concepto de "upstream"
# ─────────────────────────────────────────────────────────────────────────────

# "upstream" se usa cuando haces un fork (copia) de un proyecto.
#
# Imagina que quieres contribuir al proyecto de alguien más:
# 1. Haces un fork en GitHub (crea una copia en TU cuenta)
# 2. Clonas TU fork: git clone https://github.com/TU-USUARIO/proyecto.git
# 3. origin = tu fork
# 4. upstream = el proyecto original
#
#   Proyecto original (upstream) ←── Tu fork (origin) ←── Tu PC (local)
#
# Configuras upstream para poder descargar actualizaciones del proyecto original:
git remote add upstream https://github.com/autor-original/proyecto.git

# ─────────────────────────────────────────────────────────────────────────────
# 4. Dos formas de conectar local con remoto
# ─────────────────────────────────────────────────────────────────────────────

# FORMA 1: Clonar un repositorio existente (el remoto ya existe)
# Git configura todo automáticamente.
git clone https://github.com/usuario/proyecto.git

# FORMA 2: Conectar un repositorio local a un remoto nuevo
# Cuando ya tienes un proyecto local y creas un repo vacío en GitHub.
git init
git add .
git commit -m "commit inicial"
git remote add origin https://github.com/usuario/proyecto.git
git push -u origin main

# ─────────────────────────────────────────────────────────────────────────────
# 5. Protocolos de conexión: HTTPS vs SSH
# ─────────────────────────────────────────────────────────────────────────────

# HTTPS (más sencillo para empezar):
#   https://github.com/usuario/proyecto.git
#   - Usa usuario y contraseña (o token de acceso personal)
#   - Funciona a través de firewalls sin configuración extra
#   - GitHub recomienda usar tokens en vez de contraseña

# SSH (más cómodo a largo plazo):
#   git@github.com:usuario/proyecto.git
#   - Usa llaves SSH (pública/privada) en vez de contraseña
#   - Una vez configurado, no pide credenciales nunca más
#   - Requiere configuración inicial de llaves SSH

# Para ver qué protocolo usas:
git remote -v
# Si la URL empieza con https:// → HTTPS
# Si la URL empieza con git@    → SSH

# ─────────────────────────────────────────────────────────────────────────────
# 6. Ramas remotas (tracking branches)
# ─────────────────────────────────────────────────────────────────────────────

# Cuando clonas un repositorio, Git crea "ramas de rastreo" (tracking branches).
# Estas son copias de solo lectura de las ramas del remoto.
#
# Se nombran como: origin/main, origin/develop, origin/feature/login
#
# NO puedes hacer commit directamente en origin/main.
# Son como una "foto" de cómo estaba el remoto la última vez que sincronizaste.

# Ver ramas remotas:
git branch -r

# Ver todas las ramas (locales + remotas):
git branch -a

# Las ramas remotas se actualizan cuando haces:
# - git fetch  (descarga cambios sin fusionar)
# - git pull   (descarga y fusiona)
# - git push   (sube y actualiza)

# =============================================================================
# RESUMEN:
# - Un remoto es una copia del repositorio en un servidor (GitHub)
# - "origin" es el nombre convencional del remoto principal
# - "upstream" se usa para el repositorio original en forks
# - HTTPS usa tokens; SSH usa llaves (ambos funcionan)
# - Las ramas remotas (origin/main) son copias de solo lectura
# - git clone configura todo automáticamente
# - git remote add conecta un repo local a un remoto manualmente
# =============================================================================
