# Fechas y Tiempo en Inglés

## Introducción

Las fechas, horas y duraciones son fundamentales en programación: timestamps, cron jobs, deadlines, sprints y logs. En esta lección aprenderás a expresar todo esto en inglés, incluyendo las diferencias entre formatos americano, británico e ISO.

---

## Días de la semana (Days of the Week)

| Inglés | Abreviatura | Español |
|--------|-------------|---------|
| **Monday** | Mon | Lunes |
| **Tuesday** | Tue | Martes |
| **Wednesday** | Wed | Miércoles |
| **Thursday** | Thu | Jueves |
| **Friday** | Fri | Viernes |
| **Saturday** | Sat | Sábado |
| **Sunday** | Sun | Domingo |

> **Regla:** Los días de la semana **siempre** se escriben con mayúscula en inglés.

### Preposiciones con días

| Expresión | Ejemplo |
|-----------|---------|
| **on** + día | We deploy **on** Fridays |
| **on** + día específico | The meeting is **on** Monday |
| every + día | We have standups **every** day |
| this/next/last + día | The release is **next** Thursday |

---

## Meses del año (Months of the Year)

| Inglés | Abreviatura | Español |
|--------|-------------|---------|
| **January** | Jan | Enero |
| **February** | Feb | Febrero |
| **March** | Mar | Marzo |
| **April** | Apr | Abril |
| **May** | May | Mayo |
| **June** | Jun | Junio |
| **July** | Jul | Julio |
| **August** | Aug | Agosto |
| **September** | Sep | Septiembre |
| **October** | Oct | Octubre |
| **November** | Nov | Noviembre |
| **December** | Dec | Diciembre |

> **Regla:** Los meses también **siempre** se escriben con mayúscula.

### Preposiciones con meses

| Expresión | Ejemplo |
|-----------|---------|
| **in** + mes | The conference is **in** June |
| **in** + año | It was released **in** 2024 |
| **in** + mes + año | We launched **in** March 2025 |

---

## Formatos de fecha

### Formato americano (US) - Mes/Día/Año

```
March 15, 2025  →  3/15/2025  →  MM/DD/YYYY
```

Se lee: "March fifteenth, twenty twenty-five"

### Formato británico (UK) - Día/Mes/Año

```
15 March 2025  →  15/3/2025  →  DD/MM/YYYY
```

Se lee: "The fifteenth of March, twenty twenty-five"

### Formato ISO 8601 (estándar en programación)

```
2025-03-15  →  YYYY-MM-DD
```

Se lee: "twenty twenty-five dash oh-three dash fifteen" o simplemente "March fifteenth, twenty twenty-five"

> **En programación siempre usa ISO 8601** (YYYY-MM-DD). Evita ambigüedades entre formatos US y UK. La fecha 03/04/2025 puede ser marzo 4 o abril 3 dependiendo del formato.

### Cómo decir las fechas

| Escrito | Se dice |
|---------|---------|
| January 1 | January first |
| March 3 | March third |
| July 4 | July fourth |
| October 15 | October fifteenth |
| December 25 | December twenty-fifth |
| December 31 | December thirty-first |

### Cómo decir los años

| Año | Se dice |
|-----|---------|
| 1999 | nineteen ninety-nine |
| 2000 | two thousand |
| 2001 | two thousand (and) one |
| 2010 | twenty ten |
| 2024 | twenty twenty-four |
| 2025 | twenty twenty-five |

---

## Hora (Time)

### Hora básica

| Hora | Inglés | Nota |
|------|--------|------|
| 9:00 | nine o'clock / nine AM | Mañana |
| 9:15 | nine fifteen / quarter past nine | |
| 9:30 | nine thirty / half past nine | |
| 9:45 | nine forty-five / quarter to ten | |
| 13:00 | one PM / thirteen hundred (militar) | Tarde |
| 00:00 | midnight | Medianoche |
| 12:00 | noon / midday | Mediodía |

### AM y PM

| Período | Significado | Rango |
|---------|-------------|-------|
| **AM** | ante meridiem (antes del mediodía) | 12:00 AM - 11:59 AM |
| **PM** | post meridiem (después del mediodía) | 12:00 PM - 11:59 PM |

### Formato 24 horas (militar / programación)

En programación y entornos técnicos, el formato 24 horas es común:

| 12 horas | 24 horas | Cómo se lee |
|----------|----------|-------------|
| 1:00 PM | 13:00 | "thirteen hundred" o "one PM" |
| 6:30 PM | 18:30 | "eighteen thirty" o "six thirty PM" |
| 11:59 PM | 23:59 | "twenty-three fifty-nine" |

### Preposiciones con horas

| Expresión | Ejemplo |
|-----------|---------|
| **at** + hora | The meeting is **at** 10 AM |
| **from... to...** | I work **from** 9 **to** 5 |
| **until/till** | The server was down **until** 3 PM |
| **by** (antes de) | Finish the task **by** Friday at 5 PM |

---

## Timestamps y UTC

### UTC (Coordinated Universal Time)

