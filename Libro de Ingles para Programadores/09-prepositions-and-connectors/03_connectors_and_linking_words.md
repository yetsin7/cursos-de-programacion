# Connectors and Linking Words

## Conectores y palabras de enlace para comunicación técnica

Los conectores unen ideas y dan estructura a tu comunicación. Son fundamentales para escribir documentación clara, correos profesionales, comentarios en code reviews y explicaciones técnicas coherentes.

---

## 1. Conectores básicos (coordinantes)

Unen dos ideas del mismo nivel gramatical.

| Conector | Significado | Ejemplo |
|----------|-------------|---------|
| **and** | y | The test passed **and** the build succeeded. |
| **but** | pero | The code compiles **but** the tests fail. |
| **or** | o | Use PostgreSQL **or** MySQL. |
| **so** | así que | The API was slow, **so** we added caching. |
| **yet** | sin embargo / pero | It's simple **yet** powerful. |
| **nor** | ni | It doesn't support HTTPS, **nor** does it encrypt data. |

```text
I fixed the bug and pushed the changes.
The feature works but it needs more tests.
We can deploy now or wait until tomorrow.
The server ran out of memory, so it crashed.
```

---

## 2. Conectores de causa y razón

| Conector | Significado | Posición | Ejemplo |
|----------|-------------|----------|---------|
| **because** | porque | mitad de oración | The build failed **because** a test broke. |
| **since** | ya que / dado que | inicio o mitad | **Since** the API changed, we need to update the client. |
| **due to** | debido a | + sustantivo | The outage was **due to** a misconfiguration. |
| **because of** | por causa de | + sustantivo | The delay was **because of** a dependency issue. |
| **as** | ya que / como | inicio | **As** the deadline is close, we should focus on critical bugs. |

```text
We rolled back because the deploy introduced a regression.
Since we're using TypeScript, we get type safety.
The crash was due to a memory leak.
We're behind schedule because of the unexpected bug.
```

---

## 3. Conectores de contraste

| Conector | Significado | Uso | Ejemplo |
|----------|-------------|-----|---------|
| **but** | pero | une dos cláusulas | It's fast but hard to debug. |
| **however** | sin embargo | inicio de oración | The tests pass. **However**, the coverage is low. |
| **although** | aunque | inicio o mitad | **Although** it works, the code needs refactoring. |
| **even though** | aunque / a pesar de que | inicio o mitad | **Even though** we tested it, the bug slipped through. |
| **on the other hand** | por otro lado | inicio | Go is fast. **On the other hand**, Python has more libraries. |
| **nevertheless** | no obstante | inicio | The approach is risky. **Nevertheless**, it's our best option. |
| **instead** | en su lugar | inicio o final | Don't use var. Use let **instead**. |
| **whereas** | mientras que | mitad | Python is interpreted, **whereas** Go is compiled. |
| **despite** | a pesar de | + sustantivo/-ing | **Despite** the warnings, we deployed. |
| **in spite of** | a pesar de | + sustantivo/-ing | **In spite of** the bugs, the launch was successful. |

```text
The test passed, but the build failed.
The API is fast. However, it lacks proper documentation.
Although the code works, it's not maintainable.
React is popular. On the other hand, Svelte has better performance.
Don't hardcode the URL. Use an environment variable instead.
```

---

## 4. Conectores de consecuencia y resultado

| Conector | Significado | Ejemplo |
|----------|-------------|---------|
| **therefore** | por lo tanto | The API is unstable. **Therefore**, we added retry logic. |
| **as a result** | como resultado | The server crashed. **As a result**, we lost some data. |
| **consequently** | en consecuencia | The dependency was removed. **Consequently**, the build broke. |
| **thus** | así / por ende | The test was flaky, **thus** unreliable. |
| **so** | así que | The DB was full, **so** writes started failing. |

```text
The token expired. Therefore, the request was rejected.
We didn't write tests. As a result, the bug went to production.
The library was deprecated. Consequently, we had to migrate.
```

---

## 5. Conectores de adición

