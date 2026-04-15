# =============================================================================
# ARCHIVO: 04_buenas_practicas.sh
# TEMA: Buenas prácticas de contribución — Guías, CoC y etiqueta
# =============================================================================
#
# Contribuir a un proyecto open source no es solo escribir código.
# Hay reglas de convivencia, etiqueta y buenas prácticas que hacen
# que la experiencia sea positiva tanto para ti como para los mantenedores.
#
# En este archivo aprenderás las reglas no escritas (y escritas) de la
# colaboración open source.
#
# IMPORTANTE: Este archivo es más teórico que práctico. Léelo completo
# antes de hacer tu primera contribución.
# =============================================================================


# --- SECCIÓN 1: CONTRIBUTING.md — Las reglas del proyecto ---
#
# La mayoría de proyectos serios tienen un archivo CONTRIBUTING.md que
# explica exactamente cómo contribuir. SIEMPRE léelo antes de hacer
# cualquier cosa.
#
# Un buen CONTRIBUTING.md incluye:
#   - Cómo configurar el entorno de desarrollo local
#   - Cómo ejecutar las pruebas (tests)
#   - Convenciones de estilo de código
#   - Convenciones de mensajes de commit
#   - Proceso para proponer cambios
#   - Cómo reportar bugs
#   - Cómo sugerir nuevas funcionalidades

# Buscar el archivo CONTRIBUTING en un repositorio:
cat CONTRIBUTING.md

# A veces está dentro de la carpeta .github:
cat .github/CONTRIBUTING.md


# --- SECCIÓN 2: Code of Conduct — Reglas de comportamiento ---
#
# El Code of Conduct (Código de Conducta) establece las reglas de
# comportamiento de la comunidad. Es un acuerdo de respeto mutuo.
#
# El más usado es el "Contributor Covenant" y típicamente incluye:
#   - Usar lenguaje inclusivo y respetuoso
#   - Respetar diferentes puntos de vista y experiencias
#   - Aceptar críticas constructivas con gracia
#   - Enfocarse en lo que es mejor para la comunidad
#   - Mostrar empatía hacia otros miembros
#
# Violaciones del Code of Conduct pueden resultar en:
#   - Advertencia de los mantenedores
#   - Eliminación de comentarios ofensivos
#   - Ban temporal del proyecto
#   - Ban permanente en casos graves

# Ver el Code of Conduct de un proyecto:
cat CODE_OF_CONDUCT.md


# --- SECCIÓN 3: Antes de contribuir — Investigar primero ---
#
# REGLA DE ORO: Antes de escribir una sola línea de código, investiga.
#
# 1. Lee el README completo
#    - Entiende qué hace el proyecto
#    - Verifica los requisitos y dependencias
#    - Mira si hay una sección de "Contributing"

# 2. Revisa los issues existentes
#    - Busca si alguien ya reportó el mismo bug
#    - Busca si alguien ya propuso la misma mejora
#    - Filtra por etiquetas: "good first issue", "help wanted", "bug"

# 3. Revisa los Pull Requests abiertos
#    - Verifica que nadie esté trabajando en lo mismo
#    - Mira PRs cerrados para entender qué cambios se aceptan y cuáles no

# 4. Lee las discusiones (si el proyecto usa GitHub Discussions)
#    - A veces las decisiones de diseño se discuten ahí


# --- SECCIÓN 4: Cómo reportar un bug correctamente ---
#
# Un buen reporte de bug incluye:
#
# TÍTULO: Claro y específico
#   Malo:  "No funciona"
#   Bueno: "Error 500 al hacer login con cuenta de Google en Safari"
#
# CUERPO:
#   1. Descripción del problema
#   2. Pasos para reproducirlo (paso 1, paso 2, etc.)
#   3. Comportamiento esperado vs comportamiento actual
#   4. Entorno: sistema operativo, versión del software, navegador
#   5. Capturas de pantalla o logs si aplica
#   6. ¿El problema es consistente o intermitente?

