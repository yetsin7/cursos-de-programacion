// =============================================================================
// ARCHIVO: 02_interpolacion.dart
// TEMA: Interpolación de strings en Dart
// =============================================================================
//
// La interpolación es la forma idiomática de Dart para construir strings
// dinámicos. Es más legible que la concatenación con + y evita errores
// de conversión de tipos. Se usa $ para variables simples y ${} para
// cualquier expresión arbitraria.
//
// CÓMO EJECUTAR:
//   dart run 02_interpolacion.dart
//
// =============================================================================

// Clase auxiliar para demostrar interpolación con objetos
class Producto {
  // Nombre del producto
  final String nombre;
  // Precio en la moneda base
  final double precio;
  // Cantidad disponible en inventario
  final int stock;

  /// Crea un producto con nombre, precio y stock dados.
  const Producto(this.nombre, this.precio, this.stock);

  /// Retorna una representación legible del producto.
  @override
  String toString() => 'Producto($nombre, \$$precio)';
}

void main() {
  // ────────────────────────────────────────────────────────────────────────────
  // 1. INTERPOLACIÓN SIMPLE CON $variable
  // ────────────────────────────────────────────────────────────────────────────

  String nombre = 'María';
  int edad = 28;
  double altura = 1.65;

  // Dart inserta el valor de la variable directamente en el string
  print('Nombre: $nombre');
  print('Edad: $edad años');
  print('Altura: ${altura}m'); // {} necesarios cuando sigue un carácter alfanumérico

  // Sin llaves, Dart podría confundirse con el nombre de la variable
  String prefijo = 'sub';
  // print('$prefijotítulo'); // ERROR: busca variable 'prefijotítulo'
  print('${prefijo}título');  // CORRECTO: interpola 'prefijo' + literal 'título'

  // ────────────────────────────────────────────────────────────────────────────
  // 2. INTERPOLACIÓN CON EXPRESIONES ${}
  // ────────────────────────────────────────────────────────────────────────────

  int a = 15;
  int b = 4;

  // Operaciones aritméticas dentro de ${}
  print('$a + $b = ${a + b}');
  print('$a * $b = ${a * b}');
  print('$a / $b = ${a / b}');
  print('$a ~/ $b = ${a ~/ b}'); // División entera
  print('$a % $b = ${a % b}');   // Módulo

  // Comparaciones (devuelven bool)
  print('¿$a > $b? ${a > b}');
  print('¿$a es par? ${a % 2 == 0}');

  // Expresiones condicionales (ternario) dentro de ${}
  String resultado = '${a % 2 == 0 ? "par" : "impar"}';
  print('$a es $resultado');

  // ────────────────────────────────────────────────────────────────────────────
  // 3. INTERPOLACIÓN CON PROPIEDADES Y MÉTODOS DE OBJETOS
  // ────────────────────────────────────────────────────────────────────────────

  Producto laptop = Producto('Laptop Pro', 1299.99, 5);

  // Acceder a propiedades del objeto
  print('Producto: ${laptop.nombre}');
  print('Precio: \$${laptop.precio.toStringAsFixed(2)}');
  print('Stock disponible: ${laptop.stock} unidades');

  // Llamar a toString() automáticamente
  print('Objeto: $laptop'); // Llama laptop.toString()

  // Encadenar métodos dentro de la interpolación
  String ciudad = '  buenos aires  ';
  print('Ciudad: ${ciudad.trim().toUpperCase()}');

  // ────────────────────────────────────────────────────────────────────────────
  // 4. INTERPOLACIÓN VS CONCATENACIÓN
  // ────────────────────────────────────────────────────────────────────────────

  String usuario = 'Carlos';
  int puntos = 1500;
  String nivel = 'Oro';

  // Con concatenación: verboso, requiere .toString() explícito para no-strings
  String msgConcat = 'Usuario: ' + usuario +
      ' — Puntos: ' + puntos.toString() +
      ' — Nivel: ' + nivel;

  // Con interpolación: limpio, legible, conversión automática
  String msgInterp = 'Usuario: $usuario — Puntos: $puntos — Nivel: $nivel';

  print(msgConcat);
  print(msgInterp);
  print('¿Iguales? ${msgConcat == msgInterp}'); // true

  // ────────────────────────────────────────────────────────────────────────────
  // 5. TEMPLATE STRINGS COMPLEJOS
  // ────────────────────────────────────────────────────────────────────────────

  List<String> ingredientes = ['harina', 'huevos', 'leche'];
  double precioTotal = 45.75;
  String moneda = 'MXN';

  // Template multilínea con expresiones complejas
  String recibo = '''
╔══════════════════════════════╗
  RECIBO DE COMPRA
══════════════════════════════
  Ingredientes: ${ingredientes.length} artículos
  Lista: ${ingredientes.join(', ')}
  Total: $moneda \$${precioTotal.toStringAsFixed(2)}
  ¿Caro? ${precioTotal > 100 ? "Sí" : "No"}
╚══════════════════════════════╝''';

  print(recibo);

  // Interpolación anidada: expresión que devuelve un string interpolado
  String bienvenida(String n, int p) => 'Hola $n, tienes $p puntos';
  print('Mensaje: ${bienvenida(usuario, puntos)}');
}

// EXPERIMENTA:
//   - Crea una clase Persona con nombre y apellido, úsala en un template multilínea
//   - Usa ${lista.map((e) => e.toUpperCase()).join(' | ')} para transformar listas
//   - Prueba interpolar un Map: ${'clave': 'valor'} — ¿qué pasa?
//   - Mide el tiempo de 10,000 concatenaciones con + vs interpolación
