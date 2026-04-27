# Capítulo 04 — Control de Flujo

Un programa no sirve solo por saber hacer cálculos. También debe saber cuándo ejecutar una acción,
cuándo repetirla y cuándo detenerse. Eso es el control de flujo: el conjunto de estructuras que
permiten que el software tome decisiones y reaccione a datos, eventos o entradas del usuario.

## Qué aprenderás aquí

- Cómo hacer que un programa elija entre varios caminos
- Cuándo usar `if`, `else if`, `else` y `switch`
- Cómo repetir tareas con `for`, `while` y `do while`
- Qué hacen `break` y `continue`
- Cómo evitar bucles infinitos y errores de lógica

## Qué está pasando dentro del software y del hardware

La CPU ejecuta instrucciones una detrás de otra. Cuando aparece una condición, el procesador
evalúa un resultado y decide si salta a otra parte del programa o sigue en la siguiente línea.
Cuando aparece un bucle, la CPU vuelve a ejecutar un bloque de instrucciones hasta que la
condición deje de cumplirse.

Desde fuera parece que "el programa piensa", pero en realidad está siguiendo rutas definidas por
comparaciones, saltos y cambios en variables almacenadas en memoria.

## Ideas clave del capítulo

### 1. `if`, `else if` y `else`

Se usan cuando el programa necesita elegir entre varias posibilidades.

```c
if (temperatura > 30) {
    printf("Hace calor\n");
} else if (temperatura < 10) {
    printf("Hace frio\n");
} else {
    printf("Temperatura moderada\n");
}
```

### 2. `switch`

Sirve cuando una sola variable puede tomar varios valores concretos.

```c
switch (opcion) {
    case 1:
        printf("Crear\n");
        break;
    case 2:
        printf("Editar\n");
        break;
    default:
        printf("Opcion no valida\n");
}
```

`break` es importante para evitar que el programa siga ejecutando casos siguientes sin querer.

### 3. `for`

Es ideal cuando sabes cuántas veces quieres repetir algo.

```c
for (int i = 0; i < 5; i++) {
    printf("%d\n", i);
}
```

### 4. `while`

Se usa cuando la repetición depende de una condición y no siempre sabes cuántas vueltas habrá.

```c
while (saldo > 0) {
    saldo--;
}
```

### 5. `do while`

Se parece a `while`, pero garantiza al menos una ejecución.

```c
do {
    printf("Ingresa un numero valido: ");
    scanf("%d", &numero);
} while (numero < 1 || numero > 10);
```

### 6. `break` y `continue`

- `break` termina el bucle o `switch`
- `continue` salta al inicio de la siguiente iteración

Estas instrucciones son útiles, pero si se usan demasiado pueden volver el flujo difícil de leer.

## Ejemplos reales donde esto importa

- Validar una contraseña hasta que el usuario escriba una correcta
- Recorrer una lista de productos
- Mostrar un menú y ejecutar una opción
- Buscar un valor dentro de un arreglo
- Reintentar una operación hasta que salga bien o se cancele

## Errores comúnes

- Crear un bucle infinito por olvidar actualizar la variable de control
- Poner `;` después de un `if` o `while`
- Usar `switch` sin `break` por accidente
- Escribir condiciones confusas y difíciles de verificar
- Mezclar demasiadas responsabilidades dentro de un mismo bucle

## Cómo estudiar este capítulo

1. Lee cada condición en voz alta como si fuera una pregunta.
2. Antes de ejecutar un bucle, intenta predecir cuántas vueltas dará.
3. Imprime valores intermedios como `i`, `contador` o `opcion`.
4. Haz tablas pequeñas en papel para seguir el estado del programa.
5. Si el flujo se ve enredado, divide el problema en casos más simples.

## Archivos de este capítulo

| Archivo | Descripción |
|---------|-------------|
| `01_control_flujo.c` | Ejemplos guiados de decisiones, menús, validaciones y repeticiones |

## Conexión con el siguiente capítulo

Ahora ya puedes construir lógica completa. El siguiente paso es organizar esa lógica en funciones
para que el programa sea más claro, reutilizable y profesional.
