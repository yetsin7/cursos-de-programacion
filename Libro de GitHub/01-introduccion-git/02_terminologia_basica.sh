# =============================================================================
# ARCHIVO: 02_terminologia_basica.sh
# TEMA: Terminología básica de Git
# =============================================================================
#
# Antes de usar Git necesitas entender su vocabulario.
# Estos son los términos que verás constantemente en tu carrera como
# programador. Apréndetelos bien porque los usarás todos los días.
#
# Este archivo explica cada término con ejemplos simples.
# =============================================================================


# ─────────────────────────────────────────────────────────────────────────────
# TÉRMINO 1: REPOSITORIO (repository o "repo")
# ─────────────────────────────────────────────────────────────────────────────
# Un repositorio es simplemente una carpeta de proyecto que Git está rastreando.
# Cuando ejecutas "git init" dentro de una carpeta, esa carpeta se convierte
# en un repositorio. Git crea una carpeta oculta ".git" donde guarda todo
# el historial de cambios.

# Ejemplo: crear un repositorio desde cero
mkdir mi-proyecto
cd mi-proyecto
git init
# Ahora "mi-proyecto" es un repositorio de Git


# ─────────────────────────────────────────────────────────────────────────────
# TÉRMINO 2: COMMIT
# ─────────────────────────────────────────────────────────────────────────────
# Un commit es como una "fotografía" del estado de tu proyecto en un momento
# dado. Cada commit tiene:
#   - Un identificador único (hash) — algo como: a1b2c3d4e5f6
#   - Un mensaje que describe qué cambió — ejemplo: "Agregar página de login"
#   - La fecha y hora en que se hizo
#   - El autor que lo hizo
#
# Los commits son permanentes. Una vez que haces un commit, ese estado
# queda guardado en el historial para siempre (o hasta que lo borres).

# Ejemplo conceptual (no ejecutar aún, lo aprenderás en detalle después):
# git add archivo.txt         ← Preparar el archivo
# git commit -m "Mi primer commit"  ← Guardar la "foto"


# ─────────────────────────────────────────────────────────────────────────────
# TÉRMINO 3: BRANCH (rama)
# ─────────────────────────────────────────────────────────────────────────────
# Una rama es una línea independiente de desarrollo. Imagina un árbol:
# el tronco es la rama principal (main) y las ramas son versiones paralelas
# donde puedes experimentar sin afectar el tronco.
#
# Ejemplo real:
#   - Rama "main" → código estable que funciona
#   - Rama "nueva-funcion" → estás probando algo nuevo
#   - Si funciona, la unes a main. Si no, la borras sin afectar nada.

# Ver en qué rama estás actualmente
git branch


# ─────────────────────────────────────────────────────────────────────────────
# TÉRMINO 4: MERGE (fusionar)
# ─────────────────────────────────────────────────────────────────────────────
# Merge es el proceso de combinar los cambios de una rama con otra.
# Cuando terminas de trabajar en una función nueva (en su propia rama),
# haces merge para incorporar esos cambios a la rama principal.
#
# Ejemplo conceptual:
#   1. Creas rama "mejora-diseño" desde main
#   2. Haces cambios en "mejora-diseño"
#   3. Cuando estás satisfecho, haces merge de "mejora-diseño" → main
#   4. Ahora main tiene los cambios de mejora-diseño


# ─────────────────────────────────────────────────────────────────────────────
# TÉRMINO 5: REMOTE (remoto)
# ─────────────────────────────────────────────────────────────────────────────
# Un remoto es una copia de tu repositorio que vive en otro lugar,
# generalmente en internet (como GitHub, GitLab o Bitbucket).
#
# Cuando subes tu código a GitHub, estás enviándolo a un "remote".
# El remote más común se llama "origin" y es la dirección de tu repo
# en GitHub.

# Ver los remotos configurados (si los hay)
git remote -v


# ─────────────────────────────────────────────────────────────────────────────
# TÉRMINO 6: CLONE (clonar)
# ─────────────────────────────────────────────────────────────────────────────
# Clonar es descargar una copia completa de un repositorio remoto
# a tu computadora. Incluye todos los archivos, todas las ramas
# y todo el historial de commits.
#
# Ejemplo conceptual:
# git clone https://github.com/usuario/proyecto.git
# → Esto crea una carpeta "proyecto" con todo el código y su historial


# ─────────────────────────────────────────────────────────────────────────────
# TÉRMINO 7: PUSH (empujar)
# ─────────────────────────────────────────────────────────────────────────────
# Push es enviar tus commits locales al repositorio remoto (GitHub).
# Es como decir: "Toma, estos son mis cambios nuevos. Guárdalos en la nube."
#
# Ejemplo conceptual:
# git push origin main
# → Envía los commits de tu rama "main" local al remoto "origin"


# ─────────────────────────────────────────────────────────────────────────────
# TÉRMINO 8: PULL (jalar)
# ─────────────────────────────────────────────────────────────────────────────
# Pull es descargar los cambios más recientes del repositorio remoto
# a tu computadora. Es lo opuesto a push.
# Es como decir: "¿Hay algo nuevo en GitHub? Tráemelo."
#
# Ejemplo conceptual:
# git pull origin main
# → Descarga los cambios nuevos del remoto "origin" a tu rama "main" local


# Limpieza: salir y borrar la carpeta de prueba
cd ..
rm -rf mi-proyecto


# =============================================================================
# RESUMEN DE TÉRMINOS:
#
# | Término     | Significado                                        |
# |-------------|-----------------------------------------------------|
# | Repository  | Carpeta de proyecto rastreada por Git               |
# | Commit      | "Foto" del estado del proyecto en un momento dado   |
# | Branch      | Línea independiente de desarrollo                   |
# | Merge       | Combinar cambios de una rama en otra                |
# | Remote      | Copia del repo en internet (ej: GitHub)             |
# | Clone       | Descargar un repo remoto a tu computadora           |
# | Push        | Enviar tus commits locales al remoto                |
# | Pull        | Descargar cambios del remoto a tu computadora       |
#
# Estos 8 términos son la base de TODO lo que harás con Git.
# Memorízalos bien.
# =============================================================================
