# Estructura de Oraciones en Inglés (Sentence Structure)

## Introducción

El inglés tiene un orden de palabras muy estricto comparado con el español. Entender esta estructura es fundamental para leer y escribir código, documentación y comentarios en inglés.

---

## La Estructura SVO (Subject - Verb - Object)

En inglés, la mayoría de oraciones siguen el orden **Sujeto + Verbo + Objeto** (SVO). Este orden es casi siempre obligatorio.

```
Subject + Verb + Object
Sujeto  + Verbo + Objeto
```

### Ejemplos en programación

| Inglés (SVO) | Español | Nota |
|--------------|---------|------|
| The function returns a value | La función retorna un valor | Orden idéntico |
| The server handles requests | El servidor maneja peticiones | Orden idéntico |
| The compiler detects errors | El compilador detecta errores | Orden idéntico |
| The user clicks the button | El usuario hace clic en el botón | Orden idéntico |
| The loop iterates the array | El bucle itera el arreglo | Orden idéntico |
| The database stores records | La base de datos almacena registros | Orden idéntico |

### Ejemplos de la vida diaria de un programador

| Inglés | Español |
|--------|---------|
| I write code every day | Yo escribo código todos los días |
| She reviews pull requests | Ella revisa pull requests |
| We deploy the application | Nosotros desplegamos la aplicación |
| They fix bugs on Fridays | Ellos arreglan bugs los viernes |
| He reads the documentation | Él lee la documentación |

---

## Diferencias clave entre inglés y español

### 1. El sujeto NO se puede omitir en inglés

En español puedes decir "Retorna un valor" (omitiendo "La función"). En inglés **siempre** necesitas el sujeto.

| Español (correcto) | Inglés INCORRECTO | Inglés CORRECTO |
|--------------------|-------------------|-----------------|
| Retorna un valor | ~~Returns a value~~ | **The function** returns a value |
| Compila sin errores | ~~Compiles without errors~~ | **The code** compiles without errors |
| Necesitamos más tests | ~~Need more tests~~ | **We** need more tests |

> **Excepción:** En comandos e instrucciones (como comentarios de código), a veces se omite el sujeto: "Returns a value" es aceptable en documentación de funciones.

### 2. Los adjetivos van ANTES del sustantivo

En español decimos "variable global", pero en inglés el adjetivo va primero: "global variable".

| Español | Inglés |
|---------|--------|
| variable global | global variable |
| función recursiva | recursive function |
| código limpio | clean code |
| error crítico | critical error |
| archivo temporal | temporary file |
| respuesta rápida | fast response |
| clase abstracta | abstract class |
| método estático | static method |

### 3. No hay género gramatical en inglés

En español decimos "la función" (femenino) y "el servidor" (masculino). En inglés todo es neutro: "the function", "the server". El artículo "the" no cambia.

```
the function  → la función
the server    → el servidor
the database  → la base de datos
the variable  → la variable
```

### 4. El verbo no cambia según el sujeto (excepto tercera persona)

En español conjugamos: yo escribo, tú escribes, él escribe... En inglés solo cambia en tercera persona singular (he/she/it) añadiendo **-s** o **-es**.

```
I write       → Yo escribo
You write     → Tú escribes
He writes     → Él escribe (nota la -s)
She writes    → Ella escribe
It writes     → Ello escribe
We write      → Nosotros escribimos
They write    → Ellos escriben
```

---

## Tipos de oraciones simples

### Oraciones afirmativas

```
Subject + Verb + Object/Complement

The API returns JSON data.
The developer commits the changes.
The test passes successfully.
```

### Oraciones negativas (con "do not" / "does not")

```
Subject + do/does + not + Verb + Object

The API does not return XML.
The developer does not commit broken code.
The tests do not pass.
```

### Oraciones interrogativas

```
Do/Does + Subject + Verb + Object?

Does the API return JSON?
Do the tests pass?
Does the function handle errors?
```

---

## Oraciones comunes en el día a día del programador

| Situación | Oración en inglés | Traducción |
|-----------|-------------------|------------|
| Reunión diaria | I finished the login feature | Terminé la funcionalidad de login |
| Code review | This function needs refactoring | Esta función necesita refactorización |
| Slack/Teams | The deployment failed | El despliegue falló |
| Documentación | The method accepts two parameters | El método acepta dos parámetros |
| Issue tracker | The app crashes on startup | La app se cae al iniciar |
| Pull request | I added unit tests for the service | Agregué tests unitarios al servicio |

---

## Ejercicios

### Ejercicio 1: Ordena las palabras para formar oraciones correctas

1. `returns / the / a / function / string`
2. `the / handles / server / requests / HTTP`
3. `code / writes / clean / she`
4. `deploy / we / on / Fridays / the / app`
5. `the / stores / data / database / user`

### Ejercicio 2: Traduce al inglés

1. El compilador muestra un error.
2. Nosotros usamos Git todos los días.
3. La variable almacena un número.
4. Ella despliega la aplicación.
5. Los tests no pasan.

### Ejercicio 3: Corrige los errores

1. "The function recursive calls itself." → ___
2. "Returns a boolean." (falta sujeto) → ___
3. "He write clean code." → ___
4. "The variable global stores the config." → ___

---

### Respuestas

**Ejercicio 1:**
1. The function returns a string.
2. The server handles HTTP requests.
3. She writes clean code.
4. We deploy the app on Fridays.
5. The database stores user data.

**Ejercicio 2:**
1. The compiler shows an error.
2. We use Git every day.
3. The variable stores a number.
4. She deploys the application.
5. The tests do not pass.

**Ejercicio 3:**
1. "The recursive function calls itself."
2. "The function returns a boolean."
3. "He writes clean code."
4. "The global variable stores the config."
