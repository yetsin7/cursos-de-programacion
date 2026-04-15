# =============================================================================
# ARCHIVO: 05_tu_primer_contribucion.sh
# TEMA: Tu primera contribución open source — Guía paso a paso
# =============================================================================
#
# Vamos a hacer tu primera contribución real a un proyecto open source.
# Existen repositorios creados específicamente para que practiques
# el flujo de contribución sin miedo a romper nada.
#
# En este archivo te guiaré paso a paso por todo el proceso.
#
# IMPORTANTE: No ejecutes este archivo completo. Lee cada sección y ejecuta
# los comandos uno por uno en tu terminal.
# =============================================================================


# --- SECCIÓN 1: Repositorios para practicar ---
#
# Estos proyectos están diseñados para que principiantes practiquen:
#
# 1. first-contributions
#    https://github.com/firstcontributions/first-contributions
#    El más popular. Solo agregas tu nombre a una lista.
#
# 2. contribute-to-this-project
#    https://github.com/Syknapse/Contribute-To-This-Project
#    Agregas una tarjeta con tu info a una página web.
#
# 3. hello-open-source
#    https://github.com/nicedayzhu/hello-open-source
#    Creas un archivo con tu nombre.
#
# Usaremos "first-contributions" como ejemplo, pero el flujo es
# exactamente el mismo para cualquier proyecto.


# --- SECCIÓN 2: Paso 1 — Hacer fork del repositorio ---

# Desde GitHub CLI:
gh repo fork firstcontributions/first-contributions --clone=true

# Esto hace el fork Y lo clona en tu computadora.
# Entra a la carpeta:
cd first-contributions


# --- SECCIÓN 3: Paso 2 — Crear una rama ---

# Crea una rama con tu nombre (o un nombre descriptivo)
git checkout -b agregar-tu-nombre

# Por ejemplo:
git checkout -b agregar-yetsin


# --- SECCIÓN 4: Paso 3 — Hacer los cambios ---

# Abre el archivo Contributors.md en tu editor
# Agrega tu nombre en formato Markdown:
#
# - [Tu Nombre](https://github.com/tu-usuario)
#
# Guarda el archivo.

# Verificar los cambios
git status
git diff


# --- SECCIÓN 5: Paso 4 — Commit y push ---

# Agregar los cambios al staging area
git add Contributors.md

# Hacer commit con un mensaje descriptivo
git commit -m "feat: agregar a Tu Nombre a la lista de contribuidores"

# Subir la rama a tu fork
git push origin agregar-tu-nombre


# --- SECCIÓN 6: Paso 5 — Crear el Pull Request ---

# Desde GitHub CLI:
gh pr create \
  --title "feat: agregar a Tu Nombre como contribuidor" \
  --body "Hola! Esta es mi primera contribución open source.
Agregué mi nombre a la lista de contribuidores.

Seguí las instrucciones del README paso a paso."

# O ve a GitHub y haz clic en "Compare & pull request"


# --- SECCIÓN 7: Paso 6 — Esperar y celebrar ---
#
# Una vez que abras el PR:
# 1. Los mantenedores lo revisarán (puede tomar minutos o días)
# 2. Si piden cambios, hazlos en la misma rama y haz push
# 3. Cuando lo aprueben y lo fusionen, ¡ya eres contribuidor open source!
#
# Verás tu contribución reflejada en el repositorio original.
# GitHub también mostrará tu nombre en la sección "Contributors".


# --- SECCIÓN 8: Después de tu primera contribución ---
#
# Ya que entiendes el flujo, busca proyectos reales donde contribuir:
#
# Paso 1: Identifica herramientas que usas todos los días
#   - ¿Usas una librería de Flutter? Contribuye a ella.
#   - ¿Un paquete de npm te salvó la vida? Mejora su documentación.
#   - ¿Encontraste un bug en una herramienta? Repórtalo (o arréglalo).

# Paso 2: Busca issues accesibles
#   En GitHub, busca issues con estas etiquetas:
#     - "good first issue"
#     - "beginner friendly"
#     - "help wanted"
#     - "easy"
#     - "documentation"

# Paso 3: Empieza con contribuciones pequeñas
#   - Corregir errores tipográficos en la documentación
#   - Mejorar mensajes de error
#   - Agregar o mejorar comentarios en el código
#   - Escribir o mejorar pruebas (tests)
#   - Traducir documentación a español

# Paso 4: Gradualmente sube la complejidad
#   - Corregir bugs pequeños
#   - Implementar funcionalidades simples
#   - Revisar PRs de otros contribuidores
#   - Responder issues ayudando a otros usuarios


# --- SECCIÓN 9: Herramientas para encontrar tu primera contribución ---

# Sitios web que agregan "good first issues" de muchos proyectos:
#
# https://goodfirstissue.dev
#   Filtra por lenguaje y muestra issues etiquetados para principiantes
#
# https://goodfirstissues.com
#   Similar al anterior con una interfaz diferente
#
# https://up-for-grabs.net
#   Proyectos que marcan issues específicos como "up for grabs"
#
# https://www.codetriage.com
#   Te envía un issue por email cada día para que contribuyas
#
# https://hacktoberfest.com (cada octubre)
#   Evento anual donde puedes ganar premios por contribuir


# --- SECCIÓN 10: Errores comunes de principiantes ---
#
# ERROR 1: Trabajar directamente en main
#   Solución: SIEMPRE crea una rama nueva para cada contribución
#
# ERROR 2: No leer el CONTRIBUTING.md
#   Solución: Léelo COMPLETO antes de hacer cualquier cosa
#
# ERROR 3: Abrir un PR sin describir los cambios
#   Solución: Escribe una descripción clara y útil
#
# ERROR 4: No sincronizar el fork antes de crear una rama
#   Solución: git pull --rebase upstream main antes de crear la rama
#
# ERROR 5: Rendirse al primer rechazo
#   Solución: El feedback es oportunidad de aprender, no un ataque personal
#
# ERROR 6: Hacer cambios de estilo no solicitados
#   Solución: Solo cambia lo necesario para resolver el issue


# =============================================================================
# RESUMEN:
# - Empieza con repositorios de práctica como first-contributions
# - El flujo es: fork → clonar → rama → cambios → commit → push → PR
# - Después de practicar, busca proyectos reales con "good first issue"
# - Empieza con documentación y bugs pequeños, luego sube la complejidad
# - Usa sitios como goodfirstissue.dev para encontrar oportunidades
# - Los errores comunes se evitan leyendo CONTRIBUTING.md y siendo paciente
# =============================================================================
