#!/bin/bash
# =============================================================================
# ARCHIVO: 02_crear_pull_request.sh
# TEMA: Paso a paso para crear un Pull Request
# =============================================================================
#
# Crear un Pull Request involucra trabajo tanto en la terminal (Git)
# como en la interfaz web de GitHub. Aquí verás ambos lados del proceso.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# PASO 1: CREAR UNA RAMA PARA TU CAMBIO
# ─────────────────────────────────────────────────────────────────────────────

# Antes de hacer cualquier cambio, crea una rama nueva desde main.
# NUNCA trabajes directamente en main si vas a crear un PR.

# Asegúrate de estar en main y actualizado
git checkout main
git pull origin main

# Crea una nueva rama con un nombre descriptivo
git checkout -b feature/agregar-login

# Convenciones de nombres para ramas:
# feature/nombre    → Nueva funcionalidad
# fix/nombre        → Corrección de bug
# hotfix/nombre     → Corrección urgente
# refactor/nombre   → Mejora de código
# docs/nombre       → Cambios en documentación

echo "========================================="
echo "  PASO 1: CREAR RAMA"
echo "========================================="
echo ""
echo "  git checkout main"
echo "  git pull origin main"
echo "  git checkout -b feature/agregar-login"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# PASO 2: HACER TUS CAMBIOS Y COMMITS
# ─────────────────────────────────────────────────────────────────────────────

# Trabaja en tu código normalmente. Haz commits frecuentes y descriptivos.

# Editar archivos...
# (aquí harías tus cambios de código)

# Agregar cambios al staging
git add src/auth/login.dart
git add src/auth/login_controller.dart

# Hacer commit con mensaje descriptivo
git commit -m "Agregar pantalla de login con validación de formulario"

# Puedes hacer múltiples commits en la misma rama
git add src/auth/auth_service.dart
git commit -m "Agregar servicio de autenticación con Firebase"

git add test/auth/login_test.dart
git commit -m "Agregar tests para la pantalla de login"

echo ""
echo "========================================="
echo "  PASO 2: CAMBIOS Y COMMITS"
echo "========================================="
echo ""
echo "  Haz commits frecuentes con mensajes descriptivos."
echo "  Cada commit debe representar un cambio lógico."
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# PASO 3: PUSH DE LA RAMA AL REMOTO
# ─────────────────────────────────────────────────────────────────────────────

# Sube tu rama a GitHub. La primera vez necesitas usar -u para
# establecer la relación entre la rama local y la remota.

git push -u origin feature/agregar-login

# -u (o --set-upstream) crea la relación local ↔ remoto.
# Después del primer push, solo necesitas:
git push

# Cuando hagas push, GitHub te mostrará un enlace en la terminal
# para crear el Pull Request directamente. Algo como:
# remote: Create a pull request for 'feature/agregar-login' on GitHub by visiting:
# remote: https://github.com/usuario/repo/pull/new/feature/agregar-login

echo ""
echo "========================================="
echo "  PASO 3: PUSH AL REMOTO"
echo "========================================="
echo ""
echo "  git push -u origin feature/agregar-login"
echo ""
echo "  GitHub te dará un enlace para crear el PR."
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# PASO 4: CREAR EL PULL REQUEST EN GITHUB
# ─────────────────────────────────────────────────────────────────────────────

# Hay varias formas de crear el PR:

# OPCIÓN A: Desde la interfaz web de GitHub
# 1. Ve a tu repositorio en GitHub
# 2. Verás un banner amarillo: "feature/agregar-login had recent pushes"
# 3. Haz clic en "Compare & pull request"
# 4. Llena el formulario del PR

# OPCIÓN B: Desde la pestaña "Pull Requests"
# 1. Ve a la pestaña "Pull Requests" del repositorio
# 2. Haz clic en "New pull request"
# 3. Selecciona la rama base (main) y la rama de comparación (tu rama)
# 4. Haz clic en "Create pull request"

# OPCIÓN C: Usando GitHub CLI (gh)
gh pr create \
  --title "Agregar sistema de autenticación con login" \
  --body "## Resumen
- Agrega pantalla de login con validación
- Integra Firebase Authentication
- Incluye tests unitarios

## Cambios principales
- \`src/auth/login.dart\` — Pantalla de login
- \`src/auth/auth_service.dart\` — Servicio de autenticación
- \`test/auth/login_test.dart\` — Tests

## Cómo probar
1. Ejecutar la app
2. Ir a la pantalla de login
3. Probar con credenciales válidas e inválidas

Fixes #42" \
  --base main

echo ""
echo "========================================="
echo "  PASO 4: CREAR EL PR"
echo "========================================="
echo ""
echo "  Opción A: Desde el banner en GitHub"
echo "  Opción B: Pestaña Pull Requests → New"
echo "  Opción C: gh pr create (GitHub CLI)"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# PASO 5: LLENAR EL FORMULARIO DEL PR
# ─────────────────────────────────────────────────────────────────────────────

# El formulario del PR tiene estos campos:

echo "========================================="
echo "  CAMPOS DEL PR"
echo "========================================="
echo ""
echo "  TÍTULO: Resumen corto y claro"
echo "    Bueno: 'Agregar autenticación con Google'"
echo "    Malo:  'Cambios', 'Update', 'Fix'"
echo ""
echo "  DESCRIPCIÓN: Explicación detallada"
echo "    - Qué se cambió y por qué"
echo "    - Cómo probarlo"
echo "    - Screenshots (si hay cambios UI)"
echo "    - Issues relacionados (Fixes #42)"
echo ""
echo "  REVISORES: Quién debe revisar el código"
echo "  ASIGNADOS: Quién es responsable del PR"
echo "  ETIQUETAS: bug, enhancement, documentation..."
echo "  PROYECTO: En qué tablero aparece"
echo "  MILESTONE: A qué versión pertenece"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# CREAR UN DRAFT PULL REQUEST
# ─────────────────────────────────────────────────────────────────────────────

# Si tu trabajo aún no está terminado pero quieres compartirlo:

# Desde la interfaz web:
# En vez de "Create pull request", haz clic en la flecha del botón
# y selecciona "Create draft pull request"

# Desde GitHub CLI:
gh pr create \
  --title "WIP: Agregar sistema de autenticación" \
  --body "Trabajo en progreso. No mergear aún." \
  --draft

# Cuando esté listo, cambia el estado:
gh pr ready

echo ""
echo "========================================="
echo "  DRAFT PR"
echo "========================================="
echo ""
echo "  gh pr create --draft     → Crear como borrador"
echo "  gh pr ready              → Marcar como listo"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# EJEMPLO COMPLETO: FLUJO DE CREAR UN PR
# ─────────────────────────────────────────────────────────────────────────────

echo ""
echo "========================================="
echo "  FLUJO COMPLETO"
echo "========================================="
echo ""
echo "  # 1. Crear rama"
echo "  git checkout -b feature/mi-cambio"
echo ""
echo "  # 2. Hacer cambios y commits"
echo "  git add ."
echo "  git commit -m 'Agregar funcionalidad X'"
echo ""
echo "  # 3. Push"
echo "  git push -u origin feature/mi-cambio"
echo ""
echo "  # 4. Crear PR"
echo "  gh pr create --title 'Agregar funcionalidad X'"
echo ""
echo "  # 5. Esperar revisión y feedback"
echo "  # 6. Hacer ajustes si necesario"
echo "  # 7. Merge cuando sea aprobado"
echo ""
