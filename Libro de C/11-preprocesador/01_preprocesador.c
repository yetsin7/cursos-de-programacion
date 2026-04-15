/*
 * Capítulo 11 — El Preprocesador de C
 * Archivo: 01_preprocesador.c
 *
 * Demuestra el uso del preprocesador en C:
 *   - #define para constantes simples
 *   - Macros con parámetros (con paréntesis protectores)
 *   - Macros multilínea con do-while
 *   - Compilación condicional: #ifdef, #ifndef, #if, #elif, #else
 *   - Guardas de inclusión (demostradas conceptualmente)
 *   - Macros predefinidas: __FILE__, __LINE__, __DATE__, __func__
 *
 * Compilar: gcc -Wall -std=c11 -o preprocesador 01_preprocesador.c
 * Con modo debug: gcc -Wall -std=c11 -DDEBUG -o preprocesador 01_preprocesador.c
 */

#include <stdio.h>
#include <stdlib.h>

/* -------------------------------------------------------
 * Constantes con #define
 * ------------------------------------------------------- */

/* Constante numérica — no tiene tipo, es sustitución textual */
#define PI               3.14159265358979
#define GRAVEDAD         9.81
#define MAX_ALUMNOS      30
#define VELOCIDAD_LUZ    299792458   /* metros por segundo */

/* Constante de texto */
#define APP_VERSION      "1.0.0"
#define APP_NOMBRE       "Libro de C"

/* -------------------------------------------------------
 * Macros con parámetros
 * Los paréntesis alrededor de los parámetros son ESENCIALES
 * ------------------------------------------------------- */

/* Cuadrado: CUADRADO(2+3) → ((2+3)*(2+3)) = 25, NO 2+3*2+3 = 11 */
#define CUADRADO(x)       ((x) * (x))

/* Valor absoluto */
#define ABS(x)            ((x) >= 0 ? (x) : -(x))

/* Máximo y mínimo de dos valores */
#define MAX(a, b)         ((a) > (b) ? (a) : (b))
#define MIN(a, b)         ((a) < (b) ? (a) : (b))

/* Convertir grados a radianes */
#define DEG_A_RAD(grados) ((grados) * PI / 180.0)

/* -------------------------------------------------------
 * Macros multilínea — usar do { } while(0) para que se
 * comporten correctamente como una sola sentencia
 * ------------------------------------------------------- */

/* Macro que verifica una condición y termina si falla */
#define VERIFICAR(condicion, mensaje) \
    do { \
        if (!(condicion)) { \
            fprintf(stderr, "[ERROR] %s — archivo: %s, linea: %d\n", \
                    (mensaje), __FILE__, __LINE__); \
            exit(1); \
        } \
    } while(0)

/* Macro de debug: solo se compila si DEBUG está definido */
#ifdef DEBUG
    #define LOG_DEBUG(fmt, ...) \
        fprintf(stderr, "[DEBUG %s:%d] " fmt "\n", __func__, __LINE__, ##__VA_ARGS__)
#else
    /* Si no estamos en modo debug, la macro no genera ningún código */
    #define LOG_DEBUG(fmt, ...) do {} while(0)
#endif

/* -------------------------------------------------------
 * Compilación condicional — plataforma
 * ------------------------------------------------------- */
#ifdef _WIN32
    #define PLATAFORMA "Windows"
#elif defined(__APPLE__)
    #define PLATAFORMA "macOS"
#elif defined(__linux__)
    #define PLATAFORMA "Linux"
#else
    #define PLATAFORMA "Desconocida"
#endif


int main(void) {

    /* -------------------------------------------------------
     * 1. Constantes simples
     * ------------------------------------------------------- */
    printf("=== CONSTANTES ===\n");
    printf("App: %s v%s\n", APP_NOMBRE, APP_VERSION);
    printf("Pi = %.10f\n", PI);
    printf("Gravedad = %.2f m/s²\n", GRAVEDAD);
    printf("Velocidad de la luz = %d m/s\n", VELOCIDAD_LUZ);
    printf("Maximos alumnos por grupo: %d\n", MAX_ALUMNOS);

    /* -------------------------------------------------------
     * 2. Macros con parámetros
     * ------------------------------------------------------- */
    printf("\n=== MACROS CON PARAMETROS ===\n");

    int a = 5;
    printf("CUADRADO(%d)     = %d\n", a, CUADRADO(a));

    /* Demostración de por qué los paréntesis importan */
    printf("CUADRADO(2+3)   = %d  (correcto: 25)\n", CUADRADO(2+3));

    printf("ABS(-42)        = %d\n", ABS(-42));
    printf("ABS(17)         = %d\n", ABS(17));

    printf("MAX(8, 13)      = %d\n", MAX(8, 13));
    printf("MIN(8, 13)      = %d\n", MIN(8, 13));

    printf("90 grados en radianes = %.6f\n", DEG_A_RAD(90));

    /* -------------------------------------------------------
     * 3. Macros de debug con LOG_DEBUG
     * ------------------------------------------------------- */
    printf("\n=== MODO DEBUG ===\n");

    int resultado = CUADRADO(7);
    LOG_DEBUG("CUADRADO(7) = %d", resultado);

    /* Si DEBUG está definido, verás el mensaje; si no, no pasa nada */
    printf("(Compila con -DDEBUG para ver mensajes de debug)\n");

    /* -------------------------------------------------------
     * 4. VERIFICAR — macro de aserción personalizada
     * ------------------------------------------------------- */
    printf("\n=== VERIFICAR (asercion) ===\n");

    int divisor = 4;
    VERIFICAR(divisor != 0, "El divisor no puede ser cero");
    printf("Verificacion pasada: %d / %d = %d\n", 20, divisor, 20 / divisor);

    /* -------------------------------------------------------
     * 5. Macros predefinidas del compilador
     * ------------------------------------------------------- */
    printf("\n=== MACROS PREDEFINIDAS ===\n");

    printf("Archivo: %s\n",  __FILE__);
    printf("Linea:   %d\n",  __LINE__);
    printf("Fecha:   %s\n",  __DATE__);
    printf("Hora:    %s\n",  __TIME__);
    printf("Funcion: %s\n",  __func__);

    /* -------------------------------------------------------
     * 6. Detección de plataforma
     * ------------------------------------------------------- */
    printf("\n=== PLATAFORMA ===\n");
    printf("Compilado para: %s\n", PLATAFORMA);

    /* -------------------------------------------------------
     * 7. #if con expresiones numéricas
     * ------------------------------------------------------- */
    printf("\n=== CONDICIONAL NUMERICA ===\n");

#define VERSION_NUM 2

#if VERSION_NUM >= 3
    printf("Version 3 o superior — funcionalidades avanzadas activas\n");
#elif VERSION_NUM == 2
    printf("Version 2 — funcionalidades intermedias\n");
#else
    printf("Version 1 — modo basico\n");
#endif

    return 0;
}
