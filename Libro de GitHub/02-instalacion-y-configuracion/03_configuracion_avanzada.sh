# =============================================================================
# ARCHIVO: 03_configuracion_avanzada.sh
# TEMA: Configuración avanzada de Git — Aliases, colores y más
# =============================================================================
#
# Estas configuraciones NO son obligatorias, pero te harán la vida mucho
# más fácil. Los programadores profesionales siempre personalizan su Git
# para ser más eficientes.
# =============================================================================


# ─────────────────────────────────────────────────────────────────────────────
# ALIASES: Atajos para comandos largos
# ─────────────────────────────────────────────────────────────────────────────
# Un alias es un atajo. En vez de escribir un comando largo cada vez,
# puedes crear un nombre corto que haga lo mismo.

# "git st" en vez de "git status"
git config --global alias.st status

# "git co" en vez de "git checkout"
git config --global alias.co checkout

# "git br" en vez de "git branch"
git config --global alias.br branch

# "git ci" en vez de "git commit"
git config --global alias.ci commit

# "git lg" para ver el historial de forma bonita y compacta
# Este alias es muy popular entre desarrolladores profesionales
git config --global alias.lg "log --oneline --graph --decorate --all"

# "git last" para ver solo el último commit
git config --global alias.last "log -1 --oneline"

# "git unstage" para quitar un archivo del staging area
git config --global alias.unstage "restore --staged"

# Después de configurar estos aliases, puedes usarlos así:
# git st        → equivale a: git status
# git co main   → equivale a: git checkout main
# git br        → equivale a: git branch
# git ci -m "mensaje" → equivale a: git commit -m "mensaje"
# git lg        → muestra el historial bonito con ramas y colores
# git last      → muestra el último commit


# ─────────────────────────────────────────────────────────────────────────────
# COLORES: Hacer que Git sea más legible
# ─────────────────────────────────────────────────────────────────────────────

# Habilitar colores en la salida de Git (normalmente ya viene activado)
# Los colores ayudan a distinguir rápidamente qué archivos cambiaron,
# cuáles están staged, cuáles no, etc.
git config --global color.ui auto


# ─────────────────────────────────────────────────────────────────────────────
# CREDENTIAL HELPER: No escribir contraseña cada vez
# ─────────────────────────────────────────────────────────────────────────────
# Cuando haces push o pull a GitHub por HTTPS, Git te pide tu usuario
# y contraseña (o token). El credential helper guarda estas credenciales
# para que no tengas que escribirlas cada vez.

# Windows: usa el Credential Manager de Windows (ya viene con Git for Windows)
# git config --global credential.helper manager

# macOS: usa el Keychain de macOS
# git config --global credential.helper osxkeychain

# Linux: guarda las credenciales en memoria por 1 hora (3600 segundos)
# git config --global credential.helper 'cache --timeout=3600'

# Linux: guardar permanentemente en un archivo (menos seguro)
# git config --global credential.helper store


# ─────────────────────────────────────────────────────────────────────────────
# CONFIGURACIONES ÚTILES ADICIONALES
# ─────────────────────────────────────────────────────────────────────────────

# Hacer que "git pull" use rebase en vez de merge por defecto
# Esto mantiene un historial más limpio (lo entenderás mejor en capítulos avanzados)
git config --global pull.rebase false

# Configurar el comportamiento de los finales de línea
# Windows usa CRLF (\r\n), macOS/Linux usan LF (\n)
# Esta configuración evita problemas cuando colaboras con personas en otros SO

# En Windows: convierte LF a CRLF al descargar, y CRLF a LF al subir
git config --global core.autocrlf true

# En macOS/Linux: solo convierte CRLF a LF al subir (por si llegan archivos de Windows)
# git config --global core.autocrlf input

# Hacer que "git push" solo suba la rama actual (no todas las ramas)
git config --global push.default current

# Habilitar ayuda para corrección de comandos mal escritos
# Si escribes "git stauts" en vez de "git status", Git te sugerirá la corrección
git config --global help.autocorrect 10


# ─────────────────────────────────────────────────────────────────────────────
# VER TODOS TUS ALIASES CONFIGURADOS
# ─────────────────────────────────────────────────────────────────────────────

# Listar todos los aliases que has creado
git config --global --get-regexp alias


# ─────────────────────────────────────────────────────────────────────────────
# ELIMINAR UNA CONFIGURACIÓN
# ─────────────────────────────────────────────────────────────────────────────

# Si quieres eliminar un alias o cualquier configuración:
# git config --global --unset alias.nombre

# Ejemplo: eliminar el alias "st"
# git config --global --unset alias.st


# =============================================================================
# RESUMEN:
# - Los aliases te ahorran tiempo: "git st" en vez de "git status"
# - Los colores hacen que Git sea más fácil de leer
# - El credential helper evita escribir la contraseña cada vez
# - core.autocrlf previene problemas de finales de línea entre sistemas
# - push.default current solo sube la rama en la que estás trabajando
#
# Estas configuraciones son opcionales pero MUY recomendadas.
# Los profesionales siempre las configuran.
#
# Siguiente archivo: 04_verificar_instalacion.sh
# =============================================================================
