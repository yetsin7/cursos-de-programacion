# Lesson 03: Thinking in English

## Introduccion

Hay un momento clave en el aprendizaje de un idioma: cuando dejas de traducir mentalmente del espanol y empiezas a pensar directamente en ingles. Para los programadores, este salto es mas facil de lograr porque ya piensas en codigo, que es un lenguaje universal. Esta leccion te da estrategias practicas para hacer esa transicion.

---

## Las tres etapas del pensamiento bilingue

| Etapa | Proceso mental | Ejemplo |
|-------|---------------|---------|
| **1. Traduccion directa** | Piensas en espanol → traduces al ingles | "Necesito una variable" → "I need a variable" |
| **2. Mezcla** | A veces piensas en espanol, a veces en ingles | "I need to crear a function that retorna..." |
| **3. Pensamiento directo** | Piensas directamente en ingles | "I need a function that returns the filtered list" |

El objetivo es llegar a la etapa 3. No sucede de la noche a la manana, pero con practica constante, es alcanzable.

---

## Estrategia 1: Monologo interno al programar

Cuando programas, narrate a ti mismo en ingles lo que estas haciendo. Esto entrena tu cerebro para asociar acciones de programacion con palabras en ingles.

### Como hacerlo

```
Pensamiento en espanol (evitar):
"Voy a crear una funcion que reciba una lista y devuelva 
los elementos que cumplen la condicion."

Pensamiento en ingles (practicar):
"I'm going to create a function that takes a list and 
returns the elements that match the condition."
```

### Frases para narrar tu codigo

| Accion | Frase en ingles |
|--------|----------------|
| Crear una variable | "Let me declare a variable to store the result." |
| Escribir una funcion | "I need a function that takes X and returns Y." |
| Depurar | "The bug is somewhere in this loop. Let me add a log." |
| Leer un error | "It's throwing a TypeError because the value is null." |
| Refactorizar | "I should extract this into a separate function." |
| Buscar una solucion | "Let me check if there's a built-in method for this." |
| Revisar codigo | "This looks clean, but the naming could be better." |
| Planificar | "First I'll set up the database, then the API endpoints." |
| Probar | "Let me write a test for the edge case where input is empty." |
| Commitear | "This commit adds validation to the login form." |

### Practica diaria

Dedica **10 minutos al dia** a programar narrandote en ingles (en voz alta o mental):

```
"OK, I need to fetch user data from the API. Let me create 
an async function. I'll use try-catch for error handling. 
If the response is OK, I'll parse the JSON. Otherwise, I'll 
throw a custom error with a descriptive message."
```

---

## Estrategia 2: Describir tu codigo mientras lo escribes

En lugar de escribir codigo en silencio, describe cada linea como si le explicaras a un companero:

```javascript
// "First, I'll import the necessary modules"
import { fetchUsers } from './api';
import { formatDate } from './utils';

// "Now I'll create an async function to get active users"
async function getActiveUsers() {
  // "I'll try to fetch the users from the API"
  try {
    const users = await fetchUsers();
    
    // "Then I'll filter out the inactive ones"
    const active = users.filter(u => u.isActive);
    
    // "And return them sorted by name"
    return active.sort((a, b) => a.name.localeCompare(b.name));
  } catch (error) {
    // "If something goes wrong, I'll log the error and 
    //  return an empty array"
    console.error('Failed to fetch users:', error);
    return [];
  }
}
```

---

## Estrategia 3: Narrar el proceso de debugging

El debugging es perfecto para practicar porque requiere pensar paso a paso:

```
"OK, the app is crashing when I click the submit button. 
Let me check the console... There's a TypeError: Cannot 
read property 'email' of undefined.

So the user object is undefined. Where does it come from? 
Let me trace it back... It comes from the form state. 
Let me add a console.log before the submit handler...

Ah, I see the problem. The form state isn't initialized 
properly. The initial state should include an email field 
with an empty string as default."
```

### Vocabulario para debugging en tu monologo interno

| Espanol | Ingles (piensa esto) |
|---------|---------------------|
| "Voy a poner un breakpoint" | "Let me set a breakpoint here" |
| "El error esta aqui" | "The bug is right here" |
| "Vamos a ver que valor tiene" | "Let me check what value this holds" |
| "Algo esta mal con esta logica" | "Something's off with this logic" |
| "Ya encontre el problema" | "Found it!" / "Got it!" |
| "No tiene sentido" | "This doesn't make sense" |
| "Deberia funcionar..." | "This should work..." |
| "Que esta pasando aqui?" | "What's going on here?" |
| "Intentare otra cosa" | "Let me try a different approach" |
| "Esto funciono!" | "That did it!" / "That fixed it!" |

---

## Estrategia 4: Consumir contenido en ingles diariamente

### Fuentes recomendadas para programadores

