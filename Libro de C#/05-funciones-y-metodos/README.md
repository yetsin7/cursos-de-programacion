# Capítulo 05 — Funciones y métodos

Las funciones en C# se llaman metodos. Son la base para dividir lógica,
reutilizar comportamiento y evitar repetir código innecesariamente.

---

## ¿Qué aprenderás?

- metodos basicos;
- `out`, `ref`, `in` y `params`;
- parametros opcionales y con nombre;
- metodos de extension;
- lambdas;
- `Func`, `Action` y `Predicate`.

---

## ¿Por qué importa este capítulo?

Porque casi todo el software profesional se organiza alrededor de metodos:

- validaciones;
- calculos;
- transformaciones;
- acciones sobre datos;
- callbacks y eventos.

Aprender metodos bien hace mas facil entender clases, arquitectura y APIs.

---

## ¿Qué pasa dentro del programa?

Cuando llamas un metodo:

- el programa entra a ese bloque;
- recibe parametros;
- ejecuta instrucciones;
- puede devolver un valor o modificar algo por referencia;
- vuelve al punto desde donde fue llamado.

Eso organiza el flujo y reduce duplicacion.

---

## Errores comunes

- confundir imprimir con retornar;
- usar `ref` u `out` sin necesidad;
- abusar de lambdas complejas;
- crear metodos demasiado grandes.

---

## Ejecutar el ejemplo

```bash
cd 05-funciones-y-metodos
dotnet run
```