# Si el proyecto tiene templates de issues, úsalos:
# GitHub te mostrará un formulario predefinido al crear un issue.


# --- SECCIÓN 5: Cómo proponer una nueva funcionalidad ---
#
# Antes de implementar algo nuevo, PREGUNTA PRIMERO.
# Abre un issue o discusión explicando:
#   - ¿Qué problema resuelve tu propuesta?
#   - ¿Cómo debería funcionar?
#   - ¿Por qué es útil para el proyecto?
#   - ¿Estarías dispuesto a implementarlo?
#
# Espera la respuesta del mantenedor ANTES de escribir código.
# Esto evita que pierdas tiempo en algo que el proyecto no necesita
# o que ya se está implementando de otra forma.


# --- SECCIÓN 6: Etiqueta en Pull Requests ---
#
# HACER:
#   ✓ Mantener los PRs pequeños y enfocados (un cambio por PR)
#   ✓ Escribir una descripción clara de qué y por qué
#   ✓ Referenciar issues relacionados ("Fixes #123" o "Relates to #456")
#   ✓ Incluir capturas de pantalla si hay cambios visuales
#   ✓ Responder al feedback de forma respetuosa y oportuna
#   ✓ Ejecutar las pruebas antes de abrir el PR
#   ✓ Seguir el estilo de código del proyecto (no el tuyo)
#   ✓ Actualizar la documentación si tu cambio lo requiere
#
# NO HACER:
#   ✗ Abrir PRs enormes con cientos de cambios
#   ✗ Mezclar múltiples cambios no relacionados en un PR
#   ✗ Reformatear todo el código para que se vea "mejor"
#   ✗ Agregar dependencias innecesarias
#   ✗ Ignorar el feedback de los revisores
#   ✗ Presionar a los mantenedores para que revisen rápido
#   ✗ Tomar el rechazo de un PR como algo personal


# --- SECCIÓN 7: Comunicación efectiva ---
#
# El 90% de la comunicación open source es escrita y asíncrona.
# La persona al otro lado puede estar en cualquier zona horaria
# y hablar un idioma diferente al tuyo.
#
# CONSEJOS:
#   - Sé claro y conciso
#   - Usa formato Markdown para organizar tus mensajes
#   - Incluye contexto suficiente (no asumas que todos saben de qué hablas)
#   - Sé paciente — los mantenedores suelen ser voluntarios con otras
#     responsabilidades
#   - Agradece el tiempo de los revisores
#   - Si no recibes respuesta en una semana, un ping amable está bien
#   - Nunca exijas ni te quejes públicamente


# --- SECCIÓN 8: Tipos de contribuciones (no solo código) ---
#
# Contribuir no es solo escribir código. Hay muchas formas de ayudar:
#
#   - Documentación: mejorar el README, crear tutoriales, traducir
#   - Reportar bugs: reportar problemas claros y reproducibles
#   - Triaje: ayudar a clasificar y responder issues
#   - Diseño: mejorar la interfaz de usuario o la experiencia
#   - Pruebas: escribir tests, probar en diferentes plataformas
#   - Revisión: revisar Pull Requests de otros contribuidores
#   - Mentoría: ayudar a nuevos contribuidores
#   - Promoción: escribir sobre el proyecto, dar charlas
#
# Todas estas contribuciones son igual de valiosas que el código.


# =============================================================================
# RESUMEN:
# - Lee CONTRIBUTING.md y CODE_OF_CONDUCT.md antes de contribuir
# - Investiga antes de escribir código: issues, PRs, discusiones
# - Reporta bugs con pasos claros para reproducirlos
# - Pregunta antes de implementar funcionalidades nuevas
# - Mantén los PRs pequeños, enfocados y bien documentados
# - Sé respetuoso, paciente y agradecido con los mantenedores
# - Contribuir no es solo código: documentación, tests, triaje, etc.
# =============================================================================
