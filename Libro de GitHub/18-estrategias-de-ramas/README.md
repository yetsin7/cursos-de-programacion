# Capítulo 18 — Estrategias de Ramas

En este capítulo aprenderás las estrategias de ramificación más populares que
usan los equipos profesionales. No existe una estrategia perfecta para todos
los proyectos — cada una tiene ventajas y desventajas según el tamaño del equipo,
la frecuencia de despliegue y el tipo de proyecto.

---

## ¿Por qué importa la estrategia de ramas?

Sin una estrategia clara, los equipos terminan con:
- Conflictos constantes al fusionar código
- Código sin revisar llegando a producción
- Nadie sabe qué rama tiene la versión estable
- Bugs difíciles de rastrear porque no se sabe cuándo se introdujeron

Una buena estrategia de ramas resuelve estos problemas definiendo reglas claras.

---

## Las 3 estrategias principales

| Estrategia | Complejidad | Ideal para |
|---|---|---|
| Git Flow | Alta | Proyectos con releases programados |
| GitHub Flow | Baja | Despliegue continuo, equipos ágiles |
| Trunk-Based | Media | Equipos grandes con CI/CD maduro |

---

## Conventional Commits

Además de la estrategia de ramas, aprenderás **Conventional Commits**, un estándar
para escribir mensajes de commit que permiten automatizar changelogs y versionado.

```
feat: agregar modo oscuro
fix: corregir cálculo de impuestos
docs: actualizar guía de instalación
```

---

## Archivos de este capítulo

Ábrelos en este orden:

| Archivo | Qué aprenderás |
|---|---|
| `01_git_flow.sh` | Modelo Git Flow con sus 5 tipos de ramas |
| `02_github_flow.sh` | GitHub Flow: simple y efectivo |
| `03_trunk_based.sh` | Trunk-Based Development |
| `04_conventional_commits.sh` | Conventional Commits y versionado semántico |
| `05_proteger_ramas.sh` | Reglas de protección de ramas en GitHub |
| `06_ejercicios.sh` | Ejercicios prácticos |

---

## Conceptos clave de este capítulo

- **Git Flow** — estrategia con ramas main, develop, feature, release y hotfix
- **GitHub Flow** — estrategia simple con main y ramas de feature
- **Trunk-Based** — todos trabajan en una sola rama principal (trunk)
- **Conventional Commits** — estándar para mensajes de commit estructurados
- **Semantic Versioning** — sistema de versionado MAJOR.MINOR.PATCH
- **Branch Protection** — reglas que protegen ramas importantes en GitHub

---

> ✅ Cuando termines todos los archivos de esta carpeta, pasa a `19-seguridad/`
