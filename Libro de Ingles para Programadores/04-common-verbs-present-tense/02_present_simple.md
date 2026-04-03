# Presente Simple (Present Simple)

## Introducción

El presente simple se usa para describir **hechos**, **rutinas**, **verdades generales** y **estados permanentes**. En programación es el tiempo verbal más usado para describir qué hace el código, cómo funciona un sistema y tus hábitos de trabajo.

---

## Estructura

### Afirmativa

```
Sujeto + Verbo (forma base) + Complemento
```

Para **he / she / it** (tercera persona singular): el verbo lleva **-s** o **-es**.

| Sujeto | Estructura | Ejemplo |
|--------|-----------|---------|
| I | verbo base | I write tests every day |
| You | verbo base | You deploy on Fridays |
| He/She/It | verbo + **s/es** | The server **runs** on port 3000 |
| We | verbo base | We use Git for version control |
| They | verbo base | They review code daily |

### Reglas para agregar -s / -es / -ies

| Regla | Terminación del verbo | Se agrega | Ejemplo |
|-------|----------------------|-----------|---------|
| General | la mayoría | -s | run → run**s**, return → return**s** |
| Termina en -s, -sh, -ch, -x, -z | -s, -sh, -ch, -x, -z | -es | push → push**es**, catch → catch**es**, fix → fix**es** |
| Termina en consonante + y | -y | cambia y → -ies | deploy → deplo**ies**, copy → cop**ies** |
| Termina en vocal + y | -y | solo -s | play → play**s**, display → display**s** |
| Irregulares | have, do, go | especial | have → ha**s**, do → doe**s**, go → goe**s** |

### Ejemplos con tercera persona

| Verbo base | Tercera persona | Oración |
|-----------|----------------|---------|
| run | runs | The server **runs** on port 3000 |
| return | returns | The function **returns** a promise |
| push | pushes | She **pushes** code every afternoon |
| catch | catches | The middleware **catches** exceptions |
| fix | fixes | He **fixes** bugs fast |
| deploy | deploys | The pipeline **deploys** to staging |
| copy | copies | The script **copies** files to backup |
| have | has | The class **has** three methods |
| do | does | The cron job **does** the cleanup |

---

## Negativa

```
Sujeto + do/does + not + Verbo (base) + Complemento
```

| Sujeto | Negativa | Ejemplo |
|--------|----------|---------|
| I | don't + verbo | I **don't** use tabs |
| You | don't + verbo | You **don't** need that import |
| He/She/It | doesn't + verbo | The API **doesn't** support XML |
| We | don't + verbo | We **don't** deploy on Fridays |
| They | don't + verbo | They **don't** write documentation |

> **Recuerda:** Con "doesn't", el verbo vuelve a su forma base. "She doesn't **write**" (NO "doesn't writes").

---

## Interrogativa

```
Do/Does + Sujeto + Verbo (base) + Complemento?
```

| Pregunta | Traducción |
|----------|------------|
| **Do** you use TypeScript? | ¿Usas TypeScript? |
| **Does** the function return a value? | ¿La función retorna un valor? |
| **Do** they follow coding standards? | ¿Ellos siguen estándares de código? |
| **Does** the server log requests? | ¿El servidor registra las peticiones? |
| **Do** we have a staging environment? | ¿Tenemos un entorno de staging? |

---

## Adverbios de frecuencia (Frequency Adverbs)

Los adverbios de frecuencia indican con qué regularidad ocurre algo. Van **antes del verbo principal** pero **después de "to be"**.

### Escala de frecuencia

| Adverbio | Frecuencia | Español |
|----------|-----------|---------|
| **always** | 100% | siempre |
| **usually** | ~90% | usualmente |
| **often** | ~70% | a menudo |
| **sometimes** | ~50% | a veces |
| **rarely** | ~10% | rara vez |
| **never** | 0% | nunca |

### Posición en la oración

```
Sujeto + adverbio + verbo principal
Sujeto + to be + adverbio
```

| Con verbo principal | Con "to be" |
|--------------------|-------------|
| I **always** write tests | The server is **always** running |
| She **usually** reviews PRs in the morning | The build is **usually** fast |
| We **often** refactor legacy code | The documentation is **often** outdated |
| He **sometimes** works remotely | Bugs are **sometimes** hard to find |
| They **rarely** deploy on Fridays | The API is **rarely** down |
| I **never** push directly to main | The tests are **never** skipped |

### Ejemplos en programación

| Inglés | Español |
|--------|---------|
| I **always** write unit tests before merging | Siempre escribo tests unitarios antes de mergear |
| She **usually** starts the day with a code review | Ella usualmente empieza el día con un code review |
| We **often** use Docker for local development | A menudo usamos Docker para desarrollo local |
| The build **sometimes** fails on CI | El build a veces falla en CI |
| He **rarely** uses the debugger | Él rara vez usa el debugger |
| We **never** store passwords in plain text | Nunca almacenamos contraseñas en texto plano |

---

## Cuándo usar el presente simple

| Uso | Ejemplo | Explicación |
|-----|---------|-------------|
| Hechos técnicos | JavaScript **runs** in the browser | Verdad general |
| Cómo funciona el código | The function **returns** a string | Comportamiento permanente |
| Rutinas de trabajo | I **commit** code every day | Hábito repetido |
| Documentación | The API **accepts** JSON payloads | Descripción de funcionalidad |
| Instrucciones | First, you **install** the dependencies | Pasos generales |

---

## Ejercicios

### Ejercicio 1: Conjuga el verbo en tercera persona

1. The function (return) ___ a boolean.
2. The server (handle) ___ 1000 requests per second.
3. She (push) ___ her code before lunch.
4. The linter (catch) ___ syntax errors.
5. The script (copy) ___ files to the backup folder.
6. He (fix) ___ bugs in the morning.

### Ejercicio 2: Escribe en negativa

1. The API supports SOAP. → ___
2. I use Windows for development. → ___
3. The function throws errors. → ___
4. We deploy on weekends. → ___

### Ejercicio 3: Coloca el adverbio de frecuencia correctamente

1. I write comments in my code. (always)
2. She is late to standups. (never)
3. The tests fail on CI. (sometimes)
4. We refactor legacy code. (often)
5. The server is available. (usually)

### Ejercicio 4: Traduce al inglés

1. El servidor corre en el puerto 8080.
2. Ella siempre escribe tests unitarios.
3. ¿La función retorna una promesa?
4. Nosotros nunca hacemos push directo a main.
5. El compilador no detecta ese error.

---

### Respuestas

**Ejercicio 1:** 1. returns, 2. handles, 3. pushes, 4. catches, 5. copies, 6. fixes

**Ejercicio 2:**
1. The API doesn't support SOAP.
2. I don't use Windows for development.
3. The function doesn't throw errors.
4. We don't deploy on weekends.

**Ejercicio 3:**
1. I always write comments in my code.
2. She is never late to standups.
3. The tests sometimes fail on CI.
4. We often refactor legacy code.
5. The server is usually available.

**Ejercicio 4:**
1. The server runs on port 8080.
2. She always writes unit tests.
3. Does the function return a promise?
4. We never push directly to main.
5. The compiler doesn't detect that error.
