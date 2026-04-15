# =============================================================================
# ARCHIVO: 03_sincronizar_fork.sh
# TEMA: Mantener tu fork actualizado con upstream
# =============================================================================
#
# Cuando haces un fork, tu copia queda "congelada" en el tiempo.
# El proyecto original sigue avanzando con nuevos commits de otros
# contribuidores. Si no sincronizas tu fork regularmente, tu código
# se quedará desactualizado y tendrás conflictos al hacer Pull Requests.
#
# En este archivo aprenderás a mantener tu fork siempre al día.
#
# IMPORTANTE: No ejecutes este archivo completo. Lee cada sección y ejecuta
# los comandos uno por uno en tu terminal.
# =============================================================================


# --- SECCIÓN 1: ¿Por qué sincronizar? ---
#
# Imagina este escenario:
#   Día 1: Haces fork del proyecto (commit A, B, C)
#   Día 5: El proyecto original tiene nuevos commits (D, E, F)
#   Día 5: Tu fork sigue en (A, B, C) — ¡está atrasado!
#
# Si creas una rama y haces cambios basándote en código viejo,
# tu Pull Request podría tener conflictos o estar desactualizado.
#
# Solución: sincronizar tu fork con upstream regularmente.


# --- SECCIÓN 2: Verificar la configuración de remotos ---
# Antes de sincronizar, asegúrate de tener upstream configurado.

# Ver todos los remotos
git remote -v

# Si no ves "upstream", agrégalo:
git remote add upstream https://github.com/AUTOR/proyecto.git

# Verificar de nuevo
git remote -v
# Deberías ver:
# origin    https://github.com/TU-USUARIO/proyecto.git (fetch/push)
# upstream  https://github.com/AUTOR/proyecto.git (fetch/push)


# --- SECCIÓN 3: Sincronizar con fetch + merge ---
#
# Este es el método clásico y más seguro.

# Paso 1: Cambiar a tu rama main local
git checkout main

# Paso 2: Descargar los cambios del repositorio original
# Esto NO modifica tus archivos todavía, solo descarga la información
git fetch upstream

# Paso 3: Fusionar los cambios de upstream/main en tu main local
git merge upstream/main

# Paso 4: Subir los cambios a tu fork en GitHub
git push origin main

# Ahora tu fork en GitHub está actualizado con el proyecto original.


# --- SECCIÓN 4: Sincronizar con fetch + rebase ---
#
# Alternativa al merge. Rebase reescribe el historial para que tus
# commits aparezcan después de los commits de upstream.
# El resultado es un historial más limpio y lineal.

# Paso 1: Cambiar a main
git checkout main

# Paso 2: Descargar cambios de upstream
git fetch upstream

# Paso 3: Rebase en lugar de merge
git rebase upstream/main

# Paso 4: Subir a tu fork (puede necesitar --force si rebase reescribió commits)
git push origin main

# NOTA: Solo usa rebase en main si no tienes commits propios en main
# que no existan en upstream. Si solo usas main para sincronizar
# (que es lo recomendado), no tendrás problemas.


# --- SECCIÓN 5: Sincronizar con git pull --rebase ---
#
# Atajo que combina fetch + rebase en un solo comando.

git checkout main
git pull --rebase upstream main
git push origin main

# Este es el método más rápido y limpio para la mayoría de los casos.


# --- SECCIÓN 6: Sincronizar desde la interfaz web de GitHub ---
#
# GitHub ahora tiene un botón para sincronizar tu fork directamente
# desde la interfaz web:
#
# 1. Ve a tu fork en GitHub (github.com/TU-USUARIO/proyecto)
# 2. Verás un mensaje como: "This branch is X commits behind AUTOR:main"
# 3. Haz clic en "Sync fork"
# 4. Haz clic en "Update branch"
#
# Esto actualiza main en tu fork de GitHub, pero NO tu copia local.
# Después, actualiza tu copia local:
git checkout main
git pull origin main


# --- SECCIÓN 7: Sincronizar con GitHub CLI ---
# Si tienes GitHub CLI instalado, puedes sincronizar así:

gh repo sync TU-USUARIO/proyecto --source AUTOR/proyecto

# O desde dentro de la carpeta del proyecto:
gh repo sync --source AUTOR/proyecto


# --- SECCIÓN 8: Actualizar una rama de trabajo ---
#
# Si estás trabajando en una rama (ej: feature/mi-cambio) y main se
# actualizó, necesitas traer esos cambios a tu rama de trabajo.

# Primero, sincroniza main con upstream
git checkout main
git pull --rebase upstream main

# Luego, trae los cambios de main a tu rama de trabajo
git checkout feature/mi-cambio

# Opción A: Merge (más seguro, crea un commit de merge)
git merge main

# Opción B: Rebase (historial más limpio, pero reescribe commits)
git rebase main

# Si usaste rebase y tu rama ya estaba en GitHub, necesitas force push:
git push --force-with-lease origin feature/mi-cambio

# NOTA: --force-with-lease es más seguro que --force porque verifica
# que nadie más haya subido cambios a tu rama desde la última vez.


# --- SECCIÓN 9: Resolver conflictos al sincronizar ---
#
# Si upstream cambió los mismos archivos que tú modificaste, habrá
# conflictos al hacer merge o rebase.

# Al hacer merge y encontrar conflictos:
git merge upstream/main
# Git te dirá qué archivos tienen conflictos

# 1. Abre los archivos con conflictos
# 2. Busca las marcas de conflicto:
#    <<<<<<< HEAD
#    (tu código)
#    =======
#    (código de upstream)
#    >>>>>>> upstream/main
# 3. Edita el archivo para resolver el conflicto
# 4. Marca el conflicto como resuelto:
git add archivo-resuelto.txt
# 5. Completa el merge:
git commit

# Al hacer rebase y encontrar conflictos:
git rebase upstream/main
# Git se detendrá en cada commit que tenga conflictos
# 1. Resuelve el conflicto
# 2. Agrega los archivos resueltos:
git add archivo-resuelto.txt
# 3. Continúa el rebase:
git rebase --continue
# Si quieres cancelar el rebase:
git rebase --abort


# --- SECCIÓN 10: Rutina de sincronización recomendada ---
#
# Hazlo cada vez que vayas a empezar una nueva contribución:
#
# 1. git checkout main
# 2. git pull --rebase upstream main
# 3. git push origin main
# 4. git checkout -b nueva-rama
# 5. (trabajar en tu contribución)
#
# Esto garantiza que siempre partes del código más reciente.


# =============================================================================
# RESUMEN:
# - Tu fork se queda desactualizado con el tiempo
# - Configura "upstream" apuntando al repositorio original
# - Sincroniza con: git fetch upstream + git merge/rebase upstream/main
# - El método más rápido: git pull --rebase upstream main
# - También puedes sincronizar desde la web de GitHub o con gh repo sync
# - Siempre sincroniza main ANTES de crear una nueva rama de trabajo
# - Usa --force-with-lease si necesitas hacer force push a una rama
# =============================================================================
