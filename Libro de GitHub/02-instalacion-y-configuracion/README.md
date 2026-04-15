# Capítulo 02 — Instalación y configuración de Git

En este capítulo aprenderás a instalar Git en tu sistema operativo y a configurarlo
correctamente para empezar a trabajar. La configuración inicial es importante porque
cada commit que hagas llevará tu nombre y correo electrónico.

---

## ¿Cómo instalar Git?

### Windows
1. Ve a [https://git-scm.com/downloads](https://git-scm.com/downloads)
2. Descarga el instalador para Windows
3. Ejecuta el instalador
4. Las opciones por defecto están bien para la mayoría de usuarios
5. **Recomendado:** selecciona "Use Visual Studio Code as Git's default editor" si usas VS Code

### macOS
- **Opción 1 (Homebrew):** `brew install git`
- **Opción 2:** Descarga desde [https://git-scm.com/downloads](https://git-scm.com/downloads)
- **Opción 3:** Instala Xcode Command Line Tools: `xcode-select --install`

### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install git
```

### Linux (Fedora)
```bash
sudo dnf install git
```

---

## Configuración inicial obligatoria

Después de instalar Git, lo PRIMERO que debes hacer es configurar tu nombre
y correo electrónico. Git usa esta información en cada commit que hagas.

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

---

## Archivos de este capítulo

Ábrelos en este orden:

| Archivo | Qué aprenderás |
|---|---|
| `01_instalar_git.sh` | Verificar que Git está correctamente instalado |
| `02_configuracion_inicial.sh` | Configurar nombre, correo, editor y rama por defecto |
| `03_configuracion_avanzada.sh` | Aliases, colores, credential helper y más |
| `04_verificar_instalacion.sh` | Comprobar que todo quedó correctamente configurado |

---

## Conceptos clave de este capítulo

- **`git config`** — comando para configurar opciones de Git
- **`--global`** — aplica la configuración a todos tus repositorios
- **`--local`** — aplica la configuración solo al repositorio actual
- **Alias** — atajo personalizado para un comando largo
- **Credential helper** — herramienta que guarda tus contraseñas para no escribirlas cada vez

---

> ✅ Cuando termines todos los archivos de esta carpeta, pasa a `03-crear-cuenta-github/`
