#!/bin/bash
# =============================================================================
# ARCHIVO: 02_listas_y_tablas.sh
# TEMA: Listas ordenadas, no ordenadas, de tareas y tablas en Markdown
# =============================================================================
#
# Las listas y tablas son elementos esenciales para organizar información
# en GitHub. Las usarás constantemente en READMEs, Issues y documentación.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# LISTAS NO ORDENADAS (VIÑETAS)
# ─────────────────────────────────────────────────────────────────────────────

# Se crean con -, * o + al inicio de cada línea.
# La convención más común en GitHub es usar - (guion).

cat << 'MARKDOWN'
— Con guiones (recomendado):
- Elemento uno
- Elemento dos
- Elemento tres

— Con asteriscos:
* Elemento uno
* Elemento dos

— Con signo más:
+ Elemento uno
+ Elemento dos

— Listas anidadas (usa 2 espacios de indentación):
- Frutas
  - Manzana
  - Naranja
    - Naranja dulce
    - Naranja agria
  - Plátano
- Verduras
  - Zanahoria
  - Brócoli
MARKDOWN

# REGLAS IMPORTANTES:
# - Sé consistente: usa siempre el mismo símbolo (- es el estándar)
# - Para anidar, usa exactamente 2 espacios de indentación
# - Deja una línea en blanco antes y después de la lista
# - No mezcles -, * y + en la misma lista

echo ""
echo "========================================="
echo "  LISTAS NO ORDENADAS"
echo "========================================="
echo ""
echo "  - Elemento         (con guion)"
echo "  * Elemento         (con asterisco)"
echo "    - Sub-elemento   (anidado con 2 espacios)"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# LISTAS ORDENADAS (NUMERADAS)
# ─────────────────────────────────────────────────────────────────────────────

# Se crean con un número seguido de punto y espacio.
# Markdown renumera automáticamente — puedes poner 1. en todas.

cat << 'MARKDOWN'
— Lista ordenada estándar:
1. Primer paso
2. Segundo paso
3. Tercer paso

— Markdown renumera automáticamente (todos pueden ser 1.):
1. Primer paso
1. Segundo paso
1. Tercer paso
(Se renderiza como 1, 2, 3 correctamente)

— Lista ordenada anidada:
1. Clonar el repositorio
   1. Abrir la terminal
   2. Ejecutar git clone
2. Instalar dependencias
   1. Ejecutar npm install
   2. Verificar que no hay errores
3. Iniciar el proyecto

— Mezclar ordenadas y no ordenadas:
1. Preparar el entorno
   - Instalar Node.js
   - Instalar Git
2. Configurar el proyecto
   - Crear el repositorio
   - Agregar .gitignore
MARKDOWN

# CONSEJO PRÁCTICO:
# Usar 1. en todas las líneas es útil porque si reordenas los pasos,
# no necesitas renumerar manualmente. Markdown se encarga.

echo ""
echo "========================================="
echo "  LISTAS ORDENADAS"
echo "========================================="
echo ""
echo "  1. Primer paso"
echo "  2. Segundo paso"
echo "     1. Sub-paso"
echo "  3. Tercer paso"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# LISTAS DE TAREAS (TASK LISTS / CHECKBOXES)
# ─────────────────────────────────────────────────────────────────────────────

# Las listas de tareas son exclusivas de GitHub Flavored Markdown (GFM).
# Son increíblemente útiles en Issues y Pull Requests para rastrear progreso.

cat << 'MARKDOWN'
— Lista de tareas básica:
- [ ] Tarea pendiente
- [x] Tarea completada
- [ ] Otra tarea pendiente

— Ejemplo real en un Issue:
## Checklist de lanzamiento
- [x] Código revisado
- [x] Tests pasando
- [ ] Documentación actualizada
- [ ] Deploy a producción
- [ ] Notificar al equipo

— Anidadas:
- [x] Backend
  - [x] API de usuarios
  - [x] API de productos
  - [ ] API de pagos
