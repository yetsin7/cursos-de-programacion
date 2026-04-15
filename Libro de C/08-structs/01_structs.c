/*
 * Capítulo 08 — Structs
 * Archivo: 01_structs.c
 *
 * Demuestra el uso de structs en C:
 *   - typedef struct — tipo Persona
 *   - Arreglo de structs
 *   - Funciones que reciben structs (por valor y por puntero)
 *   - Operador flecha (->)
 *   - Operaciones CRUD básicas en memoria (crear, leer, actualizar, borrar)
 *   - Enum para estados
 *   - Union básica
 *
 * Compilar: gcc -Wall -std=c11 -o structs 01_structs.c
 */

#include <stdio.h>
#include <string.h>
#include <stdbool.h>

/* -------------------------------------------------------
 * Definición de tipos con typedef
 * ------------------------------------------------------- */

/* Enum para el estado de una persona en el sistema */
typedef enum {
    ACTIVO = 1,
    INACTIVO = 0
} Estado;

/* Struct para representar una fecha */
typedef struct {
    int dia;
    int mes;
    int anio;
} Fecha;

/* Struct principal: Persona */
typedef struct {
    int id;
    char nombre[60];
    int edad;
    double altura;
    Fecha nacimiento;
    Estado estado;
} Persona;

/* Capacidad máxima del "registro" en memoria */
#define MAX_PERSONAS 10

/* Prototipos */
void mostrarPersona(const Persona *p);
void mostrarTodas(const Persona lista[], int cantidad);
int buscarPorId(const Persona lista[], int cantidad, int id);
bool actualizarEdad(Persona lista[], int cantidad, int id, int nuevaEdad);
bool eliminarPorId(Persona lista[], int *cantidad, int id);
void mostrarFecha(const Fecha *f);

int main(void) {

    /* -------------------------------------------------------
     * 1. CREAR — agregar personas al arreglo
     * ------------------------------------------------------- */
    printf("=== CREAR PERSONAS ===\n");

    Persona personas[MAX_PERSONAS];
    int total = 0;

    /* Persona 1 */
    personas[total].id     = 1;
    strcpy(personas[total].nombre, "Ana Lopez");
    personas[total].edad   = 28;
    personas[total].altura = 1.65;
    personas[total].nacimiento = (Fecha){15, 3, 1996};
    personas[total].estado = ACTIVO;
    total++;

    /* Persona 2 — inicialización con designadores */
    personas[total] = (Persona){
        .id         = 2,
        .nombre     = "Carlos Ruiz",
        .edad       = 34,
        .altura     = 1.80,
        .nacimiento = {7, 11, 1990},
        .estado     = ACTIVO
    };
    total++;

    /* Persona 3 */
    personas[total] = (Persona){3, "María Gómez", 22, 1.60, {20, 6, 2002}, INACTIVO};
    total++;

    /* Persona 4 */
    personas[total] = (Persona){4, "Pedro Silva", 45, 1.75, {1, 1, 1979}, ACTIVO};
    total++;

    printf("Personas creadas: %d\n", total);

    /* -------------------------------------------------------
     * 2. LEER — mostrar todas las personas
     * ------------------------------------------------------- */
    printf("\n=== LEER TODAS ===\n");
    mostrarTodas(personas, total);

    /* -------------------------------------------------------
     * 3. BUSCAR — buscar por ID
     * ------------------------------------------------------- */
    printf("=== BUSCAR POR ID ===\n");

    int indice = buscarPorId(personas, total, 2);
    if (indice >= 0) {
        printf("Persona encontrada en indice %d:\n", indice);
        mostrarPersona(&personas[indice]);
    } else {
        printf("No encontrada\n");
    }

    /* -------------------------------------------------------
     * 4. ACTUALIZAR — modificar la edad de una persona
     * ------------------------------------------------------- */
    printf("=== ACTUALIZAR EDAD ===\n");

    if (actualizarEdad(personas, total, 3, 23)) {
        printf("Edad de ID=3 actualizada a 23\n");
    }

    /* -------------------------------------------------------
     * 5. ELIMINAR — marcar como inactiva (soft delete)
     * ------------------------------------------------------- */
    printf("\n=== ELIMINAR (soft delete) ===\n");

    if (eliminarPorId(personas, &total, 4)) {
        printf("Persona con ID=4 eliminada del registro\n");
    }
    printf("Total de personas activas: %d\n", total);
    mostrarTodas(personas, total);

    /* -------------------------------------------------------
     * 6. Puntero a struct y operador ->
     * ------------------------------------------------------- */
    printf("=== PUNTERO A STRUCT ===\n");

    Persona *ptr = &personas[0];
    printf("Via puntero: %s, %d anios\n", ptr->nombre, ptr->edad);

    /* Modificar a través del puntero */
    ptr->edad = 29;
    printf("Edad modificada via puntero: %d\n", ptr->edad);

    /* -------------------------------------------------------
     * 7. Union — diferentes vistas del mismo espacio de memoria
     * ------------------------------------------------------- */
    printf("\n=== UNION ===\n");

    union {
        int entero;
        float decimal;
        unsigned char bytes[4];
    } dato;

    dato.entero = 65;
    printf("Como entero:  %d\n", dato.entero);
    printf("Primer byte:  %u (ASCII: '%c')\n", dato.bytes[0], (char)dato.bytes[0]);

    dato.decimal = 3.14f;
    printf("Como float:   %.4f\n", dato.decimal);

    return 0;
}


