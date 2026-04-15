# =============================================================================
# ARCHIVO: 05_proteger_ramas.sh
# TEMA: Reglas de protección de ramas en GitHub
# =============================================================================
#
# Las reglas de protección de ramas (branch protection rules) evitan que
# se hagan cambios directos a ramas importantes como main o develop.
# Obligan a que todo cambio pase por un Pull Request con revisiones
# y pruebas aprobadas.
#
# Esto es FUNDAMENTAL para cualquier equipo profesional.
#
# IMPORTANTE: Este archivo combina explicaciones teóricas con comandos
# de GitHub CLI. La configuración principal se hace desde la web de GitHub.
# =============================================================================


# --- SECCIÓN 1: ¿Por qué proteger ramas? ---
#
# Sin protección de ramas, cualquier persona con acceso puede:
#   - Hacer push directo a main (sin revisión de código)
#   - Hacer force push y sobrescribir el historial
#   - Fusionar PRs sin aprobación
#   - Eliminar ramas importantes
#
# Con protección de ramas, puedes exigir:
#   - Que todo cambio pase por un PR
#   - Que el PR tenga al menos N aprobaciones
#   - Que pasen las pruebas automáticas (CI)
#   - Que la rama esté actualizada con main
#   - Que los commits estén firmados
#   - Que nadie pueda hacer force push


# --- SECCIÓN 2: Configurar protección desde la web de GitHub ---
#
# Ruta: Settings → Branches → Add branch protection rule
#
# Configuraciones más importantes:
#
# 1. "Branch name pattern"
#    - Escribe "main" para proteger solo main
#    - Escribe "release/*" para proteger todas las ramas de release
#    - Puedes usar wildcards: "develop", "main", "release/*"
#
# 2. "Require a pull request before merging"
#    ✓ Actívala SIEMPRE para ramas de producción
#    - "Required number of approvals": mínimo 1 (recomendado 2 en equipos grandes)
#    - "Dismiss stale pull request approvals when new commits are pushed":
#      invalida aprobaciones si se agregan nuevos commits
#    - "Require review from Code Owners": exige aprobación de los dueños del código
#
# 3. "Require status checks to pass before merging"
#    ✓ Exige que CI pase antes de poder fusionar
#    - Selecciona los checks específicos que deben pasar
#    - "Require branches to be up to date": la rama debe estar actualizada con main
#
# 4. "Require signed commits"
#    ✓ Exige que todos los commits estén firmados con GPG
#    - Esto verifica la identidad del autor del commit
#
# 5. "Require linear history"
#    ✓ No permite merge commits — solo squash o rebase
#    - Mantiene el historial limpio y lineal
#
# 6. "Do not allow bypassing the above settings"
#    ✓ Ni siquiera los administradores pueden saltarse las reglas
#
# 7. "Restrict who can push to matching branches"
#    ✓ Define quién puede hacer push directo (normalmente nadie)
#
# 8. "Allow force pushes" → NUNCA activar en main
#    ✗ Force push puede destruir el historial
#
# 9. "Allow deletions" → NUNCA activar en main
#    ✗ Evita que alguien elimine la rama principal


# --- SECCIÓN 3: Configurar con GitHub CLI ---

# Ver las reglas de protección actuales de un repositorio
gh api repos/OWNER/REPO/branches/main/protection 2>/dev/null

# Nota: La configuración completa de branch protection rules se hace
# mejor desde la interfaz web porque tiene muchas opciones anidadas.
# Sin embargo, puedes usar la API de GitHub para automatizarlo.


# --- SECCIÓN 4: Rulesets (la nueva forma de proteger ramas) ---
#
# GitHub introdujo "Rulesets" como la evolución de branch protection rules.
# Los rulesets son más flexibles y se pueden aplicar a nivel de organización.
#
# Ruta: Settings → Rules → Rulesets → New ruleset
#
# Ventajas de Rulesets sobre Branch Protection Rules:
#   - Se pueden aplicar a múltiples repositorios desde la organización
#   - Tienen modo "evaluate" para probar reglas sin aplicarlas
#   - Permiten excepciones más granulares (por equipo, por rol)
#   - Se pueden importar/exportar como JSON
#
# Las reglas disponibles son similares:
#   - Restrict creations/deletions
#   - Require linear history
#   - Require pull request (con aprobaciones)
#   - Require status checks
#   - Require signed commits
#   - Block force pushes


# --- SECCIÓN 5: CODEOWNERS — Dueños del código ---
#
# El archivo CODEOWNERS define quién es responsable de cada parte del código.
# Cuando alguien abre un PR que modifica esos archivos, los "code owners"
# son asignados automáticamente como revisores.

# Crear el archivo CODEOWNERS (va en la raíz o en .github/)
# Ejemplo de contenido:

# Estos usuarios son dueños de todo el repositorio
# * @usuario-principal @lider-equipo

# El equipo de frontend es dueño de los archivos de UI
# /src/ui/ @equipo-frontend

# El equipo de backend es dueño de la API
# /src/api/ @equipo-backend

# Un usuario específico es dueño de la documentación
# /docs/ @responsable-docs

# Los archivos de configuración tienen un dueño especial
# *.yml @devops-lead
# *.yaml @devops-lead

# El archivo se interpreta de arriba a abajo.
# La última coincidencia gana (como .gitignore).


# --- SECCIÓN 6: Configuración recomendada para equipos ---
#
# EQUIPO PEQUEÑO (1-3 personas):
#   - Proteger main: requerir PR con 1 aprobación
#   - Requerir que CI pase
#   - No permitir force push a main
#
# EQUIPO MEDIANO (4-10 personas):
#   - Proteger main y develop
#   - Requerir PR con 2 aprobaciones
#   - Requerir que CI pase
#   - Invalidar aprobaciones al agregar commits
#   - Requerir historial lineal
#   - Configurar CODEOWNERS
#
# EQUIPO GRANDE (10+ personas):
#   - Todo lo anterior más:
#   - Requerir commits firmados
#   - Usar Rulesets a nivel de organización
#   - Requerir revisión de Code Owners
#   - No permitir bypass ni a administradores


# --- SECCIÓN 7: ¿Qué pasa cuando intentas saltarte las reglas? ---
#
# Si intentas hacer push directo a una rama protegida:
#   $ git push origin main
#   remote: error: GH006: Protected branch update failed
#   remote: error: Required status check "ci/tests" is expected.
#
# Si intentas fusionar un PR sin aprobaciones:
#   GitHub mostrará un mensaje de error y el botón de merge estará deshabilitado.
#
# Si intentas hacer force push:
#   $ git push --force origin main
#   remote: error: Cannot force-push to this protected branch.
#
# Esto es exactamente lo que queremos: proteger el código de errores humanos.


# =============================================================================
# RESUMEN:
# - Las reglas de protección evitan cambios directos a ramas importantes
# - Configuración mínima: requerir PR + aprobaciones + CI
# - CODEOWNERS asigna revisores automáticamente por área de código
# - Rulesets es la evolución de branch protection rules
# - Nunca permitas force push ni eliminación de main
# - Ajusta la configuración al tamaño de tu equipo
# =============================================================================
