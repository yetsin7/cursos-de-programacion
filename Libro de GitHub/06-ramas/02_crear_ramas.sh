#!/bin/bash
# =============================================================================
# ARCHIVO: 02_crear_ramas.sh
# TEMA: Crear ramas nuevas en Git
# =============================================================================
#
# Existen varias formas de crear una rama en Git. La diferencia principal
# es si quieres crearla Y moverte a ella inmediatamente, o solo crearla
# y quedarte donde estás.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# 1. git branch — Crear sin moverse
# ─────────────────────────────────────────────────────────────────────────────

# git branch <nombre> crea una rama nueva que apunta al commit actual (HEAD).
# NO te mueve a la nueva rama. Sigues en la rama donde estabas.
git branch feature/login

# Verificamos: el asterisco (*) sigue en main.
git branch
#   feature/login
# * main

# La nueva rama apunta al mismo commit que main en este momento.
# Es como poner dos etiquetas en el mismo punto.

# ─────────────────────────────────────────────────────────────────────────────
# 2. git checkout -b — Crear Y moverse (forma clásica)
# ─────────────────────────────────────────────────────────────────────────────

# git checkout -b <nombre> crea una rama nueva Y te mueve a ella en un paso.
# Es el equivalente a: git branch <nombre> + git checkout <nombre>
git checkout -b feature/dashboard

# Verificamos: ahora estamos en la nueva rama.
git branch
#   feature/login
# * feature/dashboard
#   main

# ─────────────────────────────────────────────────────────────────────────────
# 3. git switch -c — Crear Y moverse (forma moderna)
# ─────────────────────────────────────────────────────────────────────────────

# Desde Git 2.23, git switch -c es la forma recomendada para crear y cambiar.
# -c viene de "create" (crear).
git switch -c feature/registro

# Es más intuitivo que checkout porque switch SOLO maneja ramas.
# (checkout también puede restaurar archivos, lo que genera confusión.)

# Verificamos:
git branch
#   feature/login
#   feature/dashboard
# * feature/registro
#   main

# ─────────────────────────────────────────────────────────────────────────────
# 4. Crear rama desde un commit específico
# ─────────────────────────────────────────────────────────────────────────────

# Por defecto, la rama nueva se crea desde HEAD (el commit actual).
# Pero puedes crearla desde cualquier commit pasando su hash o referencia.

# Crear rama desde un commit específico (sin moverse):
git branch fix/bug-antiguo a1b2c3d

# Crear rama desde un commit específico Y moverse a ella:
git checkout -b fix/bug-antiguo a1b2c3d
git switch -c fix/bug-antiguo a1b2c3d

# Crear rama desde otra rama (apuntará al último commit de esa rama):
git branch feature/nueva main
git branch feature/otra feature/login

# ─────────────────────────────────────────────────────────────────────────────
# 5. Convenciones de nombres para ramas
# ─────────────────────────────────────────────────────────────────────────────

# Usar nombres descriptivos y consistentes facilita el trabajo en equipo.
# Convenciones populares:

# PREFIJO POR TIPO DE TRABAJO:
git branch feature/login              # Nueva funcionalidad
git branch fix/error-en-pago          # Corrección de error
git branch hotfix/crash-al-abrir      # Corrección urgente en producción
git branch refactor/limpiar-api       # Refactorización de código
git branch docs/actualizar-readme     # Cambios en documentación
git branch test/agregar-tests-login   # Agregar tests

# CON NÚMERO DE ISSUE/TICKET:
git branch feature/123-login-google   # Vinculado al issue #123
git branch fix/456-calculo-iva        # Vinculado al issue #456

# REGLAS GENERALES:
# ✅ Usa minúsculas
# ✅ Separa palabras con guiones (-)
# ✅ Usa prefijos descriptivos (feature/, fix/, etc.)
# ✅ Sé conciso pero claro
# ❌ No uses espacios (Git no los permite)
# ❌ No uses caracteres especiales (~, ^, :, \, ?)
# ❌ No termines con .lock

# ─────────────────────────────────────────────────────────────────────────────
# 6. Verificar la creación
# ─────────────────────────────────────────────────────────────────────────────

# Después de crear una rama, siempre verifica:

# Ver todas las ramas locales:
git branch

# Ver en qué rama estás (alternativa):
git status    # La primera línea dice "On branch ..."

# Ver el commit al que apunta cada rama:
git branch -v

# =============================================================================
# RESUMEN:
# - git branch <nombre>       → Crear rama sin moverse
# - git checkout -b <nombre>  → Crear rama Y moverse (clásico)
# - git switch -c <nombre>    → Crear rama Y moverse (moderno, recomendado)
# - git branch <nombre> <hash> → Crear rama desde un commit específico
# - Usa nombres descriptivos: feature/, fix/, hotfix/, docs/, test/
# - Nombres en minúsculas, separados por guiones, sin espacios
# =============================================================================
