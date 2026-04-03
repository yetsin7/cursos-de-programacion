// =============================================================================
// ARCHIVO: 04_bucle_while.dart
// TEMA: Bucles while y do-while en Dart
// =============================================================================
//
// El bucle while repite un bloque de código mientras una condición sea true.
// A diferencia del for, se usa cuando no sabes cuántas iteraciones vas a hacer.
// El do-while garantiza que el bloque se ejecute al menos una vez, sin importar
// si la condición es falsa desde el inicio.
//
// CÓMO EJECUTAR:
//   dart run 04_bucle_while.dart
//
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // WHILE — Repetir mientras la condición sea true
  // ─────────────────────────────────────────────────────────────────────────

  // La condición se verifica ANTES de ejecutar el bloque.
  // Si la condición es false desde el inicio, el bloque NUNCA se ejecuta.
  print('--- While básico ---');

  int contador = 0;
  while (contador < 5) {
    print('contador: $contador');
    contador++; // MUY IMPORTANTE: sin esto, el bucle sería infinito
  }
  print('Fin del while. contador = $contador');

  // Ejemplo práctico: buscar el primer número divisible por 7 mayor que 50.
  // No sabemos exactamente cuántas iteraciones necesitamos → while es ideal.
  print('\n--- Buscar primer divisible por 7 > 50 ---');
  int numero = 51;
  while (numero % 7 != 0) {
    numero++;
  }
  print('Primer número > 50 divisible por 7: $numero');

  // ─────────────────────────────────────────────────────────────────────────
  // WHILE CON CONDICIÓN FALSA AL INICIO
  // ─────────────────────────────────────────────────────────────────────────

  // Si la condición ya es false antes de entrar, el while no ejecuta nada.
  // Esta es la diferencia clave con do-while.
  print('\n--- While con condición falsa al inicio ---');
  int valor = 100;
  while (valor < 10) {
    print('Esto nunca se imprime');
    valor++;
  }
  print('El while no se ejecutó porque $valor >= 10');

  // ─────────────────────────────────────────────────────────────────────────
  // DO-WHILE — Ejecutar AL MENOS UNA VEZ
  // ─────────────────────────────────────────────────────────────────────────

  // do-while verifica la condición DESPUÉS de ejecutar el bloque.
  // Garantiza que el bloque se ejecute mínimo una vez.
  print('\n--- Do-while básico ---');

  int intentos = 0;
  do {
    intentos++;
    print('Intento número $intentos');
  } while (intentos < 3);

  // Mismo ejemplo que el while anterior, pero con condición falsa:
  // Con do-while, el bloque SÍ se ejecuta una vez aunque la condición sea false.
  print('\n--- Do-while con condición falsa desde inicio ---');
  int otroValor = 100;
  do {
    print('Esto se imprime UNA vez aunque $otroValor >= 10');
    otroValor++;
  } while (otroValor < 10);
  print('Después del do-while: $otroValor');

  // ─────────────────────────────────────────────────────────────────────────
  // CUÁNDO USAR CADA BUCLE
  // ─────────────────────────────────────────────────────────────────────────

  // FOR:      Sabes cuántas veces iterar, o recorres una colección.
  // WHILE:    No sabes cuántas veces necesitas, la condición guía el bucle.
  // DO-WHILE: Debes ejecutar el bloque al menos una vez antes de verificar.

  // Ejemplo típico de do-while: un "menú" que siempre muestra al menos una vez.
  print('\n--- Simulación de menú con do-while ---');
  int opcion = 0;
  int vecesEjecutado = 0;

  do {
    vecesEjecutado++;
    // En una app real, aquí mostrarías el menú y leerías la entrada del usuario.
    // Como no podemos leer input en este ejemplo, simulamos con un valor fijo.
    opcion = simularEntradaUsuario(vecesEjecutado);
    print('Opción seleccionada: $opcion');
  } while (opcion != 0 && vecesEjecutado < 5); // 0 = salir, máx 5 intentos

  print('Menú cerrado después de $vecesEjecutado iteraciones');

  // ─────────────────────────────────────────────────────────────────────────
  // CUIDADO: BUCLES INFINITOS
  // ─────────────────────────────────────────────────────────────────────────

  // Un bucle infinito ocurre cuando la condición nunca se vuelve false.
  // Siempre asegúrate de que algo dentro del bucle eventualmente lo detenga.
  //
  // Bucle infinito (NO ejecutar esto):
  // while (true) {
  //   print('Infinito...');  // Ctrl+C para detener
  // }
  //
  // El único caso donde "while (true)" es aceptable es con "break" adentro:
  print('\n--- while(true) con break ---');
  int n = 0;
  while (true) {
    n++;
    if (n >= 3) break; // Condición de salida explícita
    print('n = $n');
  }
  print('Salimos con n = $n');
}

/// Simula la entrada de un usuario en un menú.
/// En una aplicación real, esto leería desde stdin.
/// Devuelve valores distintos según la ronda para simular navegación.
int simularEntradaUsuario(int ronda) {
  // Simula que el usuario elige opciones y en la ronda 3 elige salir (0)
  return switch (ronda) {
    1 => 1,  // Primera ronda: opción 1
    2 => 2,  // Segunda ronda: opción 2
    _ => 0,  // Tercera ronda en adelante: salir
  };
}

// =============================================================================
// EXPERIMENTA:
//   1. Usa while para calcular cuántas veces necesitas duplicar $1 para
//      llegar a $1000 (empieza con 1, multiplica por 2 en cada iteración).
//   2. Simula tirar un dado (usa Random().nextInt(6)+1) con while hasta
//      que salga un 6. ¿Cuántos intentos tomó?
//   3. Escribe un do-while que pida contraseña hasta acertar (simula con
//      un contador — "acertar" en el tercer intento).
//   4. Convierte el while de búsqueda de divisibles por 7 en un for.
//      ¿Cuál es más claro en ese caso?
//   5. ¿Qué pasa con "while(false)"? ¿Y con "do {} while(false)"?
//      Escribe ambos y observa cuántas veces se ejecutan.
// =============================================================================
