# Pronombres Personales (Personal Pronouns)

## Introducción

Los pronombres reemplazan a los sustantivos para evitar repetición. En inglés existen dos formas: **sujeto** (quién hace la acción) y **objeto** (quién recibe la acción). A diferencia del español, en inglés el pronombre de sujeto es **obligatorio**.

---

## Pronombres de sujeto (Subject Pronouns)

Se usan como sujeto de la oración, antes del verbo.

| Inglés | Español | Ejemplo en programación |
|--------|---------|------------------------|
| **I** | Yo | **I** wrote the unit tests |
| **You** | Tú / Usted / Ustedes | **You** need to update the dependency |
| **He** | Él | **He** fixed the bug yesterday |
| **She** | Ella | **She** deployed the hotfix |
| **It** | Ello (cosas/conceptos) | **It** returns null |
| **We** | Nosotros | **We** need to refactor this module |
| **They** | Ellos/Ellas | **They** merged the pull request |

### Notas importantes

1. **"I" siempre va en mayúscula**, sin importar su posición en la oración.
2. **"You"** es igual para singular y plural, formal e informal.
3. **"It"** se usa para cosas, animales, conceptos y código. Es el pronombre más usado en programación.
4. **"They"** también se usa como pronombre neutro singular cuando no se conoce el género.

### "It" en programación: el pronombre estrella

"It" reemplaza a funciones, variables, servidores, APIs, errores, etc.

| Oración original | Con pronombre |
|------------------|---------------|
| The function returns null | **It** returns null |
| The server is down | **It** is down |
| The test failed | **It** failed |
| The API handles authentication | **It** handles authentication |
| The bug was fixed | **It** was fixed |
| The loop runs 10 times | **It** runs 10 times |

### "They" para componentes plurales

| Oración original | Con pronombre |
|------------------|---------------|
| The tests are passing | **They** are passing |
| The dependencies are outdated | **They** are outdated |
| The endpoints return JSON | **They** return JSON |
| The developers pushed the fix | **They** pushed the fix |
| The microservices communicate via HTTP | **They** communicate via HTTP |

---

## Pronombres de objeto (Object Pronouns)

Se usan después del verbo o de una preposición. Reciben la acción.

| Sujeto | Objeto | Español (objeto) | Ejemplo |
|--------|--------|-------------------|---------|
| I | **me** | me/a mí | Send **me** the API docs |
| You | **you** | te/a ti | I'll assign **you** to this task |
| He | **him** | le/a él | Ask **him** about the deployment |
| She | **her** | le/a ella | Tell **her** the build failed |
| It | **it** | lo/la | Delete **it** from the database |
| We | **us** | nos/a nosotros | Give **us** access to the repo |
| They | **them** | les/a ellos | I sent **them** the credentials |

### Ejemplos en programación

| Inglés | Español |
|--------|---------|
| The function processes **it** | La función lo procesa |
| I will review **it** later | Lo revisaré más tarde |
| Pass **it** as a parameter | Pásalo como parámetro |
| We need to refactor **it** | Necesitamos refactorizarlo |
| Can you assign **me** to that ticket? | ¿Puedes asignarme a ese ticket? |
| She showed **us** the new design | Ella nos mostró el nuevo diseño |
| The API validates **them** automatically | La API los valida automáticamente |
| I'll send **him** the pull request link | Le enviaré el enlace del pull request |
| Call **her** for the code review | Llámala para el code review |
| Let **me** check the logs | Déjame revisar los logs |

---

## Sujeto vs. Objeto: Cuándo usar cada uno

### Regla simple

- **Antes del verbo** (hace la acción) → Pronombre de **sujeto**
- **Después del verbo** o preposición (recibe la acción) → Pronombre de **objeto**

```
SHE wrote the code.          → Sujeto (ella hizo la acción)
The manager called HER.      → Objeto (ella recibió la acción)

THEY deployed the fix.       → Sujeto
I messaged THEM on Slack.    → Objeto

IT returns a promise.        → Sujeto
The function wraps IT.       → Objeto
```

### Después de preposiciones: siempre objeto

| Preposición + Pronombre objeto | Ejemplo |
|-------------------------------|---------|
| for me | This task is for **me** |
| with him | I pair programmed with **him** |
| to her | Send the report to **her** |
| from us | The request came from **us** |
| about them | I don't know about **them** |
| with it | There's a problem with **it** |

---

## Errores comunes de hispanohablantes

| Error | Correcto | Explicación |
|-------|----------|-------------|
| ~~Me fixed the bug~~ | **I** fixed the bug | "Me" es objeto, no sujeto |
| ~~Him is a developer~~ | **He** is a developer | "Him" es objeto, no sujeto |
| ~~Give I the access~~ | Give **me** the access | Después del verbo va el objeto |
| ~~The function, returns null~~ | **It** returns null | Usa "it", no repitas el sustantivo |
| ~~Is raining~~ | **It** is raining | "It" obligatorio como sujeto |
| ~~Her told me~~ | **She** told me | "Her" es objeto, no sujeto |

---

## Pronombre "it" como sujeto vacío

En inglés, "it" se usa como sujeto obligatorio en ciertos casos donde el español no necesita sujeto:

| Inglés | Español | Contexto |
|--------|---------|----------|
| **It** is 3 PM | Son las 3 PM | Hora |
| **It** is important to write tests | Es importante escribir tests | Opiniones |
| **It** takes 5 minutes to build | Toma 5 minutos compilar | Duración |
| **It** seems like a memory leak | Parece ser un memory leak | Apariencia |
| **It** is possible to fix this | Es posible arreglar esto | Posibilidad |
| **It** depends on the configuration | Depende de la configuración | Estado |

---

## Ejercicios

### Ejercicio 1: Elige el pronombre de sujeto correcto

1. ___ is a full-stack developer. (He / Him)
2. ___ deployed the new version. (They / Them)
3. ___ returns an empty array. (It / Its)
4. ___ need to fix this before Friday. (We / Us)
5. ___ wrote the documentation. (She / Her)

### Ejercicio 2: Elige el pronombre de objeto correcto

1. Send ___ the error log. (I / me)
2. The API validates ___ before saving. (they / them)
3. I'll assign ___ to the bug fix. (he / him)
4. Let ___ review the code first. (we / us)
5. The compiler ignores ___. (it / its)

### Ejercicio 3: Completa con el pronombre correcto (sujeto u objeto)

1. ___ pushed the commit, but ___ had merge conflicts. (He/It)
2. The tests failed. Can you check ___? (they/them)
3. ___ wrote the module and ___ tested ___. (She/He/it)
4. ___ need to deploy ___  before midnight. (We/it)
5. Tell ___ that ___ is ready for review. (her/it)

### Ejercicio 4: Traduce al inglés

1. Ella lo desplegó ayer. (la aplicación)
2. Nosotros necesitamos refactorizarlo. (el código)
3. Ellos nos enviaron las credenciales.
4. Pásalo como parámetro. (el valor)
5. Déjame revisar los logs.

---

### Respuestas

**Ejercicio 1:** 1. He, 2. They, 3. It, 4. We, 5. She

**Ejercicio 2:** 1. me, 2. them, 3. him, 4. us, 5. it

**Ejercicio 3:**
1. He pushed the commit, but it had merge conflicts.
2. The tests failed. Can you check them?
3. She wrote the module and he tested it.
4. We need to deploy it before midnight.
5. Tell her that it is ready for review.

**Ejercicio 4:**
1. She deployed it yesterday.
2. We need to refactor it.
3. They sent us the credentials.
4. Pass it as a parameter.
5. Let me check the logs.
