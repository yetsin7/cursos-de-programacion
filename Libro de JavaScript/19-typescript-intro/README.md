# Módulo 19 — Introducción a TypeScript

## ¿Qué es TypeScript?

TypeScript es JavaScript con **tipos estáticos opcionales**. Lo desarrolla Microsoft y compila a JavaScript puro. No es un lenguaje nuevo — es un superset de JS: todo código JS válido es TypeScript válido.

## ¿Por qué TypeScript es el estándar en proyectos serios?

- **Detecta errores antes de ejecutar** el código
- **Autocompletado inteligente** en editores (VSCode lo aprovecha al máximo)
- **Documentación viva**: los tipos describen la API de cada función
- **Refactoring seguro**: renombrar variables o mover código sin romper nada
- Adoptado por Angular, NestJS, Next.js, Prisma, y prácticamente todo el ecosistema moderno

## Instalación y configuración

```bash
# Instalar TypeScript globalmente
npm install -g typescript

# Verificar versión
tsc --version

# Inicializar un proyecto TypeScript
npm init -y
npm install --save-dev typescript
npx tsc --init
```

Esto genera `tsconfig.json` con la configuración del compilador.

## Ejecutar archivos TypeScript

```bash
# Compilar a JS y ejecutar
tsc 01_tipos_basicos.ts && node 01_tipos_basicos.js

# Opción más cómoda para aprender: ts-node
npm install -g ts-node
ts-node 01_tipos_basicos.ts
```

## Archivos de este módulo

| Archivo | Contenido |
|---------|-----------|
| `01_tipos_basicos.ts` | string, number, boolean, any, unknown, never, arrays, tuplas, unions |
| `02_interfaces_y_types.ts` | interface, type alias, opcionales, readonly, extends, intersections |
| `03_funciones_genericos.ts` | funciones tipadas, generics, utility types |
| `04_clases_enums.ts` | Clases, modificadores de acceso, enums |
| `05_ejercicios.ts` | Ejercicios prácticos combinando todo |
