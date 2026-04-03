# Debugging Vocabulary

## Vocabulario de Depuracion

El debugging (depuracion) es una de las actividades mas comunes en programacion.
Conocer el vocabulario en ingles te permitira usar herramientas de depuracion,
buscar soluciones en linea y comunicarte con tu equipo sobre problemas.

---

## Herramientas y Acciones de Debugging

| Termino | Pronunciacion | Significado |
|---------|--------------|-------------|
| **Debug** | /diːˈbʌɡ/ "di-BAG" | Buscar y corregir errores en el codigo |
| **Breakpoint** | /ˈbreɪkpɔɪnt/ "BREIK-point" | Punto donde la ejecucion se detiene |
| **Step over** | /stɛp ˈoʊvər/ "step OU-ver" | Ejecutar la linea actual sin entrar en funciones |
| **Step into** | /stɛp ˈɪntuː/ "step IN-tu" | Entrar dentro de la funcion llamada |
| **Step out** | /stɛp aʊt/ "step AUT" | Salir de la funcion actual |
| **Watch** | /wɒtʃ/ "uotch" | Observar el valor de una variable |
| **Inspect** | /ɪnˈspɛkt/ "in-SPEKT" | Examinar un valor o estado |

### Ejemplos en Oraciones

- "Set a **breakpoint** on line 42." (Pon un breakpoint en la linea 42.)
- "**Step over** the logging function." (Pasa por encima de la funcion de logging.)
- "**Step into** the `calculateTotal` method." (Entra en el metodo `calculateTotal`.)
- "Add `userCount` to the **watch** list." (Agrega `userCount` a la lista de watch.)
- "**Inspect** the response object." (Inspecciona el objeto de respuesta.)

---

## Estructura de Ejecucion

| Termino | Pronunciacion | Significado |
|---------|--------------|-------------|
| **Stack trace** | /stæk treɪs/ "stak treis" | Lista de funciones que se llamaron hasta el error |
| **Call stack** | /kɔːl stæk/ "col stak" | Pila de funciones actualmente en ejecucion |
| **Heap** | /hiːp/ "jiip" | Zona de memoria para objetos dinamicos |
| **Runtime** | /ˈrʌntaɪm/ "RAN-taim" | Momento de ejecucion del programa |
| **Compile time** | /kəmˈpaɪl taɪm/ "com-PAIL taim" | Momento de compilacion del codigo |

### Ejemplos en Oraciones

- "Check the **stack trace** to find where the error originated."
- "The **call stack** shows the function was called from `main`."
- "The object is allocated on the **heap**."
- "This error only happens at **runtime**, not at **compile time**."

---

## Problemas de Memoria y Concurrencia

| Termino | Pronunciacion | Significado |
|---------|--------------|-------------|
| **Memory leak** | /ˈmɛməri liːk/ "ME-mo-ri liik" | Memoria que se usa pero nunca se libera |
| **Race condition** | /reɪs kənˈdɪʃən/ "reis con-DI-shon" | Resultado depende del orden de ejecucion |
| **Deadlock** | /ˈdɛdlɒk/ "DED-lok" | Dos procesos bloqueados esperandose mutuamente |
| **Infinite loop** | /ˈɪnfɪnɪt luːp/ "IN-fi-nit luup" | Bucle que nunca termina |

### Ejemplos en Oraciones

- "The app has a **memory leak** — memory usage keeps growing."
  (La app tiene un memory leak, el uso de memoria sigue creciendo.)
- "There's a **race condition** between the two API calls."
  (Hay una race condition entre las dos llamadas a la API.)
- "The threads are in a **deadlock** — neither can proceed."
  (Los hilos estan en un deadlock, ninguno puede continuar.)
- "The `while` loop is an **infinite loop** because the condition never changes."
  (El bucle while es un loop infinito porque la condicion nunca cambia.)

---

## Tipos de Bugs

| Termino | Pronunciacion | Significado |
|---------|--------------|-------------|
| **Off-by-one error** | "of-bai-UAN E-ror" | Error de uno mas o uno menos (indices) |
| **Edge case** | /ɛdʒ keɪs/ "ech keis" | Caso limite o extremo |
| **Corner case** | /ˈkɔːrnər keɪs/ "COR-ner keis" | Caso muy raro donde multiples condiciones se combinan |
| **Regression** | /rɪˈɡrɛʃən/ "ri-GRE-shon" | Bug que reaparece despues de haber sido corregido |
| **Flaky test** | /ˈfleɪki tɛst/ "FLEI-ki test" | Test que a veces pasa y a veces falla |

### Ejemplos en Oraciones

- "It's an **off-by-one error** — the loop runs one extra iteration."
- "We need to handle the **edge case** where the list is empty."
- "This **corner case** only happens when the user is offline and has no cached data."
- "The latest commit introduced a **regression** in the login flow."
- "That **flaky test** fails randomly on CI — we need to investigate."

---

## Soluciones y Parches

| Termino | Pronunciacion | Significado |
|---------|--------------|-------------|
| **Hotfix** | /ˈhɒtfɪks/ "JOT-fiks" | Correccion urgente en produccion |
| **Patch** | /pætʃ/ "patch" | Pequenia correccion o actualizacion |
| **Workaround** | /ˈwɜːrkəraʊnd/ "WERK-a-raund" | Solucion temporal que evita el problema |
| **Root cause** | /ruːt kɔːz/ "ruut cos" | La causa raiz del problema |
| **Fix** | /fɪks/ "fiks" | Correccion del bug |

### Ejemplos en Oraciones

- "We need to deploy a **hotfix** for the payment bug."
  (Necesitamos desplegar un hotfix para el bug de pagos.)
- "I applied a **patch** to fix the security vulnerability."
  (Aplique un parche para corregir la vulnerabilidad de seguridad.)
- "For now, I have a **workaround** — but we need a proper fix."
  (Por ahora tengo un workaround, pero necesitamos una correccion real.)
- "The **root cause** was a missing null check in the service layer."
  (La causa raiz era una verificacion de null faltante en la capa de servicio.)

---

## Frases Comunes de Debugging

| Ingles | Espaniol |
|--------|----------|
| "Let me set a breakpoint here." | "Dejame poner un breakpoint aqui." |
| "I'll step through the code." | "Voy a recorrer el codigo paso a paso." |
| "Can you check the stack trace?" | "Puedes revisar el stack trace?" |
| "I think there's a memory leak." | "Creo que hay un memory leak." |
| "It's a race condition." | "Es una race condition." |
| "I found the root cause." | "Encontre la causa raiz." |
| "I have a workaround for now." | "Tengo un workaround por ahora." |
| "This is an edge case we missed." | "Este es un caso limite que se nos paso." |
| "We need to deploy a hotfix." | "Necesitamos desplegar un hotfix." |
| "The regression was caused by the last merge." | "La regresion fue causada por el ultimo merge." |

---

## Resumen

El vocabulario de debugging se organiza en:

- **Herramientas**: debug, breakpoint, step over/into/out, watch, inspect
- **Estructura**: stack trace, call stack, heap, runtime, compile time
- **Problemas**: memory leak, race condition, deadlock, infinite loop
- **Tipos de bugs**: off-by-one, edge case, corner case, regression, flaky test
- **Soluciones**: hotfix, patch, workaround, root cause, fix
