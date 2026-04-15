#!/bin/bash
# =============================================================================
# ARCHIVO: 06_listar_ramas.sh
# TEMA: Listar y explorar ramas en Git
# =============================================================================
#
# Saber qué ramas existen, cuál es la activa y qué contiene cada una es
# fundamental para navegar tu repositorio. Git ofrece varias formas de
# listar y filtrar ramas.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# 1. Listar ramas locales
# ─────────────────────────────────────────────────────────────────────────────

# git branch sin argumentos lista todas las ramas locales.
# El asterisco (*) indica la rama actual.
git branch

# Salida:
#   feature/dashboard
#   feature/login
# * main
#   fix/bug-123

# ─────────────────────────────────────────────────────────────────────────────
# 2. Listar ramas remotas
# ─────────────────────────────────────────────────────────────────────────────

# git branch -r muestra las ramas que existen en el repositorio remoto.
# Estas son las ramas de origin (GitHub).
git branch -r

# Salida:
#   origin/main
#   origin/feature/login
#   origin/develop

# ─────────────────────────────────────────────────────────────────────────────
# 3. Listar TODAS las ramas (locales + remotas)
# ─────────────────────────────────────────────────────────────────────────────

# git branch -a (--all) muestra todas las ramas: locales y remotas.
git branch -a
git branch --all    # Equivalente

# Salida:
#   feature/dashboard
#   feature/login
# * main
#   fix/bug-123
#   remotes/origin/main
#   remotes/origin/feature/login
#   remotes/origin/develop

# ─────────────────────────────────────────────────────────────────────────────
# 4. Listar con información del último commit
# ─────────────────────────────────────────────────────────────────────────────

# git branch -v (verbose) muestra el hash y mensaje del último commit de cada rama.
git branch -v

# Salida:
#   feature/dashboard a1b2c3d Agrega componente de dashboard
#   feature/login     e4f5g6h Implementa autenticación con JWT
# * main              i7j8k9l Actualiza dependencias
#   fix/bug-123       m0n1o2p Corrige error en validación

# git branch -vv (doble verbose) además muestra la rama remota asociada
# y si estás adelante o atrás del remoto.
git branch -vv

# Salida:
# * main         i7j8k9l [origin/main] Actualiza dependencias
#   feature/login e4f5g6h [origin/feature/login: ahead 2] Implementa JWT
#   fix/bug-123  m0n1o2p Corrige validación
#
# [origin/main] = sincronizado con el remoto
# [ahead 2]     = tienes 2 commits que el remoto no tiene
# [behind 3]    = el remoto tiene 3 commits que tú no tienes
# Sin corchetes = la rama no tiene tracking remoto

# ─────────────────────────────────────────────────────────────────────────────
# 5. Filtrar ramas por estado de merge
# ─────────────────────────────────────────────────────────────────────────────

# Ramas que YA fueron fusionadas en la rama actual:
git branch --merged

# Ramas que AÚN NO han sido fusionadas:
git branch --no-merged

# Útil para saber qué ramas puedes eliminar con seguridad:
# Las que aparecen en --merged ya tienen sus cambios en la rama actual.

# Verificar contra una rama específica (no la actual):
git branch --merged main
git branch --no-merged main

# ─────────────────────────────────────────────────────────────────────────────
# 6. Filtrar ramas por patrón
# ─────────────────────────────────────────────────────────────────────────────

# Listar solo ramas que coincidan con un patrón (glob):
git branch --list "feature/*"      # Solo ramas que empiecen con feature/
git branch --list "fix/*"          # Solo ramas que empiecen con fix/
git branch --list "*login*"        # Ramas que contengan "login"

# ─────────────────────────────────────────────────────────────────────────────
# 7. Ordenar ramas
# ─────────────────────────────────────────────────────────────────────────────

# Ordenar por fecha del último commit (más reciente primero):
git branch --sort=-committerdate

# Ordenar por nombre alfabéticamente:
git branch --sort=refname

# Combinación útil: ver ramas recientes con info del commit.
# Muestra qué ramas has tocado recientemente.
git branch -v --sort=-committerdate

# ─────────────────────────────────────────────────────────────────────────────
# 8. Ver la rama actual
# ─────────────────────────────────────────────────────────────────────────────

# Varias formas de ver solo la rama actual:
git branch --show-current          # Solo el nombre (Git 2.22+)
git rev-parse --abbrev-ref HEAD    # Alternativa compatible con versiones antiguas

# git status también la muestra en la primera línea:
git status | head -1

# =============================================================================
# RESUMEN:
# - git branch                 → Listar ramas locales
# - git branch -r              → Listar ramas remotas
# - git branch -a              → Listar todas (locales + remotas)
# - git branch -v              → Listar con último commit
# - git branch -vv             → Listar con info de tracking remoto
# - git branch --merged        → Ramas ya fusionadas
# - git branch --no-merged     → Ramas sin fusionar
# - git branch --list "pat*"   → Filtrar por patrón
# - git branch --sort=-committerdate → Ordenar por fecha
# =============================================================================