| Tipo | Recurso | Nivel |
|------|---------|-------|
| **Newsletters** | JavaScript Weekly, TLDR, Bytes | Intermedio |
| **Podcasts** | Syntax.fm, The Changelog, JS Party | Intermedio-Avanzado |
| **YouTube** | Fireship, Theo, ThePrimeagen, Traversy Media | Variado |
| **Blogs** | dev.to, Hashnode, Medium (tech) | Variado |
| **Twitter/X** | Seguir devs nativos en ingles | Avanzado |
| **Reddit** | r/programming, r/webdev, r/learnprogramming | Variado |
| **Documentation** | MDN, React docs, Vue docs | Intermedio |
| **Conferencias** | JSConf, React Conf, Google I/O | Avanzado |

### Regla del 80/20

Intenta que **80% del contenido tech** que consumes sea en ingles. Esto incluye:

- Buscar errores en Google en ingles (no en espanol)
- Leer documentacion en ingles (no traducciones)
- Ver tutoriales en ingles (con subtitulos si necesitas)
- Escribir commits y comentarios en ingles

---

## Estrategia 5: Cambiar tu entorno a ingles

| Que cambiar | Por que |
|-------------|---------|
| **IDE en ingles** | Los menus y mensajes seran en ingles |
| **Sistema operativo en ingles** | Inmersion constante |
| **Navegador en ingles** | Resultados de busqueda en ingles |
| **Teclado en ingles (US)** | Los caracteres de programacion estan mejor ubicados |
| **Telefono en ingles** | Practica pasiva constante |
| **Busquedas en Google en ingles** | Mejores resultados para programacion |

---

## Estrategia 6: De la traduccion al pensamiento directo

### Palabras que deberias dejar de traducir

Algunas palabras son mas naturales en ingles en el contexto de programacion. Usarlas directamente:

| En lugar de pensar... | Piensa directamente... |
|----------------------|----------------------|
| "Funcion que devuelve" | "Function that returns" |
| "Bucle para cada" | "For each loop" |
| "Manejar errores" | "Handle errors" |
| "Instancia de la clase" | "Instance of the class" |
| "Subir cambios" | "Push changes" |
| "Rama de desarrollo" | "Dev branch" |
| "Solicitud de extraccion" | "Pull request" |
| "Base de datos" | "Database" |
| "Servidor de desarrollo" | "Dev server" |
| "Pruebas unitarias" | "Unit tests" |

### Ejercicio de transicion

Cuando te descubras pensando en espanol, **no te juzgues**. Simplemente repite el pensamiento en ingles:

```
Pensamiento: "Necesito arreglar este bug antes del deploy"
Correccion: "I need to fix this bug before the deploy"

Pensamiento: "Esta funcion es muy larga, deberia dividirla"
Correccion: "This function is too long, I should split it"

Pensamiento: "No entiendo por que falla"
Correccion: "I don't understand why it's failing"
```

---

## Estrategia 7: Practica con pair programming mental

Imagina que programas con un companero angloparlante. Cada decision que tomes, explicalas en ingles:

```
"Hey, so I think we should use a Map instead of an Object 
here because we need to preserve insertion order and the 
keys aren't just strings.

What do you think about extracting this validation logic 
into a separate utility function? It's getting repeated 
in three different places.

Actually, wait — let me check if there's already a helper 
for this in our utils folder..."
```

---

## Senales de progreso

Sabes que estas pensando en ingles cuando:

| Senal | Descripcion |
|-------|-------------|
| Suenas en ingles | Tu subconsciente procesa en ingles |
| Lees codigo sin traducir | Entiendes directamente |
| Hablas sin pausas de traduccion | Las palabras fluyen |
| Piensas "function" no "funcion" | Terminos tech en ingles |
| Escribes commits en ingles naturalmente | Sin esfuerzo consciente |
| Entiendes chistes en ingles sin pensar | Humor directo |
| Googlear en ingles es tu default | Busquedas naturales |
| Narras tu debugging en ingles | Pensamiento fluido |

---

## Plan de 30 dias

| Semana | Actividad diaria | Duracion |
|--------|-----------------|----------|
| **1** | Narra en ingles lo que programas (en voz baja) | 10 min |
| **2** | Escucha un podcast tech en ingles | 20 min |
| **3** | Escribe todos tus commits y comentarios en ingles | Todo el dia |
| **4** | Describe tu debugging en ingles en voz alta | 15 min |

---

## Resumen

- Pensar en ingles es una habilidad que se entrena con practica constante
- Narra tu programacion en ingles: declaraciones, debugging, decisiones
- Consume contenido tech en ingles (80% de tu consumo)
- Cambia tu entorno digital a ingles para inmersion pasiva
- No traduzcas: usa los terminos en ingles directamente
- Se paciente: la transicion toma semanas, no dias
