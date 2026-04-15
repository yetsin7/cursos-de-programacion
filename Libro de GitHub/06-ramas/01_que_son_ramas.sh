#!/bin/bash
# =============================================================================
# ARCHIVO: 01_que_son_ramas.sh
# TEMA: ¿Qué son las ramas en Git? Concepto y fundamentos
# =============================================================================
#
# Una rama en Git es un puntero liviano a un commit específico. Cuando creas
# una rama nueva, Git NO copia todos los archivos del proyecto. Simplemente
# crea un nuevo puntero que dice "yo estoy en este commit".
#
# Esto hace que crear ramas sea instantáneo y prácticamente gratis en
# términos de espacio en disco. Por eso Git fomenta usar ramas para TODO.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# 1. El modelo mental: commits son nodos, ramas son etiquetas
# ─────────────────────────────────────────────────────────────────────────────

# Cada commit en Git apunta a su commit padre (el anterior). Esto forma
# una cadena (una lista enlazada, técnicamente):
#
#   commit-1 ← commit-2 ← commit-3 ← commit-4
#
# Una RAMA es simplemente un nombre (etiqueta) que apunta a un commit:
#
#   commit-1 ← commit-2 ← commit-3 ← commit-4
#                                          ^
#                                         main
#
# Cuando haces un nuevo commit en main, el puntero main avanza:
#
#   commit-1 ← commit-2 ← commit-3 ← commit-4 ← commit-5
#                                                     ^
#                                                    main

# ─────────────────────────────────────────────────────────────────────────────
# 2. HEAD: ¿dónde estás ahora?
# ─────────────────────────────────────────────────────────────────────────────

# HEAD es un puntero especial que indica en qué rama estás trabajando.
# Normalmente, HEAD apunta a una rama (no directamente a un commit).

# Para ver a dónde apunta HEAD:
cat .git/HEAD
# Salida típica: ref: refs/heads/main
# Esto significa: HEAD apunta a la rama "main".

# Cuando cambias de rama (checkout/switch), HEAD se mueve a la nueva rama.
# Cuando haces un commit, la rama a la que apunta HEAD avanza un paso.

# ─────────────────────────────────────────────────────────────────────────────
# 3. La rama main (antes master)
# ─────────────────────────────────────────────────────────────────────────────

# Cuando inicializas un repositorio con git init, Git crea automáticamente
# una rama llamada "main" (o "master" en versiones antiguas).
#
# main NO es especial técnicamente: es una rama como cualquier otra.
# Sin embargo, por convención, main es la rama principal del proyecto
# donde vive el código estable y listo para producción.

# Puedes ver la rama actual con:
git branch
# El asterisco (*) indica la rama activa:
#   * main
#   feature/login
#   fix/bug-123

# ─────────────────────────────────────────────────────────────────────────────
# 4. Visualizando ramas con un ejemplo
# ─────────────────────────────────────────────────────────────────────────────

# Imaginemos este escenario:
#
# 1. Estás en main con 3 commits
# 2. Creas una rama "feature/login" desde main
# 3. Haces 2 commits en feature/login
# 4. Vuelves a main y haces 1 commit
#
# El resultado visual sería:
#
#          ── D ── E   (feature/login)
#         /
#   A ── B ── C ── F   (main)  ← HEAD
#
# Ambas ramas comparten los commits A, B, C.
# feature/login tiene D y E extras.
# main tiene F extra.
# HEAD está en main (es donde estamos trabajando).

# ─────────────────────────────────────────────────────────────────────────────
# 5. ¿Por qué son importantes las ramas?
# ─────────────────────────────────────────────────────────────────────────────

# CASO 1: Desarrollo de funcionalidades
# Cada nueva funcionalidad se desarrolla en su propia rama.
# Cuando está lista y probada, se fusiona de vuelta a main.
# Así main siempre tiene código estable.

# CASO 2: Corrección de errores urgentes
# Encuentras un bug en producción. Creas una rama desde main,
# corriges el bug, fusionas a main y despliegas. Rápido y limpio.

# CASO 3: Experimentación
# ¿Quieres probar una idea loca? Crea una rama. Si funciona, la fusionas.
# Si no, la eliminas. main nunca se enteró.

# CASO 4: Trabajo en equipo
# Juan trabaja en feature/login, María en feature/dashboard.
# Ambos trabajan al mismo tiempo sin pisarse. Cuando terminan,
# fusionan sus ramas a main.

# ─────────────────────────────────────────────────────────────────────────────
# 6. Internamente: cómo Git almacena las ramas
# ─────────────────────────────────────────────────────────────────────────────

# Las ramas son archivos de texto en .git/refs/heads/.
# Cada archivo contiene solo el hash del commit al que apunta la rama.

# Puedes verlo directamente:
ls .git/refs/heads/          # Lista todas las ramas locales
cat .git/refs/heads/main     # Muestra el hash del commit al que apunta main

# Esto confirma que una rama es literalmente un archivo de 40 caracteres (el hash).
# Por eso crear ramas es instantáneo: Git solo crea un archivo pequeñísimo.

# =============================================================================
# RESUMEN:
# - Una rama es un puntero ligero a un commit
# - HEAD indica en qué rama estás trabajando ahora
# - main es la rama principal por convención (no por magia)
# - Crear ramas es instantáneo y gratuito
# - Las ramas permiten: trabajo aislado, experimentación, colaboración
# - Internamente, cada rama es un archivo con un hash de 40 caracteres
# =============================================================================
