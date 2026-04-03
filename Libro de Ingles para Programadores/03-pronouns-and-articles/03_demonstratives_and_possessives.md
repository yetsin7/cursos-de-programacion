# Demostrativos y Posesivos (Demonstratives & Possessives)

## Introducción

Los demostrativos (**this, that, these, those**) señalan objetos según su cercanía. Los posesivos (**my, your, his, her, its, our, their**) indican pertenencia. Ambos son esenciales en programación para referirse a variables, métodos, propiedades y repositorios.

---

## Demostrativos (Demonstratives)

### Tabla principal

| Demostrativo | Distancia | Número | Español | Ejemplo |
|-------------|-----------|--------|---------|---------|
| **this** | Cerca | Singular | este/esta/esto | **this** variable |
| **these** | Cerca | Plural | estos/estas | **these** methods |
| **that** | Lejos | Singular | ese/esa/eso/aquel | **that** server |
| **those** | Lejos | Plural | esos/esas/aquellos | **those** files |

### "This" y "These" (cerca / actual / presente)

Se usan para lo que está cerca, lo actual o lo que se acaba de mencionar.

| Inglés | Español | Contexto |
|--------|---------|----------|
| **This** variable stores the user ID | **Esta** variable almacena el ID del usuario | Código actual |
| **This** function is deprecated | **Esta** función está deprecada | Función que estamos viendo |
| **This** is a critical bug | **Este** es un bug crítico | Bug que acabamos de encontrar |
| **These** tests need to be updated | **Estos** tests necesitan actualizarse | Tests del módulo actual |
| **These** dependencies are outdated | **Estas** dependencias están desactualizadas | Dependencias del proyecto |
| **These** are the new endpoints | **Estos** son los nuevos endpoints | Endpoints que mostramos |

