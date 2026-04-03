// =============================================================================
// ARCHIVO: 03_retorno.dart
// TEMA: Valores de retorno en Dart — return, Records y funciones que retornan funciones
// =============================================================================
//
// En Dart toda función devuelve un valor. Si no tiene "return", devuelve null.
// Dart 3 introdujo Records: una forma de retornar múltiples valores sin
// necesidad de crear una clase — equivalente a las tuplas de Python.
//
// CÓMO EJECUTAR:
//   dart run 03_retorno.dart
//
// =============================================================================

void main() {
  // ─────────────────────────────────────────────────────────────────────────
  // RETURN BÁSICO
  // ─────────────────────────────────────────────────────────────────────────

  print('--- return básico ---');

  int cuadrado = elevarAlCuadrado(5);
  print('5² = $cuadrado');

  String mayus = convertirMayusculas('flutter');
  print('En mayúsculas: $mayus');

  // return también puede usarse para salir temprano de una función:
  String resultado = verificarEdad(15);
  print(resultado);

  // ─────────────────────────────────────────────────────────────────────────
  // RETORNAR NULL — Cuando el resultado puede no existir
  // ─────────────────────────────────────────────────────────────────────────

  print('\n--- Retornar null ---');

  // El tipo String? significa que puede devolver String o null.
  String? busqueda = buscarEnLista(['Dart', 'Flutter', 'Python'], 'Flutter');
  print('Búsqueda "Flutter": $busqueda');

  String? noEncontrado = buscarEnLista(['Dart', 'Flutter'], 'Kotlin');
  print('Búsqueda "Kotlin": $noEncontrado');

  // Siempre maneja el posible null al usar la función:
  String texto = busqueda ?? 'No encontrado';
  print('Resultado procesado: $texto');

  // ─────────────────────────────────────────────────────────────────────────
  // RECORDS (DART 3) — Retornar múltiples valores como tupla
  // ─────────────────────────────────────────────────────────────────────────

  // Los Records permiten agrupar múltiples valores sin crear una clase.
  // Son inmutables, se comparan por valor, y pueden tener campos nombrados.
  // Equivalente directo a las tuplas de Python.
  print('\n--- Records (tuplas de Dart 3) ---');

  // Record anónimo: (tipo1, tipo2)
  var punto = obtenerPunto();
  print('Punto: x=${punto.$1}, y=${punto.$2}');  // $1 y $2 son los índices

  // Record con campos nombrados: ({nombre tipo1, nombre tipo2})
  var usuario = obtenerUsuario();
  print('Usuario: ${usuario.nombre}, ${usuario.edad} años');

  // Destructuring de Records:
  var (x, y) = obtenerPunto();          // Extraer en variables
  print('x=$x, y=$y');

  var (:nombre, :edad) = obtenerUsuario();  // Extraer campos nombrados
  print('nombre=$nombre, edad=$edad');

  // Caso práctico: función que devuelve resultado y posible error
  var (valor, error) = dividirSeguro(10, 2);
  if (error != null) {
    print('Error: $error');
  } else {
    print('10 / 2 = $valor');
  }

  var (valor2, error2) = dividirSeguro(10, 0);
  if (error2 != null) {
    print('Error: $error2');
  } else {
    print('Resultado: $valor2');
  }

  // ─────────────────────────────────────────────────────────────────────────
  // FUNCIONES QUE RETORNAN FUNCIONES
  // ─────────────────────────────────────────────────────────────────────────

  // En Dart las funciones son ciudadanos de primera clase: pueden ser
  // asignadas a variables, pasadas como parámetros y retornadas por funciones.
  print('\n--- Funciones que retornan funciones ---');

  // multiplicador() devuelve una función, no un número:
  var triplicar = crearMultiplicador(3);
  var quintuplicar = crearMultiplicador(5);

  print('triplicar(4) = ${triplicar(4)}');    // 12
  print('quintuplicar(4) = ${quintuplicar(4)}');  // 20

  // También se puede usar directamente sin guardar en variable:
  print('Doble de 7: ${crearMultiplicador(2)(7)}');  // 14
}

/// Eleva un número al cuadrado.
int elevarAlCuadrado(int n) {
  return n * n;
}

/// Convierte un texto a mayúsculas.
String convertirMayusculas(String texto) {
  return texto.toUpperCase();
}

/// Verifica si una edad permite acceso.
/// Usa return temprano para casos inválidos — patrón "guard clause".
String verificarEdad(int edad) {
  if (edad < 0) return 'Edad inválida';
  if (edad < 18) return 'Acceso denegado (menores de edad)';
  return 'Acceso permitido';
}

/// Busca un elemento en una lista. Retorna null si no lo encuentra.
String? buscarEnLista(List<String> lista, String elemento) {
  for (var item in lista) {
    if (item == elemento) return item;
  }
  return null; // No encontrado
}

/// Devuelve un punto 2D como Record anónimo.
(double, double) obtenerPunto() {
  return (3.5, 7.2);
}

/// Devuelve datos de usuario como Record con campos nombrados.
({String nombre, int edad}) obtenerUsuario() {
  return (nombre: 'María', edad: 26);
}

/// Divide dos números de forma segura.
/// Retorna (resultado, null) si tiene éxito, o (null, mensajeError) si falla.
(double?, String?) dividirSeguro(double a, double b) {
  if (b == 0) return (null, 'División por cero no permitida');
  return (a / b, null);
}

/// Crea y retorna una función multiplicadora con el factor dado.
/// Este patrón se llama "función de orden superior" (higher-order function).
///
/// Parámetros:
/// - [factor]: El número por el que se multiplicará.
///
/// Retorna una función que toma un int y devuelve int.
int Function(int) crearMultiplicador(int factor) {
  // La función retornada "recuerda" el valor de factor (closure).
  return (int numero) => numero * factor;
}

// =============================================================================
// EXPERIMENTA:
//   1. Crea una función que retorne un Record con estadísticas de una lista:
//      (min, max, promedio, total) — todos como double.
//   2. Usa Records para retornar el resultado de parsear una fecha:
//      parseDate('2025-04-02') → (anio: 2025, mes: 4, dia: 2)
//   3. Crea una función "crearSaludo(String idioma)" que devuelva una función
//      que salude en ese idioma: crearSaludo('es')('Ana') → '¡Hola, Ana!'
//   4. ¿Qué devuelve una función void en Dart? Asigna el retorno de una
//      función void a una variable y verifica con runtimeType.
//   5. Crea una función que retorne otra función que recuerde cuántas veces
//      ha sido llamada (closure con estado acumulado).
// =============================================================================
