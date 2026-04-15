# =============================================================================
# ARCHIVO: 06_ejercicios.sh
# TEMA: Ejercicios prácticos — Colaboración Open Source
# =============================================================================
#
# Pon a prueba todo lo aprendido en este capítulo. Estos ejercicios van
# desde lo básico hasta lo avanzado. Intenta resolverlos todos antes de
# pasar al siguiente capítulo.
#
# IMPORTANTE: Lee cada ejercicio completo antes de intentar resolverlo.
# =============================================================================


# --- EJERCICIO 1: Explorar un proyecto open source ---
#
# Objetivo: Familiarizarte con la estructura de un proyecto real.
#
# Instrucciones:
# 1. Ve a https://github.com/facebook/react (o cualquier proyecto popular)
# 2. Identifica y lee estos archivos:
#    - README.md
#    - LICENSE
#    - CONTRIBUTING.md
#    - CODE_OF_CONDUCT.md
# 3. Responde estas preguntas:
#    a) ¿Qué licencia usa el proyecto?
#    b) ¿Qué requisitos pide para contribuir?
#    c) ¿Qué convención de commits usan?
#    d) ¿Cuántos contribuidores tiene?
#    e) ¿Cuántos issues abiertos tiene?
#    f) ¿Cuándo fue el último commit?


# --- EJERCICIO 2: Hacer tu primer fork ---
#
# Objetivo: Practicar el flujo de fork y configuración de upstream.
#
# Instrucciones:
# 1. Haz fork de: https://github.com/firstcontributions/first-contributions
# 2. Clona tu fork a tu computadora
# 3. Configura upstream
# 4. Verifica con git remote -v que tienes origin y upstream
#
# Comandos que deberías usar:
gh repo fork firstcontributions/first-contributions --clone=true
cd first-contributions
git remote add upstream https://github.com/firstcontributions/first-contributions.git
git remote -v


# --- EJERCICIO 3: Contribuir al repositorio de práctica ---
#
# Objetivo: Completar el flujo completo de contribución.
#
# Instrucciones:
# 1. Crea una rama con tu nombre
# 2. Agrega tu nombre al archivo Contributors.md
# 3. Haz commit de tus cambios
# 4. Sube tu rama a tu fork
# 5. Abre un Pull Request al repositorio original
# 6. Espera a que lo fusionen
#
# Este es tu primer PR real. ¡Tómale captura de pantalla!


# --- EJERCICIO 4: Sincronizar un fork ---
#
# Objetivo: Practicar la sincronización con upstream.
#
# Instrucciones:
# 1. En el fork del ejercicio anterior, sincroniza main con upstream
# 2. Usa los tres métodos y compara:
#    a) fetch + merge
#    b) fetch + rebase
#    c) git pull --rebase
# 3. Verifica que tu fork en GitHub esté actualizado
#
# Pista: Después de cada método, haz git push origin main


# --- EJERCICIO 5: Buscar issues para principiantes ---
#
# Objetivo: Aprender a encontrar oportunidades de contribución.
#
# Instrucciones:
# 1. Ve a https://goodfirstissue.dev
# 2. Filtra por tu lenguaje de programación favorito
# 3. Encuentra 3 issues que podrías intentar resolver
# 4. Para cada issue, anota:
#    a) Nombre del proyecto
#    b) Título del issue
#    c) ¿Qué habilidades necesitas para resolverlo?
#    d) ¿El proyecto tiene CONTRIBUTING.md?
#    e) ¿Cuándo fue la última actividad del proyecto?


# --- EJERCICIO 6: Simular una revisión de código ---
#
# Objetivo: Practicar dar y recibir feedback.
#
# Instrucciones:
# 1. Busca un Pull Request abierto en cualquier proyecto popular
# 2. Lee el código del PR completo
# 3. Sin dejar un comentario real, escribe en un archivo local:
#    a) ¿Qué hace el PR?
#    b) ¿El código se ve correcto?
#    c) ¿La descripción del PR es clara?
#    d) ¿Qué sugerencias harías para mejorarlo?
#    e) ¿Cumple con las guías de contribución del proyecto?


# --- EJERCICIO 7: Escribir un buen reporte de bug ---
#
# Objetivo: Practicar la comunicación efectiva.
#
# Instrucciones:
# 1. Piensa en un bug que hayas encontrado en alguna herramienta
# 2. Escribe un reporte de bug completo en un archivo local con:
#    - Título claro y específico
#    - Pasos para reproducir (numerados)
#    - Comportamiento esperado
#    - Comportamiento actual
#    - Entorno (SO, versión, navegador, etc.)
#    - Capturas de pantalla si aplica
# 3. Compara tu reporte con los issues del proyecto real
# 4. ¿Tu reporte es tan claro como los mejores issues que viste?


# --- EJERCICIO FINAL: Tu plan de contribución ---
#
# Objetivo: Crear un plan personal para contribuir a open source.
#
# Instrucciones:
# 1. Elige 3 proyectos open source que te interesen
# 2. Para cada proyecto, identifica:
#    a) Tipo de contribución que podrías hacer (código, docs, tests)
#    b) Issues marcados como "good first issue" o "help wanted"
#    c) Requisitos técnicos para contribuir
# 3. Elige UNO y haz tu primera contribución real esta semana
# 4. Documenta tu experiencia: qué hiciste, qué aprendiste, qué fue
#    difícil, qué fue fácil


# =============================================================================
# CHECKLIST DE VERIFICACIÓN:
# [ ] Sé qué es un fork y para qué sirve
# [ ] Puedo configurar upstream en un repositorio local
# [ ] Puedo sincronizar mi fork con el proyecto original
# [ ] Conozco el flujo completo: fork → rama → cambios → PR
# [ ] Sé dónde encontrar issues para principiantes
# [ ] Entiendo la etiqueta y buenas prácticas de contribución
# [ ] Hice al menos una contribución real a un proyecto open source
# =============================================================================
