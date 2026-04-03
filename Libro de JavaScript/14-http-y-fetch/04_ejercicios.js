/**
 * 04_ejercicios.js
 * Módulo 14 — HTTP y Fetch
 * Ejercicios prácticos para afianzar el uso de fetch, manejo de errores,
 * encabezados HTTP, POST y encadenamiento de peticiones.
 *
 * Ejecutar: node 14-http-y-fetch/04_ejercicios.js
 * Nota: requiere Node.js 18+ para fetch nativo.
 */

// =============================================================================
// EJERCICIO 1
// Obtén los posts del usuario con ID 1 desde JSONPlaceholder.
// Imprime el título de cada post.
// URL: https://jsonplaceholder.typicode.com/posts?userId=1
// =============================================================================

console.log('── Ejercicio 1: Posts del usuario 1 ──');

async function ejercicio1() {
  try {
    const respuesta = await fetch('https://jsonplaceholder.typicode.com/posts?userId=1');

    // Verifica que la respuesta sea exitosa antes de parsear
    if (!respuesta.ok) {
      throw new Error(`HTTP ${respuesta.status}: ${respuesta.statusText}`);
    }

    const posts = await respuesta.json();

    // Muestra el título de cada post recibido
    posts.forEach((post, indice) => {
      console.log(`  ${indice + 1}. ${post.title}`);
    });

    console.log(`  Total: ${posts.length} posts\n`);
  } catch (error) {
    console.error('  Error en ejercicio 1:', error.message);
  }
}

// =============================================================================
// EJERCICIO 2
// Envía un POST con datos de un nuevo post a JSONPlaceholder.
// Verifica que la respuesta incluya un ID asignado por el servidor.
// URL: https://jsonplaceholder.typicode.com/posts
// =============================================================================

console.log('── Ejercicio 2: Crear un post con POST ──');

async function ejercicio2() {
  // Datos del nuevo post a enviar
  const nuevoPost = {
    title: 'Aprendiendo fetch con POST',
    body: 'Este post fue creado desde Node.js usando fetch nativo.',
    userId: 1,
  };

  try {
    const respuesta = await fetch('https://jsonplaceholder.typicode.com/posts', {
      method: 'POST',
      // Indica al servidor que el cuerpo es JSON
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(nuevoPost),
    });

    if (!respuesta.ok) {
      throw new Error(`HTTP ${respuesta.status}: ${respuesta.statusText}`);
    }

    const creado = await respuesta.json();
    console.log('  Post creado con éxito:');
    console.log(`  ID asignado: ${creado.id}`);
    console.log(`  Título: ${creado.title}\n`);
  } catch (error) {
    console.error('  Error en ejercicio 2:', error.message);
  }
}

// =============================================================================
// EJERCICIO 3
// Encadena dos peticiones:
//   1. Obtén el usuario con ID 3.
//   2. Con su nombre, obtén todos sus posts y cuenta cuántos tiene.
// URLs:
//   https://jsonplaceholder.typicode.com/users/3
//   https://jsonplaceholder.typicode.com/posts?userId=3
// =============================================================================

console.log('── Ejercicio 3: Peticiones encadenadas ──');

async function ejercicio3() {
  try {
    // Primera petición: datos del usuario
    const respUsuario = await fetch('https://jsonplaceholder.typicode.com/users/3');
    if (!respUsuario.ok) throw new Error(`HTTP ${respUsuario.status}`);
    const usuario = await respUsuario.json();

    console.log(`  Usuario encontrado: ${usuario.name} (${usuario.email})`);

    // Segunda petición: posts de ese usuario
    const respPosts = await fetch(`https://jsonplaceholder.typicode.com/posts?userId=${usuario.id}`);
    if (!respPosts.ok) throw new Error(`HTTP ${respPosts.status}`);
    const posts = await respPosts.json();

    console.log(`  ${usuario.name} tiene ${posts.length} posts publicados\n`);
  } catch (error) {
    console.error('  Error en ejercicio 3:', error.message);
  }
}

// =============================================================================
// EJERCICIO 4
// Usa Promise.all para obtener 3 usuarios en paralelo (IDs: 1, 2, 3).
// Imprime sus nombres y correos de forma ordenada.
// =============================================================================

console.log('── Ejercicio 4: Peticiones en paralelo con Promise.all ──');

async function ejercicio4() {
  try {
    // Lanza las 3 peticiones al mismo tiempo — más eficiente que hacerlas en serie
    const promesas = [1, 2, 3].map((id) =>
      fetch(`https://jsonplaceholder.typicode.com/users/${id}`).then((r) => r.json())
    );

    const usuarios = await Promise.all(promesas);

    usuarios.forEach((u) => {
      console.log(`  👤 ${u.name} — ${u.email}`);
    });
    console.log();
  } catch (error) {
    console.error('  Error en ejercicio 4:', error.message);
  }
}

// Ejecuta todos los ejercicios en orden
(async () => {
  await ejercicio1();
  await ejercicio2();
  await ejercicio3();
  await ejercicio4();
  console.log('✅ Todos los ejercicios completados');
})();