/*
 * mostrarPersona — Imprime los datos de una persona con formato.
 * Recibe: p — puntero constante a la Persona a mostrar
 */
void mostrarPersona(const Persona *p) {
    printf("  ID: %d | Nombre: %-20s | Edad: %2d | Altura: %.2fm | "
           "Nacimiento: %02d/%02d/%04d | Estado: %s\n",
           p->id, p->nombre, p->edad, p->altura,
           p->nacimiento.dia, p->nacimiento.mes, p->nacimiento.anio,
           p->estado == ACTIVO ? "Activo" : "Inactivo");
}

/*
 * mostrarTodas — Imprime todas las personas de la lista.
 * Recibe: lista — arreglo de personas, cantidad — número de elementos
 */
void mostrarTodas(const Persona lista[], int cantidad) {
    if (cantidad == 0) {
        printf("  (lista vacia)\n");
        return;
    }
    for (int i = 0; i < cantidad; i++) {
        mostrarPersona(&lista[i]);
    }
}

/*
 * buscarPorId — Busca una persona por su ID.
 * Recibe: lista, cantidad — el arreglo y su tamaño; id — el ID buscado
 * Retorna: índice en el arreglo si se encuentra, -1 si no existe
 */
int buscarPorId(const Persona lista[], int cantidad, int id) {
    for (int i = 0; i < cantidad; i++) {
        if (lista[i].id == id) return i;
    }
    return -1;
}

/*
 * actualizarEdad — Actualiza la edad de la persona con el ID dado.
 * Retorna: true si la encontró y actualizó, false si no la encontró
 */
bool actualizarEdad(Persona lista[], int cantidad, int id, int nuevaEdad) {
    int idx = buscarPorId(lista, cantidad, id);
    if (idx < 0) return false;
    lista[idx].edad = nuevaEdad;
    return true;
}

/*
 * eliminarPorId — Elimina una persona del arreglo moviendo los restantes.
 * Recibe: lista — el arreglo, cantidad — puntero al contador, id — ID a eliminar
 * Retorna: true si se eliminó, false si no se encontró
 */
bool eliminarPorId(Persona lista[], int *cantidad, int id) {
    int idx = buscarPorId(lista, *cantidad, id);
    if (idx < 0) return false;

    /* Mover todos los elementos posteriores una posición hacia atrás */
    for (int i = idx; i < *cantidad - 1; i++) {
        lista[i] = lista[i + 1];
    }
    (*cantidad)--;
    return true;
}

/*
 * mostrarFecha — Imprime una fecha con formato DD/MM/AAAA.
 */
void mostrarFecha(const Fecha *f) {
    printf("%02d/%02d/%04d", f->dia, f->mes, f->anio);
}
