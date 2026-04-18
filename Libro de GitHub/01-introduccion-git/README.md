# Capítulo 01 — Introducción a Git

Este capitulo construye la base mental correcta para no usar Git como una lista
de comandos memorizados. Aqui vas a entender que problema resuelve y como piensa
Git internamente.

---

## ¿Que aprenderas?

Al terminar deberias poder explicar:

- que es control de versiones;
- que diferencia hay entre Git y GitHub;
- por que Git funciona localmente;
- que son working directory, staging area y repository;
- por que `git status` es tan importante.

---

## ¿Que problema resuelve Git?

Sin Git, muchas personas terminan con copias asi:

```text
proyecto_final
proyecto_final_bueno
proyecto_final_ahora_si
proyecto_final_definitivo
```

Eso genera confusion, perdida de tiempo y errores al colaborar. Git automatiza
el historial y permite volver atras con control.

---

## ¿Que es Git?

Git es un sistema de control de versiones distribuido. Vive en tu computadora y
guarda el historial en una carpeta oculta llamada `.git`.

Eso significa que:

- puedes trabajar sin internet;
- cada cambio puede quedar registrado;
- puedes crear ramas y commits;
- puedes recuperar versiones anteriores.

---

## ¿Que es GitHub?

GitHub es un servicio en la nube que aloja repositorios Git y agrega herramientas
de colaboracion: interfaz web, pull requests, issues, actions y mas.

**Idea corta:** Git es la herramienta. GitHub es una plataforma construida sobre
esa herramienta.

---

## ¿Que pasa dentro del software cuando usas Git?

Cuando usas comandos como `git add` o `git commit`, Git actualiza su base de
datos local:

- registra cambios;
- crea objetos internos;
- mueve archivos entre areas logicas;
- actualiza referencias del historial.

Por eso Git no es solo "subir archivos": es administrar historia y estados.

---

## Archivos de este capítulo

| Archivo | Que aprenderas |
|---|---|
| `01_que_es_git.sh` | Primer contacto con Git y ayuda integrada |
| `02_terminologia_basica.sh` | Palabras clave del flujo diario |
| `03_como_funciona_git.sh` | Las 3 areas de Git y el flujo real de trabajo |

---

## Errores comunes del principiante

- creer que Git y GitHub son lo mismo;
- usar comandos sin leer `git status`;
- pensar que Git solo sirve para subir a internet;
- no entender que `.git` guarda el historial local;
- memorizar sin entender el flujo entre areas.

---

## Practica guiada

1. Ejecuta cada comando uno por uno.
2. Lee la salida de la terminal despues de cada paso.
3. Intenta explicar en que area esta cada archivo.
4. Repite el flujo hasta poder decirlo sin mirar.

> ✅ Cuando termines esta carpeta, pasa a `02-instalacion-y-configuracion/`.
