# =============================================================================
# ARCHIVO: 03_trunk_based.sh
# TEMA: Trunk-Based Development — Desarrollo basado en tronco
# =============================================================================
#
# Trunk-Based Development (TBD) es una estrategia donde todos los
# desarrolladores trabajan en una sola rama principal llamada "trunk"
# (que en Git es main). Las ramas de feature, si existen, son muy
# cortas (1-2 días máximo).
#
# Es la estrategia preferida por empresas como Google, Facebook y Netflix.
#
# IMPORTANTE: No ejecutes este archivo completo. Lee cada sección y ejecuta
# los comandos uno por uno en tu terminal.
# =============================================================================


# --- SECCIÓN 1: ¿Qué es Trunk-Based Development? ---
#
# La idea central es simple: TODOS hacen commit a una sola rama (main/trunk).
#
# Hay dos variantes:
#
# Variante 1: Commits directos a trunk (equipos pequeños, 1-3 personas)
#   - Los desarrolladores hacen commit directamente a main
#   - No hay ramas de feature
#   - Requiere disciplina extrema y buena cobertura de tests
#
# Variante 2: Ramas de vida corta (equipos grandes)
#   - Se crean ramas de feature, pero duran máximo 1-2 días
#   - Se fusionan rápidamente a main
#   - Cada PR es pequeño y enfocado
#
# EN AMBOS CASOS:
#   - main siempre debe estar en estado desplegable
#   - Los cambios se integran al menos una vez al día
#   - Se usa CI/CD para verificar que todo funciona


# --- SECCIÓN 2: Diagrama visual ---
#
# Variante 1 (commits directos):
#  main:  ──●──●──●──●──●──●──●──●──●──●──●──
#           A1  A2  B1  A3  B2  A4  B3  A5  B4
#           (A = desarrollador A, B = desarrollador B)
#
# Variante 2 (ramas cortas):
#  main:     ──●──────●──────●──────●──
#              │      ↑      ↑      ↑
#  short-1:   └──●──●┘      │      │
#  short-2:      └──●───────┘      │
#  short-3:         └──●──●───────┘
#
# Nota cómo las ramas son MUY cortas (1-3 commits máximo).


# --- SECCIÓN 3: Ejemplo práctico — Commits directos ---

# Crear repositorio de práctica
mkdir trunk-based-practica
cd trunk-based-practica
git init

echo "# App Trunk Based" > README.md
git add README.md
git commit -m "feat: commit inicial"

# En trunk-based puro, trabajas directamente en main
# Cada cambio es pequeño y atómico

echo "función A" > feature-a.txt
git add feature-a.txt
git commit -m "feat: agregar funcionalidad A básica"

echo "función A mejorada" > feature-a.txt
git add feature-a.txt
git commit -m "feat: mejorar funcionalidad A"

# Cada commit debe dejar main en un estado funcional.
# Si algo falla, se revierte inmediatamente.


# --- SECCIÓN 4: Ejemplo práctico — Ramas de vida corta ---

# Crear una rama de vida corta (máximo 1-2 días)
git checkout -b short/agregar-boton-login

# Hacer los cambios rápidamente (pocos commits)
echo "botón de login" > login-button.txt
git add login-button.txt
git commit -m "feat: agregar botón de login"

# Fusionar de vuelta a main lo antes posible
git checkout main
git merge --no-ff short/agregar-boton-login
git branch -d short/agregar-boton-login

# La rama existió por minutos u horas, no días o semanas.


# --- SECCIÓN 5: Feature Flags (Banderas de funcionalidad) ---
#
# ¿Cómo puedes trabajar en una feature grande si todo va a main?
# La respuesta: Feature Flags.
#
# Un feature flag es un interruptor en el código que activa o desactiva
# una funcionalidad. Te permite tener código incompleto en main sin
# que los usuarios lo vean.
#
# Ejemplo conceptual en pseudocódigo:
#
#   if (featureFlags.darkModeEnabled) {
#     mostrarModoOscuro();
#   } else {
#     mostrarModoClaro();
#   }
#
# Ventajas de feature flags:
#   - El código está en main pero no se ejecuta hasta que lo actives
#   - Puedes activar features para ciertos usuarios (beta testers)
#   - Si algo falla, desactivas el flag sin hacer rollback
#   - Múltiples desarrolladores pueden trabajar en la misma feature
#
# Herramientas populares para feature flags:
#   - LaunchDarkly
#   - Unleash
#   - ConfigCat
#   - Firebase Remote Config (para apps móviles)


