#!/bin/bash
# =============================================================================
# ARCHIVO: 02_sintaxis_gitignore.sh
# TEMA: Sintaxis de .gitignore — Patrones: *, **, /, !, comentarios
# =============================================================================
#
# El .gitignore usa patrones (glob patterns) para definir qué ignorar.
# Entender estos patrones es clave para crear un .gitignore efectivo.
#
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# REGLAS BÁSICAS DE SINTAXIS
# ─────────────────────────────────────────────────────────────────────────────

# 1. Cada línea del .gitignore es un patrón
# 2. Las líneas en blanco se ignoran (sirven para separar secciones)
# 3. Las líneas que comienzan con # son comentarios
# 4. Los espacios al final de la línea se ignoran (a menos que uses \)

cat << 'EJEMPLO'
# Esto es un comentario — Git lo ignora
# Las líneas en blanco también se ignoran

node_modules/
.env
build/
EJEMPLO

echo "========================================="
echo "  REGLAS BÁSICAS"
echo "========================================="
echo ""
echo "  # comentario    → Git lo ignora"
echo "  (línea vacía)   → Se ignora (para organizar)"
echo "  patrón          → Archivos/carpetas a ignorar"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# PATRÓN: NOMBRE DE ARCHIVO EXACTO
# ─────────────────────────────────────────────────────────────────────────────

# Un nombre de archivo sin caracteres especiales ignora ESE archivo
# en CUALQUIER directorio del repositorio.

cat << 'EJEMPLO'
.env            ← Ignora .env en cualquier directorio
debug.log       ← Ignora debug.log en cualquier directorio
Thumbs.db       ← Ignora Thumbs.db en cualquier directorio
EJEMPLO

# ─────────────────────────────────────────────────────────────────────────────
# PATRÓN: ASTERISCO * (WILDCARD)
# ─────────────────────────────────────────────────────────────────────────────

# El asterisco * coincide con cualquier cantidad de caracteres,
# EXCEPTO la barra / (separador de directorios).

cat << 'EJEMPLO'
*.log           ← Ignora TODOS los archivos .log
                   debug.log ✓  error.log ✓  app.log ✓

*.tmp           ← Ignora todos los archivos .tmp

*.class         ← Ignora todos los archivos .class (Java compilado)

test_*          ← Ignora archivos que empiecen con "test_"
                   test_main.py ✓  test_utils.py ✓

*.py[cod]       ← Ignora .pyc, .pyo, .pyd (Python compilado)
EJEMPLO

echo ""
echo "========================================="
echo "  ASTERISCO *"
echo "========================================="
echo ""
echo "  *.log      → Todos los .log"
echo "  *.tmp      → Todos los .tmp"
echo "  test_*     → Todo lo que empiece con test_"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# PATRÓN: SIGNO DE INTERROGACIÓN ? (UN SOLO CARÁCTER)
# ─────────────────────────────────────────────────────────────────────────────

# El ? coincide con EXACTAMENTE un carácter.

cat << 'EJEMPLO'
?.log           ← Ignora a.log, b.log, 1.log (un solo carácter + .log)
                   NO ignora: debug.log (más de un carácter)

file?.txt       ← Ignora file1.txt, fileA.txt
                   NO ignora: file10.txt (dos caracteres después de "file")
EJEMPLO

# ─────────────────────────────────────────────────────────────────────────────
# PATRÓN: CORCHETES [] (RANGO DE CARACTERES)
# ─────────────────────────────────────────────────────────────────────────────

# Los corchetes coinciden con cualquier carácter dentro del rango.

cat << 'EJEMPLO'
*.[oa]          ← Ignora archivos .o y .a (compilados de C)
file[0-9].txt   ← Ignora file0.txt hasta file9.txt
[Bb]uild/       ← Ignora Build/ y build/
EJEMPLO

# ─────────────────────────────────────────────────────────────────────────────
# PATRÓN: BARRA / (DIRECTORIO)
# ─────────────────────────────────────────────────────────────────────────────

# La barra / tiene diferentes significados según su posición:

cat << 'EJEMPLO'
# Barra al FINAL: indica que es un directorio (carpeta)
build/          ← Ignora la carpeta build/ y todo su contenido
node_modules/   ← Ignora la carpeta node_modules/ y todo su contenido
dist/           ← Ignora la carpeta dist/ y todo su contenido

# Barra al INICIO: indica ruta relativa a la raíz del .gitignore
/TODO           ← Ignora TODO solo en la raíz del proyecto
                   /TODO ✓  src/TODO ✗ (no lo ignora)

/build          ← Ignora build solo en la raíz
                   /build ✓  src/build ✗

