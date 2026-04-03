# Slang and Informal English - Jerga y lenguaje informal en tech

## Introduccion

Ademas de los modismos y phrasal verbs, existe una capa de jerga informal y humor que es fundamental en la cultura de desarrollo. Estas expresiones aparecen en memes, Slack, Twitter/X, Reddit, comentarios de codigo y conversaciones entre colegas. Conocerlas te ayuda a integrarte en equipos y entender la cultura tech.

---

## Frases clasicas de la cultura dev

| Frase | Significado | Contexto |
|-------|-------------|----------|
| **"It's a feature, not a bug"** | Algo que parece error se presenta como intencional | Humor cuando algo no funciona como se esperaba |
| **"404 brain not found"** | No puedo pensar / estoy agotado mentalmente | Cuando llevas muchas horas programando |
| **"PEBKAC"** | Problem Exists Between Keyboard And Chair (el usuario es el problema) | Soporte tecnico humoristico |
| **"sudo make me a sandwich"** | Referencia a permisos de administrador (xkcd) | Humor sobre privilegios en Linux |
| **"There's no place like 127.0.0.1"** | Juego de palabras: "no hay lugar como el hogar" (localhost) | Referencia a "The Wizard of Oz" + networking |

### Origen y contexto

```
// "It's a feature, not a bug"
// Origen: frase clasica de soporte tecnico/marketing
// Uso moderno: cuando un comportamiento inesperado se justifica

PM: "Why does the app close when I swipe left?"
Dev: "It's a feature, not a bug."

// "sudo make me a sandwich" (del comic xkcd #149)
// Origen: En Linux, 'sudo' da permisos de superusuario
User: "Make me a sandwich."
Computer: "No."
User: "sudo make me a sandwich."
Computer: "OK."

// "There's no place like 127.0.0.1"
// 127.0.0.1 = localhost = tu propia maquina = "home"
// Se ve en camisetas, stickers y perfiles de GitHub
```

---

## Jerga sobre calidad y soluciones

| Termino | Significado | Ejemplo |
|---------|-------------|---------|
| **Janky** | Inestable, de mala calidad, fragil | *"The deployment script is super janky."* |
| **Hacky** | Solucion improvisada, no elegante | *"It's a hacky solution but it works."* |
| **Quick and dirty fix** | Arreglo rapido sin buenas practicas | *"I did a quick and dirty fix for now."* |
| **Footgun** | Algo que facilita dispararte en el pie | *"That config option is a total footgun."* |
| **Blazingly fast** | Extremadamente rapido (a veces ironico) | *"Our new Rust service is blazingly fast."* |
| **Crunching** | Trabajar horas extras intensas | *"The team is crunching before the release."* |
| **Grinding** | Trabajar de forma continua y persistente | *"I've been grinding on this bug all week."* |

### Ejemplos en contexto

```javascript
// Codigo "hacky" - funciona pero no es ideal
// HACK: SetTimeout para esperar a que el DOM se actualice
setTimeout(() => {
  document.getElementById('modal').style.display = 'block';
}, 100);

// Codigo "janky" - fragil e impredecible
function getUser(id) {
  // A veces retorna null, a veces undefined, a veces throws
  // TODO: This is janky, needs proper error handling
  return db.query(`SELECT * FROM users WHERE id = ${id}`);
}
```

```
// En Slack:
"Hey, I pushed a quick and dirty fix for the login bug. 
It works but we should refactor it properly next sprint."

// En un code review:
"This regex is a footgun — one wrong character and it 
matches everything in the database."
```

---

## Jerga sobre el estado mental del desarrollador

| Expresion | Significado | Ejemplo |
|-----------|-------------|---------|
| **I'm in the zone** | Estoy concentrado al maximo | *"Don't interrupt me, I'm in the zone."* |
| **I'm in the flow** | Estado de concentracion optima (flow state) | *"I was in the flow and fixed 5 bugs in an hour."* |
| **404 brain not found** | Mi cerebro no funciona | *"It's Friday 5 PM, 404 brain not found."* |
| **I'm fried** | Estoy mentalmente agotado | *"After that 8-hour debug session, I'm fried."* |
| **Nerd sniped** | Distraido por un problema interesante | *"I got nerd sniped by a sorting algorithm challenge."* |

