# Capítulo 06 — Ramas (Branches)

## ¿Qué son las ramas?

Las ramas son una de las características más poderosas de Git. Una rama es
simplemente un **puntero ligero a un commit**. Cuando creas una rama, Git
no copia archivos: solo crea un puntero nuevo que puedes mover independientemente.

### Analogía: el árbol

Imagina tu proyecto como un árbol:

- El **tronco** es la rama `main` (la línea principal de desarrollo)
- Cada **rama** sale del tronco y crece de forma independiente
- Las ramas pueden **fusionarse** de vuelta al tronco cuando el trabajo está listo
- Mientras trabajas en una rama, el tronco sigue intacto

```
        ── o ── o ── o   (feature/login)
       /
o ── o ── o ── o ── o    (main)
       \
        ── o ── o         (fix/bug-123)
```

### El puntero HEAD

**HEAD** es un puntero especial que indica **en qué rama estás trabajando ahora**.
Cuando haces un commit, HEAD avanza automáticamente junto con la rama activa.

```
Antes del commit:              Después del commit:

o ── o ── o  (main)            o ── o ── o ── o  (main)
              ^                                ^
             HEAD                             HEAD
```

### ¿Por qué usar ramas?

1. **Trabajo aislado**: cada funcionalidad o corrección tiene su propio espacio
2. **Experimentación segura**: puedes probar ideas sin afectar el código estable
3. **Trabajo en equipo**: cada persona trabaja en su rama sin conflictos
4. **Historial limpio**: cada rama cuenta una historia coherente

---

## Archivos de este capítulo

| Archivo | Tema |
|---------|------|
| `01_que_son_ramas.sh` | Concepto de ramas con comandos |
| `02_crear_ramas.sh` | Crear ramas nuevas |
| `03_cambiar_de_rama.sh` | Moverse entre ramas |
| `04_fusionar_ramas.sh` | Fusionar ramas (merge) |
| `05_eliminar_ramas.sh` | Eliminar ramas |
| `06_listar_ramas.sh` | Listar y explorar ramas |
| `07_ejercicios.sh` | Ejercicios de práctica |

---

## Cómo usar estos archivos

```bash
bash 06-ramas/01_que_son_ramas.sh
# O léelos y practica los comandos manualmente en un repositorio de prueba.
```
