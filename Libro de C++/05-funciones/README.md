# Capítulo 05 — Funciones

## Anatomía de una función

```cpp
// tipoRetorno nombreFuncion(parámetros) { cuerpo }
int sumar(int a, int b) {
    return a + b;
}

// Función sin retorno
void saludar(const std::string& nombre) {
    std::cout << "Hola, " << nombre << "!\n";
}
```

---

## Parámetros por valor, referencia y referencia constante

```cpp
// Por valor: se copia el argumento, el original no cambia
void incrementarCopia(int n) { n++; }

// Por referencia: se modifica el original directamente
void incrementarRef(int& n) { n++; }

// Por referencia constante: lectura eficiente sin copia (ideal para strings/objetos)
void imprimirNombre(const std::string& nombre) {
    std::cout << nombre << "\n";
}
```

---

## Parámetros por defecto

Los parámetros con valor por defecto deben ir **al final** de la lista:

```cpp
// 'exponente' tiene valor por defecto 2 (cuadrado)
double potencia(double base, int exponente = 2) {
    double resultado = 1.0;
    for (int i = 0; i < exponente; i++) resultado *= base;
    return resultado;
}

potencia(3.0);     // 9.0  (usa exponente=2)
potencia(3.0, 3);  // 27.0 (usa exponente=3)
```

---

## Sobrecarga de funciones

C++ permite varias funciones con el **mismo nombre** pero **diferentes parámetros**:

```cpp
int    area(int lado);                   // Cuadrado
double area(double base, double altura); // Rectángulo/triángulo
double area(double radio);               // Círculo

// El compilador elige cuál llamar según los argumentos
area(5);          // Llama a area(int)
area(3.0, 4.0);   // Llama a area(double, double)
```

> La sobrecarga se resuelve en **tiempo de compilación** (no en ejecución).

---

## Funciones `inline`

Sugerencia al compilador para expandir la función en el punto de llamada
(evita el overhead de una llamada de función en operaciones muy pequeñas):

```cpp
inline int cuadrado(int x) { return x * x; }
```

> El compilador puede ignorar `inline`. En C++ moderno, el compilador hace
> esta optimización automáticamente cuando lo considera conveniente.

---

## Lambdas (C++11)

Las lambdas son **funciones anónimas** definidas en el lugar donde se usan:

```cpp
// Sintaxis: [captura](parámetros) -> tipoRetorno { cuerpo }
auto sumar = [](int a, int b) -> int { return a + b; };
sumar(3, 4);  // 7

// Captura de variables del scope exterior
int multiplicador = 5;
auto multiplicar = [multiplicador](int x) { return x * multiplicador; };

// Capturar todo por valor: [=]
// Capturar todo por referencia: [&]
// Capturar específicamente: [var1, &var2]
```

---

## Funciones recursivas

Una función que se llama a sí misma. Siempre debe tener un caso base:

```cpp
// Factorial: n! = n * (n-1)! , con caso base 0! = 1
long long factorial(int n) {
    if (n <= 1) return 1;       // Caso base
    return n * factorial(n-1); // Llamada recursiva
}
```

---

## Archivo de ejemplo

Ver: [01_funciones.cpp](01_funciones.cpp)
