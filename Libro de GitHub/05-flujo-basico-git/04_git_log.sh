#!/bin/bash
# =============================================================================
# ARCHIVO: 04_git_log.sh
# TEMA: Ver el historial de commits con git log
# =============================================================================
#
# git log es tu ventana al pasado del proyecto. Te permite explorar quién
# hizo qué cambio, cuándo y por qué. Es una herramienta esencial para
# entender la evolución del código y depurar problemas.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# 1. git log básico
# ─────────────────────────────────────────────────────────────────────────────

# Muestra el historial completo de commits, del más reciente al más antiguo.
# Cada entrada incluye: hash, autor, fecha y mensaje.
git log

# La salida se ve así:
#   commit a1b2c3d4e5f6... (HEAD -> main)
#   Author: Tu Nombre <tu@email.com>
#   Date:   Mon Apr 3 14:30:00 2026 -0600
#
#       Agrega validación de formulario de contacto
#
# Para salir del visor (less), presiona 'q'.
# Para avanzar: Espacio o flecha abajo. Para retroceder: 'b'.

# ─────────────────────────────────────────────────────────────────────────────
# 2. git log --oneline (formato compacto)
# ─────────────────────────────────────────────────────────────────────────────

# Muestra cada commit en una sola línea: hash abreviado + mensaje.
# Es la forma más rápida de ver el historial.
git log --oneline

# Salida:
#   a1b2c3d Agrega validación de formulario de contacto
#   e5f6g7h Corrige error en cálculo de precios
#   i8j9k0l Implementa sistema de carrito de compras
#
# El hash abreviado (7 caracteres) es suficiente para identificar un commit.

# ─────────────────────────────────────────────────────────────────────────────
# 3. git log --graph (historial visual con ramas)
# ─────────────────────────────────────────────────────────────────────────────

# Dibuja un gráfico ASCII de las ramas y merges en el historial.
# Muy útil para entender cómo se relacionan las ramas.
git log --graph

# Combinado con --oneline es aún mejor:
git log --graph --oneline

# Salida típica con ramas:
#   * a1b2c3d (HEAD -> main) Merge branch 'feature/login'
#   |\
#   | * d4e5f6g Agrega pantalla de login
#   | * h7i8j9k Agrega validación de credenciales
#   |/
#   * k0l1m2n Actualiza dependencias

# Para ver TODAS las ramas (no solo la actual):
git log --graph --oneline --all

# Versión "decorada" que muestra nombres de ramas y tags:
git log --graph --oneline --all --decorate

# ─────────────────────────────────────────────────────────────────────────────
# 4. Filtrar por autor
# ─────────────────────────────────────────────────────────────────────────────

# Muestra solo los commits de un autor específico.
# Busca coincidencias parciales en el nombre o email.
git log --author="Juan"

# Puedes combinar con --oneline para una vista compacta:
git log --author="Juan" --oneline

# Para ver commits de varios autores, usa expresiones regulares:
git log --author="Juan\|María" --oneline

# ─────────────────────────────────────────────────────────────────────────────
# 5. Filtrar por fecha
# ─────────────────────────────────────────────────────────────────────────────

# Commits después de una fecha (since/after son sinónimos):
git log --since="2026-01-01"
git log --after="2026-01-01"

# Commits antes de una fecha (until/before son sinónimos):
git log --until="2026-03-31"
git log --before="2026-03-31"

# Combinar ambos para un rango de fechas:
git log --since="2026-01-01" --until="2026-03-31" --oneline

# También acepta formatos relativos (muy práctico):
git log --since="2 weeks ago" --oneline
git log --since="3 days ago" --oneline
git log --since="yesterday" --oneline

# ─────────────────────────────────────────────────────────────────────────────
# 6. Filtrar por mensaje de commit
# ─────────────────────────────────────────────────────────────────────────────

# Busca commits cuyo mensaje contenga un texto específico.
# Útil para encontrar cuándo se implementó algo.
git log --grep="login" --oneline

# La búsqueda es sensible a mayúsculas por defecto.
# Para ignorar mayúsculas/minúsculas, agrega -i:
git log --grep="login" -i --oneline

# ─────────────────────────────────────────────────────────────────────────────
# 7. Limitar la cantidad de commits
# ─────────────────────────────────────────────────────────────────────────────

# Muestra solo los últimos N commits:
git log -5 --oneline           # Últimos 5 commits
git log -10 --oneline          # Últimos 10 commits
git log -1                     # Solo el último commit (completo)

# ─────────────────────────────────────────────────────────────────────────────
# 8. Ver qué archivos cambió cada commit
# ─────────────────────────────────────────────────────────────────────────────

# --stat muestra un resumen de archivos modificados con líneas +/-.
git log --stat --oneline -5

# Salida:
#   a1b2c3d Agrega validación de formulario
#    src/form.js    | 45 +++++++++++++
#    src/validate.js | 23 ++++++++
#    2 files changed, 68 insertions(+)

# --name-only muestra solo los nombres de archivos cambiados (sin estadísticas).
git log --name-only --oneline -5

# --name-status muestra nombres + tipo de cambio (A=added, M=modified, D=deleted).
git log --name-status --oneline -5

# ─────────────────────────────────────────────────────────────────────────────
# 9. Formato personalizado (--format)
# ─────────────────────────────────────────────────────────────────────────────

# Puedes crear tu propio formato de salida con placeholders:
#   %H  → Hash completo
#   %h  → Hash abreviado
#   %an → Nombre del autor
#   %ae → Email del autor
#   %ad → Fecha del autor
#   %s  → Mensaje del commit (subject)

# Ejemplo: hash corto, autor y mensaje en una línea
git log --format="%h - %an: %s" -10

# Ejemplo: formato con fecha relativa
git log --format="%h %ar %s" -10

# ─────────────────────────────────────────────────────────────────────────────
# 10. Ver un commit específico
# ─────────────────────────────────────────────────────────────────────────────

# git show muestra los detalles completos de un commit: mensaje + diff.
git show a1b2c3d

# Ver solo el último commit:
git show HEAD

# Ver el penúltimo commit:
git show HEAD~1

# =============================================================================
# RESUMEN:
# - git log                            → Historial completo
# - git log --oneline                  → Una línea por commit
# - git log --graph --oneline --all    → Historial visual con ramas
# - git log --author="nombre"          → Filtrar por autor
# - git log --since="fecha"            → Filtrar por fecha
# - git log --grep="texto"             → Buscar en mensajes
# - git log -N                         → Limitar a N commits
# - git log --stat                     → Ver archivos cambiados
# - git show HASH                      → Detalle de un commit
# =============================================================================
