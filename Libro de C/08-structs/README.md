# Capítulo 08 — Structs, Union y Enum

Hasta ahora trabajaste con datos sueltos: números, carácteres, arreglos y punteros. Pero muchos
problemas reales necesitan representar entidades completas, como una persona, un libro, una venta
o una fecha. Para eso C ofrece `struct`, `union` y `enum`.

## Qué aprenderás aquí

- Cómo agrupar datos relacionados con `struct`
- Qué ventaja da `typedef`
- Cómo acceder a campos normales y mediante punteros
- Para qué sirve `union`
- Cómo usar `enum` para dar nombres claros a valores enteros

## Qué está pasando dentro del software y del hardware

Un `struct` reserva un bloque de memoria que contiene varios campos organizados en un orden
concreto. El compilador decide cómo acomodarlos y puede añadir relleno interno para respetar
alineación de memoria.

Una `union`, en cambio, reutiliza la misma zona de memoria para todos sus campos. Solo uno debe
interpretarse como válido a la vez. Un `enum` normalmente se representa internamente como un
entero, pero con nombres mucho más claros para la persona que lee el código.

## Ideas clave del capítulo

### 1. `struct`

```c
struct Persona {
    char nombre[50];
    int edad;
    double altura;
};
```

Esto permite tratar varios datos como una sola unidad lógica.

### 2. `typedef`

```c
typedef struct {
    char nombre[50];
    int edad;
} Persona;
```

Así puedes escribir `Persona alumno;` en lugar de `struct Persona alumno;`.

### 3. Acceso a campos

```c
Persona p;
p.edad = 20;
```

Si tienes un puntero a `struct`, usas `->`:

```c
Persona *ptr = &p;
ptr->edad = 21;
```

### 4. `union`

Una `union` comparte la misma memoria entre todos sus campos:

```c
union Valor {
    int entero;
    float decimal;
};
```

Es útil cuando quieres ahorrar memoria o reinterpretar datos, pero debe usarse con mucho cuidado.

### 5. `enum`

```c
typedef enum {
    LUNES,
    MARTES,
    MIERCOLES
} Dia;
```

Sirve para reemplazar números "mágicos" por nombres más claros.

## Por qué esto importa en software real

- Modelar usuarios, productos, registros y configuraciones
- Organizar datos que viajan juntos
- Hacer el código más legible
- Reducir errores causados por usar variables sueltas desconectadas

## Errores comúnes

- No inicializar campos antes de usarlos
- Copiar texto en campos `char[]` sin revisar el tamaño
- Pensar que `union` guarda todos los valores al mismo tiempo
- Usar enteros crudos cuando un `enum` sería más claro
- Ignorar que el orden y tipos de los campos afectan la memoria ocupada

## Cómo estudiar este capítulo

1. Diseña estructuras para objetos cotidianos: libro, estudiante, factura.
2. Imprime los campos para verificar que quedaron bien cargados.
3. Haz arreglos de `struct` y recórrelos con bucles.
4. Usa `enum` para menús o estados.
5. Observa con `sizeof` cuánta memoria ocupa cada tipo definido.

## Archivos de este capítulo

| Archivo | Descripción |
|---------|-------------|
| `01_structs.c` | Ejemplos de estructuras, acceso a campos y organización de datos relacionados |

## Conexión con el siguiente capítulo

Ya puedes representar datos más realistas. En el siguiente capítulo aprenderás a guardarlos y
recuperarlos usando archivos.
