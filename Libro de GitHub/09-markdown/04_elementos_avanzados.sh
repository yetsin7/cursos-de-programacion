#!/bin/bash
# =============================================================================
# ARCHIVO: 04_elementos_avanzados.sh
# TEMA: Secciones colapsables, alertas, notas al pie, matemáticas y diagramas
# =============================================================================
#
# GitHub Flavored Markdown (GFM) soporta elementos avanzados que no existen
# en Markdown estándar. Estos elementos te permiten crear documentación
# profesional y rica directamente en GitHub.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# SECCIONES COLAPSABLES (COLLAPSIBLE SECTIONS)
# ─────────────────────────────────────────────────────────────────────────────

# Las secciones colapsables usan las etiquetas HTML <details> y <summary>.
# Son perfectas para ocultar información secundaria sin sobrecargar el documento.

cat << 'MARKDOWN'
— Sección colapsable básica:
<details>
<summary>Haz clic para ver más detalles</summary>

Aquí va el contenido oculto.
Puedes poner **Markdown** aquí dentro, incluyendo:
- Listas
- Código
- Tablas
- Imágenes

</details>

— Sección colapsable abierta por defecto:
<details open>
<summary>Esta sección está abierta por defecto</summary>

El atributo `open` hace que la sección esté expandida al cargar la página.

</details>

— Ejemplo práctico — FAQ:
<details>
<summary><strong>¿Cómo instalo el proyecto?</strong></summary>

```bash
git clone https://github.com/usuario/proyecto.git
cd proyecto
npm install
```

</details>

<details>
<summary><strong>¿Qué versión de Node necesito?</strong></summary>

Necesitas Node.js 18 o superior. Verifica tu versión con:

```bash
node --version
```

</details>

— Ejemplo práctico — Logs de error (útil en Issues):
<details>
<summary>Ver log de error completo</summary>

```
Error: Cannot find module 'express'
    at Function.Module._resolveFilename
    at Function.Module._load
    at Module.require
    at require (internal/modules/cjs/helpers.js:88:18)
```

</details>
MARKDOWN

# NOTAS IMPORTANTES:
# - Deja una línea en blanco después de <summary> para que el Markdown interno se renderice
# - Deja una línea en blanco antes de </details>
# - Puedes anidar <details> dentro de otros <details>
# - Son muy útiles en Issues para pegar logs largos sin sobrecargar la vista

echo ""
echo "========================================="
echo "  SECCIONES COLAPSABLES"
echo "========================================="
echo ""
echo "  <details>"
echo "  <summary>Título visible</summary>"
echo ""
echo "  Contenido oculto aquí..."
echo ""
echo "  </details>"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# ALERTAS DE GITHUB (ALERTS / ADMONITIONS)
# ─────────────────────────────────────────────────────────────────────────────

# GitHub soporta alertas especiales con formato visual dentro de blockquotes.
# Hay 5 tipos: NOTE, TIP, IMPORTANT, WARNING y CAUTION.

cat << 'MARKDOWN'
— Nota (información adicional):
> [!NOTE]
> Esto es una nota con información adicional que el lector debería conocer.

— Consejo (sugerencia útil):
> [!TIP]
> Puedes usar `git stash` para guardar cambios temporalmente sin hacer commit.

— Importante (información clave):
> [!IMPORTANT]
> Debes configurar las variables de entorno ANTES de iniciar el servidor.

— Advertencia (precaución):
> [!WARNING]
> Este comando elimina archivos permanentemente. No se puede deshacer.

— Peligro (acción destructiva):
> [!CAUTION]
> Ejecutar `git push --force` puede sobrescribir el trabajo de otros colaboradores.
MARKDOWN

# CUÁNDO USAR CADA ALERTA:
# - NOTE: información complementaria, contexto adicional
# - TIP: trucos, atajos, mejores prácticas
# - IMPORTANT: requisitos previos, información que no debe pasarse por alto
# - WARNING: acciones que podrían causar problemas
# - CAUTION: acciones destructivas o irreversibles

echo ""
echo "========================================="
echo "  ALERTAS DE GITHUB"
echo "========================================="
echo ""
echo "  > [!NOTE]      → Información adicional (azul)"
echo "  > [!TIP]       → Consejo útil (verde)"
echo "  > [!IMPORTANT] → Información clave (morado)"
echo "  > [!WARNING]   → Precaución (amarillo)"
echo "  > [!CAUTION]   → Peligro (rojo)"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# NOTAS AL PIE (FOOTNOTES)
# ─────────────────────────────────────────────────────────────────────────────

