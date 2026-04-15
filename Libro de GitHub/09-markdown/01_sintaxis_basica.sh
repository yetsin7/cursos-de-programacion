#!/bin/bash
# =============================================================================
# ARCHIVO: 01_sintaxis_basica.sh
# TEMA: Sintaxis básica de Markdown — Encabezados, negrita, cursiva, enlaces, imágenes
# =============================================================================
#
# Markdown es un lenguaje de marcado ligero. En este archivo aprenderás la
# sintaxis fundamental que usarás en TODO lo que escribas en GitHub:
# READMEs, Issues, Pull Requests, comentarios y wikis.
#
# NOTA: Los ejemplos de Markdown están dentro de comentarios y bloques cat/echo
# porque Markdown no es código ejecutable — es texto con formato.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# ENCABEZADOS (HEADERS)
# ─────────────────────────────────────────────────────────────────────────────

# Los encabezados se crean con el símbolo # al inicio de la línea.
# Hay 6 niveles de encabezado, del más grande al más pequeño.
# Siempre deja un espacio entre el # y el texto.

cat << 'MARKDOWN'
# Encabezado nivel 1 (H1) — Título principal
## Encabezado nivel 2 (H2) — Sección
### Encabezado nivel 3 (H3) — Subsección
#### Encabezado nivel 4 (H4)
##### Encabezado nivel 5 (H5)
###### Encabezado nivel 6 (H6)
MARKDOWN

# REGLAS IMPORTANTES SOBRE ENCABEZADOS:
# - Usa solo UN H1 por archivo (es el título del documento)
# - No saltes niveles: después de H2 va H3, no H4
# - GitHub genera automáticamente un índice (table of contents) basado en los encabezados
# - Los encabezados se convierten en enlaces ancla: ## Mi Sección → #mi-sección

echo ""
echo "========================================="
echo "  ENCABEZADOS EN MARKDOWN"
echo "========================================="
echo ""
echo "Sintaxis:"
echo "  # H1 — Título principal (solo uno por archivo)"
echo "  ## H2 — Secciones principales"
echo "  ### H3 — Subsecciones"
echo "  #### H4 — Sub-subsecciones"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# ÉNFASIS: NEGRITA, CURSIVA Y COMBINACIONES
# ─────────────────────────────────────────────────────────────────────────────

# Markdown permite resaltar texto con negrita, cursiva o ambas.
# Puedes usar asteriscos (*) o guiones bajos (_), pero los asteriscos son más comunes.

cat << 'MARKDOWN'
*cursiva*           — Un asterisco a cada lado
_cursiva_           — Un guion bajo a cada lado (mismo resultado)

**negrita**         — Dos asteriscos a cada lado
__negrita__         — Dos guiones bajos a cada lado (mismo resultado)

***negrita y cursiva***  — Tres asteriscos a cada lado
___negrita y cursiva___  — Tres guiones bajos a cada lado

~~tachado~~         — Dos tildes a cada lado (texto tachado/strikethrough)
MARKDOWN

# RECOMENDACIÓN:
# - Usa ** para negrita (más legible que __)
# - Usa * para cursiva (más legible que _)
# - Usa negrita para términos importantes o advertencias
# - Usa cursiva para términos técnicos la primera vez que aparecen
# - No abuses del énfasis — si todo es importante, nada es importante

echo ""
echo "========================================="
echo "  ÉNFASIS EN MARKDOWN"
echo "========================================="
echo ""
echo "Sintaxis:"
echo "  *cursiva*             → cursiva"
echo "  **negrita**           → negrita"
echo "  ***ambas***           → negrita y cursiva"
echo "  ~~tachado~~           → texto tachado"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# LÍNEAS HORIZONTALES (SEPARADORES)
# ─────────────────────────────────────────────────────────────────────────────

# Para crear una línea horizontal que separe secciones, usa tres o más
# guiones, asteriscos o guiones bajos en una línea sola.

cat << 'MARKDOWN'
---
***
___
MARKDOWN

# Los tres producen el mismo resultado: una línea horizontal.
# La convención más común es usar --- (tres guiones).
# IMPORTANTE: Deja una línea en blanco antes y después del separador
# para que Markdown no lo confunda con un encabezado.

# ─────────────────────────────────────────────────────────────────────────────
# ENLACES (LINKS)
# ─────────────────────────────────────────────────────────────────────────────

# Los enlaces son fundamentales en Markdown. La sintaxis es:
# [texto visible](URL)

