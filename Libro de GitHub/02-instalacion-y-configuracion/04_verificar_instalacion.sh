# =============================================================================
# ARCHIVO: 04_verificar_instalacion.sh
# TEMA: Verificar que Git está correctamente instalado y configurado
# =============================================================================
#
# Este archivo es una lista de verificación final. Ejecuta cada comando
# y confirma que todo está correcto antes de continuar al siguiente capítulo.
# =============================================================================


# ─────────────────────────────────────────────────────────────────────────────
# CHECK 1: Git está instalado
# ─────────────────────────────────────────────────────────────────────────────
# Deberías ver algo como: git version 2.43.0 (o superior)
git --version


# ─────────────────────────────────────────────────────────────────────────────
# CHECK 2: Tu nombre está configurado
# ─────────────────────────────────────────────────────────────────────────────
# Deberías ver tu nombre completo
# Si no aparece nada, configúralo: git config --global user.name "Tu Nombre"
git config user.name


# ─────────────────────────────────────────────────────────────────────────────
# CHECK 3: Tu correo está configurado
# ─────────────────────────────────────────────────────────────────────────────
# Deberías ver tu correo electrónico (el mismo que usarás en GitHub)
# Si no aparece nada, configúralo: git config --global user.email "tu@email.com"
git config user.email


# ─────────────────────────────────────────────────────────────────────────────
# CHECK 4: Tu editor está configurado
# ─────────────────────────────────────────────────────────────────────────────
# Deberías ver "code --wait" si configuraste VS Code
# Si no aparece nada, Git usará Vim por defecto (puede ser confuso)
git config core.editor


# ─────────────────────────────────────────────────────────────────────────────
# CHECK 5: La rama por defecto es "main"
# ─────────────────────────────────────────────────────────────────────────────
# Deberías ver "main"
# Si no aparece, configúralo: git config --global init.defaultBranch main
git config init.defaultBranch


# ─────────────────────────────────────────────────────────────────────────────
# CHECK 6: Ver toda la configuración
# ─────────────────────────────────────────────────────────────────────────────
# Esto muestra TODAS las configuraciones activas
# Revísala para confirmar que todo está como lo quieres
git config --list


# ─────────────────────────────────────────────────────────────────────────────
# CHECK 7: Prueba rápida — Crear un repositorio de prueba
# ─────────────────────────────────────────────────────────────────────────────

# Crear carpeta temporal y entrar en ella
mkdir test-git-config
cd test-git-config

# Inicializar un repositorio
git init

# Verificar que la rama se llama "main" (no "master")
git branch --show-current

# Crear un archivo de prueba
echo "Prueba de configuracion" > test.txt

# Agregarlo al staging area
git add test.txt

# Hacer un commit de prueba
git commit -m "Commit de prueba para verificar configuracion"

# Ver el commit — tu nombre y correo deberían aparecer correctamente
git log

# Si ves tu nombre, correo, la fecha y el mensaje del commit, todo está bien

# Limpiar: salir y borrar la carpeta de prueba
cd ..
rm -rf test-git-config


# ─────────────────────────────────────────────────────────────────────────────
# CHECKLIST FINAL
# ─────────────────────────────────────────────────────────────────────────────
#
# ✅ git --version muestra una versión de Git
# ✅ git config user.name muestra tu nombre
# ✅ git config user.email muestra tu correo
# ✅ git config core.editor muestra tu editor (idealmente VS Code)
# ✅ git config init.defaultBranch muestra "main"
# ✅ Puedes crear un repo, agregar archivos y hacer commits
#
# Si todo está ✅, estás listo para continuar al capítulo 03.
# Si algo falla, revisa los archivos anteriores de este capítulo.


# =============================================================================
# RESUMEN:
# - Verificar la instalación es FUNDAMENTAL antes de continuar
# - Si algún check falla, vuelve a los archivos 01, 02 o 03 de este capítulo
# - Una vez que todo funciona, tu entorno de Git está listo para trabajar
#
# Siguiente capítulo: 03-crear-cuenta-github/
# =============================================================================
