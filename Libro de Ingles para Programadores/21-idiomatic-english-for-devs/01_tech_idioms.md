# Tech Idioms - Modismos Tecnologicos

## Introduccion

En el mundo del desarrollo de software existe un vocabulario idiomatico unico. Estas expresiones no se aprenden en cursos de ingles tradicionales, pero son esenciales para comunicarte con equipos internacionales, entender discusiones en GitHub, y participar en la cultura tech.

---

## Modismos de desarrollo y despliegue

| Modismo | Significado en espanol | Ejemplo |
|---------|----------------------|---------|
| **Ship it** | Desplegar, lanzar, publicar | *"The feature is ready. Let's ship it!"* |
| **Dogfooding** | Usar tu propio producto internamente | *"We're dogfooding the new API before releasing it."* |
| **Bikeshedding** | Discutir trivialidades ignorando lo importante | *"We spent an hour bikeshedding over button colors."* |
| **Yak shaving** | Hacer tareas previas interminables antes de la real | *"I needed to fix the tests, but ended up yak shaving for two days."* |

### Ejemplos en contexto

```
// En un pull request:
"LGTM, ship it!" 
// (Looks Good To Me, despliegalo)

// En una reunion:
"Can we stop bikeshedding about the font size 
and focus on the database migration?"

// En un standup:
"I started yak shaving — I needed to update one dependency, 
which required upgrading Node, which broke three other packages..."
```

---

## Modismos de calidad de codigo

| Modismo | Significado en espanol | Ejemplo |
|---------|----------------------|---------|
| **Spaghetti code** | Codigo desordenado y dificil de seguir | *"This legacy module is pure spaghetti code."* |
| **Tech debt** | Deuda tecnica acumulada | *"We need a sprint to pay down our tech debt."* |
| **Code smell** | Indicador de un problema en el codigo | *"That 500-line function is a major code smell."* |
| **Boilerplate** | Codigo repetitivo necesario pero no interesante | *"This framework has too much boilerplate."* |
| **Syntactic sugar** | Sintaxis que simplifica sin cambiar funcionalidad | *"Async/await is syntactic sugar over Promises."* |

### Ejemplos en contexto

```python
# Spaghetti code - dificil de seguir
def process(d):
    if d:
        for i in d:
            if i > 0:
                for j in range(i):
                    if j % 2 == 0:
                        # ... 15 niveles mas de anidamiento

# Codigo limpio - facil de seguir
def process_positive_items(data: list[int]) -> list[int]:
    positive = filter_positive(data)
    return expand_even_range(positive)
```

```
// Code review comment:
"This function is a code smell — it does too many things. 
Let's split it following the Single Responsibility Principle."
```

---

## Modismos de debugging y solucion de problemas

| Modismo | Significado en espanol | Ejemplo |
|---------|----------------------|---------|
| **Rubber duck debugging** | Explicar el problema en voz alta para resolverlo | *"I was stuck for hours, then rubber duck debugging solved it in 5 min."* |
| **Footgun** | Herramienta o feature que facilita cometer errores | *"That API is a total footgun — it silently deletes data."* |
| **Nuke it** | Borrar todo y empezar de cero | *"The config is so broken, let's just nuke it and start over."* |
| **Nuke it from orbit** | Version extrema de nuke it (borrar absolutamente todo) | *"The dev environment is cursed. Nuke it from orbit."* |
| **It works on my machine** | Excusa clasica cuando algo falla en otro entorno | *"It works on my machine!" — "Then we'll ship your machine."* |

### Ejemplos en contexto

```
// En Slack:
"I've been debugging this for 3 hours. Time for some 
rubber duck debugging. Hey @duck, so the request hits 
the middleware and then..."

// En un PR:
"This optional parameter is a footgun — if someone passes 
null, it wipes the entire user profile."

// En una reunion:
Dev: "It works on my machine."
Lead: "That's why we use Docker."
```

---

## Modismos filosoficos y de principios

| Modismo | Significado en espanol | Ejemplo |
|---------|----------------------|---------|
| **Move fast and break things** | Priorizar velocidad sobre estabilidad | *"Our startup culture is move fast and break things."* |
| **Don't reinvent the wheel** | No rehacer lo que ya existe | *"There's a library for that. Don't reinvent the wheel."* |
| **Premature optimization is the root of all evil** | No optimizar antes de tiempo | *"You're caching before having users. Premature optimization..."* |
| **There are only two hard things in CS** | Cache invalidation y naming things | *"Spent 30 min naming this variable. Two hard things in CS..."* |

### La cita completa de las "dos cosas dificiles"

```
"There are only two hard things in Computer Science: 
cache invalidation and naming things."
— Phil Karlton

// Variaciones humoristicas de la comunidad:
"There are only two hard things in CS: 
cache invalidation, naming things, and off-by-one errors."

"There are only 2 hard problems in CS: 
cache invalidation, naming things, and scope creep, 
and keeping requirements stable, and..."
```

---

## Modismos en accion: conversacion simulada

```
// Sprint planning meeting:

Tech Lead: "OK team, we have a lot of tech debt in the 
payments module. The code is spaghetti code and it's becoming 
a footgun for new developers."

Dev 1: "Should we nuke it and rewrite from scratch?"

Tech Lead: "Let's not reinvent the wheel. We can refactor 
incrementally. Don't forget — premature optimization is the 
root of all evil."

Dev 2: "I agree. Last time we tried to ship it fast — move 
fast and break things — we ended up with more tech debt."

Dev 1: "Fair point. But can we at least stop bikeshedding 
about the variable names and start coding?"

Tech Lead: "Deal. But naming IS one of the two hard things 
in computer science."
```

---

## Tabla resumen rapida

| Modismo | Categoria | Uso |
|---------|-----------|-----|
| Ship it | Despliegue | Lanzar codigo |
| Dogfooding | Producto | Usar tu propio producto |
| Bikeshedding | Reuniones | Discutir trivialidades |
| Yak shaving | Productividad | Prerequisitos infinitos |
| Rubber duck debugging | Debugging | Explicar para resolver |
| Spaghetti code | Calidad | Codigo desordenado |
| Tech debt | Calidad | Deuda tecnica |
| Code smell | Calidad | Indicador de problema |
| Boilerplate | Codigo | Codigo repetitivo |
| Syntactic sugar | Codigo | Sintaxis simplificada |
| Footgun | Diseno | Feature peligrosa |
| Nuke it | Solucion | Borrar todo |
| It works on my machine | Debugging | Excusa clasica |
| Move fast and break things | Filosofia | Velocidad sobre estabilidad |
| Don't reinvent the wheel | Filosofia | Reusar lo existente |
| Premature optimization... | Filosofia | No optimizar antes de tiempo |
| Two hard things in CS | Humor | Cache y naming |

---

## Consejo practico

> Estos modismos se usan constantemente en code reviews, Slack, reuniones y documentacion tecnica. No los traduzcas literalmente al espanol — aprende a reconocerlos y usarlos en ingles directamente. Son parte de la identidad cultural del desarrollo de software.