> **En código:** `this` es una palabra reservada en muchos lenguajes (JavaScript, Java, Dart, C#) que se refiere a la instancia actual del objeto.

```javascript
// "this" en código vs. "this" en inglés hablado
class User {
  constructor(name) {
    this.name = name;  // "this" = esta instancia
  }
}

// En una conversación:
// "This class has a constructor that accepts a name."
// "Esta clase tiene un constructor que acepta un nombre."
```

### "That" y "Those" (lejos / anterior / otro contexto)

Se usan para lo que está lejos, se mencionó antes o está en otro contexto.

| Inglés | Español | Contexto |
|--------|---------|----------|
| **That** server is in production | **Ese** servidor está en producción | Otro servidor |
| **That** bug was fixed last week | **Ese** bug fue arreglado la semana pasada | Bug anterior |
| **That** is not the correct approach | **Esa** no es la forma correcta | Idea de otro |
| **Those** methods are private | **Esos** métodos son privados | Métodos de otra clase |
| **Those** files should be in .gitignore | **Esos** archivos deberían estar en .gitignore | Archivos que el otro señala |
| **Those** were the old requirements | **Esos** eran los requisitos viejos | Requisitos anteriores |

### This vs. That en conversaciones de desarrollo

| Situación | Usarías |
|-----------|---------|
| Hablando de tu código actual | **this** code, **this** function |
| Hablando del código de otro | **that** code, **that** approach |
| Señalando algo en tu pantalla | **this** line, **these** errors |
| Refiriéndote a algo que dijeron antes | **that** idea, **that** suggestion |
| Mostrando tu PR | **this** PR, **these** changes |
| Comentando el PR de otro | **that** PR, **those** changes |

---

## Posesivos (Possessive Adjectives)

### Tabla principal

| Pronombre sujeto | Posesivo | Español | Ejemplo |
|-----------------|----------|---------|---------|
| I | **my** | mi/mis | **my** repository |
| you | **your** | tu/tus/su | **your** code |
| he | **his** | su (de él) | **his** commit |
| she | **her** | su (de ella) | **her** branch |
| it | **its** | su (de ello) | **its** value |
| we | **our** | nuestro/a | **our** project |
| they | **their** | su (de ellos) | **their** deployment |

> **Cuidado con "its" vs "it's":**
> - **its** = posesivo (su, de ello): "The function and **its** parameters"
> - **it's** = contracción de "it is": "**It's** a bug"

### Ejemplos en programación

| Inglés | Español |
|--------|---------|
| Check **your** repository for updates | Revisa **tu** repositorio por actualizaciones |
| **My** code passed all tests | **Mi** código pasó todos los tests |
| **His** pull request was approved | **Su** (de él) pull request fue aprobado |
| **Her** solution is more efficient | **Su** (de ella) solución es más eficiente |
| The variable lost **its** value | La variable perdió **su** valor |
| **Our** team uses Scrum | **Nuestro** equipo usa Scrum |
| **Their** API has good documentation | **Su** (de ellos) API tiene buena documentación |

### "Its" en programación: la propiedad de algo

"Its" es muy común para hablar de las propiedades o características de objetos, funciones, etc.

| Inglés | Español |
|--------|---------|
| The function and **its** return type | La función y **su** tipo de retorno |
| The array and **its** elements | El arreglo y **sus** elementos |
| The class and **its** methods | La clase y **sus** métodos |
| The API and **its** endpoints | La API y **sus** endpoints |
| The object and **its** properties | El objeto y **sus** propiedades |
| The framework and **its** ecosystem | El framework y **su** ecosistema |
| The database and **its** tables | La base de datos y **sus** tablas |

---

## Pronombres posesivos (Possessive Pronouns)

A diferencia de los adjetivos posesivos, estos reemplazan al sustantivo completo.

| Adjetivo posesivo | Pronombre posesivo | Ejemplo |
|-------------------|--------------------|---------|
| my | **mine** | This repo is **mine** |
| your | **yours** | Is this branch **yours**? |
| his | **his** | The commit is **his** |
| her | **hers** | That solution is **hers** |
| its | (no se usa) | --- |
| our | **ours** | The project is **ours** |
| their | **theirs** | The API key is **theirs** |

```
My code works. → This code is mine.
Your branch has conflicts. → This branch is yours.
```

---

## Errores comunes de hispanohablantes

| Error | Correcto | Explicación |
|-------|----------|-------------|
| ~~it's value~~ | **its** value | "it's" = "it is", "its" = posesivo |
| ~~the my repository~~ | **my** repository | No se combina "the" con posesivos |
| ~~this variables~~ | **these** variables | Plural requiere "these" |
| ~~that methods~~ | **those** methods | Plural requiere "those" |
| ~~his code~~ (de ella) | **her** code | En español "su" es ambiguo; en inglés no |
| ~~mine repository~~ | **my** repository | "mine" reemplaza, "my" acompaña |

---

## Ejercicios

### Ejercicio 1: Completa con this / that / these / those

1. ___ function right here handles authentication. (cerca)
2. ___ servers in the other data center are faster. (lejos)
3. ___ are the new API endpoints. (cerca, plural)
4. ___ bug you mentioned yesterday was already fixed. (lejos)
5. Can you look at ___ error on my screen? (cerca)
6. ___ libraries we used before are deprecated now. (lejos, plural)

### Ejercicio 2: Completa con el posesivo correcto

1. I need to update ___ dependencies. (yo)
2. The function lost ___ reference. (la función)
3. She pushed ___ changes to the main branch. (ella)
4. Check ___ email for the credentials. (tú)
5. ___ team uses agile methodology. (nosotros)
6. He forgot to commit ___ code. (él)
7. ___ deployment pipeline is automated. (ellos)

### Ejercicio 3: its vs. it's

1. ___ a known issue. (It is)
2. The module and ___ tests are ready. (posesivo)
3. ___ running on port 8080. (It is)
4. The API lost ___ connection. (posesivo)
5. ___ important to write documentation. (It is)

### Ejercicio 4: Traduce al inglés

1. Esta función retorna un booleano.
2. Esos métodos son privados.
3. Mi código está listo para revisión.
4. La variable perdió su valor.
5. ¿Es tuya esta rama (branch)?
6. Nuestro proyecto usa TypeScript.

---

### Respuestas

**Ejercicio 1:** 1. This, 2. Those, 3. These, 4. That, 5. this, 6. Those

**Ejercicio 2:** 1. my, 2. its, 3. her, 4. your, 5. Our, 6. his, 7. Their

**Ejercicio 3:** 1. It's, 2. its, 3. It's, 4. its, 5. It's

**Ejercicio 4:**
1. This function returns a boolean.
2. Those methods are private.
3. My code is ready for review.
4. The variable lost its value.
5. Is this branch yours?
6. Our project uses TypeScript.
