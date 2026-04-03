// =============================================================================
// ARCHIVO: 01_try_catch.dart
// TEMA: try/catch/finally y manejo de excepciones en Dart
// =============================================================================
//
// Dart usa excepciones para señalar condiciones de error recuperables.
// El bloque try/catch permite interceptarlas y decidir cómo responder.
// 'finally' garantiza limpieza de recursos. 'rethrow' permite re-lanzar
// una excepción después de registrarla o enriquecerla.
//
// CÓMO EJECUTAR:
//   dart run 01_try_catch.dart
//
// =============================================================================

// ────────────────────────────────────────────────────────────────────────────
// 1. try/catch BÁSICO
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra el try/catch básico con un error de parsing.
void demoTryCatchBasico() {
  print('── try/catch básico ──');

  // Intento de parsear un string no numérico
  try {
    int numero = int.parse('no_es_numero');
    print('Número: $numero'); // Nunca llega aquí
  } catch (e) {
    // 'e' es el objeto de la excepción
    print('Error atrapado: $e');
    print('Tipo: ${e.runtimeType}'); // FormatException
  }

  // La ejecución continúa después del catch — el programa NO termina
  print('El programa continúa normalmente.');
}

// ────────────────────────────────────────────────────────────────────────────
// 2. on TIPO catch — Atrapar tipos específicos
// ────────────────────────────────────────────────────────────────────────────

/// Simula diferentes tipos de errores que pueden ocurrir al procesar datos.
void procesarDato(String entrada) {
  print('\nProcesando: "$entrada"');
  try {
    // Paso 1: parsear como número
    double numero = double.parse(entrada);

    // Paso 2: verificar que sea positivo
    if (numero < 0) {
      throw ArgumentError('El número no puede ser negativo: $numero');
    }

    // Paso 3: calcular raíz cuadrada
    double raiz = _calcularRaiz(numero);
    print('√$numero = ${raiz.toStringAsFixed(4)}');

  } on FormatException catch (e) {
    // Solo se ejecuta si se lanza FormatException
    print('Error de formato: "${e.source}" no es un número válido.');
  } on ArgumentError catch (e) {
    // Solo se ejecuta si se lanza ArgumentError
    print('Argumento inválido: ${e.message}');
  } catch (e, stackTrace) {
    // Captura CUALQUIER otra excepción no manejada arriba
    print('Error inesperado: $e');
    print('Stack trace: ${stackTrace.toString().split('\n').first}');
  }
}

/// Calcula la raíz cuadrada usando el método de Newton-Raphson.
double _calcularRaiz(double n) {
  if (n == 0) return 0;
  double x = n;
  for (int i = 0; i < 100; i++) {
    x = (x + n / x) / 2;
  }
  return x;
}

// ────────────────────────────────────────────────────────────────────────────
// 3. finally — Siempre se ejecuta (limpieza de recursos)
// ────────────────────────────────────────────────────────────────────────────

/// Simula el ciclo de vida de un recurso que siempre debe cerrarse.
///
/// finally garantiza que el recurso se libera incluso si hay excepción.
void demoFinally() {
  print('\n── finally: limpieza garantizada ──');

  // Simulamos abrir un recurso (archivo, conexión, etc.)
  bool recursoAbierto = false;

  try {
    recursoAbierto = true;
    print('Recurso abierto.');

    // Simulamos un error en mitad del procesamiento
    throw Exception('Error durante el procesamiento');

    // Esta línea nunca se ejecuta
    // print('Procesamiento completado.');

  } catch (e) {
    print('Error capturado: $e');
    // Podríamos manejar el error aquí sin cerrar el recurso...
  } finally {
    // SIEMPRE se ejecuta — ya sea con éxito, error, o incluso return
    if (recursoAbierto) {
      recursoAbierto = false;
      print('finally: recurso cerrado correctamente.');
    }
  }

  // Demostrar que finally se ejecuta incluso con return
  print('\nfinally con return:');
  _funcionConReturn();
}

/// Función que retorna desde dentro del try — finally igual se ejecuta.
String _funcionConReturn() {
  try {
    print('  Dentro del try, a punto de retornar...');
    return 'valor_del_try';
  } finally {
    // Se ejecuta ANTES de que la función retorne efectivamente
    print('  finally: ejecutado antes del return');
  }
}

