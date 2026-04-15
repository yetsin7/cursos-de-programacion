# Capítulo 08 — Structs, Union y Enum

## ¿Qué es un struct?

Un `struct` agrupa múltiples variables de **distintos tipos** bajo un mismo nombre. Es la forma
de crear tipos de datos personalizados en C — el equivalente simplificado de las clases en
lenguajes orientados a objetos.

```c
struct Persona {
    char nombre[50];
    int edad;
    double altura;
};

struct Persona p1;
p1.edad = 30;
```

---

## typedef — nombrar tipos

`typedef` permite crear un alias para un tipo, evitando escribir `struct` repetidamente:

```c
typedef struct {
    char nombre[50];
    int edad;
    double altura;
} Persona;

Persona p1;    /* ya no necesitas escribir "struct Persona" */
p1.edad = 30;
```

---

## Inicialización

```c
/* Por campo */
Persona alumno;
alumno.edad = 20;
strcpy(alumno.nombre, "Ana");

/* Con inicializador designado (C99) */
Persona doctor = {
    .nombre = "Luis García",
    .edad   = 45,
    .altura = 1.78
};

/* Posicional */
Persona p2 = {"María", 28, 1.65};
```

---

## Structs anidados

```c
typedef struct {
    int dia, mes, anio;
} Fecha;

typedef struct {
    char nombre[60];
    Fecha nacimiento;   /* struct dentro de struct */
} Empleado;

Empleado e = {"Pedro", {15, 3, 1990}};
printf("Nacido el %d/%d/%d\n",
       e.nacimiento.dia,
       e.nacimiento.mes,
       e.nacimiento.anio);
```

---

## Punteros a struct (operador ->)

```c
Persona *ptr = &p1;

/* Estas dos formas son equivalentes */
printf("%s\n", (*ptr).nombre);   /* desreferenciar y acceder */
printf("%s\n", ptr->nombre);     /* operador flecha — más legible */

ptr->edad = 35;
```

---

## Arrays de structs

```c
Persona equipo[3] = {
    {"Carlos", 25, 1.75},
    {"María",  22, 1.62},
    {"Pedro",  30, 1.80}
};

for (int i = 0; i < 3; i++) {
    printf("%s tiene %d años\n", equipo[i].nombre, equipo[i].edad);
}
```

---

## union

Una `union` es como un struct, pero todos sus campos **comparten la misma memoria**.
Solo se puede usar un campo a la vez. Útil para ahorrar memoria o para reinterpretar bytes.

```c
union Valor {
    int entero;
    float decimal;
    char bytes[4];
};

union Valor v;
v.entero = 65;
printf("%d\n", v.entero);   /* 65 */
printf("%c\n", v.bytes[0]); /* 'A' — mismo espacio de memoria */
```

---

## enum

Una `enum` define un conjunto de constantes enteras con nombres descriptivos:

```c
typedef enum {
    LUNES = 1, MARTES, MIERCOLES, JUEVES, VIERNES, SABADO, DOMINGO
} DiaSemana;

DiaSemana hoy = MIERCOLES;
printf("Dia: %d\n", hoy);   /* 3 */
```

---

## Archivos de este capítulo

| Archivo         | Descripción                                        |
|-----------------|----------------------------------------------------|
| `01_structs.c`  | struct Persona con operaciones CRUD básicas        |

---

## Siguiente capítulo

→ **Capítulo 09:** Manejo de Archivos
