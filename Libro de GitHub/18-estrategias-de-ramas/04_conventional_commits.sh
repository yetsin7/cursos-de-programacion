# =============================================================================
# ARCHIVO: 04_conventional_commits.sh
# TEMA: Conventional Commits y Versionado Semántico
# =============================================================================
#
# Conventional Commits es un estándar para escribir mensajes de commit
# que sean legibles tanto por humanos como por máquinas. Permite
# automatizar changelogs, versionado y releases.
#
# Combinado con Semantic Versioning (SemVer), crea un sistema poderoso
# donde los mensajes de commit determinan la siguiente versión del software.
#
# IMPORTANTE: No ejecutes este archivo completo. Lee cada sección y ejecuta
# los comandos uno por uno en tu terminal.
# =============================================================================


# --- SECCIÓN 1: Formato de Conventional Commits ---
#
# Estructura básica:
#
#   <tipo>[alcance opcional]: <descripción>
#
#   [cuerpo opcional]
#
#   [pie opcional]
#
# Ejemplos:
#   feat: agregar modo oscuro
#   fix: corregir cálculo de impuestos
#   docs: actualizar guía de instalación
#   feat(auth): implementar login con Google
#   fix(cart): corregir total cuando se elimina un producto


# --- SECCIÓN 2: Tipos de commits ---
#
# Los tipos más comunes (ordenados por frecuencia de uso):
#
# feat:     Nueva funcionalidad para el usuario
#           Ejemplo: feat: agregar filtro de búsqueda por categoría
#
# fix:      Corrección de un bug
#           Ejemplo: fix: corregir crash al abrir la app sin internet
#
# docs:     Cambios en documentación (README, guías, comentarios)
#           Ejemplo: docs: agregar sección de instalación al README
#
# style:    Cambios de formato (espacios, comas, punto y coma, etc.)
#           NO cambian la lógica del código
#           Ejemplo: style: formatear archivo según ESLint
#
# refactor: Cambio de código que no agrega funcionalidad ni corrige bugs
#           Ejemplo: refactor: extraer lógica de validación a un servicio
#
# perf:     Cambio que mejora el rendimiento
#           Ejemplo: perf: optimizar consulta de productos con caché
#
# test:     Agregar o corregir pruebas (tests)
#           Ejemplo: test: agregar tests para el servicio de autenticación
#
# build:    Cambios en el sistema de build o dependencias
#           Ejemplo: build: actualizar Flutter a la versión 3.19
#
# ci:       Cambios en la configuración de CI/CD
#           Ejemplo: ci: agregar workflow de deploy automático
#
# chore:    Tareas de mantenimiento que no cambian código de producción
#           Ejemplo: chore: actualizar .gitignore


# --- SECCIÓN 3: Alcance (scope) opcional ---
#
# El alcance indica QUÉ parte del proyecto se ve afectada.
# Va entre paréntesis después del tipo:
#
#   feat(auth): implementar login con huella digital
#   fix(cart): corregir precio cuando hay descuento
#   docs(api): documentar endpoint de usuarios
#   refactor(database): migrar de SQLite a Hive
#
# Alcances comunes:
#   auth, cart, profile, settings, api, database, ui, navigation


# --- SECCIÓN 4: Breaking Changes (cambios que rompen compatibilidad) ---
#
# Si tu commit introduce un cambio que rompe la compatibilidad con
# versiones anteriores, debes indicarlo con:
#
# Opción 1: Signo de exclamación después del tipo
#   feat!: cambiar formato de respuesta del API
#   refactor(auth)!: cambiar parámetros del método de login
#
# Opción 2: Footer "BREAKING CHANGE:"
#   feat: cambiar formato de respuesta del API
#
#   BREAKING CHANGE: el campo "user_name" ahora se llama "username"
#
# Los breaking changes incrementan la versión MAJOR en SemVer.


