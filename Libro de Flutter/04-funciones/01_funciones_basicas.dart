// =============================================================================
// ARCHIVO: 01_funciones_basicas.dart
// TEMA: Declaración y uso básico de funciones en Dart
// =============================================================================
//
// Una función agrupa código reutilizable bajo un nombre. En Dart toda función
// tiene un tipo de retorno explícito (o "void" si no retorna nada), un nombre,
// y opcionalmente parámetros. El punto de entrada main() es en sí misma
// una función — la primera que Dart ejecuta.
//
// CÓMO EJECUTAR:
//   dart run 01_funciones_basicas.dart
//
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // LLAMAR FUNCIONES DEFINIDAS A NIVEL GLOBAL
  // ─────────────────────────────────────────────────────────────────────────

  // Las funciones se pueden definir fuera de main() y llamarse desde adentro.
  // En Dart NO existe el concepto de "definir antes de llamar" — puedes
  // llamar una función que está definida debajo en el archivo.
  print('--- Funciones básicas ---');
  saludar();
  imprimirLinea();

  // Funciones con parámetros:
  saludarPersona('María');
  saludarPersona('Carlos');

  // Funciones que retornan valores:
  int resultado = sumar(3, 7);
  print('3 + 7 = $resultado');

  double area = calcularAreaRectangulo(5.0, 3.0);
  print('Área del rectángulo: $area');

  // ─────────────────────────────────────────────────────────────────────────
  // FUNCIONES LOCALES — Definidas dentro de main() u otra función
  // ─────────────────────────────────────────────────────────────────────────

  // Puedes definir funciones dentro de otras funciones.
  // Son útiles para encapsular lógica que solo se usa en ese contexto.
  // No son visibles desde fuera de la función que las contiene.
  print('\n--- Funciones locales ---');

  // Esta función solo existe dentro de main():
  String formatearPrecio(double precio) {
    return '\$${precio.toStringAsFixed(2)}';
  }

  print(formatearPrecio(9.5));      // $9.50
  print(formatearPrecio(1299.99));  // $1299.99
  print(formatearPrecio(0.1));      // $0.10

  // ─────────────────────────────────────────────────────────────────────────
  // VOID — Funciones sin valor de retorno
  // ─────────────────────────────────────────────────────────────────────────

  // "void" indica que la función no devuelve ningún valor útil.
  // Toda función en Dart técnicamente devuelve null si no tiene return,
  // pero void comunica claramente la intención de "no retorna nada".
  print('\n--- void ---');
  imprimirSeparador('=', 30);
  imprimirSeparador('-', 20);
  imprimirSeparador('*', 10);

  // ─────────────────────────────────────────────────────────────────────────
  // FUNCIONES QUE LLAMAN A OTRAS FUNCIONES
  // ─────────────────────────────────────────────────────────────────────────

  // Es normal y correcto que las funciones se llamen entre sí.
  // Esto es el principio de composición de funciones.
  print('\n--- Composición de funciones ---');

  double precioFinal = calcularPrecioConImpuesto(100.0, 0.15);
  print('Precio con impuesto 15%: \$${precioFinal.toStringAsFixed(2)}');

  double descuento = aplicarDescuento(precioFinal, 0.10);
  print('Con descuento 10%: \$${descuento.toStringAsFixed(2)}');
}

// ─────────────────────────────────────────────────────────────────────────────
// FUNCIONES GLOBALES — Definidas fuera de main()
// ─────────────────────────────────────────────────────────────────────────────

/// Imprime un mensaje de saludo genérico.
/// No recibe parámetros ni devuelve valor.
void saludar() {
  print('¡Hola desde la función saludar()!');
}

/// Imprime una línea horizontal de guiones para separar secciones.
void imprimirLinea() {
  print('─' * 40);
}

/// Saluda a una persona específica por su nombre.
///
/// Parámetros:
/// - [nombre]: El nombre de la persona a saludar.
void saludarPersona(String nombre) {
  print('Hola, $nombre! Bienvenido a Dart.');
}

/// Suma dos números enteros y devuelve el resultado.
///
/// Parámetros:
/// - [a]: Primer sumando.
/// - [b]: Segundo sumando.
///
/// Retorna la suma de [a] y [b].
int sumar(int a, int b) {
  return a + b;
}

/// Calcula el área de un rectángulo.
///
/// Parámetros:
/// - [base]: La base del rectángulo.
/// - [altura]: La altura del rectángulo.
///
/// Retorna el área como [double].
double calcularAreaRectangulo(double base, double altura) {
  return base * altura;
}

/// Imprime un separador visual de longitud dada.
///
/// Parámetros:
/// - [caracter]: El carácter a repetir.
/// - [longitud]: Cuántas veces repetirlo.
void imprimirSeparador(String caracter, int longitud) {
  print(caracter * longitud);
}

/// Calcula el precio con impuesto incluido.
///
/// Parámetros:
/// - [precio]: El precio base.
/// - [tasaImpuesto]: La tasa como decimal (0.15 = 15%).
///
/// Retorna el precio con impuesto.
double calcularPrecioConImpuesto(double precio, double tasaImpuesto) {
  return precio + (precio * tasaImpuesto);
}

/// Aplica un descuento porcentual a un precio.
///
/// Parámetros:
/// - [precio]: El precio original.
/// - [tasaDescuento]: El descuento como decimal (0.10 = 10%).
///
/// Retorna el precio con descuento aplicado.
double aplicarDescuento(double precio, double tasaDescuento) {
  return precio - (precio * tasaDescuento);
}

// =============================================================================
// EXPERIMENTA:
//   1. Crea una función "potencia(base, exponente)" que multiplique base
//      por sí misma exponente veces usando un bucle (sin dart:math).
//   2. Crea una función "esPalindromo(texto)" que devuelva true si el texto
//      se lee igual al revés.
//   3. Define una función local dentro de saludarPersona() que formate el
//      nombre (primera letra en mayúscula, resto en minúscula).
//   4. Crea una función que reciba una lista de números y devuelva el mayor.
//   5. ¿Puede una función devolver void? ¿Qué pasa si escribes
//      "return;" dentro de una función void? Pruébalo.
// =============================================================================
