# Capítulo 04 — Repositorios básicos

En este capítulo aprenderás qué es un repositorio, cómo crear uno desde cero
en tu computadora, cómo crear uno en GitHub y cómo clonar repositorios existentes.

Los repositorios son la unidad fundamental de Git. Todo tu trabajo vive dentro
de un repositorio. Si entiendes bien este concepto, todo lo demás será más fácil.

---

## ¿Qué es un repositorio?

Un repositorio (o "repo") es una carpeta de proyecto que Git está rastreando.
Contiene todos tus archivos de código más un historial completo de todos los
cambios que se han hecho desde que se creó.

Hay dos tipos de repositorios:
- **Repositorio local** — vive en tu computadora
- **Repositorio remoto** — vive en internet (en GitHub, GitLab, etc.)

Normalmente trabajas en tu repositorio local y luego sincronizas los cambios
con el repositorio remoto.

---

## Formas de obtener un repositorio

1. **`git init`** — Crear uno nuevo desde cero en tu computadora
2. **GitHub → New repository** — Crear uno en GitHub y luego clonarlo
3. **`git clone`** — Descargar una copia de un repositorio que ya existe

---

## Archivos de este capítulo

Ábrelos en este orden:

| Archivo | Qué aprenderás |
|---|---|
| `01_crear_repositorio_local.sh` | Crear un repositorio desde cero con `git init` |
| `02_crear_repositorio_github.sh` | Crear un repositorio en GitHub (instrucciones paso a paso) |
| `03_clonar_repositorio.sh` | Descargar repositorios con `git clone` (HTTPS vs SSH) |
| `04_estructura_repositorio.sh` | Qué hay dentro de la carpeta `.git` y cómo funciona |
| `05_ejercicios.sh` | Ejercicios prácticos para afianzar lo aprendido |

---

## Conceptos clave de este capítulo

- **`git init`** — inicializar un repositorio nuevo en una carpeta
- **`.git/`** — carpeta oculta donde Git guarda todo el historial
- **`git clone`** — descargar una copia completa de un repositorio remoto
- **HTTPS** — protocolo para conectarse a GitHub usando token/contraseña
- **SSH** — protocolo para conectarse a GitHub usando llaves criptográficas
- **`origin`** — nombre por defecto del repositorio remoto

---

> ✅ Cuando termines todos los archivos de esta carpeta, pasa a `05-flujo-básico-git/`
