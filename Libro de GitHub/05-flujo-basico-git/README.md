# Capítulo 05 — Flujo Básico de Git

## El ciclo fundamental: modificar, preparar, confirmar

Git funciona con un flujo de trabajo de tres etapas que todo desarrollador debe
dominar. Este ciclo se repite cientos de veces al día y es la base de todo lo
demás que harás con Git.

### Las tres áreas de Git

```
┌──────────────┐     git add     ┌──────────────┐    git commit    ┌──────────────┐
│  Working Dir │ ─────────────▶  │ Staging Area │ ──────────────▶  │  Repository  │
│  (Directorio │                 │  (Área de    │                  │  (Historial  │
│   de trabajo)│ ◀─────────────  │   preparación│                  │   de commits)│
└──────────────┘  git restore    └──────────────┘                  └──────────────┘
```

1. **Working Directory** (Directorio de trabajo): donde editas archivos normalmente
2. **Staging Area** (Área de preparación): donde seleccionas qué cambios incluir
   en el próximo commit
3. **Repository** (Repositorio): el historial permanente de todos los commits

### ¿Por qué existe el Staging Area?

El Staging Area te da **control granular** sobre qué cambios incluir en cada
commit. Imagina que modificaste 5 archivos, pero solo 3 están relacionados con
la misma tarea. Con el staging area puedes hacer un commit limpio con solo esos 3.

### El ciclo en la práctica

```bash
# 1. Verificar qué ha cambiado
git status

# 2. Preparar los cambios que quieres guardar
git add archivo.txt

# 3. Confirmar los cambios con un mensaje descriptivo
git commit -m "Agrega validación de email al formulario"

# 4. Verificar que todo quedó bien
git log --oneline
```

### Buenos mensajes de commit

Un buen mensaje de commit:
- Empieza con un verbo en imperativo: "Agrega", "Corrige", "Elimina", "Refactoriza"
- Es conciso pero descriptivo (máximo 50 caracteres en la primera línea)
- Explica el **por qué**, no solo el **qué**

| Malo ❌ | Bueno ✅ |
|---------|----------|
| `cambios` | `Corrige error de validación en login` |
| `update` | `Agrega soporte para modo oscuro` |
| `fix bug` | `Corrige cálculo de IVA en checkout` |
| `asdfg` | `Elimina dependencia no utilizada lodash` |

---

## Archivos de este capítulo

| Archivo | Tema |
|---------|------|
| `01_git_status.sh` | Verificar el estado del repositorio |
| `02_git_add.sh` | Preparar archivos (staging) |
| `03_git_commit.sh` | Crear commits con buenos mensajes |
| `04_git_log.sh` | Ver el historial de commits |
| `05_git_diff.sh` | Ver diferencias entre versiones |
| `06_flujo_completo.sh` | Ejemplo completo del flujo de trabajo |
| `07_ejercicios.sh` | Ejercicios de práctica |

---

## Cómo usar estos archivos

```bash
# Los archivos .sh contienen comandos de ejemplo con explicaciones detalladas.
# Puedes ejecutarlos directamente (asegúrate de estar en un repositorio Git):
bash 05-flujo-basico-git/01_git_status.sh

# O simplemente léelos y practica los comandos manualmente.
```
