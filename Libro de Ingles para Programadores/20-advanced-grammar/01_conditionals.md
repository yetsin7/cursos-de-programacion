# Condicionales en Inglés para Programadores

## Introducción

Los condicionales son estructuras gramaticales que expresan situaciones
hipotéticas y sus consecuencias. En programación los usamos constantemente:
para describir comportamiento del código, discutir decisiones técnicas y
planificar escenarios. Hay 4 tipos principales.

---

## Zero Conditional: Hechos y verdades generales

### Estructura

```
If + presente simple, presente simple
```

### Uso

Describe algo que **siempre sucede** cuando se cumple la condición.
Es equivalente a una regla o ley. En programación, describe comportamiento
determinístico y predecible.

### Ejemplos en contexto de programación

| Oración | Traducción |
|---------|------------|
| If you push to main, the CI runs automatically. | Si haces push a main, el CI se ejecuta automáticamente. |
| If the input is null, the function throws an error. | Si el input es null, la función lanza un error. |
| If you divide by zero, the program crashes. | Si divides por cero, el programa se cae. |
| If the cache expires, the app fetches fresh data. | Si el caché expira, la app obtiene datos frescos. |
| If a test fails, the pipeline stops. | Si un test falla, el pipeline se detiene. |
| If you don't handle the error, the app crashes. | Si no manejas el error, la app se cae. |

### Nota

Puedes usar **when** en lugar de **if** para el zero conditional,
ya que describe algo que siempre pasa:

```
When you push to main, the CI runs automatically.
When the token expires, the user is logged out.
```

---

## First Conditional: Situaciones probables en el futuro

### Estructura

```
If + presente simple, will + verbo base
```

### Uso

Describe algo que **probablemente sucederá** si se cumple la condición.
Se usa para planes, predicciones y consecuencias reales.

### Ejemplos en contexto de programación

| Oración | Traducción |
|---------|------------|
| If the tests pass, we will deploy to production. | Si los tests pasan, desplegaremos a producción. |
| If we add an index, the query will be faster. | Si añadimos un índice, la consulta será más rápida. |
| If the client approves, we will start the sprint. | Si el cliente aprueba, empezaremos el sprint. |
| If you merge this PR, it will fix the login bug. | Si haces merge de este PR, arreglará el bug de login. |
| If we don't optimize, the app will be too slow. | Si no optimizamos, la app será demasiado lenta. |
| If the API is down, users won't be able to log in. | Si la API está caída, los usuarios no podrán hacer login. |

### Variaciones

Puedes reemplazar **will** con otros modales para cambiar el grado de certeza:

```
If we add caching, it should improve performance. (probable)
If we add caching, it might improve performance. (posible)
If we add caching, it could improve performance. (posible)
If we add caching, it can improve performance. (capacidad)
```

---

## Second Conditional: Situaciones hipotéticas o improbables

### Estructura

```
If + pasado simple, would + verbo base
```

### Uso

Describe situaciones **imaginarias, hipotéticas o improbables** en el presente
o futuro. Se usa mucho para discutir alternativas y decisiones de diseño.

### Ejemplos en contexto de programación

| Oración | Traducción |
|---------|------------|
| If I had more time, I would refactor this module. | Si tuviera más tiempo, refactorizaría este módulo. |
| If we used TypeScript, we would catch more bugs. | Si usáramos TypeScript, atraparíamos más bugs. |
| If I were the tech lead, I would choose Rust. | Si yo fuera el tech lead, elegiría Rust. |
| If the budget allowed, we would hire another dev. | Si el presupuesto lo permitiera, contrataríamos otro dev. |
| If we had a staging environment, we would test there first. | Si tuviéramos un entorno de staging, probaríamos ahí primero. |
| If this were a greenfield project, I would use Next.js. | Si este fuera un proyecto nuevo, usaría Next.js. |

### Nota importante

Con el verbo **to be**, se usa **were** para todos los sujetos en el
second conditional (no "was"):

```
If I were you, I would add more tests.      (correcto)
If he were here, he would know the answer.   (correcto)
If it were up to me, I would use PostgreSQL. (correcto)
```

---

## Third Conditional: Situaciones pasadas imposibles de cambiar

### Estructura

```
If + pasado perfecto (had + participio), would have + participio
```

### Uso

Describe algo que **no sucedió en el pasado** y su consecuencia hipotética.
Se usa para reflexionar sobre errores, bugs y decisiones pasadas.

### Ejemplos en contexto de programación

| Oración | Traducción |
|---------|------------|
| If we had written tests, we would have caught this bug. | Si hubiéramos escrito tests, habríamos atrapado este bug. |
| If I had read the docs, I would have avoided this mistake. | Si hubiera leído la documentación, habría evitado este error. |
| If we had used a framework, we would have saved months. | Si hubiéramos usado un framework, habríamos ahorrado meses. |
| If the PR had been reviewed, the bug wouldn't have reached production. | Si el PR hubiera sido revisado, el bug no habría llegado a producción. |
| If we had planned the architecture, we wouldn't have needed to rewrite. | Si hubiéramos planificado la arquitectura, no habríamos necesitado reescribir. |
| If they had backed up the database, they wouldn't have lost the data. | Si hubieran respaldado la base de datos, no habrían perdido los datos. |

---

## Resumen comparativo

| Tipo | Estructura | Tiempo | Ejemplo |
|------|-----------|--------|---------|
| **Zero** | If + present, present | Siempre | If you push, CI runs |
| **First** | If + present, will + verb | Futuro probable | If tests pass, we'll deploy |
| **Second** | If + past, would + verb | Hipotético presente | If I had time, I'd refactor |
| **Third** | If + past perfect, would have + past participle | Pasado irreal | If we'd tested, we'd have caught it |

---

## Mixed Conditionals

A veces mezclamos tipos de condicionales cuando la condición es de un
tiempo y la consecuencia de otro.

### Condición pasada → Consecuencia presente

```
If we had chosen microservices, we wouldn't be dealing
with this monolith now.
(Si hubiéramos elegido microservicios, no estaríamos
lidiando con este monolito ahora.)

If I had studied computer science, I would be a better
architect today.
```

### Condición presente → Consecuencia pasada

```
If I were a better developer, I would have caught
that bug in the review.
(Si fuera un mejor desarrollador, habría atrapado
ese bug en la revisión.)
```

---

## Condicionales en código vs en inglés

Es interesante notar el paralelo entre condicionales del inglés y del código:

```javascript
// Zero conditional → Siempre sucede
if (input === null) throw new Error();

// First conditional → Probablemente sucederá
// "If the user clicks submit, the form will validate"
submitBtn.addEventListener('click', () => form.validate());

// Second conditional → Hipotético (no existe en código directamente)
// Se expresa en comentarios y discusiones:
// "If we had a cache layer, this would be much faster"

// Third conditional → Reflexión post-mortem
// "If we had added input validation, the injection
//  wouldn't have happened"
```

> **Consejo:** Los condicionales aparecen en code reviews, post-mortems,
> planning meetings y documentación de arquitectura. Practica usándolos
> al discutir decisiones técnicas.
