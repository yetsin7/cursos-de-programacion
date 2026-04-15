# =============================================================================
# ARCHIVO: 02_configurar_perfil.sh
# TEMA: Configurar tu perfil de GitHub profesionalmente
# =============================================================================
#
# Tu perfil de GitHub es tu carta de presentación como desarrollador.
# Reclutadores, empresas y otros programadores lo revisarán.
# Dedicar unos minutos a configurarlo bien vale mucho la pena.
#
# La mayoría de esto se hace desde el navegador, pero al final
# veremos cómo crear un README de perfil especial usando Git.
# =============================================================================


# ─────────────────────────────────────────────────────────────────────────────
# CONFIGURACIÓN BÁSICA DEL PERFIL (desde el navegador)
# ─────────────────────────────────────────────────────────────────────────────
#
# 1. Ve a https://github.com/settings/profile
#    (o haz clic en tu avatar → Settings → Public profile)
#
# 2. Completa estos campos:
#
#    AVATAR (foto de perfil):
#    - Sube una foto profesional o un avatar que te represente
#    - Evita imágenes borrosas, memes o imágenes por defecto
#    - Una foto real genera más confianza en la comunidad
#
#    NAME (nombre):
#    - Tu nombre completo o el nombre con el que quieres ser conocido
#    - Ejemplo: "Juan Carlos Pérez"
#
#    BIO (biografía):
#    - Máximo 160 caracteres
#    - Describe quién eres y qué haces
#    - Ejemplos:
#      "Full Stack Developer | Flutter & Nuxt.js | Open Source Enthusiast"
#      "Mobile Developer | Building apps with Flutter | Learning every day"
#      "Computer Science Student | Passionate about clean code"
#
#    COMPANY (empresa):
#    - Tu empresa actual o universidad (opcional)
#
#    LOCATION (ubicación):
#    - Tu ciudad y país (opcional pero recomendado)
#
#    WEBSITE (sitio web):
#    - Tu portafolio personal o LinkedIn (opcional)
#
# 3. Haz clic en "Update profile" para guardar los cambios


# ─────────────────────────────────────────────────────────────────────────────
# CREAR UN README DE PERFIL (el truco secreto de GitHub)
# ─────────────────────────────────────────────────────────────────────────────
# GitHub tiene una función especial: si creas un repositorio con el MISMO
# nombre que tu username, y le agregas un archivo README.md, ese contenido
# aparecerá directamente en tu página de perfil.
#
# Por ejemplo, si tu username es "juanperez", creas un repo llamado
# "juanperez" con un README.md y su contenido aparece en tu perfil.

# Paso 1: Crear el repositorio especial desde la terminal
# (Reemplaza "tu-username" con tu nombre de usuario real de GitHub)
mkdir tu-username
cd tu-username
git init

# Paso 2: Crear el archivo README.md con contenido
# Puedes editarlo con VS Code después, pero aquí creamos uno básico
cat > README.md << 'EOF'
# Hola, soy [Tu Nombre] 👋

## Sobre mí
- 🔭 Actualmente estoy trabajando en **proyectos personales**
- 🌱 Estoy aprendiendo **Git y GitHub**
- 💬 Pregúntame sobre **lo que quieras, estoy aprendiendo**
- 📫 Cómo contactarme: **tu.correo@ejemplo.com**

## Tecnologías que estoy aprendiendo
- Git & GitHub
- (Agrega más conforme aprendas)

## Estadísticas de GitHub
![Tus stats de GitHub](https://github-readme-stats.vercel.app/api?username=tu-username&show_icons=true&theme=radical)

---
*Este README fue creado como parte del Libro de GitHub*
EOF

# Paso 3: Agregar y hacer commit
git add README.md
git commit -m "Crear README de perfil"

# Paso 4: Conectar con GitHub y subir (aprenderás esto en detalle después)
# Por ahora, es más fácil crear el repo desde GitHub.com:
#   1. Ve a https://github.com/new
#   2. Nombre del repositorio: tu-username (EXACTO, igual que tu username)
#   3. Marca "Public"
#   4. Marca "Add a README file"
#   5. Haz clic en "Create repository"
#   6. Edita el README.md directamente desde GitHub

# Limpiar la carpeta de prueba local
cd ..
rm -rf tu-username


# ─────────────────────────────────────────────────────────────────────────────
# CONFIGURAR REPOSITORIOS DESTACADOS (Pinned Repositories)
# ─────────────────────────────────────────────────────────────────────────────
#
# En tu perfil de GitHub puedes "fijar" hasta 6 repositorios que quieras
# que la gente vea primero cuando visite tu perfil.
#
# Cómo hacerlo:
#   1. Ve a tu perfil: https://github.com/tu-username
#   2. Busca la sección "Pinned"
#   3. Haz clic en "Customize your pins"
#   4. Selecciona los repos que quieras destacar
#   5. Guarda los cambios
#
# CONSEJO: Destaca tus mejores proyectos o los más interesantes.
# Conforme avances en este curso, tendrás proyectos que mostrar.


# ─────────────────────────────────────────────────────────────────────────────
# OTRAS CONFIGURACIONES ÚTILES DEL PERFIL
# ─────────────────────────────────────────────────────────────────────────────
#
# Activar las contribuciones privadas en el gráfico de actividad:
#   Settings → Public profile → Contribution settings
#   → Marca "Private contributions"
#   Esto hace que tu gráfico de actividad (los cuadritos verdes) muestre
#   también la actividad en repos privados.
#
# Configurar tu estado:
#   Haz clic en tu avatar → "Set status"
#   Puedes poner un emoji y un mensaje corto, por ejemplo:
#   🎓 "Aprendiendo Git y GitHub"


# =============================================================================
# RESUMEN:
# - Configura tu foto, nombre, bio y ubicación en Settings → Profile
# - Crea un repo con tu mismo username para tener un README de perfil
# - Fija tus mejores repos para que aparezcan primero
# - Un perfil bien configurado genera confianza y oportunidades
#
# Siguiente archivo: 03_configuracion_seguridad.sh
# =============================================================================