cat << 'MARKDOWN'
[Google](https://www.google.com)
[GitHub](https://github.com)
[Mi perfil](https://github.com/tu-usuario)

— Con título al pasar el mouse (tooltip):
[GitHub](https://github.com "Ir a GitHub")

— Enlace automático (solo pega la URL):
https://github.com

— Enlace a otro archivo del mismo repo:
[Ver la guía de instalación](./docs/instalacion.md)

— Enlace a una sección del mismo archivo (ancla):
[Ir a la sección de imágenes](#imágenes)

— Enlaces de referencia (útiles cuando repites el mismo enlace):
[GitHub][gh-link]
[También GitHub][gh-link]

[gh-link]: https://github.com
MARKDOWN

# NOTAS SOBRE ENLACES:
# - GitHub convierte automáticamente URLs pegadas en enlaces clickeables
# - Puedes enlazar a Issues con #123, a PRs, a commits por su hash
# - Los enlaces relativos (./archivo.md) funcionan dentro del repositorio
# - Los enlaces ancla (#sección) se generan de los encabezados

echo ""
echo "========================================="
echo "  ENLACES EN MARKDOWN"
echo "========================================="
echo ""
echo "Sintaxis:"
echo "  [texto](URL)                    → Enlace básico"
echo "  [texto](URL \"tooltip\")          → Enlace con tooltip"
echo "  [texto](#seccion)               → Enlace ancla (misma página)"
echo "  [texto](./ruta/archivo.md)      → Enlace relativo"
echo "  https://url.com                 → Autoenlace"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# IMÁGENES
# ─────────────────────────────────────────────────────────────────────────────

# Las imágenes usan una sintaxis similar a los enlaces, pero con ! al inicio.
# Sintaxis: ![texto alternativo](URL de la imagen)

cat << 'MARKDOWN'
— Imagen básica:
![Logo de GitHub](https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png)

— Imagen con tooltip:
![Logo de GitHub](https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png "Logo oficial de GitHub")

— Imagen local del repositorio:
![Captura de pantalla](./screenshots/demo.png)

— Imagen con tamaño personalizado (usando HTML):
<img src="./logo.png" alt="Logo" width="200">

— Imagen como enlace (clickeable):
[![Logo](./logo.png)](https://github.com)
MARKDOWN

# NOTAS SOBRE IMÁGENES:
# - El texto alternativo (alt text) es obligatorio para accesibilidad
# - GitHub permite arrastrar y soltar imágenes en Issues y PRs
# - Para controlar el tamaño, necesitas usar HTML (<img> tag)
# - Formatos recomendados: PNG para capturas, SVG para logos, GIF para demos
# - Guarda las imágenes en una carpeta como /assets o /screenshots

echo ""
echo "========================================="
echo "  IMÁGENES EN MARKDOWN"
echo "========================================="
echo ""
echo "Sintaxis:"
echo "  ![alt](URL)                     → Imagen básica"
echo "  ![alt](URL \"tooltip\")           → Imagen con tooltip"
echo "  <img src=\"URL\" width=\"200\">      → Imagen con tamaño"
echo "  [![alt](img)](link)             → Imagen clickeable"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# SALTOS DE LÍNEA Y PÁRRAFOS
# ─────────────────────────────────────────────────────────────────────────────

# En Markdown, los saltos de línea NO funcionan como en un editor normal.
# Esto es una fuente muy común de confusión para principiantes.

cat << 'MARKDOWN'
— ESTO NO crea un salto de línea:
Línea uno
Línea dos
(Aparecerá todo en la misma línea)

— Para crear un salto de línea, usa DOS espacios al final:
Línea uno
Línea dos
(Ahora sí aparecen en líneas separadas)

— Para crear un párrafo nuevo, deja una LÍNEA EN BLANCO:
Párrafo uno.

Párrafo dos.

— También puedes usar <br> para un salto de línea explícito:
Línea uno<br>Línea dos
MARKDOWN

# REGLA CLAVE:
# - Salto de línea = dos espacios al final + Enter
# - Párrafo nuevo = línea en blanco entre textos
# - O usa <br> si quieres ser explícito

echo ""
echo "========================================="
echo "  RESUMEN DE SINTAXIS BÁSICA"
echo "========================================="
echo ""
echo "  # H1          ## H2          ### H3"
echo "  *cursiva*      **negrita**    ~~tachado~~"
echo "  [texto](url)   ![alt](img)    ---"
echo ""
echo "  ¡Practica en un README.md de cualquier repositorio!"
echo ""
