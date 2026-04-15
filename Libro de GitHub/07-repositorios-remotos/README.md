# Capítulo 07 — Repositorios Remotos

## ¿Qué es un repositorio remoto?

Un repositorio remoto es una copia de tu proyecto alojada en un servidor
(como GitHub, GitLab o Bitbucket). Es el punto de conexión entre tu trabajo
local y el mundo exterior.

### ¿Por qué necesitas remotos?

1. **Respaldo**: tu código no solo vive en tu computadora
2. **Colaboración**: otros pueden ver, descargar y contribuir a tu proyecto
3. **Despliegue**: muchos servicios despliegan directamente desde el repositorio
4. **Portabilidad**: puedes trabajar desde cualquier computadora

### Conceptos clave

```
┌────────────────┐                    ┌────────────────┐
│  Tu computadora│    git push ──▶    │    GitHub       │
│  (repositorio  │                    │  (repositorio   │
│   local)       │    ◀── git pull    │   remoto)       │
│                │    ◀── git fetch   │                 │
└────────────────┘                    └────────────────┘
```

- **origin**: nombre por defecto del repositorio remoto principal
- **upstream**: nombre convencional para el repositorio original (en forks)
- **push**: enviar tus commits locales al remoto
- **pull**: descargar commits del remoto y fusionarlos localmente
- **fetch**: descargar commits del remoto SIN fusionar (solo ver)
- **clone**: descargar una copia completa del repositorio remoto

---

## Archivos de este capítulo

| Archivo | Tema |
|---------|------|
| `01_que_es_un_remoto.sh` | Concepto de repositorios remotos |
| `02_git_remote.sh` | Administrar conexiones remotas |
| `03_git_push.sh` | Enviar cambios al remoto |
| `04_git_pull.sh` | Descargar y fusionar cambios |
| `05_git_fetch.sh` | Descargar sin fusionar |
| `06_sincronizar_repositorio.sh` | Flujo completo de sincronización |
| `07_ejercicios.sh` | Ejercicios de práctica |

---

## Cómo usar estos archivos

```bash
bash 07-repositorios-remotos/01_que_es_un_remoto.sh
# O léelos y practica los comandos con un repositorio real en GitHub.
```