| Expresión | Significado |
|-----------|-------------|
| UTC | Tiempo Universal Coordinado (referencia global) |
| UTC+0 | Hora de Greenwich |
| UTC-5 | Cinco horas detrás de UTC (ej: EST) |
| UTC+1 | Una hora adelante de UTC (ej: CET) |

### Zonas horarias comunes en tech

| Abreviatura | Nombre | UTC Offset |
|-------------|--------|------------|
| UTC | Coordinated Universal Time | +0 |
| EST | Eastern Standard Time | -5 |
| PST | Pacific Standard Time | -8 |
| CST | Central Standard Time | -6 |
| CET | Central European Time | +1 |
| IST | India Standard Time | +5:30 |
| JST | Japan Standard Time | +9 |

### Cómo hablar de zonas horarias

| Inglés | Español |
|--------|---------|
| The deploy is at 3 PM **UTC** | El deploy es a las 3 PM **UTC** |
| What time is it **in your timezone**? | ¿Qué hora es **en tu zona horaria**? |
| The server logs are in **UTC** | Los logs del servidor están en **UTC** |
| The meeting is at 10 AM **EST** | La reunión es a las 10 AM **EST** |
| Convert the timestamp to **local time** | Convierte el timestamp a **hora local** |

---

## Duraciones (Durations)

| Inglés | Español | Ejemplo |
|--------|---------|---------|
| second(s) | segundo(s) | The request took **2 seconds** |
| minute(s) | minuto(s) | The build took **five minutes** |
| hour(s) | hora(s) | The migration took **three hours** |
| day(s) | día(s) | The sprint lasts **ten days** |
| week(s) | semana(s) | The feature took **two weeks** |
| month(s) | mes(es) | The project took **six months** |

### Expresar duraciones

| Expresión | Ejemplo |
|-----------|---------|
| It **takes** + duración | The build **takes** 5 minutes |
| It **took** + duración | The migration **took** 3 hours |
| **for** + duración | The server was down **for** 20 minutes |
| **in** + duración | I'll finish **in** two days |
| **within** + duración | Deploy **within** 24 hours |
| **about/around** + duración | It takes **about** 10 minutes |

### Ejemplos en programación

| Inglés | Español |
|--------|---------|
| The build takes **about five minutes** | El build toma **unos cinco minutos** |
| The server was down **for two hours** | El servidor estuvo caído **por dos horas** |
| The test suite runs **in under a minute** | La suite de tests corre **en menos de un minuto** |
| The deploy took **longer than expected** | El deploy tomó **más de lo esperado** |
| The request timed out **after 30 seconds** | La petición expiró **después de 30 segundos** |
| The sprint lasts **two weeks** | El sprint dura **dos semanas** |
| The certificate expires **in 90 days** | El certificado expira **en 90 días** |

---

## Expresiones de tiempo comunes en desarrollo

| Inglés | Español |
|--------|---------|
| **deadline** | fecha límite |
| **ETA** (estimated time of arrival) | tiempo estimado de entrega |
| **downtime** | tiempo de inactividad |
| **uptime** | tiempo de actividad |
| **turnaround time** | tiempo de respuesta/entrega |
| **lead time** | tiempo de preparación |
| **runtime** | tiempo de ejecución |
| **build time** | tiempo de compilación |
| **response time** | tiempo de respuesta |
| **latency** | latencia |

---

## Ejercicios

### Ejercicio 1: Escribe la fecha en inglés (formato hablado US)

1. 2025-01-15 → ___
2. 2024-07-04 → ___
3. 2025-12-31 → ___
4. 2023-03-01 → ___

### Ejercicio 2: Escribe la hora en inglés

1. 9:00 AM → ___
2. 14:30 → ___
3. 23:59 → ___
4. 12:00 PM → ___
5. 00:00 → ___

### Ejercicio 3: Traduce las duraciones

1. El build toma 5 minutos.
2. El servidor estuvo caído por 3 horas.
3. Terminaré en dos días.
4. La petición expiró después de 30 segundos.
5. El sprint dura dos semanas.

### Ejercicio 4: Completa con at / on / in

1. We deploy ___ Fridays.
2. The meeting is ___ 10 AM.
3. The release is ___ March.
4. The deadline is ___ Friday ___ 5 PM.
5. JavaScript was created ___ 1995.

---

### Respuestas

**Ejercicio 1:**
1. January fifteenth, twenty twenty-five.
2. July fourth, twenty twenty-four.
3. December thirty-first, twenty twenty-five.
4. March first, twenty twenty-three.

**Ejercicio 2:**
1. Nine o'clock / nine AM.
2. Two thirty PM / fourteen thirty.
3. Twenty-three fifty-nine / eleven fifty-nine PM.
4. Noon / twelve PM / midday.
5. Midnight / twelve AM.

**Ejercicio 3:**
1. The build takes five minutes.
2. The server was down for three hours.
3. I'll finish in two days.
4. The request timed out after thirty seconds.
5. The sprint lasts two weeks.

**Ejercicio 4:** 1. on, 2. at, 3. in, 4. on / at, 5. in
