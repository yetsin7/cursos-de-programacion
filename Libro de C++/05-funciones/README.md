# Capítulo 05 — Funciones

Las funciones permiten dividir el trabajo del programa en partes reutilizables.
En C++ son fundamentales para organizar lógica, reducir duplicación y controlar
cómo viajan los datos entre distintas partes del código.

---

## ¿Qué aprenderás?

- anatomia de una funcion;
- paso por valor, referencia y referencia constante;
- parametros por defecto;
- sobrecarga;
- `inline`;
- lambdas;
- recursion.

---

## ¿Qué pasa dentro del programa?

Cuando llamas una funcion:

- el programa transfiere control a ese bloque;
- entrega argumentos;
- ejecuta instrucciones;
- devuelve un valor o modifica datos segun el tipo de paso de parametros.

Esto influye directamente en rendimiento, seguridad y claridad.

---

## Paso de parámetros

En C++ no es igual pasar por valor que por referencia:

- por valor copia;
- por referencia modifica el original;
- por referencia constante evita copias y protege el dato.

Entender esto es clave para escribir funciones eficientes.

---

## Lambdas y recursión

Las lambdas ayudan a definir lógica pequeña cerca del lugar donde se usa.
La recursión ayuda a expresar problemas donde una solución se apoya en una
versión más pequeña del mismo problema.

---

## Errores comunes

- copiar objetos grandes sin necesidad;
- usar referencia cuando no deberías modificar;
- olvidar el caso base en recursión;
- abusar de sobrecargas poco claras.

---

## Archivo de ejemplo

Ver: [01_funciones.cpp](C:/Users/Yetsin/Documents/Programacion/cursos-de-programacion/Libro%20de%20C%2B%2B/05-funciones/01_funciones.cpp)