| Conector | Significado | Ejemplo |
|----------|-------------|---------|
| **also** | también | The API **also** supports WebSockets. |
| **moreover** | además | The code is clean. **Moreover**, it's well-tested. |
| **furthermore** | además / más aún | The lib is fast. **Furthermore**, it has zero dependencies. |
| **in addition** | además / adicionalmente | **In addition** to REST, the API supports GraphQL. |
| **besides** | además de | **Besides** being fast, it's also secure. |
| **as well (as)** | también / además de | The app supports dark mode **as well**. |
| **not only... but also** | no solo... sino también | It's **not only** fast **but also** reliable. |

```text
The framework is lightweight. Moreover, it has great documentation.
In addition to the API, we also built an admin dashboard.
It's not only well-documented but also actively maintained.
```

---

## 6. Conectores de condición

| Conector | Significado | Ejemplo |
|----------|-------------|---------|
| **if** | si | **If** the test fails, the deploy is cancelled. |
| **unless** | a menos que | **Unless** you add tests, I won't approve the PR. |
| **otherwise** | de lo contrario | Fix the linting errors. **Otherwise**, the CI will fail. |
| **as long as** | siempre y cuando | You can push directly **as long as** tests pass. |
| **provided that** | siempre que | **Provided that** the API is stable, we can launch. |
| **in case** | en caso de que | Add error handling **in case** the request fails. |

```text
If the build passes, we deploy automatically.
Deploy to staging first; otherwise, we might break production.
Unless the tests pass, don't merge.
You can skip the review as long as it's a hotfix.
Add a fallback in case the service is unavailable.
```

---

## 7. Conectores de tiempo y secuencia

| Conector | Significado | Ejemplo |
|----------|-------------|---------|
| **first / then / finally** | primero / luego / finalmente | **First** install Node, **then** run npm install. |
| **before** | antes de | Run the tests **before** deploying. |
| **after** | después de | Restart the server **after** the migration. |
| **while** | mientras | The data loads **while** the spinner shows. |
| **meanwhile** | mientras tanto | The API was down. **Meanwhile**, the team investigated. |
| **once** | una vez que | **Once** the build completes, we can deploy. |
| **until** | hasta que | Wait **until** the migration finishes. |
| **as soon as** | tan pronto como | Notify me **as soon as** the deploy is done. |

```text
First, clone the repo. Then, install the dependencies. Finally, run the dev server.
Test the changes before creating a PR.
Once the CI passes, the PR can be merged.
Meanwhile, I'll work on the documentation.
```

---

## 8. Conectores de ejemplo y clarificación

| Conector | Significado | Ejemplo |
|----------|-------------|---------|
| **for example** | por ejemplo | Use a linter, **for example**, ESLint. |
| **such as** | como / tales como | Languages **such as** Python and Go. |
| **in other words** | en otras palabras | It's idempotent. **In other words**, calling it twice has the same effect. |
| **that is (i.e.)** | es decir | The request is stateless, **i.e.**, it carries no session. |
| **specifically** | específicamente | **Specifically**, the error occurs in the auth middleware. |
| **namely** | a saber / concretamente | Two services are affected, **namely** auth and payments. |

```text
Some frameworks, such as Next.js, support SSR out of the box.
The API is RESTful — in other words, it follows REST conventions.
We need to fix two issues, namely the login bug and the timeout.
```

---

## 9. Conectores en documentación y correos

### En documentación técnica

```text
First, install the CLI tool. Then, configure your project.
Note: This feature requires Node 18 or higher.
However, if you're using an older version, you can use the polyfill.
In addition, make sure the database is running before starting the app.
```

### En correos profesionales

```text
I've finished the feature. However, I need help with the tests.
The deploy failed due to a configuration issue. Therefore, I'm rolling back.
Could you review my PR? Also, I'd appreciate feedback on the naming.
The deadline is tomorrow. As a result, I'll skip the optional refactoring.
```

---

## Resumen rápido

| Función | Conectores principales |
|---------|----------------------|
| Causa | because, since, due to |
| Contraste | but, however, although, instead |
| Resultado | therefore, as a result, so |
| Adición | also, moreover, in addition |
| Condición | if, unless, otherwise |
| Tiempo | first/then/finally, before, after, once |
| Ejemplo | for example, such as, i.e. |