# Sin barra: coincide en cualquier directorio
build           ← Ignora "build" (archivo o carpeta) en CUALQUIER lugar
                   /build ✓  src/build ✓  lib/build ✓

# Barra en medio: ruta específica
doc/*.pdf       ← Ignora archivos .pdf solo dentro de doc/
                   doc/guia.pdf ✓  doc/sub/guia.pdf ✗
EJEMPLO

echo ""
echo "========================================="
echo "  BARRA /"
echo "========================================="
echo ""
echo "  build/      → Carpeta build (en cualquier lugar)"
echo "  /build      → Solo build en la raíz"
echo "  doc/*.pdf   → Solo .pdf directamente en doc/"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# PATRÓN: DOBLE ASTERISCO ** (CUALQUIER NIVEL DE DIRECTORIOS)
# ─────────────────────────────────────────────────────────────────────────────

# El doble asterisco ** coincide con CUALQUIER número de directorios
# (incluyendo cero directorios). Es uno de los patrones más poderosos.

cat << 'EJEMPLO'
**/logs         ← Ignora carpetas/archivos "logs" en cualquier profundidad
                   logs/ ✓  src/logs/ ✓  a/b/c/logs/ ✓

**/logs/*.log   ← Ignora .log dentro de cualquier carpeta "logs"
                   logs/debug.log ✓  src/logs/error.log ✓

build/**        ← Ignora TODO dentro de build/ (cualquier profundidad)
                   build/app.js ✓  build/assets/img/logo.png ✓

**/*.tmp        ← Ignora archivos .tmp en cualquier directorio
                   (equivalente a *.tmp en la práctica)

src/**/test/    ← Ignora carpetas "test" dentro de src/ a cualquier nivel
                   src/test/ ✓  src/app/test/ ✓  src/a/b/test/ ✓
EJEMPLO

echo ""
echo "========================================="
echo "  DOBLE ASTERISCO **"
echo "========================================="
echo ""
echo "  **/logs         → 'logs' en cualquier profundidad"
echo "  build/**        → Todo dentro de build/"
echo "  src/**/test/    → 'test/' dentro de src/ a cualquier nivel"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# PATRÓN: EXCLAMACIÓN ! (NEGACIÓN / EXCEPCIÓN)
# ─────────────────────────────────────────────────────────────────────────────

# El ! al inicio de un patrón crea una EXCEPCIÓN: indica que ese archivo
# NO debe ser ignorado, incluso si coincide con un patrón anterior.

cat << 'EJEMPLO'
# Ignorar todos los .log EXCEPTO important.log
*.log
!important.log

# Ignorar toda la carpeta build/ EXCEPTO build/index.html
build/
!build/index.html
# ⚠️ CUIDADO: Esto NO funciona como esperas.
# Si ignoras un directorio con /, no puedes negar archivos dentro de él.
# Git ni siquiera mira dentro de directorios ignorados.

# La forma correcta es:
build/*
!build/index.html
# Ahora sí: ignora todo DENTRO de build/, excepto index.html

# Ignorar todos los .env EXCEPTO .env.example
.env*
!.env.example

# Ignorar todo en config/ excepto config/default.json
config/*
!config/default.json
EJEMPLO

# REGLA CLAVE SOBRE NEGACIÓN:
# No puedes negar un archivo dentro de un directorio ignorado.
# Si pones "carpeta/", Git ignora la carpeta completa y no mira dentro.
# Usa "carpeta/*" + "!carpeta/archivo" para excepciones.

echo ""
echo "========================================="
echo "  NEGACIÓN !"
echo "========================================="
echo ""
echo "  *.log             → Ignorar todos los .log"
echo "  !important.log    → EXCEPTO important.log"
echo ""
echo "  ⚠️ No funciona con directorios ignorados con /"
echo "  Usa carpeta/* en vez de carpeta/ para excepciones"
echo ""

# ─────────────────────────────────────────────────────────────────────────────
# RESUMEN DE PATRONES
# ─────────────────────────────────────────────────────────────────────────────

echo "========================================="
echo "  RESUMEN DE PATRONES"
echo "========================================="
echo ""
echo "  #           → Comentario"
echo "  archivo     → Nombre exacto (cualquier directorio)"
echo "  *.ext       → Todos los archivos con extensión .ext"
echo "  ?           → Un solo carácter"
echo "  [abc]       → Cualquier carácter del conjunto"
echo "  carpeta/    → Ignorar directorio completo"
echo "  /archivo    → Solo en la raíz del proyecto"
echo "  **          → Cualquier nivel de directorios"
echo "  !patrón     → Excepción (no ignorar)"
echo ""
