# =============================================================================
# ARCHIVO: 01_que_es_open_source.sh
# TEMA: ¿Qué es Open Source? — Licencias y exploración de proyectos
# =============================================================================
#
# Open source no es solo "código gratis". Es un movimiento global donde
# desarrolladores comparten su código para que otros lo usen, aprendan de él,
# lo mejoren y lo redistribuyan.
#
# En este archivo exploraremos qué significa open source, los tipos de
# licencias más comunes y cómo encontrar proyectos a los que contribuir.
#
# IMPORTANTE: No ejecutes este archivo completo. Lee cada sección y ejecuta
# los comandos uno por uno en tu terminal.
# =============================================================================


# --- SECCIÓN 1: ¿Qué significa Open Source? ---
#
# Open source (código abierto) se refiere a software cuyo código fuente está
# disponible públicamente. Cualquier persona puede:
#   - VER el código fuente completo
#   - USAR el software para cualquier propósito
#   - MODIFICAR el código para adaptarlo a sus necesidades
#   - DISTRIBUIR copias del original o de versiones modificadas
#
# Esto NO significa que no tenga reglas. Cada proyecto tiene una LICENCIA
# que define exactamente qué puedes y qué no puedes hacer con el código.
#
# Ejemplos de proyectos open source que probablemente usas todos los días:
#   - Linux (el sistema operativo)
#   - Git (el control de versiones que estamos aprendiendo)
#   - VS Code (el editor de código de Microsoft)
#   - Flutter (el framework de Google para apps móviles)
#   - Node.js (el runtime de JavaScript)
#   - Python (el lenguaje de programación)


# --- SECCIÓN 2: Licencias Open Source ---
#
# La licencia es un archivo (generalmente llamado LICENSE) en la raíz del
# repositorio que define las reglas legales del proyecto.
#
# LICENCIA MIT:
#   - La más popular y permisiva
#   - Puedes usar, copiar, modificar, fusionar, publicar, distribuir,
#     sublicenciar y vender copias del software
#   - La única condición: incluir la nota de copyright y la licencia
#   - Ejemplo: React, jQuery, Node.js
#
# LICENCIA APACHE 2.0:
#   - Similar a MIT pero más detallada
#   - Incluye una cláusula de protección de patentes
#   - Debes indicar los cambios que hiciste al código original
#   - Ejemplo: Android, Kubernetes, Swift
#
# LICENCIA GPL v3 (GNU General Public License):
#   - Es "copyleft": si usas código GPL en tu proyecto, tu proyecto
#     también DEBE ser GPL y open source
#   - Esto protege la libertad del software: garantiza que siempre
#     permanezca abierto
#   - Ejemplo: Linux kernel, WordPress, GIMP
#
# LICENCIA BSD:
#   - Muy similar a MIT, extremadamente permisiva
#   - Existen variantes de 2 y 3 cláusulas
#   - Ejemplo: FreeBSD, Django
#
# LICENCIA ISC:
#   - La más corta y simple de todas
#   - Funcionalmente equivalente a MIT pero con menos texto
#   - Ejemplo: muchos paquetes de npm


# --- SECCIÓN 3: Ver la licencia de un proyecto ---
# Puedes ver la licencia de cualquier repositorio en GitHub. Generalmente
# aparece en la parte superior de la página del repositorio o en el archivo
# LICENSE en la raíz.

# Desde la línea de comandos, si clonaste un repo, puedes ver su licencia:
cat LICENSE

# O si el archivo se llama diferente:
cat LICENSE.md
cat COPYING


# --- SECCIÓN 4: Explorar proyectos Open Source en GitHub ---
#
# GitHub es el hogar de millones de proyectos open source.
# Aquí hay formas de encontrar proyectos interesantes:
#
# 1. GitHub Explore — https://github.com/explore
#    Muestra proyectos populares, trending y colecciones temáticas
#
# 2. GitHub Topics — https://github.com/topics
#    Filtra proyectos por tecnología, lenguaje o tema
#
# 3. Awesome Lists — Listas curadas de recursos por tema
#    Ejemplo: https://github.com/sindresorhus/awesome
#
# 4. Good First Issues — Issues etiquetados como fáciles para principiantes
#    https://goodfirstissue.dev
#    https://goodfirstissues.com
#
# 5. First Timers Only — Proyectos que dan la bienvenida a nuevos contribuidores
#    https://www.firsttimersonly.com


# --- SECCIÓN 5: Buscar proyectos por lenguaje en GitHub ---
# Puedes buscar repositorios directamente desde la web de GitHub
# usando filtros de búsqueda avanzada.
#
# Ejemplos de búsqueda en la barra de GitHub:
#   language:python stars:>100 good-first-issues:>5
#   language:javascript label:"good first issue"
#   language:dart topic:flutter stars:>50
#
# Esto te ayuda a encontrar proyectos activos en tu lenguaje favorito
# que tienen issues fáciles marcados para principiantes.


# --- SECCIÓN 6: Indicadores de un buen proyecto para contribuir ---
#
# Antes de invertir tiempo en un proyecto, verifica estos indicadores:
#
# SEÑALES POSITIVAS (buen proyecto para contribuir):
#   ✓ Tiene un archivo README claro y detallado
#   ✓ Tiene un archivo CONTRIBUTING.md con instrucciones
#   ✓ Tiene un Code of Conduct (CODE_OF_CONDUCT.md)
#   ✓ Los issues están activos y los mantenedores responden
#   ✓ Los Pull Requests se revisan en un tiempo razonable
#   ✓ Tiene etiquetas como "good first issue" o "help wanted"
#   ✓ Ha tenido commits recientes (proyecto activo)
#   ✓ Tiene pruebas automatizadas (tests)
#
# SEÑALES DE ALARMA (mejor evitar):
#   ✗ No ha tenido commits en meses o años
#   ✗ Hay muchos issues y PRs abiertos sin respuesta
#   ✗ No tiene licencia
#   ✗ Los mantenedores son hostiles o groseros
#   ✗ No tiene documentación


# --- SECCIÓN 7: Anatomía de un proyecto Open Source ---
#
# Los proyectos bien organizados suelen tener estos archivos en la raíz:
#
# README.md            — Descripción del proyecto, cómo instalarlo y usarlo
# LICENSE              — La licencia del proyecto
# CONTRIBUTING.md      — Cómo contribuir (reglas, proceso, estilo de código)
# CODE_OF_CONDUCT.md   — Reglas de comportamiento de la comunidad
# CHANGELOG.md         — Historial de cambios por versión
# .github/             — Carpeta con templates de issues, PRs y workflows
#   ├── ISSUE_TEMPLATE/
#   ├── PULL_REQUEST_TEMPLATE.md
#   └── workflows/     — GitHub Actions


# =============================================================================
# RESUMEN:
# - Open source es código disponible públicamente bajo una licencia
# - Siempre revisa la licencia antes de usar o contribuir a un proyecto
# - MIT y Apache 2.0 son las licencias más comunes y permisivas
# - GPL requiere que tu proyecto derivado también sea open source
# - Busca proyectos con buena documentación e issues etiquetados para
#   principiantes
# - Verifica que el proyecto sea activo y que los mantenedores respondan
# =============================================================================
