# Phrasal Verbs in Tech - Verbos frasales en tecnologia

## Introduccion

Los phrasal verbs (verbos frasales) son combinaciones de un verbo + una particula (preposicion o adverbio) que crean un significado diferente al del verbo original. En el mundo tech, son absolutamente esenciales. Sin dominarlos, no podras seguir conversaciones tecnicas ni leer documentacion con fluidez.

---

## Autenticacion y acceso

| Phrasal Verb | Significado | Ejemplo |
|-------------|-------------|---------|
| **log in** | Iniciar sesion | *"Log in with your GitHub account."* |
| **log out** | Cerrar sesion | *"Remember to log out when using shared computers."* |
| **sign up** | Registrarse | *"Sign up for a free tier account."* |
| **opt in** | Aceptar participar voluntariamente | *"Users must opt in to receive notifications."* |
| **opt out** | Rechazar/salir voluntariamente | *"You can opt out of data collection in settings."* |

```javascript
// Ejemplo en codigo
async function handleAuth(action) {
  switch(action) {
    case 'sign-up':    return createAccount();   // Registrarse
    case 'log-in':     return authenticate();     // Iniciar sesion
    case 'log-out':    return destroySession();   // Cerrar sesion
    case 'opt-in':     return enableFeature();    // Aceptar participar
    case 'opt-out':    return disableFeature();   // Rechazar
  }
}
```

---

## Infraestructura y servidores

| Phrasal Verb | Significado | Ejemplo |
|-------------|-------------|---------|
| **set up** | Configurar, instalar | *"Let me set up the development environment."* |
| **spin up** | Iniciar/crear una instancia rapidamente | *"Spin up a new container for testing."* |
| **tear down** | Destruir/eliminar infraestructura | *"Tear down the staging environment after tests."* |
| **stand up** | Levantar/crear (un servidor o servicio) | *"We need to stand up a new Redis instance."* |
| **boot up** | Arrancar/encender | *"The server takes 30 seconds to boot up."* |
| **shut down** | Apagar completamente | *"Shut down the server before maintenance."* |
| **scale up** | Aumentar capacidad/recursos | *"Scale up the cluster during Black Friday."* |
| **scale down** | Reducir capacidad/recursos | *"Scale down after peak hours to save costs."* |
| **back up** | Hacer una copia de respaldo | *"Back up the database before migrating."* |

```yaml
# Ejemplo en Docker Compose / CI pipeline
# set up    -> docker-compose up
# tear down -> docker-compose down
# spin up   -> docker run (crear contenedor rapido)
# shut down -> docker stop
# back up   -> pg_dump database > backup.sql

# Ejemplo en conversacion:
# "Can you spin up a staging environment so QA can test?"
# "Don't forget to tear down the test cluster after."
```

---

## Despliegue y versionamiento

| Phrasal Verb | Significado | Ejemplo |
|-------------|-------------|---------|
| **roll out** | Desplegar gradualmente | *"We'll roll out the feature to 10% of users first."* |
| **roll back** | Revertir a una version anterior | *"The deploy caused errors — roll back immediately."* |
| **check in** | Subir codigo al repositorio | *"Check in your changes before the end of day."* |
| **check out** | Obtener una copia del codigo / cambiar de rama | *"Check out the feature branch to test it."* |
| **phase out** | Retirar gradualmente | *"We're phasing out the legacy API over six months."* |
| **plug in** | Conectar/integrar un componente | *"Plug in the authentication middleware."* |

```bash
# Ejemplos en la terminal
git checkout feature/new-login    # Check out una rama
git add . && git commit           # Check in cambios

# Ejemplo en Slack:
# "We rolled out v2.3 to production last night."
# "There's a bug — we need to roll back to v2.2."
# "The old endpoint will be phased out by Q3."
```

---

## Resolucion de problemas y analisis

