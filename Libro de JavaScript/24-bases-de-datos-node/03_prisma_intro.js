// ============================================================
// ARCHIVO: 03_prisma_intro.js
// TEMA: Introducción conceptual a Prisma ORM
// CÓMO EJECUTAR: node 03_prisma_intro.js  (solo muestra la guía)
// DEPENDENCIA: npm install @prisma/client  (para usarlo de verdad)
// ============================================================

'use strict';

// ─────────────────────────────────────────────────────────────
// ¿QUÉ ES PRISMA?
// ─────────────────────────────────────────────────────────────
//
// Prisma es un ORM (Object-Relational Mapper) moderno para Node.js y TypeScript.
// Abstrae la base de datos: en lugar de escribir SQL crudo, usas funciones JS.
//
// Ventajas principales:
//  - Autocompletado en el IDE para queries (con TypeScript es muy potente)
//  - Migrations automáticas con un solo comando
//  - Compatible con PostgreSQL, MySQL, SQLite, MongoDB, SQL Server
//  - Genera tipos TypeScript desde el schema automáticamente
//
// Cuándo usar Prisma vs better-sqlite3:
//  - better-sqlite3: apps de escritorio, proyectos pequeños, solo SQLite
//  - Prisma: apps web con PostgreSQL/MySQL, proyectos medianos/grandes, TypeScript

// ─────────────────────────────────────────────────────────────
// CONFIGURACIÓN INICIAL
// ─────────────────────────────────────────────────────────────
//
// 1. Instalar Prisma CLI y cliente:
//    npm install @prisma/client
//    npm install -D prisma
//
// 2. Inicializar Prisma en el proyecto:
//    npx prisma init --datasource-provider sqlite
//    (crea prisma/schema.prisma y .env con DATABASE_URL)
//
// 3. El archivo .env generado:
//    DATABASE_URL="file:./dev.db"
//
// 4. Después de editar el schema, aplicar cambios:
//    npx prisma migrate dev --name init
//    (crea la BD, aplica el schema y regenera el cliente)

// ─────────────────────────────────────────────────────────────
// SCHEMA — prisma/schema.prisma
// ─────────────────────────────────────────────────────────────
//
// El schema define los modelos (tablas) y sus relaciones.
// Prisma genera el SQL y los tipos TypeScript desde este archivo.
//
// Ejemplo de schema completo:
//
// datasource db {
//   provider = "sqlite"         // o "postgresql", "mysql"
//   url      = env("DATABASE_URL")
// }
//
// generator client {
//   provider = "prisma-client-js"
// }
//
// model Nota {
//   id          Int      @id @default(autoincrement())
//   titulo      String
//   contenido   String   @default("")
//   publicada   Boolean  @default(false)
//   creadoEn    DateTime @default(now())
//   actualizadoEn DateTime @updatedAt
//   autorId     Int
//   autor       Usuario  @relation(fields: [autorId], references: [id])
// }
//
// model Usuario {
//   id      Int     @id @default(autoincrement())
//   nombre  String
//   email   String  @unique
//   notas   Nota[]
// }

// ─────────────────────────────────────────────────────────────
// QUERIES CON PRISMA CLIENT
// ─────────────────────────────────────────────────────────────
//
// Todas las operaciones son async/await y devuelven promesas.
//
// Configuración del cliente (un solo archivo en toda la app):
//
//   import { PrismaClient } from '@prisma/client';
//   const prisma = new PrismaClient();
//   export default prisma;

console.log('=== Guía de Prisma ORM ===\n');

// CREAR un registro
console.log('1. CREAR (prisma.nota.create):');
console.log(`
  const nuevaNota = await prisma.nota.create({
    data: {
      titulo: 'Mi primera nota',
      contenido: 'Hola desde Prisma',
      autorId: 1,
    },
  });
  // Retorna la nota creada con su id y timestamps
`);

// LEER — findMany (todos) y findUnique (uno)
console.log('2. LEER (findMany / findUnique):');
console.log(`
  // Todas las notas publicadas de un autor, ordenadas
  const notas = await prisma.nota.findMany({
    where: { publicada: true, autorId: 1 },
    orderBy: { creadoEn: 'desc' },
    take: 10,   // LIMIT
    skip: 0,    // OFFSET
    include: { autor: true },  // JOIN con la tabla de usuarios
  });

  // Una nota por ID (lanza error si no existe)
  const nota = await prisma.nota.findUnique({
    where: { id: 42 },
  });

  // Una nota o null si no existe
  const notaONull = await prisma.nota.findFirst({
    where: { titulo: { contains: 'Prisma' } },
  });
`);

// ACTUALIZAR
console.log('3. ACTUALIZAR (prisma.nota.update):');
console.log(`
  const notaActualizada = await prisma.nota.update({
    where: { id: 42 },
    data: {
      titulo: 'Título actualizado',
      publicada: true,
    },
  });
  // actualizadoEn se actualiza automáticamente (@updatedAt en el schema)
`);

// ELIMINAR
console.log('4. ELIMINAR (prisma.nota.delete):');
console.log(`
  await prisma.nota.delete({
    where: { id: 42 },
  });

  // Eliminar múltiples con deleteMany
  await prisma.nota.deleteMany({
    where: { publicada: false, autorId: 1 },
  });
`);

// TRANSACCIONES
console.log('5. TRANSACCIONES:');
console.log(`
  // Operaciones atómicas con prisma.$transaction
  const [usuario, nota] = await prisma.$transaction([
    prisma.usuario.create({ data: { nombre: 'Ana', email: 'ana@test.com' } }),
    prisma.nota.create({ data: { titulo: 'Bienvenida', autorId: 1 } }),
  ]);
`);

// MIGRATIONS
console.log('6. MIGRATIONS (desde la terminal):');
console.log(`
  # Crear y aplicar una nueva migración (desarrollo)
  npx prisma migrate dev --name agregar-campo-etiqueta

  # Ver el estado de las migraciones
  npx prisma migrate status

  # Aplicar migraciones en producción (sin crear archivos nuevos)
  npx prisma migrate deploy

  # Abrir Prisma Studio (GUI para ver y editar la BD en el navegador)
  npx prisma studio
`);

console.log('Para usar Prisma de verdad, ejecuta: npm install @prisma/client && npx prisma init');
