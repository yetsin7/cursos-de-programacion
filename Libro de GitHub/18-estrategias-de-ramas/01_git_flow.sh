# =============================================================================
# ARCHIVO: 01_git_flow.sh
# TEMA: Git Flow — El modelo clásico de ramificación
# =============================================================================
#
# Git Flow fue propuesto por Vincent Driessen en 2010 y se convirtió en
# el estándar para proyectos con releases programados (apps móviles,
# software empresarial, videojuegos, etc.)
#
# Es la estrategia más compleja pero también la más estructurada.
# Define 5 tipos de ramas, cada una con un propósito específico.
#
# IMPORTANTE: No ejecutes este archivo completo. Lee cada sección y ejecuta
# los comandos uno por uno en tu terminal.
# =============================================================================


# --- SECCIÓN 1: Las 5 ramas de Git Flow ---
#
# 1. main (o master)
#    - Contiene SOLO código de producción estable
#    - Cada commit en main corresponde a una versión publicada
#    - Nunca se hace commit directamente aquí
#    - Se etiqueta con la versión (v1.0.0, v1.1.0, etc.)
#
# 2. develop
#    - Rama de integración donde se acumula el trabajo
#    - Aquí se fusionan todas las features terminadas
#    - Es la rama "base" para crear nuevas features
#    - Siempre tiene el código más reciente (pero no necesariamente estable)
#
# 3. feature/*
#    - Una rama por cada nueva funcionalidad
#    - Se crean desde develop y se fusionan de vuelta a develop
#    - Nomenclatura: feature/nombre-de-la-funcionalidad
#    - Se eliminan después de fusionar
#
# 4. release/*
#    - Se crea cuando develop tiene suficientes features para una nueva versión
#    - Aquí se hacen los últimos ajustes: corrección de bugs, documentación
#    - Se fusiona a main (con tag de versión) y a develop
#    - Nomenclatura: release/1.2.0
#
# 5. hotfix/*
#    - Para correcciones urgentes en producción
#    - Se crea desde main y se fusiona a main y develop
#    - Es la única rama que nace de main (además de release)
#    - Nomenclatura: hotfix/corregir-crash-login


# --- SECCIÓN 2: Diagrama visual ---
#
#  main:     ──●──────────────────●───────────●──
#              │                  ↑            ↑
#  release:   │            ──●──●┘      ──●──●┘
#              │            ↑              ↑
#  develop:  ──●──●──●──●──●──●──●──●──●──●──●──
#                  ↑     ↑        ↑     ↑
#  feature:       ──●──●┘        ──●──●┘
#
#  hotfix:   (cuando hay bug urgente en main)
#  main:     ──●──────●──
#              │      ↑
#  hotfix:    └──●──●┘ → también se fusiona a develop


# --- SECCIÓN 3: Configurar Git Flow desde cero ---

# Crear un repositorio de práctica
mkdir git-flow-practica
cd git-flow-practica
git init

# Crear el primer commit en main
echo "# Mi Proyecto" > README.md
git add README.md
git commit -m "feat: commit inicial"

# Crear la rama develop a partir de main
git checkout -b develop

# Ahora tienes las dos ramas permanentes: main y develop


# --- SECCIÓN 4: Crear y trabajar con Feature branches ---

# Asegúrate de estar en develop
git checkout develop

# Crear una rama de feature
git checkout -b feature/login-usuario

# Trabajar en la feature (simularemos con archivos)
echo "función de login" > login.txt
git add login.txt
git commit -m "feat: agregar pantalla de login"

echo "validación de email" >> login.txt
git add login.txt
git commit -m "feat: agregar validación de email en login"

# Cuando la feature está terminada, fusionar a develop
git checkout develop
git merge --no-ff feature/login-usuario
# --no-ff crea un commit de merge explícito (recomendado en Git Flow)

# Eliminar la rama de feature (ya no se necesita)
git branch -d feature/login-usuario


# --- SECCIÓN 5: Crear una rama de Release ---

# Cuando develop tiene suficientes features para una versión nueva
git checkout develop
git checkout -b release/1.0.0

# En la rama de release, solo se hacen:
#   - Correcciones de bugs menores
#   - Actualización de versión en archivos de configuración
#   - Actualización de documentación

echo "versión 1.0.0" > VERSION.txt
git add VERSION.txt
git commit -m "chore: establecer versión 1.0.0"

# Cuando la release está lista, fusionar a main
git checkout main
git merge --no-ff release/1.0.0
git tag -a v1.0.0 -m "Versión 1.0.0"

# También fusionar a develop (para que develop tenga los fixes de la release)
git checkout develop
git merge --no-ff release/1.0.0

# Eliminar la rama de release
git branch -d release/1.0.0


# --- SECCIÓN 6: Crear un Hotfix ---

# Un bug crítico en producción necesita corrección inmediata
git checkout main
git checkout -b hotfix/crash-en-login

# Corregir el bug
echo "fix aplicado" > hotfix.txt
git add hotfix.txt
git commit -m "fix: corregir crash al hacer login sin internet"

# Fusionar a main
git checkout main
git merge --no-ff hotfix/crash-en-login
git tag -a v1.0.1 -m "Versión 1.0.1 - hotfix"

# Fusionar a develop también
git checkout develop
git merge --no-ff hotfix/crash-en-login

# Eliminar la rama de hotfix
git branch -d hotfix/crash-en-login


# --- SECCIÓN 7: Git Flow con la herramienta git-flow ---
#
# Existe una extensión de Git llamada "git-flow" que automatiza todos
# estos comandos. La instalas y luego usas comandos simplificados:

# Inicializar git-flow en un repositorio
git flow init
# Te pedirá confirmar los nombres de las ramas (main, develop, etc.)

# Crear una feature
git flow feature start login-usuario
# (equivale a: git checkout -b feature/login-usuario develop)

# Terminar una feature
git flow feature finish login-usuario
# (equivale a: merge a develop + eliminar rama)

# Crear una release
git flow release start 1.0.0

# Terminar una release
git flow release finish 1.0.0
# (equivale a: merge a main + tag + merge a develop + eliminar rama)

# Crear un hotfix
git flow hotfix start crash-login

# Terminar un hotfix
git flow hotfix finish crash-login


# --- SECCIÓN 8: ¿Cuándo usar Git Flow? ---
#
# USAR Git Flow cuando:
#   ✓ Tienes releases programados (cada 2 semanas, cada mes, etc.)
#   ✓ Necesitas mantener múltiples versiones en producción
#   ✓ Tu equipo es mediano-grande (5+ personas)
#   ✓ Desarrollas apps móviles (necesitas versiones específicas por tienda)
#   ✓ El proceso de QA es largo y formal
#
# NO usar Git Flow cuando:
#   ✗ Haces despliegue continuo (múltiples deploys al día)
#   ✗ Tu equipo es pequeño (1-3 personas)
#   ✗ Es un proyecto web simple con deploy automático
#   ✗ La complejidad adicional no se justifica


# --- SECCIÓN 9: Limpiar ---
cd ..
rm -rf git-flow-practica


# =============================================================================
# RESUMEN:
# - Git Flow usa 5 tipos de ramas: main, develop, feature, release, hotfix
# - main = código de producción, develop = código de integración
# - Features nacen de develop y vuelven a develop
# - Releases nacen de develop y van a main + develop
# - Hotfixes nacen de main y van a main + develop
# - Usa --no-ff para mantener el historial claro
# - La herramienta git-flow automatiza todo el flujo
# - Ideal para proyectos con releases programados
# =============================================================================
