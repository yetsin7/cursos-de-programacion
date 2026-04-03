# Escritura Clara y Concisa en Documentación Técnica

## Introducción

La documentación técnica debe ser **clara, directa y sin relleno**. Los desarrolladores
leen documentación para resolver problemas rápidamente, no para disfrutar de prosa literaria.
Cada palabra debe aportar valor.

---

## Principio 1: Elimina palabras de relleno (Filler Words)

Las palabras de relleno no agregan significado y hacen el texto más largo sin razón.

| Palabra/Frase de relleno | En español | Alternativa |
|--------------------------|------------|-------------|
| basically | básicamente | (eliminar) |
| actually | en realidad | (eliminar o ser específico) |
| kind of / sort of | algo así como | (ser específico) |
| just | solo/simplemente | (eliminar si no es necesario) |
| really | realmente | (eliminar) |
| very | muy | (usar un adjetivo más preciso) |
| quite | bastante | (eliminar) |
| in order to | para/con el fin de | to |
| due to the fact that | debido al hecho de que | because |
| at this point in time | en este punto del tiempo | now / currently |
| it should be noted that | cabe señalar que | (eliminar, decir directamente) |

### Ejemplos

```markdown
# Malo (con relleno)
Basically, this function kind of does something with the data
and it actually just validates the input.

# Bueno (directo)
This function validates the input data.
```

```markdown
# Malo
In order to install the package, you basically just need to
run the install command.

# Bueno
To install the package, run:
npm install express
```

```markdown
# Malo
It should be noted that this method is actually quite slow
due to the fact that it iterates over the entire array.

# Bueno
This method is slow because it iterates over the entire array.
```

---

## Principio 2: Sé específico, no vago

| Vago (Evitar) | Específico (Preferir) |
|--------------|----------------------|
| This handles stuff | This parses JSON responses |
| It does some processing | It compresses images to WebP format |
| The function does things with data | The function filters users by age |
| This might cause issues | This causes a memory leak on arrays > 10K items |
| It takes some time | It takes approximately 200ms per request |
| Make sure everything works | Verify all unit tests pass |
| There are several options | There are three options: A, B, and C |

### Ejemplos en documentación

```markdown
# Vago
This component handles the user interface stuff for the login.

# Específico
This component renders the login form and handles
email/password validation.
```

```markdown
# Vago
The function processes the response and returns some data.

# Específico
The function extracts the `users` array from the API response
and returns it sorted by `createdAt` in descending order.
```

---

## Principio 3: Una idea por oración

Las oraciones largas con múltiples ideas son difíciles de seguir.

```markdown
# Malo (múltiples ideas)
The function validates the input, connects to the database,
runs the query, transforms the results, caches them for future
use, and returns the final output to the caller.

# Bueno (una idea por oración)
The function validates the input.
Then it queries the database and transforms the results.
Finally, it caches the output and returns it to the caller.
```

```markdown
# Malo
To set up the project you need to clone the repo and install
dependencies and create a .env file with your database credentials
and then run the migrations and seed the database.

# Bueno
To set up the project:
1. Clone the repository.
2. Install dependencies with `npm install`.
3. Create a `.env` file with your database credentials.
4. Run migrations: `npm run migrate`.
5. Seed the database: `npm run seed`.
```

---

## Principio 4: Evita la sobrecarga de jerga (Jargon Overload)

Usar terminología técnica es necesario, pero acumular demasiada jerga
hace el texto incomprensible incluso para desarrolladores.

```markdown
# Sobrecarga de jerga
The containerized microservice leverages a serverless
event-driven architecture with a polyglot persistence
layer utilizing eventual consistency paradigms.

# Claro
The service runs in Docker containers. It processes
events asynchronously and stores data in both PostgreSQL
and Redis.
```

### Regla: Define la jerga cuando la introduces por primera vez

```markdown
# Bueno
The API uses rate limiting (restricting the number of
requests a client can make per minute) to prevent abuse.
```

---

## Principio 5: Usa la forma imperativa en instrucciones

En guías y tutoriales, usa verbos en imperativo. Es más directo.

| Indirecto (Evitar) | Imperativo (Preferir) |
|--------------------|----------------------|
| You should run the tests | Run the tests |
| You need to install Node.js | Install Node.js |
| You can configure the port | Configure the port in `.env` |
| The user should click Save | Click Save |
| You will want to restart the server | Restart the server |

---

## Principio 6: Prefiere palabras simples

| Palabra compleja | Alternativa simple |
|-----------------|-------------------|
| utilize | use |
| implement | build / create |
| facilitate | help / enable |
| leverage | use |
| commence | start / begin |
| terminate | end / stop |
| subsequently | then / after |
| prior to | before |
| in the event that | if |
| a large number of | many |
| in close proximity to | near |
| has the ability to | can |

### Ejemplo

```markdown
# Complejo
Prior to commencing the implementation, utilize the
configuration file to facilitate the setup process.

# Simple
Before starting, use the config file to set up the project.
```

---

## Principio 7: Estructura con listas y tablas

Los párrafos largos son difíciles de escanear. Usa listas y tablas.

```markdown
# Difícil de escanear (párrafo)
The API supports GET, POST, PUT, and DELETE methods. GET
retrieves resources, POST creates new resources, PUT updates
existing resources, and DELETE removes resources.

# Fácil de escanear (tabla)
| Method | Purpose |
|--------|---------|
| GET    | Retrieve a resource |
| POST   | Create a new resource |
| PUT    | Update an existing resource |
| DELETE | Remove a resource |
```

---

## Checklist de escritura clara

Antes de publicar documentación, verifica:

- [ ] No hay palabras de relleno innecesarias
- [ ] Cada oración tiene una sola idea principal
- [ ] Las instrucciones usan forma imperativa
- [ ] La jerga técnica está explicada o es ampliamente conocida
- [ ] Se usan listas y tablas donde corresponde
- [ ] Cada oración aporta información nueva
- [ ] El texto es específico, no vago

---

## Comparación final

```markdown
# ANTES (117 palabras)
Basically, in order to actually get the application up and
running, you're going to really need to make sure that you
have all of the necessary dependencies installed on your
system. It should be noted that the application kind of
requires Node.js version 18 or higher, and you'll also
quite possibly need to have a PostgreSQL database that is
sort of configured and ready to go. Due to the fact that
the application utilizes environment variables, you will
need to create a .env file.

# DESPUÉS (35 palabras)
Prerequisites:
- Node.js 18+
- PostgreSQL database

Setup:
1. Install dependencies: `npm install`
2. Copy `.env.example` to `.env`
3. Update `.env` with your database credentials
4. Start the app: `npm start`
```

> **El texto "después" tiene un 70% menos de palabras y es mucho más útil.**
