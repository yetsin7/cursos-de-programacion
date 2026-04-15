#!/bin/bash
# =============================================================================
# ARCHIVO: 03_git_commit.sh
# TEMA: Crear commits y escribir buenos mensajes
# =============================================================================
#
# Un commit es una "fotografía" permanente del estado de tu proyecto en un
# momento dado. Es la unidad fundamental del historial en Git. Cada commit
# tiene un identificador único (hash), un autor, una fecha y un mensaje
# que describe los cambios realizados.
#
# Aprender a hacer buenos commits es una de las habilidades más valiosas
# que puedes desarrollar como programador.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# 1. Crear un commit básico
# ─────────────────────────────────────────────────────────────────────────────

# Primero debes tener archivos en el staging area (ver 02_git_add.sh).
# Luego usas git commit para crear el commit.

# La forma más común: commit con mensaje en línea usando -m
git commit -m "Agrega formulario de registro de usuarios"

# El mensaje va entre comillas (simples o dobles).
# Git creará el commit con todos los archivos que estén en staging.

# ─────────────────────────────────────────────────────────────────────────────
# 2. Commit con editor de texto
# ─────────────────────────────────────────────────────────────────────────────

# Si ejecutas git commit sin -m, Git abrirá tu editor de texto configurado
# (vim, nano, VS Code, etc.) para que escribas el mensaje.
git commit

# Esto es útil para mensajes largos con cuerpo explicativo.
# El editor te mostrará algo así:
#
#   (línea vacía para el título del commit)
#   # Please enter the commit message for your changes.
#   # Lines starting with '#' will be ignored.
#   #
#   # On branch main
#   # Changes to be committed:
#   #   modified:   src/login.js
#
# Escribe tu mensaje, guarda y cierra el editor para crear el commit.

# Para configurar VS Code como editor de Git:
# git config --global core.editor "code --wait"

# ─────────────────────────────────────────────────────────────────────────────
# 3. Commit con mensaje de título y cuerpo
# ─────────────────────────────────────────────────────────────────────────────

# Puedes usar -m dos veces para agregar título Y cuerpo al commit.
# El primer -m es el título, el segundo es el cuerpo descriptivo.
git commit -m "Corrige error en cálculo de impuestos" -m "El IVA se aplicaba
dos veces cuando el usuario tenía descuento activo. Se corrigió la lógica
en la función calcularTotal() para verificar el descuento antes del impuesto."

# El cuerpo es opcional pero MUY valioso para cambios complejos.
# Ayuda a tu yo del futuro (y a tu equipo) a entender POR QUÉ se hizo el cambio.

# ─────────────────────────────────────────────────────────────────────────────
# 4. Atajo: agregar y hacer commit en un solo paso
# ─────────────────────────────────────────────────────────────────────────────

# git commit -am combina git add -u + git commit -m en un solo comando.
# Agrega todos los archivos MODIFICADOS (no nuevos) y hace commit.
git commit -am "Actualiza estilos del botón de inicio de sesión"

# ⚠️ IMPORTANTE: -am NO agrega archivos nuevos (untracked).
# Si creaste archivos nuevos, necesitas hacer git add primero.
# Solo funciona con archivos que Git ya está rastreando.

# ─────────────────────────────────────────────────────────────────────────────
# 5. Modificar el último commit (amend)
# ─────────────────────────────────────────────────────────────────────────────

# Si olvidaste incluir un archivo o tu mensaje tiene un error, puedes
# corregir el ÚLTIMO commit con --amend.

# Caso 1: Corregir el mensaje del último commit
git commit --amend -m "Corrige validación de email (no solo username)"

# Caso 2: Agregar archivos olvidados al último commit
git add archivo_olvidado.txt
git commit --amend --no-edit    # --no-edit mantiene el mensaje original

# ⚠️ PRECAUCIÓN: --amend reescribe el último commit (cambia su hash).
# NUNCA uses --amend en commits que ya hayas subido con git push.
# Esto causará problemas a otros colaboradores.

# ─────────────────────────────────────────────────────────────────────────────
# 6. Convenciones para mensajes de commit
# ─────────────────────────────────────────────────────────────────────────────

# REGLA 1: Usa el imperativo en el título
#   ✅ "Agrega validación de contraseña"
#   ❌ "Agregué validación de contraseña"
#   ❌ "Agregando validación de contraseña"
#
# Piensa en completar la frase: "Si se aplica, este commit..."
# → "Si se aplica, este commit AGREGA validación de contraseña" ✅

# REGLA 2: Máximo 50 caracteres en el título
#   ✅ "Corrige error de login con Google"
#   ❌ "Corrige el error que ocurría cuando el usuario intentaba iniciar sesión
#       usando su cuenta de Google y la API devolvía un token expirado"

# REGLA 3: Separa título del cuerpo con una línea en blanco
#   Agrega sistema de notificaciones push
#
#   Se implementa Firebase Cloud Messaging para enviar
#   notificaciones en tiempo real a los usuarios.
#   Incluye configuración para Android e iOS.

# REGLA 4: El cuerpo explica el QUÉ y el POR QUÉ, no el CÓMO
#   El código ya dice el cómo. El mensaje debe decir por qué se hizo.

# ─────────────────────────────────────────────────────────────────────────────
# 7. Conventional Commits (estándar popular)
# ─────────────────────────────────────────────────────────────────────────────

# Conventional Commits es una convención que estructura los mensajes así:
#   tipo(alcance): descripción
#
# Tipos más comunes:
#   feat:     Nueva funcionalidad
#   fix:      Corrección de error
#   docs:     Cambios en documentación
#   style:    Formato (no afecta la lógica del código)
#   refactor: Refactorización (no agrega función ni corrige error)
#   test:     Agregar o corregir tests
#   chore:    Tareas de mantenimiento (deps, config, etc.)

# Ejemplos:
git commit -m "feat(auth): agrega inicio de sesión con Google"
git commit -m "fix(cart): corrige cálculo de descuento en carrito"
git commit -m "docs(readme): actualiza instrucciones de instalación"
git commit -m "refactor(api): extrae lógica de validación a middleware"
git commit -m "test(login): agrega tests para flujo de recuperación"

# ─────────────────────────────────────────────────────────────────────────────
# 8. Commits vacíos (casos especiales)
# ─────────────────────────────────────────────────────────────────────────────

# Puedes crear un commit sin cambios en archivos. Útil para disparar CI/CD
# o marcar un punto en el historial.
git commit --allow-empty -m "chore: dispara pipeline de CI"

# =============================================================================
# RESUMEN:
# - git commit -m "msg"       → Commit con mensaje en línea
# - git commit                → Commit con editor de texto
# - git commit -am "msg"      → Add + commit (solo archivos ya rastreados)
# - git commit --amend        → Corregir el último commit
# - git commit --allow-empty  → Commit sin cambios en archivos
# - Usa imperativo, máximo 50 chars, explica el por qué
# - Conventional Commits: tipo(alcance): descripción
# =============================================================================
