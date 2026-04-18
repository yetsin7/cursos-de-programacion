// =============================================================================
// ARCHIVO: 01_funciones_basicas.dart
// TEMA: Funciones basicas en Dart
// EJECUCION: dart run 01_funciones_basicas.dart
// =============================================================================
//
// Una funcion agrupa instrucciones bajo un nombre para poder reutilizarlas.
// En Dart, main() tambien es una funcion: es el punto de entrada del programa.
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // LLAMAR FUNCIONES DEFINIDAS A NIVEL GLOBAL
  // ─────────────────────────────────────────────────────────────────────────

  // Las funciones pueden definirse fuera de main() y llamarse desde aqui.
  print('--- Funciones básicas ---');
  saludar();
  imprimirLinea();

  // Funciones con parametros:
  saludarPersona('María');
  saludarPersona('Carlos');

  // Funciones que retornan valores:
  int resultado = sumar(3, 7);
  print('3 + 7 = $resultado');

  double area = calcularAreaRectangulo(5.0, 3.0);
  print('Área del rectángulo: $area');

  // ─────────────────────────────────────────────────────────────────────────
  // FUNCIONES LOCALES
  // ─────────────────────────────────────────────────────────────────────────

  // Una funcion local sirve cuando la logica solo se necesita en ese contexto.
  print('\n--- Funciones locales ---');

  // Esta funcion solo existe dentro de main().
  String formatearPrecio(double precio) {
    return '\$${precio.toStringAsFixed(2)}';
  }

  print(formatearPrecio(9.5));      // $9.50
  print(formatearPrecio(1299.99));  // $1299.99
  print(formatearPrecio(0.1));      // $0.10

  // ─────────────────────────────────────────────────────────────────────────
  // VOID
  // ─────────────────────────────────────────────────────────────────────────

  // void comunica que la funcion no devuelve un valor util.
  print('\n--- void ---');
  imprimirSeparador('=', 30);
  imprimirSeparador('-', 20);
  imprimirSeparador('*', 10);

  // ─────────────────────────────────────────────────────────────────────────
  // FUNCIONES QUE LLAMAN A OTRAS FUNCIONES
  // ─────────────────────────────────────────────────────────────────────────

  // Componer funciones ayuda a dividir problemas grandes en piezas pequeñas.
  print('\n--- Composición de funciones ---');

  double precioFinal = calcularPrecioConImpuesto(100.0, 0.15);
  print('Precio con impuesto 15%: \$${precioFinal.toStringAsFixed(2)}');

  double descuento = aplicarDescuento(precioFinal, 0.10);
  print('Con descuento 10%: \$${descuento.toStringAsFixed(2)}');
}

// ─────────────────────────────────────────────────────────────────────────────
// FUNCIONES GLOBALES
// ─────────────────────────────────────────────────────────────────────────────

/// Imprime un saludo generico.
/// No recibe parametros ni devuelve valor.
void saludar() {
  print('¡Hola desde la función saludar()!');
}

/// Imprime una linea horizontal para separar secciones.
void imprimirLinea() {
  print('─' * 40);
}

/// Saluda a una persona por su nombre.
/// [nombre] es el texto que se insertara en el saludo.
void saludarPersona(String nombre) {
  print('Hola, $nombre! Bienvenido a Dart.');
}

/// Suma dos enteros y devuelve el resultado.
int sumar(int a, int b) {
  return a + b;
}

/// Calcula el area de un rectangulo y devuelve un double.
double calcularAreaRectangulo(double base, double altura) {
  return base * altura;
}

/// Imprime un separador visual repitiendo un caracter.
void imprimirSeparador(String caracter, int longitud) {
  print(caracter * longitud);
}

/// Calcula el precio con impuesto incluido.
double calcularPrecioConImpuesto(double precio, double tasaImpuesto) {
  return precio + (precio * tasaImpuesto);
}

/// Aplica un descuento porcentual a un precio.
double aplicarDescuento(double precio, double tasaDescuento) {
  return precio - (precio * tasaDescuento);
}

// =============================================================================
// QUE DEBERIAS ENTENDER AL TERMINAR
// - Una funcion agrupa logica reutilizable.
// - main() tambien es una funcion.
// - Algunas funciones imprimen; otras devuelven valores.
// - Dividir el trabajo en funciones mejora la claridad del programa.
//
// PRACTICA GUIADA
// 1. Crea una funcion potencia(base, exponente).
// 2. Crea una funcion esPalindromo(texto).
// 3. Crea una funcion que reciba una lista y devuelva el mayor numero.
// =============================================================================
