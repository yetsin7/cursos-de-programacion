# Capítulo 13 — Conflictos en Git

## ¿Por qué ocurren los conflictos?

Cuando dos personas (o dos ramas) modifican **las mismas líneas** del mismo archivo,
Git no puede decidir automáticamente cuál versión conservar. En ese momento Git se
detiene y te pide que resuelvas el conflicto manualmente.

### Situaciones comúnes que generan conflictos

```
Rama main:        línea 10 = "color: azul"
Rama feature:     línea 10 = "color: rojo"
                         ↓
                    ¡CONFLICTO!
        Git no sabe cuál versión elegir
```

1. **Dos ramas modifican la misma línea** — el caso más común
2. **Un archivo fue editado en una rama y eliminado en otra**
3. **Dos ramas crean un archivo con el mismo nombre** pero diferente contenido
4. **Rebase sobre una rama que divergió mucho** del punto original

### ¿Cuándo NO hay conflicto?

Si dos ramas modifican **líneas diferentes** del mismo archivo, Git puede fusionar
automáticamente sin problemas. Los conflictos solo aparecen cuando Git no puede
tomar la decisión por ti.

---

## Marcadores de conflicto

Cuando Git detecta un conflicto, inserta marcadores especiales en el archivo:

```
<<<<<<< HEAD
Tu versión actual (la rama donde estás)
=======
La versión entrante (la rama que estás fusionando)
>>>>>>> nombre-de-la-rama
```

- `<<<<<<< HEAD` — inicio de tu versión actual
- `=======` — separador entre las dos versiones
- `>>>>>>> rama` — fin de la versión entrante

### Estrategias de resolución

| Estrategia | Cuándo usarla |
|------------|---------------|
| Conservar tu versión | Cuando tu código es el correcto |
| Aceptar la versión entrante | Cuando el otro cambio es mejor |
| Combinar ambas versiones | Cuando ambos cambios son necesarios |
| Reescribir completamente | Cuando ninguna versión es adecuada |

### Buenas prácticas para prevenir conflictos

- Haz **pull frecuentemente** para mantener tu rama actualizada
- Trabaja en **archivos diferentes** cuando sea posible
- Usa **ramas cortas** — entre más tiempo viva una rama, más probable es un conflicto
- Comunica con tu equipo qué archivos estás modificando
- Haz **commits pequeños y frecuentes**

---

## Archivos de este capítulo

| Archivo | Tema |
|---------|------|
| `01_que_son_conflictos.sh` | Qué causa los conflictos de merge |
| `02_identificar_conflictos.sh` | Leer marcadores de conflicto |
| `03_resolver_conflictos.sh` | Resolución manual paso a paso |
| `04_resolver_con_herramientas.sh` | VS Code merge editor, git mergetool |
| `05_prevenir_conflictos.sh` | Buenas prácticas para minimizar conflictos |
| `06_ejercicios.sh` | Escenarios de práctica |

---

## Cómo usar estos archivos

```bash
# Los archivos .sh contienen comandos de ejemplo con explicaciones detalladas.
# Puedes ejecutarlos o leerlos y practicar los comandos manualmente.
bash 13-conflictos/01_que_son_conflictos.sh
```
