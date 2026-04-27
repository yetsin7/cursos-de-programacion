# Capítulo 05 — funciones

Las funciones permiten dividir un programa grande en piezas pequeñas con una responsabilidad
clara. Son una de las bases de la programación profesional porque ayudan a reutilizar lógica,
reducir errores y hacer que el código sea más fácil de leer, probar y mantener.

## Qué aprenderás aquí

- Qué es una función y cómo se define
- Qué diferencia hay entre declarar, definir y llamar una función
- Cómo funcionan los parámetros y el valor de retorno
- Qué significa paso por valor y cómo modificar datos mediante punteros
- Qué es la recursividad y cuándo usarla con cuidado

## Qué está pasando dentro del software y del hardware

Cuando llamas una función, el programa salta temporalmente a otra zona del código. En la pila de
ejecución se guarda información como la dirección de retorno y las variables locales de esa
función. Cuando la función termina, la CPU vuelve al punto donde estaba antes.

Por eso las funciones no son solo una herramienta para "ordenar" el código: también cambian el
estado de la ejecución, usan stack y administran datos temporales.

## Ideas clave del capítulo

### 1. Estructura básica

```c
int sumar(int a, int b) {
    return a + b;
}
```

Aquí `int` es el tipo de retorno, `sumar` es el nombre y `(int a, int b)` son los parámetros.

### 2. Prototipos

Si defines una función después de `main`, debes declararla antes:

```c
int sumar(int a, int b);
```

Esto le dice al compilador qué firma tendrá la función.

### 3. Parámetros y retorno

Una función puede recibir datos, procesarlos y devolver un resultado:

```c
double calcular_promedio(double a, double b) {
    return (a + b) / 2.0;
}
```

Si no necesita devolver nada, usa `void`.

### 4. Paso por valor

En C los parámetros se copian por defecto. La función trabaja con una copia, no con la variable
original.

```c
void cambiar(int numero) {
    numero = 99;
}
```

Si llamas esa función, la variable original no cambia.

### 5. Modificar el valor original con punteros

Para cambiar una variable real debes pasar su dirección:

```c
void cambiar(int *numero) {
    *numero = 99;
}
```

Aquí la función ya no trabaja con una copia del dato, sino con la ubicación real en memoria.

### 6. Recursividad

Una función puede llamarse a sí misma:

```c
int factorial(int n) {
    if (n <= 1) {
        return 1;
    }

    return n * factorial(n - 1);
}
```

Esto puede ser elegante, pero consume stack. Si no existe un caso base correcto, el programa
puede terminar en un desbordamiento de pila.

## Por qué esto importa en programas reales

- Separar validaciones, cálculos y salida por pantalla
- Reutilizar lógica en diferentes partes del programa
- Reducir duplicación
- Facilitar pruebas y correcciones
- Preparar el código para crecer sin volverse caótico

## Errores comúnes

- Crear funciones demasiado largas y con varias responsabilidades
- Olvidar declarar un prototipo cuando hace falta
- Pensar que una función modificará un argumento pasado por valor
- Abusar de variables globales para "compartir" datos
- Usar recursión donde un bucle simple sería más claro

## Cómo estudiar este capítulo

1. Toma un bloque repetido de código y conviértelo en función.
2. Haz pruebas con parámetros diferentes y predice el resultado.
3. Imprime valores antes y después de una llamada para ver si cambian.
4. Dibuja el flujo: llamada, ejecución, retorno.
5. Si una función hace demasiadas cosas, divídela.

## Archivos de este capítulo

| Archivo | Descripción |
|---------|-------------|
| `01_funciones.c` | Ejemplos de funciones simples, retorno, recursividad y modificación mediante punteros |

## Conexión con el siguiente capítulo

Una vez que sabes organizar lógica en funciones, el siguiente paso es trabajar con colecciones de
datos: arreglos y cadenas de texto.
