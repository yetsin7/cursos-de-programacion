#!/bin/bash
# =============================================================================
# ARCHIVO: 06_perfil_readme.sh
# TEMA: Crear un README de perfil en GitHub (repositorio especial username/username)
# =============================================================================
#
# GitHub tiene una funcionalidad especial: si creas un repositorio con el
# MISMO nombre que tu usuario, el README.md de ese repositorio se muestra
# directamente en tu perfil de GitHub. Es tu carta de presentación.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# ¿QUÉ ES EL PERFIL README?
# ─────────────────────────────────────────────────────────────────────────────

# Cuando alguien visita tu perfil en github.com/tu-usuario, normalmente
# solo ve tus repositorios y contribuciones. Pero si creas un repositorio
# especial, puedes mostrar un README personalizado al inicio de tu perfil.

# El "truco" es simple:
# 1. Crea un repositorio con EXACTAMENTE el mismo nombre que tu usuario de GitHub
# 2. Hazlo público
# 3. Agrega un README.md
# 4. Ese README aparece en tu perfil

echo "========================================="
echo "  CREAR EL REPOSITORIO ESPECIAL"
echo "========================================="
echo ""
echo "  Si tu usuario es 'yetsin7', crea un repositorio llamado 'yetsin7'"
echo "  URL: github.com/yetsin7/yetsin7"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# PASO A PASO PARA CREAR EL PERFIL README
# ─────────────────────────────────────────────────────────────────────────────

# Paso 1: Crear el repositorio especial desde GitHub
# - Ve a github.com/new
# - Nombre del repositorio: tu-usuario (exacto, mismo que tu username)
# - Marcarlo como público
# - Marcar "Add a README file"
# - GitHub te mostrará un mensaje: "You found a secret! tu-usuario/tu-usuario
#   is a special repository that you can use to add a README.md to your
#   GitHub profile."

# Paso 2: Clonar y editar localmente
git clone https://github.com/tu-usuario/tu-usuario.git  # Reemplaza 'tu-usuario'
cd tu-usuario

# Paso 3: Editar el README.md con tu contenido personalizado

# Paso 4: Push de los cambios
git add README.md
git commit -m "Actualizar perfil README"
git push origin main

echo ""
echo "========================================="
echo "  PASOS"
echo "========================================="
echo ""
echo "  1. Crear repo: github.com/new → nombre = tu username"
echo "  2. Hacerlo público + agregar README"
echo "  3. Editar el README.md con tu información"
echo "  4. Push → ¡aparece automáticamente en tu perfil!"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# PLANTILLA DE PERFIL README
# ─────────────────────────────────────────────────────────────────────────────

# Aquí hay una plantilla profesional que puedes personalizar:

cat << 'MARKDOWN'
# Hola, soy [Tu Nombre] 👋

Desarrollador de software apasionado por crear aplicaciones móviles y web.

## Sobre mí

- 📱 Desarrollo apps móviles con **Flutter**
- 🌐 Desarrollo sitios web con **Nuxt 4**
- 🎯 Enfocado en arquitectura limpia y alto rendimiento
- 🌍 Ubicación: [Tu ciudad, país]
- 📫 Contacto: [tu-email@ejemplo.com]

## Tecnologías

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Nuxt](https://img.shields.io/badge/Nuxt-00DC82?style=for-the-badge&logo=nuxt.js&logoColor=white)
![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=for-the-badge&logo=typescript&logoColor=white)
![Tailwind](https://img.shields.io/badge/Tailwind-06B6D4?style=for-the-badge&logo=tailwindcss&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3FCF8E?style=for-the-badge&logo=supabase&logoColor=white)

## Proyectos destacados

| Proyecto | Descripción | Tecnología |
|----------|-------------|------------|
| [Nombre](enlace) | Descripción breve | Flutter |
| [Nombre](enlace) | Descripción breve | Nuxt 4 |

## Estadísticas de GitHub

![GitHub Stats](https://github-readme-stats.vercel.app/api?username=tu-usuario&show_icons=true&theme=dark)

![Top Langs](https://github-readme-stats.vercel.app/api/top-langs/?username=tu-usuario&layout=compact&theme=dark)

## Racha de contribuciones

![GitHub Streak](https://github-readme-streak-stats.herokuapp.com/?user=tu-usuario&theme=dark)

---

⭐ De [Tu Nombre](https://github.com/tu-usuario)
MARKDOWN

# ─────────────────────────────────────────────────────────────────────────────
# HERRAMIENTAS ÚTILES PARA EL PERFIL README
# ─────────────────────────────────────────────────────────────────────────────

echo ""
echo "========================================="
echo "  HERRAMIENTAS ÚTILES"
echo "========================================="
echo ""
echo "  Estadísticas de GitHub:"
echo "    https://github.com/anuraghazra/github-readme-stats"
echo ""
echo "  Racha de contribuciones:"
echo "    https://github.com/DenverCoder1/github-readme-streak-stats"
echo ""
echo "  Badges de tecnologías:"
echo "    https://github.com/Ileriayo/markdown-badges"
echo "    https://shields.io/"
echo ""
echo "  Generadores de perfil README:"
echo "    https://rahuldkjain.github.io/gh-profile-readme-generator/"
echo "    https://gprm.itsvg.in/"
echo ""
echo "  Gráfico de actividad:"
echo "    https://github.com/Ashutosh00710/github-readme-activity-graph"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# CONSEJOS PARA UN PERFIL README PROFESIONAL
# ─────────────────────────────────────────────────────────────────────────────

echo "========================================="
echo "  CONSEJOS PARA UN PERFIL PROFESIONAL"
echo "========================================="
echo ""
echo "  HACER:"
echo "  - Mantenerlo conciso y bien organizado"
echo "  - Incluir tus tecnologías principales con badges"
echo "  - Mostrar 2-3 proyectos destacados"
echo "  - Incluir forma de contacto"
echo "  - Actualizarlo regularmente"
echo ""
echo "  NO HACER:"
echo "  - Poner demasiada información (menos es más)"
echo "  - Usar GIFs excesivos que distraigan"
echo "  - Listar 20+ tecnologías que apenas conoces"
echo "  - Copiar el perfil de alguien más sin personalizarlo"
echo "  - Dejarlo desactualizado con info de hace años"
echo ""