// ────────────────────────────────────────────────────────────────────────────
// 4. rethrow — Re-lanzar la excepción
// ────────────────────────────────────────────────────────────────────────────

/// Registra el error y lo re-lanza para que el llamador lo maneje.
///
/// rethrow es útil cuando quieres hacer algo (log, limpieza) pero no
/// quieres "consumir" la excepción — el llamador sigue siendo responsable.
void operacionConLog(String dato) {
  try {
    if (dato.isEmpty) {
      throw FormatException('El dato no puede estar vacío');
    }
    print('Operación exitosa con: $dato');
  } catch (e) {
    print('LOG: Error en operacionConLog: $e');
    rethrow; // Re-lanza la misma excepción con el mismo stack trace
  }
}

/// Demuestra rethrow en una cadena de llamadas.
void demoRethrow() {
  print('\n── rethrow ──');

  // La excepción se registra en operacionConLog y luego llega aquí
  try {
    operacionConLog('');
  } catch (e) {
    print('Excepción re-lanzada atrapada en el nivel superior: $e');
  }

  // Sin error — operación exitosa
  operacionConLog('datos_validos');
}

// ────────────────────────────────────────────────────────────────────────────
// 5. Exception vs Error — Cuándo NO atrapar
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra la diferencia entre Exception (recuperable) y Error (bug).
void demoExceptionVsError() {
  print('\n── Exception vs Error ──');

  // Exception: condición esperada, DEBE manejarse
  try {
    throw FormatException('Datos malformados del servidor');
  } on FormatException catch (e) {
    print('Exception (recuperable): $e');
    print('Acción: mostrar mensaje al usuario y pedir reintento.');
  }

  // Error: bug del programador, generalmente NO debería atrapars
  // Atrapar un Error enmascara bugs. Solo hazlo en el nivel más alto
  // de la aplicación para logging, antes de terminar limpiamente.
  try {
    List<int> lista = [1, 2, 3];
    print(lista[10]); // RangeError — índice inválido
  } on RangeError catch (e) {
    // Estamos atrapando esto solo para demostrarlo — en código real,
    // lo correcto es FIX el bug que causa el acceso inválido.
    print('Error (bug): $e');
    print('Acción: corregir el código, no atrapar el error.');
  }
}

// ────────────────────────────────────────────────────────────────────────────
// 6. Cuándo NO usar try/catch
// ────────────────────────────────────────────────────────────────────────────

/// Demuestra el antipatrón de usar excepciones para control de flujo.
void demoAntiPatron() {
  print('\n── Antipatrón vs buena práctica ──');

  String entrada = 'abc';

  // ANTIPATRÓN: usar excepciones para lógica normal
  // try {
  //   int n = int.parse(entrada);
  //   print('Es número: $n');
  // } catch (e) {
  //   print('No es número');
  // }

  // BUENA PRÁCTICA: usar métodos de validación (int.tryParse devuelve null)
  int? numero = int.tryParse(entrada);
  if (numero != null) {
    print('Es número: $numero');
  } else {
    print('No es número: usa tryParse en lugar de try/catch para validación.');
  }

  // Otro ejemplo: double.tryParse
  String precio = '19.99';
  double? precioDouble = double.tryParse(precio);
  print('Precio parseado: ${precioDouble ?? "inválido"}');
}

void main() {
  demoTryCatchBasico();

  print('\n── on TIPO catch: múltiples excepciones ──');
  procesarDato('25.0');     // Éxito
  procesarDato('-5.0');     // ArgumentError
  procesarDato('hola');     // FormatException

  demoFinally();
  demoRethrow();
  demoExceptionVsError();
  demoAntiPatron();
}

// EXPERIMENTA:
//   - Escribe una función que lea un Map y lance KeyError si la clave no existe
//   - Implementa un parse de fecha que lance FormatException descriptiva
//   - Prueba qué pasa si lanzas dentro de finally — ¿qué excepción prevalece?
//   - Mide el rendimiento: 1000 try/catch vs 1000 if/else para validación simple
