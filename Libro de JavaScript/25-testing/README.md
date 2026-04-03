# Módulo 25 — Testing en JavaScript

## ¿Por qué testear?

El código sin tests es código que *esperas* que funcione. Los tests son la red de seguridad que te permite refactorizar, agregar funcionalidades y corregir bugs **con confianza**.

---

## La pirámide de testing

```
        /\
       /  \   E2E (pocos, lentos, costosos)
      /----\
     /      \  Integración (medianos)
    /--------\
   /          \ Unitarios (muchos, rápidos, baratos)
  /____________\
```

| Tipo         | ¿Qué prueba?                          | Velocidad |
|--------------|---------------------------------------|-----------|
| Unitario     | Una función o clase aislada           | Muy rápido |
| Integración  | Varias piezas trabajando juntas       | Medio     |
| E2E (end-to-end) | Flujo completo del usuario        | Lento     |

**Regla general:** escribe muchos tests unitarios, algunos de integración, y pocos E2E.

---

## Jest vs Vitest

| Característica     | Jest                        | Vitest                        |
|--------------------|-----------------------------|-------------------------------|
| Creado por         | Meta                        | Comunidad Vite                |
| Configuración      | Más verbosa                 | Mínima (usa vite.config)      |
| Velocidad          | Buena                       | Muy rápida (HMR en tests)     |
| Ecosistema         | Enorme, muy maduro          | Creciendo rápido              |
| ESM nativo         | Requiere configuración      | Nativo                        |
| Compatible con Jest| —                           | Sí (misma API)                |
| Uso ideal          | Node.js, React (CRA/Next)   | Vite, Vue, Nuxt, proyectos modernos |

> Para este módulo usamos **Jest** por su prevalencia en el ecosistema. Instalar con:
> ```bash
> npm install -D jest
> ```

---

## Archivos del módulo

| Archivo              | Contenido                                          |
|----------------------|----------------------------------------------------|
| `01_jest_basico.js`  | Matchers, describe/test, hooks de ciclo de vida    |
| `02_mocks.js`        | jest.fn(), spyOn, mock de módulos y fetch          |
| `03_testing_async.js`| Promises, async/await, fake timers, callbacks      |
| `04_ejercicios.js`   | Suite de tests para el gestor de tareas (módulo 11)|

---

## Estructura de un test

```js
// Describe agrupa tests relacionados
describe('MiModulo', () => {
  // beforeEach corre antes de cada test
  beforeEach(() => { /* setup */ });

  test('descripción clara de lo que debe hacer', () => {
    // Arrange — preparar datos
    // Act — ejecutar la función
    // Assert — verificar resultado
    expect(resultado).toBe(esperado);
  });
});
```

> **Regla AAA:** Arrange, Act, Assert — mantén cada test enfocado en una sola cosa.