# --- SECCIÓN 6: Integración continua es OBLIGATORIA ---
#
# Trunk-Based Development NO funciona sin CI/CD. Necesitas:
#
# 1. Tests automatizados que se ejecuten en cada commit/PR
#    - Tests unitarios
#    - Tests de integración
#    - Tests end-to-end (los más críticos)
#
# 2. Build automático
#    - Cada commit compila correctamente
#    - No se introducen errores de compilación
#
# 3. Deploy automático (opcional pero recomendado)
#    - Si pasa CI, se despliega automáticamente
#    - Canary deployments o blue-green deployments
#
# Sin CI/CD, hacer commit directo a main es una receta para el desastre.


# --- SECCIÓN 7: Reglas de Trunk-Based Development ---
#
# 1. INTEGRAR al menos una vez al día
#    No acumules cambios en tu máquina por días.
#    Mientras más tiempo pases sin integrar, más conflictos tendrás.
#
# 2. CAMBIOS PEQUEÑOS
#    Cada commit o PR debe ser pequeño y enfocado.
#    Es más fácil revisar 50 líneas que 5000.
#
# 3. MAIN SIEMPRE FUNCIONA
#    Si rompes main, la prioridad #1 es arreglarlo.
#    Todo el equipo se detiene hasta que main vuelva a funcionar.
#
# 4. FEATURE FLAGS para cambios grandes
#    Si una feature toma más de 2 días, usa feature flags.
#
# 5. REVERTIR RÁPIDO
#    Si un commit rompe algo, revierte inmediatamente:
git revert HEAD
#    No pierdas tiempo debuggeando — revierte y arregla después.


# --- SECCIÓN 8: ¿Cuándo usar Trunk-Based Development? ---
#
# USAR TBD cuando:
#   ✓ Tu equipo tiene buena cobertura de tests
#   ✓ Tienes CI/CD maduro y confiable
#   ✓ Los desarrolladores son experimentados
#   ✓ Haces deploy continuo (varias veces al día)
#   ✓ Quieres minimizar el tiempo entre escribir código y desplegarlo
#
# NO usar TBD cuando:
#   ✗ No tienes CI/CD configurado
#   ✗ Tu equipo no tiene experiencia con integración continua
#   ✗ Necesitas releases programados (usa Git Flow)
#   ✗ El proceso de QA es largo y manual


# --- SECCIÓN 9: Comparación de las 3 estrategias ---
#
# | Aspecto            | Git Flow   | GitHub Flow  | Trunk-Based  |
# |--------------------|------------|--------------|--------------|
# | Complejidad        | Alta       | Baja         | Media        |
# | Ramas permanentes  | 2          | 1            | 1            |
# | Vida de ramas      | Larga      | Media        | Muy corta    |
# | Requiere CI/CD     | No         | Recomendado  | Obligatorio  |
# | Frecuencia deploy  | Periódica  | Frecuente    | Continua     |
# | Feature flags      | No         | Opcional     | Esencial     |
# | Ideal para         | Releases   | Web apps     | Empresas     |
# |                    | programados| ágiles       | grandes      |


# --- SECCIÓN 10: Limpiar ---
cd ..
rm -rf trunk-based-practica


# =============================================================================
# RESUMEN:
# - Trunk-Based Development: todos trabajan en una sola rama (main)
# - Las ramas de feature, si existen, duran máximo 1-2 días
# - Feature flags permiten tener código incompleto sin afectar usuarios
# - CI/CD es OBLIGATORIO — sin tests automatizados no funciona
# - La regla principal: main siempre debe estar en estado desplegable
# - Ideal para equipos experimentados con deploy continuo
# =============================================================================