# Las notas al pie permiten agregar referencias sin interrumpir la lectura.
# GitHub las renderiza al final del documento con enlaces de ida y vuelta.

cat << 'MARKDOWN'
— Notas al pie:
Git fue creado por Linus Torvalds en 2005[^1]. Originalmente fue diseñado
para gestionar el desarrollo del kernel de Linux[^2].

[^1]: Linus Torvalds es también el creador de Linux.
[^2]: El kernel de Linux es uno de los proyectos open source más grandes del mundo.

— Nota al pie con múltiples líneas:
GitHub fue lanzado en 2008[^github].

[^github]: GitHub fue fundado por Tom Preston-Werner, Chris Wanstrath,
    PJ Hyett y Scott Chacon. Fue adquirido por Microsoft en 2018
    por $7.5 mil millones de dólares.
MARKDOWN

# Las definiciones de las notas al pie pueden estar en cualquier lugar del archivo,
# pero GitHub siempre las muestra al final del documento renderizado.

# ─────────────────────────────────────────────────────────────────────────────
# EXPRESIONES MATEMÁTICAS (LATEX)
# ─────────────────────────────────────────────────────────────────────────────

# GitHub soporta expresiones matemáticas usando sintaxis LaTeX.
# Útil para documentación técnica, científica o algorítmica.

cat << 'MARKDOWN'
— Matemáticas en línea (dentro de un párrafo):
La fórmula cuadrática es $x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$ y resuelve ecuaciones de segundo grado.

— Bloque de matemáticas (centrado en su propia línea):
$$
E = mc^2
$$

$$
\sum_{i=1}^{n} i = \frac{n(n+1)}{2}
$$

— Ejemplo práctico — Complejidad algorítmica:
El algoritmo tiene complejidad $O(n \log n)$ en el caso promedio.

$$
T(n) = 2T\left(\frac{n}{2}\right) + O(n)
$$
MARKDOWN

# Para matemáticas en línea: $expresión$
# Para bloques de matemáticas: $$expresión$$
# Usa sintaxis LaTeX estándar dentro de los delimitadores.

# ─────────────────────────────────────────────────────────────────────────────
# DIAGRAMAS MERMAID
# ─────────────────────────────────────────────────────────────────────────────

# GitHub renderiza diagramas Mermaid directamente en Markdown.
# Es como "código que se convierte en diagrama visual".
# Soporta: flujo, secuencia, Gantt, clase, estado, ER, pie y más.

cat << 'MARKDOWN'
— Diagrama de flujo:
```mermaid
graph TD
    A[Inicio] --> B{¿Hay cambios?}
    B -->|Sí| C[git add]
    C --> D[git commit]
    D --> E[git push]
    B -->|No| F[Nada que hacer]
    E --> G[Fin]
    F --> G
```

— Diagrama de secuencia:
```mermaid
sequenceDiagram
    participant Dev as Desarrollador
    participant GH as GitHub
    participant Rev as Revisor

    Dev->>GH: Push rama feature
    Dev->>GH: Crear Pull Request
    GH->>Rev: Notificar PR nuevo
    Rev->>GH: Revisar código
    Rev->>GH: Aprobar PR
    Dev->>GH: Merge PR
```

— Diagrama de Gantt (planificación):
```mermaid
gantt
    title Plan de desarrollo
    dateFormat YYYY-MM-DD
    section Backend
        API usuarios     :a1, 2024-01-01, 10d
        API productos    :a2, after a1, 7d
    section Frontend
        Login            :b1, 2024-01-05, 8d
        Dashboard        :b2, after b1, 12d
```

— Gráfico circular (pie chart):
```mermaid
pie title Lenguajes del proyecto
    "TypeScript" : 45
    "Python" : 30
    "Dart" : 15
    "Shell" : 10
```
MARKDOWN

# VENTAJAS DE MERMAID:
# - No necesitas software externo para crear diagramas
# - Los diagramas son texto, así que están versionados con Git
# - GitHub los renderiza automáticamente
# - Perfectos para documentar arquitectura, flujos y procesos

echo ""
echo "========================================="
echo "  RESUMEN DE ELEMENTOS AVANZADOS"
echo "========================================="
echo ""
echo "  <details>         → Secciones colapsables"
echo "  > [!NOTE]         → Alertas de GitHub"
echo "  [^1]              → Notas al pie"
echo "  \$...\$  \$\$...\$\$   → Expresiones matemáticas"
echo "  \`\`\`mermaid        → Diagramas"
echo ""
