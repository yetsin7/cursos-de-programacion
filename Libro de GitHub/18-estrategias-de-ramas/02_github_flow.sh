# =============================================================================
# ARCHIVO: 02_github_flow.sh
# TEMA: GitHub Flow — La estrategia simple y efectiva
# =============================================================================
#
# GitHub Flow es la estrategia de ramificación más simple. Fue creada por
# GitHub para sus propios equipos y es perfecta para proyectos que hacen
# despliegue continuo.
#
# Solo tiene UNA regla fundamental: todo lo que está en main funciona y
# está listo para producción.
#
# IMPORTANTE: No ejecutes este archivo completo. Lee cada sección y ejecuta
# los comandos uno por uno en tu terminal.
# =============================================================================


# --- SECCIÓN 1: ¿Qué es GitHub Flow? ---
#
# GitHub Flow se resume en 6 pasos:
#
# 1. Crear una rama desde main
# 2. Agregar commits en esa rama
# 3. Abrir un Pull Request
# 4. Discutir y revisar el código
# 5. Desplegar para probar (opcional)
# 6. Fusionar a main
#
# Eso es TODO. No hay rama develop, no hay ramas de release,
# no hay ramas de hotfix. Solo main y ramas de trabajo.


# --- SECCIÓN 2: Diagrama visual ---
#
#  main:      ──●──────────●──────────●──────●──
#               │          ↑          ↑       ↑
#  feature-1:  └──●──●──●─┘          │       │
#                                     │       │
#  feature-2:       └──●──●──●──●────┘       │
#                                             │
#  fix-bug:              └──●──●─────────────┘
#
# Todas las ramas nacen de main y vuelven a main.
# Cada flecha ↑ representa un Pull Request fusionado.


# --- SECCIÓN 3: Paso a paso con ejemplo real ---

# Crear repositorio de práctica
mkdir github-flow-practica
cd github-flow-practica
git init

# Commit inicial en main
echo "# App de Tareas" > README.md
git add README.md
git commit -m "feat: commit inicial"


# --- SECCIÓN 4: Paso 1 — Crear rama desde main ---

# Asegúrate de que main está actualizado
git checkout main
git pull origin main  # (si trabajas con un remoto)

# Crear rama con nombre descriptivo
git checkout -b feature/agregar-lista-tareas

# Nombres descriptivos, siempre en minúsculas con guiones:
#   feature/agregar-modo-oscuro
#   fix/corregir-calculo-total
#   docs/actualizar-readme
#   refactor/simplificar-autenticacion


# --- SECCIÓN 5: Paso 2 — Trabajar y hacer commits ---

# Trabajar normalmente en tu rama
echo "Lista de tareas:" > tareas.txt
git add tareas.txt
git commit -m "feat: crear archivo de lista de tareas"

echo "- Comprar leche" >> tareas.txt
git add tareas.txt
git commit -m "feat: agregar funcionalidad para agregar tareas"

# Haz commits pequeños y frecuentes con mensajes claros.
# Cada commit debería representar un cambio lógico y funcional.


# --- SECCIÓN 6: Paso 3 — Subir y abrir Pull Request ---

# Subir tu rama al remoto
git push -u origin feature/agregar-lista-tareas

# Abrir Pull Request
gh pr create \
  --title "feat: agregar lista de tareas" \
  --body "## Descripción
Implementé la funcionalidad de lista de tareas.

## Cambios
- Nuevo archivo tareas.txt con el sistema de lista
- Funcionalidad para agregar tareas

## Cómo probar
1. Abrir el archivo tareas.txt
2. Verificar que las tareas se listan correctamente"

# El PR es el corazón de GitHub Flow. Es donde ocurre:
#   - La revisión de código por otros miembros del equipo
#   - La discusión sobre el enfoque y la implementación
#   - Las pruebas automáticas (CI/CD)


# --- SECCIÓN 7: Paso 4 — Revisión y discusión ---
#
# Una vez abierto el PR:
#
# 1. Los revisores leen el código línea por línea
# 2. Dejan comentarios con sugerencias o preguntas
# 3. Pueden aprobar, pedir cambios o simplemente comentar
# 4. Tú respondes a los comentarios y haces ajustes
#
# Si te piden cambios, simplemente haz más commits en la misma rama:
echo "- Estudiar Git" >> tareas.txt
git add tareas.txt
git commit -m "fix: aplicar cambios solicitados en revisión"
git push origin feature/agregar-lista-tareas

# El PR se actualiza automáticamente con los nuevos commits.


# --- SECCIÓN 8: Paso 5 — Fusionar a main ---

# Una vez aprobado, se fusiona el PR.
# Desde GitHub CLI:
gh pr merge --squash
# --squash combina todos los commits de la rama en uno solo en main.
# Esto mantiene el historial de main limpio.

# Opciones de merge:
#   --merge    Merge commit (conserva todos los commits de la rama)
#   --squash   Squash merge (combina todo en un commit)
#   --rebase   Rebase merge (aplica commits uno por uno sobre main)

# Después de fusionar, elimina la rama:
git checkout main
git pull origin main
git branch -d feature/agregar-lista-tareas
git push origin --delete feature/agregar-lista-tareas


# --- SECCIÓN 9: ¿Cómo se manejan los hotfixes? ---
#
# En GitHub Flow, un hotfix se maneja EXACTAMENTE igual que cualquier
# otra rama. No hay un flujo especial:
#
# 1. Crear rama desde main: git checkout -b fix/bug-critico
# 2. Corregir el bug
# 3. Abrir PR
# 4. Revisión rápida (prioridad alta)
# 5. Fusionar a main
#
# La diferencia es solo la urgencia de la revisión, no el proceso.


# --- SECCIÓN 10: ¿Cuándo usar GitHub Flow? ---
#
# USAR GitHub Flow cuando:
#   ✓ Haces despliegue continuo o frecuente
#   ✓ Solo mantienes una versión en producción
#   ✓ Tu equipo es pequeño o mediano
#   ✓ Tienes buena cobertura de tests automatizados
#   ✓ Quieres simplicidad y velocidad
#   ✓ Trabajas en aplicaciones web
#
# NO usar GitHub Flow cuando:
#   ✗ Necesitas mantener múltiples versiones simultáneas
#   ✗ Tu ciclo de release es largo (mensual o más)
#   ✗ No tienes CI/CD configurado
#   ✗ Necesitas un proceso de QA formal antes de cada release


# --- SECCIÓN 11: Git Flow vs GitHub Flow ---
#
# | Aspecto              | Git Flow        | GitHub Flow      |
# |----------------------|-----------------|------------------|
# | Ramas permanentes    | main + develop  | Solo main        |
# | Complejidad          | Alta            | Baja             |
# | Releases             | Programados     | Continuos        |
# | Hotfixes             | Rama especial   | Como cualquier PR|
# | Ideal para           | Apps móviles    | Apps web         |
# | Tamaño de equipo     | Mediano-grande  | Cualquiera       |


# --- SECCIÓN 12: Limpiar ---
cd ..
rm -rf github-flow-practica


# =============================================================================
# RESUMEN:
# - GitHub Flow es la estrategia más simple: main + ramas de trabajo
# - Todo lo que está en main debe funcionar y estar listo para producción
# - El flujo es: rama → commits → PR → revisión → fusionar
# - Los hotfixes siguen el mismo flujo que cualquier otra rama
# - Ideal para despliegue continuo y equipos ágiles
# - Squash merge mantiene el historial de main limpio
# =============================================================================
