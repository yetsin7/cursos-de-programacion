// =============================================================================
// ARCHIVO: 01_hola_mundo.dart
// TEMA: Tu primer programa en Dart
// =============================================================================
//
// Este archivo es el punto de partida de tu viaje con Dart.
// Aprenderás a usar print(), a declarar variables básicas y a interpolar
// texto con la sintaxis de Dart (equivalente a los f-strings de Python).
//
// CÓMO EJECUTAR:
//   dart run 01_hola_mundo.dart
//
// =============================================================================

// ─────────────────────────────────────────────────────────────────────────────
// EL PUNTO DE ENTRADA: void main()
// ─────────────────────────────────────────────────────────────────────────────

// En Dart, todo programa comienza en la función main().
// Es OBLIGATORIO. Sin main(), el programa no sabe por dónde empezar.
// El tipo de retorno "void" significa que la función no devuelve ningún valor.
void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // HOLA MUNDO — Lo más básico
  // ─────────────────────────────────────────────────────────────────────────

  // print() imprime texto en la consola y agrega un salto de línea al final.
  // Funciona igual que print() en Python.
  print('Hola, mundo!');
  print('Bienvenido al Libro de Flutter.');

  // ─────────────────────────────────────────────────────────────────────────
  // IMPRIMIR DISTINTOS TIPOS DE VALORES
  // ─────────────────────────────────────────────────────────────────────────

  // Dart puede imprimir cualquier valor directamente.
  // Los números, booleanos y otros tipos se convierten a String automáticamente.
  print(42);        // Número entero
  print(3.14);      // Número decimal
  print(true);      // Booleano
  print(null);      // El valor nulo (ausencia de valor)

  // ─────────────────────────────────────────────────────────────────────────
  // VARIABLES BÁSICAS
  // ─────────────────────────────────────────────────────────────────────────

  // "var" le dice a Dart que infiera el tipo automáticamente.
  // Una vez asignado el tipo, no puedes cambiarlo.
  // Aquí Dart deduce que "nombre" es de tipo String.
  var nombre = 'Flutter';
  var version = 3;
  var estaBuenisimo = true;

  print(nombre);
  print(version);
  print(estaBuenisimo);

  // ─────────────────────────────────────────────────────────────────────────
  // INTERPOLACIÓN DE STRINGS — El equivalente a los f-strings de Python
  // ─────────────────────────────────────────────────────────────────────────

  // En Python usas: f"Hola {nombre}"
  // En Dart usas:   "Hola $nombre"
  // El símbolo $ seguido del nombre de la variable inserta su valor.
  print('Hola desde $nombre $version!');

  // Para expresiones más complejas (llamadas a métodos, cálculos, etc.),
  // usa llaves: ${expresión}
  var precio = 9.99;
  var cantidad = 3;
  print('Total: \$${precio * cantidad}');
  // Nota: el primer \ escapa el símbolo $, para que no lo interprete como variable.
  // El segundo ${precio * cantidad} sí es interpolación.

  // También puedes llamar métodos dentro de la interpolación:
  print('Nombre en mayúsculas: ${nombre.toUpperCase()}');
  print('Longitud del nombre: ${nombre.length} letras');

  // ─────────────────────────────────────────────────────────────────────────
  // STRINGS CON COMILLAS SIMPLES Y DOBLES
  // ─────────────────────────────────────────────────────────────────────────

  // Dart acepta tanto comillas simples como dobles. Son equivalentes.
  // Elige uno y sé consistente en todo tu código.
  var mensaje1 = 'Usando comillas simples';
  var mensaje2 = "Usando comillas dobles";
  print(mensaje1);
  print(mensaje2);

  // Para strings multilínea, usa triple comilla (''' o """):
  var textoLargo = '''
Este es un string
que ocupa varias
líneas.
  ''';
  print(textoLargo);

  // ─────────────────────────────────────────────────────────────────────────
  // CONCATENACIÓN vs INTERPOLACIÓN
  // ─────────────────────────────────────────────────────────────────────────

  // Puedes concatenar strings con el operador +, pero la interpolación
  // es más limpia y recomendada en Dart.
  var lenguaje = 'Dart';

  // Forma menos recomendada (concatenación):
  print('Aprendiendo ' + lenguaje + ' desde cero');

  // Forma recomendada (interpolación):
  print('Aprendiendo $lenguaje desde cero');
}

// =============================================================================
// EXPERIMENTA:
//   1. Cambia el valor de "nombre" y vuelve a ejecutar el archivo.
//   2. Intenta imprimir una lista: print([1, 2, 3]) — ¿qué pasa?
//   3. Crea una variable con tu nombre y saluda con interpolación.
//   4. ¿Qué pasa si intentas hacer print(nombre + version)?
//      Pruébalo y lee el error — los errores de Dart son muy descriptivos.
//   5. Usa ${} para calcular cuántos días hay en 3 semanas dentro de un print().
// =============================================================================
