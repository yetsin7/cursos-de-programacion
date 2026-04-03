# Exercises - Ejercicios del Capitulo 21

## Ejercicio 1: Identifica el modismo

Lee cada situacion y selecciona el modismo correcto.

**1.** Tu equipo paso 45 minutos discutiendo si el boton deberia ser azul o verde, mientras el servidor estaba caido.

- a) Yak shaving
- b) Bikeshedding
- c) Dogfooding
- d) Rubber duck debugging

**2.** Necesitabas actualizar una dependencia, pero eso requirio actualizar el compilador, que requirio cambiar el SO, que requirio comprar un nuevo disco duro.

- a) Bikeshedding
- b) Tech debt
- c) Yak shaving
- d) Ship it

**3.** Tu empresa usa su propia app de gestion de proyectos internamente para organizar el trabajo.

- a) Spaghetti code
- b) Boilerplate
- c) Dogfooding
- d) Footgun

**4.** El archivo principal tiene 2,000 lineas, funciones de 300 lineas y variables llamadas `x`, `temp` y `data2`.

- a) Syntactic sugar
- b) Spaghetti code
- c) Boilerplate
- d) Tech debt

**5.** Un companero te explica su problema en voz alta y de repente dice "espera, ya se cual es el error."

- a) Nuke it from orbit
- b) Ship it
- c) Rubber duck debugging
- d) Footgun

---

## Ejercicio 2: Completa con el phrasal verb correcto

Usa los phrasal verbs del banco de palabras:

> **spin up | roll back | set up | log in | opt out | phase out | look into | run into | figure out | back up**

1. "Can you ________ a new test environment for QA?"
2. "The deploy broke production. We need to ________ immediately."
3. "Please ________ with your company email address."
4. "I'll ________ the memory leak after lunch."
5. "Don't forget to ________ the database before running migrations."
6. "Users can ________ of email notifications in settings."
7. "We're going to ________ the old API by end of year."
8. "I ________ a strange bug with timezone handling."
9. "Let me ________ the development environment on my new laptop."
10. "I can't ________ why the tests pass locally but fail in CI."

---

## Ejercicio 3: Formal vs Informal

Reescribe cada frase informal usando lenguaje profesional apropiado para un email a stakeholders.

**1.** *"The codebase is total spaghetti code and super janky."*

Tu version formal: _______________________________________________

**2.** *"We should just nuke it from orbit and start over."*

Tu version formal: _______________________________________________

**3.** *"That API endpoint is a footgun — it'll bite us eventually."*

Tu version formal: _______________________________________________

**4.** *"We did a quick and dirty fix, it's hacky but it works."*

Tu version formal: _______________________________________________

**5.** *"The team's been crunching all week and everyone's fried."*

Tu version formal: _______________________________________________

---

## Ejercicio 4: Traduce la conversacion

Traduce esta conversacion de Slack al espanol, manteniendo el significado de cada modismo y phrasal verb.

```
Alice: "Hey team, I just spun up a new staging environment. 
Can someone help me set up the database?"

Bob: "Sure! Let me check out the migration branch. Should I 
back up the current DB first?"

Alice: "Always. Once that's done, we'll roll out v2.1."

Carol: "Heads up — I ran into a weird bug in the auth module. 
I'll look into it this afternoon."

Bob: "Is it a blocker? Should we bring it up at standup?"

Carol: "Not a blocker, but the code is pretty janky. We have 
some tech debt to pay down."

Alice: "Let's come up with a plan. For now, ship the current 
version and we'll figure out the auth issue next sprint."
```

Tu traduccion:
_______________________________________________

---

## Ejercicio 5: Escribe el acronimo

Escribe el acronimo correspondiente a cada definicion.

| Definicion | Acronimo |
|-----------|----------|
| Se ve bien, aprobado | ________ |
| Demasiado largo, no lo lei (resumen) | ________ |
| Lee el manual | ________ |
| Trabajo en progreso | ________ |
| No vas a necesitarlo | ________ |
| No te repitas | ________ |
| Mantenlo simple | ________ |
| El problema esta entre la silla y el teclado | ________ |
| No estoy en la computadora | ________ |
| Explicalo como si tuviera 5 anos | ________ |

---

## Ejercicio 6: Contexto apropiado

Indica si usarias la expresion en cada contexto (Si / No).

| Expresion | Slack con equipo | Code review | Email al CTO | Documentacion |
|-----------|-----------------|-------------|--------------|---------------|
| "LGTM, ship it!" | | | | |
| "This is janky" | | | | |
| "We have tech debt" | | | | |
| "Nuke it from orbit" | | | | |
| "PEBKAC" | | | | |
| "Blazingly fast" | | | | |
| "Quick and dirty fix" | | | | |

---

## Ejercicio 7: Escribe un mensaje de Slack

Escribe un mensaje de Slack para cada situacion usando al menos 2 modismos o phrasal verbs de este capitulo.

**Situacion 1:** Acabas de desplegar una nueva version y encontraste un bug critico.

Tu mensaje: _______________________________________________

**Situacion 2:** Quieres proponer reescribir un modulo legacy que nadie entiende.

Tu mensaje: _______________________________________________

**Situacion 3:** Terminaste de investigar un bug y encontraste la causa.

Tu mensaje: _______________________________________________

---

## Respuestas

### Ejercicio 1
1. b) Bikeshedding
2. c) Yak shaving
3. c) Dogfooding
4. b) Spaghetti code
5. c) Rubber duck debugging

### Ejercicio 2
1. spin up  2. roll back  3. log in  4. look into  5. back up
6. opt out  7. phase out  8. ran into  9. set up  10. figure out

### Ejercicio 5
LGTM, TL;DR, RTFM, WIP, YAGNI, DRY, KISS, PEBKAC, AFK, ELI5

### Ejercicio 6 (respuestas sugeridas)

| Expresion | Slack | Review | Email CTO | Docs |
|-----------|-------|--------|-----------|------|
| "LGTM, ship it!" | Si | Si | No | No |
| "This is janky" | Si | Si | No | No |
| "We have tech debt" | Si | Si | Si | Si |
| "Nuke it from orbit" | Si | No | No | No |
| "PEBKAC" | Si | No | No | No |
| "Blazingly fast" | Si | Si | No | No |
| "Quick and dirty fix" | Si | Si | No | No |