# --- SECCIÓN 5: Semantic Versioning (SemVer) ---
#
# SemVer usa el formato: MAJOR.MINOR.PATCH
#
#   Ejemplo: 2.4.1
#            │ │ └── PATCH: correcciones de bugs (fix:)
#            │ └──── MINOR: nuevas funcionalidades compatibles (feat:)
#            └────── MAJOR: cambios que rompen compatibilidad (BREAKING CHANGE)
#
# ¿Cuándo incrementar cada número?
#
#   PATCH (2.4.1 → 2.4.2):
#     - Correcciones de bugs
#     - Commits tipo: fix
#
#   MINOR (2.4.1 → 2.5.0):
#     - Nuevas funcionalidades que NO rompen nada existente
#     - Commits tipo: feat
#     - Al incrementar MINOR, PATCH vuelve a 0
#
#   MAJOR (2.4.1 → 3.0.0):
#     - Cambios que rompen compatibilidad
#     - Commits con BREAKING CHANGE o !
#     - Al incrementar MAJOR, MINOR y PATCH vuelven a 0


# --- SECCIÓN 6: Ejemplos prácticos de commits ---

# Crear repositorio de práctica
mkdir conventional-commits-practica
cd conventional-commits-practica
git init

echo "# Mi App" > README.md
git add README.md
git commit -m "chore: commit inicial del proyecto"

# Agregar una nueva funcionalidad
echo "función de login" > auth.txt
git add auth.txt
git commit -m "feat(auth): implementar pantalla de login con email y contraseña"

# Corregir un bug
echo "login corregido" > auth.txt
git add auth.txt
git commit -m "fix(auth): corregir validación de email que aceptaba formatos inválidos"

# Actualizar documentación
echo "## Instalación" >> README.md
git add README.md
git commit -m "docs: agregar sección de instalación al README"

# Refactorizar código
echo "auth refactorizado" > auth.txt
git add auth.txt
git commit -m "refactor(auth): extraer lógica de validación a un servicio separado"

# Commit con cuerpo descriptivo
echo "caché implementado" > cache.txt
git add cache.txt
git commit -m "perf(api): implementar caché para consultas de productos

Se agregó un sistema de caché con TTL de 5 minutos para las consultas
más frecuentes al API. Esto reduce el tiempo de respuesta promedio
de 800ms a 150ms en la pantalla de productos."

# Commit con breaking change
echo "api v2" > api.txt
git add api.txt
git commit -m "feat(api)!: cambiar formato de respuesta de usuarios

BREAKING CHANGE: el campo 'user_name' ahora se llama 'username'.
Los clientes que consuman este endpoint deben actualizar su código."


# --- SECCIÓN 7: Ver el historial con commits convencionales ---

# El historial se ve ordenado y profesional
git log --oneline

# Filtrar por tipo de commit
git log --oneline --grep="^feat"
git log --oneline --grep="^fix"
git log --oneline --grep="^docs"

# Esto facilita generar changelogs automáticamente


# --- SECCIÓN 8: Herramientas para Conventional Commits ---
#
# commitlint — Valida que los mensajes de commit sigan el formato
#   https://commitlint.js.org
#
# commitizen — Asistente interactivo para escribir commits
#   https://commitizen-tools.github.io/commitizen/
#
# standard-version — Genera changelogs y versiones automáticamente
#   https://github.com/conventional-changelog/standard-version
#
# semantic-release — Automatiza el release completo basado en commits
#   https://semantic-release.gitbook.io
#
# En proyectos de Node.js, puedes instalar commitlint como hook:
#   npm install --save-dev @commitlint/cli @commitlint/config-conventional
#   echo "module.exports = {extends: ['@commitlint/config-conventional']}" > commitlint.config.js


# --- SECCIÓN 9: Limpiar ---
cd ..
rm -rf conventional-commits-practica


# =============================================================================
# RESUMEN:
# - Conventional Commits: formato estándar para mensajes de commit
# - Formato: tipo(alcance): descripción
# - Tipos principales: feat, fix, docs, style, refactor, perf, test, ci, chore
# - SemVer: MAJOR.MINOR.PATCH
# - fix → incrementa PATCH, feat → incrementa MINOR
# - BREAKING CHANGE → incrementa MAJOR
# - Herramientas como commitlint y semantic-release automatizan el proceso
# =============================================================================