```
// Conversacion tipica en Slack:
Dev 1: "Hey, can you review my PR?"
Dev 2: "Give me 30 min, I'm in the zone right now."
Dev 1: "No rush. I'm 404 brain not found anyway."

// Despues de un deploy nocturno:
"I've been crunching all weekend. 
I'm completely fried. Don't trust any code I write today."
```

---

## Acronimos y abreviaciones informales

| Acronimo | Significado completo | Uso |
|----------|---------------------|-----|
| **PEBKAC** | Problem Exists Between Keyboard And Chair | El usuario es el problema |
| **LGTM** | Looks Good To Me | Aprobacion en code review |
| **TL;DR** | Too Long; Didn't Read | Resumen de algo extenso |
| **RTFM** | Read The F***ing Manual | Lee la documentacion |
| **WIP** | Work In Progress | Trabajo en curso |
| **YAGNI** | You Ain't Gonna Need It | No construyas lo que no necesitas |
| **DRY** | Don't Repeat Yourself | No dupliques codigo |
| **KISS** | Keep It Simple, Stupid | Mantenlo simple |
| **IMO / IMHO** | In My (Humble) Opinion | En mi opinion |
| **AFK** | Away From Keyboard | No estoy en la computadora |
| **ELI5** | Explain Like I'm 5 | Explicalo de forma simple |

```
// En un code review:
Reviewer: "LGTM! Ship it."

// En un PR description:
"TL;DR: Refactored the auth module to use JWT tokens."

// En Slack:
"I'll be AFK for lunch. Back in 30."

// En una discusion tecnica:
"IMO we should follow YAGNI here — we don't need 
a microservice architecture for 100 users."
```

---

## Humor tecnico en conversaciones reales

```
// Situacion 1: Bug misterioso
Dev: "The tests pass locally but fail in CI."
Lead: "Classic. It works on my machine!"
Dev: "Maybe we should ship my machine to production."

// Situacion 2: Solucion temporal
Dev: "I found a hacky workaround for the API timeout."
Lead: "How hacky are we talking?"
Dev: "Quick and dirty. Held together with duct tape and prayers."
Lead: "Sounds janky. Let's add a TODO and fix it properly."

// Situacion 3: Optimizacion prematura
Junior: "I rewrote the search in Rust. It's blazingly fast now!"
Senior: "We have 12 users."
Junior: "But it processes queries in 0.001ms instead of 2ms!"
Senior: "YAGNI. Premature optimization is the root of all evil."

// Situacion 4: Soporte tecnico
Support: "User says the app doesn't work."
Dev: "What error message?"
Support: "They say 'the screen is black.'"
Dev: "Is the monitor turned on?"
Support: "...PEBKAC confirmed."
```

---

## Cuando usar (y cuando NO usar) jerga informal

| Contexto | Usar jerga? | Ejemplo |
|----------|-------------|---------|
| Slack con tu equipo | Si | *"LGTM, ship it!"* |
| Code review entre colegas | Si, moderadamente | *"This is a bit hacky, consider refactoring."* |
| Comentarios de codigo internos | Si, con moderacion | *`// HACK: quick and dirty fix for #123`* |
| Email a tu manager | Con cuidado | *"We have some technical debt to address."* |
| Documentacion oficial | No | *"The API has a known limitation..."* (no "janky") |
| Presentacion a stakeholders | No | *"We need to invest in code quality."* |
| Entrevista de trabajo | Muy poco | Muestra que conoces la cultura pero se profesional |

---

## Consejo final

> La jerga informal es como las especias en la cocina: en la cantidad correcta mejora todo, pero en exceso arruina el plato. Aprende estas expresiones para **entenderlas** siempre, pero usalas solo en los contextos apropiados. Un "LGTM, ship it!" en un code review es perfecto; un "this code is janky AF" en un email al cliente no lo es.
