# Libro de TypeScript — De cero a PRO

Curso practico, progresivo y muy explicativo para aprender TypeScript de forma
seria. La meta de este libro no es solo que sepas escribir anotaciones de tipo,
sino que entiendas como TypeScript mejora el desarrollo de software, como se
transforma a JavaScript y por que eso reduce errores reales.

---

## ¿Para quien es este libro?

- Personas que ya conocen algo de JavaScript y quieren trabajar mejor
- Personas principiantes que quieren aprender con mas estructura desde el inicio
- Desarrolladores que quieren escribir software mas mantenible y seguro
- Equipos que necesitan modelar datos, funciones y modulos con claridad

## Objetivo real del libro

Al terminar este curso deberias poder:

- entender que problema resuelve TypeScript;
- diferenciar desarrollo, compilacion y ejecucion;
- modelar datos con tipos, interfaces, unions y generics;
- leer y corregir errores del compilador con criterio;
- organizar proyectos pequenos y medianos con buena base tecnica.

## Que vas a aprender sobre software

Este libro insiste en varias ideas importantes:

- TypeScript ayuda en desarrollo, pero quien se ejecuta es JavaScript.
- El compilador revisa relaciones logicas entre datos, no magia.
- Los tipos no reemplazan la validacion de datos externos.
- Un buen modelado de tipos mejora legibilidad, mantenimiento y colaboracion.

## Requisitos

- **Node.js** v18 o superior
- **npm** incluido con Node.js
- **VS Code** recomendado

## Instalacion inicial

Desde la carpeta `Libro de TypeScript/`:

```bash
npm install
```

## Como estudiar este libro

1. Lee el `README.md` general del libro.
2. Abre el `README.md` del capitulo.
3. Recorre los archivos `.ts` en orden.
4. Ejecuta revision de tipos con `npx tsc --noEmit`.
5. Compila con `npx tsc` cuando quieras ver JavaScript generado.
6. Observa como el mismo concepto se ve en TypeScript y en JavaScript.
7. Cambia codigo a proposito para provocar errores y entenderlos.

## Que ocurre cuando trabajas con TypeScript

Cuando escribes TypeScript:

- el editor analiza tipos y relaciones mientras escribes;
- el compilador revisa incoherencias antes de ejecutar;
- si todo es valido, genera JavaScript;
- Node.js o el navegador ejecutan ese JavaScript compilado.

Eso significa que TypeScript no sustituye a JavaScript. Lo acompana y lo vuelve
mas claro en el proceso de construccion del software.

## Ruta del libro

| Nivel | Modulo | Tema |
|---|---|---|
| 🟢 Basico | `01-introduccion/` | Que es TypeScript y como se compila |
| 🟢 Basico | `02-tipos-y-variables/` | Tipos primitivos, inferencia y anotaciones |
| 🟢 Basico | `03-funciones-e-interfaces/` | Parametros, retorno, objetos e interfaces |
| 🟡 Medio | `04-objetos-arreglos-y-uniones/` | Arrays, unions, aliases y narrowing |
| 🟡 Medio | `05-generics-y-narrowing/` | Generics, guards y reutilizacion segura |
| 🟡 Medio | `06-clases-y-modulos/` | Clases, modificadores y export/import |
| 🔴 Avanzado | `07-utility-types/` | `Partial`, `Pick`, `Record`, `Omit` y modelado practico |
| 🔴 Avanzado | `08-tsconfig-y-tooling/` | Configuracion, strict mode y flujo de trabajo |
| 🔴 Avanzado | `09-async-y-fetch/` | Promesas, fetch y datos externos tipados |
| 🔴 Avanzado | `10-proyecto-final/` | Mini proyecto final guiado con varios modulos |

## Como se conecta con JavaScript

Si vienes de JavaScript, este libro te ayudara a ver que:

- `interface` y `type` describen formas de datos;
- `unknown` suele ser mas seguro que `any`;
- los generics permiten reutilizar logica sin perder informacion;
- los errores del compilador pueden prevenir muchos errores de integracion.

## Errores comunes que este libro quiere corregir

- pensar que TypeScript cambia el comportamiento en tiempo de ejecucion;
- usar `any` como salida rapida demasiado pronto;
- creer que tener tipos elimina la necesidad de validar APIs o archivos;
- aprender solo sintaxis sin entender el flujo compilacion -> JavaScript;
- evitar los mensajes del compilador en vez de aprender a leerlos.

## Archivos base del libro

| Archivo | Descripcion |
|---|---|
| `package.json` | Dependencias y scripts del libro |
| `tsconfig.json` | Configuracion principal del compilador |
| `.gitignore` | Archivos generados que no conviene versionar |
| `GUIA_DE_ESTUDIO.md` | Metodo recomendado para aprovechar el curso |

## Resultado esperado al terminar

Si completas este libro con practica real, deberias estar listo para:

- usar TypeScript en proyectos Node.js;
- entender mejor bases de frameworks como React, Next.js o Angular;
- modelar contratos de datos mas claros;
- trabajar con codigo moderno de frontend o backend con menos errores.

---

## Licencia

Este material es de uso libre para fines educativos.
