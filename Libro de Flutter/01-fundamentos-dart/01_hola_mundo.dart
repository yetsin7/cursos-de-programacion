// =============================================================================
// ARCHIVO: 01_hola_mundo.dart
// TEMA: Tu primer programa en Dart
// EJECUCION: dart run 01_hola_mundo.dart
// =============================================================================
//
// Este archivo es el punto de partida para entender Dart como lenguaje.
// Antes de construir interfaces en Flutter, necesitas comprender como un
// programa lee instrucciones, crea datos en memoria y produce una salida.
//
// Cuando ejecutes este archivo:
// - Dart compilara o interpretara el codigo segun el entorno.
// - El programa entrara por main().
// - Se crearan variables en memoria.
// - La consola mostrara la salida visible.
// =============================================================================

// ─────────────────────────────────────────────────────────────────────────────
// EL PUNTO DE ENTRADA: void main()
// ─────────────────────────────────────────────────────────────────────────────

// En Dart, todo programa comienza en la funcion main().
// Es el punto de entrada. Sin main(), el runtime no sabe que ejecutar primero.
// "void" significa que esta funcion no devuelve un valor al finalizar.
void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // HOLA MUNDO — Lo más básico
  // ─────────────────────────────────────────────────────────────────────────

  // print() envia informacion a la consola.
  // Esa consola es una salida visible del software para mostrar resultados.
  print('Hola, mundo!');
  print('Bienvenido al Libro de Flutter.');

  // ─────────────────────────────────────────────────────────────────────────
  // IMPRIMIR DISTINTOS TIPOS DE VALORES
  // ─────────────────────────────────────────────────────────────────────────

  // Dart puede convertir muchos valores a texto automaticamente para imprimirlos.
  print(42);        // Número entero
  print(3.14);      // Número decimal
  print(true);      // Booleano
  print(null);      // El valor nulo (ausencia de valor)

  // ─────────────────────────────────────────────────────────────────────────
  // VARIABLES BÁSICAS
  // ─────────────────────────────────────────────────────────────────────────

  // "var" le pide a Dart inferir el tipo automaticamente.
  // El valor vive en memoria y la variable actua como un nombre para accederlo.
  var nombre = 'Flutter';
  var version = 3;
  var estaBuenisimo = true;

  print(nombre);
  print(version);
  print(estaBuenisimo);

  // ─────────────────────────────────────────────────────────────────────────
  // INTERPOLACIÓN DE STRINGS — El equivalente a los f-strings de Python
  // ─────────────────────────────────────────────────────────────────────────

  // La interpolacion inserta valores dentro del texto.
  // En lugar de unir cadenas manualmente, dejas que Dart construya el resultado.
  print('Hola desde $nombre $version!');

  // Para expresiones mas complejas, usa llaves: ${expresion}
  var precio = 9.99;
  var cantidad = 3;
  print('Total: \$${precio * cantidad}');
  // El simbolo \ evita que el primer $ se interprete como interpolacion.

  // Tambien puedes ejecutar operaciones dentro de la interpolacion.
  print('Nombre en mayúsculas: ${nombre.toUpperCase()}');
  print('Longitud del nombre: ${nombre.length} letras');

  // ─────────────────────────────────────────────────────────────────────────
  // STRINGS CON COMILLAS SIMPLES Y DOBLES
  // ─────────────────────────────────────────────────────────────────────────

  // Dart acepta comillas simples y dobles.
  // Lo importante es ser consistente para mejorar legibilidad.
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

  // Puedes concatenar strings con +, pero la interpolacion suele ser mas clara.
  var lenguaje = 'Dart';

  // Forma menos recomendada (concatenación):
  print('Aprendiendo ' + lenguaje + ' desde cero');

  // Forma recomendada (interpolación):
  print('Aprendiendo $lenguaje desde cero');
}

// =============================================================================
// QUE DEBERIAS ENTENDER AL TERMINAR
// - main() es el punto de entrada del programa.
// - print() produce una salida visible en consola.
// - Las variables apuntan a valores administrados por Dart en memoria.
// - La interpolacion vuelve mas claro el texto dinamico.
// - Dart distingue tipos y eso ayuda a evitar errores.
//
// PRACTICA GUIADA
// 1. Cambia el valor de nombre y version.
// 2. Crea una variable llamada ciudad.
// 3. Imprime un mensaje con tu nombre, ciudad y edad.
// 4. Intenta hacer print(nombre + version) y explica el error.
// 5. Calcula con ${} cuantos dias hay en 4 semanas.
// =============================================================================