| Phrasal Verb | Significado | Ejemplo |
|-------------|-------------|---------|
| **figure out** | Resolver, descifrar | *"I need to figure out why the tests are failing."* |
| **break down** | Descomponer en partes / dejar de funcionar | *"Let's break down this task into subtasks."* |
| **bring up** | Mencionar, plantear un tema | *"I want to bring up a concern about security."* |
| **carry out** | Ejecutar, realizar | *"We need to carry out a full security audit."* |
| **come up with** | Idear, proponer | *"Can you come up with a solution by Friday?"* |
| **look into** | Investigar | *"I'll look into the memory leak this afternoon."* |
| **run into** | Encontrarse con (un problema) | *"I ran into a weird bug with the date parser."* |

```python
# Ejemplos en comentarios de codigo

# TODO: Figure out why this returns None on empty input
# INVESTIGAR: por que retorna None con input vacio
def parse_config(path):
    pass

# NOTE: We ran into issues with timezone handling
# NOTA: Nos encontramos con problemas de zonas horarias
def convert_timestamp(ts):
    pass

# TODO: Break down this function into smaller helpers
# HACER: Descomponer esta funcion en helpers mas pequenos
def process_order(order):
    pass
```

---

## Phrasal verbs con doble significado

Algunos phrasal verbs tienen significados diferentes segun el contexto:

| Phrasal Verb | Significado 1 | Significado 2 |
|-------------|---------------|---------------|
| **break down** | Descomponer en partes (*break down the task*) | Dejar de funcionar (*the server broke down*) |
| **set up** | Configurar (*set up the environment*) | Preparar una trampa (*it's a setup!*) |
| **check out** | Cambiar de rama git (*check out main*) | Revisar algo (*check out this new tool*) |
| **bring up** | Mencionar (*bring up an issue*) | Levantar un servicio (*bring up the server*) |
| **stand up** | Crear un servidor (*stand up a server*) | Reunion diaria (*daily standup*) |

```
// Contexto 1: break down = descomponer
"Let's break down the epic into user stories."

// Contexto 2: break down = fallar
"The CI pipeline broke down again last night."

// Contexto 1: stand up = crear servidor
"We need to stand up a new microservice."

// Contexto 2: stand up = reunion
"See you at the daily standup at 9 AM."
```

---

## Conversacion simulada usando phrasal verbs

```
DevOps: "I'm going to spin up a new staging environment. 
Can someone help me set up the database?"

Backend: "Sure. Let me check out the latest migration branch. 
Should I also back up the current staging DB first?"

DevOps: "Yes, always back up before changes. Once you're done, 
we'll roll out the new API version."

Backend: "Got it. By the way, I ran into an issue with the 
auth service. I'll look into it after lunch."

DevOps: "OK. If it's a blocker, bring it up at the standup. 
Worst case, we roll back to the previous version."

Backend: "Sounds good. Also, should we start phasing out 
the v1 endpoints?"

DevOps: "Let's come up with a deprecation plan first. I'll 
figure out the timeline and carry out the migration."
```

---

## Nota sobre la escritura

Los phrasal verbs pueden escribirse de varias formas como sustantivos:

| Verbo | Sustantivo | Ejemplo |
|-------|-----------|---------|
| log in | **login** | *"Enter your login credentials."* |
| set up | **setup** | *"Follow the setup instructions."* |
| back up | **backup** | *"Create a backup before deploying."* |
| roll back | **rollback** | *"The rollback took five minutes."* |
| roll out | **rollout** | *"The rollout is scheduled for Monday."* |
| sign up | **signup** | *"The signup page needs a redesign."* |
| check out | **checkout** | *"The checkout process in the store."* |
| shut down | **shutdown** | *"Schedule a graceful shutdown."* |
| boot up | **bootup** / **boot** | *"Reduce the boot time."* |
| stand up | **standup** | *"Join the daily standup."* |

> **Regla general:** como verbo se escribe separado (*log in*), como sustantivo o adjetivo se escribe junto o con guion (*login*, *log-in*).
