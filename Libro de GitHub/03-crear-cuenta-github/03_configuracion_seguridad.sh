# =============================================================================
# ARCHIVO: 03_configuracion_seguridad.sh
# TEMA: Seguridad de tu cuenta de GitHub — 2FA, emails y SSH
# =============================================================================
#
# La seguridad de tu cuenta es FUNDAMENTAL. Si alguien accede a tu cuenta
# de GitHub, puede modificar o borrar todos tus repositorios.
# En este archivo configuraremos las protecciones más importantes.
# =============================================================================


# ─────────────────────────────────────────────────────────────────────────────
# 1. AUTENTICACIÓN DE DOS FACTORES (2FA)
# ─────────────────────────────────────────────────────────────────────────────
# 2FA agrega una segunda capa de seguridad. Además de tu contraseña,
# necesitas un código temporal generado por tu teléfono.
# Incluso si alguien roba tu contraseña, no puede entrar sin tu teléfono.
#
# GitHub REQUIERE 2FA desde 2023 para todos los usuarios que contribuyen código.
#
# Cómo activar 2FA:
#   1. Ve a https://github.com/settings/security
#      (o Settings → Password and authentication)
#   2. En "Two-factor authentication", haz clic en "Enable"
#   3. Elige tu método preferido:
#
#      OPCIÓN A — App de autenticación (RECOMENDADO):
#      - Descarga una app como Google Authenticator, Authy o Microsoft Authenticator
#      - Escanea el código QR que GitHub te muestra
#      - Ingresa el código de 6 dígitos que la app genera
#
#      OPCIÓN B — SMS (menos seguro pero funcional):
#      - Ingresa tu número de teléfono
#      - Recibirás un código por mensaje de texto
#
#   4. IMPORTANTE: Guarda los códigos de recuperación en un lugar seguro
#      - GitHub te dará códigos de respaldo por si pierdes tu teléfono
#      - Guárdalos en un gestor de contraseñas o imprímelos
#      - Sin estos códigos y sin tu teléfono, PERDERÁS acceso a tu cuenta


# ─────────────────────────────────────────────────────────────────────────────
# 2. CONFIGURACIÓN DE CORREO ELECTRÓNICO
# ─────────────────────────────────────────────────────────────────────────────
# Configurar correctamente tu email en GitHub es importante por dos razones:
# 1) Para que tus commits se vinculen a tu cuenta
# 2) Para proteger tu privacidad
#
# Ve a: https://github.com/settings/emails
#
# Opciones importantes:
#
#   "Keep my email addresses private":
#   - Si activas esta opción, GitHub te da un email especial tipo:
#     12345678+tu-username@users.noreply.github.com
#   - Tus commits usarán este email en vez del real
#   - Ideal si no quieres que tu correo personal sea público
#
#   "Block command line pushes that expose my email":
#   - Bloquea pushes si tu commit tiene tu email real expuesto
#   - Actívalo si usas el email privado de GitHub

# Si decides usar el email privado de GitHub, actualiza tu configuración local:
# (Reemplaza con tu email noreply real de GitHub)
# git config --global user.email "12345678+tu-username@users.noreply.github.com"


# ─────────────────────────────────────────────────────────────────────────────
# 3. INTRODUCCIÓN A SSH KEYS (Llaves SSH)
# ─────────────────────────────────────────────────────────────────────────────
# SSH (Secure Shell) es un protocolo seguro de comunicación.
# Cuando configuras SSH con GitHub, puedes hacer push y pull sin escribir
# tu contraseña o token cada vez. Es más seguro y cómodo que HTTPS.
#
# El concepto es simple:
#   - Generas un par de llaves: una PÚBLICA y una PRIVADA
#   - La pública la subes a GitHub (es como un candado)
#   - La privada se queda en tu computadora (es como la llave del candado)
#   - Cuando haces push/pull, Git usa tu llave privada para demostrar
#     que eres tú, sin necesidad de contraseña

# Paso 1: Verificar si ya tienes llaves SSH
# Si ves archivos como id_rsa.pub o id_ed25519.pub, ya tienes llaves
ls -la ~/.ssh/

# Paso 2: Generar una nueva llave SSH (si no tienes una)
# Ed25519 es el algoritmo más moderno y seguro
# Reemplaza el email con el tuyo
ssh-keygen -t ed25519 -C "tu.correo@ejemplo.com"

# Git te preguntará:
#   "Enter file in which to save the key" → presiona Enter (usa la ruta por defecto)
#   "Enter passphrase" → escribe una contraseña para proteger la llave (RECOMENDADO)
#   "Enter same passphrase again" → repite la contraseña

# Paso 3: Iniciar el agente SSH (gestiona tus llaves)
eval "$(ssh-agent -s)"

# Paso 4: Agregar tu llave privada al agente
ssh-add ~/.ssh/id_ed25519

# Paso 5: Copiar tu llave PÚBLICA al portapapeles
# macOS:
# pbcopy < ~/.ssh/id_ed25519.pub

# Windows (Git Bash):
# clip < ~/.ssh/id_ed25519.pub

# Linux:
# xclip -selection clipboard < ~/.ssh/id_ed25519.pub

# O simplemente muestra la llave y cópiala manualmente:
cat ~/.ssh/id_ed25519.pub

# Paso 6: Agregar la llave a GitHub
#   1. Ve a https://github.com/settings/keys
#   2. Haz clic en "New SSH key"
#   3. Title: un nombre descriptivo (ej: "Mi laptop Windows")
#   4. Key type: "Authentication Key"
#   5. Key: pega tu llave pública (lo que copiaste en el paso 5)
#   6. Haz clic en "Add SSH key"

# Paso 7: Verificar la conexión SSH con GitHub
# Si todo está bien, verás un mensaje como:
# "Hi tu-username! You've successfully authenticated"
ssh -T git@github.com


# ─────────────────────────────────────────────────────────────────────────────
# 4. TOKENS DE ACCESO PERSONAL (alternativa a SSH)
# ─────────────────────────────────────────────────────────────────────────────
# Si prefieres usar HTTPS en vez de SSH, necesitas un token de acceso personal.
# GitHub eliminó la autenticación por contraseña en 2021, así que ahora
# se usa un token en su lugar.
#
# Cómo crear un token:
#   1. Ve a https://github.com/settings/tokens
#   2. Haz clic en "Generate new token (classic)"
#   3. Dale un nombre descriptivo (ej: "Token para mi laptop")
#   4. Selecciona una fecha de expiración (90 días es razonable)
#   5. Selecciona los permisos (scopes):
#      - "repo" → para acceder a repositorios (NECESARIO)
#      - "workflow" → para GitHub Actions (opcional por ahora)
#   6. Haz clic en "Generate token"
#   7. COPIA el token INMEDIATAMENTE — no lo podrás ver de nuevo
#   8. Guárdalo en un gestor de contraseñas
#
# Cuando Git te pida contraseña al hacer push, usa el TOKEN en vez de tu
# contraseña de GitHub.


# =============================================================================
# RESUMEN:
# - Activa 2FA (autenticación de dos factores) — es OBLIGATORIO
# - Configura tu email para proteger tu privacidad
# - Configura SSH para no escribir contraseña en cada push/pull
# - Si usas HTTPS, crea un token de acceso personal
# - Guarda los códigos de recuperación y tokens en un lugar seguro
#
# La seguridad no es opcional. Protege tu cuenta desde el primer día.
#
# Siguiente capítulo: 04-repositorios-basicos/
# =============================================================================
