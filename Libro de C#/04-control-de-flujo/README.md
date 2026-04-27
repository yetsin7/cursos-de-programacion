# Capítulo 04 — Control de flujo

El control de flujo decide qué camino sigue el programa y cuántas veces repite
una acción. Sin este capítulo, no podrías validar, iterar ni reaccionar a datos.

---

## ¿Qué aprenderás?

- `if`, `else if`, `else`;
- `switch` clásico y `switch expression`;
- pattern matching básico;
- `for`, `foreach`, `while`, `do-while`;
- `break` y `continue`.

---

## ¿Qué pasa dentro del programa?

Cuando C# evalúa flujo:

- comprueba condiciones booleanas;
- elige una rama;
- puede repetir instrucciones;
- puede detener o saltar iteraciones.

Eso aparece en validaciones, menús, formularios, reglas de negocio y recorridos
de colecciones.

---

## `if` y `switch`

`if` sirve cuando la decisión depende de una condición lógica.
`switch` es útil cuando comparas un valor contra varios casos definidos.

`switch expression` además permite devolver un valor de forma compacta.

---

## Bucles

- `for` cuando controlas un contador;
- `foreach` cuando recorres una colección;
- `while` cuando no sabes cuántas veces repetirás;
- `do-while` cuando debe ejecutarse al menos una vez.

---

## Errores comúnes

- escribir condiciones difíciles de leer;
- usar `while` cuando `foreach` sería más claro;
- olvidar cómo termina un bucle;
- abusar de `break` y `continue` sin justificarlo.

---

## Ejecutar el ejemplo

```bash
cd 04-control-de-flujo
dotnet run
```
