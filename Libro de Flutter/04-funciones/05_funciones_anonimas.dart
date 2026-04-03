// =============================================================================
// ARCHIVO: 05_funciones_anonimas.dart
// TEMA: Funciones anónimas, closures, callbacks y typedef en Dart
// =============================================================================
//
// Las funciones anónimas (lambdas) no tienen nombre — se definen directamente
// donde se usan. Las closures son funciones que "capturan" variables de su
// entorno. Los callbacks son funciones pasadas como parámetros. Estas
// herramientas son esenciales para el estilo funcional de Dart y Flutter.
//
// CÓMO EJECUTAR:
//   dart run 05_funciones_anonimas.dart
//
// =============================================================================

// Typedef permite definir un tipo para una firma de función específica.
// Es equivalente a crear un "alias de tipo" para funciones.
typedef Transformador = String Function(String);
typedef Validador = bool Function(String);
typedef Operacion = double Function(double, double);

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // FUNCIONES ANÓNIMAS — Sin nombre, asignadas a variables
  // ─────────────────────────────────────────────────────────────────────────

  print('--- Funciones anónimas ---');

  // Una función anónima es como una función normal, pero sin nombre.
  // Se asigna directamente a una variable de tipo función.
  var saludar = (String nombre) {
    return '¡Hola, $nombre!';
  };

  print(saludar('Dart'));
  print(saludar('Flutter'));

  // Versión arrow (más corta, mismo resultado):
  var despedir = (String nombre) => 'Adiós, $nombre!';
  print(despedir('Dart'));

  // El tipo se infiere, pero puedes ser explícito:
  String Function(int) cuadradoTexto = (n) => 'El cuadrado de $n es ${n * n}';
  print(cuadradoTexto(7));

  // ─────────────────────────────────────────────────────────────────────────
  // CLOSURES — Capturar variables del entorno
  // ─────────────────────────────────────────────────────────────────────────

  // Un closure es una función que "recuerda" las variables del alcance donde
  // fue creada, incluso después de que ese alcance haya terminado.
  // Es diferente de un parámetro: la variable se comparte, no se copia.
  print('\n--- Closures ---');

  // crearContador() devuelve una función que recuerda "conteo":
  var contador = crearContador();
  print(contador()); // 1
  print(contador()); // 2
  print(contador()); // 3

  // Cada llamada a crearContador() crea un closure INDEPENDIENTE:
  var otroContador = crearContador();
  print(otroContador()); // 1 — empieza de cero, independiente del primero

  // Closure con parámetro capturado:
  var sumar5 = crearSumador(5);
  var sumar10 = crearSumador(10);
  print('sumar5(3) = ${sumar5(3)}');    // 8
  print('sumar10(3) = ${sumar10(3)}');  // 13

  // ─────────────────────────────────────────────────────────────────────────
  // CALLBACKS — Pasar funciones como parámetros
  // ─────────────────────────────────────────────────────────────────────────

  // Un callback es una función pasada como argumento para ser llamada
  // por la función receptora en algún momento (inmediato o futuro).
  // Son el mecanismo base de los eventos en Flutter (onPressed, onChanged, etc.).
  print('\n--- Callbacks ---');

  // Pasar una función nombrada como callback:
  procesarLista([1, 2, 3, 4, 5], imprimirElemento);

  // Pasar una función anónima como callback:
  procesarLista([10, 20, 30], (elemento) {
    print('Elemento × 2 = ${elemento * 2}');
  });

  // Pasar una arrow function como callback:
  procesarLista(['a', 'b', 'c'], (e) => print('Letra: $e'));

  // Ejemplo con callbacks que devuelven valor (como map/where):
  var numeros = [1, 2, 3, 4, 5, 6];
  var pares = filtrar(numeros, (n) => n % 2 == 0);
  print('\nPares: $pares');

  // ─────────────────────────────────────────────────────────────────────────
  // TYPEDEF — Tipar funciones para mayor claridad
  // ─────────────────────────────────────────────────────────────────────────

  // typedef crea un nombre para una firma de función.
  // Mejora la legibilidad cuando pasas funciones como parámetros.
  print('\n--- typedef ---');

  // Usando el typedef Transformador = String Function(String):
  Transformador aGritos = (s) => s.toUpperCase() + '!!!';
  Transformador aSusurro = (s) => s.toLowerCase() + '...';

  print(aplicarTransformacion('flutter', aGritos));  // FLUTTER!!!
  print(aplicarTransformacion('DART', aSusurro));    // dart...

  // Usando el typedef Validador:
  Validador esEmailBasico = (s) => s.contains('@') && s.contains('.');
  Validador esSoloLetras = (s) => RegExp(r'^[a-zA-Z]+$').hasMatch(s);

  print('\nValidaciones:');
  print('hola@mail.com es email: ${esEmailBasico("hola@mail.com")}');
  print('noesmail es email: ${esEmailBasico("noesmail")}');
  print('"Flutter" es solo letras: ${esSoloLetras("Flutter")}');
  print('"Flutter3" es solo letras: ${esSoloLetras("Flutter3")}');

  // Usando el typedef Operacion:
  Operacion sumar = (a, b) => a + b;
  Operacion restar = (a, b) => a - b;
  Operacion multiplicar = (a, b) => a * b;

  print('\nOperaciones:');
  print('calcular(10, 3, sumar) = ${calcular(10, 3, sumar)}');
  print('calcular(10, 3, restar) = ${calcular(10, 3, restar)}');
  print('calcular(10, 3, multiplicar) = ${calcular(10, 3, multiplicar)}');
}

/// Crea un contador que incrementa su valor interno cada vez que se llama.
/// Usa un closure para mantener el estado entre llamadas.
int Function() crearContador() {
  int conteo = 0;
  // Esta función anónima captura "conteo" del entorno exterior
  return () => ++conteo;
}

/// Crea una función que suma un valor fijo a cualquier número.
///
/// Parámetros:
/// - [incremento]: El valor a sumar en cada llamada.
int Function(int) crearSumador(int incremento) {
  return (int numero) => numero + incremento;
}

/// Itera sobre una lista y llama el callback para cada elemento.
void procesarLista<T>(List<T> lista, void Function(T) callback) {
  for (var elemento in lista) {
    callback(elemento);
  }
}

/// Imprime un elemento. Función nombrada usada como callback.
void imprimirElemento(dynamic elemento) {
  print('→ $elemento');
}

/// Filtra una lista usando un predicado (función que devuelve bool).
List<T> filtrar<T>(List<T> lista, bool Function(T) predicado) {
  return lista.where(predicado).toList();
}

/// Aplica una transformación de texto usando el typedef Transformador.
String aplicarTransformacion(String texto, Transformador transformador) {
  return transformador(texto);
}

/// Realiza una operación matemática usando el typedef Operacion.
double calcular(double a, double b, Operacion operacion) {
  return operacion(a, b);
}

// =============================================================================
// EXPERIMENTA:
//   1. Crea un closure "generadorId" que devuelva IDs únicos: ID-1, ID-2, ID-3...
//   2. Usa typedef para definir un tipo "OnPressed = void Function()" y
//      crea una función que reciba ese callback (simula el onPressed de Flutter).
//   3. Crea una función "componerTransformaciones" que reciba dos Transformadores
//      y devuelva uno que aplique ambos en secuencia.
//   4. Implementa una mini-pipeline: dado [1..10], filtra pares, multiplica ×3,
//      y suma todos los resultados — usando solo map(), where() y reduce().
//   5. ¿Cuál es la diferencia entre pasar una función anónima y una función
//      nombrada como callback? Prueba ambas con forEach.
// =============================================================================