- [ ] Frontend
  - [x] Pantalla de login
  - [ ] Pantalla de checkout
MARKDOWN

# DATO IMPORTANTE:
# En Issues de GitHub, las checkboxes son interactivas — puedes marcarlas
# y desmarcarlas directamente desde la interfaz web sin editar el texto.
# GitHub también muestra un indicador de progreso (ej: "2 of 5 tasks").

echo ""
echo "========================================="
echo "  LISTAS DE TAREAS"
echo "========================================="
echo ""
echo "  - [ ] Tarea pendiente     (checkbox vacío)"
echo "  - [x] Tarea completada    (checkbox marcado)"
echo ""
echo "  ¡Son interactivas en Issues y PRs de GitHub!"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# TABLAS
# ─────────────────────────────────────────────────────────────────────────────

# Las tablas se crean con pipes (|) y guiones (-).
# Son muy útiles en READMEs para mostrar información estructurada.

cat << 'MARKDOWN'
— Tabla básica:
| Columna 1 | Columna 2 | Columna 3 |
|-----------|-----------|-----------|
| Dato 1    | Dato 2    | Dato 3    |
| Dato 4    | Dato 5    | Dato 6    |

— Alineación de columnas:
| Izquierda | Centro | Derecha |
|:----------|:------:|--------:|
| texto     | texto  | texto   |
| alineado  | al     | a la    |
| izquierda | centro | derecha |

— Ejemplo real — tabla de comandos:
| Comando | Descripción | Ejemplo |
|---------|-------------|---------|
| `git init` | Inicializa un repositorio | `git init mi-proyecto` |
| `git add` | Agrega archivos al staging | `git add .` |
| `git commit` | Crea un commit | `git commit -m "mensaje"` |
| `git push` | Sube cambios al remoto | `git push origin main` |

— Ejemplo real — comparativa de tecnologías:
| Característica | React | Vue | Angular |
|:---------------|:-----:|:---:|:-------:|
| Curva de aprendizaje | Media | Baja | Alta |
| Tamaño del bundle | Pequeño | Pequeño | Grande |
| Tipado estático | Opcional | Opcional | Obligatorio |
| Respaldado por | Meta | Comunidad | Google |
MARKDOWN

# NOTAS SOBRE TABLAS:
# - Los pipes exteriores (| al inicio y final) son opcionales pero mejoran legibilidad
# - No es necesario que las columnas estén perfectamente alineadas en el código
# - La fila de guiones (---) es obligatoria entre el header y los datos
# - Para alinear: :--- (izquierda), :---: (centro), ---: (derecha)
# - Puedes usar formato dentro de celdas: **negrita**, `código`, enlaces

echo ""
echo "========================================="
echo "  TABLAS EN MARKDOWN"
echo "========================================="
echo ""
echo "  | Col 1 | Col 2 |"
echo "  |-------|-------|"
echo "  | Dato  | Dato  |"
echo ""
echo "  Alineación: :--- izq   :---: centro   ---: derecha"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# CITAS (BLOCKQUOTES)
# ─────────────────────────────────────────────────────────────────────────────

# Las citas se crean con > al inicio de la línea.
# Son útiles para resaltar notas, advertencias o citar a alguien.

cat << 'MARKDOWN'
— Cita simple:
> Esta es una cita o nota importante.

— Cita de múltiples líneas:
> Esta es una cita larga que ocupa
> varias líneas. Cada línea comienza
> con el símbolo >.

— Citas anidadas:
> Nivel 1 de la cita
>> Nivel 2 (cita dentro de cita)
>>> Nivel 3

— Cita con formato:
> **Nota importante:** Siempre haz backup antes de ejecutar
> `git reset --hard`. Este comando **no se puede deshacer**.
MARKDOWN

echo ""
echo "========================================="
echo "  RESUMEN"
echo "========================================="
echo ""
echo "  Listas:    - item   1. item   - [ ] tarea"
echo "  Tablas:    | col | col |  con  |---|---|"
echo "  Citas:     > texto citado"
echo ""
